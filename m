Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6B079DFF4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 08:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238276AbjIMGWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 02:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjIMGWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 02:22:15 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140DD172E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 23:22:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhF09Z21HdOrll9sXyYo1VGTPOON+UcyBeCOTFWvBnRf5Y2kPDoRCwkJY0NMzQ5EYmI95+ZmWZFFZZNrVrLOwEnrGMpyJoXNLnadLSolbuIjeEV5gcl+srVZDIhSj3jhl3VZfsXtZ3ZukjiR/lD2rjgtXoVwsbpYmbyB2c1oOVoRkR2TD1ZdKcCghBbeIvMqcUkQVmfrB6AbChDNy8XUez1VJIF+NCd4IC3Mo9jzEVC60EA60mBH+Pcr2rwqYXBfA9jbG5sT10rUgYJ/FBMBCKeML/AdookvQoUFVH5/7A0OjCqSjaXfz2RN30yADCPS7LLyGTsSLcrOVLc3kGLa6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOKuDfRyEPrh0L+Aop0ICVWW7fHCltnxBEVbyaor/vw=;
 b=lS7etl/prVwTXwKtxBj2PPcJcGA39qYUJLRCpdK8PB2pnD/Gr5xmy7PFASo5k5GJXNHaRIswMEN+zL8V+cpUulM4Co0LdMvcu+N99XgqGOTSGoeEbWQpLVJ/0tZfLEjQtLYo8pS6Jbknd0xeAqwNFINVdPV12KrVgRMOV6q/RJHwBTSicqbWtBl9cfWc9MrsE3oimV/jzfvt40LsZ3gWUpwEFUbvR16eTFH87bN7avPN2CJ2vJcybBHpIwnfQjfBQ07T0QV9WO+PR8pM+1J/nC96ATmZwedxWRaYn6dbhhnGt9M6jrJxjMJMRZPvrmQ0fhCSG1/OXoEqcLmK62VCxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOKuDfRyEPrh0L+Aop0ICVWW7fHCltnxBEVbyaor/vw=;
 b=tGf5je2BjKiiKoZJbUPlB7gtheskVnITbN4+gy8SRGfFPJztqj7u4C0UQa1sW3sdkin+Y9VCvGxCK0iCSQqnpCxSpGqryy0aOSrGbin2TdQzPwZB0cJOyrwMogf1Y5tVvCGieoolKZjU3Z3jJukTyeHwK0K1NLe5xPnyImyOfX0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 06:22:08 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::74d4:ad6f:f00:8187]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::74d4:ad6f:f00:8187%3]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 06:22:08 +0000
Message-ID: <697988e9-20bc-8cc9-c3ee-403f58a0f823@amd.com>
Date:   Wed, 13 Sep 2023 11:51:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH V1 2/6] sched/numa: Add disjoint vma unconditional
 scan logic
Content-Language: en-US
To:     kernelt test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Aithal Srikanth <sraithal@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com,
        aubrey.li@linux.intel.com, yu.c.chen@intel.com, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bharata B Rao <bharata@amd.com>,
        Sapkal Swapnil <Swapnil.Sapkal@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
References: <202309121417.53f44ad6-oliver.sang@intel.com>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <202309121417.53f44ad6-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0200.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::11) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|SA0PR12MB4512:EE_
X-MS-Office365-Filtering-Correlation-Id: f8ab5cea-1e17-425f-0dfd-08dbb421c1c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wXjRz8AGDlNaADfmCunRu+NAlVzJF/tjURXyYwWFmsWcsgqNWySxpPu9oBBYwI7Y8/dndVIhOqhGjSC+JDj+nEXQSI8stt931CAytz5sE4CL7Xcwvu5AaBsPzsI3huQQVepfLohGfw3lHkZiBUb1KYEpu9Q6Qb3qePHo8Ap1v3gAoWdskMMnwjf3l7LRe8wDHJeDYx8k2LkdyunBJeIp3qclxctDQc9Jczzk3dhQQ60jKParvYMVlr7cNS042jeHwHhdw2PzkrBKh6/zYHjcX3G1zvEXoHbRP9+sF7ZQZOxtvBVW3qlCgqP8OnEzrwAfoy0BFJi1m2JhPZFt6iSEmEXUmYxbvbg0hwuqrYtKvjj1NyfeWpnETddn+rpr1eC9K2udqUuV5km06MbKCL3+3F49WjJ09Gh67MzRqCPuYkfx53+ZuSfIhXk0K1aPwgXOg/byRnUHQefyGjo6lMl0VQE8vPptkiXogxfyS50OLzIlyHK5OPN+DDTCcOm2TXht1SqEZqjg0JItBxrX/uQOaD4K13em2Rt7oTUrqBQizTkq+FLZVaK2KJCPbwZHtN/fFFwjFJ/r5ky7vWkPEzmH5gWpwTgPYPPgqZuUzX8oEL2+F8Jrgl9uHbg1fe/xpj/zBR3aVWOR/i+SiOhxM/DQBTDkPNlM1Nd9PS10ZmMobtKvIxyDMpPrtejwBPreS87r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(396003)(346002)(1800799009)(186009)(451199024)(31686004)(6666004)(6506007)(53546011)(6486002)(36756003)(31696002)(38100700002)(2616005)(26005)(2906002)(6512007)(966005)(478600001)(83380400001)(4326008)(5660300002)(8676002)(41300700001)(8936002)(6916009)(7416002)(66476007)(316002)(54906003)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVd3UCtYQkdCcDc4ZWh3V2JGTVVZMkVGaUJ5b1R0eW1TSEpoTFZ5SFdzY29h?=
 =?utf-8?B?Y25XTWFnOSsxZ25KRlBweVVkNWdweWpuVXc4MzFaOTZoUCtXTlBkRWZ6ODJK?=
 =?utf-8?B?S0hZb05ybG9NVVh2YmFGdUZYMDlRVGZXOTlNL0tvU2wvZk5aUjh4RW4yeks5?=
 =?utf-8?B?TFNob2NiNUQ5RHUvVVo2b0pCT3hNcFd6aTNYcnBNSlRqS3Z6NDF5WW9UQlhu?=
 =?utf-8?B?ekl6cHg4Y1g3dEo2ZUhMRTIxek5kZ1VIVVZQUURMVkt0WUEvdFE0SVFtMFc3?=
 =?utf-8?B?dnhJT3FTZVQzWTIyVGtSK3Bsd3Nkb0xMT0FHcDA1R3k2bU5RQWNnVENzQlpk?=
 =?utf-8?B?Q3ZYK0FrVUR3ZW5XTUlKTmhzb1MrR3h1TGRESEh0Sy9kYUt0SGJpanFFN3E0?=
 =?utf-8?B?c1JZRVJoQ1M3aTcrTWxNYUZFRndYVUEyeE53aUlnaXR1RUV2WUFVbi9GbkJy?=
 =?utf-8?B?U1Q3K1JEeG83Z1Y1SUhuU3QzWnlaZjhJVS9ZS0thcGNKU3orOEZ2MjFnclg3?=
 =?utf-8?B?TTVRbFRmZWROdnRHOVo1UkpCOW83ZitsUlM2ZURtK1dsT0xjTXFoVmFCemVr?=
 =?utf-8?B?b3dZWU9nNFFsNENYeHVaZkVFenpONFRSWCtiNzNZK1Ribm93d2xLVzFzRXZY?=
 =?utf-8?B?U1JYZSttMFhLVkRCYXRHSDZ0STNoRjRTYkhSaTFHOERLQVc2TFVSbUtkaFZh?=
 =?utf-8?B?KzFyM2F5RFMwWlRCNTRHNk1zVWxnZkJITXIzVTM0N3plUTBlQmM5SUJhNlhL?=
 =?utf-8?B?VkI5ay9TOUNTUXMvWkh0VHlnSVBlTDJVNnl5YjFvMU91Sk9qRjdMazUvZmVp?=
 =?utf-8?B?VHRuaXUyQ1FCeHVyS2daYlpjZUpJb1BPSXlDUHFvSzZCbERxQitlcU84WlJ6?=
 =?utf-8?B?K1N4eHhMeFoxMDdvMmM2WGQ4MnlkVU45RGpGVTZYaEQ2ZEtoeEpTWGl2Rm4r?=
 =?utf-8?B?OUh5TU1FeVJCcG5xMW51eWxYSlR1Rks3MmdhR01XOXVsbGlISGR2QnpDMUN4?=
 =?utf-8?B?azlOS0IwbVZZemdBMElPQkJWR0I4RVZFOTNGS0ZkVUI1SFJob0h6cjhGdml3?=
 =?utf-8?B?L1AwM3YybDlidGhqWCtiSDA4TzBwVHBNVUwxUnB3bGw4ZVptbG1FdTNDQmJt?=
 =?utf-8?B?bXdNcDFTQ1RNZlFqMnJwNzh6NElvaUhVb2M0MWxjMkhnRVNmeENPaC9namo5?=
 =?utf-8?B?UWxSQlFKYWJPc0FiNGgyRCtTcm1RR0wyRmQraktoM3pWUHR5T2l2VVBZYTV3?=
 =?utf-8?B?dzArL2ZvK0N3bVhIQVN4cjdSeXFIQlQweE02T1RiL1MveE8rQkVuV3l6ZU5B?=
 =?utf-8?B?OFBsdEdjTklGekhBaHhZTTVXR3FIa01KQ2YvUUphbFErMmV0WXR3MzY3ams2?=
 =?utf-8?B?OHp4cDZ6VURzbDFhOVhxSzdQZUJzOHg0Q253WVhKMkNDeE10SVlHWm1DVTNa?=
 =?utf-8?B?WkhHOWM5cU8yd09GY0xpOUZGR0Z2RzZrb3Q3amxiTjdRTU5YdkQ0ZENvVk9D?=
 =?utf-8?B?dGlqMUwxOGdjV0pETHZuTmdjNzJhbVlNMmZpb1EyMVZYNlpHbkVnWDlQNTgz?=
 =?utf-8?B?cXFzRVpPd0h0eEU2bmlTWXUyWVR5MmxmejdBbU9OV3dDZDY5cXRPRXRrTDJC?=
 =?utf-8?B?ZXFnV3lISTI5cWxlQU9nSnE4MzZ1TjJxLzdIMHdNVm5YSktwN2ZZelY1ZGNN?=
 =?utf-8?B?aTZLbGRJWGhjNUlJbGNIZnE4b0hGWVlUL2tKVWttUUlkSy9telJKV1VhbmZE?=
 =?utf-8?B?YnV4c1pSMDFYNysxcVVlQ21hbktHdElRQ1RwaFMxQUFZb3FaWkw3V1ltN0l0?=
 =?utf-8?B?dUFMMENOMkVGNURVZ0xhaHVLOFZCb1Y4VEFua3duOXdzZUlUV09DMEwzUUtC?=
 =?utf-8?B?ZWpVVjdYN3R2czVmS2MyY0pmQ0l6eStUZ0Y2cUFSMTdEaEtqZTdUS0Z3VEwy?=
 =?utf-8?B?dkdndlVSSCt3aXlrOGpzRnNqL09SL1NnVmMrTks5ZzBSY01pcVhjZFNvaTAx?=
 =?utf-8?B?cittOXpTUlNEQzhZWXdORk5RZTJkS0pSRmV4YWR1VnR0VmFMdERtTFBackxo?=
 =?utf-8?B?cWd2d09jb1NoeDBtbXhMTFdod2pmRWt1ZmdiQ0h5aU5KQjVJS2lnWUtlc1ZU?=
 =?utf-8?Q?5z1hSo0M6uDw+ORccaXvQA294?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ab5cea-1e17-425f-0dfd-08dbb421c1c8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 06:22:08.5824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKVlwT3RCLBY1RJhu9/XoIetJmur4dx9OUDisK1lmC0N+3AZcviDEAlq705gfsYUMy4qt9tKun6xTPVIZOQGyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/2023 1:20 PM, kernelt test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a -11.9% improvement of autonuma-benchmark.numa01_THREAD_ALLOC.seconds on:
> 
> 
> commit: 1ef5cbb92bdb320c5eb9fdee1a811d22ee9e19fe ("[RFC PATCH V1 2/6] sched/numa: Add disjoint vma unconditional scan logic")
> url: https://github.com/intel-lab-lkp/linux/commits/Raghavendra-K-T/sched-numa-Move-up-the-access-pid-reset-logic/20230829-141007
> base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 2f88c8e802c8b128a155976631f4eb2ce4f3c805
> patch link: https://lore.kernel.org/all/87e3c08bd1770dd3e6eee099c01e595f14c76fc3.1693287931.git.raghavendra.kt@amd.com/
> patch subject: [RFC PATCH V1 2/6] sched/numa: Add disjoint vma unconditional scan logic
> 
> testcase: autonuma-benchmark
> test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
> parameters:
> 
> 	iterations: 4x
> 	test: numa01_THREAD_ALLOC
> 	cpufreq_governor: performance
> 
> 
> hi, Raghu,
> 
> the reason there is a separate report for this commit besides
> https://lore.kernel.org/all/202309102311.84b42068-oliver.sang@intel.com/
> is due to bisection nature, for one auto-bisect, we so far only could capture
> one commit for performance change.
> 
> this auto-bisect is running on another test machine (Sapphire Rapids), and it
> happened to choose autonuma-benchmark.numa01_THREAD_ALLOC.seconds as indicator
> to do the bisect, it finally captured
> "[RFC PATCH V1 2/6] sched/numa: Add disjoint vma unconditional"
> 
> and from
> https://lore.kernel.org/all/acf254e9-0207-7030-131f-8a3f520c657b@amd.com/
> I noticed you care more about the performance impact of whole patch set,
> so let me give a summary table as below.
> 
> firstly, let me give out how we apply your patch again:
> 
> 68cfe9439a1ba (linux-review/Raghavendra-K-T/sched-numa-Move-up-the-access-pid-reset-logic/20230829-141007) sched/numa: Allow scanning of shared VMAs
> af46f3c9ca2d1 sched/numa: Allow recently accessed VMAs to be scanned
> 167773d1ddb5f sched/numa: Increase tasks' access history
> fc769221b2306 sched/numa: Remove unconditional scan logic using mm numa_scan_seq
> 1ef5cbb92bdb3 sched/numa: Add disjoint vma unconditional scan logic
> 2a806eab1c2e1 sched/numa: Move up the access pid reset logic
> 2f88c8e802c8b (tip/sched/core) sched/eevdf/doc: Modify the documented knob to base_slice_ns as well
> 
> 
> we have below data on this test machine
> (full table will be very big, if you want it, please let me know):
> 
> =========================================================================================
> compiler/cpufreq_governor/iterations/kconfig/rootfs/tbox_group/test/testcase:
>    gcc-12/performance/4x/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-spr-r02/numa01_THREAD_ALLOC/autonuma-benchmark
> 
> commit:
>    2f88c8e802 ("(tip/sched/core) sched/eevdf/doc: Modify the documented knob to base_slice_ns as well")
>    2a806eab1c ("sched/numa: Move up the access pid reset logic")
>    1ef5cbb92b ("sched/numa: Add disjoint vma unconditional scan logic")
>    68cfe9439a ("sched/numa: Allow scanning of shared VMAs")
> 
> 
> 2f88c8e802c8b128 2a806eab1c2e1c9f0ae39dc0307 1ef5cbb92bdb320c5eb9fdee1a8 68cfe9439a1baa642e05883fa64
> ---------------- --------------------------- --------------------------- ---------------------------
>           %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>               \          |                \          |                \          |                \
>      271.01            +0.8%     273.24            -0.7%     269.00           -26.4%     199.49 ±  3%  autonuma-benchmark.numa01.seconds
>       76.28            +0.2%      76.44           -11.7%      67.36 ±  6%     -46.9%      40.49 ±  5%  autonuma-benchmark.numa01_THREAD_ALLOC.seconds
>        8.11            -0.9%       8.04            -0.7%       8.05            -0.1%       8.10        autonuma-benchmark.numa02.seconds
>        1425            +0.7%       1434            -3.1%       1381           -30.1%     996.02 ±  2%  autonuma-benchmark.time.elapsed_time
> 
> 

Thanks for this Summary too.

I think slight additional time overhead from first patch is coming
from additional logic that gets executed before we return from
is_vma_accessed() check as expected.

Regards
- Raghu
