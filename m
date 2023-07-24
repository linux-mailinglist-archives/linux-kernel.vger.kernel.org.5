Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643B975ECAE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjGXHmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjGXHmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:42:15 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03075195
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 00:42:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoGmLfQgVqvBLdUiPGYfHS2MgoGvjBqcVyICpaQ1cq/gp5LisVPp3X2KI74iLWUWDmU3CkIdhKgnFQtcemKbqkamYXxGOan9c2Cvl95mmhU442heXSgBksACeAN+N4ay4QmAJYnEsEzda994Lz1VURd6sWGGr/tiratIgGOoxqR2v03hSNRL5J1oVq1eGieKAWo17jBOhOh+txVYsmoowVq6b/XX0zZvBf9nGplnsB+mgxPLGjGLg3Fdf2A7xV8WCYV3Jml13I8E8yrJzMmBwsw72c2enSUljRwykVCA0LfrrM1O33HDoJslD6jSIkBUFYrQM2DLtYED1+H8+8YZKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPByoqqKTP+hcQx1HC2MBC0XRpr2mZIzyZI3JWd3ywc=;
 b=SelCir5D8KkkUoDj4aDAy9Z6SyLZqnopuoSNMIe4PdYiJIPvHaFtELH7dtD7P/NppX/BYjT0rsp/wf1svXDeRFkm31qLPYMs58065vuqQxtVPvBPZQKV8inFwCaRxiu5Rs+OX7K8h4uefRIbzITc5l8EOU7GVi2CjI7E5urF3gzbasc/XqVLPYXDaxPDiIxp7OgSOBw1Uxo9gqkSOHrfnbB9fIGUNHgyBcUdmMxvQqlNBf+TJIHnoScvErcbrtqrYZZ0YsWruOimrMBeXV0rrqYOGZDsKxiGvDStpdVO0mNmGlbP3vMXliUXEKaasYLlO0xLGGNWFlaDGplJfd6hYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPByoqqKTP+hcQx1HC2MBC0XRpr2mZIzyZI3JWd3ywc=;
 b=cAcWZSlkqu3LoQbPgeHpDgoB4oFAU3KiM3LqPLWk1HBnnGJaCBW2MSez3YeFOXcuVezdwopI5b/i32RaIu3iXKu6zdT/RAtqTAMdCOkqOJwSy4SQkjOVmiokw3waxg72jvDbhO6hbvBG60ZGQKJhunB1+JvXFpOvsGzrVDM4RUg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by PH7PR12MB5949.namprd12.prod.outlook.com (2603:10b6:510:1d8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 07:42:08 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::1ddb:13ad:2eae:53cb]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::1ddb:13ad:2eae:53cb%3]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 07:42:08 +0000
Message-ID: <77632c46-edd1-36bc-1f2b-d3c82b0d5ebc@amd.com>
Date:   Mon, 24 Jul 2023 13:11:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH V3 1/1] sched/numa: Fix disjoint set vma scan
 regression
Content-Language: en-US
To:     Mel Gorman <mgorman@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bharata B Rao <bharata@amd.com>,
        Aithal Srikanth <sraithal@amd.com>,
        kernel test robot <oliver.sang@intel.com>
References: <cover.1685506205.git.raghavendra.kt@amd.com>
 <8581ca937d4064b3cd138845d5bd418580d177da.1685506205.git.raghavendra.kt@amd.com>
 <20230721151834.yaymi6emrppl3mzl@suse.de>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20230721151834.yaymi6emrppl3mzl@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0200.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::11) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|PH7PR12MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: ecf63d03-9042-4f3c-0a8d-08db8c197b33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SqqEOMN7XW0ETgRFfgMjYEYMO56Sx7aFzavIjwrt1L8rAOEEyRfyM+iOFZ9Cbmoivf0teXIIVr+/6B8KUgpWaT0A0ySZbRi475rKeQnnKQWVlqu0o9uruk+V2Uk1TUgpuzLhvNXUmobUwpUH4NXNR2I1aQ5h2F9e1/kXg80SyyFk5DwaWcDQ+AxRaQQIhlxnZearNypp7nswDu4BhrvU0j+HAOe8GqmrIXqKGv/yrdo4XWrSE49FE3dqIZupU3+P7ydaNCLOW2mWXF5Qd3wuBN01aI0C32R+XDYlwMkGXanqCfZ+oz0DMilXDmhjVoRJ0Yxc30n+nKEQo8CcpMZWNHiZhRC6rJkemeoxaR04qIcn0W8nF3dWFuiGpoXY4TqUws7WxShFqUbTPoNZADHq3bfWxk8wyoVegVTp/He9JrZsF0IdAD786gEOrK1zVCO8Zia8rqcH2gU+AbF1NFuFj2l4MFav+Vu5yqx5a800hRsJoa2GSvT5ZoQzWZFHCTPNwnXrxp5h0UBEmTwc6BKuGgHyqBxSse4YVeul+qcfY7YzQrfdGwVhfItiTKGA8nLui5z8NlVaaVUW9DVw1VjmtbkLieLdqVxWM90iq7Bxgo7BnY3AnAiYitwDxO1wZzDMIfPSx/lGetjC+YfrbJNHCdkLudTYJWibkldBhvMwyPaEiJQSDqYghortbyj84xXz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199021)(31686004)(966005)(6512007)(6486002)(54906003)(478600001)(6666004)(83380400001)(36756003)(31696002)(30864003)(2906002)(186003)(2616005)(53546011)(26005)(6506007)(316002)(38100700002)(6916009)(66476007)(4326008)(41300700001)(66556008)(8676002)(8936002)(66946007)(7416002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1JnNFFmcFZtM0NTdFJDRUtmbWdhQWtKWWc5YkNha2xhU2dvcUYveE9uVVZQ?=
 =?utf-8?B?S0tzT2k5MmhrajlVNldXUmN3cU4wVlQvOFNsUXRyZGdGZXl2bFVscUVJSkZW?=
 =?utf-8?B?Ym12dWowZVdXeVk3Q2QzMjQ2aERReW1ZOWo1NTZ6ZW10UHUvek9raUx0TlZD?=
 =?utf-8?B?K0lQVFRmT3cwV0plSVpWZHFqS24ycFYzT3dIWFlJalFEZXFDZU5QamlFbkps?=
 =?utf-8?B?UjV1aktGNExCSHl5dDlhSVVyclJrRXg3eUhrekZ6SWZQS2l5QmptWE02U1d5?=
 =?utf-8?B?UjRoQXR5SU9VL2dzbENuais5SThYOE8wMDRSYUZTcTBjbkkvQlVXRzVlVENL?=
 =?utf-8?B?eVR3TWluSVJReitjajJoYzVNbjJhSEN6ZFdGVTJmMk5rTEhFK1lrNzBjZnVL?=
 =?utf-8?B?eFIwUkpMR1JwbDdlYzAxTkhFUy9pb3lUaCsweFA5dUZRT1hxTHFxVVA1SjdM?=
 =?utf-8?B?RUpYc1ovUURGOXVEVm9PcFAwTnordFZjOEYxOEhwdkFveHhqcjlkMEcvVjNW?=
 =?utf-8?B?aXRUQ2FrdWtFdkc3bWFINWFJZGFVRTNUeDE1ZjhEaTRQbHZldHV4ekpPTW9S?=
 =?utf-8?B?T3l2eGdrRUljMGR1VkFsZ2M5UEcva25CVjN6QVgwc3NRUzV0MDkxenpPM1ha?=
 =?utf-8?B?VjMrYmdkQ2EwVk82MWZzbGdaajloQnlMbCtSU0tZZmk2djJBamxkNVBpOXVE?=
 =?utf-8?B?Ym5yODdPeklTYUdJeG1oOUN6VWhHSU4zK2hIV1JWbitnbmdaVUJxc1lsL2Fr?=
 =?utf-8?B?QmtkaXRWR1I3SEE1eTJtRHJ6OGFHakNLdEZvQmNST3ExRko3cFpsVmVEWnp0?=
 =?utf-8?B?UUNBN1Vvb2RZREFtcThLTi9QMVB4dzdKc0t5R0U5QnUweGlZbUNZeFJZeFpq?=
 =?utf-8?B?OVQrR25hZkJIb09oL1IxVEVBanhlcHQ0MEZIWVZOcmtjbDUwbTBFNFoxa3Mx?=
 =?utf-8?B?bXRndzlmTjZyUzBVZ1ZvZlk3MEtZZ2J3TXFsdzZPbzBWaVFWRGhwS3hCZkRB?=
 =?utf-8?B?bFpSa011TExvM3c4dndrcXZzS29jdWpnNkhnbmluUlo5OFVyS1NQV2ROV002?=
 =?utf-8?B?RmdKOWZWU0JEczRZQlc2WVcwWjJ0UjRqUUI1UjVlOFhWMTFPcmgvcHBCam4w?=
 =?utf-8?B?T3h6eDhHSE1qTVdlbGZ5STZyNklab0VUYWJQWGZ3UzVDVy9wclBmKzVuZFh6?=
 =?utf-8?B?a1dxS3Q1OUJtczVSWHhNTnltZkl5cU1CQ09NRHhkdGxXTXJVdC9CTytYUEdV?=
 =?utf-8?B?aU1SSnhQWXNIeWx1L1ltVzFCNklxbTB5dzVwdVUwa0VIS3IzYWh0Nm8zeFpD?=
 =?utf-8?B?elBsenkzNVlrMmRWQi9WL05FQlk4VHB6dXg2UU01ZmhwR0VDSGdKdE5yeGM3?=
 =?utf-8?B?NlpSNEFLd2wyOE1DVkhZN05lNnc4YnROeTlrTWZyaUY2UnBqY09rTXRSMkQr?=
 =?utf-8?B?d1hONVdueDIzMFl0Q1ZvVldjOGg4WU9KdzQvZDNwWnBIOTVkeThQbFIzRWty?=
 =?utf-8?B?ZmlzRmkvdTVlTVVUU0w1dlVTUURYeS9QSStrUEdaWTJTNlVpbVBRUitUZHNL?=
 =?utf-8?B?MDdBQStDWW9QL3pSRjhBTVJYRE5jazNzbmU4V1U1RFM0U21SZGJUUUFPVTdF?=
 =?utf-8?B?MXRUVkphVTlOTUZiUStTc1JKdThsbG1WbStGQVhBTXJPdjJjYVNaT0ZYL29v?=
 =?utf-8?B?Rjl4Z0ptc2FSQ2FrR05HUzJYMmxrVnVLa3YyaUJCd1lWTERLT3pFVkZZTXZH?=
 =?utf-8?B?aU5PcVRKOGdCcmtsS1ZKU214VVdOd21UQ1RMK1NjWFpvMDhZZmNLT040QXZy?=
 =?utf-8?B?TDhwaGNnK252WWZWS1QrOG14YlhZek1uNVR2VUUwblFZdkErd2JKZGVFY3A3?=
 =?utf-8?B?WEFXeHQvTHJXK2JESHFEbzIyZFNtZkhnaElZSDI3L214MDlUMVNueUhaVUtq?=
 =?utf-8?B?MGhzQ29CMG1ucjJqU0N1QlB4amFCS0VlTXlOV1F5cmlzRzhqU0VXczJPbkJn?=
 =?utf-8?B?K2ZvSjNhS0pzYndib3gwcktQd2NPMldnazVCQk9rQlVZN254bSt5QURza21D?=
 =?utf-8?B?RlZrY3VHY2FEazBaUDNRTFQvS0NGSHBuTEI4elN0bm5ncjUrREtVYVRURnIv?=
 =?utf-8?Q?vzH1cTKLH6oGmHzDprSwVOTQe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf63d03-9042-4f3c-0a8d-08db8c197b33
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 07:42:07.5681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBwa+64I1LfwWWp8CiBr9Goqha/d0Vgtxz41LYJ8aMKHLONM86G7eFqgQ0lj22ZbHijGY/NMUoA4RFQCQtz8hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5949
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/2023 8:48 PM, Mel Gorman wrote:
> On Wed, May 31, 2023 at 09:55:26AM +0530, Raghavendra K T wrote:
>>   With the numa scan enhancements [1], only the threads which had previously
>> accessed vma are allowed to scan.
>>
> 
> I know it's very late to be reading this properly for the first time.  It's a
> brief review as it's late but I'm not 100% convinced by the patch as-is.
> 

Thank you Mel for the review.  Expert opinion / intuition from you,
PeterZ helped, helps alot to improve to solve the problem in better way 
finally.

> To start off -- reference the specific commit e.g. Since commit fc137c0ddab2
> ("sched/numa: enhance vma scanning logic")...
> 

Okay.

>> While this had improved significant system time overhead, there were corner
>> cases, which genuinely need some relaxation. For e.g.,
>>
>> 1) Concern raised by PeterZ, where if there are N partition sets of vmas
>> belonging to tasks, then unfairness in allowing these threads to scan could
>> potentially amplify the side effect of some of the vmas being left
>> unscanned.
>>
> 
> This needs a much better description as there is too much guesswork
> required to figure out what problem is being solved. 

Agree I needed to be more descriptive.

You may be referring
> to an issue where a VMA not accessed for a long time may be skipped for
> scanning indefinitely. 
I feel this is mostly a favorable case because we don't incur
overhead of scanning unneeded VMA. so not this, but below ones

You could also be referring to an issue where a
> highly active thread always traps the NUMA hinting fault first and other
> tasks never pass the vma_is_accessed test. It also could be the case that
> due to a malloc implementation behaviour that the thread using a particular
> VMA changes and it's not detected. It's simply not clear how the VMAs are
> partitioned or what exactly is unfair. I certainly can guess a number of
> reasons why a patch like this is necessary but in a years time, it'll be
> hard to be certain about the original intent.

Agree, to summarize
here there are multiple layers of issues

1) PeterZ pointed this

(Thread1/Set1)---->access(vma1) <== gets  65% opportunity

(Thread2/Set2)---->access(vma2) <== gets 35% opprtunity

Suppose Thread1 (or threads from Set1) are actively getting more 
scanning opportunity, we may miss or scan less of vma2.

I did some experiment and found there was indeed a bit of unfairness in
the way set1/set2 gets opportunity to scan.

Link: 
https://lore.kernel.org/lkml/c730dee0-a711-8a8e-3eb1-1bfdd21e6add@amd.com/

2) Suppose for the above case if we have
vma1, vma2 represents sum of vmas accessed by set1 and set2 respectively 
in disjoint way.

and vma1 size is far less than vma2 size, effect of unfairness in 
scanning gets amplified. e.g.,

(Thread1/Set1)---->access(vma1 size = 1MB)  <== actively scanning

(Thread2/Set2)---->access(vma2 size = 10MB)


3) malloc behavior you pointed.

I was trying to minimize the side effect of unfairness in scanning
overall by introducing a bit of unconditional scans.

(But the unfairness amongst the threads, which thread (or set of thread) 
gets opportunity to scan remains)

I may be missing some more cases here

> 
>> 2) Below reports of LKP numa01 benchmark regression.
>>
>> Currently this is handled by allowing first two scanning unconditional
>> as indicated by mm->numa_scan_seq. This is imprecise since for some
>> benchmark vma scanning might itself start at numa_scan_seq > 2.
>>
> 
> Well, it's also not useful in many cases. There is nothing special about
> the first two scans other than they happen early in the lifetime of the
> process. A major change in phase behaviour that occurs after 2 scans
> could miss the new access pattern.

Fully agree. That is why that condition is removed in the patch now.
What I also saw was some times when new vma gets created
mm->numa_scan_seq could be already more than 2.
(To handle that correctly I would have to have per vma start_numa_seq
kind of things etc which was messy and more space consuming)

Note:
Somewhat related, In my experiments what I saw is normal short
running benchmarks used to finish by numa_scan_seq < 16 whereas some 
benchmark  like NAS used to go till 100-150. (to set context for any 
long running  benchmark optimization in future)

> 
>> Solution:
>> Allow unconditional scanning of vmas of tasks depending on vma size. This
>> is achieved by maintaining a per vma scan counter, where
>>
>> f(allowed_to_scan) = f(scan_counter <  vma_size / scan_size)
>>
> 
> This is a vague description as well and does not mention that the
> scan_counter resets and the code does not appear to match the equation.
> It's also a bit arbitrary that unconditional scanning occurs for every task
> after the scan_count passes a threshold. The timing of when this occurs may
> vary and all threads sharing the address space may conduct the scanning
> which may be overkill. It should only be necessary for at least one task
> to unconditionally mark the VMA for hinting, no? I'm generally a bit wary
> that the time it takes to detect a VMA needs unconditonal scanning depends
> on the size as due to VMA-merging,

I do agree that changing of vma size due to merge/split can affect
scanning. But I was assuming that it is Okay because this calculation is
done every time we hit task_numa_work which may be wrong (and imprecise).

  it may be non-deterministic when a VMA
> gets scanned and there may be run-to-run variance to the timing of threads
> allocating address space >

Agree

>> Result:
>> numa01_THREAD_ALLOC result on 6.4.0-rc2 (that has numascan enhancement)
>>                  	base-numascan	base		base+fix
>> real    		1m1.507s	1m23.259s	1m2.632s
>> user    		213m51.336s	251m46.363s	220m35.528s
>> sys     		3m3.397s	0m12.492s	2m41.393s
>>
>> numa_hit 		5615517		4560123		4963875
>> numa_local 		5615505		4560024		4963700
>> numa_other 		12		99		175
>> numa_pte_updates 	1822797		493		1559111
>> numa_hint_faults 	1307113		523		1469031
>> numa_hint_faults_local 	612617		488		884829
>> numa_pages_migrated 	694370		35		584202
>>
> 
> It's not clear what these kernels are. Is base-numascan a 6.4-rc2 kernel
> with at least commit fc137c0ddab2 ("sched/numa: enhance vma scanning
> logic") reverted?

This is correct. To compare the system time overhead before commit
fc137c0ddab2 ("sched/numa: enhance vma scanning logic")

> The numa_[hint|local|other] stats are not helpful. They are updated on
> the allocation side and not related to actual behaviour.

will trim this next time.

> 
> As I'm unsure what the kernels are, I'm not sure how interesting it is
> that the pte update stats and number of faults trapped are very different
> for base to base+fix. 

Number of faults trapped are excessively refined for base (6.4.0-rc2 
vanilla) for this particular case, because of malloc behaviour you 
pointed above.

Sure enough, the overall runtime is lower so it's
> *probably* good but not sure as it may be also the case that disabling NUMA
> balancing would be faster again given the nature of this particular test :P
> 
> The testing is a little thin and I'd worry slightly that this patch is
> very specific to this particular workload.

I do agree that it is mostly trying to address LKP numa01_THREAD_ALLOC
case.
But regarding the testing though I reported only above result,
I do run
1) kernbench, autonuma from mmtest,
2) some microbenchmarks and also  NAS/hashjoin etc long running
benchmarks to ensure there are no surprises.

> 
>> Summary: Regression in base is recovered by allowing scanning as required.
>>
>> [1] https://lore.kernel.org/lkml/cover.1677672277.git.raghavendra.kt@amd.com/T/#t
>>
>> Fixes: fc137c0ddab2 ("sched/numa: enhance vma scanning logic")
>> regression.
> 
> Fixes may be a bit overkill as this patch is more of an enhancement than
> something that justifies a backport to -stable but I don't feel strongly
> about it.

Sure.

> 
>> Reported-by: Aithal Srikanth <sraithal@amd.com>
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> Closes: https://lore.kernel.org/lkml/db995c11-08ba-9abf-812f-01407f70a5d4@amd.com/T/
>> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
>> ---
>>   include/linux/mm_types.h |  1 +
>>   kernel/sched/fair.c      | 31 ++++++++++++++++++++++++-------
>>   2 files changed, 25 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 306a3d1a0fa6..992e460a713e 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -479,6 +479,7 @@ struct vma_numab_state {
>>   	unsigned long next_scan;
>>   	unsigned long next_pid_reset;
>>   	unsigned long access_pids[2];
>> +	unsigned int scan_counter;
>>   };
> 
> Vague name as it's not counting and gets reset. It might have been clearer
> to name is something like scan_selective with an initial value related to
> the VMA size that decrements. When it hits 0, the scan is forced *once*
> for the unlucky task. The suggested name is also bad, I'm terrible at
> naming but "counter" gives no hints either.
> 

Agree that naming is bad, will use scan_selective / or try if I get more
idea on naming.
So you are suggesting to try other-way where we force scan once we hit
zero. Looks fair to me. will try the idea and see how it goes.

>>   
>>   /*
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 373ff5f55884..4e71fb58085b 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -2931,17 +2931,30 @@ static void reset_ptenuma_scan(struct task_struct *p)
>>   static bool vma_is_accessed(struct vm_area_struct *vma)
>>   {
>>   	unsigned long pids;
>> +	unsigned int vma_size;
>> +	unsigned int scan_threshold;
>> +	unsigned int scan_size;
>> +
>> +	pids = vma->numab_state->access_pids[0] | vma->numab_state->access_pids[1];
>> +
>> +	if (test_bit(hash_32(current->pid, ilog2(BITS_PER_LONG)), &pids))
>> +		return true;
>> +
>> +	scan_size = READ_ONCE(sysctl_numa_balancing_scan_size);
>> +	/* vma size in MB */
>> +	vma_size = (vma->vm_end - vma->vm_start) >> 20;
>> +
>> +	/* Total scans needed to cover VMA */
>> +	scan_threshold = vma_size / scan_size;
>> +
>>   	/*
>> -	 * Allow unconditional access first two times, so that all the (pages)
>> -	 * of VMAs get prot_none fault introduced irrespective of accesses.
>> +	 * Allow the scanning of half of disjoint set's VMA to induce
>> +	 * prot_none fault irrespective of accesses.
>>   	 * This is also done to avoid any side effect of task scanning
>>   	 * amplifying the unfairness of disjoint set of VMAs' access.
>>   	 */
> 
> Much better description is required. It's not stated how the VMAs are
> disjoint. For example, they all belong to the same address space so from that
> perspective they are not disjoint. Clarify that it's related to accesses
> at the very least or be clear on how a set of VMAs can be disjoint. Also,
> it's not half the total VMAs or some other critieria either, it's related
> to scanning events. There is a lot of guesswork involved here.

Sure. will add more details.
ALso I was not clear here where does that half came from. Idea was
allowing unconditional scanning = vma_size for a unrelated task that has
not accessed vma is too much.. since we are  letting unconditional scans 
let it be reduced to atleast half of that. I will experiment a bit here
to get optimal f(vma_size/scan_size)

> 
>> -	if (READ_ONCE(current->mm->numa_scan_seq) < 2)
>> -		return true;
>> -
>> -	pids = vma->numab_state->access_pids[0] | vma->numab_state->access_pids[1];
>> -	return test_bit(hash_32(current->pid, ilog2(BITS_PER_LONG)), &pids);
>> +	scan_threshold = 1 + (scan_threshold >> 1);
>> +	return (vma->numab_state->scan_counter < scan_threshold);
>>   }
>>   
>>   #define VMA_PID_RESET_PERIOD (4 * sysctl_numa_balancing_scan_delay)
>> @@ -3058,6 +3071,8 @@ static void task_numa_work(struct callback_head *work)
>>   			/* Reset happens after 4 times scan delay of scan start */
>>   			vma->numab_state->next_pid_reset =  vma->numab_state->next_scan +
>>   				msecs_to_jiffies(VMA_PID_RESET_PERIOD);
>> +
>> +			vma->numab_state->scan_counter = 0;
>>   		}
>>   
>>   		/*
>> @@ -3084,6 +3099,8 @@ static void task_numa_work(struct callback_head *work)
>>   			vma->numab_state->access_pids[1] = 0;
>>   		}
>>   
>> +		vma->numab_state->scan_counter++;
>> +
>>   		do {
>>   			start = max(start, vma->vm_start);
>>   			end = ALIGN(start + (pages << PAGE_SHIFT), HPAGE_SIZE);
> 
> This has a potential timing issue as only tasks that accessed the VMA
> update the counter. 

I think there is a confusion because of reverted logic. we do allow
unconditionally to let the scan happen initially till scan_counter 
reaches scan_threshold. So even though task did not access vma, we get
to scan initially.

So idea is update scan_counter only if we are able to successfully come 
till here because we are sure that there is not condition that returns 
back after this without scanning.

A task could create a VMA, access is heavily in an
> init phase and then go completely idle waiting on other tasks to complete
> (e.g. parallelised load that uses a single thread to setup the data and then
> creates worker threads to process that data). As there is no guarantee other
> tasks would trap a fault, the access bits would never be set, the counter
> never increments and the VMA is ignored forever. It's late on a Friday so
> maybe I'm wrong but it looks like this could have weird corner cases.
> 
> The counter should at least increase if the VMA could have been scanned
> except the access bits were not set with the caveat that it may incur
> excessive cache misses.
> 

Explained above

Thanks a lot,
Raghu
