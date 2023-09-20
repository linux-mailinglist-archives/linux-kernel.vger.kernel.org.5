Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFEB7A797B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbjITKnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbjITKnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:43:14 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F05AC2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 03:43:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQDs6qsuDumtTCQTVrtGOVAcCu9AOIlFez/RCCDPkHZyvHl4BaoctNd0ENfu0Mg0cEmroCbwUzrUMyM59s6d2jFPahBN5nBwSD/G+ecp5Qc+RnHtiYbCFw6AHz6cZXgD7Z65THryxDjDhF9q96/nd4AOCK3aiq8pFaBA7s2ZOUr7VFQRB9Jt3toPwOvWeLzP740ArYz02WZB9MrD0heJSvUW1smP1yj7JHpcoWKXpAvdr5RlDkbYLlXJJCyd4Eu29viHUX/HKQezBalD0Zgim3/HhWUzrp9rwb1gW7gmc6feHq6tHxVZv7sGlgKeVjctKnFd40W42O9Eirn98iX0Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iscMtwZmoDtCOZLt5MXdHnj5VU27DUR2xWVqetmXgFg=;
 b=NaiJl5yxXGVd2nBFGgcyoHOQTF/qTol2HKFXN4kOs1T64VwMABu2RbnNGv9K4ZpIuFreSeaVoEg9AB3PoaaKk/JQoNOU1VFD+aIBPlFF7+tn9TsVgJh9JJqVhlJO8Rq7bUA85h3oNs/XopAc/yGRC6uclMIF6Ly4og9GD4MEWM5zzqof9UjKwuTQ+ClClqH0BJMvL4Svh+JJcB3mkmf/HG3uR6OlrUVHmSseUWN7wj0Lvr8XvcX9/2Cpgrwgk0ttWbsazdrJjHA30Z8C0mXvBZNnuRa1ikajg3I1bF880PBS1BYKvB7Zc7SRG1Xq/pxRJtKoNMUyoOCgkVuBymLg/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iscMtwZmoDtCOZLt5MXdHnj5VU27DUR2xWVqetmXgFg=;
 b=Un9IRyzyWCBzciEXnzLIcPMFKKA1rHhvofLXnBRjbxQngG7A31gKiHoNU2bA7HozyiD4WckTYlCNHmpEbGf67BhhQKCDMtYNxKxeLt/Bn29uf4XjdyWe8I+AQ01hYgGia0n/3MxhzJ921yJvWYUIe7xJj3UXspvJ1DEYW/5LrSE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by SN7PR12MB7299.namprd12.prod.outlook.com (2603:10b6:806:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Wed, 20 Sep
 2023 10:43:00 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::74d4:ad6f:f00:8187]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::74d4:ad6f:f00:8187%3]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 10:42:59 +0000
Message-ID: <6d9d7ad8-58ba-1da8-a046-466b1ebfcf8e@amd.com>
Date:   Wed, 20 Sep 2023 16:12:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH V1 0/6] sched/numa: Enhance disjoint VMA scanning
Content-Language: en-US
To:     Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>
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
References: <cover.1693287931.git.raghavendra.kt@amd.com>
 <20230919092830.GF21729@noisy.programming.kicks-ass.net>
 <20230919162215.2cszdylo2skevnr6@suse.de>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20230919162215.2cszdylo2skevnr6@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::27) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|SN7PR12MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: 212b0e51-c107-432e-8081-08dbb9c65b2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nqmga66funyYy95t+4irLXrr1lazMKvphey8tCiVrqotJIcEAxRY0R6nJ5CBjaZ4khvTGe1O4UVQXiB5OZRhYC4CCLewT/hNfsGoNLR0fa5Jkx46OWC5zCnOC3ovSXKmCpA/7oU2AFzSC/MyytXutWGneGHARD2npCZJp4HByhEZCL2h3j/emDGe/dCN51G8a11FDaXXknJ58AnKu4uGtmJkaCOD2P2MpvbXRFhuVAYJ2+7TZ5COodf63L0iaR37bHaYRiZSKfWfY/uxm8Kt2WvFwwVsegJQgFYbbPmT94ieEcf973h6vHfrLEmfMhARCuxY5JNrtE+ybVI+ao82XzVqjdseegAlKtTUKYMu9w1npswIBzImVxWofI8kF7e0nWCaEZEs6DCOWXSrm76C/ej47ikuxEVPsAg1Wh0s9syXalmqk4/0tvDwVyxx/SkVokex3RsJ0XbfFMztcc6k8DEaOz6lBx63nbzP8VVW1xJfZZ+8AxRkVBpAqi/z6pUktaxdVJ+M+sB8zDF+Kg2E9MRz/pTZ12nt5icaVotDLny9fnsMtWiJxs6W3hZ90+uCfgnUlP19itInAVz4hUPBprnl5vUt3iMzXSaZmkN9TpPyMT1Ag/xNYtffKK30ZVAG5L6SmaykJS8s3/UmzwxHaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39860400002)(366004)(136003)(186009)(1800799009)(451199024)(6666004)(966005)(6512007)(53546011)(6506007)(6486002)(36756003)(31686004)(41300700001)(110136005)(66476007)(54906003)(66946007)(478600001)(316002)(66556008)(38100700002)(31696002)(8936002)(8676002)(4326008)(26005)(66899024)(5660300002)(83380400001)(2616005)(2906002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDg0Tmk5dkxmeEVhSHlKRHBMbHdpWkNqaTNOWFJpUjllUHkwdXVuUEtZYzNH?=
 =?utf-8?B?TEVNZkprdU1WK3orMVpSUHBRblQvV2lsalNzQk1LdDAvaEtEanczOTEyN2NK?=
 =?utf-8?B?aFZmZGtIVkdldGhpWVhLZmcxcUQrNmY0bmtUbXpIV0hKOVpoUXMrVGVvMU5Z?=
 =?utf-8?B?WUhWWG80TlYvY1IxTnVtMDBINjFBSjhPWWkzcmJzWDFYckdzd243aVVZczNB?=
 =?utf-8?B?V2prL0FSeXd3WW9GU3c0ZUJMWVpFMVNmdStpSkFUSkhuNjR5blVtdmhkN2wv?=
 =?utf-8?B?VEVKenhNY09ybUtheVVGRHBzZkpYWHBNcC9pTUpFYWpWdk1xM05TaXJYeGYz?=
 =?utf-8?B?ZEZ3OCtyWG1JUFUySWhPVGs3VS9KVW9USDRmM01lQVdiNGgyZGZucEFCdlov?=
 =?utf-8?B?MzdPRHloNjZRb0tka1hNbUZwUFFObmRvaGN6ZWx0cVNLdHNJbXNIMmFmQ2Ey?=
 =?utf-8?B?ZEszQitsVFA4UDFLSVhSQWUyYXFKYXVyWElmVEhBOUkzTkwzSEdlNTVmVTFU?=
 =?utf-8?B?dWN1Sk0yTTBURUNiN2NkODZOaWM4WXVXRG1JYmo3WXp2TEtydHUxaEZZcGlo?=
 =?utf-8?B?UUJOd3FUNElhakRFN3krSFhMUUpzNzZ1QVZWQk84bWpvTk9iTDhPVGJhaTYx?=
 =?utf-8?B?UUNaZW1xbjhXMmN4M2w5L3M2UGxuQkorUGFOYjJ0cjZRWGxzaWM1Nnd2SXg3?=
 =?utf-8?B?MDJKS2xhR0UvZjhmYXZGbmVsMXdDQ2tIUHY2VjA3dy9wME1FSFdkalJTeGNQ?=
 =?utf-8?B?SmUzeTNzZTNscmloTGtmeEptR0FEeG5Ja0psWStNUy9HOTZkMGszZmZaTUJO?=
 =?utf-8?B?ZElzSXBhc0ZXSUJ1cGxoN0ZESFc4NktOZ0hhTjYvTnR5SFhKcExwcTlWaURS?=
 =?utf-8?B?dEMxUkQ4UnMveXVYZVFZT3dWL3ZiTVlCbUw1YTdOVmFUWFJnV1U2NXpkM1Ft?=
 =?utf-8?B?MDk1WE0vMFY1RVJwM1VYcndmanh2WThhUDdSUXp1MmhsMkI3NWpTUUdnZ2xm?=
 =?utf-8?B?Qkl5MXU3K0NDbGF5UUdtQ016NUcwME43TWF4RG5nWkdZaCtPMVF5NW1ScmIx?=
 =?utf-8?B?NmtaczZ2aXk1U2cxUEl5T0JBWFJpOWV5T1FDdEVIazhnbzkzdzlFVEIraTNF?=
 =?utf-8?B?bGVwNHdKSGtpVEdvcmhtMkw3ODE2Q1FyQk85aTRIT29pYlFIcmJEblRjVkVJ?=
 =?utf-8?B?dUp6b2M0eW9KTTBIc2JFbDhQUmRKN25wbkpIbEUrSDM0cWVmVkw1NUluNmVW?=
 =?utf-8?B?K1h6UG5OVG02enlSL3lDTlhoTXJHdk1hTXg0RW1MRVI1aDBzZXhMWkdMdDVD?=
 =?utf-8?B?MW1WMndsQVl1UUI0b1ZSU0tnUndQV01VSGxFTll6Uk1qamd4ZFpDUEZPZEJK?=
 =?utf-8?B?S0oyL0ZZYjJsZ3ZCUUxHMnNieE01V3ZBZnR6RmZVbkh1L2FNWjR3bHRDWEEw?=
 =?utf-8?B?UXBtT1dhZUtyR0VTWURDWVBCeWVTOXo2VHcraXdSYVlyY0hTejJ0UWtRREds?=
 =?utf-8?B?akgzb2djN29yUFRXMVNHQzF0TzBYRXVTSlJPYkxyT3d3aWRWZXZTUHQyVG1S?=
 =?utf-8?B?SG5HYnh6cXNXajZtOStDbGdkZkpkY2NYV0ViaGZQcmJUTSszbU1EMjJpN05v?=
 =?utf-8?B?V05JRG0vOWg0UWpzbmZPTUhoOTlybjlMRW9kY2JNcGVYN2VscW1vdGRYZ3lh?=
 =?utf-8?B?RVB2KzN4OXZEMkJ6RStRaC9MQ2FzeVByMExGVUlUNUJ1dTVuNmF6dFBSdFlL?=
 =?utf-8?B?Qmg0OUIzbG9SSHhWSXI0NWczT3dnODdDZzdYbllCZzFTT0NhUU4wcXc1dERG?=
 =?utf-8?B?RDhhakJJOGpJMnlzVlVDWGVFbC9WSmlrRzRlV0NVTDkzaVVSa3J6VDllb0FH?=
 =?utf-8?B?aTlYMDVTMGtGbUs2NElDSS9oNHVmcFZWdGFLMnIzY2ZDWVY3L3FUWWRQS0RO?=
 =?utf-8?B?M21WczZtRVplYTdmeXJjZm1SYTlHVXZaS05IblkrSTI5RHd0UXRPSlNBM2hC?=
 =?utf-8?B?UHV6RVpvUGZjRVpXbGpBZVRUNkRta0hZbUp0anVrcDRGWEhHUWd6QWFiSzlz?=
 =?utf-8?B?NHdpNTEvS0FUd0dwUnUzRmRzUU5CRXBMMVdBQldVZkkvRENHSDAwV2NpTmx6?=
 =?utf-8?Q?YsKLpGWv6jGtLbHPkTbPOtTly?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212b0e51-c107-432e-8081-08dbb9c65b2d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 10:42:59.6712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dcL7i5sULzwcpJ8YSEOP7u7OoFG0iSHl3r+LC5DfehfQ6H5qfuf0fd8CW+4xss2XZ4tU6eX7xvIstJZbKxj4ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7299
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/2023 9:52 PM, Mel Gorman wrote:
> On Tue, Sep 19, 2023 at 11:28:30AM +0200, Peter Zijlstra wrote:
>> On Tue, Aug 29, 2023 at 11:36:08AM +0530, Raghavendra K T wrote:
>>
>>> Peter Zijlstra (1):
>>>    sched/numa: Increase tasks' access history
>>>
>>> Raghavendra K T (5):
>>>    sched/numa: Move up the access pid reset logic
>>>    sched/numa: Add disjoint vma unconditional scan logic
>>>    sched/numa: Remove unconditional scan logic using mm numa_scan_seq
>>>    sched/numa: Allow recently accessed VMAs to be scanned
>>>    sched/numa: Allow scanning of shared VMAs
>>>
>>>   include/linux/mm.h       |  12 +++--
>>>   include/linux/mm_types.h |   5 +-
>>>   kernel/sched/fair.c      | 109 ++++++++++++++++++++++++++++++++-------
>>>   3 files changed, 102 insertions(+), 24 deletions(-)
>>
>> So I don't immediately see anything horrible with this. Mel, do you have
>> a few cycles to go over this as well?
> 
> I've been trying my best to find the necessary time and it's still on my
> radar for this week. 

Hello Mel,
Thanks you a lot for your time and for having a detailed look, and your
patches.

In summary, I will start with your patchset.
Link:  https://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git/ 
sched-numabselective-v1r5
and see if there is any cumulative benefits from my patches (3-6) on top 
of them.

Trying to give out some details for your questions. please skip if its
long..

Preliminary results don't look great for the first part
> of the series up to the patch "sched/numa: Add disjoint vma unconditional
> scan logic" even though other reports indicate the performance may be
> fixed up later in the series. For example
> 
> autonumabench
>                                     6.5.0-rc6              6.5.0-rc6
>                           sched-pidclear-v1r5   sched-forcescan-v1r5
> Min       syst-NUMA02        1.94 (   0.00%)        1.38 (  28.87%)
> Min       elsp-NUMA02       12.67 (   0.00%)       21.02 ( -65.90%)
> Amean     syst-NUMA02        2.35 (   0.00%)        1.86 (  21.13%)
> Amean     elsp-NUMA02       12.93 (   0.00%)       21.69 * -67.76%*
> Stddev    syst-NUMA02        0.54 (   0.00%)        0.90 ( -67.67%)
> Stddev    elsp-NUMA02        0.18 (   0.00%)        0.44 (-144.19%)
> CoeffVar  syst-NUMA02       22.82 (   0.00%)       48.50 (-112.58%)
> CoeffVar  elsp-NUMA02        1.38 (   0.00%)        2.01 ( -45.56%)
> Max       syst-NUMA02        3.15 (   0.00%)        3.89 ( -23.49%)
> Max       elsp-NUMA02       13.16 (   0.00%)       22.36 ( -69.91%)
> BAmean-50 syst-NUMA02        2.01 (   0.00%)        1.45 (  27.69%)
> BAmean-50 elsp-NUMA02       12.77 (   0.00%)       21.34 ( -67.04%)
> BAmean-95 syst-NUMA02        2.22 (   0.00%)        1.52 (  31.68%)
> BAmean-95 elsp-NUMA02       12.89 (   0.00%)       21.58 ( -67.39%)
> BAmean-99 syst-NUMA02        2.22 (   0.00%)        1.52 (  31.68%)
> BAmean-99 elsp-NUMA02       12.89 (   0.00%)       21.58 ( -67.39%)
> 
>                     6.5.0-rc6   6.5.0-rc6
>                  sched-pidclear-v1r5sched-forcescan-v1r5
> Duration User        5702.00    10264.25
> Duration System        17.02       13.59
> Duration Elapsed       92.57      156.30
> 
> Similar results seen across multiple machines. It's not universally bad
> but the NUMA02 tests appear to suffer quite badly and while not realistic,
> they are somewhat relevant because numa02 is likely an "adverse workload"
> for the logic that skips VMAs based on PID accesses.
> 
> For the rest of the series, the changelogs lacked detail on why those
> changes helped. Patch 4's changelog lacks detail and patch 6 stating
> "VMAs being accessed by more than two tasks are critical" is not helpful
> either -- e.g. why are they critical?

Agree, for patch 5 and 6 (scanning shared VMA and recently accessed
VMAs) there was a brief rationale in cover letter, but it was not enough
perhaps.

More background:
I had used trace_prints to understand vma sizes, PID hash, success
percentage of is_vma_accessed(), and also how many tasks are typically
accessing etc for some of the workloads..
(vma_size here was in KB)

E.g.,
<...>-1451602 [116] ...1. 39195.488591: vma_fault: vma=ffff8bcab42ad7b8 
pid=1451602 hash=40, success=1
            <...>-1451481 [210] ..... 39196.948390: sched_numascan: 
comm=numa01 pid=1451481 vma = ffff8bc9228637b8 
access_hist=4200000cfe66727 hashval = 26 bitmap_wt = 22, vma_size = 
3153924 success = 1
            <...>-1451570 [052] ...1. 39196.948725: vma_fault: 
vma=ffff8bc9228637b8 pid=1451570 hash=25, success=1

1) For very large VMAs we may incur delay in scanning whole VMA,
because we scan only in 256MB chunks and filter out tasks which had not
touched them etc, So idea was to speed up the scanning.

2) Similar rationale for recently accessed VMA, i.e., not to delay
scanning for a very recently (hot) accessed VMAs.

[ I did not explore using young page info, mm walk etc as I thought it
may be expensive ].

> They are obviously shared VMAs and
> therefore it may be the case that they need to be identified and interleaved
> quickly

Yes. Mostly that was idea as mentioned above.

> but maybe not. Is the shared VMA that is critical a large malloc'd
> area split into per-thread sections or something that is MAP_SHARED? The
> changelog doesn't say so I have to guess.  > There are also a bunch of
> magic variables with limited explanation (e.g. why NR_ACCESS_PID_HIST==4
> and SHARED_VMA_THRESH=3?),

Those thresholds were result of multiple experiments I did.
(SHARED_VMA_THRESH = 3,4 .. NR_ACCESS_PID_HIST=3, 4 etc ).

One thing I did not look is whether I should reduce PID_RESET interval
(because we are maintaining more history now.)

> the numab fields are not documented 
Agree, I should have done better earlier.

> and the
> changelogs lack supporting data. I suspect that patches 3-6 may be dealing
> with regressions introduced by patch 2, particularly for NUMA02, but I'm

TBH, Did not really target to worsen num02, improve num02 later.
This is the data I had for the full patchset.

autonumabench
                              base                   patched
Min       syst-NUMA02        0.99 (   0.00%)        0.99 (   0.00%)
Min       elsp-NUMA02        3.04 (   0.00%)        3.04 (   0.00%)
Amean     syst-NUMA02        1.06 (   0.00%)        1.05 *   1.08%*
Amean     elsp-NUMA02        3.80 (   0.00%)        3.39 *  10.68%*
Stddev    syst-NUMA02        0.10 (   0.00%)        0.07 (  24.57%)
Stddev    elsp-NUMA02        0.73 (   0.00%)        0.34 (  52.86%)
CoeffVar  syst-NUMA02        9.04 (   0.00%)        6.89 (  23.75%)
CoeffVar  elsp-NUMA02       19.25 (   0.00%)       10.16 (  47.22%)
Max       syst-NUMA02        1.27 (   0.00%)        1.21 (   4.72%)
Max       elsp-NUMA02        4.91 (   0.00%)        4.04 (  17.72%)
BAmean-50 syst-NUMA02        1.00 (   0.00%)        1.01 (  -0.66%)
BAmean-50 elsp-NUMA02        3.21 (   0.00%)        3.12 (   2.60%)
BAmean-95 syst-NUMA02        1.03 (   0.00%)        1.02 (   0.32%)
BAmean-95 elsp-NUMA02        3.61 (   0.00%)        3.28 (   9.09%)
BAmean-99 syst-NUMA02        1.03 (   0.00%)        1.02 (   0.32%)
BAmean-99 elsp-NUMA02        3.61 (   0.00%)        3.28 (   9.09%)

Duration User        1555.24     1377.57
Duration System         8.10        7.99
Duration Elapsed       30.86       26.49

But then, I saw result from Kernel test Robot, which compared individual
patches,

commit:
   2f88c8e802 ("(tip/sched/core) sched/eevdf/doc: Modify the documented 
knob to base_slice_ns as well")
   2a806eab1c ("sched/numa: Move up the access pid reset logic")
   1ef5cbb92b ("sched/numa: Add disjoint vma unconditional scan logic")
   68cfe9439a ("sched/numa: Allow scanning of shared VMAs")


2f88c8e802c8b128 2a806eab1c2e1c9f0ae39dc0307 1ef5cbb92bdb320c5eb9fdee1a8 
68cfe9439a1baa642e05883fa64
---------------- --------------------------- --------------------------- 
---------------------------
          %stddev     %change         %stddev     %change 
%stddev     %change         %stddev
              \          |                \          |                \ 
          |                \
     271.01            +0.8%     273.24            -0.7%     269.00 
       -26.4%     199.49 ±  3%  autonuma-benchmark.numa01.seconds
      76.28            +0.2%      76.44           -11.7%      67.36 ± 
6%     -46.9%      40.49 ±  5% 
autonuma-benchmark.numa01_THREAD_ALLOC.seconds
       8.11            -0.9%       8.04            -0.7%       8.05 
        -0.1%       8.10        autonuma-benchmark.numa02.seconds
       1425            +0.7%       1434            -3.1%       1381 
       -30.1%     996.02 ±  2%  autonuma-benchmark.time.elapsed_time

I do see some negligible overhead from first patch but second patch
still gave some improvement.

My observation with the patchset was increase in system time
  because of additional scanning we re-introduced but this
was still 2x better than where we started without numascan enhancements.

> not certain as I didn't dedicate the necessary test time to prove that
> and it's the type of information that should be in the changelog. While
> there is nothing wrong with that as such, it's very hard to imagine how
> patches 3-6 work in every case and be certain that the various parameters
> make sense. That could cause difficulties later in terms of maintenance.
>

Agree regarding maintenance.

> My initial thinking was "There should be a standalone series that deals
> *only* with scanning VMAs that had no fault activity and skipped due to
> PID hashing". These are important because there may be no fault activity
> because there is no scan activity which is due to to fault activity. The
> series is incomplete and without changelogs but I pushed it anyway to
> 

Agreed.

> https://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git/ sched-numabselective-v1r5
> 

Thanks.. Patches are simple to start with (1-4) with a force scan in
patch5. Will experiment with these.

> The first two patches simply improve the documentation on what is going
> on, patch 3 adds a tracepoint for figuring out why VMAs were skipped or
> not skipped. Patch 4 handles a corner case to complete the scan of a VMA
> once it has started regardless of what task is doing the scanning. The
> last patch scans VMAs that have seen no fault activity once active VMAs
> have been scanned.
>
> It has its weaknesses because it may be overly simplisitic and it forces
> all VMAs to be scanned on every sequence which is wasteful. It also hurts
> NUMA02 performance, although not as badly as ""sched/numa: Add disjoint
> vma unconditional scan logic". On the plus side, it is easier to reason
> about, it solves only one problem in the series and any patch on top or
> modification should justify each change individually.
> 
Anything else you have in mind that I should look into apart from
above (Rebasing to your patches and experiment with my patch 3-6 for any
cumulative improvements ?).

Thanks and Regards
- Raghu
