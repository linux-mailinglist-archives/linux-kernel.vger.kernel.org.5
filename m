Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A5A7BA20D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjJEPMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjJEPKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:10:35 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8861019E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:41:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxhcV/goqRKuTFBvWxaZckXlFhu3ecJfIe2qsprVOEDZm2kUy5smPkIUDQ5H11q4W7b5N9Tl7AMkxsXSP/hMN4Dn2z66AmikEdTbgdNyTLpVjz0YplUsehdR6dcCfJ8lsXzAl8EiusRq7A/kU4av0MLl7bV+Tn8Fn+h4Pah7aXlH9da89rKR5sENTJl6bhbaX+dkjeDLJfvDXGwBIbJgXyOOP7xTiXOcqa0k3URjyYaWiuMT7+NOBj2pIglEV08e3ulmJREzuDQkyYjArWOxLGP+6Rjpo30YZ/OEjr55v/9qbYFFdf+cBIG6RcJXbrlwcNNkA1V/3/LMvS8GQFAqeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdZJn+YIXr9uk5QaOwxilMZ1M7MHL/FV1y6d5allFx8=;
 b=UuoHo0sVjm9VVHWyA2cuiyezXUZxVgWu8G1KEuEAwCCg286zsesl/mLaFzeduFElQowGxfXn2zJG1ltFp+mR8XYUMvv2xX2I2LNd7NpsxSylf5JWGo4V3uTctq3gR4E67kOy7zf61dLPlCCk2qo5k63msGZqfrBMsWrX9isJGgU+NQ7b0yE7KTeCaoj89l4nQOUuP1QF/H03qHsWvN1QcD8MH1RsFCrriMMmHEJyzRXg1rF9WmTA9pBq7Msu/YF1r9X/r99sguwQcN0/DgXMfaztZQT7gCK2KFsbEq09qcTQmvYvjzjE8KM16gV/dfxrr73iWNlNRBosmoQMV8YmwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdZJn+YIXr9uk5QaOwxilMZ1M7MHL/FV1y6d5allFx8=;
 b=QAQ5eRBX2qkRmwF4lR9bKMDS8ueSRQr4CJxfFz9djTjbNyad+Nn4XSpLysNpdc4BOQqG/JiMxqV/kPcl4gTJ+OsisDgGcBzdSAQgu3RyxEkaa5ziDNbJ7ya0JWwm55FQrSHOAIQQooC9s5JnSFv4WOV8LSqUN0GAfJR2b9XI5uc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SJ0PR12MB6990.namprd12.prod.outlook.com (2603:10b6:a03:449::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Thu, 5 Oct
 2023 14:41:38 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::2b54:7ddf:9e2e:751c]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::2b54:7ddf:9e2e:751c%3]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 14:41:38 +0000
Message-ID: <2de3a655-f3f9-f3ff-031b-1367e193f485@amd.com>
Date:   Thu, 5 Oct 2023 09:41:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH kernel v3] x86/compressed/64: reduce #VC nesting for
 intercepted CPUID for SEV-SNP guest
Content-Language: en-US
To:     Alexey Kardashevskiy <aik@amd.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <seanjc@google.com>
References: <20231003073123.1763564-1-aik@amd.com>
 <32c0080f-1bd1-32c4-2bfa-910537a50ca8@amd.com>
 <14619d42-b319-4b5c-9363-c75096d27584@amd.com>
 <37f536c7-0b09-89f2-5556-d403a0726fdb@amd.com>
 <1d9a3a05-fbcb-49b5-955a-a3686ab3efdd@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <1d9a3a05-fbcb-49b5-955a-a3686ab3efdd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0338.namprd03.prod.outlook.com
 (2603:10b6:8:55::31) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|SJ0PR12MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d985889-55ff-4b22-b8a5-08dbc5b12e65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cQAgGzKdOBdD1nRYS3L57udhTtxDkFHY53pohVjPWo6vZeHIgjBf1V92NXBX/NCERVIxsINyORh5eHVJk8qJ9VcNDIL/ZnAun29Q/i/8d6u4vzaPUBP0SInBvmwXHByp6sb6RaDV/PxhptQeWCrARjStnM7cuXpVj6/Inu9NZkbW0iAf8PFZuKUEXA1OKTKjju8/Ls3YPgRr5LC926SaDS3qlGlB1MJyYbaNa/CI+cBmm3zxwgnUrkdyE7gu/WNWLmgIJ9E2yAVBOZxx5dhBzaqgyoSOtPSFQ2kGou4+Qxf+oYn9Xai9ZfrSW7GhErFrFPx0Pnfvu87iwtI1+O1C9TTPIyXHIWXRdV62Yxf+MrpErGF0R9ISU0obDanx7egt1L0gL9UoMdwGsJMT5fygo1XvuxhAX4ijNhNIt0ToXS/HrV3v35ZulqYCuKL8D8awjpDSN19x25duPKOY4jSo7GeJYOJkdQkSDh/7eIg3bTfTZPUGwpFNyv+LjMeqBDBF/U1yjrdrEiGU0Ti00LwxecIdt9tP30e4W6OkNen6VrHqPRW228S1mN3Eur0SJt6g1JnWCErSjHI6JkS5Lqo0dIcuYY1G/zrmgV5mMZHmwJvyLdqiVJQiViMayVoHtx9JgH7iJ+g7nQs4+Ky80qhbxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(39860400002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(2616005)(66556008)(66946007)(316002)(54906003)(66476007)(41300700001)(6512007)(53546011)(26005)(36756003)(6666004)(6506007)(966005)(478600001)(6486002)(38100700002)(31696002)(86362001)(83380400001)(2906002)(31686004)(4326008)(8676002)(8936002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGNJTmhIbWJ2RFpxSVE0U29iajhlYWFTNEhaaEFiRUFXcTlFTmlOQ3pWekxC?=
 =?utf-8?B?OEp4VmRqd3hDanlwb2NSaE9hUmxRakp2bCtYZThwWnNLYUdCRVFOZlFBQTFN?=
 =?utf-8?B?U245ZWx2eldVVUdETEZiSWRaUjhSQ3pjYW0zaGUzb0RBMlc2d3FCMCtqSStR?=
 =?utf-8?B?dXEwL1lHbUsrbnVlY1UvRlEyNFo1QmdTa0xnQVY3N3doMGZtelBMeTJRUEIx?=
 =?utf-8?B?U3lIMkZnTnVQYUlmN3pKdlhpMFl5bVdjUFVBUjRyZ2lDQldnVGJoNTBaKzZ5?=
 =?utf-8?B?V0dmTzh3OW5nMUlHYkFheTQ1MEliSW4zUmtIMGVDY1hBckhJZFgxU3crMnNo?=
 =?utf-8?B?V0Q1UmRKMG81cG9mczZDVkZoMFRSdzk3T3FEL1JiTEFmT2FMYUNmdnYvVHBk?=
 =?utf-8?B?Um5sdXJySy9iS3o1U201Z2xMeVVXRlNRNEJHcmJ3WnB4VWZ2L3pkVFVTUTA2?=
 =?utf-8?B?REhjcjc0ZDZIdm9nYzhKYUphNk9qSVhPUGYreENSNWFaQ1FqNElnZlcrLytp?=
 =?utf-8?B?QVJNOXJCYkR2OE51Q05vcVRQV0ZVUnZxNzNPSUhKQXNVcUkzKzRNSVFPeE1t?=
 =?utf-8?B?NGFIWDhCczNUUWhpRmx1WjVGb1BYNzRBajNRSUFIbmtJL2ZaTlNWRVVaYzZX?=
 =?utf-8?B?VSt0SXU2MTdlWmc5TTFuZnMrelJLWTRSY3ZDQ0VjckZNckNHR2gvTXR5a2ZC?=
 =?utf-8?B?bDN2SzFpVTh4NmR4bWtsVU9rOFhLcUdqVVVYK0NIamlReS9yRlhLVXpaNktO?=
 =?utf-8?B?RG5VTCtDNEExODhoRU91dVBoanc4UGc4ZW5ZakxVU1NnN0p5dlhiT1N0aXQ1?=
 =?utf-8?B?ajBzMWVMVVZTeCtxclkxOTM4dTM3QUlLWk1xSitjQ3MvazFpWnpVMUtRUXpX?=
 =?utf-8?B?RzVuUzc2WlpDS2VLMzgwRjRtVUM0QTBZZ3p1Ulk5ek1UVTQyMlN3TUlUY1F2?=
 =?utf-8?B?VCs2am5QRDZyaVRmUlJiZzY4VEtMcUFHNUZ4b0ptajV4MUdEeC9LYmttNXJl?=
 =?utf-8?B?Zm5KaFE1c3l2S3UyZmhoK3BNZElsUzlWVXl2VlhBcW9CUVNFUTVmc2ZUZ0Vw?=
 =?utf-8?B?MmVUeVpTWjhJS1NRUjF6cUV3ZGgyd2ZzRklxRmtYamdIZ05FYzlaazBUMzVs?=
 =?utf-8?B?eWxHVFkxSEUra0FPeC9peEpuM0lFSExhbXByQzB6N3ZDdC85dHByNG91L2oy?=
 =?utf-8?B?ZHJoK3QrcER1YzM0ZlN0NzlJdk1VY28wakFscHFxZTluSVlBanAzOXBKUklw?=
 =?utf-8?B?Nys5Y2FDNDFhbWt6V3AyU01EZmxnK05vTUlSWUk3c0EzZHlzbjBZTUUvYmlY?=
 =?utf-8?B?ZXhiZUFRT2I2ZEk4NUJVdHpJeUt0ZUlLbXZMTS91eTBSSVdpcUxCRUJaZHR2?=
 =?utf-8?B?M2dRWUhycmxiREpCdXpzbENvaFNDWUFZem95U1c0bmJ4cVlHN2pTWDlTM0hM?=
 =?utf-8?B?Qmt3NW1vZS9kaTdxblVQalZFYi9UTmNqZ1RvWm05UDc0SEtRb1JpSmdESFpE?=
 =?utf-8?B?SDNlblBHT3R3QTNLMUxlZC9EQ0pWeW9uYjRvQytoQ1BPdkFVcGNvZTczWWN4?=
 =?utf-8?B?UHoxM2x0YnhBZndLamd5Z1VwbDRjSGh2MnpxVDJISXJDaWlIeWpiZW5xYkhQ?=
 =?utf-8?B?RnNlamp1d05iZDVOYUdKMXlSOFpCRE1DSTZrYlV1NjJGK09Bd1NjN2d6YUNl?=
 =?utf-8?B?OW9Sd1o4cDRsc1oycWhvMkNGc2RmTTBCOUMreldYVUloTE1qN1BaekNiQTNE?=
 =?utf-8?B?azVXWmYxSFEybG8wd1NPTEtoTXZxYnVzWkw2TTlFNTMwemZlSmoyblJJa3hw?=
 =?utf-8?B?LzFPNDdXVFpzRStodHBjcWpwQUF6bXdrNGV3K2JBU0R1bDFnUWhGZzZoRFd0?=
 =?utf-8?B?TDh6cytiSTZTbWtDeDhKckdyUDZWa0dWK1Q5WVhDMGVFYlNPTmpyTHJSWURE?=
 =?utf-8?B?cUVoSGRINTdhOExHSGRYTEFCNTE1NzdGOHR4NU5raDJBU1JpYWZmSU9Vei9S?=
 =?utf-8?B?OGtTeEVUY2JaSkxwM1dickdTZXhLbDZJaHBMbzZoUmpXQS9WeW90OVp3S1J2?=
 =?utf-8?B?TTBKVkdqek1pVm1BM2hCaW4rZ2lzeVVzNkUxc1ZIbU5wR1VkeFNiVnJwQ2lK?=
 =?utf-8?Q?IdBs9MMOsZxJqFksd5C/Bn6D5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d985889-55ff-4b22-b8a5-08dbc5b12e65
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 14:41:38.2728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BjX9toax6go6gmIpIWBNXpQM1vNNTAMb1pG5ansJuKXyPwwWT+nx4Up+llLZ06OhGE7UCU06FpgF5jeBHGdQEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6990
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/23 04:36, Alexey Kardashevskiy wrote:
> 
> On 5/10/23 00:53, Tom Lendacky wrote:
>> On 10/3/23 18:22, Alexey Kardashevskiy wrote:
>>>
>>> On 4/10/23 04:21, Tom Lendacky wrote:
>>>> On 10/3/23 02:31, Alexey Kardashevskiy wrote:
>>>>> For certain intercepts an SNP guest uses the GHCB protocol to talk to
>>>>> the hypervisor from the #VC handler. The protocol requires a shared 
>>>>> page so
>>>>> there is one per vCPU. In case NMI arrives in a middle of #VC or the NMI
>>>>> handler triggers a #VC, there is another "backup" GHCB page which stores
>>>>> the content of the first one while SVM_VMGEXIT_NMI_COMPLETE is sent.
>>>>> The vc_raw_handle_exception() handler manages main and backup GHCB pages
>>>>> via __sev_get_ghcb/__sev_put_ghcb.
>>>>>
>>>>> This works fine for #VC and occasional NMIs but not so fine when the #VC
>>>>> handler causes intercept + another #VC. If NMI arrives during
>>>>> the second #VC, there are no more pages for SVM_VMGEXIT_NMI_COMPLETE.
>>>>> The problem place is the #VC CPUID handler which reads an MSR which
>>>>> triggers another #VC and if "perf" was running, panic happens:
>>>>>
>>>>> Kernel panic - not syncing: Unable to handle #VC exception! GHCB and 
>>>>> Backup GHCB are already in use
>>>>>
>>>>> Add a helper similar to native_read_msr_safe() for making a direct 
>>>>> hypercall
>>>>> in the SEV-ES environment. Use the new helper instead of the raw 
>>>>> "rdmsr" to
>>>>> avoid the extra #VC event.
>>>>>
>>>>> Fixes: ee0bfa08a345 ("x86/compressed/64: Add support for SEV-SNP 
>>>>> CPUID table in #VC handlers")
>>>>> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
>>>>> ---
>>>>>
>>>>> Based on:
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=tip-x86-urgent
>>>>> which top at the time was:
>>>>> 62d5e970d022 "x86/sev: Change npages to unsigned long in 
>>>>> snp_accept_memory()"
>>>>>
>>>>> ---
>>>>> Changes:
>>>>> v3:
>>>>> * made it a function, mimic native_read_msr_safe() which 1) returns 
>>>>> value 2) returns an error
>>>>> * removed debug backtraces the commit log as these were added for 
>>>>> debugging and never
>>>>> appear with actual kernels
>>>>>
>>>>>
>>>>> v2:
>>>>> * de-uglify by defining rdmsr_safe_GHCB()
>>>>> ---
>>>>>   arch/x86/kernel/sev-shared.c | 27 +++++++++++++++++---
>>>>>   1 file changed, 23 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
>>>>> index dcf325b7b022..494d92a71986 100644
>>>>> --- a/arch/x86/kernel/sev-shared.c
>>>>> +++ b/arch/x86/kernel/sev-shared.c
>>>>> @@ -241,6 +241,25 @@ static enum es_result sev_es_ghcb_hv_call(struct 
>>>>> ghcb *ghcb,
>>>>>       return verify_exception_info(ghcb, ctxt);
>>>>>   }
>>>>> +
>>>>> +/* Paravirt SEV-ES rdmsr which avoids extra #VC event */
>>>>> +static unsigned long long ghcb_prot_read_msr(unsigned int msr, 
>>>>> struct ghcb *ghcb,
>>>>> +                         struct es_em_ctxt *ctxt, int *err)
>>>>
>>>> Alternatively you could return enum es_result and take xss as a 
>>>> parameter... six of one, half dozen of another I guess.
>>>
>>> How do we decide on this? :)
>>>
>>> and yeah, I need to s/int/enum es_result/
>>>
>>>>> +{
>>>>> +    unsigned long long ret = 0;
>>>>> +
>>>>> +    ghcb_set_rcx(ghcb, msr);
>>>>> +
>>>>> +    *err = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_MSR, 0, 0);
>>>>> +    if (*err == ES_OK)
>>>>> +        ret = (ghcb->save.rdx << 32) | ghcb->save.rax;
>>>>
>>>> You should check ghcb_rax_is_valid(ghcb) and ghcb_rdx_is_valid(ghcb) 
>>>> before using the values.
>>>
>>> Huh. v4 is coming then. Although what are the chances of *err == ES_OK 
>>> and !ghcb_rax_is_valid() at the same time? What if *err == ES_OK and 
>>> ghcb_rdx_is_valid()==true but ghcb_rax_is_valid()==false?
>>>
>>> return ((ghcb_rdx_is_valid(ghcb)?(ghcb->save.rdx << 32):0) |
>>>      (ghcb_rax_is_valid(ghcb)?ghcb->save.rax:0;
>>>
>>> Or I can just drop *err, invalidate ghcb before sev_es_ghcb_hv_call() 
>>> and only rely on (ghcb_rdx_is_valid() && ghcb_rax_is_valid)?
>>>
>>> Where should I stop with this? :)
>>
>> No, you can't drop *err. The GHCB protocol specifically calls out how 
>> errors can be returned and how register state is returned.
>>
>> In this case, sev_es_ghcb_hv_call() will check for general errors being 
>> returned from the hypervisor, e.g. non-zero SW_EXITINFO1[31:0] and that 
>> is why you need to check *err.
>>
>> Then you need to validate that the hypervisor set the proper registers, 
>> hence the check for ghcb_rax/rdx_is_valid() (see __sev_cpuid_hv_ghcb() 
>> as an example).
> 
> 
> After an offline discussion, it turns out this intercepted rdmsr of XSS in 
> this particular place (postprocessing of CPUID 0xd:0x1 bit3 == "XSAVES, 
> XRSTOR, and XSS are supported") in the guest should not have been 
> intercepted in the first place as it is virtualized and swapped as typeB, 
> but it is intercepted as this is the default.
> 
> 
> This applied to KVM fixes the guest crashing problem:
> 
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4266,6 +4266,11 @@ static void svm_vcpu_after_set_cpuid(struct 
> kvm_vcpu *vcpu)
>          vcpu->arch.xsaves_enabled = guest_cpuid_has(vcpu, 
> X86_FEATURE_XSAVE) &&
>                                      boot_cpu_has(X86_FEATURE_XSAVE) &&
>                                      boot_cpu_has(X86_FEATURE_XSAVES);
> +       if (vcpu->arch.xsaves_enabled)
> +               set_msr_interception(vcpu, svm->msrpm, MSR_IA32_XSS, 1, 1);

But this isn't valid for non ES/SNP guests, so it would need to be part of 
the (recently added) sev_es_vcpu_after_set_cpuid(). It would also need to 
(re)enable the intercept if xsaves_enabled isn't set.

> 
> 
> Sooo. I guess we want to fix the KVM but at least for now the guest needs 
> the fix too, does not it?

Since the SNP hypervisor patches aren't upstream, I don't think we do. If 
the SNP patches do the right thing from the start, everything is ok.

There isn't currently support for XSS in the ES #VC path for CPUID, so we 
do need to look at including that. But that is also the tricky part for ES 
since we don't have a CPUID table. The XSS MSR is valid if CPUID leaf 0xd, 
subleaf 1 has bit 3 set, but you need to be able to supply XSS on the 
CPUID call... so there is a bit of a chicken and egg issue where we might 
have to call that CPUID twice the very first time that CPUID request is 
encountered so that the proper XSS value can be supplied before the 
X86_FEATURE_XSAVES flag is set.

Is XSAVES being advertised for ES guests today? If not, we can add the 
interception updates today to KVM and be covered there, too.

Thanks,
Tom

> 
> And adding Sean in cc.
> 
> Thanks,
> 
> 
>>
>> Thanks,
>> Tom
>>
>>>
>>>>> +
>>>>> +    /* Invalidate qwords for likely another following GHCB call */
>>>>> +    vc_ghcb_invalidate(ghcb);
>>>>
>>>> We should probably call this on entry to the function, too, right? Not 
>>>> sure it really matters though.
>>>
>>> The SVM_EXIT_MSR's handler in SVM/KVM only cares if RCX is valid in 
>>> sev_es_validate_vmgexit() and the guest's ghcb_set_rcx() does that. 
>>> Nothing in SVM enforces that other (unused) registers are not valid 
>>> though. Thanks,
>>>
>>>
>>>>
>>>> Thanks,
>>>> Tom
>>>>
>>>>> +
>>>>> +    return ret;
>>>>> +}
>>>>> +
>>>>>   static int __sev_cpuid_hv(u32 fn, int reg_idx, u32 *reg)
>>>>>   {
>>>>>       u64 val;
>>>>> @@ -477,11 +496,11 @@ static int snp_cpuid_postprocess(struct ghcb 
>>>>> *ghcb, struct es_em_ctxt *ctxt,
>>>>>           if (leaf->subfn == 1) {
>>>>>               /* Get XSS value if XSAVES is enabled. */
>>>>>               if (leaf->eax & BIT(3)) {
>>>>> -                unsigned long lo, hi;
>>>>> +                int err = 0;
>>>>> -                asm volatile("rdmsr" : "=a" (lo), "=d" (hi)
>>>>> -                             : "c" (MSR_IA32_XSS));
>>>>> -                xss = (hi << 32) | lo;
>>>>> +                xss = ghcb_prot_read_msr(MSR_IA32_XSS, ghcb, ctxt, 
>>>>> &err);
>>>>> +                if (err != ES_OK)
>>>>> +                    return -EINVAL;
>>>>>               }
>>>>>               /*
>>>
> 
