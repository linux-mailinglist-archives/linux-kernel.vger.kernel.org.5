Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6478793DE7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240744AbjIFNmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 09:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjIFNml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:42:41 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59A6CF1;
        Wed,  6 Sep 2023 06:42:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrD6zVkddR5fdQuz0PqQQfZOIkMtAT1KMmDvhfkAXhG+rVsb1ib9HoImI9P0cGQVPO59ETkLWduE0HLhbuO92R/dfGZzuO1l4uQWImWL2nSgIKTM7RytORWWEVQ0ZDVx/w0pBDpGUET3Q+RwmPCZ5BaermvGcCkpiNOQsnva5hNgKlk069Dqm1EtON322sWq/tneUvYzcg62Uqv1B0dR9dbFE9WlW8g3apwNjzjHVHkxj/fHngfYx+u5DgEdVA1mtsSZlsCE3h+5p+AMtRbCDr3uR0Mem9K+/sszKGf6J1fcBFnFC8+wsL7t1h8wet9lvDKkBfneKMXq8co3Ej2/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eadZXOi/9Bd3WBI4Vl32/ojVu/fOaoz4i6bcWKDnh/s=;
 b=dG0ZJ9LL3HDZVLWYt000PyNFTLeRMlG+u9PkA4jW3umV8/oWI/aq8xpZUwA+BldDjc8oOKhZKwXVBwNobQ/+2h+E90WACs6vMbwjorl5qVHUws3FRn80mOvK+ie0ybp2ir7miNsdx3btUS8nkVuIOumOLg2tzQxntu03ayCd8ZDruzci6dMFjTMJ3xhxMHBKJV4WM92ktWA+g/yJEO/2uakm+IGQ1wb+VwpvqmEYaF5SJ+9n53dpRxVLk75d/WpmIfg75iH1+V8UY0uhQu/79kWHgKYdYenhb5+os9VW89KUQQJPW6eaMvkSYV9xx/LXMOMqZYdxcf5RlsGNr/3nsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eadZXOi/9Bd3WBI4Vl32/ojVu/fOaoz4i6bcWKDnh/s=;
 b=FLKLkyBgbSpHhY7WBge2KdCoy1BOvi1CwVAXmhgiw9Ns6I/yGKxt4oDtIOeYexU2vMckmvlZn33RmwJWw+VaKtmLioAatZEtj/MGKdU4/96a6hrX+xkDl0oyo66rOXFvc/ycVO/BgfCBUPVu7PiQYzTzioWj7pnYfFVB7QAVa0Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DM6PR12MB4863.namprd12.prod.outlook.com (2603:10b6:5:1b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 13:42:34 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::1352:c7fd:4b4b:cc18]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::1352:c7fd:4b4b:cc18%7]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 13:42:34 +0000
Message-ID: <4a25cfe8-39d7-1d0f-b89b-2d62bdb085c1@amd.com>
Date:   Wed, 6 Sep 2023 08:42:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4] docs: security: Confidential computing intro and
 threat model for x86 virtualization
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
Content-Language: en-US
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <2023090537-undesired-junction-b325@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0077.namprd04.prod.outlook.com
 (2603:10b6:806:121::22) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DM6PR12MB4863:EE_
X-MS-Office365-Filtering-Correlation-Id: 155af405-94c6-4455-0df3-08dbaedf1fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pbtg6m0gjgYlvEWoeTyHy18thch/CZo4ZNHhADDR95mqDU6R28N2Cbc9jSVxghL6vbcP/oD1Lnh+HUhXc+OuSsL1iEn66J9LvUKhRJgM4bqXxxwR0hTZkV6HkEmWrbSeWyS9tx2Bc47BgDYAW0Ef9joXUS5h8Ro3TG9plLwgWZqsnYk5gcR2gRzYOHU5l5vAd8IuKGS1RFw/bpi4moRsRHqbdjirlRJ1xt8INM54in1shamOXxLoJ04K33Hw+Y/58Tq1uqmVCVBQBjJxqyvgGh5AF2aUdyV812B88Ie7EznVI+RN4wbXgiZ8HFDIyTOKk/UcRvE4/KpZfRdD3BqoVABHBgRKP42NSU8NnlE+3MapIEArz2zPBhhfZl5bTTNPmXsbIaDxmSU+Ku2GAdh4EI+DnuB0jGPJAHGZPwstt2Y+qFGeEnrmDYBDmNw9W7islr6VdNedUXEHJiW77BW2rk8j8HjWwJh6A33l5YJHm+19fqJ8k9Xp24NByDPiWJDSVd/o5I5lm8BreVY7IlrTag5c+PZhmq6kAV3FpP9180297XrHDyXfPEgYbxp0xpDMxeUr3H50WWdwr3FjqSEBRNk6Ck9Kofqsts+xn/V9rMjR05/iQ/ANeSqAZIL3JvoAOsV/Kwpjm4yIBBccTth/OA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(396003)(346002)(451199024)(186009)(1800799009)(53546011)(6486002)(6506007)(6666004)(6512007)(478600001)(83380400001)(2616005)(30864003)(15650500001)(2906002)(26005)(7406005)(7416002)(316002)(44832011)(6916009)(66556008)(66946007)(66476007)(41300700001)(5660300002)(8936002)(8676002)(4326008)(31696002)(86362001)(36756003)(38100700002)(31686004)(66899024)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmtFMC9GNU15V1lVemNVYXFNblpVL1BmUGNyWklyb3JGZEFvUyt1cHFqVmIz?=
 =?utf-8?B?TzhBelpoVWM0YjJXYWtKVU8vaW5jaVVqaUFXQXEzeFJvK2tsNVZCYlhLMkNN?=
 =?utf-8?B?Qyt3MkJ2M01UM2hPWDV6V0pYK0NLUk9oNElHaTlLUSsrUmY3WFNVeWJOT1Bs?=
 =?utf-8?B?M1hEeGNMT0FEa3NEdGtWZHl4ZHEzVnFZMCtiT3BIYjdqU0krM0J4U3o5dHhO?=
 =?utf-8?B?bmRzNExPNHpYNno5UFNhSHY0QWJiTVFFbTNXdUpaM3phSGYzQ2l4RnU3Vk5F?=
 =?utf-8?B?OFBpc3Q3Y0VHNkhGSFlXUG4wbkhTTHN5TWs2dk5ybS9YcllhSDRKWThWMUQ0?=
 =?utf-8?B?N2dxMDJHcFpJR21yRG5mbXdBZmkwOEdOL0ZmWDFYaWFSUDl1YzdWbHg4QXJw?=
 =?utf-8?B?azIrQnBZK2kwQUJPWG1WbEhjK2xYclRHNGJ1eGthMDJ2UHQydFhlQ2grM1U0?=
 =?utf-8?B?QWorSFU1TTVpSkRMVmQ1RVNIK1ZvNUREUDBTNFN5TUs0b2RZWVNQWFZ4RVAy?=
 =?utf-8?B?U1VzNjdpMlVqOGI1SkVUTDNsQkJrN2E2RlVkdEVyWFlmNjdDalNHa3ZOSkdw?=
 =?utf-8?B?V0M4S2h5R00rTk9ibnAvTnJsTFA0NUp2d1ozbmN5UzI2MHZ5aVNXdG80UWs1?=
 =?utf-8?B?NzdvZ05RZmFYVEc3ZkNqWUhEN3FMNTdUaWpjMFRtblpJa0FYMS9zYUY1WklI?=
 =?utf-8?B?akZMK09aRGdkK2dnZTlVZlQvN05pRnJWWk0zaENWTVBpMzNXNS9LaTFoWDg3?=
 =?utf-8?B?Q0lsZ3k0bkNFQkJ5ZWhzWU5HMUlBR0d5VmF4WGpSbFhUOUdSc3dBa2xoSWFT?=
 =?utf-8?B?RkN5NTB1YnJQUElCU2NWY2F3Q0VwU0JUZWpuZnJuWjBuTmF5cnFkV05Tajg0?=
 =?utf-8?B?TjJycVVwWFd5ZngwQTI3anRzaE9MWGxVVjdHMjUvR3FFakZIY3k3T0JPS1BU?=
 =?utf-8?B?MFJFR09CaUlUdVY0VkVCRFhPMW5teGxKS3IzRXg0N0JPdDY2Smd1UUY1ZHFZ?=
 =?utf-8?B?QzBYMG5EdFJGQXMyUTJCL01jVm1sSGh0OWJWdlcxWms4QU5tN051VDlWUGpP?=
 =?utf-8?B?WUZmZEZhbzVNb3lkQ1JNQU40MldxM3FDLzkzaHViMTFmTUxxdUZOWGozRTFN?=
 =?utf-8?B?RGcwUjdUMGlxQnBMVVVSZFp2THhNLzFYTjJKYTlnQUx6SGtRaXBUQlcyUm9M?=
 =?utf-8?B?dklwc0tQN0xyY0txSlVzZE1VdlpQdnJINU5uR1hnTStpcVBKVmxneUREK05p?=
 =?utf-8?B?emViWVhNelBiQjFpaFk0cEVtcGtIZGxTMk9jTFVRcEtpSDEzL1dscVdNWEky?=
 =?utf-8?B?Si9xM0RIeG9LbXE0YWlUVU5PVmluandCeWxMYmxGN1d0d1ZJRER1TzJIK3BV?=
 =?utf-8?B?MWdwdWhYTk9MNkM5b3hFc1JZUmQ2VUxzNHJvbWRVQjExbis4VllTRUIrQ0NE?=
 =?utf-8?B?cWp5R21jTjNRTHFRVzh0MEs0U1VZZUs5WkFRMHNTZjhQblhQZHIvTXkxSGRj?=
 =?utf-8?B?MFZTL1hrTG8rTHY1KzNwY3FNS0h0WHBWSlJLMEZGTmVhNUdpUlNINlkrSXg2?=
 =?utf-8?B?bmIyT3FJUG9TSlJaZ0x3eDZpNm11WjluZGh1b2JZTXJreGRFWWJVLzh6MUlv?=
 =?utf-8?B?bjNPekdsbG5sYk1IUFBHemQ2dWVNeVhBYjlaV2g5SWtlZDhDb3dDeEMvTkQ1?=
 =?utf-8?B?NmV6SWMzdmI4czVPSGcxajRpN3VDbjNXRVFBVlFKQTNTZG16WHcwSHBYbDRO?=
 =?utf-8?B?QnMyK2o3bk1jcHNmaVUxWWhDbnFSbXVkVkhMMGtsLzZ4ZWR2VEFTdXFWajhx?=
 =?utf-8?B?VVRvMEY1c25FN1pId0hlNnB0RFRCYWFKajBqUTJrSWpYTUczTlR0SVZOV3NY?=
 =?utf-8?B?S2NBeHE5dXdzZXkrbGIyS3Mxcmc3ZXpFcU9DclN6cG1KejFNdGlMVHZ1WmNH?=
 =?utf-8?B?N2wyN3lSU3ZueHpDWis0RFppaEp0aUdzaUd3Z25uQWdDQU51bkVDS1ZBZEdS?=
 =?utf-8?B?MW12c2NjaDZiVFI4OGw4SVB0bmJSMlhKRWN1VnhpZS8zbEtMTEdwM0k0N2pG?=
 =?utf-8?B?T3B4a2k4Y0UvWVh3NjIzbjNSV2F6S2VnaGM1R1RxUGVaTnpONXZleVZpVkpW?=
 =?utf-8?Q?UHTFuk+N828wfvRDousqqlLtc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 155af405-94c6-4455-0df3-08dbaedf1fd3
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 13:42:33.9623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +DuLAI2ejbQR+40eMjqIZfQt/Z95JoDtQzYMNFUASxExA5aqfnmE/nEt0vCY3GWIf+wEYJ8fwfD02NCFCMH/SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4863
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/23 10:49, Greg KH wrote:
> On Tue, Sep 05, 2023 at 10:26:56AM -0500, Carlos Bilbao wrote:
>> +In the following diagram, the "<--->" lines represent bi-directional
>> +communication channels or interfaces between the CoCo security manager and
>> +the rest of the components (data flow for guest, host, hardware) ::
>> +
>> +    +-------------------+      +-----------------------+
>> +    | CoCo guest VM     |<---->|                       |
>> +    +-------------------+      |                       |
>> +      | Interfaces |           | CoCo security manager |
>> +    +-------------------+      |                       |
>> +    | Host VMM          |<---->|                       |
>> +    +-------------------+      |                       |
>> +                               |                       |
>> +    +--------------------+     |                       |
>> +    | CoCo platform      |<--->|                       |
>> +    +--------------------+     +-----------------------+
> 
> I don't understand what "| Interfaces |" means here.  There is, or is
> not, a communication channel between the CoC guest VM and the Host VMM?
> 
> What does "interface" mean?

Explained below :)

> 
>> +
>> +The specific details of the CoCo security manager vastly diverge between
>> +technologies. For example, in some cases, it will be implemented in HW
>> +while in others it may be pure SW.
>> +
>> +Existing Linux kernel threat model
>> +==================================
>> +
>> +The overall components of the current Linux kernel threat model are::
>> +
>> +     +-----------------------+      +-------------------+
>> +     |                       |<---->| Userspace         |
>> +     |                       |      +-------------------+
>> +     |   External attack     |         | Interfaces |
>> +     |       vectors         |      +-------------------+
>> +     |                       |<---->| Linux Kernel      |
>> +     |                       |      +-------------------+
>> +     +-----------------------+      +-------------------+
>> +                                    | Bootloader/BIOS   |
>> +                                    +-------------------+
>> +                                    +-------------------+
>> +                                    | HW platform       |
>> +                                    +-------------------+
> 
> 
> Same here, what does "Interfaces" mean?
> 
> And external attack vectors can't get to the kernel without going
> through userspace (or the HW platform), right?
> 
>> +There is also communication between the bootloader and the kernel during
>> +the boot process, but this diagram does not represent it explicitly. The
>> +"Interfaces" box represents the various interfaces that allow
>> +communication between kernel and userspace. This includes system calls,
>> +kernel APIs, device drivers, etc.
> 
> Ah, you define that here now.
> 
> But the kernel talks to the Bootloader/BIOS after things are up and
> running all the time.

That's true. Here's some alternatives you might like more:

(a)

+-----------------------+      +-------------------+
|                       |<---->| Userspace         |
|                       |      +-------------------+
|   External attack     |         | Interfaces |
|       vectors         |      +-------------------+
|                       |<---->| Linux Kernel      |
|                       |      +-------------------+
|                       |         | Interfaces |
|                       |      +-------------------+
|                       |<---->| Bootloader/BIOS   |
|                       |      +-------------------+
|                       |         | Interfaces |
|                       |      +-------------------+
|                       |<---->| HW platform       |
|                       |      +-------------------+
+-----------------------+

(b)



                +-------------------+
       ┌─────── | Userspace         |
       │        +-------------------+
       │           | Interfaces |
                +-------------------+
External   ─── | Linux Kernel      |
attack         +-------------------+
vectors           | Interfaces |
   │  │         +-------------------+
   │  └─────────| Bootloader/BIOS   |
   │            +-------------------+
   │               | Interfaces |
   │            +-------------------+
   └────────────| HW platform       |
                +-------------------+


(c)

┌─────────────────┐
│                 │
│   Userspace     ├─────────┐
│                 │         │
├──────▲───────▲──┤         │
├──▼───────▼──────┤         │
│   Linux kernel  │         │
│                 ├───── External
├──▲──────▲───────┤      attack
├─────▼───────▼───┤      vectors
│   Bootloader/   │       │   │
│   BIOS          ├───────┘   │
├───────▲─────▲───┤           │
├───▼───────▼─────┤           │
│                 │           │
│   HW Platform   │           │
│                 ├───────────┘
└─────────────────┘

┌─▲─┐
└───┘ Interfaces

> 
> Same goes with the HW platform, the kernel talks to it too.
> 
>> +The existing Linux kernel threat model typically assumes execution on a
>> +trusted HW platform with all of the firmware and bootloaders included on
>> +its TCB. The primary attacker resides in the userspace, and all of the data
>> +coming from there is generally considered untrusted, unless userspace is
>> +privileged enough to perform trusted actions. In addition, external
>> +attackers are typically considered, including those with access to enabled
>> +external networks (e.g. Ethernet, Wireless, Bluetooth), exposed hardware
>> +interfaces (e.g. USB, Thunderbolt), and the ability to modify the contents
>> +of disks offline.
> 
> Ok, but again, your diagram is odd, the text seems correct though.

My hope is that everyone can understand the updated diagram we pick with
the explanation of what Interfaces means in this context.

> 
>> +Regarding external attack vectors, it is interesting to note that in most
>> +cases external attackers will try to exploit vulnerabilities in userspace
>> +first, but that it is possible for an attacker to directly target the
>> +kernel; particularly if the host has physical access. Examples of direct
>> +kernel attacks include the vulnerabilities CVE-2019-19524, CVE-2022-0435
>> +and CVE-2020-24490.
>> +
>> +Confidential Computing threat model and its security objectives
>> +===============================================================
>> +
>> +Confidential Computing adds a new type of attacker to the above list: a
>> +potentially misbehaving host (which can also include some part of a
>> +traditional VMM or all of it), which is typically placed outside of the
>> +CoCo VM TCB due to its large SW attack surface. It is important to note
>> +that this doesn’t imply that the host or VMM are intentionally
>> +malicious, but that there exists a security value in having a small CoCo
>> +VM TCB. This new type of adversary may be viewed as a more powerful type
>> +of external attacker, as it resides locally on the same physical machine
>> +(in contrast to a remote network attacker) and has control over the guest
>> +kernel communication with most of the HW::
>> +
>> +                                 +------------------------+
>> +                                 |    CoCo guest VM       |
>> +   +-----------------------+     |  +-------------------+ |
>> +   |                       |<--->|  | Userspace         | |
>> +   |                       |     |  +-------------------+ |
>> +   |   External attack     |     |     | Interfaces |     |
>> +   |       vectors         |     |  +-------------------+ |
>> +   |                       |<--->|  | Linux Kernel      | |
>> +   |                       |     |  +-------------------+ |
>> +   +-----------------------+     |  +-------------------+ |
>> +                                 |  | Bootloader/BIOS   | |
>> +   +-----------------------+     |  +-------------------+ |
>> +   |                       |<--->+------------------------+
>> +   |                       |          | Interfaces |
>> +   |                       |     +------------------------+
>> +   |     CoCo security     |<--->| Host/Host-side VMM |
>> +   |      manager          |     +------------------------+
>> +   |                       |     +------------------------+
>> +   |                       |<--->|   CoCo platform        |
>> +   +-----------------------+     +------------------------+
>> +
>> +While traditionally the host has unlimited access to guest data and can
>> +leverage this access to attack the guest, the CoCo systems mitigate such
>> +attacks by adding security features like guest data confidentiality and
>> +integrity protection. This threat model assumes that those features are
>> +available and intact.
>> +
>> +The **Linux kernel CoCo VM security objectives** can be summarized as follows:
>> +
>> +1. Preserve the confidentiality and integrity of CoCo guest's private
>> +memory and registers.
> 
> Preserve it from whom?

 From unauthorized access, I could update this sentence.

> 
>> +2. Prevent privileged escalation from a host into a CoCo guest Linux kernel.
>> +While it is true that the host (and host-side VMM) requires some level of
>> +privilege to create, destroy, or pause the guest, part of the goal of
>> +preventing privileged escalation is to ensure that these operations do not
>> +provide a pathway for attackers to gain access to the guest's kernel.
>> +
>> +The above security objectives result in two primary **Linux kernel CoCo
>> +VM assets**:
>> +
>> +1. Guest kernel execution context.
>> +2. Guest kernel private memory.
>> +
>> +The host retains full control over the CoCo guest resources, and can deny
>> +access to them at any time. Examples of resources include CPU time, memory
>> +that the guest can consume, network bandwidth, etc. Because of this, the
>> +host Denial of Service (DoS) attacks against CoCo guests are beyond the
>> +scope of this threat model.
>> +
>> +The **Linux CoCo VM attack surface** is any interface exposed from a CoCo
>> +guest Linux kernel towards an untrusted host that is not covered by the
>> +CoCo technology SW/HW protection. This includes any possible
>> +side-channels, as well as transient execution side channels. Examples of
>> +explicit (not side-channel) interfaces include accesses to port I/O, MMIO
>> +and DMA interfaces, access to PCI configuration space, VMM-specific
>> +hypercalls (towards Host-side VMM), access to shared memory pages,
>> +interrupts allowed to be injected into the guest kernel by the host, as
>> +well as CoCo technology-specific hypercalls, if present. Additionally, the
>> +host in a CoCo system typically controls the process of creating a CoCo
>> +guest: it has a method to load into a guest the firmware and bootloader
>> +images, the kernel image together with the kernel command line. All of this
>> +data should also be considered untrusted until its integrity and
>> +authenticity is established via attestation.
>> +
>> +The table below shows a threat matrix for the CoCo guest Linux kernel but
>> +does not discuss potential mitigation strategies. The matrix refers to
>> +CoCo-specific versions of the guest, host and platform.
>> +
>> +.. list-table:: CoCo Linux guest kernel threat matrix
>> +   :widths: auto
>> +   :align: center
>> +   :header-rows: 1
>> +
>> +   * - Threat name
>> +     - Threat description
>> +
>> +   * - Guest malicious configuration
>> +     - A misbehaving host modifies one of the following guest's
>> +       configuration:
>> +
>> +       1. Guest firmware or bootloader
>> +
>> +       2. Guest kernel or module binaries
>> +
>> +       3. Guest command line parameters
>> +
>> +       This allows the host to break the integrity of the code running
>> +       inside a CoCo guest, and violates the CoCo security objectives.
>> +
>> +   * - CoCo guest data attacks
>> +     - A misbehaving host retains full control of the CoCo guest's data
>> +       in-transit between the guest and the host-managed physical or
>> +       virtual devices. This allows any attack against confidentiality,
>> +       integrity or freshness of such data.
>> +
>> +   * - Malformed runtime input
>> +     - A misbehaving host injects malformed input via any communication
>> +       interface used by the guest's kernel code. If the code is not
>> +       prepared to handle this input correctly, this can result in a host
>> +       --> guest kernel privilege escalation. This includes traditional
>> +       side-channel and/or transient execution attack vectors.
> 
> ok, good luck with that!  side-channel attack vectors are going to be
> interesting for you to attempt to handle.
> 
> Anyway, you are setting yourself up to treat ALL data coming into any
> kernel interface as potentially malicious, right?  I welcome the patches
> to all of the drivers you are using to attempt to handle this properly,
> and to cover the performance impact that it is going to cause (check all
> the disk i/o packets!)  Good Luck!
> 
> greg k-h
> 

Thanks,
Carlos
