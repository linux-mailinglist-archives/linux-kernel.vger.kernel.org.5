Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6927B8163
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242664AbjJDNxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 09:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjJDNxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:53:20 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0072A9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 06:53:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiJXafbZzrJ7+rQeWXK3I/06skJnh1+uS9flN3u7dpSS0Lc9cSYtyHACGV2piIvPi731XrJmtFgN/ZJw2eeLduU2cBV8F9IXcKRcQbo63CPFi0ZoLUGMGPD+eBgp7nofEG7tSwBxPHGql36ULjEGaii+KQzt4HvEnrrq0RU5o9tVIWMuGzzihLH6HBlUytoVw3UZWDFBdRd2trIIFSimps5giyd7oAujd6IMraMh9SUyzDCeXNG8M1FDfiO0sbujzUENWNbHoopgx+VgXvlIEflK/zv0eM6fdvCDWBCEQXuHRJgzPn/9AI+15GWGXDt1fvvogwYG51JZpOMjU5aVkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTJmzCgXknewK9DgyzZ+wBO2Whq+LwtuZ75QQHSsXQw=;
 b=izJsRzTlcDB8WmnYxgf8RfU3j053cqJCjwA8EAuz2DysxK05O6In2/lOsfP+LlVdNVHHeMK3Zyq39LY/j4ltzvF45qJvTYJV3x3/rwU/3pqJBLbVcK/wzwUyrbr64BS/R7TS5FSbIrSxk6IP84pl2z+UpqXNNz4bkiQYMyfntTIKTWk6MZdS4Ag+gqSG8qRoFYGE/16SGgnp1/pU1tjKh6vfRyhtB+qK26hxjhtn/SjVtDFajLrDURx/x/IRfurfgY3AXqZyu28U46OBtWYbCPmjmxqSXOOJu/aULKRVa5/nraimarEIapOJ2UfSQukQb1GwpuLzyWYYfPKsyIUi7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTJmzCgXknewK9DgyzZ+wBO2Whq+LwtuZ75QQHSsXQw=;
 b=JusHvgq6f5G3XoS5ygiE62R4clV7LiuLjRkY4SxNE3rbM7ZrRCw08TF6cucp7/tMQ9sAvJPO3UAeM47ko8ZLgFEojXw8btHTOc/KrO2FHbJ5ereAiImDjKlcXB5OuYQ+gQiBTTSv7PiTNE/huIWzusQkB3do4KUHm4hMCl3ZSHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by PH0PR12MB5646.namprd12.prod.outlook.com (2603:10b6:510:143::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Wed, 4 Oct
 2023 13:53:13 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::2b54:7ddf:9e2e:751c]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::2b54:7ddf:9e2e:751c%3]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 13:53:12 +0000
Message-ID: <37f536c7-0b09-89f2-5556-d403a0726fdb@amd.com>
Date:   Wed, 4 Oct 2023 08:53:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH kernel v3] x86/compressed/64: reduce #VC nesting for
 intercepted CPUID for SEV-SNP guest
Content-Language: en-US
To:     Alexey Kardashevskiy <aik@amd.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>
References: <20231003073123.1763564-1-aik@amd.com>
 <32c0080f-1bd1-32c4-2bfa-910537a50ca8@amd.com>
 <14619d42-b319-4b5c-9363-c75096d27584@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <14619d42-b319-4b5c-9363-c75096d27584@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P223CA0022.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::27) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|PH0PR12MB5646:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fed4c14-868f-46ea-5fce-08dbc4e13fd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w7xjdMjtf9Tq0Uph/qcc293LyY+LMPGrHzD/+3ZwvnTIuZ7n8CxWdA6xJcZjGuO4irpZ4trplb3Ucfrcbqff+sUaR161D05LNUkHgFccRBwC0Irs5SA2/b97+MrEbtjSd0hXEyYgPU1nWAcyuUQGmsyk+HwgWvN5ctp7H+0t06Kw075I8AQf2yf6e8A89YGnoWQFax4gCBvFQClQIYdw526POGD9qMttRzCQ4EV4VVk0EWxPXGnoXF3hRTNtNi8NhKfuvHZ3pQrUHafJN5BZ9g+gO0diTATt+HnlrAlIdw+QYD6fMZlAovdjTfoSP2CQkxJXXzFgfyegQ7gFM+7uGJzNRDXfb3rpNoddc8Lcx9UFh51aDg6vmoiFEPd1f6dXBtiAj+yLcoFZLQ71OuXdeliPFukEY7BWWUkFHpRItdikYv2OSHihHIJcmlL51cKoYszIFHHGdmq5BQ4ciKvfBUp3TlMauAtXp9lAvclwGRgl3qDKCBKxLktxuRyudd6SFV9TfhGGq8y6BnM0j6okz/BiVQWzdJCTthmYzMCvEOS0SCbsTxHylSOZuRAkG1z0wLYGYcNB73RV/DePAPTDbjJyS+TcxFB15Hp5bpb08zWuKV4tuuxtCIhLBpZJTdm8/uah3NfPCFqwD7DLMrCI8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(5660300002)(2616005)(31696002)(8676002)(8936002)(4326008)(26005)(31686004)(83380400001)(6486002)(6512007)(53546011)(6506007)(966005)(66476007)(478600001)(36756003)(66556008)(66946007)(316002)(6666004)(86362001)(54906003)(38100700002)(41300700001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEUwZkVjT2xmUVpCbEhVMVV5ZXNmMkpYcDlBOXdYaUFrUDlwL0VXTFdHeG1E?=
 =?utf-8?B?blBoRzk4TUNBR25relpCTXRXZjdVNkxqNHZxcUZnNTMzTHQxM3B4blJwQnd0?=
 =?utf-8?B?RzZERE9wOFhjUHl0bkk2U01MRTNPdGpVaU5oUEYrODZzUW1WaU1ZMVgwUjVF?=
 =?utf-8?B?TTl6Z21SOFFzQjBuWm1kdXpJNHE0RjZFa3ZEM2FIUGpJMzRBaTY4ODlJTkJW?=
 =?utf-8?B?bml0T3B4d3BZcldSVTI3K2laQXM4ZnNlbEVsRG90MGpqS0MwS2JseVhObnRr?=
 =?utf-8?B?aUVZemE5a0NETmgvOVlVRW10b3Z2MFRLYTY2VXJTZHdmU2cyWkdBYlZyUjRx?=
 =?utf-8?B?Y2RCMVAvalVHWXdOZTBLaGI1RXplZmpiMEZaZUtncGVEYVNpMUcxTjlhd3Ns?=
 =?utf-8?B?N2tJRDFWZzJPb1A3TmtneW51R2RIaGllWU9aeHlMeVE3Y2tQWndKTjRnUEJw?=
 =?utf-8?B?TGd2aUdCZzdXTjdYVURLTGxXazZDMFV3S08yWkhKY0JNUU9LTjRCcEZsaFBW?=
 =?utf-8?B?bDFKVTM0TjYzakE0OXZKUkFpZmh4WDZTTE16c1ZSci9LM0pDMmtreFh4WEpi?=
 =?utf-8?B?Y2NKdDBkbnFFbk9CdUlqQ2Z1ZTJ3WEtWMVVWa2VYSjdzL2FlckV4bGRMTzAw?=
 =?utf-8?B?WDdmU0tEWFNCNStOYWtJRWlxSEo2VTFSTWYzUjVva0RtYmU5V282cUs0V2V2?=
 =?utf-8?B?R0FPVjNoZXgrRTcxblAvTERpT1ZGUUlwQ2l1UjE1STFpZDRUSlZnSVBwV2ZY?=
 =?utf-8?B?YmlQalhDYmc2bEhwS3dPTmRKbUNuYzIweWtucUZSZ1JsSlBzL29saUlDaWJO?=
 =?utf-8?B?bmh2UFpsTHZYNmh1V05Qb3RHRzhkc3V5bFhBSXdoZ1BVbHN2RHk0NDFVUWZz?=
 =?utf-8?B?bjhwdzZlSjV3RXlCaGgwRlNGSTFObTVXYVBEMkVpQ2x0TEZucmowa3Z0SlVN?=
 =?utf-8?B?SG9lNml6ZUxyemJYWC9VUitiak5FVXliRWlQSWVCTDd1WmhtYjVRS1dBWC9I?=
 =?utf-8?B?VXlCT08wcHRWcXNLak9ReHhLR3l6SVkrZ0ZCUFZsUU1sZVdCOWY3R0NyekZR?=
 =?utf-8?B?RGlDNTlMcEY1Rm55SzNUMExLc2hHTFpZdHB5RmRrSjFwczIyV3NxU25NUzA5?=
 =?utf-8?B?TldzOVROM2t4Uk51bFIzR3hVVkgvVkYxR29RZTdBT2xtRnZOcGl3bXZPNVFq?=
 =?utf-8?B?ZDlVTHNaTW9JaWJ3aEUyaUo4NzZQMkxQMWprbXpFTjR1UjBaSlJmN3ZheitY?=
 =?utf-8?B?dFZ3VHRVNzVnMm1yZk9RMkZ5QU5RR1dodVJoWkVTcmY2aXlld3luVmxYWGZG?=
 =?utf-8?B?a2dBOE1GSW1JTmFtTUJyc3NGZ0JLNytOcGE5dWdQNjFxaEZONGtGWTZCVWVZ?=
 =?utf-8?B?bENaVXNuK3E0VDhRd0x0a2dBV1BvUENJUlBnNExTMDB2VXVBQlRqd3hkMmdZ?=
 =?utf-8?B?eS83UnFueml0NHpCb29jQUI5RW1RSmVLZDNVZ0k3YWM3WXZUQll6SzBkM1N3?=
 =?utf-8?B?T3NRaWM4ZVRpdVJVTDJiV0RZaWtKS041aWdKNVVlcWlsNThFazNFZmJJMWZx?=
 =?utf-8?B?SDFmZW9DWjlFQzZ1MlhCQ1RMUUZZMVd2WnBoY0l1VEtTeWR2dUlTdEk0Mkdz?=
 =?utf-8?B?c2tremZMQTRJZ1NXYjFjcFA3NlpsQU9zaDhtTmxOYUtUaDJEOVBkdVo3S2hi?=
 =?utf-8?B?OVpsRGJ4dUdoRElva0lWRHhxL3Axalg3ZzBoQ0VlNmFJOVRTeDJ0b2szZEd5?=
 =?utf-8?B?RnhUYkdSaXNkVjZkaGwyRE9GYm1HeUVpcFBuNTdaMmRPTzJYUE85T1JSUk5a?=
 =?utf-8?B?UXZ4R0lXWFFwQkcrSG5lQmo4NHBXM2VWZXl3NWNLd24ySUF0bnc4bHFSUWZG?=
 =?utf-8?B?dDhaZHRhR2pDYVZvcW9QSmlseVl3K0VZdlM1ZndxcnhOOWtCb1F3emd6dDFY?=
 =?utf-8?B?djJNK2MrdUZoZmROYlRjcjYwb3k0SGJLbFZQb3lZbjdSWi9iNGlKMkVJb1hU?=
 =?utf-8?B?ZlkyYSswbEZUdmpEdC9JYUZNVmozUkJUY244SXFhVmhiQUgwNEZDOWVxbDdH?=
 =?utf-8?B?QXR4R1k5YXAxUGo0bVBIVFdNekExc1ZoS0YyVDZWTzljYmtIZ1gzUzlQUExF?=
 =?utf-8?Q?kIYLQFi6LHld4G4AJWp7to3Dr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fed4c14-868f-46ea-5fce-08dbc4e13fd4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 13:53:12.7853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E40WlHMBFrGrbWhIZrQlvQ4XSz0lN9FDzPyn8SreMuRcR4ynL6Pexn1deBlpddMsIhAynuC7JuTXfFIA0E/g+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5646
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/23 18:22, Alexey Kardashevskiy wrote:
> 
> On 4/10/23 04:21, Tom Lendacky wrote:
>> On 10/3/23 02:31, Alexey Kardashevskiy wrote:
>>> For certain intercepts an SNP guest uses the GHCB protocol to talk to
>>> the hypervisor from the #VC handler. The protocol requires a shared 
>>> page so
>>> there is one per vCPU. In case NMI arrives in a middle of #VC or the NMI
>>> handler triggers a #VC, there is another "backup" GHCB page which stores
>>> the content of the first one while SVM_VMGEXIT_NMI_COMPLETE is sent.
>>> The vc_raw_handle_exception() handler manages main and backup GHCB pages
>>> via __sev_get_ghcb/__sev_put_ghcb.
>>>
>>> This works fine for #VC and occasional NMIs but not so fine when the #VC
>>> handler causes intercept + another #VC. If NMI arrives during
>>> the second #VC, there are no more pages for SVM_VMGEXIT_NMI_COMPLETE.
>>> The problem place is the #VC CPUID handler which reads an MSR which
>>> triggers another #VC and if "perf" was running, panic happens:
>>>
>>> Kernel panic - not syncing: Unable to handle #VC exception! GHCB and 
>>> Backup GHCB are already in use
>>>
>>> Add a helper similar to native_read_msr_safe() for making a direct 
>>> hypercall
>>> in the SEV-ES environment. Use the new helper instead of the raw 
>>> "rdmsr" to
>>> avoid the extra #VC event.
>>>
>>> Fixes: ee0bfa08a345 ("x86/compressed/64: Add support for SEV-SNP CPUID 
>>> table in #VC handlers")
>>> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
>>> ---
>>>
>>> Based on:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=tip-x86-urgent
>>> which top at the time was:
>>> 62d5e970d022 "x86/sev: Change npages to unsigned long in 
>>> snp_accept_memory()"
>>>
>>> ---
>>> Changes:
>>> v3:
>>> * made it a function, mimic native_read_msr_safe() which 1) returns 
>>> value 2) returns an error
>>> * removed debug backtraces the commit log as these were added for 
>>> debugging and never
>>> appear with actual kernels
>>>
>>>
>>> v2:
>>> * de-uglify by defining rdmsr_safe_GHCB()
>>> ---
>>>   arch/x86/kernel/sev-shared.c | 27 +++++++++++++++++---
>>>   1 file changed, 23 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
>>> index dcf325b7b022..494d92a71986 100644
>>> --- a/arch/x86/kernel/sev-shared.c
>>> +++ b/arch/x86/kernel/sev-shared.c
>>> @@ -241,6 +241,25 @@ static enum es_result sev_es_ghcb_hv_call(struct 
>>> ghcb *ghcb,
>>>       return verify_exception_info(ghcb, ctxt);
>>>   }
>>> +
>>> +/* Paravirt SEV-ES rdmsr which avoids extra #VC event */
>>> +static unsigned long long ghcb_prot_read_msr(unsigned int msr, struct 
>>> ghcb *ghcb,
>>> +                         struct es_em_ctxt *ctxt, int *err)
>>
>> Alternatively you could return enum es_result and take xss as a 
>> parameter... six of one, half dozen of another I guess.
> 
> How do we decide on this? :)
> 
> and yeah, I need to s/int/enum es_result/
> 
>>> +{
>>> +    unsigned long long ret = 0;
>>> +
>>> +    ghcb_set_rcx(ghcb, msr);
>>> +
>>> +    *err = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_MSR, 0, 0);
>>> +    if (*err == ES_OK)
>>> +        ret = (ghcb->save.rdx << 32) | ghcb->save.rax;
>>
>> You should check ghcb_rax_is_valid(ghcb) and ghcb_rdx_is_valid(ghcb) 
>> before using the values.
> 
> Huh. v4 is coming then. Although what are the chances of *err == ES_OK and 
> !ghcb_rax_is_valid() at the same time? What if *err == ES_OK and 
> ghcb_rdx_is_valid()==true but ghcb_rax_is_valid()==false?
> 
> return ((ghcb_rdx_is_valid(ghcb)?(ghcb->save.rdx << 32):0) |
>      (ghcb_rax_is_valid(ghcb)?ghcb->save.rax:0;
> 
> Or I can just drop *err, invalidate ghcb before sev_es_ghcb_hv_call() and 
> only rely on (ghcb_rdx_is_valid() && ghcb_rax_is_valid)?
> 
> Where should I stop with this? :)

No, you can't drop *err. The GHCB protocol specifically calls out how 
errors can be returned and how register state is returned.

In this case, sev_es_ghcb_hv_call() will check for general errors being 
returned from the hypervisor, e.g. non-zero SW_EXITINFO1[31:0] and that is 
why you need to check *err.

Then you need to validate that the hypervisor set the proper registers, 
hence the check for ghcb_rax/rdx_is_valid() (see __sev_cpuid_hv_ghcb() as 
an example).

Thanks,
Tom

> 
>>> +
>>> +    /* Invalidate qwords for likely another following GHCB call */
>>> +    vc_ghcb_invalidate(ghcb);
>>
>> We should probably call this on entry to the function, too, right? Not 
>> sure it really matters though.
> 
> The SVM_EXIT_MSR's handler in SVM/KVM only cares if RCX is valid in 
> sev_es_validate_vmgexit() and the guest's ghcb_set_rcx() does that. 
> Nothing in SVM enforces that other (unused) registers are not valid 
> though. Thanks,
> 
> 
>>
>> Thanks,
>> Tom
>>
>>> +
>>> +    return ret;
>>> +}
>>> +
>>>   static int __sev_cpuid_hv(u32 fn, int reg_idx, u32 *reg)
>>>   {
>>>       u64 val;
>>> @@ -477,11 +496,11 @@ static int snp_cpuid_postprocess(struct ghcb 
>>> *ghcb, struct es_em_ctxt *ctxt,
>>>           if (leaf->subfn == 1) {
>>>               /* Get XSS value if XSAVES is enabled. */
>>>               if (leaf->eax & BIT(3)) {
>>> -                unsigned long lo, hi;
>>> +                int err = 0;
>>> -                asm volatile("rdmsr" : "=a" (lo), "=d" (hi)
>>> -                             : "c" (MSR_IA32_XSS));
>>> -                xss = (hi << 32) | lo;
>>> +                xss = ghcb_prot_read_msr(MSR_IA32_XSS, ghcb, ctxt, &err);
>>> +                if (err != ES_OK)
>>> +                    return -EINVAL;
>>>               }
>>>               /*
> 
