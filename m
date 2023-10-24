Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABA97D59C6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 19:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344082AbjJXRbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 13:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbjJXRaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 13:30:52 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D2110D9;
        Tue, 24 Oct 2023 10:30:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnhIfy1XBzb3P5Nb1OfsSV/UQrbreoTST65555U9xhnCSW+Bp2VKyJcPvOvTuc+fbx+jF19GUzHmNBLTDdquPgpDwrM1Go1vktY0HEq7Q0wGePxpMoahpLIunVrw0kV6bywqMVO5dq9miVqsPR+Xhrn2pWJgLdbxBtBG4/aXKllrgmpoZE5BQsqWU2XoNvUPUrGUugoUjOWoAqr3BEpBdIOBMlyPWAswF6VpzBVGUeTzZ71fXcHILfw/xyiVINHjcVBTPr9REWFBVvqmTaAwUh1/6wlJ3e2hlGectA6hXX7rvH2QPZvCbhGPgnvKufz4ONzMtA6gNLyU+4l/dupH7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAfTneH1g2W9YCD5Tg3joRlMaCEPvaqAwGKpiPOizRk=;
 b=CNxQXy/q1xK+TzNEtzj1MPjb+Wx4eF9pj21l15xzPNuYkmijhGx4BKtpGc2f/Nu6oSFJ2b0TgXdNZC/Q5kQenq3VkBnKw/Qq8f1ZTBvK/Z7u/uq9xtDAZKhAf4QwLNlKE6t6nmJ6p8uivBzNklVUikBlEy4BIlrIlwcji8sn/HsY9YroEtRqMizm0wzWtVjRBm1hb2U4VdmrBsymmu6uq/8IZVPO//eM5yj2RbJcVNFlDoCPC2vm4pxDKnDi2NF3XpUAZsL7fHC/Lg359FtitTMoyKNPXdcLKid2Pw7LFyYRni5aLljCVL7tW4wvUphN/QYA3nhfNfmgkhkUPUwBPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAfTneH1g2W9YCD5Tg3joRlMaCEPvaqAwGKpiPOizRk=;
 b=BZoxe9X6H6wdd4WKEoE0rpS40xEHp1vjOhk7AWGHy6pBfKB4zxZH84FDx2NJuHuuavknfk6EwVJfOA/8V5LJDZAzL6SCG7Zru6kuD/Vo4jzrCCawen3L2Dnt6l8nJrrWB7NpWp/MsnfOJ/0azdajw6owp5pOC2EZCOfwIIApQuY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by SJ0PR12MB6878.namprd12.prod.outlook.com (2603:10b6:a03:483::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Tue, 24 Oct
 2023 17:30:47 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::e16e:d7f1:94ad:3021]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::e16e:d7f1:94ad:3021%7]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 17:30:47 +0000
Message-ID: <3e3ca8c6-d336-d675-fc07-6e4fdcd273a1@amd.com>
Date:   Tue, 24 Oct 2023 12:30:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] x86: Enable x2apic during resume from suspend if used
 previously
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org, rafael@kernel.org,
        pavel@ucw.cz, linux-perf-users@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20231023160018.164054-1-mario.limonciello@amd.com>
 <20231023160018.164054-2-mario.limonciello@amd.com>
 <ZTeB9K4NYu1sRiZ1@gmail.com> <6894bebf-15ed-4bd2-aebc-f4ac0a30a395@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <6894bebf-15ed-4bd2-aebc-f4ac0a30a395@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::15) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|SJ0PR12MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a3a7227-e31f-4dee-4b51-08dbd4b6f577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p4T4ktfdgNL2QE4s+C+b66MysisyehSWuX9ED7qTy+DrEi5tkrvMzMLhKwLZvL0zcBMJR8iPE0+4McauHNNWpurbFE3fw9ZSZN689BioX3rYS4JkhnvQOHQfAGylKF4NmezVdc5cQ0L0HbEJKi/nuknhxBSJaSZZyKPH/mCF1da3TRqw/kWNn8LW0TL0OvkSqKIyT24xNQHQkz31p38SacJ8QSxpsocFxbJ8Ep1LgVsZuxHEKvb6e/GRt2JUWMSdsDR5f4rNTvBmqKDJfPJx4BPPaRoOFlQ5pB37CLKrKMsek7i53NCA204nL3CAtWlraOxKvPQxq3EBUAq9OI+rSln39T1pP207mQLVQZrwwMr59MNpFUzXXrjmv0GnqwYF7S+JJGGRk/V25o1f8BfoXR0QKPkeFPjsg/kLIxcRx7o+HMwwTyCgOs1Wiwa9AYzXuRJpVg05mbAmuof1CAdGS+mUIkpthXuHfJo3jC2G7/3XR4486a90v1aZNuhrdxsVGWBEfROkMXKZxFU6/LlbUdxibI5/uPhF8LSS68yq+7UF2RSeO/QJyaxL7RSgJzmLdjyEGeECdzSmPdTys2zKvt2hHLMyA+e2pbWk3ioeHyQ0z5KoPNaPB142QifGLDrSb6B8S+q5Hls4Rt1TfNcjdTtp0nBW1vj6ZlaMURWx9co=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(316002)(2616005)(6486002)(26005)(15650500001)(6506007)(2906002)(6512007)(5660300002)(8676002)(66946007)(83380400001)(4326008)(41300700001)(478600001)(54906003)(8936002)(7416002)(31696002)(66476007)(110136005)(66556008)(38100700002)(86362001)(6666004)(31686004)(53546011)(36756003)(87944015)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXJ0cWRmaU45Y1NlMXh5OTlKMDRxZksxUG1YWVpETHFuRStZNmVrRlllcHlk?=
 =?utf-8?B?QWh6VEFOQlNyMHpqTDN4TTk2aXdxTFNNdjZiUEtJV0dTWkNpNVU1RHRKZWJJ?=
 =?utf-8?B?N2UyVXBEckV0SGNUbENXWXhJRXVaQVRJRkkyYTRFamRBdFFDMmFmdEVrNW5V?=
 =?utf-8?B?dFhLQnRqSUF6am54Y0ZHcVRZL0ovZ0hsc2I4aTFTb0pEVzhUTTBUZ2RnR2w0?=
 =?utf-8?B?M0tjVzdVcWpma1NzTUtSVlNGZkNRZFlMY1J4RVZxa3dHTXpYdk56K1FVOElL?=
 =?utf-8?B?eVpOQ3crQklsUnVxT2I4NEdNcTQwTUFXYU9CV0NhdEl5eGJ3eGZsOVdJTGNO?=
 =?utf-8?B?R2NLMmtWMTNpRjJtZEVPY01RTkJUSmpzZVYwYXBNOWJwWUsrYStxWlN0VjQz?=
 =?utf-8?B?RTd3MTNRR0tJWHg1VXZabEFJZWlGTnU0U2FUNXQyejBZTER1ZWN0Rnc5SDBm?=
 =?utf-8?B?SUVIdFJYa240TkdTeVVmb2RGYnI0VmhRTE9TWVoyWm54ckpDU0R2S2s5Nm9O?=
 =?utf-8?B?Z2M2MEhEYlRJQTFxTzN1QzVXdGxOT29QTHJnTDhTcGF2dHVoenlMUzExdW5z?=
 =?utf-8?B?a1hlZ2pTZVFaVGdSdDB3RXRrQzhIQWZpeUhKSEt5S0RXU3MveXNxd1VDWGsy?=
 =?utf-8?B?ZWZhMklPdE51UkxSMTRlcWpHSVkwaHdiNnpOV1NZcDFNWmMyOHdsQXBIdnc3?=
 =?utf-8?B?cHRtUnV6R1BCZWw3M21CYmQ1Ui9HYUxubE5KeXNlNEViUHJBYWdBaE1QNjlv?=
 =?utf-8?B?ZEllUFJHU1lubEFBYjZxWkNBOStXckYrYUdzU1M3ZExMNitvcy9iRlE5NmV2?=
 =?utf-8?B?VnJNL0oxa0c5cVpOeEhpckNVejYzOS9rNFFsejNBUG4wMmJQZEdJV1N5ckx1?=
 =?utf-8?B?YmVIL1FIenV2bmVkVXNUWit1Sm9ROWcxQld1bDQxOWUvWnVNYTA1QWtWaHND?=
 =?utf-8?B?ZytmeCt3OVplWVRCdzhrdFQyUFZPbWZpajNLRlVreVBNbENjeE1YTXg2ZXBa?=
 =?utf-8?B?MlovUk1RYW9FZHB3dnF5WVhvRnRKdmgwZ3Bpeis1RkxHUzZabThSWE9wNmxu?=
 =?utf-8?B?cEg0Y1ZlVFhSMHJnYklnclZGaGh5Nm5MZnQxVzRFQzNTOUNhcHFxOU5YMEo5?=
 =?utf-8?B?ZlpNdkIwUXh5TTFhQWlZZ3Zhd3dFaWRtYVN1SVp3NEtUVi9TY3hDWHBITjFS?=
 =?utf-8?B?dUhBUUkzYWpFYWJRQnRtYVV3ODR1VU44cmRHMDNBU0FHaGFjS2hVYjk4Zjdt?=
 =?utf-8?B?SkZROXdoMktCWDd6WFVpTDgwQTJieVM4djl1bS9nVGhqcmdsd3hGU0IrYlhQ?=
 =?utf-8?B?Rmw2UTZmSjVrL1NqVHJLZnZsNGhwNjZJUWZQRkZ4Z1d4cVE4REtMckpvOGFR?=
 =?utf-8?B?VHhOQjloQXdrN3dEZytZNy9BaDhZNVFOZVpWWFdFdysxYXpXUWhBMmt4YzhI?=
 =?utf-8?B?bGROVGdNTWg2NGFvQy9OdWc3bktsMGRBQm5CMGJJMHVQQVhZY0VDQ3FJT3VT?=
 =?utf-8?B?ci9MejNwT2hDSFEzaW5leU54YThWUStMYmMvQ2l5dnd2RHNHcHNlbVNMbTY4?=
 =?utf-8?B?SkdyZ29Ed1d6SlQzemdLakVhMkxLYWg1L3Vva3JXQVdxeFRoK1J0TWU3NmdG?=
 =?utf-8?B?N3Z0K1lhQUlaS1Jxdkc0U0xreTdvOEsreE9OQlVLYVl2SURxZmZrRTBmaTNz?=
 =?utf-8?B?dGRIWHAvNzVFUHdBejZDdk5LL1U4K21PZmU3NTlvOTJIUi9FOFVVbUFibXpt?=
 =?utf-8?B?dTFMN3V2T1Q4SERtY01BazY1QVFIQWVDbDZiNm9TdUNTQnBreTgwNmNzdnV1?=
 =?utf-8?B?VGh1Mms4WEdLTE5VWXVJZzNTY25LVk40SVFRZGFUN2tqejZuVHFUVFdTcmk3?=
 =?utf-8?B?OUF0QUp1QnllMVBIMkpwZ2RneUk1RHR1VUIvZGFGSE9oNktidmRzQzJPdFJa?=
 =?utf-8?B?bDZrVU9wTHZCYTYzSlV2SSt5aEhyUjVZSTM5Z0NYN2xEZERORHRLVWRTYThj?=
 =?utf-8?B?VlVCT2gvaWpEUmZIMEhpODRaTjJPYkN6TUZzcGJNaWVUOFlFWU9DVnZFc1ox?=
 =?utf-8?B?emdlUnZ2TzFQQ3NXZ1J4WWxYQkpYYWM4SXdxTnlGYTZheHU5bW9xeG9UV25X?=
 =?utf-8?Q?IUY178KQN8NUJRkPVUKBheJiD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3a7227-e31f-4dee-4b51-08dbd4b6f577
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 17:30:47.2087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFpnNZ/H1ZmLYfMhXPwTekYXnXbGm2drJaVGVkyo05FqAN1cY+/kCFvjOvelNVc1bJo6l/qvb/ywmonh8MA/Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6878
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/23 10:36, Mario Limonciello wrote:
> +Tom
> 
> On 10/24/2023 03:36, Ingo Molnar wrote:
>>
>> * Mario Limonciello <mario.limonciello@amd.com> wrote:
>>
>>> If x2apic was enabled during boot with parallel startup
>>> it will be needed during resume from suspend to ram as well.
>>>
>>> Store whether to enable into the smpboot_control global variable
>>> and during startup re-enable it if necessary.
>>>
>>> Cc: stable@vger.kernel.org # 6.5+
>>> Fixes: 0c7ffa32dbd6 ("x86/smpboot/64: Implement 
>>> arch_cpuhp_init_parallel_bringup() and enable it")
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>   arch/x86/include/asm/smp.h   |  1 +
>>>   arch/x86/kernel/acpi/sleep.c | 12 ++++++++----
>>>   arch/x86/kernel/head_64.S    | 15 +++++++++++++++
>>>   3 files changed, 24 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
>>> index c31c633419fe..86584ffaebc3 100644
>>> --- a/arch/x86/include/asm/smp.h
>>> +++ b/arch/x86/include/asm/smp.h
>>> @@ -190,6 +190,7 @@ extern unsigned long apic_mmio_base;
>>>   #endif /* !__ASSEMBLY__ */
>>>   /* Control bits for startup_64 */
>>> +#define STARTUP_ENABLE_X2APIC    0x40000000
>>>   #define STARTUP_READ_APICID    0x80000000
>>>   /* Top 8 bits are reserved for control */
>>> diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
>>> index 6dfecb27b846..29734a1299f6 100644
>>> --- a/arch/x86/kernel/acpi/sleep.c
>>> +++ b/arch/x86/kernel/acpi/sleep.c
>>> @@ -11,6 +11,7 @@
>>>   #include <linux/dmi.h>
>>>   #include <linux/cpumask.h>
>>>   #include <linux/pgtable.h>
>>> +#include <asm/apic.h>
>>>   #include <asm/segment.h>
>>>   #include <asm/desc.h>
>>>   #include <asm/cacheflush.h>
>>> @@ -129,11 +130,14 @@ int x86_acpi_suspend_lowlevel(void)
>>>        */
>>>       current->thread.sp = (unsigned long)temp_stack + sizeof(temp_stack);
>>>       /*
>>> -     * Ensure the CPU knows which one it is when it comes back, if
>>> -     * it isn't in parallel mode and expected to work that out for
>>> -     * itself.
>>> +     * Ensure x2apic is re-enabled if necessary and the CPU knows which
>>> +     * one it is when it comes back, if it isn't in parallel mode and
>>> +     * expected to work that out for itself.
>>>        */
>>> -    if (!(smpboot_control & STARTUP_PARALLEL_MASK))
>>> +    if (smpboot_control & STARTUP_PARALLEL_MASK) {
>>> +        if (x2apic_enabled())
>>> +            smpboot_control |= STARTUP_ENABLE_X2APIC;
>>> +    } else
>>>           smpboot_control = smp_processor_id();
>>
>> Yeah, so instead of adding further kludges to the 'parallel bringup is
>> possible' code path, which is arguably a functional feature that shouldn't
>> have hardware-management coupled to it, would it be possible to fix
>> parallel bringup to AMD-SEV systems, so that this code path isn't a
>> quirk-dependent "parallel boot" codepath, but simply the "x86 SMP boot
>> codepath", where all SMP x86 systems do a parallel bootup?
>>
>> The original commit by Thomas says:
>>
>>    0c7ffa32dbd6 ("x86/smpboot/64: Implement 
>> arch_cpuhp_init_parallel_bringup() and enable it")
>>
>>    | Unfortunately there is no RDMSR GHCB protocol at the moment, so 
>> enabling
>>    | AMD-SEV guests for parallel startup needs some more thought.
>>
>> But that was half a year ago, isn't there RDMSR GHCB access code 
>> available now?

That support requires an update to the GHCB specification to add 
RDMSR/WRMSR access to the GHCB MSR protocol, which hasn't been written, 
yet. The support would have to be present in both the hypervisor and the 
guest.

Thanks,
Tom

>>
>> This code would all read a lot more natural if it was the regular x86 SMP
>> bootup path - which it is 'almost' today already, modulo quirk.
>>
>> Obviously coupling functional features with hardware quirks is fragile, for
>> example your patch extending x86 SMP parallel bringup doesn't extend the
>> AMD-SEV case, which may or may not matter in practice.
>>
>> So, if it's possible, it would be nice to fix AMD-SEV systems as well and
>> remove this artificial coupling.
> 
> It probably isn't clear since I didn't mention it in the commit message, 
> but this is not a system that supports AMD-SEV.  This is a workstation 
> that supports x2apic.  I'll clarify that for V2.
> 
> I've looped Tom in to comment whether it's possible to improve AMD-SEV as 
> well.
> 
>>
>> Also, side note #1: curly braces should be balanced.
>>
>>>   #endif
>>>       initial_code = (unsigned long)wakeup_long64;
>>> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
>>> index ea6995920b7a..fcfa79105928 100644
>>> --- a/arch/x86/kernel/head_64.S
>>> +++ b/arch/x86/kernel/head_64.S
>>> @@ -236,10 +236,15 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, 
>>> SYM_L_GLOBAL)
>>>        * used to look up the CPU number.  For booting a single CPU, the
>>>        * CPU number is encoded in smpboot_control.
>>>        *
>>> +     * Bit 30    STARTUP_ENABLE_X2APIC (Enable X2APIC mode)
>>>        * Bit 31    STARTUP_READ_APICID (Read APICID from APIC)
>>>        * Bit 0-23    CPU# if STARTUP_xx flags are not set
>>
>> Side note #2: you mixed up the comment ordering here.
>>
>> Thanks,
>>
>>     Ingo
> 
> Sure, thanks for the feedback.  I'll adjust the style for v2.
> 
> 
