Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A3B7D8D67
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 05:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345205AbjJ0D1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 23:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJ0D1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 23:27:23 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F6FB4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 20:27:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEWpOTFyoekt8pFwhmYdBX7U9lZCa/mpyWy0NcvRhJrXgcQHKk0IN0c4iPPw33wr59MHUAmUlbtn7TJD+Fi1CaTqymRfS3hIZAhQdQij1gdtzzU6PRhs5/s4IfoVjQKCaiartniw+LkqYiXoFCtd9XSaTXMNDiwilGCL+w7vGF5dqX4kmehapfSTNt2FLMv3YmDkFD57m5iuVHzUiRTG3Z+y9lzThkDA7I6P9Rz0j7oICDMBLOmNgc8uKlsu13F+PrH/b9GajRhhHTUln/g7omyEH/S0WzxdMGE4wgFo4aHWmcMMmw0u4jsdUHVY1P+ZXdk1wXjHVjYgTQrB8MjU3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lsw2cKLcLWqDaFULXVzT2C5euHKUu/hGGdvUCWFW64g=;
 b=bJQkZnOxSTlM+6TSYEjoWWgkOIbQWGlRdWIcefVJK4GAARwbQNdZRBhnK1icSpd58mY5kR/Sg3ettVpGWwYCvjVdqQlGmBjfJiOifndlm/5hFhVG70iTcrCL9dQZLD+9xYF+WXSl2h79uh9nPQsaQAxIUAq+Y/mE7j1zrggjPNFU808jt/PZeOvfIbptvvDdk5WsaussJTrkiFg9JGMoDzpimQy0hJLgIJr0WhLqfd/hllVSxGZ4JLILH/ZOSZ/vjVItRaGhaiS9X1IcCjFBbXeaELoyHAiw3UBWNKMldD4jGhxa1bLOUoslLop9AMMm8pQdjyxaS+IR4B1BqKA1iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lsw2cKLcLWqDaFULXVzT2C5euHKUu/hGGdvUCWFW64g=;
 b=laV55H1ZMLGzuc0ZB91ajQ/rYNWcJ0Cd7frmE/YrnQhlHBqPftSPN9f00Tmhq2tUcBOmDbpLiCP9yFj39yE2/fNJ/2HghVO7xJrLpPhw6ssdTaGbz4N2Z5nn3XXTa1K+HdjXB5HViLLW6w3n4E56WCyu3h3bDQlAtmXQeCXSnjU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2381.namprd12.prod.outlook.com (2603:10b6:802:2f::13)
 by BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Fri, 27 Oct
 2023 03:27:16 +0000
Received: from SN1PR12MB2381.namprd12.prod.outlook.com
 ([fe80::e576:7d4c:6a76:bbbb]) by SN1PR12MB2381.namprd12.prod.outlook.com
 ([fe80::e576:7d4c:6a76:bbbb%6]) with mapi id 15.20.6907.032; Fri, 27 Oct 2023
 03:27:16 +0000
Message-ID: <85b710a9-5b26-b0df-8c21-c2768a21e182@amd.com>
Date:   Fri, 27 Oct 2023 08:57:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH v2 0/2] sched/fair migration reduction features
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>, x86@kernel.org
References: <20231019160523.1582101-1-mathieu.desnoyers@efficios.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20231019160523.1582101-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::34) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2381:EE_|BY5PR12MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: 0763c85c-6515-41b8-6c35-08dbd69c9da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hny6zwMWOBZ7rnxALQ+x9gwPWJ9KopigPLtHI5NRJUISyG37cP6GkZlNUdHOfL8L2EWFArBz0R4v1lI2PFRqVNM15e9WxiQnsu+kZR26FkdjHe/PgNEnpkJKqDcC6xvJLP50JYr6rqKVabzOPUFmivW64RouB6TFwEklZT582CI+OaOjCGEUlJWqSZjXNSaEdXT+fqGgXzB5tPumjX2/+2h+aQpI5DA2LCG5FkGGlwdBs2yKhXv9wpv/tCaACvM7Rd0mlHAigF9L5XsxyVOKbNXKJo0r4tEKydkki1ZM0dyeKrJbVuIAvuJnnnVwUAAYAgLR1GVc7jo8jScMp5eMs+MEKLfpVgjsFgUlstn4NyIHmWmblWIo2Su9m/7QBaSwsVW0oBslgQb7Wv0JbD7XlXJ3+rgJ9+rcDyVxY9T9SiT/AJB9Gkot2vIMFRK1tpFy5fkpE4q5pUBLkx1lGf9aedX0wN0gJlZad2KZm7laDrKhjcIIQtXq3y071kRlJJBO8lrilHmzv4SK8sp5F8Ka4rW2De2Xvb/ibb2KroPwTp/4oOHrw16FWMfmI12C15OQ1qBsS9QgUWXuCviWSmkBdaaci9bYd8ebSBWk+RO8J5mocVwEL2BjBzis+W62CK7/NYVgZOdzY018mSS/WdgJRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2381.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(396003)(366004)(346002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(41300700001)(5660300002)(31696002)(2906002)(4326008)(8936002)(316002)(54906003)(86362001)(66556008)(66946007)(66476007)(110136005)(36756003)(7416002)(66899024)(6486002)(31686004)(478600001)(8676002)(6506007)(6666004)(6512007)(53546011)(2616005)(83380400001)(38100700002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXM0dG5JcE1SSmJ4TWIvaWhtVmd1N3dIeDI5WVMzcFltNFJ6TEVNVTB2S0du?=
 =?utf-8?B?aWVVcEsxS2lwM3V2WnZlSk9YclNDMGZRQWlCeEdNcWduZ3JCUjZnMzlyYnNL?=
 =?utf-8?B?aGI0UGQ5T1lIT2w0QVpKb0o1aXBXekFyOGpWUm5uREVZT3BlYWljSE1YRk4z?=
 =?utf-8?B?ZGtvVjRIbjNNZXB1Yk5wRkhxZmg1U3dzZzBrWlEzUTFlZ1NYSUNtYms0WFQ0?=
 =?utf-8?B?S3NIcFM3Qjh4Q2N6UUJ4ZzArSlF2SFRhWlJRR2VDZENpZDgxRDUvdkQ1RFJy?=
 =?utf-8?B?Zk5PWmJpL2g5Yk1UQ1V4UXhpVFl3dnd4SnlYM1o5dWlZRDNvNFYrWGhveEFG?=
 =?utf-8?B?UnR6UzUvZFk2aHNCNVJ6MVZ2Z0tvNlo4bVFCeFYwMUtnVHZ2ZHhOZUNJOTZj?=
 =?utf-8?B?ODY1NldFY1B3REZyNkdFWFQ1RStla0pIV0F1dHp4eXlLUW1TNjNPdi90OFVh?=
 =?utf-8?B?anRQRVo1NlZab3RGZzdwZ2FIVFE1WHlLVTRMRmtWd2FWNFBzY0pTZkVCMzJQ?=
 =?utf-8?B?ZXFFQUtKRFBLWWJlV1VlL2pqYy9PSlBZSFRLd2hOUXpGNm9GeTduNHYrK3NQ?=
 =?utf-8?B?UExCZVVJRTFEcEVSa0JDalk1aEpkSHVEeEpNVWs2UUhraFNtMDlRUWd1cVJI?=
 =?utf-8?B?TXgyc2dOMXNuUGozTFJRT0V3Zlc3TzZLQ2JPZHdFUzR0OXMzZnVWMnVTVnJC?=
 =?utf-8?B?dmZjdWVoeDlINW0yRmcwNWpkU0FoS0VBREY3U2FONE43djJwdkxHamRVY2d5?=
 =?utf-8?B?VHVneUxBcjhNeFQyL0V6MEFzblZUOXVld2NmUnRFUkhBQnRicFB4WmxxMThL?=
 =?utf-8?B?THRxTzY0OS82VkR5T1dYMXA5YzBWcERIN1BMTG1ONzhCVzEyRVVZK202dHll?=
 =?utf-8?B?eGozT1FEMzdBVThQampQUitMdXlWaTFzNXF2Q1E0L3dpSklSSGRTeU1IVEY2?=
 =?utf-8?B?UEJXbU9LbkxaUGZmd1JDcWNQTCtyUkV4TEpXb2g5VkJMbXJvcWEwODF1N2d2?=
 =?utf-8?B?R1doYjk3SC9kWDBDVW9sM3JVNmJMMXdYVHJUZTNueTIyMFh4YTZSOWVVRFln?=
 =?utf-8?B?SXU2TWdIOFdQNmo0MkJVbmRZUzVwQjBiY1Vud0dPa2hPZDloMVlkOFc4eEds?=
 =?utf-8?B?TGxDc3BwWnBiekluZ202UDhwNStxM0dpbHhuRVRMRHd0bnFVdmcvUjlFZHFI?=
 =?utf-8?B?d2VEUG9RU3hFTU4wVjg3M2lldm5SeEgyYjhDT2VxcUxjbmNLUkdjdVFVdWp2?=
 =?utf-8?B?cUhUK3lJZEVBbTBIVTdQMWxSSW41emxVWFdXakdMZ1N3eVJacmVYSWcrVm9H?=
 =?utf-8?B?K2lKQkVpdW1mWFlYWGdtMk5CSndUMTVDSkpUZVFzM3RIRWplaStleUN3UVhF?=
 =?utf-8?B?bmF3QU8rMUJTQ3paRFJhMHdzRGRJYWU5OEZacFpWVTNxRjMzUERSUDNvaHRK?=
 =?utf-8?B?SFNUWjFJY00wUE5xY2JxdlJJNUw1Qm5uNGJ3YjVlYnJJdmorSDUvbmxVMTRp?=
 =?utf-8?B?ZzI4dEVFK0lCMHVFZEEvMHJHQ0gzZExid1VxNzRRZStCV3dRYUtWUDVlckZ0?=
 =?utf-8?B?L1FRSXBONjVIZTFSNnBIc2g3WGU1dCtlQS90ckplS2VrVW9tSmNJQWtWQ3d3?=
 =?utf-8?B?akdLdHBaNVRCSVVOUHBFU3pDVE5WZWlrRzNOd041SUQxMGM4V2s2ZC92L3R2?=
 =?utf-8?B?Zk9xSE1KWkRPdGYrbjYwYW1MUU4zV2xZa3N1THVGSk1KcTgveHVQZnpIOEQ3?=
 =?utf-8?B?S3gyelEvK2M5aWdQNloreVpMWmlqMTd4czU2VUZJMlhNTG1PSmRzZkhxSVli?=
 =?utf-8?B?UTBhTlNySmx2WEk0eUk3VmhxRGIvcDQ3cjFNN0plRFVoMjdIUXZoY3dQQ3d5?=
 =?utf-8?B?NVI4WmEvKzJkZWQ4Y3Vqa2JQOVhJYkFnWldCZUExS0hzRjgwMWJyNjhuU0tl?=
 =?utf-8?B?S3BqdTdweFhrKzE4TVQrV2xTWEN2NTVJUXcrNVpxZ0N4N3RCZDlLc1AwUUww?=
 =?utf-8?B?RkRVRmFBejNFUWEvVVlZQmNpOTdhYVRTY1F5TGFqY2hHK0FzWXVhQlJGWGwy?=
 =?utf-8?B?RFAwSmRIaW05YU9MTndVL0dTNUcvclpBZjdTVGZCR2hLVFJUbGVaUjVFaHcx?=
 =?utf-8?Q?vXfwA5KPf45ANssAMCzDEuqdC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0763c85c-6515-41b8-6c35-08dbd69c9da5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 03:27:16.4756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /d2m/EIqP+0YgpcYJIGUfCx8uygdSQ7jwaxfY89Em9cC/qbKhCcCtcHtxUf7cvrm6sEwQhMVrxAc4T+LYj+/aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mathieu,

On 10/19/2023 9:35 PM, Mathieu Desnoyers wrote:
> Hi,
> 
> This series introduces two new scheduler features: UTIL_FITS_CAPACITY
> and SELECT_BIAS_PREV. When used together, they achieve a 41% speedup of
> a hackbench workload which leaves some idle CPU time on a 192-core AMD
> EPYC.
> 
> The main metrics which are significantly improved are:
> 
> - cpu-migrations are reduced by 80%,
> - CPU utilization is increased by 17%.
> 
> Feedback is welcome. I am especially interested to learn whether this
> series has positive or detrimental effects on performance of other
> workloads.

I got a chance to test this series on a dual socket 3rd Generation EPYC
System (2 x 64C/128T). Following is a quick summary:

- stream and ycsb-mongodb don't see any changes.

- hackbench and DeathStarBench see a major improvement. Both are high
  utilization workloads with CPUs being overloaded most of the time.
  DeathStarBench is known to benefit from lower migration count. It was
  discussed by Gautham at OSPM '23.

- tbench, netperf, and sch bench regresses. The former two when the
  system is near fully loaded, and the latter for most cases. All these
  benchmarks are client-server / messenger-worker oriented and is
  known to perform better when client-server / messenger-worker are on
  same CCX (LLC domain).

Detailed results are as follows:

o Machine details

- 3rd Generation EPYC System
- 2 sockets each with 64C/128T
- NPS1 (Each socket is a NUMA node)
- C2 Disabled (POLL and C1(MWAIT) remained enabled)

o Kernel Details

- tip:	tip:sched/core at commit 984ffb6a4366 ("sched/fair: Remove
	SIS_PROP")

- wake_prev_bias: tip + this series + Peter's suggestion to optimize
		  sched_util_fits_capacity_active()

I've taken liberty at resolving the conflict with recently added cluster
wakeup optimization by prioritizing "SELECT_BIAS_PREV" feature.
select_idle_sibling() looks as follows:

	select_idle_sibling(...)
	{

		...

		/*
		 * With the SELECT_BIAS_PREV feature, if the previous CPU is
		 * cache affine, prefer the previous CPU when all CPUs are busy
		 * to inhibit migration.
		 */
		if (sched_feat(SELECT_BIAS_PREV) &&
		    prev != target && cpus_share_cache(prev, target))
			return prev;

		/*
		 * For cluster machines which have lower sharing cache like L2 or
		 * LLC Tag, we tend to find an idle CPU in the target's cluster
		 * first. But prev_cpu or recent_used_cpu may also be a good candidate,
		 * use them if possible when no idle CPU found in select_idle_cpu().
		 */
		if ((unsigned int)prev_aff < nr_cpumask_bits)
			return prev_aff;
		if ((unsigned int)recent_used_cpu < nr_cpumask_bits)
			return recent_used_cpu;

		return target;
	}

Please let me know if you have a different ordering in mind.

o Benchmark results

==================================================================
Test          : hackbench
Units         : Normalized time in seconds
Interpretation: Lower is better
Statistic     : AMean
==================================================================
Case:           tip[pct imp](CV)    wake_prev_bias[pct imp](CV)
 1-groups     1.00 [ -0.00]( 2.88)     0.97 [  2.88]( 1.78)
 2-groups     1.00 [ -0.00]( 2.03)     0.91 [  8.79]( 1.19)
 4-groups     1.00 [ -0.00]( 1.42)     0.87 [ 13.07]( 1.77)
 8-groups     1.00 [ -0.00]( 1.37)     0.86 [ 13.70]( 0.98)
16-groups     1.00 [ -0.00]( 2.54)     0.90 [  9.74]( 1.65)


==================================================================
Test          : tbench
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:    tip[pct imp](CV)    wake_prev_bias[pct imp](CV)
    1     1.00 [  0.00]( 0.63)     0.99 [ -0.53]( 0.97)
    2     1.00 [  0.00]( 0.89)     1.00 [  0.21]( 0.99)
    4     1.00 [  0.00]( 1.34)     1.01 [  0.70]( 0.88)
    8     1.00 [  0.00]( 0.49)     1.00 [  0.40]( 0.55)
   16     1.00 [  0.00]( 1.51)     0.99 [ -0.51]( 1.23)
   32     1.00 [  0.00]( 0.74)     0.97 [ -2.57]( 0.59)
   64     1.00 [  0.00]( 0.92)     0.95 [ -4.69]( 0.70)
  128     1.00 [  0.00]( 0.97)     0.91 [ -8.58]( 0.29)
  256     1.00 [  0.00]( 1.14)     0.90 [ -9.86]( 2.40)
  512     1.00 [  0.00]( 0.35)     0.97 [ -2.91]( 1.78)
 1024     1.00 [  0.00]( 0.07)     0.96 [ -4.15]( 1.43)


==================================================================
Test          : stream-10
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:       tip[pct imp](CV)    wake_prev_bias[pct imp](CV)
 Copy     1.00 [  0.00]( 8.25)     1.04 [  3.53](10.84)
Scale     1.00 [  0.00]( 5.65)     0.99 [ -0.85]( 5.94)
  Add     1.00 [  0.00]( 5.73)     1.00 [  0.50]( 7.68)
Triad     1.00 [  0.00]( 3.41)     1.00 [  0.12]( 6.25)


==================================================================
Test          : stream-100
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:       tip[pct imp](CV)    wake_prev_bias[pct imp](CV)
 Copy     1.00 [  0.00]( 1.75)     1.01 [  1.18]( 1.61)
Scale     1.00 [  0.00]( 0.92)     1.00 [ -0.14]( 1.37)
  Add     1.00 [  0.00]( 0.32)     0.99 [ -0.54]( 1.34)
Triad     1.00 [  0.00]( 5.97)     1.00 [  0.37]( 6.34)


==================================================================
Test          : netperf
Units         : Normalized Througput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:         tip[pct imp](CV)    wake_prev_bias[pct imp](CV)
 1-clients     1.00 [  0.00]( 0.67)     1.00 [  0.08]( 0.15)
 2-clients     1.00 [  0.00]( 0.15)     1.00 [  0.10]( 0.57)
 4-clients     1.00 [  0.00]( 0.58)     1.00 [  0.10]( 0.74)
 8-clients     1.00 [  0.00]( 0.46)     1.00 [  0.31]( 0.64)
16-clients     1.00 [  0.00]( 0.84)     0.99 [ -0.56]( 1.78)
32-clients     1.00 [  0.00]( 1.07)     1.00 [  0.04]( 1.40)
64-clients     1.00 [  0.00]( 1.53)     1.01 [  0.68]( 2.27)
128-clients    1.00 [  0.00]( 1.17)     0.99 [ -0.70]( 1.17)
256-clients    1.00 [  0.00]( 5.42)     0.91 [ -9.31](10.74)
512-clients    1.00 [  0.00](48.07)     1.00 [ -0.07](47.71)


==================================================================
Test          : schbench
Units         : Normalized 99th percentile latency in us
Interpretation: Lower is better
Statistic     : Median
==================================================================
#workers: tip[pct imp](CV)    wake_prev_bias[pct imp](CV)
  1     1.00 [ -0.00](12.00)     1.06 [ -5.56]( 2.99)
  2     1.00 [ -0.00]( 6.96)     1.08 [ -7.69]( 2.38)
  4     1.00 [ -0.00](13.57)     1.07 [ -7.32](12.95)
  8     1.00 [ -0.00]( 6.45)     0.98 [  2.08](10.86)
 16     1.00 [ -0.00]( 3.45)     1.02 [ -1.72]( 1.69)
 32     1.00 [ -0.00]( 3.00)     1.05 [ -5.00](10.92)
 64     1.00 [ -0.00]( 2.18)     1.04 [ -4.17]( 1.15)
128     1.00 [ -0.00]( 7.15)     1.07 [ -6.65]( 8.45)
256     1.00 [ -0.00](30.20)     1.72 [-72.03](30.62)
512     1.00 [ -0.00]( 4.90)     0.97 [  3.25]( 1.92) 


==================================================================
Test          : ycsb-mondodb
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : Mean
==================================================================
metric      tip     wake_prev_bias(%diff)
throughput  1.00    0.99 (%diff: -0.94%)


==================================================================
Test          : DeathStarBench
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : Mean
==================================================================
Pinning   scaling   tip     wake_prev_bias(%diff)
1CCD        1       1.00    1.10 (%diff: 10.04%)
2CCD        2       1.00    1.06 (%diff: 5.90%)
4CCD        4       1.00    1.04 (%diff: 3.74%)
8CCD        8       1.00    1.03 (%diff: 2.98%)

--
It is a mixed bag of results, as expected. I would love to hear your
thoughts on the results. Meanwhile, I'll try to get some more data
from other benchmarks.

> 
> [..snip..]
> 

--
Thanks and Regards,
Prateek
