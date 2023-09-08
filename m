Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF86A7987A5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 15:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243466AbjIHNOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 09:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjIHNOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 09:14:08 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718D819BC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 06:14:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUsCu+XZqUXtwfKMg9Nbou91xE3ALw9ufXOxB3TVtGfUKJfQs/wCsASIBiS2vl717zwUx//myWuIx6uJEVX050GLiKSbhpyNEpkaLs0CCeS9u3hqNcVJ1hnqRauiWs9kBbLFwfceIhNpIsJMXo49s+2m6HzQhL5RCyzETeIq1hUYWGq5H7ksDyZT2jDSGN6vPYGNWX7cZRMnDWetJy92LnUWkVnpe/nbluYiJ83tw2EWLNidJsXKZtROYmYzqiPRPptpyuEI1Al/ppp0/9/1is1CI2iI7fEs64rdO1hIQ1D6cygN94McVIoxauo+w3nv5DG+Fobgh1UKAq+1wyhHgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7A2aNmAVY1lnT7/wY1oro+z6rtLY8diVsz3PuPWoOs=;
 b=cC6T0GFCZ1mlohKb0pvD+CipNJPJkFcBBJKwd0ag03AQgIzZX70d5IDbUf+zVht7ewDUiX/FCFJ+pjjknv6ry9B3QFFBUVUecR/kJSJxq0tYOmbSKp+bysa8Cyrbu2d4uajobkbE7SbAODUIEjBjNE+RoFNuQwFI1K1STvAldqiDPHyNTC/WzvOGDN/OgO8l6pUAfaUkhKhO89+6q85Izr54uiJBOWoS0xiPWEWdIz8NpF3IQjYhGVqhd+BOUtQtvbCrV6a57AZbYtdHe/+zXgpqTxZF91/Vpjvra8H+D0WA2wwXhwwQ8eQgVZsKBpB+wGe/E8x2FUzFNTB3ASixlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7A2aNmAVY1lnT7/wY1oro+z6rtLY8diVsz3PuPWoOs=;
 b=WpYxBg2T+foOt5h5lEZEPQ7Xl6p3PAAp9cjiZltb2pe8IM1tYLGQX4+RO8USU4BrdIywrXCahTpD6iHb9EfKfnMOK2K3joDbucQ5+KBf1IRbA3+v6chOMOurPDZcl5sV7+7HIxBCFpUFP4BLHIk34tfkWeXD5+P1cTUhdVCtJlM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB4091.namprd12.prod.outlook.com (2603:10b6:5:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Fri, 8 Sep
 2023 13:14:01 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd%7]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 13:14:01 +0000
Message-ID: <0d8a35c9-82ca-188a-529d-65fd01c40149@amd.com>
Date:   Fri, 8 Sep 2023 08:13:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] x86/sev-es: Do not use copy_from_kernel_nofault in early
 #VC handler
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Adam Dunlap <acdunlap@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, Jacob Xu <jacobhxu@google.com>
References: <20230906224541.2778523-1-acdunlap@google.com>
 <e037f1c0-aaf6-7951-04ea-6d27e557b61b@intel.com>
 <CAMBK9=b9V6WxYZNrVPNV5vzBZ-mT_noBAxod=ijqrV3bUXAUyA@mail.gmail.com>
 <cb958f57-6a3a-d626-da51-53ad0e61870c@intel.com>
 <CAMBK9=bk715TjXhzwss+wFqpafKganGhZ=WKWPvEuJyM5M2MCQ@mail.gmail.com>
 <ac2f3bfc-9177-abc9-d4d7-69b1fba943a6@intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <ac2f3bfc-9177-abc9-d4d7-69b1fba943a6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0058.namprd13.prod.outlook.com
 (2603:10b6:806:22::33) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DM6PR12MB4091:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ad95bc2-b7b2-4aaf-f722-08dbb06d77bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DKYSFqLKDC7KkafxWVyaVW/tABQn+YubFITT5jVLVXM7kHS9g5h+cUuhSX9PMr9uJbAP5f7eFDQKLHGw/0oJl4L3em91qCe9IbcqVfLe5Y6R5IUD6CbM6ptOEmqdv2XjmDO50PxtdNOcmBH5zW0mzztL4NZbKgmP0GVU0ChkAoEfPHWqQM/wkwKJsCNJVI/zXbdybtS+wm1+E/Do7xi655oQR2n1JCruzA2e7RJag/efOH1oPrArpo6BOcxa4IR9IG5/SvkZbSVc4CRcc7xfsgFguC9380zNpNGTm1HW3C6KhKvqEJEa3TRd3KoX+lC9e1GQOKBgElGO2YZNXduTlzFlxSuWlyLC/kyv81aL8DqwET4NS8sbPOVmesKfkX5GrYiCsw8QTJdwyqq8ufuOtcA2OKHHKNGitXe5F+44iUOBt2EjteKubT7FlkRUAjMRdodq9uaEkoM9kKM4F8rJn//ZjX2v7FTdhX0URyq7IXay9r9A+ONbyysx6NSGyHRmt+v6nXXpEhVERwVmvFs8SDJ7j2qFrMIUR+ECQgNKr8qQRnB1wmN6jLjmah/yKQAeozpBQ1D18kdv4XuseUYm/b4b4J5hh7JjMzFfJQL+rRnmRh56KfM1lc0pXGHxU8803+5z2kUWNfYZlDrm45wFfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199024)(1800799009)(186009)(7416002)(66476007)(110136005)(66946007)(316002)(54906003)(66556008)(2906002)(31696002)(4326008)(8936002)(5660300002)(6666004)(83380400001)(8676002)(6506007)(26005)(6486002)(41300700001)(6512007)(53546011)(478600001)(86362001)(2616005)(36756003)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEh0bUx2TnJ6R05oOWZlN1A5b0hHaUd1WFFwM2ZPSVlzZmU2ZE00WGtvNmh0?=
 =?utf-8?B?V3BnUWErNTFPREprYlRvM3hCRFJjemU4cHR4TGcrc2U0WGtyb3pKQmYxMTh1?=
 =?utf-8?B?a213TDR6RCtDM3B1TmJ6R1ZHczV0akpjb3E2bnNGZ2dCb0JFVlEyQ1pkM0gx?=
 =?utf-8?B?dDlxRkQ5c0VFT2dZVThYN3dGczRpeHpzL3FlcFZGU0FOQVRVQXRCa0x1S3Rt?=
 =?utf-8?B?RUl6eEJmWm54bXREVkJlcnErMTFTY1d6c29leHNvZTVRczg5VHZWaW1GYmVJ?=
 =?utf-8?B?NWpLUFdvQnVkVlF4RHFKYnc2Qi8zUmV5dEc3NUNqS0FwYkd0RkdkUEdIWmhx?=
 =?utf-8?B?dDYzSEVYajdWOTUxN3ovb3BJUmlML1FmRlBJTnJiSCswaXpYWExVY01JQi93?=
 =?utf-8?B?L2ozS1U1cVRxZUhycFlwMHdIWThXQmltQVZWQlE0bHhET3Nzd3lvS2VPSW80?=
 =?utf-8?B?bENEd3p1Q2laTnM1YmZXRjYvWXI1a2JkZURvRFdUdXo3SmZzd2laZVlBT0RB?=
 =?utf-8?B?Q3hJNENtREdKUUExZk1pdTZpMkxUamFDeGFmOGZuS01Sd29jZGxrMUZuVzRy?=
 =?utf-8?B?OExhRnRUQk5WTDlnRFRTcGVKUUFpZlBxQlkxRDNlN1Y1cmlldnhmSDJMTE9k?=
 =?utf-8?B?WlZTbHlkUWdydHZxV2FDVDZKVGQ3cTIxTS9FRTRybmRhZHpEMnBJc1prZXpj?=
 =?utf-8?B?YmdobXN5SWg0djZ2dzg1RFQ2TUplSDNQTUdPSlZ1QXVTc0cwclExbmR3d09T?=
 =?utf-8?B?OTJQcFpCcjB5YTJuakF6UjFKU2dHaG9BVVg4cUJjNzUxSFRpeFA4VDJSczNl?=
 =?utf-8?B?Z3Q5RjhlUUhkLzRWZDJEQVpvVmlqZGZQR2owZzdFdXRzaGZwZ0dQUE1IbFRJ?=
 =?utf-8?B?SUEyMWsrZFZWM1V5ZHRBTWlRb005eTZ3U1J1SlNTWHBuSlQ5bys0cERWNjNl?=
 =?utf-8?B?T2JQeW5NT1hqa1dDT1BlbzQrRTJSL3dSS2hsbEtobVFyV2lYdlNJY004b3gw?=
 =?utf-8?B?TmhKaHZmWWJWQTdmQ3pDMTAycWdvcHNHRm82VW9wNkY3KzRRME1lUnBPZkhG?=
 =?utf-8?B?L1NFNmxKb3FvQjFORXdqeW5KczFaTTM5MHh5Z1A2aWloOWx4bXZuRVJ5Z3p0?=
 =?utf-8?B?by95U0pOUk5UWmRYdHBOZ1M0bEg3UndodU1rSHRDZXlVRkNWL1NCVENNcW1m?=
 =?utf-8?B?eS82NnNqRWJDbEJ6MWFWWk5MYXExZUUrQURxdTNuT0tER3krMGhQNVpOYmVI?=
 =?utf-8?B?aUVYZmUwelZNZDlOQ21SdXFIck1HV3R5cVo4d0daVzFYUGUrclhnRXpPZUN6?=
 =?utf-8?B?ZEZtZUpSejhYQnV4azNkN1BuSm5Rb3NYNVhhYmpZN0NqcnlKWXVHZjUyVmwr?=
 =?utf-8?B?c29HTmVDM0xJTC9lVncwWXh4TDYzSHRncG00SGZFOERoczJDTWRPSW50eHdw?=
 =?utf-8?B?dWZkcXhRczRKeEcxSk91a2EvTnlJdnNCaHhkU2llb0xjQWIranljVEkvOFlo?=
 =?utf-8?B?VEY1LzRpN3BobFBaSHQ0anVCeXNRZGV3TUVrZ1c1ZDZ2bkg0b21FSUNnQ1V1?=
 =?utf-8?B?VlhKZHErcWN2UkpMc1JkYUI2YXpiRWxhY0w0ckgxeTJRYlNyL1RVNFFyOWpL?=
 =?utf-8?B?akpCSlRGMjlralNybWRwRHpXTHNVRnZwTXYxdjFOaGttWEhHUkJLMzlnSkVI?=
 =?utf-8?B?K2NIYVJ4dmhzMXp4MFB6UUZvbm82eTZJaStmclhIdW9EazJ2RUxCZXlzMDdV?=
 =?utf-8?B?MG82eVZheForMVFJN3VUOUxMNjd4L0IzYUtkWXJHemo1QXJsNWsvbGdMODhw?=
 =?utf-8?B?cXRZeTdLbEJRTXVzMkwvR0lZbVhVTGkvZW9yVFZQSlhSdnBkY3pES3Q0R3lY?=
 =?utf-8?B?NkNMUWFSVk5DNnBEcDByeVp1anE0Z0ZIZXY2dG1Jb2txbVZvckVQdUlkbGRz?=
 =?utf-8?B?aExCeVN1eFNtemI5SGhvdkR2b24vUDF5TDBtYlowVEFjWjBrVS9DeDViOGgv?=
 =?utf-8?B?RVFUa2dsc0V4NW45YnBBL2FoYW5RRi82dFJPcXJTdmJtWS9HZ1F5Rmc3RmRm?=
 =?utf-8?B?bTkwU2lxY2dvais0R29xUExpLzFwbDdXeVpYWW9Ba2lKemJaamFaZ0s0djQ4?=
 =?utf-8?Q?9b58mXKE+q0gpIFTaHrr53Yl1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad95bc2-b7b2-4aaf-f722-08dbb06d77bc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 13:14:01.1772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4LE5BsBXnIKOOij1XIjTP2ofrmWIl9pXm9Q90nlwR0Sd15eIKJX0nGUw2GWKitjxfNdXqesMotMBBaJdwuZ8+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4091
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/23 14:12, Dave Hansen wrote:
> On 9/7/23 11:03, Adam Dunlap wrote:
>> On Thu, Sep 7, 2023 at 10:06 AM Dave Hansen <dave.hansen@intel.com> wrote:
>>> How about something like the attached patch?
>>
>> I think that's a much better idea, but unfortunately we can't rely on
>> boot_cpu_data being 0'd out. While it is a static global variable that C says
>> should be 0'd, the early interrupt happens before .bss is cleared (Note if it
>> happens to be 0, then the __is_canonical_address check succeeds anyway -- the
>> boot failure only happens when that variable happens to be other random values).
>> If there's another check we could do, I'd agree that'd end up being a much
>> better patch. For example, maybe we could add a field to cpuinfo_x86 is_valid
>> that is manually (i.e. not part of the regular .bss clearing) set to false and
>> is only set to true after early_identify_cpu is finished. Or the
>> simplest thing would  be to just manually set x86_virt_bits to 0 somewhere super early.
> 
> Gah, what a mess.  So the guilty CPUID in question is this:
> 
>>          /* Setup and Load IDT */
>>          call    early_setup_idt
>>
>>          /* Check if nx is implemented */
>>          movl    $0x80000001, %eax
>>          cpuid
>>          movl    %edx,%edi
> 
> which is _barely_ after we have an IDT with which to generate
> exceptions.  What happens before this?  This isn't the first CPUID
> invocation.  Does this one just happen to #VC and all the others before
> don't?
> 
> In any case, the most straightforward way out of this mess is to just
> move boot_cpu_data out of .bss and explicitly initialize it along with
> some documentation explaining the situation.

Agreed, putting this in the .data section will ensure it is zero from the 
start.

> 
>>> Also, what's the root cause here?  What's causing the early exception?
>>> It is some silly CPUID leaf?  Should we be more careful to just avoid
>>> these exceptions?
>>
>> Yes, it is a CPUID instruction in secondary_startup_64 with the comment /* Check
>> if nx is implemented */. It appears to be pretty important. Potentially we could
>> paravirtualize the CPUID direclty (i.e. mess with the GHCB and make the vmgexit)
>> instead of taking the #VC, but I'm not sure that's a great idea.
> 
> What TDX does here is actually pretty nice.  It doesn't generate a #VE
> for these.
> 
> But seriously, is it even *possible* to spin up a SEV-SNP VM what
> doesn't have NX?

It is a common path, so while an SEV guest would have NX support, you 
would first have to determine that it is an SEV guest. That would take 
issuing a CPUID instruction in order to determine if a particular MSR can 
be read...

Ultimately, we could probably pass the encryption mask from the 
decompressor to the kernel and avoid some of the checks during early boot 
of the kernel proper. Is it possible to boot an x86 kernel without going 
through the decompressor?

Thanks,
Tom

> 
>> There's a couple of other CPUIDs that are called in early_identify_cpu between
>> when x86_virt_bits is set to 48 and when it is set to its real value (IIUC, it
>> may be set to 57 if 5 level paging is enabled), which could potentially cause
>> spurious failures in those later calls.
> 
> That should be easy enough to fix.
> 
> These things where we initialize a value and then write over it are
> always fragile.  Let's just make one function that does it right and
> does it once.
> 
> Totally untested patch attached.
