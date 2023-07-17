Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74885755B6E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjGQGX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjGQGX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:23:56 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A8DE57
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:23:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoo1pxYnD7aJ+j2iJFGpB+HSjCyXX5ZHnB68ApnCoW15Abdp3mFCoV6nwq3C0eMIpcpmV29Fgw8QIuWBVpsF3PXdJza7lq8UumkY1EouBR9zqj80udqMJHMP5zo1lBtE0qJEj6MkgDDrWI/LHFL5NhE3KXBDSBgSL8p7lLCZD2k0T++om3BBuM80yQawzvUlRpzAekrW3GdFDsQTcMstA4Nzl/9MowiOpc6NeD9e8b/sTpTls9qUMNBvFiK6FLt/Z8+lq/xbUB50JlcX9ypvChm+yooV5CmNXFNjsO61vFLeBccxLbUBMmwHmj8eKfR9eqV5HzKp0NWquSfntA07Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3YdwKWqBPk7HvWOVAVt5xH4oKId8us2HYDiJNTzbn0=;
 b=eN5/Qb3c6ig42+xV3E37Oy66goeZN3BD+v3HdykQVCPOGlBEl3+VpnAIdTb+cg66F7g3jpmULKnfeAK/b9/kHJovwAk+YLuqspVcZmCMo3VdLQa2nrvZJ9JNsllJyB3x6lN4MgwZkmBSz6WAfGuot/ePCgjF3n0ft5R6KvVzx0xb7Erdfp2KFs1lO1/pW2Eio/vTDJBNKyN0x2FBWq6kQOVBRnrVHKIZZRNYQSb1yTTQsuzs0FUDZhyuG+0yGKa+taF7ajxvTJj/7ZYSidEGXmXJAi9L2UWrjSm+JU8WRJ3ug2sCxlouep/Xua2c/car5o7qlbIvWNlpc5cqd+iNog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3YdwKWqBPk7HvWOVAVt5xH4oKId8us2HYDiJNTzbn0=;
 b=0quyKCfIlNk05y6E/7E1NFXvq/GAy3DgaOvs9nVn/hcehcSXZh6O+LJKTp3vbqXd9RHjaFe5cE10dzaIcY3bOoacGAI7/H3ta4nrSYLyPGZ9APB6uUp/zg/wXVdajdw8fG46b46gVM24eKhv5u6s6SmZjwQLrOZud6o0RzdUlyM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by PH7PR12MB9101.namprd12.prod.outlook.com (2603:10b6:510:2f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 06:23:47 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::1ddb:13ad:2eae:53cb]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::1ddb:13ad:2eae:53cb%3]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 06:23:46 +0000
Message-ID: <edc92c77-ec96-8f8b-dbbc-081624231dc4@amd.com>
Date:   Mon, 17 Jul 2023 11:53:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH V3 1/1] sched/numa: Fix disjoint set vma scan
 regression
Content-Language: en-US
To:     Oliver Sang <oliver.sang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bharata B Rao <bharata@amd.com>,
        Aithal Srikanth <sraithal@amd.com>, fengwei.yin@intel.com
References: <cover.1685506205.git.raghavendra.kt@amd.com>
 <8581ca937d4064b3cd138845d5bd418580d177da.1685506205.git.raghavendra.kt@amd.com>
 <88d0c858-586b-bf59-8d57-d31ec63a9e35@amd.com>
 <ZLP8F001a+Shp8DD@xsang-OptiPlex-9020>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <ZLP8F001a+Shp8DD@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::10) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|PH7PR12MB9101:EE_
X-MS-Office365-Filtering-Correlation-Id: fff9af9a-ddf5-49ef-2a37-08db868e5fe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zV0or2HGuzGIEki1FnRUEmB65JEwSsKIqc6S93w+fgVCk7xVyDzAwr6SPrEOFkvhby2mvh4yxBuhHQS/PcROHe8IYV3JNZyM+8uVlTSAh06kLaMoP3hE4a8y0bofaoZpqZRf2YD3KmyQDlj9Bo93c/wl9b9smzGABOwMY2Ep04HdHRwKr4fLJT9rFVDiE7BAj0i5BPnMbEzyZzOHo/TwENjQn4zPL4C8USnU5Df7iYuw0oADhU0meKa+VTbBqA6HbjKYxy/j9fEXP/Pvhge0+apwHK25/jHxpLxY5+vZmqDgIlihLv/r2frBD7TbulIqdr/ZBJ2mdZziULbClWyMeRCwS48KMR69i0kGx74m/vUtBrRokXaDxHr4A6EgiSnJehD2PJo4c0fpSEOng/yq01vUuMzQ3NcfG8INO39870aAZlZFHrTlmk0HAoy/UeAe00cn0ljAQ9IVtkCFEFvVUNDgPLxMmkiwhaS0nkEjPswp5yJj5CM2zJOwJK6ReGA9msSr0Jrm20zNwy49uFbEkNG7jzCkr1Qb8pbtquDXbhk1RSNqK94zCEz2EAVlHzwmpVrS9LIcBtqOaes04GlPvxrI+JnVWDNQtw3xmDKk4Xc+LKGAYZD0lzntcuGcjBvkzb/dhrfZKuxxFOWI3KaN/mhRqOat0T+IHKjWdBwQIi5p20Hls1ySketAnQeYTD59
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(451199021)(2906002)(38100700002)(6512007)(966005)(83380400001)(186003)(2616005)(26005)(6506007)(53546011)(5660300002)(31696002)(8936002)(36756003)(8676002)(7416002)(478600001)(54906003)(110136005)(6486002)(6666004)(316002)(41300700001)(4326008)(66476007)(66556008)(66946007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3pEQ0ltZXJtMzJ6WEJyNkZHOU15UEZjaElWYzZPdWlId29YNU9UMnRkYytV?=
 =?utf-8?B?SE5kMDFwZ2NvclJqNFFHaTJmWXFBempEeUpZeHZ0TUpRMU1hMlpleFVGSndv?=
 =?utf-8?B?TnVNVW56SDdYYjNNdHRTbnhUdWNkUmc2M1ZMVlN4bnQwT0F0ODBtOWp6RzZ4?=
 =?utf-8?B?Q0FFQUQydVY2YXUrb3JOa3JGOHhkaklUay9UdU12dFhjMWdFa3BzVmMxOG9P?=
 =?utf-8?B?aTdIekNYSWhuTFdMaytEVFNsMmx1VVFTcjk2KzAzUDg0RG9RUEhZNlZWMTNT?=
 =?utf-8?B?UjdITHRwRGV0dDFub0x6dmZZbGhmQVZ5NDUzSStXSUNOUG1nYVhTTlRuT0ZC?=
 =?utf-8?B?cVlZNTNGTWNCaEM0UVI5Z0xpZzdHa3lxMzl6aGNvMFE5STEyNXVoVXVNSzBV?=
 =?utf-8?B?MmdRMTcwcXM3VFN2STJZeDU5V0U1ZFF4bE5xVGpNM0NzQnJRNVhuZFBFaDFT?=
 =?utf-8?B?b2VWZXZmRFJBWnhOWFY4b3dkMGdBcW45bUJsR1p0U3FYOUVLYjZ2UDc2ZWFQ?=
 =?utf-8?B?Y2hHclluTm5oQlIrUnRrRXBNOHEvSDk1OG4rNzVLVUljRnhJRTdWSEszVTB1?=
 =?utf-8?B?bDRva2xpbHFOenRNY0N3RHVFSGZpUE9zeEVXUnpybThIcStuam1ZOFdVSjdS?=
 =?utf-8?B?L1BZaEFPa2RPVk5kSEZKNGQydlF6RGJ6WkZYbVdURHZhTjREQ3FmRXJmbUdn?=
 =?utf-8?B?ZFdORTVxeHljRzdwdVEwODhyQjB2YlFRQWkweE0vUjEySkUxcXY5OUw4eVpn?=
 =?utf-8?B?cnV3UWRja0JmOXNXOHVhVDI3Rng1UXNTM1E3UnJzaXNjT1Zvd3ZvOWNqeGtF?=
 =?utf-8?B?RlhQYWY5WFRsdDFQVXptbU9ZTXI0dEpMNFV6YTB5YTdxaWhaRnNMT3JVdDd5?=
 =?utf-8?B?c1ZTOGZpRmtFU3NIbWJ2QzZjL24rVCtVWGNGb09rWldMRC83bDJhTXFKWGJ6?=
 =?utf-8?B?ZTg2NWYrTUZIeC9JSGljUUxXcm8vaVp5QmNzd3NzKzR5UnE1R0xpUnZVRUFK?=
 =?utf-8?B?ckEwT1JpbCtQY21PWTlSNWhQUHd4MFpmTjA0MUorYVhKdlFHdStoR2crMVJJ?=
 =?utf-8?B?bVg5ckcxY3k3M2RzRUQ5dmJoSnVhKzZQcEtVS0dQUWR5NTZ3cmVBRjhxMFNa?=
 =?utf-8?B?MmRuTnpZZm9sR1Nvc2NZSzNEcFVkVWxjbWpKdDR2SFY1YzN0WnVVL3dGWmlt?=
 =?utf-8?B?Y2FpRW42UTVrM2tQakNDS2xHZytVMWxHRXlpWkEvV1dtNmlsL0dHdGJrSkc0?=
 =?utf-8?B?bFRyR2g4WWtyamI4WHBXejZKTkpoSXdqQ0ltaklTb3RZRkRaQWl4WTlMeVZN?=
 =?utf-8?B?RnFoNGRiamZ5RTdpN1N3L3ZobzNMWlpBaVFXTFBjNkt6QXV0SGJ1cHNGU0Nh?=
 =?utf-8?B?NkR5UUtJNEIzWU84ZTIrNzh4NnpXc0MzdjZnS1BOY01odkhrZFlkUG41aTV1?=
 =?utf-8?B?VHJ1MEhHVGlTSFJUZmpEK243b0JIT0JxRGdOOERzdHVjcUpHQUJXU3NKRC9z?=
 =?utf-8?B?RTdzREFnZVFVTjQ1SVhIclBzUFE3WjdyVlR4UGg5ZVRsNDBIUHJ3Tmt5Z2hq?=
 =?utf-8?B?b1hzZDhHTGttWVMrMy8vV3FmdW5vMmRJTnE1VVFQM3VFYjNLRkoxMkJNUDdC?=
 =?utf-8?B?dzViSGhGcXg5bG5yQTI0aFhnejMyMnJaTFZRN2NsbjFnUEZjVmxuQ2lwTnFL?=
 =?utf-8?B?VlVVRVRvbnJVQk1EaFU4NmF0TkdqYmV3Um01QXJ6OWJwYUJ2VVhuWUthdnRz?=
 =?utf-8?B?MDYvV0RWWFBQYjFubEkzUlJ0NW9wMVV3c0lLTmxpcHlLckdxcTVRbnBNd3dU?=
 =?utf-8?B?ZEtKQjJIaVFacWtUc2lycHczSHkrVmVRSE81bVp4a3FDN3huUjJyZkFmVmJF?=
 =?utf-8?B?ODVXekF4SG9UWXhYUXpUeGxWazNNdTd5ZXhsbG9Nb0txSDhaQUFkYUxvekZ0?=
 =?utf-8?B?L1VVOGVUWmw5WGVpQTNPSDZLMzFhMUpObWRUUFplU09QcVlUTmM1UU1HbXV3?=
 =?utf-8?B?anphcVl3VlppYXJBZzVCZjNjVVl1TDFLWHhSS1FET2NoemUrU0xPaTZuYUVZ?=
 =?utf-8?B?b1ZLMkJGSmRxcFI1UUNwSTJMYWJoYzQvQyttMFJENnhzT053eU5UM2ZFOGZM?=
 =?utf-8?Q?2edBM2pZwPneICWndprQkddD/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fff9af9a-ddf5-49ef-2a37-08db868e5fe8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 06:23:46.0877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 53Nw/pI3JIUSdi0IqZXWjdNusKlGd7y6yDEJq5s6O9zyIHiBeKlS9/AmykFDjksERBRTpzzA2mBfHuVq7RwRiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9101
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/2023 7:47 PM, Oliver Sang wrote:
> hi, Raghavendra K T,
> 
> On Wed, Jul 05, 2023 at 11:18:37AM +0530, Raghavendra K T wrote:
>> On 5/31/2023 9:55 AM, Raghavendra K T wrote:
>>>    With the numa scan enhancements [1], only the threads which had previously
>>> accessed vma are allowed to scan.
>>>
>>> While this had improved significant system time overhead, there were corner
>>> cases, which genuinely need some relaxation. For e.g.,
>>>
>>> 1) Concern raised by PeterZ, where if there are N partition sets of vmas
>>> belonging to tasks, then unfairness in allowing these threads to scan could
>>> potentially amplify the side effect of some of the vmas being left
>>> unscanned.
>>>
>>> 2) Below reports of LKP numa01 benchmark regression.
>>>
>>> Currently this is handled by allowing first two scanning unconditional
>>> as indicated by mm->numa_scan_seq. This is imprecise since for some
>>> benchmark vma scanning might itself start at numa_scan_seq > 2.
>>>
>>> Solution:
>>> Allow unconditional scanning of vmas of tasks depending on vma size. This
>>> is achieved by maintaining a per vma scan counter, where
>>>
>>> f(allowed_to_scan) = f(scan_counter <  vma_size / scan_size)
>>>
>>> Result:
>>> numa01_THREAD_ALLOC result on 6.4.0-rc2 (that has numascan enhancement)
>>>                   	base-numascan	base		base+fix
>>> real    		1m1.507s	1m23.259s	1m2.632s
>>> user    		213m51.336s	251m46.363s	220m35.528s
>>> sys     		3m3.397s	0m12.492s	2m41.393s
>>>
>>> numa_hit 		5615517		4560123		4963875
>>> numa_local 		5615505		4560024		4963700
>>> numa_other 		12		99		175
>>> numa_pte_updates 	1822797		493		1559111
>>> numa_hint_faults 	1307113		523		1469031
>>> numa_hint_faults_local 	612617		488		884829
>>> numa_pages_migrated 	694370		35		584202
>>>
>>> Summary: Regression in base is recovered by allowing scanning as required.
>>>
>>> [1] https://lore.kernel.org/lkml/cover.1677672277.git.raghavendra.kt@amd.com/T/#t
>>>
>>> Fixes: fc137c0ddab2 ("sched/numa: enhance vma scanning logic")
>>> regression.
>>> Reported-by: Aithal Srikanth <sraithal@amd.com>
>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>> Closes: https://lore.kernel.org/lkml/db995c11-08ba-9abf-812f-01407f70a5d4@amd.com/T/
>>> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
>>
>> Hello kernel test robot,
>>
>> Gentle ping to check if the patch has helped your regression report.
> 
> sorry for late.
> 
> previously we found a 118.9% regression of autonuma-benchmark.numa01.seconds
> on a Cascade Lake, which happened to be converted for other test purposes, so
> we cannot test your patch on it again.
> 
> however, we also found a 39.3% regression on a Sapphire Rapids test machine:
> 
> =========================================================================================
> compiler/cpufreq_governor/iterations/kconfig/rootfs/tbox_group/test/testcase:
>    gcc-11/performance/4x/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-spr-r02/numa02_SMT/autonuma-benchmark
> 
> ef6a22b70f6d9044 fc137c0ddab29b591db6a091dc6
> ---------------- ---------------------------
>           %stddev     %change         %stddev
>               \          |                \
>      193.14           +39.2%     268.84        autonuma-benchmark.numa01.seconds
>        8.14            -0.7%       8.09        autonuma-benchmark.numa02.seconds
> 
> 
> now we tested your v3 patch on it, found regression mostly recovered
> (55fd15913b18d6a790c17d947df is just [RFC PATCH V3 1/1] sched/numa: Fix disjoint set vma scan regression)
> 
> =========================================================================================
> compiler/cpufreq_governor/iterations/kconfig/rootfs/tbox_group/test/testcase:
>    gcc-11/performance/4x/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-spr-r02/numa01_THREAD_ALLOC/autonuma-benchmark
> 
> ef6a22b70f6d9044 55fd15913b18d6a790c17d947df
> ---------------- ---------------------------
>           %stddev     %change         %stddev
>               \          |                \
>      193.14            +5.8%     204.37 ±  3%  autonuma-benchmark.numa01.seconds
>        8.14            -0.9%       8.06        autonuma-benchmark.numa02.seconds
> 
> detail comparison as below:
> 

Thank you for the confirmation. So looks like we got back most of the
regression with the patch for numa01_THREAD_ALLOC case.

Andrew, could you please help by picking up this patch unless
Mel , PeterZ do not have any concern about the patch / direction.

(as we note it brings back little bit system time overhead by allowing
some scanning..)

Thanks and Regards
- Raghu
