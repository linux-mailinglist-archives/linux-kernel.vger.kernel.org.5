Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D188B7BBFB1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 21:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjJFTYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 15:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjJFTYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 15:24:35 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC2E83
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 12:24:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6MjAM6spMnrMUJGWtUfr/MnByleyVVw19UVzsUiXQ0Jl0sL8RDiV+CqGD6dDHnt1dfS13QCAWf9qs8zh7Vfz8JYBC1cm5dHn5uspX3VNbZ7leZAFvfcdSem/O4IdwI+E1oPT0Ygo9gfm0mGPMMHrEAlT7OeFh8V64kVXwcldlMFJZoeCOkEMRUSqTW2+R4BLi1+TYD7MHeXv6lPo+cz67v8LW1tM3/4ojzcFNalvAaJZ7ea6MnhN8lsn01GXorjb4ohjS6XftxGKtYuWLTTRqJ06Bcq34Y3R5nyV0NfWXURA+XmWVjrCfBzxr2CC9bIRkLYWvHbGCf9Sx6BQanxMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MHKPlvqSy/RUpySyhJq3dgCf1WBgiiw2DmCcJYGtZs=;
 b=TiD+yUxGf4L4kIQT0X/VQYTmLRwiVmlCDV24cMmrs6r8QZLOcWCVKDkjr0WYoAw54f1tsXr3dD4YVBPURo473MkPIlryAkYV1vDPtVZPJkoskAm5LaszfvYS0Tr3CPPjl5nJyV4gt4zYx/KDVF79j9lUAtIV+iHZYbKjMlPpolNDpjtx2GXlsr+NmJpxWp2+B7/CryC/sViiL7qRz6+6un1ZbFU3Lqqs1fdwMw9aVF6JVpAtVr5Nn8fdcw8w283BfMhjFsBOEl9cesBLuDMr8oMXTa2Mc67qRHBr0223Jr85dbYfQto92AIyQv50knlnPT4elKMFPf2vTh1wzIy+AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MHKPlvqSy/RUpySyhJq3dgCf1WBgiiw2DmCcJYGtZs=;
 b=YEe5vjVJy9Yhpw/spdAxYGFUu7rTNuALORL+G1IWmebxEPFE1gc+Miegt2FsSRj4BEDmbGQDNvL/kBs75CWN4Fz6/eQSWFNcGDA1PmaSqHolshVOSKlJwhYPZ65mrGumUENObGHE2uZDgwmQwggKAw8ZzpEGk2XxJnAuZ7vIvIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by IA1PR12MB8221.namprd12.prod.outlook.com (2603:10b6:208:3f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Fri, 6 Oct
 2023 19:24:13 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::6ac8:eb30:6faf:32b2]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::6ac8:eb30:6faf:32b2%5]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 19:24:13 +0000
Message-ID: <f4228262-02f9-3af5-8ef5-be109b5d3d13@amd.com>
Date:   Fri, 6 Oct 2023 14:24:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 10/13] x86/tdx: Convert shared memory back to private on
 kexec
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        kexec@lists.infradead.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-11-kirill.shutemov@linux.intel.com>
 <8d0e4e71-0614-618a-0f84-55eeb6d27a6d@amd.com>
 <20231005212828.veeekxqc7rwvrbig@box>
 <e0459b50-7e21-7548-8151-9010ee88b0a6@amd.com>
 <20231005222839.jt2du72xogg3c5ny@box>
From:   "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20231005222839.jt2du72xogg3c5ny@box>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:806:120::25) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|IA1PR12MB8221:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d3876c-d632-43c1-587d-08dbc6a1d308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pjDMpRynd789rE0b0vH5MUEKKAO+vlyZiQguihQFjxRvPAfSk+0qJ/uqRejH9Ksd3BSiuIIPwDBvO07EsUxIvaSEh9q/kGxrwmy6iGs1ROIzShh9YJccUPfOu+ROOo7hfACYDho6ScGbsXa6iNtm7zNwSNb0/dRN5wDSVzx0eBd9W5sIgc3HB6Sl84396dwe0ya39BizmArmovklEGlvn8aDqIA9+K0QY7Qxh20w/28OIwWNSYMfTWunNCNWjqwtWPrmrkRcGcrOZUphFjxIRtMVRdunlUQlraEaR6sDp0S3SSjtUgLmWTG6Befj138tYtDbu3M1gy7Eofjqq0xxOVs5frWn5e6BwrnbWncaWrRM3998GuUQ9RRlTgjgCB3x3Glf25SE0QRFLKvic6I5wi2tK4MBacMY8l+VhPXNsvct3RYFms21S55YvysRH/gbf8BsIWbfSfD+JasNUnyrXX/YANTqlMzi2zYA3dFejNOXtYG5V72WqfXK4VVMEl+mm7PHSb3Wx/5Hz0Ua9/riBRqEz31ZfukyViFg8SNId1Mjot+dfml6XAm0GtyA3fAmzAlb6Wcm4R6Dl4zEEWbLHtB82o41DMi5d45npLN42VnNwUl7wA911dk5iQ0eohs+SdxYehWFGw9Nhmk/v4+Pxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(2906002)(2616005)(83380400001)(26005)(36756003)(86362001)(38100700002)(31696002)(41300700001)(8676002)(8936002)(31686004)(4326008)(5660300002)(6486002)(316002)(66946007)(7416002)(54906003)(66476007)(66556008)(478600001)(6512007)(6506007)(6916009)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MElUUVVTaGwzN3M1YTJDaXdCQkY1MnJPakdUQ2VncWRrVzV1MFgvNGxqN2xi?=
 =?utf-8?B?WXlud2pqcDBaazg2RHpwdmVpOGp6Y0wrc2JySjN5UERYeTdDc3FMaDgyT1Ba?=
 =?utf-8?B?VzREZkxqNUtoWWZtdHlhbHl2L1ozZHpCWmozWVRGVGwvTnpFajJTaGZsS2h1?=
 =?utf-8?B?RG95dU9Yd0RoRHpiK1BEcng1c2VTQW5SeDYzY0FMTEFqdG5JdUhYcDNVdTNY?=
 =?utf-8?B?YmlOVUx4Y3VnQ0NuSGpzaG5IK0lybWZHOER0OThZN3F4KzZNMnFZa1NoNmJx?=
 =?utf-8?B?MGlkYWVGRDkxTWt3cmJvNlBTaUk2VTNZYXhsVWE3Y3VHL3RlcDNXd2ZINXdz?=
 =?utf-8?B?UWxqR0VsVlI3NG9ZZmdFRlYzSDJxNWpMdjU0T2dJczBubFlrd0tVVEpEUWF2?=
 =?utf-8?B?NXpqRkxITHE5MXVCYS9tM1k2Q0FpNTUzMlpLSG5zd0lzZjBmdnZxekphNlBG?=
 =?utf-8?B?TnpWa1dEbmxpa3pCcnNxSDFKNS9CK2Z0ZXE0NFk2N1lvLzc5N2NTbTNLL3cv?=
 =?utf-8?B?Tk41UjAvN0NmbXBOWWVURE1zL21TYVlSWk0zc2tDZjQ5UkZlbnJ4dmZPMTVC?=
 =?utf-8?B?OGhtTjloY0diU1VSRklLZk01VkFHcnNxajBXVlI1TExGbjB5OGNDdS9BMGs3?=
 =?utf-8?B?Sk41cWRCdGMxSzc5U1BSUU9ydWFqMlJmSkZQNjhBaXByZUQyaTNnRmltcWNt?=
 =?utf-8?B?dDVzdlRucXg3TmIxSnZPa3dKYjFDR0R4N3lCSGZxaVZ1Vmh2dzBRdkdnUWln?=
 =?utf-8?B?VVJNYW5FY0wxUVYxNGVXNW9jenlsbFRDSnNqcVRWamlmMk4yZEdrb1d0enNF?=
 =?utf-8?B?R1kydEtiRnBTRXMydVpTRjRRd0d4U2F6bjRDNXdlWm5mK0tvYWVlbG1jTHcy?=
 =?utf-8?B?b0V3dVdFVkFNYzNOcjhpdEZGVlJTZ2RRSnNWZndNZjZyOFM0cExzSGw1aW5u?=
 =?utf-8?B?ZTl2Mk1yWWRaN01uQ05KRDVCS05yRWVoOFBlVHY5cWJCY0krQStzbm1qZG8r?=
 =?utf-8?B?U01ZQU1VZmplb3hUY05rOHBESjZoWUFvMDlOMGhZcEE3YnUraDg4UCtIcHFX?=
 =?utf-8?B?ZW1DNXZTQVM1eitqSWJqMUNhV0FEYVg4WFVVSURMWFcxbnpPd0Nrc25WQnN1?=
 =?utf-8?B?ZC9aUEswODkyUk9kaWFqOXdNUWVNZWowWXp5b3k4SkxnVU51S25qanJXS0xT?=
 =?utf-8?B?MVh4OGtEeXllcm1vQ09pNVBRWHhVdkFXVTluaklyTEZsRlFCZVJ2TWo0d21Y?=
 =?utf-8?B?aTBtSnpvNDRHeDZuUzh2VnJSY09Qcmt6RngrVmZOVTUrOStXWGZQTWJmWm1M?=
 =?utf-8?B?Skg0Z3VxZHp3M2krL2JYN2JBeE91cWEzNHJZaXZ3RUt5T3VFaEtuTXFwcTdM?=
 =?utf-8?B?Qk8vbkFaUkV4MUJySWVxZjRsK2JRc3Q1M2RJZ2Y3dUxyLzlYU2ZNZytBc2s4?=
 =?utf-8?B?QnhHKzI1enlicHRjRXo0WlhhRDdSZWlWalArNnBqZ1N3NzJzQ3dzS0pZVXpF?=
 =?utf-8?B?Qm02Tm1mOTcwNmZ1Y3Vqbk5oRzNQVzNtckJ2V3loQ1J2K1dsaUVSOGlZSHhx?=
 =?utf-8?B?MGRRZ1ZOVnVLZzJoeDd6eXh4ZDZsaXZHZFJEalFzbmIvaWplbTBrU1JuQ3F2?=
 =?utf-8?B?NWxhOSsvN2lCaTdDQTU2ekh6NUNYVkpKOVE0dWM2Vy9aMU9MQ2FTOGthUHow?=
 =?utf-8?B?VjNNK1pNSzQ2Ykw0bGs1MmlQc1BSQmlzRndaZmxWYkUyOHpKY1phSW1SSEhJ?=
 =?utf-8?B?YVZTN1ZNZ0R2Sk85OTIzY0pHcmlwTzhITzVYc0xUUGR6aDhCd3FUYzlPSlg1?=
 =?utf-8?B?MVlUNXl6Ni9EMUhjL1dkc0tXL1kxa3h6V0srZ0hTakJ6TnZ0NzNIb0hoeSto?=
 =?utf-8?B?RkpISk53QTVFeG4yQU05NDF3UTdPai9SSmJOZE9YcE8rbmt0RkZXR1UvTzFJ?=
 =?utf-8?B?TXRzMDFPbVZ4TjZBbUl2Y2hVN3hwdGxtS29MVFNqbFhRdVdCM0NxSGdhMHdr?=
 =?utf-8?B?V2p2SUhoSGhWSTZmeTR6Q0dKaWx0U0t1M2l0cEs2ZkprNjdyQU9FcGg5UUt2?=
 =?utf-8?B?RE5iZnByeEloTUxRcmFYektHM01PM0NYR1luc2JHTy9USUgrbHI4MFZoTnRi?=
 =?utf-8?Q?jX2YmaUQwbg5k8z3T0eoQEjvb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d3876c-d632-43c1-587d-08dbc6a1d308
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 19:24:13.7638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xo23yfCzROj67U9Pdzuujmoj9O+vDAvmHb6b8cgFiIIvDNZ+sD5EJi7rgqEjJFlhChrtscvHGX8QdCLh5sTerA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8221
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/5/2023 5:28 PM, Kirill A. Shutemov wrote:
> On Thu, Oct 05, 2023 at 05:01:23PM -0500, Kalra, Ashish wrote:
>> On 10/5/2023 4:28 PM, Kirill A. Shutemov wrote:
>>> On Thu, Oct 05, 2023 at 01:41:38PM -0500, Kalra, Ashish wrote:
>>>>> +static void unshare_all_memory(bool unmap)
>>>>> +{
>>>>> +	unsigned long addr, end;
>>>>> +	long found = 0, shared;
>>>>> +
>>>>> +	/*
>>>>> +	 * Walk direct mapping and convert all shared memory back to private,
>>>>> +	 */
>>>>> +
>>>>> +	addr = PAGE_OFFSET;
>>>>> +	end  = PAGE_OFFSET + get_max_mapped();
>>>>> +
>>>>> +	while (addr < end) {
>>>>> +		unsigned long size;
>>>>> +		unsigned int level;
>>>>> +		pte_t *pte;
>>>>> +
>>>>> +		pte = lookup_address(addr, &level);
>>>>
>>>> IIRC, you were earlier walking the direct mapping using
>>>> walk_page_range_novma(), any particular reason to use lookup_address()
>>>> instead ?
>>>
>>> walk_page_range_novma() wants mmap lock to be taken, but it is tricky as
>>> we run here from atomic context in case of crash.
>>>
>>> I considered using trylock to bypass the limitation, but it is a hack.
>>>
>>>>
>>>>> +		size = page_level_size(level);
>>>>> +
>>>>> +		if (pte && pte_decrypted(*pte)) {
>>>>
>>>> Additionally need to add check for pte_none() here to handle physical memory
>>>> holes in direct mapping.
>>>
>>> lookup_address() returns NULL for none entries.
>>>
>>
>> Looking at lookup_address_in_pgd(), at pte level it is simply returning
>> pte_offset_kernel() and there does not seem to be a check for returning NULL
>> if pte_none() ?
> 
> Hm. You are right.
> 
> I think it yet another quirk in how lookup_address() implemented. We need
> to make it straight too.
> 
> There's two options: either make lookup_address() return pointer for entry
> even if it is NULL, or add check for pte_none() after pte_offset_kernel()
> and return NULL if it is true.
> 
> I like the first option more as it allows caller to populate the entry if
> it wants.

Yes, i like the first option.

> 
>>>>> +			int pages = size / PAGE_SIZE;
>>>>> +
>>>>> +			/*
>>>>> +			 * Touching memory with shared bit set triggers implicit
>>>>> +			 * conversion to shared.
>>>>> +			 *
>>>>> +			 * Make sure nobody touches the shared range from
>>>>> +			 * now on.
>>>>> +			 *
>>>>> +			 * Bypass unmapping for crash scenario. Unmapping
>>>>> +			 * requires sleepable context, but in crash case kernel
>>>>> +			 * hits the code path with interrupts disabled.
>>>>
>>>> In case of SNP we will need to temporarily enable interrupts during this
>>>> unsharing as we invoke set_memory_encrypted() which then hits a BUG_ON() in
>>>> cpa_flush() if interrupts are disabled.
>>>
>>> Do you really need full set_memory_encrypted()? Can't you do something
>>> ligher?
>>>
>> We need to modify the PTE for setting c-bit to 1 so that will require
>> cpa_flush(), though probably can add something lighter to do
>> clflush_cache_range() directly ?
> 
> For TDX, I don't touch shared bit as nobody suppose to touch the memory
> after the point (ans set_memory_np() enforces it for !crash case).
> 
> Can't SNP do the same?
> 

No, we need to make the PSC call for HV to update the RMP, then set 
C-bit=1 in the PTE and then do a PVALIDATE to switch the page back to 
private, so it needs something like a full set_memory_encrypted().

Thanks,
Ashish
