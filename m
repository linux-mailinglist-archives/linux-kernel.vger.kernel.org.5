Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B391379ADC6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345945AbjIKVWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239304AbjIKORN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:17:13 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F31DCF0;
        Mon, 11 Sep 2023 07:17:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBWc0akmWiVmlC9y7mXf1NZHWdmX3ZRyEmSZsfnlPCekmPVae7H04fqTWzbkm+FQ6Mud0M3vf3HaRIxLtX8L135yPKEBWsZ9U9GTsj2RBWvxGKdc+0xpoSH0QkgCEQY14L1LgRPI7xPXI6tUERVpVpXs9+RLTPEWBDoV/TXYMTyq9xtvLrFvuG2KEjBsyD6jvTd1mTsFSiKNtYfnJkOV0VCQdaw62UmWJX/75f7wUJw5+7sMldsLxwIepGSg6QyGOdxxx2FtF69BHujnfdaFzgduLBdflJaMtf/9r0AFHJJvpuCbdumwD9e35yatg+abq+91LPsDEorwDFiPuQB4KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/UfmlkljqNBsz6+ucE7oJrrvyp4VQP2gk83CXAS2XU=;
 b=nsmGlGkSHccqRshwuEdMJpJy2qKjQ+R/FhzCZtNd+r5nFcVtvFp6WFpCO/ygQYB1WlyJ4+JGhFJjtHBVr+ZYEx1jwrRTWXdlLuS7ltJpW+D9j0QRTLD9Q5eKIbCjm7uUWnQS9htKMjsH0VAMmLrPFh+T03JngBG7+VUrwn3ilrpMK6aRqBCupDHLJsYXDPWkB1QVh0g5m06NreeQ4Ry/WketlQQoWwa1+oMsYz9haYZDZEm5BJTEVeOEnMHzq1IoSyMgmu/m71r4FxCLkxAN1IVRusHPcaC5sj0L3is3wNAzLa+QYDDxJplCEk90DTO6p/BNC4fP0hK0k0Y+uMdyZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/UfmlkljqNBsz6+ucE7oJrrvyp4VQP2gk83CXAS2XU=;
 b=XS6scomqG9JqWGB5mB3ZWO5w2W1pg0wwCbKqWmzj0UqkkTFUnFwo6MGs9+uqCSGulGXXUm5yVHRnp57NrUuEZ4abQ8q8XbsrYT8pxg2Gkfts/UsMqHz5ATPFvezBmxq0ohx9r8r/FinWbrh7vx1VXLC1aN78PftuYYgEJgWRI+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by CY8PR12MB8065.namprd12.prod.outlook.com (2603:10b6:930:73::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Mon, 11 Sep
 2023 14:17:02 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9ac8:9ded:2dc2:afaf]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9ac8:9ded:2dc2:afaf%6]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 14:17:02 +0000
Message-ID: <bb5a6655-ebaa-2ddf-0c49-6f1027ccb839@amd.com>
Date:   Mon, 11 Sep 2023 09:16:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4] docs: security: Confidential computing intro and
 threat model for x86 virtualization
Content-Language: en-US
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ardb@kernel.org, kraxel@redhat.com,
        dovmurik@linux.ibm.com, elena.reshetova@intel.com,
        dave.hansen@linux.intel.com, Dhaval.Giani@amd.com,
        michael.day@amd.com, pavankumar.paluri@amd.com,
        David.Kaplan@amd.com, Reshma.Lal@amd.com, Jeremy.Powell@amd.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        alexander.shishkin@linux.intel.com, thomas.lendacky@amd.com,
        tglx@linutronix.de, dgilbert@redhat.com, dinechin@redhat.com,
        linux-coco@lists.linux.dev, berrange@redhat.com, mst@redhat.com,
        tytso@mit.edu, jikos@kernel.org, joro@8bytes.org, leon@kernel.org,
        richard.weinberger@gmail.com, lukas@wunner.de, jejb@linux.ibm.com,
        cdupontd@redhat.com, jasowang@redhat.com, sameo@rivosinc.com,
        bp@alien8.de, seanjc@google.com, security@kernel.org,
        Larry Dewey <larry.dewey@amd.com>
References: <20230905152656.1215119-1-carlos.bilbao@amd.com>
 <2023090537-undesired-junction-b325@gregkh>
 <4a25cfe8-39d7-1d0f-b89b-2d62bdb085c1@amd.com>
In-Reply-To: <4a25cfe8-39d7-1d0f-b89b-2d62bdb085c1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR16CA0066.namprd16.prod.outlook.com
 (2603:10b6:805:ca::43) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|CY8PR12MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: d2b14af9-e8ce-4852-b6b4-08dbb2d1c4b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fTvsvg/bqvdZsNOgEH7f3zBSQllqMFxSBvi/XcTMi+/8dhwnIrMV30D38wX6hBtyDDGQiaG7b+MUHdp2EQidfLg+p6TKDls5rfMExb6I15qt6C1gLfJBvPXRnAbFqlYiFspDV3uagFtmjeURaAMnYdM2LoxVsnO35igHnV9WvWQ5KHAPnMSqDev8xLXPaYUh2/TIT/HiD4ZNVf7Ig8rfa1q1Mm8CYj4f3MEOl79QhDzSkpyO5NdSsIhCQ8NOgmeJpspGSWIkzmK7hoTlKomIq6USfhM6e+lowbSoeaPqCcN3gJ1LofJlBOB/zKsvXc2hZNBp8AyeSr68NuXrzMNlzSE+MlgZS6dSvhigVVXbO6jWiez9b+9+adSx+lvj8Jsa6PAbrOEeCPd9mWuG5cAoBHGe/qt2+yUHjlKeUhdO6qJyV432Z3+v7ZHRySSDgJSOHTuiVJ3ZyKHB+5MVDvDmdyWaLHOzCuiHfibi8ghI4ln00pq1MHvGi043kOe8yvuSPh3HeaC9kLRILrnP2afbfbYz6NpHZb/S23NaOnkOZzU35oAX2evhaaIPAjznzZQYWRBrOasIEAuIBpiQj+jWEbI43YZwINsUc90yXR6Cui6F5OS0vTCwrtESTKeIKVukm/x1wwHyt6NGiTBnqDmpBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39860400002)(376002)(186009)(1800799009)(451199024)(15650500001)(6486002)(6506007)(6666004)(53546011)(83380400001)(6512007)(41300700001)(478600001)(26005)(2616005)(2906002)(30864003)(7416002)(66476007)(44832011)(66556008)(316002)(6916009)(4326008)(5660300002)(8676002)(7406005)(8936002)(66946007)(86362001)(36756003)(31696002)(38100700002)(31686004)(66899024)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UG5LQVM2bkw3YTFYcGJpMDVTekxURzRSUEpqdW9US1QrZGtXV0lGbjBKVlI3?=
 =?utf-8?B?am5TaExKWjVNeC8vV2luQnc4M0pMMFRkczRBN2tqUHVsMU9XSi9HOHAwc2pE?=
 =?utf-8?B?dGxHT2hrcENlR2ZDMmdIc01BN2RWdFFJSjV4akJMWGwzemYxQXV0L2FvbXdW?=
 =?utf-8?B?ZUF6SXlvSXIwdDYyTVZzZTgyaHdUYzJWU0kwNG1CL2VSekJQOTdEK0NYOTVX?=
 =?utf-8?B?SlpGWHJmaS9iWnJTaXVnRUthY1FvNmNJSUhENGFNa0tGYmdMVk9OVHlwU05j?=
 =?utf-8?B?a2ZJQjZrbERWa0lUZE11blgxbW14TWxNcklLQnprN3E3U0ZBR09UQzQ1YnRZ?=
 =?utf-8?B?TnlGNkVkSVRrZCtadW5LYmdRSnVXVzUxMUM2SUhsNkE2K0s2RS80U1hjRnJ6?=
 =?utf-8?B?Qkxzd3lrc0ttZkpuMGZGejRTWkJ4RGs3NmdiR3VWUk4xWUQ2aU9RYjRkWnVC?=
 =?utf-8?B?OWlRQnRTWnBpZTFEUUxvcGJuejloRmEyT3Q3NTZZUW0vLzNUOHpaZk1ZUTlH?=
 =?utf-8?B?SXg0SG5FN1JJQjVXdmRLNTdQdS9GRDhNSzFlaWkyZGRVbGFWRnV2anM1eWli?=
 =?utf-8?B?NGRTS29kZldwSXhUYUtpQU1qTCtTK0xnZG1pUVgvMkhydURVNDhyWGJuejBG?=
 =?utf-8?B?TEMvZDhlcHpKV3puRlUxYXRYMVFDTlZnSGtiTmhUYUtLdXlDc0g2aTAyWUQz?=
 =?utf-8?B?VlZlMUR0MXRTZW9CemVTb2xrelhCd1oyMkZIYlI3eUFDcjdPYmlZNWNIak01?=
 =?utf-8?B?OVdEL2Y0UHdCREN0bEU3UC9JY2lJZFNaZUlyYmtKK3pPdE4rcVJMQThPaC9V?=
 =?utf-8?B?ZHhPSWZUdzN2OWtFejhUbDVSaDlvSXZLcUFKcUV4clZpRjNUdHdYTk4vL3Bq?=
 =?utf-8?B?enhDSVN1RzFhTXpBdzJIaUJEVkNNTDhPRWRsV1E4eXQwQUVHNlpzeHkrZ0pr?=
 =?utf-8?B?b09wSG05MVlaZHFIdGNBMWxhazArTm04NDNnVjh3RituQlp1N2FmU2JoWXdO?=
 =?utf-8?B?d2dzUW1WY053Zmpoc25BQTNVOUQzVnhvOVFPR0RHTy9SRHRreWVWdS9SZTFi?=
 =?utf-8?B?QnZxYmxHYmNBSW1oQ1d3aWhQL0ZWaE1CREFKa2c1eHlCUGxSbWhOMk9FdVpL?=
 =?utf-8?B?YStHdkRSRmpSOEV3TUhvVlZ2aHgwRmt5SlowRW1SNGRqTENZUjRnOTQzTTFE?=
 =?utf-8?B?a2tlS2xLYmVVV3hoSmJLQSs3R0RSN29sOTk1L3JGTVpQNVNVMkNadExVMDFW?=
 =?utf-8?B?RGtaU08zZ3pPUDBBeUdrSmRrd3NsWUplYXAxeEtoZU9qbmlyRzMvdksrOCs0?=
 =?utf-8?B?dklCOG1HR0M4ak5LalVUZlJJb3FKLzA5RmkyR3ROSDJjM1hYQTZ0Qy9pVDg2?=
 =?utf-8?B?TmkwNTgyT1NKb1hhcDRnMllHeU9ZTDAxMG5FSG9tT0F1UkJ6U2l2TmtYWjNn?=
 =?utf-8?B?c0xjaHZjNHNUejhUS2FXY1N5ZGFrRGJnRFdsZWdVWWxYWXR5aG00TFNHV0RW?=
 =?utf-8?B?Titnb3JrMVRDVDdqaFQ2bVllREF2TlVUVjZ2UkE5QWhJT3BabTFUYnI1RmRP?=
 =?utf-8?B?NFAvMGFOSnJjcC9UNi9mRHI3dmZlUzV6Nk9NRXlDT0lIYWFvNUM3RWVUb2c0?=
 =?utf-8?B?REs3RFpwKzQvSW02NVgzakowY0E0eGwvN2x3NldORDVxRUFGczdndzdZVzAz?=
 =?utf-8?B?eGo4dGN3Z0VPNlowT1A1TnpBeEsyeFc0N2ZkMWljWGoxajZjcUlBL2NkZEY4?=
 =?utf-8?B?UzlMRWhaeDc4dExOZ0hObWpRdkk4WEpvTVdYL0FveGlHb0VKbkp0UU1helZo?=
 =?utf-8?B?Rm5SMW8vNXVGSkVyM3lXRnF3US84MHYzWkxPMDNWRys1K1Z6dVN3SEhaVUc4?=
 =?utf-8?B?YXdCTyt2RG83ZDB2bHRyOGdUais1eUR0eVpZdDZZNE1ySlp4SFhRdGdpaGpZ?=
 =?utf-8?B?aGVUc0xKMWNZbjYxU3JnemluSzJ5L0YvSGRHVHVtcVVTTHE2WWtBaXdySUFW?=
 =?utf-8?B?b3ROUmhBQmNFcFNtZkQxRy9JU05YdUlKSEJPUG9VZnd5TE5LbTVaZjBDV0xu?=
 =?utf-8?B?cXhyOGdyQWt1elRQSTRwYkxSL2VBN083RFlJZzFYQWc3TEpFa015UlVTUCtU?=
 =?utf-8?Q?SzQTvF9lhXXx8NTepdEIa0mLn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b14af9-e8ce-4852-b6b4-08dbb2d1c4b7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 14:17:02.4491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HisjTWrHsEaLjWpznb8v80GwR651ta2b0p78+1Uj8F/W1eIp1EbSB95L0UEX+JEIsBjp2YBQUzrGSLDeefw1iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8065
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/23 08:42, Carlos Bilbao wrote:
> On 9/5/23 10:49, Greg KH wrote:
>> On Tue, Sep 05, 2023 at 10:26:56AM -0500, Carlos Bilbao wrote:
>>> +In the following diagram, the "<--->" lines represent bi-directional
>>> +communication channels or interfaces between the CoCo security manager and
>>> +the rest of the components (data flow for guest, host, hardware) ::
>>> +
>>> +    +-------------------+      +-----------------------+
>>> +    | CoCo guest VM     |<---->|                       |
>>> +    +-------------------+      |                       |
>>> +      | Interfaces |           | CoCo security manager |
>>> +    +-------------------+      |                       |
>>> +    | Host VMM          |<---->|                       |
>>> +    +-------------------+      |                       |
>>> +                               |                       |
>>> +    +--------------------+     |                       |
>>> +    | CoCo platform      |<--->|                       |
>>> +    +--------------------+     +-----------------------+
>>
>> I don't understand what "| Interfaces |" means here.  There is, or is
>> not, a communication channel between the CoC guest VM and the Host VMM?
>>
>> What does "interface" mean?
> 
> Explained below :)
> 
>>
>>> +
>>> +The specific details of the CoCo security manager vastly diverge between
>>> +technologies. For example, in some cases, it will be implemented in HW
>>> +while in others it may be pure SW.
>>> +
>>> +Existing Linux kernel threat model
>>> +==================================
>>> +
>>> +The overall components of the current Linux kernel threat model are::
>>> +
>>> +     +-----------------------+      +-------------------+
>>> +     |                       |<---->| Userspace         |
>>> +     |                       |      +-------------------+
>>> +     |   External attack     |         | Interfaces |
>>> +     |       vectors         |      +-------------------+
>>> +     |                       |<---->| Linux Kernel      |
>>> +     |                       |      +-------------------+
>>> +     +-----------------------+      +-------------------+
>>> +                                    | Bootloader/BIOS   |
>>> +                                    +-------------------+
>>> +                                    +-------------------+
>>> +                                    | HW platform       |
>>> +                                    +-------------------+
>>
>>
>> Same here, what does "Interfaces" mean?
>>
>> And external attack vectors can't get to the kernel without going
>> through userspace (or the HW platform), right?
>>
>>> +There is also communication between the bootloader and the kernel during
>>> +the boot process, but this diagram does not represent it explicitly. The
>>> +"Interfaces" box represents the various interfaces that allow
>>> +communication between kernel and userspace. This includes system calls,
>>> +kernel APIs, device drivers, etc.
>>
>> Ah, you define that here now.
>>
>> But the kernel talks to the Bootloader/BIOS after things are up and
>> running all the time.
> 
> That's true. Here's some alternatives you might like more:

If nobody has any strong opinions regarding this alternative diagrams, I'd
like to know if there are any objections left with the current threat
model.

> 
> (a)
> 
> +-----------------------+      +-------------------+
> |                       |<---->| Userspace         |
> |                       |      +-------------------+
> |   External attack     |         | Interfaces |
> |       vectors         |      +-------------------+
> |                       |<---->| Linux Kernel      |
> |                       |      +-------------------+
> |                       |         | Interfaces |
> |                       |      +-------------------+
> |                       |<---->| Bootloader/BIOS   |
> |                       |      +-------------------+
> |                       |         | Interfaces |
> |                       |      +-------------------+
> |                       |<---->| HW platform       |
> |                       |      +-------------------+
> +-----------------------+
> 
> (b)
> 
> 
> 
>                 +-------------------+
>        ┌─────── | Userspace         |
>        │        +-------------------+
>        │           | Interfaces |
>                 +-------------------+
> External   ─── | Linux Kernel      |
> attack         +-------------------+
> vectors           | Interfaces |
>    │  │         +-------------------+
>    │  └─────────| Bootloader/BIOS   |
>    │            +-------------------+
>    │               | Interfaces |
>    │            +-------------------+
>    └────────────| HW platform       |
>                 +-------------------+
> 
> 
> (c)
> 
> ┌─────────────────┐
> │                 │
> │   Userspace     ├─────────┐
> │                 │         │
> ├──────▲───────▲──┤         │
> ├──▼───────▼──────┤         │
> │   Linux kernel  │         │
> │                 ├───── External
> ├──▲──────▲───────┤      attack
> ├─────▼───────▼───┤      vectors
> │   Bootloader/   │       │   │
> │   BIOS          ├───────┘   │
> ├───────▲─────▲───┤           │
> ├───▼───────▼─────┤           │
> │                 │           │
> │   HW Platform   │           │
> │                 ├───────────┘
> └─────────────────┘
> 
> ┌─▲─┐
> └───┘ Interfaces
> 
>>
>> Same goes with the HW platform, the kernel talks to it too.
>>
>>> +The existing Linux kernel threat model typically assumes execution on a
>>> +trusted HW platform with all of the firmware and bootloaders included on
>>> +its TCB. The primary attacker resides in the userspace, and all of the 
>>> data
>>> +coming from there is generally considered untrusted, unless userspace is
>>> +privileged enough to perform trusted actions. In addition, external
>>> +attackers are typically considered, including those with access to enabled
>>> +external networks (e.g. Ethernet, Wireless, Bluetooth), exposed hardware
>>> +interfaces (e.g. USB, Thunderbolt), and the ability to modify the contents
>>> +of disks offline.
>>
>> Ok, but again, your diagram is odd, the text seems correct though.
> 
> My hope is that everyone can understand the updated diagram we pick with
> the explanation of what Interfaces means in this context.
> 
>>
>>> +Regarding external attack vectors, it is interesting to note that in most
>>> +cases external attackers will try to exploit vulnerabilities in userspace
>>> +first, but that it is possible for an attacker to directly target the
>>> +kernel; particularly if the host has physical access. Examples of direct
>>> +kernel attacks include the vulnerabilities CVE-2019-19524, CVE-2022-0435
>>> +and CVE-2020-24490.
>>> +
>>> +Confidential Computing threat model and its security objectives
>>> +===============================================================
>>> +
>>> +Confidential Computing adds a new type of attacker to the above list: a
>>> +potentially misbehaving host (which can also include some part of a
>>> +traditional VMM or all of it), which is typically placed outside of the
>>> +CoCo VM TCB due to its large SW attack surface. It is important to note
>>> +that this doesn’t imply that the host or VMM are intentionally
>>> +malicious, but that there exists a security value in having a small CoCo
>>> +VM TCB. This new type of adversary may be viewed as a more powerful type
>>> +of external attacker, as it resides locally on the same physical machine
>>> +(in contrast to a remote network attacker) and has control over the guest
>>> +kernel communication with most of the HW::
>>> +
>>> +                                 +------------------------+
>>> +                                 |    CoCo guest VM       |
>>> +   +-----------------------+     |  +-------------------+ |
>>> +   |                       |<--->|  | Userspace         | |
>>> +   |                       |     |  +-------------------+ |
>>> +   |   External attack     |     |     | Interfaces |     |
>>> +   |       vectors         |     |  +-------------------+ |
>>> +   |                       |<--->|  | Linux Kernel      | |
>>> +   |                       |     |  +-------------------+ |
>>> +   +-----------------------+     |  +-------------------+ |
>>> +                                 |  | Bootloader/BIOS   | |
>>> +   +-----------------------+     |  +-------------------+ |
>>> +   |                       |<--->+------------------------+
>>> +   |                       |          | Interfaces |
>>> +   |                       |     +------------------------+
>>> +   |     CoCo security     |<--->| Host/Host-side VMM |
>>> +   |      manager          |     +------------------------+
>>> +   |                       |     +------------------------+
>>> +   |                       |<--->|   CoCo platform        |
>>> +   +-----------------------+     +------------------------+
>>> +
>>> +While traditionally the host has unlimited access to guest data and can
>>> +leverage this access to attack the guest, the CoCo systems mitigate such
>>> +attacks by adding security features like guest data confidentiality and
>>> +integrity protection. This threat model assumes that those features are
>>> +available and intact.
>>> +
>>> +The **Linux kernel CoCo VM security objectives** can be summarized as 
>>> follows:
>>> +
>>> +1. Preserve the confidentiality and integrity of CoCo guest's private
>>> +memory and registers.
>>
>> Preserve it from whom?
> 
>  From unauthorized access, I could update this sentence.
> 
>>
>>> +2. Prevent privileged escalation from a host into a CoCo guest Linux 
>>> kernel.
>>> +While it is true that the host (and host-side VMM) requires some level of
>>> +privilege to create, destroy, or pause the guest, part of the goal of
>>> +preventing privileged escalation is to ensure that these operations do not
>>> +provide a pathway for attackers to gain access to the guest's kernel.
>>> +
>>> +The above security objectives result in two primary **Linux kernel CoCo
>>> +VM assets**:
>>> +
>>> +1. Guest kernel execution context.
>>> +2. Guest kernel private memory.
>>> +
>>> +The host retains full control over the CoCo guest resources, and can deny
>>> +access to them at any time. Examples of resources include CPU time, memory
>>> +that the guest can consume, network bandwidth, etc. Because of this, the
>>> +host Denial of Service (DoS) attacks against CoCo guests are beyond the
>>> +scope of this threat model.
>>> +
>>> +The **Linux CoCo VM attack surface** is any interface exposed from a CoCo
>>> +guest Linux kernel towards an untrusted host that is not covered by the
>>> +CoCo technology SW/HW protection. This includes any possible
>>> +side-channels, as well as transient execution side channels. Examples of
>>> +explicit (not side-channel) interfaces include accesses to port I/O, MMIO
>>> +and DMA interfaces, access to PCI configuration space, VMM-specific
>>> +hypercalls (towards Host-side VMM), access to shared memory pages,
>>> +interrupts allowed to be injected into the guest kernel by the host, as
>>> +well as CoCo technology-specific hypercalls, if present. Additionally, the
>>> +host in a CoCo system typically controls the process of creating a CoCo
>>> +guest: it has a method to load into a guest the firmware and bootloader
>>> +images, the kernel image together with the kernel command line. All of 
>>> this
>>> +data should also be considered untrusted until its integrity and
>>> +authenticity is established via attestation.
>>> +
>>> +The table below shows a threat matrix for the CoCo guest Linux kernel but
>>> +does not discuss potential mitigation strategies. The matrix refers to
>>> +CoCo-specific versions of the guest, host and platform.
>>> +
>>> +.. list-table:: CoCo Linux guest kernel threat matrix
>>> +   :widths: auto
>>> +   :align: center
>>> +   :header-rows: 1
>>> +
>>> +   * - Threat name
>>> +     - Threat description
>>> +
>>> +   * - Guest malicious configuration
>>> +     - A misbehaving host modifies one of the following guest's
>>> +       configuration:
>>> +
>>> +       1. Guest firmware or bootloader
>>> +
>>> +       2. Guest kernel or module binaries
>>> +
>>> +       3. Guest command line parameters
>>> +
>>> +       This allows the host to break the integrity of the code running
>>> +       inside a CoCo guest, and violates the CoCo security objectives.
>>> +
>>> +   * - CoCo guest data attacks
>>> +     - A misbehaving host retains full control of the CoCo guest's data
>>> +       in-transit between the guest and the host-managed physical or
>>> +       virtual devices. This allows any attack against confidentiality,
>>> +       integrity or freshness of such data.
>>> +
>>> +   * - Malformed runtime input
>>> +     - A misbehaving host injects malformed input via any communication
>>> +       interface used by the guest's kernel code. If the code is not
>>> +       prepared to handle this input correctly, this can result in a host
>>> +       --> guest kernel privilege escalation. This includes traditional
>>> +       side-channel and/or transient execution attack vectors.
>>
>> ok, good luck with that!  side-channel attack vectors are going to be
>> interesting for you to attempt to handle.
>>
>> Anyway, you are setting yourself up to treat ALL data coming into any
>> kernel interface as potentially malicious, right?  I welcome the patches
>> to all of the drivers you are using to attempt to handle this properly,
>> and to cover the performance impact that it is going to cause (check all
>> the disk i/o packets!)  Good Luck!
>>
>> greg k-h
>>
> 
> Thanks,
> Carlos
> 

Thanks,
Carlos
