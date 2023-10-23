Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F5D7D2998
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 07:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjJWF0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 01:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWF0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 01:26:12 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FF5E9
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 22:26:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7dmsfX0/3L1klh1R5FvpHztjLrcbTfsVV+7gnEVlsn3DTH71GYQO96jli759lYUz8d3+uoxK8szmt7h3ARr3nRVqaQ9Qai7EeCucA0VpCwGDczqcQiNjKPjoxaPFHGHlwhZ+uRbiuwPWVyz+5Jw0SvP6DTRuKb8OI2VLlwoH0UEImcFlQdZR5Ktfz5f6bEqovmhniNvEQvIASnFIQn/6f1MF3PZG8Bxzv66uj7h8S2FCj2JAZ0jX4eEXM8YP15hdb/HmhcJKqQ0B4FortCoA6+v4Ra08qoHkKIY2I5Cn0KzYYrKD16DO14ZM2dy4w+EbjhH1zgm7rewU4xfH7Ycsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOZh0/oFRpn2v9CBpGpdF+Ut99pF42FYBLZpdTrr4Ag=;
 b=UJ77e6X8a0RAGhJsmemKm1oq67tLHlq+5ezZjQwiFXdkrNEBh4WugTY4VaXlbdRk0e1wjwoNiPIDiyEawJJbG8/lVGq1akCG8BHjJnW29iQaPHRCtPlRFCSAQTRRUO3JKtmlnzvM6X2fKZLEpOZgm87iMFpgUhRZ9Ib2gVvYImtqEPnRMj8CTzFcLQq410Xd+pkLyM6346IVgKBfQ+LNSzHVKcf4cFkgxJciXM+eMgvyFawRtfwbJhydv/2QBmBLTkIbRJKaXnSmMos9Z2R1h4YKXHDaQUygm5p2htm5qPsiinL7Uh44JXlH+wlIXSbN/U/L3Edc2QLH1ME5+LOvKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOZh0/oFRpn2v9CBpGpdF+Ut99pF42FYBLZpdTrr4Ag=;
 b=RjBgYSwXlH2qUy99kNIDJyKH/Me1Oh/u/tXGrPRiMIvhbVvVBERTZf59PP6+S5/OruyB3XJaESupIq8I9pzXTzknx9WmfT/T3ZpNGghEYsJZnwq/qWQrdQZSkvzcEVJuxNUvwwJTQ5i5H33ADB3J3SDnpnz9xxN/RZ+KoJjIQck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by SJ0PR12MB8613.namprd12.prod.outlook.com (2603:10b6:a03:44d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 05:26:06 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::6d1b:7a85:af7d:a90b]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::6d1b:7a85:af7d:a90b%4]) with mapi id 15.20.6907.028; Mon, 23 Oct 2023
 05:26:06 +0000
Message-ID: <6ef38c6e-e47d-66c2-216a-76ab4a59feb1@amd.com>
Date:   Mon, 23 Oct 2023 10:55:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V1 0/1] sched/numa: Fix mm numa_scan_seq based
 unconditional scan
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bharata B Rao <bharata@amd.com>,
        Aithal Srikanth <sraithal@amd.com>,
        kernel test robot <oliver.sang@intel.com>,
        Sapkal Swapnil <Swapnil.Sapkal@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
References: <cover.1697816692.git.raghavendra.kt@amd.com>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <cover.1697816692.git.raghavendra.kt@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0191.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::18) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|SJ0PR12MB8613:EE_
X-MS-Office365-Filtering-Correlation-Id: c58578b1-8b8b-4ac1-6b24-08dbd3888dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Btnj1zedW1R/K8t0uD/VzJNoObwEmaYUmkClAijGLmj4BRmEauV52hCWnqZDaRU7rNkPX6Bm3/YOpKl5Ex6bUNA1CeMJ82W0FdqHDTyzTsj5PFLV38Xb/ML+kq1BQyb1pr0Dr8qpa18QvlUSNsizF6v8Fj0HVqn6EufojuOsqvL56abupBCPXriLtisVlcvE9DBw0CDEF8dOO7gJrQfK7eeoriWLNuR/ttVbEAOILTfxcKkJJZDKGkn0pZRrexU96tFwC6d3i2URYshefZ3Bg6hROIPcohZ2S3npkaDdHQ94qQLGRARZ+zh+u39EWua0AuDdCSySeP7WyRk79cJTk19eDIApsE/Flfmr+d0JJK921INliyIwqhuk6APTK8gb6XcHyWLdtpPMmmv/mn/MdAFAXdvuTg2wRALMReI5yursJrXoVgfSjNF8jYGEvy/nCZt2hz/Sd27WTKSg6NJGghrIGjSKGgcqtBbcICaawG5SCkFzpR0Xq2bZktU8drMDm93oDnO7kFEjMXkdGKqFwNyhv2lyIaZun2eWcOHMrQdaizRBZpUIGelsVOrhnTlYC2oqB3930ant1+egCxTcMZSxRZd+Dz2EN9dBCV/nZSherZ3muvYHLqulGqTQWrj/2pTHvTe8WJAtAhN7exuDMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(346002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2906002)(6666004)(31696002)(53546011)(6512007)(26005)(316002)(2616005)(66946007)(54906003)(66556008)(66476007)(6506007)(6486002)(966005)(478600001)(83380400001)(38100700002)(5660300002)(7416002)(41300700001)(4326008)(36756003)(8936002)(8676002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUl5cUgvcVNMVWh4b3dNSGNvb3VhQkZ2QlRrRG9IOWpCbmJwZ1laSlR0VzlO?=
 =?utf-8?B?M0tIZVZqdEJjME9vUEQ0dXVzSSswSjU1NnF6TnR3RGxpb1hZbjNTamtSMVFN?=
 =?utf-8?B?QkhBNVFWanhPZUNIaG1saXNaU3pxUk15Mk5ybFNGQ2hwOHBMRC9tTFB0UnJ5?=
 =?utf-8?B?NUg2STMvd3RRaDZ4RWx2L205ZGdsa1EyamQ1blpOUWNrUTd5akZSaVRkSlpp?=
 =?utf-8?B?MDRJVFBTMjNJYnozRDZEUWs1OCs0K3IxVDhxT1lmVkZSNGlZNU1LbG9RVm41?=
 =?utf-8?B?ci9ZNDZMU3hVeGRNaEloQmZQdFBrL3BRUUluZmNFdCtzdk80V2ZXN0V2RnN2?=
 =?utf-8?B?ZUh0ZXNRUDNQZ1ZZaHEwWDF6b0xENEpjUzBvUU0wR0g4TXI2QkdPL1R0QVR0?=
 =?utf-8?B?NWhrNWRLWk1kekx4akVsM1k1bWtWSk4rNERlZm5iOS8zVEJUZ3RBQWFnTDlu?=
 =?utf-8?B?eEJHMG5xSjl2ZnlUcGxPam0yY2ZqQWtETEVjYWEwYlI0WTVXZHp1WnpXWHdU?=
 =?utf-8?B?eW9WRVNTbWFUSktNTlI1TENqK0U5WlRYUGRpV0J2NlhBbXl4REZudTc3WTB2?=
 =?utf-8?B?SFdjdW9VNTlNdmdHNFFxT3lGbk92amVYZE1FcTlWOGJUN244bFgvcFVMN0ZQ?=
 =?utf-8?B?L1h3ZERxWit6UVdkcStNd2JCcnRmMEwxaUxhMEVKb3J6cWYrSVhoa0N2TXI4?=
 =?utf-8?B?SWYyWnZjMkdYVzlxK3FyYjVWaFBkQy9tNWN4dzBKKzl1N3FqcmZJVThTMTdX?=
 =?utf-8?B?aGNCYk8zVnJEL2xJVFUwUDcvVXRUYi9wOEZPdDcyMVFYUTI2dFlrR2Q3bm5I?=
 =?utf-8?B?SXdIUk55VmZjRHRaQk5FRiswZU1LcjhGVFgwSDloUkFxRjlUL2RVLzhjWGNz?=
 =?utf-8?B?S0hNMExPcGJsbnM1aGl5NVoxbUFodThtQnZ3ZStQZDErOXM0amlmZ0hVSFN0?=
 =?utf-8?B?dGdsaG8wSklRVVJNUTFwRE9nalNSdExoQ0xZNkpwRElTL0hYMU9EbDM1dXUz?=
 =?utf-8?B?bFIxTm1KTUVaYUhNSGZaWmlEZno2eStncE5PWjZDUmdZK21oT3JDTDc0ZCts?=
 =?utf-8?B?S2k2TzczZ0grek9GZ1dIRXJsdldpMjdFMUQ2Q1hyWGF0VklnZWZFZGtOMmdu?=
 =?utf-8?B?MzB6Ym5weitVQncwNjduaGFFWWwydUZlcld6d01yajRIVU5wNmtoZStjY1Zi?=
 =?utf-8?B?d0JiQWtweUg0VTVFWXNMN1l2V2RaVURUemtGQ1lod2I1ZS9EYmpJQndubjJQ?=
 =?utf-8?B?T05XbWVwZ2t2SXF3di9jZkFyRlhmUU9tVmZCeTVQVFEyMzNJQzBETXh1U0Jv?=
 =?utf-8?B?MUVDeHNqYWptdytoYlRmVVBTWWduMGhOc1h4eEMxWFgyUTU4OFNHb1lVa01G?=
 =?utf-8?B?Y2VsS1g2Z0RwN2RYdnhHQTNqRjVyY3ZRK1IzWDhkK0lKRVJXQU1RWVV3bHBX?=
 =?utf-8?B?S0NuSEs0L2h1WXM5dEpFRjRLNThXOEpheEtlWHN2MnNLVmNrYUhSVU4ybHRl?=
 =?utf-8?B?Zkg0N0d6RENsWWVCclVyeXNRMmFvQlRyeDlERFhrdFdPY0JyZSttb1lnK0RW?=
 =?utf-8?B?Z0VxVXV3TjZiUmpVYVkvRjN1RVpkUzZoUlUwSTF3S3ltSUZKK3NsS1gvdE1X?=
 =?utf-8?B?dmpOeHdKMUJvaHJacS9UMnFJSHdJUytpSHp3Y1YzSjlEZmtHVUFucys3UGRB?=
 =?utf-8?B?MTlSZ2pTTk56Mnk5bkhxRzhxdmtQams2dzRPdE9USXdYVk1RYVVUL1BQREtv?=
 =?utf-8?B?U0RSMWZlQ1pwYXIrd2JNWHVDMzNTQ0tuQk9IUW9TUzU3M0hIb1NUZHYxa0xy?=
 =?utf-8?B?OUV0Um8yazdwQ2FKSDVSWHRlWXBtN214NWQvaGpPS1BmdUlSbWFLb3BBU1ph?=
 =?utf-8?B?VWZLQm9pa0VzTnIwVkI3Y2lISm1CNkRUWFNlNzlvdWZwN1NDaUJ1aXZkNDlZ?=
 =?utf-8?B?WEZwL2E5dDhiUUdUYjVueVhxbjZKUU9RY0RpSzlEbkFCdkpMNnUwODlmR3ND?=
 =?utf-8?B?dXM2OHphN0dNTHJhZmdVUmo3ZnJjajV2cGVqQTZTT3dFZnpJOVVlazZlR3FL?=
 =?utf-8?B?RDdSUEMydzlBdjVPcmwrMGl5b0haMWZRTGJjRS9jMWdEbHJubVB0UFlxRXor?=
 =?utf-8?Q?80CNUJWMvBHJ/HnlJr/CJ27yz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c58578b1-8b8b-4ac1-6b24-08dbd3888dcd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 05:26:05.7836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mD2ePBIlP0FcYuNH7q8qPwlhykxCqJWatVmzTAIuxgrfmSR6+5f6qnUZGA1e7UZpTRtKT7ECingF32+pLlL6Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8613
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/2023 9:27 PM, Raghavendra K T wrote:
> NUMA balancing code that updates PTEs by allowing unconditional scan
> based on the value of processes' mm numa_scan_seq is not perfect.
> 
> More description is in patch1.
> 
> Have used the below patch to identify the corner case.
> 
> Detailed Result: (Only part of the result is updated
> in patch1 to save space in commit log)
> 
> Detailed Result:
> 
> SUT: AMD EPYC Milan with 2 NUMA nodes 256 cpus.
> 
> Base kernel: upstream 6.6-rc6 (dd72f9c7e512) with Mels patch-series
> from tip/sched/core [1] applied.
> 
> Summary: Some benchmarks imrove. There is increase in system
> time due to additional scanning. But elapsed time shows gain.
> 
> However there is also some overhead seen for benchmarks like NUMA01.
> 
> kernbench
> ==========		base                  patched
> Amean     user-128    13799.58 (   0.00%)    13789.86 *   0.07%*
> Amean     syst-128     3280.80 (   0.00%)     3249.67 *   0.95%*
> Amean     elsp-128      165.09 (   0.00%)      164.78 *   0.19%*
> 
> Duration User       41404.28    41375.08
> Duration System      9862.22     9768.48
> Duration Elapsed      519.87      518.72
> 
> Ops NUMA PTE updates                 1041416.00      831536.00
> Ops NUMA hint faults                  263296.00      220966.00
> Ops NUMA pages migrated               258021.00      212769.00
> Ops AutoNUMA cost                       1328.67        1114.69
> 
> autonumabench
> 
> NUMA01_THREADLOCAL
> ==================
> Amean     syst-NUMA01_THREADLOCAL       10.65 (   0.00%)       26.47 *-148.59%*
> Amean     elsp-NUMA01_THREADLOCAL       81.79 (   0.00%)       67.74 *  17.18%*
> 
> Duration User       54832.73    47379.67
> Duration System        75.00      185.75
> Duration Elapsed      576.72      476.09
> 
> Ops NUMA PTE updates                  394429.00    11121044.00
> Ops NUMA hint faults                    1001.00     8906404.00
> Ops NUMA pages migrated                  288.00     2998694.00
> Ops AutoNUMA cost                          7.77       44666.84
> 
> NUMA01
> =====
> Amean     syst-NUMA01       31.97 (   0.00%)       52.95 * -65.62%*
> Amean     elsp-NUMA01      143.16 (   0.00%)      150.81 *  -5.34%*
> 
> Duration User       84839.49    91342.19
> Duration System       224.26      371.12
> Duration Elapsed     1005.64     1059.01
> 
> Ops NUMA PTE updates                33929508.00    50116313.00
> Ops NUMA hint faults                34993820.00    52895783.00
> Ops NUMA pages migrated              5456115.00     7441228.00
> Ops AutoNUMA cost                     175310.27      264971.11
> 
> NUMA02
> =========
> Amean     syst-NUMA02        0.86 (   0.00%)        0.86 *  -0.50%*
> Amean     elsp-NUMA02        3.99 (   0.00%)        3.82 *   4.40%*
> 
> Duration User        1186.06     1092.07
> Duration System         6.44        6.47
> Duration Elapsed       31.28       30.30
> 
> Ops NUMA PTE updates                     776.00         731.00
> Ops NUMA hint faults                     527.00         490.00
> Ops NUMA pages migrated                  183.00         153.00
> Ops AutoNUMA cost                          2.64           2.46
> 
> Link: https://lore.kernel.org/linux-mm/ZSXF3AFZgIld1meX@gmail.com/T/
> 

Forgot to add skip_vma_count trace results:

autonumabench: numa01_THREAD_LOCAL 3 iterations

base:
inaccessible:13133
pid_inactive:15807
scan_delay:471
seq_completed:50
shared_ro:6983
unsuitable:3917

patched:
inaccessible:4727
pid_inactive:5119
scan_delay:455
seq_completed:7
shared_ro:2551
unsuitable:5402



> Raghavendra K T (1):
>    sched/numa: Fix mm numa_scan_seq based unconditional scan
> 
>   include/linux/mm_types.h | 3 +++
>   kernel/sched/fair.c      | 4 +++-
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> ---8<---
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 010ba1b7cb0e..a4870b01c8a1 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -10,6 +10,30 @@
>   #include <linux/tracepoint.h>
>   #include <linux/binfmts.h>
>   
> +TRACE_EVENT(sched_vma_start_seq,
> +
> +	TP_PROTO(struct task_struct *t, struct vm_area_struct *vma, int start_seq),
> +
> +	TP_ARGS(t, vma, start_seq),
> +
> +	TP_STRUCT__entry(
> +		__array(	char,	comm,	TASK_COMM_LEN	)
> +		__field(	pid_t,	pid			)
> +		__field(	void *,	vma			)
> +		__field(	int, start_seq		)
> +	),
> +
> +	TP_fast_assign(
> +		memcpy(__entry->comm, t->comm, TASK_COMM_LEN);
> +		__entry->pid	= t->pid;
> +		__entry->vma	= vma;
> +		__entry->start_seq	= start_seq;
> +	),
> +
> +	TP_printk("comm=%s pid=%d vma = %px start_seq=%d", __entry->comm, __entry->pid, __entry->vma,
> +			 __entry->start_seq)
> +);
> +
>   /*
>    * Tracepoint for calling kthread_stop, performed to end a kthread:
>    */
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c8af3a7ccba7..e0c16ea8470b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3335,6 +3335,7 @@ static void task_numa_work(struct callback_head *work)
>   				continue;
>   
>   			vma->numab_state->start_scan_seq = mm->numa_scan_seq;
> +			trace_sched_vma_start_seq(p, vma, mm->numa_scan_seq);
>   
>   			vma->numab_state->next_scan = now +
>   				msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
> 
> 

