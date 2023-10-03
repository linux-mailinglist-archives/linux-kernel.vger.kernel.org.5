Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB797B74C5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbjJCXW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbjJCXW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:22:27 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA17A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:22:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8qNmidYn60AxvLskiR8A1djnFlivP9hVaR7iGQ4xbB24Pd6zYkB14PIhiDYFWISrmRSszAF2PraXzw+gLtahde6QlRGrLA89TziTWjYfFJ0y5YpcRTPJVC/Wafsx/sDAdI8x6GPC5QcQ+4IU5ve2nFw5Rm4LzfrbLWg4kLTbrjR+Oaop8Bq4LWmWXV1I3EC5HhS8ZR9ZN1uWeu0mRF1uBnXDgCXKMKOwQgn4ROaMyaK7TJAdwDDDHfntFhJ4k20HNYtSXgDG56054T+eyXLE83aLe5FwbWJOFwwmmrNYlYC3QnmiIvLCDajqBZRCVyJxeU2dmC1p86Woe6FXxv6HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KNbUUDxEDohvpCxVTYiH8wiGbABALyQC+qp7Tc2w5s=;
 b=dbdvGyz90aY8Y68CdMbkaofqzadh+ZJMxr3uBcsA2Nt9Cb5o6OdQubO5Wppmp8EVgaKnJBaKfRWrwNKCuJRAPxgJ8rdS7FUh8UU+O7o1n4GZqP9S5CqpbpsVYruMQl97HIMaoxd1jF3cOCbasegVfNiqt5CN9H57OGsudDIQ/kJmfZlIKGwJ36PqbcKWJ+nO5xnLtKuZrP3cWQhvt7Ri0xnldYAWCvgjwUFdKWdlm7Q2btkYZbPUHCCLF/H2xSyD53vczItjjMSfZmv/wOR9j4LmZIFU25d2+Uor9iQZGNK0KrQ0TF3TzgHuAQRkxIIaWeGDaGJW7oTmXh96TaLqWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KNbUUDxEDohvpCxVTYiH8wiGbABALyQC+qp7Tc2w5s=;
 b=d2pNcmDYc5n35p9zWNUyFBWh2qaslk2VlDO/3yNQTzjYFdL3CF0jMkYCkx/lusq65Z7Fl7R+jmYoBIfGdESoaOy1h1Qy4uuACX3GM+5wD7nyU6xNEHSCfgsD5G6sfisr3JYviO4LJXNyTfySMODjGyQ3o0cU0NTTZomQoPJSLKE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SA1PR12MB6972.namprd12.prod.outlook.com (2603:10b6:806:24f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Tue, 3 Oct
 2023 23:22:17 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::16da:8b28:d454:ad5a]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::16da:8b28:d454:ad5a%3]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 23:22:17 +0000
Message-ID: <14619d42-b319-4b5c-9363-c75096d27584@amd.com>
Date:   Wed, 4 Oct 2023 10:22:09 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kernel v3] x86/compressed/64: reduce #VC nesting for
 intercepted CPUID for SEV-SNP guest
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>
References: <20231003073123.1763564-1-aik@amd.com>
 <32c0080f-1bd1-32c4-2bfa-910537a50ca8@amd.com>
From:   Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <32c0080f-1bd1-32c4-2bfa-910537a50ca8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR14CA0048.namprd14.prod.outlook.com
 (2603:10b6:5:18f::25) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SA1PR12MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: ad81e49c-cab2-4afe-4e79-08dbc467957b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r3tBMA6yWMnem5wrB9xaJI8zxsX8ydZJYvbFlOmuSzoaXIXMEVHB2mhljNK9VA5jfwKW3j++t0QAdkfxqjPuJUL/87NWTtNjCMrFmHsCquPIvGq+Bm5WHO2bIZnVOjFg6Kgg9s1fnqkuC7eTnNo/fYuLxIqExuW+S8qNgOXphSBhmE4XbihTBBfXDxRsp7rIE1cEz1lBya7X/G7MkMoOi440I9cpnpj2A0k5+bf46mJE2V+8Uoty5niqimqdznxhgRKvUb2PQnev1DrtGF/W+LvqTPgoiLgOY+m8G1I7z2gQwZt4ihpgKyh8anQK7SXVjr1SW+r8TiyKL/cUTDxJL5PSt35TwDHWGaMrVzxHMrqAaEZYinmWJO0OSYUbTfB125o5mW5wYDPWWcc2IjUewj0Kr6jOTWVj0U6TXRvJU39huMslbhrRBRpSF3N1vfG72el6LwJ5ezt1ZA9V8GCypGk1Q+x4ZeF2HZIk9TyDy7QDZ1h5wnT/7Om7IVG11KqmFFm6MGaOu7C4oZn6A4WjiIP9kiQEWu0gbFHn4bZbY8px/IfS5QEo84FDdpLbV7qcE+1t/PdG7+ZnvSmCeZi4r05XbKWH6uh2Q+25cBWfHKS8UIUG4VCYFPYNuSjbWC9E82Mhtu0C0OQMG3M9kCHIaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(366004)(346002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(2616005)(26005)(6512007)(54906003)(53546011)(66946007)(66556008)(66476007)(316002)(8676002)(8936002)(4326008)(41300700001)(38100700002)(6506007)(6486002)(6666004)(478600001)(966005)(83380400001)(31686004)(2906002)(31696002)(36756003)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b01Cb1hKWC9TOVdwQVVFaEg4M1RVMHh1YUVud2orQmlLbXNROHBOVW1GVzF1?=
 =?utf-8?B?UVJ1YlBBdlM1UDRERFJmZC95MndjRlVvNjVSUGxFMmFJVitHN3ljYWZjZll5?=
 =?utf-8?B?NFQxZmJoTHpBT3VSSjRpYnlSSER6d3hpdUlrTjJHWnlSSjFkajY3SlkvRlI2?=
 =?utf-8?B?M0pHZXhRQ0JuNytDaEIzUzQ3SUVoMnVub3hFNENMZzVHVU4vY1N4cWZZcE8w?=
 =?utf-8?B?c3Fnb0RvdldzZ2I4dXpRZWJFUTBFZzhQaG8za2lLL1U1cml3bEk3amJNQ0FB?=
 =?utf-8?B?bDBQM2prc1I3cHYvZlU2ZzBsTjJ4S2xrd0RheVhTSHphbFlGa3IxVm5YWDhk?=
 =?utf-8?B?MkZscjNDUFUvWGpVZVVEL2J3WUx2a3IyV1lWL0drTVViTk9jRFEvU29Rczd6?=
 =?utf-8?B?NHcvTU03YTJGU2kyVFNmTk1LL2RqN0JqZUVFbmlYZzdQVUZGSktXamNKUjJm?=
 =?utf-8?B?ZWVJblVlVTdGVjU1OXcrRlZOS1RDN01YOEU2NVErRTM0U2oyVjFRZHZ3RjVS?=
 =?utf-8?B?NXV1WUVzSzlDY042QjZnMlhVbGtuOVRxMWpVendRWFdRM2JrOUtJZmdzM1Z0?=
 =?utf-8?B?UVNNK2NORk5VVHVjSkdjNFBEc0V4ckJIMnpFNURtK1BydTNiSFdPbXBSeVZw?=
 =?utf-8?B?Zk5QMkVScGRjRWZ6ZzVlMGFadXQ4UWdsam10Vkg3SnR6elZOTEZQdHBud1hR?=
 =?utf-8?B?cUt1MXpOYTcwWjNPQ2VRTzEzN2FLUmJieC9MLzQxSm50NWxERTI5eWY2STNE?=
 =?utf-8?B?Tkc5NnE1ZWgvTjk0eCtVZ2ZzV244MklQQXgxZVQycmpSTk1ZQnpyYnI5RHhW?=
 =?utf-8?B?NzFscGg3WG16ZXNKT3p0cHovdVFVd3AyOW93TG9hMlFNdUZKQUI1M0tTWGVI?=
 =?utf-8?B?TFJTdlhVVG5ZRGR5Q2FxY2haNmswQXRVL2J2K3Z1UFpsUUxSelBsUzRVcjVN?=
 =?utf-8?B?aFF2c0lhb2ZWbmd5SWJZL3B0M2p3QnEyb0NIK1pEd0lDTHorTlhTWDlrZHJC?=
 =?utf-8?B?ZFBnSGM0U1NXUEx0dnFYUCtaRjNQN1RJZlBkRVpvcndzSXNhS2VaY3g4ekRU?=
 =?utf-8?B?WCtzTVpYN0hhd0ZXU3BJcXd5Mm1aTXhiOGVyYnljRCtqS3FpUy9jcjVsRXJX?=
 =?utf-8?B?NDBBYXZqcCs4ckRQTXJHNEwxRlJVcThLRkZNMzU5dFVmRmJobnRIekhzeFdp?=
 =?utf-8?B?ZVhaYWZoR3M2R3V6RWk3ZUR2QW5hWWZGaWJoa3IrS1RJNGZRVHVJNXhKS3Av?=
 =?utf-8?B?NnBSNmtKekNxMzQrWVpOcUJBNEVFOSt3clhENHpNUXg0Wk01ZUtHZ09KK1dF?=
 =?utf-8?B?alRwQmdqVjFEdXEvSEpkQy9lSThZamdjSkVSeVhBS3ByZEs0S3pyNGdzRE4y?=
 =?utf-8?B?NVd3b3hoMW10YmZkQlJqNUoxYm9HUW0wdjBLK2htdHRxVGkzUm93bmNOWGVN?=
 =?utf-8?B?c3Y3TE9uYlZKNzE2UytsZjlIMkFWMFhMdFNnQXl4NThmWC9Ha2d4SDF5UDRs?=
 =?utf-8?B?L0I2ZzNZbVNQcW8vbk5kYmJGOGZUWjFXSytnTjU5WlNzWlltS1ZWWi9VSlF2?=
 =?utf-8?B?WGpWSlhOWUhoT0NrQmp3anZRUktUMzJqZklER2tvclRLQzBpY25ENjZzTGpm?=
 =?utf-8?B?aUQ5T2lYRGpveWJCbkticDRvS3J5N3RXeGkyckJLNmxjTnorZmtSdFRDdTJm?=
 =?utf-8?B?NUxQdytNNHZGUVBwNHFHS0xJNjljNW9XekF0ZllTSWJSNnVyOENhQUxTOElt?=
 =?utf-8?B?eEVMdVFGK3dLVXoxNGhnTm83aklYU01iN2ZhQVUxYWdvOTE2eEtZKzFXWkFL?=
 =?utf-8?B?MFZhR1RiYkFKMVRYb0VEMDJtNEYxeVdVVWtBeHlYc3VqWEVJVkg3OGRlZDdL?=
 =?utf-8?B?R1JRa3VNZnE5OTRrVC9MQzlzZnl2WFF0VW9DdFRZUUR2a0dzOCtVbzQxL3dF?=
 =?utf-8?B?eUhuSnk5aEVkVDN6bHdydUN2aU5xZHl1YlFKRVJQZFo0c3hiLzBMYlVxNlBP?=
 =?utf-8?B?RXFMaEhoWlhVYi9EZjNwc1V5Nm9OaDBteSttQmp5K1pOU1N1VCtVZllvRTZU?=
 =?utf-8?B?cHAwbjRUUWRYZlQ3dkt4TkZCTGpSd2ZNTFRoSFB0VllBK3YvUzFXOWMyeDM2?=
 =?utf-8?Q?Nq9CDpeJ2OM4zw8ark68XUZcU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad81e49c-cab2-4afe-4e79-08dbc467957b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 23:22:17.3158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C24020Pq0lLG+P+EdyNGcxphBo68uOH4LQijXI3jx3AUWBu/RUVGpg6zjHREneKONRpqf6JvAFO62FOyEB4kMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6972
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/10/23 04:21, Tom Lendacky wrote:
> On 10/3/23 02:31, Alexey Kardashevskiy wrote:
>> For certain intercepts an SNP guest uses the GHCB protocol to talk to
>> the hypervisor from the #VC handler. The protocol requires a shared 
>> page so
>> there is one per vCPU. In case NMI arrives in a middle of #VC or the NMI
>> handler triggers a #VC, there is another "backup" GHCB page which stores
>> the content of the first one while SVM_VMGEXIT_NMI_COMPLETE is sent.
>> The vc_raw_handle_exception() handler manages main and backup GHCB pages
>> via __sev_get_ghcb/__sev_put_ghcb.
>>
>> This works fine for #VC and occasional NMIs but not so fine when the #VC
>> handler causes intercept + another #VC. If NMI arrives during
>> the second #VC, there are no more pages for SVM_VMGEXIT_NMI_COMPLETE.
>> The problem place is the #VC CPUID handler which reads an MSR which
>> triggers another #VC and if "perf" was running, panic happens:
>>
>> Kernel panic - not syncing: Unable to handle #VC exception! GHCB and 
>> Backup GHCB are already in use
>>
>> Add a helper similar to native_read_msr_safe() for making a direct 
>> hypercall
>> in the SEV-ES environment. Use the new helper instead of the raw 
>> "rdmsr" to
>> avoid the extra #VC event.
>>
>> Fixes: ee0bfa08a345 ("x86/compressed/64: Add support for SEV-SNP CPUID 
>> table in #VC handlers")
>> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
>> ---
>>
>> Based on:
>> https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=tip-x86-urgent
>> which top at the time was:
>> 62d5e970d022 "x86/sev: Change npages to unsigned long in 
>> snp_accept_memory()"
>>
>> ---
>> Changes:
>> v3:
>> * made it a function, mimic native_read_msr_safe() which 1) returns 
>> value 2) returns an error
>> * removed debug backtraces the commit log as these were added for 
>> debugging and never
>> appear with actual kernels
>>
>>
>> v2:
>> * de-uglify by defining rdmsr_safe_GHCB()
>> ---
>>   arch/x86/kernel/sev-shared.c | 27 +++++++++++++++++---
>>   1 file changed, 23 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
>> index dcf325b7b022..494d92a71986 100644
>> --- a/arch/x86/kernel/sev-shared.c
>> +++ b/arch/x86/kernel/sev-shared.c
>> @@ -241,6 +241,25 @@ static enum es_result sev_es_ghcb_hv_call(struct 
>> ghcb *ghcb,
>>       return verify_exception_info(ghcb, ctxt);
>>   }
>> +
>> +/* Paravirt SEV-ES rdmsr which avoids extra #VC event */
>> +static unsigned long long ghcb_prot_read_msr(unsigned int msr, struct 
>> ghcb *ghcb,
>> +                         struct es_em_ctxt *ctxt, int *err)
> 
> Alternatively you could return enum es_result and take xss as a 
> parameter... six of one, half dozen of another I guess.

How do we decide on this? :)

and yeah, I need to s/int/enum es_result/

>> +{
>> +    unsigned long long ret = 0;
>> +
>> +    ghcb_set_rcx(ghcb, msr);
>> +
>> +    *err = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_MSR, 0, 0);
>> +    if (*err == ES_OK)
>> +        ret = (ghcb->save.rdx << 32) | ghcb->save.rax;
> 
> You should check ghcb_rax_is_valid(ghcb) and ghcb_rdx_is_valid(ghcb) 
> before using the values.

Huh. v4 is coming then. Although what are the chances of *err == ES_OK 
and !ghcb_rax_is_valid() at the same time? What if *err == ES_OK and 
ghcb_rdx_is_valid()==true but ghcb_rax_is_valid()==false?

return ((ghcb_rdx_is_valid(ghcb)?(ghcb->save.rdx << 32):0) |
	(ghcb_rax_is_valid(ghcb)?ghcb->save.rax:0;

Or I can just drop *err, invalidate ghcb before sev_es_ghcb_hv_call() 
and only rely on (ghcb_rdx_is_valid() && ghcb_rax_is_valid)?

Where should I stop with this? :)

>> +
>> +    /* Invalidate qwords for likely another following GHCB call */
>> +    vc_ghcb_invalidate(ghcb);
> 
> We should probably call this on entry to the function, too, right? Not 
> sure it really matters though.

The SVM_EXIT_MSR's handler in SVM/KVM only cares if RCX is valid in 
sev_es_validate_vmgexit() and the guest's ghcb_set_rcx() does that. 
Nothing in SVM enforces that other (unused) registers are not valid 
though. Thanks,


> 
> Thanks,
> Tom
> 
>> +
>> +    return ret;
>> +}
>> +
>>   static int __sev_cpuid_hv(u32 fn, int reg_idx, u32 *reg)
>>   {
>>       u64 val;
>> @@ -477,11 +496,11 @@ static int snp_cpuid_postprocess(struct ghcb 
>> *ghcb, struct es_em_ctxt *ctxt,
>>           if (leaf->subfn == 1) {
>>               /* Get XSS value if XSAVES is enabled. */
>>               if (leaf->eax & BIT(3)) {
>> -                unsigned long lo, hi;
>> +                int err = 0;
>> -                asm volatile("rdmsr" : "=a" (lo), "=d" (hi)
>> -                             : "c" (MSR_IA32_XSS));
>> -                xss = (hi << 32) | lo;
>> +                xss = ghcb_prot_read_msr(MSR_IA32_XSS, ghcb, ctxt, 
>> &err);
>> +                if (err != ES_OK)
>> +                    return -EINVAL;
>>               }
>>               /*

-- 
Alexey


