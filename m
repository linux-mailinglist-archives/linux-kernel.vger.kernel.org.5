Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C057DEC31
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 06:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348532AbjKBFRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 01:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjKBFRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 01:17:50 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9926B112
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 22:17:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9uJWWch6mCiRoObQfHcGXm8Uek1vPaBb+4vZPMNQ4kM44fuKLuM7fZHrSprxCs+F1bLjwCtx3RZ02wkPX6GCCjp30eTauFoVKKIDhEmPWOCzz1k4c7YwE4I21dAYioj2fRUcOQIKsaj51ti8+MHIFFYL/dTWwqAOMSsQwjx5m3iofLAzPpULhMRqciNqmBrgse4IHeMSfCwzgLAPA2VLYmyjqzflrPljmylysYDptARp0lYgZiFP2Ks/PodtEiobqObi6MM9Bu5sl3PVremVSNrmFjrsvwnK3lvebMGqKNqhwXk4y3lhcHtMrqguu3ofLWw+xIjNleIp259CBBfSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0gVryhlMvPYMt8Jp8+S5ibAhbXlG5uimro045rsLk8=;
 b=XswuzeW0MEswaCsUILacqHzt7DuhEYPIINTlrEJ9FXGHvcGiepXbSNK/4SZqJEECNZKCvkw+T9dWXFa1IxI5Flg4HDPVQ1TiuDPWRV64U4ixypjtO24Pwl4uuNP2eKrOB2kLG0Vj809dkn1t0uyMwVfQ/8IjvorNOjSiE4k4WoGcd0pm856PmgTbHvb/xV9LF+UQsew4hnBUKliHVk7qTE1oDGkz0MBypibTs11aPu2l5gyv3u5ijz3dmIGtycfqpmB7Ijbevbmex3fs+Hna5bAUopZucjSlbu9dLG8V6DhsSAk/Sdg08GiHbJkvF/oTvyU0G51T/FWSdwjNecVKxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0gVryhlMvPYMt8Jp8+S5ibAhbXlG5uimro045rsLk8=;
 b=G8BZC3OvWpXOJzJbnQxrzD3tSvT3m33ytKv4OyFk+d+wAiM4d9DDgu9XqsurmKTPzFfxUbr7/dORQjYOcl7OVh6cYsu64S4DHuX8L7zHiEc+g/Y8CmH80FqoXy9zkfapJBqrspPwQ4wyAc9yC1+GfasFJ+QFARsNsUYJlkZQPJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by DS7PR12MB5814.namprd12.prod.outlook.com (2603:10b6:8:76::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.19; Thu, 2 Nov 2023 05:17:39 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::fac7:2586:9cc6:e566]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::fac7:2586:9cc6:e566%4]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 05:17:37 +0000
Message-ID: <bb5cf1ee-62ef-5019-4974-88a66555557f@amd.com>
Date:   Thu, 2 Nov 2023 10:47:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V1 1/1] sched/numa: Fix mm numa_scan_seq based
 unconditional scan
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>, Mel Gorman <mgorman@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
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
 <2ea7cbce80ac7c62e90cbfb9653a7972f902439f.1697816692.git.raghavendra.kt@amd.com>
 <20231101092101.i562axvfqjdvw2rx@suse.de>
 <20231101103114.GK15024@noisy.programming.kicks-ass.net>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20231101103114.GK15024@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::13) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|DS7PR12MB5814:EE_
X-MS-Office365-Filtering-Correlation-Id: a30cf9d6-72be-4849-4627-08dbdb6306e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GK/b+XO9Y09YQ2PYGYCj6a5iZVHIj/J2Q0ku10oWq5/anZGDPJ3KzbX27zPcDp0lP7a5ruPZ4WAjtWLXxbdUnYX2J5wJxVnI5we8JivRXdfmkzxfYkpB+nrIjDFdZYr6HKosOQ7EN9aPjlBcCkwgtTcG68BFRzYKm1zpH3PTPvzzTMOyz8zGETWm36Ug1NdDWguYGjrYA/M71TYckT/V1f+Bz8En0QdKu6dyPDBK/gdPhSytBuwkcAbVlFnQl7aRQikMEyvVainNaZCkP70TCXav1Tu8gLiYVAuiXq6PGUXbmRzKVq+7dEy9vpzxPMi5hfie7LTMz9bFW0nNNoovOfUZ+q9hpGUugIHFqQfFKfhey2Ng06rLHWhmKy9H5Mq7OPCIkcYtWOBjQzq2q+a4PGfkGrgEOBusNXiC8f7e6h5oD828qS10JoYkYjyMgQvUR4hYHz2N7tOs/rR3e2zhhVM4PjPkj28N9IyGJcdQsNL7arx1JH9DXQpC/Yge/1bXytahHhMWIPKFj3IPqAeYWxpLIWXG9w+U97uEgAsOosRzwqeSfiiqW4YWucFncurcY9O6fJo8zR+xRDV+6aU0yckcoRDPRTBzYdVLxK40Y+YyRlLr0uWABiaQMccKTW6Fb573ukPo9GSE9C1ghc5H6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(376002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(26005)(6512007)(2616005)(6666004)(6486002)(53546011)(2906002)(6506007)(5660300002)(478600001)(8676002)(66946007)(66556008)(41300700001)(110136005)(4326008)(966005)(316002)(66476007)(54906003)(8936002)(36756003)(38100700002)(31696002)(83380400001)(7416002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2VsVHBSUFo1RG00ZGZ0T0MybFNDYWtacHdtOVA2bkVTNDh5dTZtOXRNZDdT?=
 =?utf-8?B?SHlRR0RpWE1xTFNsZFFIbUtXUG5EMGFSTk80SC9BVEp0bG9iWUF6VkJtRlVV?=
 =?utf-8?B?VE9CR1hVOG5rNldiVWM3VEJ5bDdQcmVEVXlwRnhQVkN3WWhPVEZXZkVlZWpW?=
 =?utf-8?B?MWNFMTZpM3c0NmJwZGliaUIvWDFKd3JFSXgyUmdueHgyc3NzVFIvbWhvR1Zv?=
 =?utf-8?B?T0ZrOHZwUkVYY1dHNW51Yk4wd2RrbmM3VW9JeWltSUdBK0t1dkVDY3Fha2Fr?=
 =?utf-8?B?dWk1QkRpNzJWd2tnVjJGSitiZG14N1Y3S3BndXdEV2lmeDNNUm9vNkpmTkRa?=
 =?utf-8?B?OVlRSDVnVG9pWFRVQ01xNk5yb3ZXTFBMblNzOWlUNEVWdXFwcHVLQ2c3TVFP?=
 =?utf-8?B?cUJMVTF2NzNpMUhFTENvRWNLdGY5ZmlsUVRUTE50TzdTLy92QUZiT3VkTTNL?=
 =?utf-8?B?dThUampXdWR3eHVSMnFhbzhpanpNellmbXg0RXBlL3M4c09WWVZ0NFhJQ3p6?=
 =?utf-8?B?MEhnbFo2SnhSY0dBZGl2dm9sREdXRXNUcHZKVllFNW1jdElRYXQwa3BWK2lw?=
 =?utf-8?B?dlI5Y1NFeHZXNFdESmcxRFRYRjFDS202M0JTeDN2S1NjTk5RU0diTEJ3S3NP?=
 =?utf-8?B?bTNVYVFZRVFLWE9rcnc2cUVhQ3FlY092em1IOGRpaE1xL3FmSzRydVlWdjFH?=
 =?utf-8?B?OURQYyt6VmlQMVcyZFZoL0Qya09OWUFFT1ZNSStTZS9BaWg0Y1VrbXZraFlu?=
 =?utf-8?B?N05qaHJpc1JCTDdpMFJFbFdDNFllMzJwSlpjN0E0R0dRTnh1N3d3SVg1VGFR?=
 =?utf-8?B?eDNkN0VtS2xyUk5RdDdQb0RpK2hvMG9sOTBSQWVwbEY2c09VTUxKa21NREtF?=
 =?utf-8?B?SGZHWW1QZFVjT2kreWtuWFVwa29XUnZOQ3RyTU5zeEpuVnBMSWZ4S1h2MVZr?=
 =?utf-8?B?R25Db1NwTVBOcWJxNTk2ZHFiMXBzN2dSbE1wSGlvU3B6Y0NMQVVjTHhPNnZT?=
 =?utf-8?B?dVZkSnh1anlKa0FITFMrRmVRQVBWL0pkck0zVWtPSTlhWGRQd1VQUEt2QkRq?=
 =?utf-8?B?MEJhUHN6b0JXZHNhT2RuTDRFZU9qRDRGb2V1ZTlFMW5HN0V6ZnBQcG4ySndV?=
 =?utf-8?B?WVZ3K3RYUlBPMi8vVHFwbFQ1eDRSRk5SbVhpTEFna3AzcUxVOHVIMzZvaUtS?=
 =?utf-8?B?UDRhVE9EOWt6aTU5TmNLbE1hYVozd005cWVGZTIzNjZmRWpBQ3k1RXZ3Zi80?=
 =?utf-8?B?THdkbVBBcmNudDNnU2VZSUxDYUZkWVlkcDZ2bVFjcFdYQXBqNlNxdTl3eFJU?=
 =?utf-8?B?a2VrRGhjczhaR3BTbjBpdmh0alBsU0F5cktLV1R4ODUwN2R0L1hKN3NJc3h6?=
 =?utf-8?B?VndDM0xRUkhvNUlLUDFQS3EwK2lLbXdRWmJjUkUwOHo2Q09qU0xqblluQXlU?=
 =?utf-8?B?NWdpY1ZhalY5Y3U0SVp1TE1aMU5Zcko5QXBuWXc4QURub01FMUhHaDRJZ2NU?=
 =?utf-8?B?YnZrUnJHRTN5Q1duTkszdmR5YU93QkMxVTJjUTBkdzhjZHRsSm5lOTZ0N1BH?=
 =?utf-8?B?TUtSZzNXTENhWDVYUHhVMHFCT2lYcVZVd21zQWVlemZTUnRLS1RrdS9jRmtB?=
 =?utf-8?B?SGNHR05MTERSMkZ2TmpIeTg1WmtDWmY1NURWYWYvMjc3TG1mUjR1ejVHZFJ3?=
 =?utf-8?B?OWxnZWpmR1pxMzBVUXo4RFViL0dkT3FkQi9rVlUzNFp1NE9oSS8ydzcvaGxy?=
 =?utf-8?B?bUgrYjAwM29VQVZLL29SZFdLTmNlMWo1aTI4TGxQVFMrNFZsckdPQzVscTQ2?=
 =?utf-8?B?NklUd3B2MjVxdVF3UFFwb2JYVEVmV0xINXNURStYMTNXM3NmNmdlWVhiV2ll?=
 =?utf-8?B?Wi9Sbm1SMXZQa0VWaGZseHJFZmd0TDNnWmgvU0tuNFJBYUR4UVJCOW44TnFk?=
 =?utf-8?B?SEdlcThMWUdISyszNjdtVFoyRG5ybE9pR2w0dVBmbHhiRXhoTlBWWFBlaXhO?=
 =?utf-8?B?dmJCa0pzTldrTUhPc3JXTFp5NUJGMC9VTkpmRXgxRVlxSklucE5xWFBPbjY4?=
 =?utf-8?B?cjVqYVhlK3U2QnJOUmg5eHFJNlhQcmtxVW9uc2wrWkxHSU82dHp3L2tWb1Ew?=
 =?utf-8?Q?d/XBVJ/aH1j+5FWUZ3m72oEhK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a30cf9d6-72be-4849-4627-08dbdb6306e2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 05:17:37.0562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Cyn2fjpb8ab+cN3Of2AmzgDh9PfIJeYpWh8TULdce3BmiLT5+w4OI2phRzWNRzO3A6SWJGDJEPrLEJoZxedqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5814
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/2023 4:01 PM, Peter Zijlstra wrote:
> On Wed, Nov 01, 2023 at 09:21:01AM +0000, Mel Gorman wrote:
>> On Fri, Oct 20, 2023 at 09:27:46PM +0530, Raghavendra K T wrote:
>>> Since commit fc137c0ddab2 ("sched/numa: enhance vma scanning logic")
>>>
>>> NUMA Balancing allows updating PTEs to trap NUMA hinting faults if the
>>> task had previously accessed VMA. However unconditional scan of VMAs are
>>> allowed during initial phase of VMA creation until process's
>>> mm numa_scan_seq reaches 2 even though current task had not accessed VMA.
>>>
>>> Rationale:
>>>   - Without initial scan subsequent PTE update may never happen.
>>>   - Give fair opportunity to all the VMAs to be scanned and subsequently
>>> understand the access pattern of all the VMAs.
>>>
>>> But it has a corner case where, if a VMA is created after some time,
>>> process's mm numa_scan_seq could be already greater than 2.
>>>
>>> For e.g., values of mm numa_scan_seq when VMAs are created by running
>>> mmtest autonuma benchmark briefly looks like:
>>> start_seq=0 : 459
>>> start_seq=2 : 138
>>> start_seq=3 : 144
>>> start_seq=4 : 8
>>> start_seq=8 : 1
>>> start_seq=9 : 1
>>> This results in no unconditional PTE updates for those VMAs created after
>>> some time.
>>>
>>> Fix:
>>> - Note down the initial value of mm numa_scan_seq in per VMA start_seq.
>>> - Allow unconditional scan till start_seq + 2.
>>>
>>> Result:
>>> SUT: AMD EPYC Milan with 2 NUMA nodes 256 cpus.
>>> base kernel: upstream 6.6-rc6 with Mels patches [1] applied.
>>>
>>> kernbench
>>> ==========		base                  patched %gain
>>> Amean    elsp-128      165.09 ( 0.00%)      164.78 *   0.19%*
>>>
>>> Duration User       41404.28    41375.08
>>> Duration System      9862.22     9768.48
>>> Duration Elapsed      519.87      518.72
>>>
>>> Ops NUMA PTE updates           1041416.00      831536.00
>>> Ops NUMA hint faults            263296.00      220966.00
>>> Ops NUMA pages migrated         258021.00      212769.00
>>> Ops AutoNUMA cost                 1328.67        1114.69
>>>
>>> autonumabench
>>>
>>> NUMA01_THREADLOCAL
>>> ==================
>>> Amean  elsp-NUMA01_THREADLOCAL   81.79 (0.00%)  67.74 *  17.18%*
>>>
>>> Duration User       54832.73    47379.67
>>> Duration System        75.00      185.75
>>> Duration Elapsed      576.72      476.09
>>>
>>> Ops NUMA PTE updates                  394429.00    11121044.00
>>> Ops NUMA hint faults                    1001.00     8906404.00
>>> Ops NUMA pages migrated                  288.00     2998694.00
>>> Ops AutoNUMA cost                          7.77       44666.84
>>>
>>> Link: https://lore.kernel.org/linux-mm/ZSXF3AFZgIld1meX@gmail.com/T/
>>>
>>> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
>>
>> Acked-by: Mel Gorman <mgorman@suse.de>
> 
> Thanks, will queue for the next merge window (6.8 I think that is) once
> 6.7-rc1 comes around.

Thank you Mel, PeterZ.

Meanwhile, I will check if extending #history (PeterZ) on this changed
baseline,  as well as implications of extending #bits for PIDS (Ingo) 
suggested (especially larger machine) helps and come back if I find
anything interesting.

Thanks and Regards
- Raghu

