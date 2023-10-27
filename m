Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851A87D8E1E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 07:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345039AbjJ0FZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 01:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjJ0FZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 01:25:07 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0496F1A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 22:25:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OlzWA13+FLH6+TGNb7aqNxLJ4ywb3YuP58sXXUlcQBWJlZyp1l3sVCuUFhSJ/7T2LTOWMk1gIiyzlCr7PxFPqQJub2j7fCzyKIjOVctyxkaahIie9yZMQ7SH7gJFbfOezJ8CjYCGo4Y/uULHZDvVLOXrt+ZzI+1k2TdopqfdI0tLvkwsCVlDmHRwXMdo41DXMaB7r0vszk8KnMd+8EmEG3Budq7fCxLnKtIMUxZrHsD4UwFeDMcmYSPmoZMyJUcPRPC7Z9uhvoKT5lWwSgdBf2Iwpl+N6yTQkXKxhXA7ePEY7rMCyQbmZV/CYvaD+YH9vGhCeXcHmpvXyXcP8U6GPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mC6tq1EEEJXoJe47tchaF5XzocBJEKkHWRE2w7PTG0=;
 b=SenTUgY361Q9trDKYfYAGFvFZ7vns2BUmkl9fQtNFODcEohL0oTgFJXLXLqp3/hL08zJLWHl6FkUHg+Qv9f+kg+xc7QS+2Vh3ZFJN9t91xe3ArAvAudSnR1IwIhgLCh8sDl2ieVLYyq1gtKC5Hw6ZGrFqIJLqxv1JaUjPvLZj7MXnjvwsHY+pqzxnIjzPMcxw6/4KpHbzq5fhl3vqYMFE8WjqW4tLXUbJizYTiahhJ+pvnaqj0HpsBl6jI6uJfo919KtiLYdkG/kXQHerWnXy/YNu6fxxb5INej0aM9bfm507DGLH84VpzYNAIlVxPXn7RYqCi095+09PUESTlgHPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mC6tq1EEEJXoJe47tchaF5XzocBJEKkHWRE2w7PTG0=;
 b=JW2YTIzl003kAebAYU6ELI72+9B3Pna9tTUSSBqLlDOm9CcKoY7TnJA9jVsUV+tUP8vvIvyqNvMR7ZGCffqwd4AY3V1UweiJV9xsTVojROEExPuP7qztn8Jk/2tdaJEDsR665Q/2k/+Q5GETqB3cIJWqInF0RgumL1bXnqjw4iA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by PH7PR12MB8054.namprd12.prod.outlook.com (2603:10b6:510:27f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 05:25:00 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::6d1b:7a85:af7d:a90b]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::6d1b:7a85:af7d:a90b%5]) with mapi id 15.20.6933.022; Fri, 27 Oct 2023
 05:24:59 +0000
Message-ID: <b7704b2a-29ab-b538-5b95-d72cc3993eb2@amd.com>
Date:   Fri, 27 Oct 2023 10:54:47 +0530
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
X-ClientProxiedBy: PN3PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::20) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|PH7PR12MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: db56a77f-fa43-411b-0ee4-08dbd6ad0f0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 58HbGrhQthUQUty41aMTy50kNU0i3FRntrvYAIKqfG4oJPrzLWtAA8VsVEV7Iy400mbTN8UHZoNYllGWDu0RrlzYa6S6huENzYVTBS4M/uQ81tA6B7czufvFSRusrFz3OUY+4CPJ7oXVLsofZVUktpkSHlvSBj4h6ITHOXjWbCkyvKIICeBQfQiCf83VMhOENkSM9PAGgrcHnklLmzNNskjKH7+O9Wyby2JLAIJZgmQ1/QKxDDkul4kq0kP/ntOgZK1GvamKXNSdLXqpQxb+KAYaQv5BBE+oy8IWzG0mnBaljbgpUe4TFa96Afdpt4hWVmzHFhld6xqTMAU+SlOsG+0JVGEgSO7aqOrtcV55Ch2YxdqFbo2cI9aH0iEC7OHygKkjZcfyJjL2AaZgeJArCl4BQYywCvEO6fpQCZM83KboLcjtMRQrtNEFeOjzQ/7P2HM8daa0C/8bOmu1rQyCb+/UM4RQ+9yc1DeDtZTR3z+Q4R1VZnGqaqlGlbqpjF8rwtfPJv5Y24e8wodUg5cXvZ2r9E/usVs+vV8e0ZnHVUH5DePcKOZkAg4Z0vNpT6+gxFbdHyEs+0ulJtktFdXFQID9dJcugscSaafaN60yKx0pjegNcb7jFeS5kR4tGzCgvagOTZFT6j2QT1pcOtl60w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39860400002)(396003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(26005)(31686004)(38100700002)(41300700001)(2906002)(4744005)(36756003)(5660300002)(31696002)(8676002)(7416002)(66946007)(8936002)(4326008)(2616005)(478600001)(6666004)(66476007)(54906003)(6506007)(66556008)(316002)(83380400001)(6486002)(53546011)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDI4VUR6QzFXUG5NKzBwUjZmaE0yZ01PUXY4YXdhdTI0Q2tWRGNPRk5yRjNR?=
 =?utf-8?B?V0h2SHRoN29GL3ZmSnVSajRwTGp5YnlBdGpEaTFvZ3MwVXMyNWJ2ME9VWTRJ?=
 =?utf-8?B?aTBLUDdXSFl1MTUweDdzSSs4RHNRVHE5S1dyNlU1c3VONWh2Znh0cktpZ0NP?=
 =?utf-8?B?MFNKVFRGeGs5bE41QlM2bHV3c0NIZDVLWkhYRUFUMUtkMk00RG41NVdTOFB1?=
 =?utf-8?B?cU91bk1acE1ONm5KeU5jUnlsQzc4UWYwZmNzWEVyUDJGb0dEZzlGblQySncx?=
 =?utf-8?B?ZjRjbTBHOXNaUHFFV05CdGtWcmg0dktjd2pBNmdwYlRIVWRwYU0yeFA1RENn?=
 =?utf-8?B?WWdLVitTRkMvR3hlT1N6UW82V0VhNXE2anliMTZ2dEtNd0h5Ri9wVjdmdmIv?=
 =?utf-8?B?cktxc29VTnRLWGRtMTNYTjVRRzNiNUNQYXFrM0NLbjRnRGM1MHZjN0lNZ3JN?=
 =?utf-8?B?U25ySC9sMDJHTUdveXcwMXZ1OHZzTUN5ZTZtLzBteU5EQjRVRDR3NFVSRG9V?=
 =?utf-8?B?QjZzM2JrYlBYUDQwSVdodFVVcURDaFV1Sk16V0d3M3ZMQ2xFMjJmODFQS2Ni?=
 =?utf-8?B?Wmt1a3FpYlVhd3ZhWVJQdDNEQmJkUXkwNHRycklGQzVuU3VqSXYwa0tNcXhE?=
 =?utf-8?B?WWJUQW5aVTNHWmY5cnZ6Z1c2elFETkE0VGVSQkpXU3AzYi9PM2dGYllHUjB3?=
 =?utf-8?B?UWFCUVpYZVl1MkRrY29jVEtwN3NMZjBiWlBCeFE0aWhpQlppazU5OHFnTTdS?=
 =?utf-8?B?NE16aTV2Y1RsN1QxdjVaTUoxMlBxMlM0d25WNFAwaWxJaTArZGtxVmp4blNB?=
 =?utf-8?B?YzVEVWUvOCsyeWgydnRJRW51bHhObHFLajROeUd3WHU4QkgzbWtGdFFqdkVi?=
 =?utf-8?B?bEhKZzE5UnN4SWtTa3RkenJORDhtUXVWNGRveno5ejRZM3c5eFMzcVJxK3By?=
 =?utf-8?B?SU83VVF1WXI2REZKaGJja1pyYnVuYVZ3T1dTdkQrVldWTERYZmkyaGE1SDcz?=
 =?utf-8?B?RlZwem5mVjV2Tm5DTitRRmlDOWdHTlpBL3lNNTErZS90YjZnVDNFVkVSRzc3?=
 =?utf-8?B?K2ZlekxZNjVrcjFHeVZ5eXlDSStrQk9yWUh6SEhVcmRpMzc3TmkyeG0vTS84?=
 =?utf-8?B?cHh4ZUZyZnFYUGZ5RSs1cWVYRnViZlF4aStjQktmaUwzMkZnN2hLcmRRU21j?=
 =?utf-8?B?d0FGOWZZWG1lQVdNS2JCN1F6b1ljbmdBa1VXNnYyRldUVVI3K3NVVGpueWpz?=
 =?utf-8?B?d3pKNk5hR3oxN050RmNnWjI4RzR1bnZJdnJHT0dpZ1dRUkp3cDVDQ0hSUkt0?=
 =?utf-8?B?RFJRZ1V5VWt3YnJWS1lmckRiUHVZek5lMjk4ekNvYVZDaFNhNGpQWm5jeCtF?=
 =?utf-8?B?ODVsN3BKb0txODVKKzJGaG9BY3FxVWRpN3V0L1R3OXhJUEMxNkwxWlJjZElw?=
 =?utf-8?B?NGFvSnJGQVZpOE51U0t6M2EzL2ZvZ0Jvdm5qZzVHZXI1ZVRNdnRUOXJRM2po?=
 =?utf-8?B?cEl6QjdEUVZqK2JJZVdIRWFMVzFmMDZZK1N5OFZ6RW5XaUpMRVcrRWZPZFhm?=
 =?utf-8?B?WlJxMGdBcEZJK1VxRCttSGxrTVBVR0pSMXNtQXhodTA1RDNxam9HS2V6Y1F5?=
 =?utf-8?B?SGs2VlJaSGdGRnRKY3l6aDRWZ2NlZGFIZW9HMVN4MlNIa3BFS3lSS3lMNDgy?=
 =?utf-8?B?UnNESW91OEtCQVZ1QjV0ZzJvVEkwREVwMTh3c20zU08wQU01ZGZnRERZeWYy?=
 =?utf-8?B?aUx3UlFlYUtlQUYxSXo2K3RJem9HVXR5d0NBOEdYVE9MZitUSXpTZXFZY3ZH?=
 =?utf-8?B?YnpoMnN6a0VsUjBXSUxkSlUwNDBJRFNzaFBRcGxFM2loclBUWU9BQkc0WUlI?=
 =?utf-8?B?U3ZUOWdjcmNydGlzWVlJWmkvellKNStWbE1vMmNYcE0xcWx1SWVGWkhQQjdV?=
 =?utf-8?B?Yi9kbEwrK3A2WFo4aTZWc0R0bXJDc3VkNkExdUtibnNBY2tMdDkrWjJiRUZO?=
 =?utf-8?B?Q2lCKzc4VTl1MzI5bjd3MVZrQUNGaVdUQ2ljTi9wcFFzdzdMbXFnbVZpRld3?=
 =?utf-8?B?bUM5VExTRk5XcmxRa005WVhhTTR6djR2emhCSm9Sb3FIZjRSWGtEL0d5R1Qy?=
 =?utf-8?Q?fiN9Q02BY4ExyzJa3Zj3YiklN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db56a77f-fa43-411b-0ee4-08dbd6ad0f0b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 05:24:58.1438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iEZ05FeZzJKEJlMyQT2mn85m1adFymstJhqn1JWffwoFHeTWni+Q1Popc1t1Wvif0qIfv4h61FlHENihE1+XQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8054
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Gentle ping to check if there are any concerns / comments
on the patch :)

Thanks and Regards
- Raghu
