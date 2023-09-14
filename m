Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739FF7A0719
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239903AbjINOS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239466AbjINOS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:18:56 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC52FD7;
        Thu, 14 Sep 2023 07:18:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrKbuxYcE4I1ALfdvXzMbZQYHlPV2TROn5ZGYNP6vB+FGI4jVL86rCONL9WV38KkFhjRGwIDrsFf4ixFX89Lku+n48lFqbNw44+3ic5KGEJfiY+jF+vdedGoBxeDpUf74aIZIYWvcFy6H66Dy1po0zpNK3Da2CkpOfcQ/XQNSapat2rMdUZy8kmtq5TtgckfSS0wr8X/dN0HeMHGUmoWWmC22HvTBDFrZEtdZqf4vZexZNGn1SZscex0uyKu1dZyYLHja/gwqVdUUdB9eOkBygIsKmU3i4T9QHVTdU/uD6pJwD5/g4Lu+DqA35GbqkakvKlmM38/hYP67LVY4i4RTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaHyL61rXY4V0Si14Sq/T3vZwYj/SM97RDZxR+OMKis=;
 b=nSSSkWzTDqknYy30dyef/hdpLa1DMxCKAnBZPPm9nKE7XP22j7lQ74AhYWIdknhZCXJ+TYK/W1G5iFXfVeWkz2P6NHKP3yI82fbkUQbfz+S0ItE6gjgjPk4Q/RyeGLcQQpbodUttLvLMdteX4c4Y1r/9ZlIeurSIsIEM95Kh/ZqKaZ+VRDB84/Pc1+St+XQ3EZ+HUppAWxm0X0N9tSzTo3wAgo61qxBHuBxq88Fpo4WEJ5/uWyCYv7mH9JZXHPguXp70ESEFU8CmVjbeMUJik6P3cdoXs/RLVHNG6HVbXDyFTNzGca47g7JsJYLOWhJCDH9lwYFG9X045cUO/LA4Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaHyL61rXY4V0Si14Sq/T3vZwYj/SM97RDZxR+OMKis=;
 b=NXyctiCLrhIAXOWq+FtfiVzeleg7N5+vq8C+85HBd6TI/MnAmy6wKf/ilbXmTFlNxIIV6zK2IJg9owVMGaMNLqn5DfTu2P9YK6sETrKdxDClnxp9rt2n+wds17UMhGHrwnegOh9Hd/w5NhbSdPUAppKDfZSy1NekUbkKWe17+8Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by SJ1PR12MB6313.namprd12.prod.outlook.com (2603:10b6:a03:458::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 14 Sep
 2023 14:18:47 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9ac8:9ded:2dc2:afaf]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9ac8:9ded:2dc2:afaf%6]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 14:18:47 +0000
Message-ID: <f7700d54-da02-3482-17c5-bbae36799fb5@amd.com>
Date:   Thu, 14 Sep 2023 09:18:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4] docs: security: Confidential computing intro and
 threat model for x86 virtualization
Content-Language: en-US
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     Jonathan Corbet <corbet@lwn.net>
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
        Larry Dewey <larry.dewey@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230905152656.1215119-1-carlos.bilbao@amd.com>
 <2023090537-undesired-junction-b325@gregkh>
 <4a25cfe8-39d7-1d0f-b89b-2d62bdb085c1@amd.com>
 <bb5a6655-ebaa-2ddf-0c49-6f1027ccb839@amd.com>
In-Reply-To: <bb5a6655-ebaa-2ddf-0c49-6f1027ccb839@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0145.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::30) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|SJ1PR12MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: 50297f12-7c54-4539-2739-08dbb52d8224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hxfEwn82qjypK9/EKTeRIoqWj2sYDwoht4e2c5EfVrSM7yoy8gpw4CmG2WQsxjknuIZ/ZUFWVVL4h6g1SBKiGv21RAPM+m216xxaFh5CnQnkydzOCnfrNfve0GoUO1iTXBaliEgLOpSjg8eu06TbgpMsEExGwTMjGBOVAR5tyH0yoQec8Ck96KVCAQdPdXv0ILwjesK3C/p+ZwRPv0v9f1QifObZl+67i1CJwwriHNcipnq0Hc3O6sbM0rKh0h7mow3dhbM9zufmzPXU8peswxiGD6rXFTgI0iDOdKrMdJHGMf82YFuCjnjxtZk+z5IPPKpmX8mnWU52TB3AoyvPpuEe8t+HOsvHpoZSuXe4xx+f+dY4wiwgNbyQiKIaekpQ47TTwURQgKaGX29Tzb7cC8MTM5DLKB29pRFCzo3QUekFO1dUIrcJJWjIGTxlB2giowZT/4PNFXCyaEJAYe+f5vwa6x1f7it4SyGG2hYCCSAB+9E7gm0H0ObSZjtJAxah4I5vGyg39xmKBc0eM8iMn1Pq0rVE034V0I4o4RNrJqNcgPn3nFUrd9Sw251L21jB9rX3fdtX0HrKlEeVeD2uOCnv1c/E9pqgpCrnuzes/1i/YhBJXierO94PrdmrhEcCkF/FdMBFDsV7UdP4fXQrbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(136003)(366004)(376002)(451199024)(186009)(1800799009)(66899024)(38100700002)(86362001)(36756003)(31696002)(2906002)(6512007)(316002)(31686004)(6506007)(7406005)(6666004)(53546011)(8676002)(8936002)(5660300002)(44832011)(66946007)(66556008)(54906003)(4326008)(15650500001)(66476007)(41300700001)(30864003)(6486002)(6916009)(478600001)(83380400001)(7416002)(2616005)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T09FYk85V3d0cWtQK0VKU2dsTXZVeDNUZG5wZXBGUmdEMXJUd08xVVZVK2E0?=
 =?utf-8?B?eVFNc2xJVGtIb1hKSzU2S1A1a1lyVDlZbXc1R3h2TDhZRVlGVmt2SnNvdlNO?=
 =?utf-8?B?aE5weFJ5RW92R2wvK2V0YzZjUmIva1poQXNQUWw3VEJRaDl6NTRiM2dvbTRy?=
 =?utf-8?B?dlBsdnFrSWVab3hIM1pHUFVYVjBseUVMK3pTdUhxbU5uUW1aZ05aOVVPOGhj?=
 =?utf-8?B?QUxNeDVYSlNjajl6WG5NY1AybEttd2tOb0F2VlhXRTAyWHFqQlV0dUFJc2Zh?=
 =?utf-8?B?d0dNSGNBUzE0dHBEYVpib1VlbU51Z1dUb3E5OHdwcTFWemxIZE85eVdzMzBB?=
 =?utf-8?B?Ym1ObmlOd01wRm5US3ppcHIxMlZmR0lsSVNDckV3Tkw0V2pJelQzcmg3c1lL?=
 =?utf-8?B?VmQ1Tm52eXFVZnpmQTdSWGRnQlZIK3FWUkU2UzBwUXAraEVoM2ZCZllsVjYy?=
 =?utf-8?B?ZUZtTElua2ZlV3dSU2p0cGYwb09VMEtETXUvclYxQzNHR0hVcE5VRzBSNEdz?=
 =?utf-8?B?VFpWWWY2VWRpbnZIMVAvRnRpaWFNMDYyWHZreG4wRmU4aEdiVitkZ1FFKzFF?=
 =?utf-8?B?UUw0d2dOYTNxcWFMRFhaRlpPSEM3WXhZY29jOFRpNjRkZDVKVENZZEhCNzZR?=
 =?utf-8?B?cVY3NXVBTXdtbXh3NHVNWFhGd2RRMUYwUWNiUjJCZ3VleGJWWDFEMUpCMjVR?=
 =?utf-8?B?L1NTL1FLbUdmbTNTV0lVdjVaSlNRV2JBeXhTMGdKS1UxRFVpSUJ2bXJhS28w?=
 =?utf-8?B?Si9FU3QzVWlrY2Z6N3dDV3lqcFhhdUNleHZGMTkyblpTTk82Rld5TXh2Wk5Q?=
 =?utf-8?B?RFRuWlRGKzdORnZLbms5MHlqbGlGZ2JVTXJzV1pVVWtja0dUUGx5YU1td3Jw?=
 =?utf-8?B?U1dIUmtycG55bnFHK1NqSWZQaWhQbW83TDZQbnlheVVlRUpibVpJRkc4c1Zm?=
 =?utf-8?B?S1lDb3dJaVlIalVXczZPRHVET0F5TXFMZXJFNkptVFBYUVJLc0Q0alFjRzdK?=
 =?utf-8?B?bkhoM21WK0NGM3ZHRFJwQzc0Tjhuc1dIUGxEU0NZaWNVdytSUjR0NWc3cHpz?=
 =?utf-8?B?WjU4VTV2Ym5OWjYyejNkTVJLVnJwU0R5RlJSbzVDVmdZYzJqbnZ5R3Yxd0J3?=
 =?utf-8?B?MVNYbzIzWWNqYnJnUUFXQ2NOYjI0Rm5vSXYyT2ZRZ2o0OE5iOHhteThDemUr?=
 =?utf-8?B?Z2JQRWE2cHBsdU9NcUdteXhSaUt5UnlReGFPK0swd0JIRmIrMHVrbkFHdkNw?=
 =?utf-8?B?bEJEb3JBT2NXbTZpcmZpWSs2c2lmNTFNa0RnYk9uOTFkb04xY2dzQTVxcElz?=
 =?utf-8?B?Y2ptY1A1Z1drK1BwdjhtMS9LWlRmOVNncytUM3J2L1Q5OXdFS3pKUmhkSEND?=
 =?utf-8?B?dTNtd0ZLdkVBalpFM1VtUURkTVNub010WnJQa0F4OFcxdGhYSW5yN1lVbkI1?=
 =?utf-8?B?MUhLNDlTbnRrZ2FudXROK2JNM3dnZFRVdXQvYnEzZTFiTmEyWFVPdi9UUUt0?=
 =?utf-8?B?bUptbjlwSy9PTm1tODBiUTZUL1BidkQxRDVaem53SnRENjFxVXg0NGdpbkdZ?=
 =?utf-8?B?SlJsdStMOHdqSmY4SUNNNVZESENTaFIzUXlXbGJXSUsrUHZJRlRObjBma2c5?=
 =?utf-8?B?OXV0cmtqZ2Z6SzZpNHdYWFdOWkxnRXAzWnZnNUwyZXlhanFraFRha29hSUdQ?=
 =?utf-8?B?TFFPaENLK3BhWnZuZmloRlRFTlA5U1BjS1BJRnZhTkJ3SkIrTTJFK2VMbjZ1?=
 =?utf-8?B?TnRncU13UE0xWVhOK1k0ajhEdUpybWFweDlQSVVTN2theTlOMEhDN1lTYk10?=
 =?utf-8?B?cFgxTnRERm1McHZiMnB3UUkyV1VvMmJZZU13Rjc3dndja3loeitzdjNHQ1A3?=
 =?utf-8?B?cnVFbnpHeVQ2RDc5T1dHUjloMXM4NW9DMGJucWdFUElnUjJnT3U0QXI2V0Jz?=
 =?utf-8?B?TDdaN08zZmNwUlhMbGp6T2lEbG9GVWdvM3hCQ3pnOHZZS2poMVY5ejlscSs0?=
 =?utf-8?B?ODdwMTJDcHNYK0lPTUV5ME5zdnhraWE0cXc0UHMxWTJpMjRvSVFFLzIzZEFZ?=
 =?utf-8?B?N3BiNU1adzBwNnU1MmdxTzlMN3ZQQVdDTWZaclJ1aUkzeFhMYlNSZE9KYWQv?=
 =?utf-8?Q?nAXynV7PzPquDNffnw77vNmY9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50297f12-7c54-4539-2739-08dbb52d8224
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 14:18:46.8974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7L2yv/hm3QWlNJf0TIREQC2kQdfBShPbhNScZoskahlCPfqhmFTgXX1GkpwizWEwLib29YGmg4Vv+speTQt0QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6313
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/23 09:16, Carlos Bilbao wrote:
> On 9/6/23 08:42, Carlos Bilbao wrote:
>> On 9/5/23 10:49, Greg KH wrote:
>>> On Tue, Sep 05, 2023 at 10:26:56AM -0500, Carlos Bilbao wrote:
>>>> +In the following diagram, the "<--->" lines represent bi-directional
>>>> +communication channels or interfaces between the CoCo security manager 
>>>> and
>>>> +the rest of the components (data flow for guest, host, hardware) ::
>>>> +
>>>> +    +-------------------+      +-----------------------+
>>>> +    | CoCo guest VM     |<---->|                       |
>>>> +    +-------------------+      |                       |
>>>> +      | Interfaces |           | CoCo security manager |
>>>> +    +-------------------+      |                       |
>>>> +    | Host VMM          |<---->|                       |
>>>> +    +-------------------+      |                       |
>>>> +                               |                       |
>>>> +    +--------------------+     |                       |
>>>> +    | CoCo platform      |<--->|                       |
>>>> +    +--------------------+     +-----------------------+
>>>
>>> I don't understand what "| Interfaces |" means here.  There is, or is
>>> not, a communication channel between the CoC guest VM and the Host VMM?
>>>
>>> What does "interface" mean?
>>
>> Explained below :)
>>
>>>
>>>> +
>>>> +The specific details of the CoCo security manager vastly diverge between
>>>> +technologies. For example, in some cases, it will be implemented in HW
>>>> +while in others it may be pure SW.
>>>> +
>>>> +Existing Linux kernel threat model
>>>> +==================================
>>>> +
>>>> +The overall components of the current Linux kernel threat model are::
>>>> +
>>>> +     +-----------------------+      +-------------------+
>>>> +     |                       |<---->| Userspace         |
>>>> +     |                       |      +-------------------+
>>>> +     |   External attack     |         | Interfaces |
>>>> +     |       vectors         |      +-------------------+
>>>> +     |                       |<---->| Linux Kernel      |
>>>> +     |                       |      +-------------------+
>>>> +     +-----------------------+      +-------------------+
>>>> +                                    | Bootloader/BIOS   |
>>>> +                                    +-------------------+
>>>> +                                    +-------------------+
>>>> +                                    | HW platform       |
>>>> +                                    +-------------------+
>>>
>>>
>>> Same here, what does "Interfaces" mean?
>>>
>>> And external attack vectors can't get to the kernel without going
>>> through userspace (or the HW platform), right?
>>>
>>>> +There is also communication between the bootloader and the kernel during
>>>> +the boot process, but this diagram does not represent it explicitly. The
>>>> +"Interfaces" box represents the various interfaces that allow
>>>> +communication between kernel and userspace. This includes system calls,
>>>> +kernel APIs, device drivers, etc.
>>>
>>> Ah, you define that here now.
>>>
>>> But the kernel talks to the Bootloader/BIOS after things are up and
>>> running all the time.
>>
>> That's true. Here's some alternatives you might like more:
> 
> If nobody has any strong opinions regarding this alternative diagrams, I'd
> like to know if there are any objections left with the current threat
> model.

Jon, I believe we have addressed all major concerns and this is good for
merge.

> 
>>
>> (a)
>>
>> +-----------------------+      +-------------------+
>> |                       |<---->| Userspace         |
>> |                       |      +-------------------+
>> |   External attack     |         | Interfaces |
>> |       vectors         |      +-------------------+
>> |                       |<---->| Linux Kernel      |
>> |                       |      +-------------------+
>> |                       |         | Interfaces |
>> |                       |      +-------------------+
>> |                       |<---->| Bootloader/BIOS   |
>> |                       |      +-------------------+
>> |                       |         | Interfaces |
>> |                       |      +-------------------+
>> |                       |<---->| HW platform       |
>> |                       |      +-------------------+
>> +-----------------------+
>>
>> (b)
>>
>>
>>
>>                 +-------------------+
>>        ┌─────── | Userspace         |
>>        │        +-------------------+
>>        │           | Interfaces |
>>                 +-------------------+
>> External   ─── | Linux Kernel      |
>> attack         +-------------------+
>> vectors           | Interfaces |
>>    │  │         +-------------------+
>>    │  └─────────| Bootloader/BIOS   |
>>    │            +-------------------+
>>    │               | Interfaces |
>>    │            +-------------------+
>>    └────────────| HW platform       |
>>                 +-------------------+
>>
>>
>> (c)
>>
>> ┌─────────────────┐
>> │                 │
>> │   Userspace     ├─────────┐
>> │                 │         │
>> ├──────▲───────▲──┤         │
>> ├──▼───────▼──────┤         │
>> │   Linux kernel  │         │
>> │                 ├───── External
>> ├──▲──────▲───────┤      attack
>> ├─────▼───────▼───┤      vectors
>> │   Bootloader/   │       │   │
>> │   BIOS          ├───────┘   │
>> ├───────▲─────▲───┤           │
>> ├───▼───────▼─────┤           │
>> │                 │           │
>> │   HW Platform   │           │
>> │                 ├───────────┘
>> └─────────────────┘
>>
>> ┌─▲─┐
>> └───┘ Interfaces
>>
>>>
>>> Same goes with the HW platform, the kernel talks to it too.
>>>
>>>> +The existing Linux kernel threat model typically assumes execution on a
>>>> +trusted HW platform with all of the firmware and bootloaders included on
>>>> +its TCB. The primary attacker resides in the userspace, and all of the 
>>>> data
>>>> +coming from there is generally considered untrusted, unless userspace is
>>>> +privileged enough to perform trusted actions. In addition, external
>>>> +attackers are typically considered, including those with access to 
>>>> enabled
>>>> +external networks (e.g. Ethernet, Wireless, Bluetooth), exposed hardware
>>>> +interfaces (e.g. USB, Thunderbolt), and the ability to modify the 
>>>> contents
>>>> +of disks offline.
>>>
>>> Ok, but again, your diagram is odd, the text seems correct though.
>>
>> My hope is that everyone can understand the updated diagram we pick with
>> the explanation of what Interfaces means in this context.
>>
>>>
>>>> +Regarding external attack vectors, it is interesting to note that in most
>>>> +cases external attackers will try to exploit vulnerabilities in userspace
>>>> +first, but that it is possible for an attacker to directly target the
>>>> +kernel; particularly if the host has physical access. Examples of direct
>>>> +kernel attacks include the vulnerabilities CVE-2019-19524, CVE-2022-0435
>>>> +and CVE-2020-24490.
>>>> +
>>>> +Confidential Computing threat model and its security objectives
>>>> +===============================================================
>>>> +
>>>> +Confidential Computing adds a new type of attacker to the above list: a
>>>> +potentially misbehaving host (which can also include some part of a
>>>> +traditional VMM or all of it), which is typically placed outside of the
>>>> +CoCo VM TCB due to its large SW attack surface. It is important to note
>>>> +that this doesn’t imply that the host or VMM are intentionally
>>>> +malicious, but that there exists a security value in having a small CoCo
>>>> +VM TCB. This new type of adversary may be viewed as a more powerful type
>>>> +of external attacker, as it resides locally on the same physical machine
>>>> +(in contrast to a remote network attacker) and has control over the guest
>>>> +kernel communication with most of the HW::
>>>> +
>>>> +                                 +------------------------+
>>>> +                                 |    CoCo guest VM       |
>>>> +   +-----------------------+     |  +-------------------+ |
>>>> +   |                       |<--->|  | Userspace         | |
>>>> +   |                       |     |  +-------------------+ |
>>>> +   |   External attack     |     |     | Interfaces |     |
>>>> +   |       vectors         |     |  +-------------------+ |
>>>> +   |                       |<--->|  | Linux Kernel      | |
>>>> +   |                       |     |  +-------------------+ |
>>>> +   +-----------------------+     |  +-------------------+ |
>>>> +                                 |  | Bootloader/BIOS   | |
>>>> +   +-----------------------+     |  +-------------------+ |
>>>> +   |                       |<--->+------------------------+
>>>> +   |                       |          | Interfaces |
>>>> +   |                       |     +------------------------+
>>>> +   |     CoCo security     |<--->| Host/Host-side VMM |
>>>> +   |      manager          |     +------------------------+
>>>> +   |                       |     +------------------------+
>>>> +   |                       |<--->|   CoCo platform        |
>>>> +   +-----------------------+     +------------------------+
>>>> +
>>>> +While traditionally the host has unlimited access to guest data and can
>>>> +leverage this access to attack the guest, the CoCo systems mitigate such
>>>> +attacks by adding security features like guest data confidentiality and
>>>> +integrity protection. This threat model assumes that those features are
>>>> +available and intact.
>>>> +
>>>> +The **Linux kernel CoCo VM security objectives** can be summarized as 
>>>> follows:
>>>> +
>>>> +1. Preserve the confidentiality and integrity of CoCo guest's private
>>>> +memory and registers.
>>>
>>> Preserve it from whom?
>>
>>  From unauthorized access, I could update this sentence.
>>
>>>
>>>> +2. Prevent privileged escalation from a host into a CoCo guest Linux 
>>>> kernel.
>>>> +While it is true that the host (and host-side VMM) requires some level of
>>>> +privilege to create, destroy, or pause the guest, part of the goal of
>>>> +preventing privileged escalation is to ensure that these operations do 
>>>> not
>>>> +provide a pathway for attackers to gain access to the guest's kernel.
>>>> +
>>>> +The above security objectives result in two primary **Linux kernel CoCo
>>>> +VM assets**:
>>>> +
>>>> +1. Guest kernel execution context.
>>>> +2. Guest kernel private memory.
>>>> +
>>>> +The host retains full control over the CoCo guest resources, and can deny
>>>> +access to them at any time. Examples of resources include CPU time, 
>>>> memory
>>>> +that the guest can consume, network bandwidth, etc. Because of this, the
>>>> +host Denial of Service (DoS) attacks against CoCo guests are beyond the
>>>> +scope of this threat model.
>>>> +
>>>> +The **Linux CoCo VM attack surface** is any interface exposed from a CoCo
>>>> +guest Linux kernel towards an untrusted host that is not covered by the
>>>> +CoCo technology SW/HW protection. This includes any possible
>>>> +side-channels, as well as transient execution side channels. Examples of
>>>> +explicit (not side-channel) interfaces include accesses to port I/O, MMIO
>>>> +and DMA interfaces, access to PCI configuration space, VMM-specific
>>>> +hypercalls (towards Host-side VMM), access to shared memory pages,
>>>> +interrupts allowed to be injected into the guest kernel by the host, as
>>>> +well as CoCo technology-specific hypercalls, if present. Additionally, 
>>>> the
>>>> +host in a CoCo system typically controls the process of creating a CoCo
>>>> +guest: it has a method to load into a guest the firmware and bootloader
>>>> +images, the kernel image together with the kernel command line. All of 
>>>> this
>>>> +data should also be considered untrusted until its integrity and
>>>> +authenticity is established via attestation.
>>>> +
>>>> +The table below shows a threat matrix for the CoCo guest Linux kernel but
>>>> +does not discuss potential mitigation strategies. The matrix refers to
>>>> +CoCo-specific versions of the guest, host and platform.
>>>> +
>>>> +.. list-table:: CoCo Linux guest kernel threat matrix
>>>> +   :widths: auto
>>>> +   :align: center
>>>> +   :header-rows: 1
>>>> +
>>>> +   * - Threat name
>>>> +     - Threat description
>>>> +
>>>> +   * - Guest malicious configuration
>>>> +     - A misbehaving host modifies one of the following guest's
>>>> +       configuration:
>>>> +
>>>> +       1. Guest firmware or bootloader
>>>> +
>>>> +       2. Guest kernel or module binaries
>>>> +
>>>> +       3. Guest command line parameters
>>>> +
>>>> +       This allows the host to break the integrity of the code running
>>>> +       inside a CoCo guest, and violates the CoCo security objectives.
>>>> +
>>>> +   * - CoCo guest data attacks
>>>> +     - A misbehaving host retains full control of the CoCo guest's data
>>>> +       in-transit between the guest and the host-managed physical or
>>>> +       virtual devices. This allows any attack against confidentiality,
>>>> +       integrity or freshness of such data.
>>>> +
>>>> +   * - Malformed runtime input
>>>> +     - A misbehaving host injects malformed input via any communication
>>>> +       interface used by the guest's kernel code. If the code is not
>>>> +       prepared to handle this input correctly, this can result in a host
>>>> +       --> guest kernel privilege escalation. This includes traditional
>>>> +       side-channel and/or transient execution attack vectors.
>>>
>>> ok, good luck with that!  side-channel attack vectors are going to be
>>> interesting for you to attempt to handle.
>>>
>>> Anyway, you are setting yourself up to treat ALL data coming into any
>>> kernel interface as potentially malicious, right?  I welcome the patches
>>> to all of the drivers you are using to attempt to handle this properly,
>>> and to cover the performance impact that it is going to cause (check all
>>> the disk i/o packets!)  Good Luck!
>>>
>>> greg k-h
>>>
>>
>> Thanks,
>> Carlos
>>
> 
> Thanks,
> Carlos
> 

Thanks,
Carlos
