Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9AA7D70C8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbjJYP0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbjJYP0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:26:22 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A01171E
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 08:25:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfkKPJEn/39fiQXyd0+lCnl3viMSEqiXNQ+VnkJBEZkIroBnDghSLb9/vUyRfKFKn6ffEBN97vDu462b7BulM2/4Z7sJk9pbOlF/QUhaDAVT5+Obln1X9EFEYW7v/1dRSbQa51jQYoFIrp3YPsVNUm++RaHkZYkNZRkp9KWdYWdXQEWVVtQ1d3U70GZteTpJhhniko2NJM1CiWeBpdXcZO2fSAHOkAkKdm5i3yLrTVFaA1+wUxOQbX19qoRIo9k4WMAjrX2vL8tG5LvKS8yZFF7O8Ev2ooTTERpWE8JBZDMrFa1pIIu+9KaSC65Olm7s1NDScuW1SThQ5jBqpVh1Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9gKZFbdEQsrXFZgkeQpf+Yf2wWxn2nvbRtTsxo+41I=;
 b=BvHJaiOgXe/HqIcZ5KtySnryLfvOaNH1MXy1ICn9PNZa4sOAIV50XR9r1JtmW7Vr/ykTZ7QJRGG3MCaU0EftuEIzf3bNWDFCUeJYdXnk6+BIiSS14ulL/sYDIJklzFO1GcMOJkm2xxl3dtHbU/8Hp3wtN403P/bYkxqyNhwxfo92ceW2LbLujwi2Dd2I5HXwcymcA1/XIqia7tzikD7vv1cOUqyY26J4G6ayKGV686BzmPzN7btN+LF6TX6U1ckWDUjUGhdUNbjB8NKN9UQXsmkmncDjJbcERnvYXDwFl+OSrY9Cv+nzGxqlsGiM9/5xVqTOah4RL06LS/nwAUxeRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9gKZFbdEQsrXFZgkeQpf+Yf2wWxn2nvbRtTsxo+41I=;
 b=ESiwUWo2ZTVCh3M0kJmzDZB7zu7f451n4XsDJiI+98slXBi/DQOAKeQ0Y0HsSIv6lL7NJgy0iOBQJDa40hxGNcHWKzTGNFELsppx1DP422+Ppcu1HK0q035HfLIOEaH/Hkal096vYd9iNDzbbfNs1bOuEsOgn/USbo8WVEN9uQM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB8241.namprd12.prod.outlook.com (2603:10b6:930:76::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 15:25:14 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%4]) with mapi id 15.20.6907.022; Wed, 25 Oct 2023
 15:25:13 +0000
Message-ID: <af4a9f50-1c91-4f65-b0b8-1c5ae4a57637@amd.com>
Date:   Wed, 25 Oct 2023 10:25:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: PIC probing code from e179f6914152 failing
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>, kys@microsoft.com,
        hpa@linux.intel.com, dlazar@gmail.com
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <c8d43894-7e66-4a01-88fc-10708dc53b6b@amd.com>
 <878r7z4kb4.ffs@tglx> <e79dea49-0c07-4ca2-b359-97dd1bc579c8@amd.com>
 <87ttqhcotn.ffs@tglx> <87v8avawe0.ffs@tglx>
 <32bcaa8a-0413-4aa4-97a0-189830da8654@amd.com>
In-Reply-To: <32bcaa8a-0413-4aa4-97a0-189830da8654@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR07CA0055.namprd07.prod.outlook.com
 (2603:10b6:5:74::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY8PR12MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: 0161c9f7-89b9-4472-7cf1-08dbd56e95a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OA/0wjB3cPRnRkl1HjzZQK9a3kN/q+rCURIrt6s38ovhRyEUG5QuMBq8MgvGKNmrEd1IyBtNt4gdWycaO8UJrn0WP2x2XZriFEVtwThokvSbbUAmzP9maPEky9ouCsfeOZO3u1lRt186KqOipRilY04/hL24Vrgs2NCrDfB7QzJfSjHdZgbJAwvIENeV1n9QV9RgW4q8USoz3H6x7vuH2962ixXfDaYw8UBFTsqOo31N56A0WsfsIHEW6WdNutdVJ5O74nsx4BtM0TFeVkiyC39hMzqlFUZkiGRpJKzuoyP0d/evhdrO5yqxQY7eUkliKNIgBivBfNKmOnS2xErwjxrdMvPdEhqC9eEy78ZTaTAwC4TD6m/T3TB0H5Pq3Qdaoayviue161GqrwMj8ujBnz2aAH4s2AXERw1FKr51cxZUapMOytmhaxVDFEEvuD5F7A72V/EsLV9v7CaRBlItlf5nL1iXroNQ23u0Ecpz3MMuC7rojYWfJhi0YgYmeVPznfih+ZfGjB99nRqDx5B0gA0geLN6i9TvQOCqRpCDiC8pF2DWyiQJGUUg8TelJva3zWVywYUbd64yST12M2pZiXjZOp7J2D9nvBvkNivqid3CXRiE634Hg+kz+qi+yrpHnIaBKNXNEgswNMVsxAb3Iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(396003)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(83380400001)(53546011)(6506007)(6512007)(6486002)(966005)(26005)(478600001)(316002)(110136005)(54906003)(66946007)(66476007)(66556008)(38100700002)(86362001)(31686004)(2616005)(36756003)(31696002)(4326008)(8936002)(41300700001)(8676002)(44832011)(2906002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THJQTXNmemtNdGtXWXpPNjdlSVZsTUl2cVh3WE9aMmN5Rk53cmVYbEZEaGFY?=
 =?utf-8?B?WnNLeGJKZFlLdUU0cjNtOVY1YTErZGZCNWV4dDlHMGUzVm1Kdy81NnBhclMr?=
 =?utf-8?B?czhINEpjMkNYTGxBd0F4NWJnUkdGK2pBMC9QaWxUSko3WVpGMWpGQTNack5P?=
 =?utf-8?B?Qkc1SmFrL0R6dExCbHFCbjZwWXhWVVgwSEUzMVRXbE9yTWtYMW5wZmRSSE81?=
 =?utf-8?B?SVlGcnVxN0dJU2Ria09uVWJiU3QzZFEyaCtpYU1PVXVUVGNzQlduR0hHT2Q4?=
 =?utf-8?B?YUN1d2M3SGhWK2VQL2dPSDVLdkFmRjJQR3FKK0QyZ2dBVHVzTlllVTlEL0hM?=
 =?utf-8?B?UUhiYU14aVFkSGMwZGVwZHBNWDQ2UmhJMm4rcFU0NHVrTlJkMXE3MEV0QmNU?=
 =?utf-8?B?cXFaYWF6TGg0amhqbXB5VUJ6ZlpTRDdENW9sS05PZjYyc1I4dFNldU85Mlda?=
 =?utf-8?B?ZW44amlPRG8weGdIR2lwZzQzVTRLeXoxZW5pWjNGYy9MWUg1TThzellYaml4?=
 =?utf-8?B?VUdnMXdxUDJEenpYYnFTWFMvdkFNcU1ISkdwdS9ETGdwWGF4c1JhaE14cGJh?=
 =?utf-8?B?b0szVWh4UlZXbnY0L1JacEdtUGhyTmJlS0ZsdzRwdWhPanVBQ0tKblpWTWVK?=
 =?utf-8?B?am1xai9jYkNHc2NRK2x3Ui8zWWNXeVh2ZWtGQmdpZDFqbGt6WHgvdG03TmJl?=
 =?utf-8?B?RVRkTFlqdlNDKzEwQkJoMnNSM3NIa3YrWDJPMlRsMEJVV3FPUkZJc0xlRnVD?=
 =?utf-8?B?MEg3dXU2YXQyTlloMC9WT3FtOVh1bFZodzZYczFTYWYxYUU1MkY1MDlyRjF1?=
 =?utf-8?B?L29sN1JUZElaYjJzWnlsWXlQRmZEOXgrcjQydnZWci8yVitXclhrVllxTmNs?=
 =?utf-8?B?WjBPcTRjcHZLRVlmMVp0RTdjbmh3V3dadXhpWFBSV28ya2MxZTUrcDE5dkps?=
 =?utf-8?B?OXZtV3hOcDIwNHhrWXVYcXIvbC95dVdCRjdja0s0SGpaV1FGWm9vUzlCQVBt?=
 =?utf-8?B?RE1qSmpiVlZmYWpIZWFXS0xLdmczT0U1d1NmMUQvMkFERGd2d0lsaEYrN2Z1?=
 =?utf-8?B?VnM1UFVGYktpdDdhb1hFbHBuaG5EZ05ZaFlHc2lNZ1k1Sm9XY3BvUVY2ZGw0?=
 =?utf-8?B?WGdlTWU2Q204bnprTjA0dHJ2MWZsTStqRXBNQm1Ga08rbzRQR2hoTTQvbWpy?=
 =?utf-8?B?M0hFMUtKK3c1ZlB6OW9MZG5Sb2hNMzBQNTlKRkdUMUM0b2pGMzhWU0hMTHk5?=
 =?utf-8?B?TnowaHBjdUVrL0xDVzEraXlUYzN6OHBnRmhMOE9JK290Wjlndm5iVWZYY3dS?=
 =?utf-8?B?ZHBJVjdYZ1pLbWZpRm91SFpwRGk5RzliU1BxZWhlWVp6T0cxOEhsK1N0S3Bu?=
 =?utf-8?B?OCs3d2p4YnRxMFdpU2JUNW0vc0lIVERoRnNoeVVvYzhNbStUbzl3Zyt4cC9I?=
 =?utf-8?B?Q3pDbUs0amtLSnpPQUczZlMzUVo1TjV3eDZORUJoV3dCOVo5b1M4YTErYXNB?=
 =?utf-8?B?alFJME1qdnI5bVEwV1FMSWxTa0pkTTIvTWRBQ2FOVEgrK1R3S2NsN3lObysr?=
 =?utf-8?B?ZkVFcjRKY2x4RzdrOCtHN1cwcGF4dU56MkhXYWhmNWY1eXAzVEpDU01Pemkw?=
 =?utf-8?B?TXIvcEkralJ1ZFBLaFNlREtKU3kzd2JRL0Nuc09rcHRHZjh4Y1dhVXp4dHl0?=
 =?utf-8?B?ODdLQXNOajhJNDRHM3N5dWMzRndIVXNJQXBsS0pJSEEvRitGRFNvM0xLdDVR?=
 =?utf-8?B?M0ZEY0ttS1k3VG1OR3ViK2JuZGdiN2k2UGhWNWpieTBvSW1rTHArei9tQ3E2?=
 =?utf-8?B?cUpLMG9lcnlzOFNsN1RvdE53dmxDYVFsRTNGdG5KVldJS2NTa2xVT25vdEJN?=
 =?utf-8?B?WEhOTUpqVmdpZkdwVnFnRjFCUkg2dU1VUytaQ0k2Y3g0Zlp1YjBXWjFDM3dj?=
 =?utf-8?B?QUFwdkd1RHlOQmMvNVhyVVBGZWUvTkh4ZU9WemdScGk1azJoeEZud3VRTWZy?=
 =?utf-8?B?NUliWWc1cHlaRDNJTURhT01BbGVnVVUvMjVsano4eWhSbXNoL0dSVFByTmwv?=
 =?utf-8?B?VkxCRGp2bHRZVk53R1JqeEUzSDVGeGRQUUZORElyZmQ4RXFRMzNnd2xzL1lW?=
 =?utf-8?Q?SFKe6BIDuaRlJKgYean/9rjfY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0161c9f7-89b9-4472-7cf1-08dbd56e95a0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 15:25:13.8989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yn5rrpukBoWmOsaqtFx1d5u+tDX3/E9XmA596bQiABfcq9pBTFZSuXzJmIVbLBbzBKUKj4D7vgTNS6IUZ4PDfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8241
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/2023 09:41, Mario Limonciello wrote:
> On 10/25/2023 04:23, Thomas Gleixner wrote:
>> On Mon, Oct 23 2023 at 17:59, Thomas Gleixner wrote:
>>> On Thu, Oct 19 2023 at 16:20, Mario Limonciello wrote:
>>>>    struct legacy_pic null_legacy_pic = {
>>>> -       .nr_legacy_irqs = 0,
>>>> +       .nr_legacy_irqs = 1,
>>>>           .chip = &dummy_irq_chip,
>>>>           .mask = legacy_pic_uint_noop,
>>>>           .unmask = legacy_pic_uint_noop,
>>>>
>>>> I think it's cleaner than changing all the places that use
>>>> nr_legacy_irqs().
>>>
>>> No. It's not cleaner. It's a hack and you still need to audit all places
>>> which depend on nr_legacy_irqs(). Also why '1'? You could as well use
>>> '16', no?
>>
>> So I sat down and did a thorough analysis of legacy PIC dependencies.
>>
>> Unfortunately this is an unholy mess and sprinkled all over the place,
>> so there is no trivial way to resolve this quickly. This needs a proper
>> overhaul to decouple the actual PIC driver selection from the fact that
>> the kernel runs on a i8259 equipped hardware and therefore needs to
>> honour the legacy PNP overrides etc.
>>
>> The probing itself is to stay in order to avoid sprinkling weird
>> conditions and NULL PIC selections all over the place.
>>
>> It could be argued that the probe function should try to initialize the
>> PIC, but that's overkill for scenarios where the PIC does not exist.
>>
>> Though it turns out that ACPI/MADT is helpful here because the MADT
>> header has a flags field which denotes in bit 0, whether the system has
>> a 8259 setup or not.
>>
>> This allows to override the probe for now until we actually resolved the
>> dependency problems in a clean way.
>>
>> Untested patch below.
> 
> +David from the bugzilla.
> 
> I checked his acpidump and I do think this will work for him.
> 
> [024h 0036   4]           Local Apic Address : FEE00000
> [028h 0040   4]        Flags (decoded below) : 00000001
>                           PC-AT Compatibility : 1
> 
> 
> David - can you see if the below helps your hardware?

FYI, David confirmed this works for fixing his hardware, thanks.

https://bugzilla.kernel.org/show_bug.cgi?id=218003#c84

> 
>>
>> Thanks,
>>
>>          tglx
>> ---
>> --- a/arch/x86/include/asm/i8259.h
>> +++ b/arch/x86/include/asm/i8259.h
>> @@ -69,6 +69,8 @@ struct legacy_pic {
>>       void (*make_irq)(unsigned int irq);
>>   };
>> +void legacy_pic_pcat_compat(void);
>> +
>>   extern struct legacy_pic *legacy_pic;
>>   extern struct legacy_pic null_legacy_pic;
>> --- a/arch/x86/kernel/acpi/boot.c
>> +++ b/arch/x86/kernel/acpi/boot.c
>> @@ -148,6 +148,9 @@ static int __init acpi_parse_madt(struct
>>           pr_debug("Local APIC address 0x%08x\n", madt->address);
>>       }
>> +    if (madt->flags & ACPI_MADT_PCAT_COMPAT)
>> +        legacy_pic_pcat_compat();
>> +
>>       /* ACPI 6.3 and newer support the online capable bit. */
>>       if (acpi_gbl_FADT.header.revision > 6 ||
>>           (acpi_gbl_FADT.header.revision == 6 &&
>> --- a/arch/x86/kernel/i8259.c
>> +++ b/arch/x86/kernel/i8259.c
>> @@ -32,6 +32,7 @@
>>    */
>>   static void init_8259A(int auto_eoi);
>> +static bool pcat_compat __ro_after_init;
>>   static int i8259A_auto_eoi;
>>   DEFINE_RAW_SPINLOCK(i8259A_lock);
>> @@ -299,15 +300,32 @@ static void unmask_8259A(void)
>>   static int probe_8259A(void)
>>   {
>> +    unsigned char new_val, probe_val = ~(1 << PIC_CASCADE_IR);
>>       unsigned long flags;
>> -    unsigned char probe_val = ~(1 << PIC_CASCADE_IR);
>> -    unsigned char new_val;
>> +
>> +    /*
>> +     * If MADT has the PCAT_COMPAT flag set, then do not bother probing
>> +     * for the PIC. Some BIOSes leave the PIC uninitialized and probing
>> +     * fails.
>> +     *
>> +     * Right now this causes problems as quite some code depends on
>> +     * nr_legacy_irqs() > 0 or has_legacy_pic() == true. This is silly
>> +     * when the system has an IO/APIC because then PIC is not required
>> +     * at all, except for really old machines where the timer interrupt
>> +     * must be routed through the PIC. So just pretend that the PIC is
>> +     * there and let legacy_pic->init() initialize it for nothing.
>> +     *
>> +     * Alternatively this could just try to initialize the PIC and
>> +     * repeat the probe, but for cases where there is no PIC that's
>> +     * just pointless.
>> +     */
>> +    if (pcat_compat)
>> +        return nr_legacy_irqs();
>> +
>>       /*
>> -     * Check to see if we have a PIC.
>> -     * Mask all except the cascade and read
>> -     * back the value we just wrote. If we don't
>> -     * have a PIC, we will read 0xff as opposed to the
>> -     * value we wrote.
>> +     * Check to see if we have a PIC.  Mask all except the cascade and
>> +     * read back the value we just wrote. If we don't have a PIC, we
>> +     * will read 0xff as opposed to the value we wrote.
>>        */
>>       raw_spin_lock_irqsave(&i8259A_lock, flags);
>> @@ -429,5 +447,9 @@ static int __init i8259A_init_ops(void)
>>       return 0;
>>   }
>> -
>>   device_initcall(i8259A_init_ops);
>> +
>> +void __init legacy_pic_pcat_compat(void)
>> +{
>> +    pcat_compat = true;
>> +}
>>
> 

