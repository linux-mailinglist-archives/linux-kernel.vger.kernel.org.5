Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551277C6432
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 06:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343534AbjJLEsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 00:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJLEse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 00:48:34 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2051.outbound.protection.outlook.com [40.107.96.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0C8B7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 21:48:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSkVKQQbehEoT/wRp+5H6Tl3YNSH7Tlof/HNTgDByhGgHG02h9Elt1zbe5ZDnQXLon6Y5ESQL1j7sZTlG7QTOei2SD56tvPNuO5fCRXxenrMVFEqURqc1TpYkuaYhTwz021EaTGUc2JGv7zdcpcEM3roU8ovx9DdmY4pxYWK55ZM9RV9gWbXDmv/PkkUyV5zU9Gb7Y43jAIKumdSGPKgvkC5IzZsiTZHpxwKBr2G5vgfr3276QPqdn3Vj30TIQkxQIZMWfPh42HZKoDobcxwYi5UlXhQL7MaDC7pqeaflafJhcNu4FiKmXLNKhUTIU1JmcT333KJL8V29cD9vHZpcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+U6Gb9aV531pVqHSEELPyAyTE0M66jeHoR2Lio9EWxc=;
 b=jJpgDdUmJ5QHpZx+2NTBlXu/+PG0UFZI/7N6XE/Xgaq7XCu4Npmlvgwa3+fg80evgH6dyFI/KM5pZ4akYfxl9IiZnHq/Qlu9a17tLQ9Oa1qFUd7IUxkC5JugNDOlc0nR3AUjpovZANpJfZDxjhhdVZHPKr+9BtwJEJnAMpdWWQ1AXthJI3nLzEbOxAPZfxfgS2gUZ7EGYWV8XHCrVj3QT6Hpo2HnfzT6MTYm3lnGyZeoUTVdijGr8gX1CgKB/EoqARgA91+sPDBTzfpYoy8hqICVLxvUjYJDr6ACNwXL6Rz+r9mzkAI4vsLd/KeF1i8qx0kmWmsAKJ2b+C4U6o94ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+U6Gb9aV531pVqHSEELPyAyTE0M66jeHoR2Lio9EWxc=;
 b=W2zP7WXLDzSe4vKpD7DyJC74MZVR9KCYv7L6oJ23J4mWzEDiOjDggXnCQOzgDb2wOvNuYtvLT0U37pz7wNl8EvIcMUQcWJCh7fTPUXtU9MTKy/FlQ0jZWNnjSeqnvG/Kzb2m93CGh7Td+vTe87/TxF3fWxUutVKeeYE8V3GADGw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by PH7PR12MB6491.namprd12.prod.outlook.com (2603:10b6:510:1f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 04:48:25 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::2cf7:49ea:e95c:31b8]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::2cf7:49ea:e95c:31b8%6]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 04:48:25 +0000
Message-ID: <5b5c513c-92a8-d9eb-bc07-273518ed3280@amd.com>
Date:   Thu, 12 Oct 2023 10:18:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] sched/fair: Preserve PLACE_DEADLINE_INITIAL deadline
Content-Language: en-US
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     peterz@infradead.org, bristot@redhat.com, bsegall@google.com,
        chris.hyser@oracle.com, corbet@lwn.net, dietmar.eggemann@arm.com,
        efault@gmx.de, joel@joelfernandes.org, joshdon@google.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@kernel.org, patrick.bellasi@matbug.net,
        pavel@ucw.cz, pjt@google.com, qperret@google.com,
        qyousef@layalina.io, rostedt@goodmis.org, tglx@linutronix.de,
        tim.c.chen@linux.intel.com, timj@gnu.org,
        vincent.guittot@linaro.org, youssefesmat@chromium.org,
        yu.c.chen@intel.com
References: <20231004011737.188682-1-daniel.m.jordan@oracle.com>
 <20231004130908.238992-1-daniel.m.jordan@oracle.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20231004130908.238992-1-daniel.m.jordan@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::14) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|PH7PR12MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: e24c4433-8eed-48aa-fec4-08dbcade7829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S8BhExlg4fdlsYCtaV47l55TfVQIukAYwWIHAXlPPiNldW/1G6P38LhF94huyIaNG1GPdnwkv79N9bBudkrjdxNNIl6c4fm0fqHw6jN94izAutfZDJenAgxQsJZl2vcVnFnzCuRFUgl/uNSh0xyYne8mOvd+jj25+/GsYGLLSNSgLQZvfd7eVONRK7UmTrVp5wm0vhbaMSST5tExvfwWxcorhCsZcIgG03wmFm7sICNPZjsry6X5tfBJskSeGZYRlbSRG+fPzV2WXzRtILw/PQMQy8ihYd3lSpsedysBYmAeL3AEZXX/xNNpKka+VxX+fTSZdMS+SEKOyle65e+AiFpuhV+evfRFOaCCoknXuoF/RAFvkPYAEg5E8uI/rcDMmWDV5V0Uc23CaPJ4cq6OY1vo0zdl9hrLVYobbO6PgunKXLmlbXG0DWx36UmW1bT7vimOARVn3srCq3b1OwJfVDi6lCvXbxjBwO/VDatlZ6gW8DKoJxQBKN1m1NxGEeJq6xhVGI/LC5NX4VeTyqzUvnDeOZ4L71smrsnr0qykT7cNQEzKJ8PuevwkGUFNsHzcfknd1Ns2UXEG6rA37OeZPCh86oJ9Vjf+Bo9LYob49Qd+FqVB5A7tY/GuA5Pke/2ZRuWlU9B7fv5n7odbChKInw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2616005)(26005)(6666004)(6506007)(6512007)(53546011)(83380400001)(7416002)(5660300002)(4326008)(8676002)(2906002)(8936002)(478600001)(6486002)(66476007)(66946007)(66556008)(316002)(6916009)(41300700001)(38100700002)(36756003)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDYvNWt3eHA2UEN3b0dZKy9iZ2NxcVI3TjgzdjQvMmxKWGhaVEhGdFg3Nk9j?=
 =?utf-8?B?MWxYdG5tclo0cVlaSFB6RjhQZG9LaTk5K1FQMnJoQldRb2NkTEx0ZG9VUVBV?=
 =?utf-8?B?M2tIbUZzVlNtak94WFNKUUtiaUpxdkFFMDQwZjMwc2ZCY3FnUWpHNzRpcHF4?=
 =?utf-8?B?TG5qOFYrRnYvZ1NGOUQxcXZlK21BUnpMVzFoUXh4Y3Eya3pwRnF3b0M3Q2lm?=
 =?utf-8?B?cDVmVXZwQ293SXh1cSt5NFUvZEsvU0ZYdElpdGdkNlpjWUpwNjNnQVdncDZB?=
 =?utf-8?B?WUN0NTRKS2JjT0lRazNXUWdCVUxMMlkvRHE4ZXZseitmMVdzN2NvWjF3TXNM?=
 =?utf-8?B?ZDhDd1JNd1JsY3NhTkJUeURnNmZIbFdqSDlxS2xLTFZqelI2UW8zUElvVHZM?=
 =?utf-8?B?RU1wY1B1ZlNkeUlXamphVkRHZ0pXUjh1RWRxZ1p2d002U0dEVTRUVy82cld0?=
 =?utf-8?B?OTFTNjMzUTNxdklaZWh6cGlsTjUwYTltWkNWVjQzdUMrSlpEQ09rS1kzb0R3?=
 =?utf-8?B?NmlOcVdXbkpXWU9NRnZEbUlnU0lYLzBid0JrcDFiZVFDWDVzTk9JaG92V0pL?=
 =?utf-8?B?L2ZFNHdjQlorOXl2SWcxektxZFF0d1NsYUtvNWNaWXFZRTZsb2pZSjhuZVUy?=
 =?utf-8?B?UjdGS2NVR1VseW9NbjZlbmhhc2pLUlNSd3Bxd0dXcWlCcmxiTVpUUy93WnZO?=
 =?utf-8?B?QlcySlMxY1h0ZjlaMEhYWFN0NWV3MUhZYzhCNTZFZTd2SEhFSDFiK2J6cE5z?=
 =?utf-8?B?K051QnJoMDRqUHlTMmJobnE1ei9acHp0SHk1dnkycy9rMUlMUFQyVFBSbHh5?=
 =?utf-8?B?d2lvVEI5RUFvWTEzT2w2bTQzUUhGUzA3cEUzSWVrVGhNbHM3b2lHUnlRbXhV?=
 =?utf-8?B?MFZRTE5IZzQ5YndIeFVHYkYyNkEwUGpxZnBjVC9hVWxObk1TS1lhRmJEKzMx?=
 =?utf-8?B?dndLS1FPSGM1L2k3dVdZZ0cwbVlYOHdBTVFlZURlNElhUHlkSDRjL2d4Q2k1?=
 =?utf-8?B?TktSVXhCRzRKUjFzNjB2WnRQbjRBZHVkd2ZZSVlCUSszaWRKdVRwUXl0MjZI?=
 =?utf-8?B?dDFTcno2S0JKVmhXSkJoMllUUTd5NzFLQnVJcThFSjNVZEFacE0wR000R2Zj?=
 =?utf-8?B?c0IzL29xVk5WM3NiWDN0QUp3UWhoaUFkSTJ2WjdvYWFXcDVXbjFVeXJUUFNh?=
 =?utf-8?B?bFptcEt1MEJXN0hnNmVSSmhSUkx6Si9BZEJZVWludDREeHFKY2UvTGNWcjNp?=
 =?utf-8?B?VkFPQ2JaTXQveUIrSlVNZDN6alRXaW1ERzI2ZkpUZVRDWVB4UWRQbE5mWEs4?=
 =?utf-8?B?TTJNaEY0NVlqdnVHSVovR1V2QUVNNUc4aU1hdjZ3Wi95a0N2NGRiTGVhNmZv?=
 =?utf-8?B?TTZidzk0Q2FGd1NxYzk2QjJoK3EveGVnUWVIVm5vTDRKdDdxakZ4S0FSblk4?=
 =?utf-8?B?SzBVZmlkakpkQ0lGZkQxU2NaMHdKTkZzWEZydW1lOWV1WjVXZVQ3VEp2ZytR?=
 =?utf-8?B?bW1KZzNpcXJseGRaTVp2OUdPUVhucnRKZ2s0SFkrc2ozU01xNHg4YnZ0amJE?=
 =?utf-8?B?V05vUjJidmdlUDErUXpXaU84bmtwQkwzUkJ5Um5SekJvR1o5TUU5VlZwcjZ2?=
 =?utf-8?B?ZHk0SUNqTE5icHJxbURnajNaQXlEaEp0MHpmUHh0VEYvRTBVZlFXWHJYODBH?=
 =?utf-8?B?ZGh1QjluK3lRVjlzN1NlUThlZCtPM0s5SktEOUJHMTduV25JSmtJVEowWi9X?=
 =?utf-8?B?cW43VTA3VU9YbFZ6aHBPaElJK3BrWTFxcXlSellta3BCVzBwcFUyU0hlZ3Rp?=
 =?utf-8?B?YW9RTE1Qb285eWZoSWUyT0U0V0RkK2NVclFtbCthWmdFeW5CYXVlZDVETzRE?=
 =?utf-8?B?OWV5RkQ5YUtZQWhDZFIwVERJbWVPU3ZXTTRySTZTQyt4WnY4Ymc2dEV4NGFG?=
 =?utf-8?B?YVNCRk16Y1VVemlFNXBSSW0ybC9jaCtlS0Y1cHNwYUdSTzNHZzlrSHN6U0Fp?=
 =?utf-8?B?ai9vY3BwMDh5Njg2Q3EvTWZtWWRDTkxiVklEbHhrMjd1b3luUUFkQnNWV2M1?=
 =?utf-8?B?MHhheU90S2ZrOFliNFBuTHMrTVBKbldrbk03WkI4VlluTTkyWkZFSmNETW1o?=
 =?utf-8?Q?s2fkZ6L+7XaWlHEViMLhOSgGF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e24c4433-8eed-48aa-fec4-08dbcade7829
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 04:48:25.2276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVRy2wF/kUbP/jKFSDfW6EKHimPDWF/fF7kJM0AUd08H3eghnsGriq0g7+DxQN/E2VidIvQHPN0N9x6mMGyoig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6491
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel,

Same as v1, I do not see any regressions with this version either.
I'll leave the full results below.

o Machine details

- 3rd Generation EPYC System
- 2 sockets each with 64C/128T
- NPS1 (Each socket is a NUMA node)
- C2 Disabled (POLL and C1(MWAIT) remained enabled)

o Kernel Details

- tip:	tip:sched/core at commit 238437d88cea ("intel_idle: Add ibrs_off
	module parameter to force-disable IBRS")
	[For DeathStarBench comparisons alone since I ran to the issue
	which below commit solves]
	+ min_deadline fix commit 8dafa9d0eb1a ("sched/eevdf: Fix
	min_deadline heap integrity") from tip:sched/urgent 

- place-initial-fix: tip + this patch as is

o Benchmark Results

==================================================================
Test          : hackbench
Units         : Normalized time in seconds
Interpretation: Lower is better
Statistic     : AMean
==================================================================
Case:           tip[pct imp](CV)    place-initial-fix[pct imp](CV)
 1-groups     1.00 [ -0.00]( 2.11)     1.01 [ -1.08]( 2.60)
 2-groups     1.00 [ -0.00]( 1.31)     1.01 [ -0.93]( 1.61)
 4-groups     1.00 [ -0.00]( 1.04)     1.00 [ -0.00]( 1.25)
 8-groups     1.00 [ -0.00]( 1.34)     0.99 [  1.15]( 0.85)
16-groups     1.00 [ -0.00]( 2.45)     1.00 [ -0.27]( 2.32)


==================================================================
Test          : tbench
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:    tip[pct imp](CV)    place-initial-fix[pct imp](CV)
    1     1.00 [  0.00]( 0.46)     0.99 [ -0.59]( 0.88)
    2     1.00 [  0.00]( 0.64)     0.99 [ -1.43]( 0.69)
    4     1.00 [  0.00]( 0.59)     0.99 [ -1.49]( 0.76)
    8     1.00 [  0.00]( 0.34)     1.00 [ -0.35]( 0.20)
   16     1.00 [  0.00]( 0.72)     0.98 [ -1.96]( 1.97)
   32     1.00 [  0.00]( 0.65)     1.00 [ -0.24]( 1.07)
   64     1.00 [  0.00]( 0.59)     1.00 [ -0.14]( 1.18)
  128     1.00 [  0.00]( 1.19)     0.99 [ -1.04]( 0.93)
  256     1.00 [  0.00]( 0.16)     1.00 [ -0.18]( 0.34)
  512     1.00 [  0.00]( 0.20)     0.99 [ -0.62]( 0.02)
 1024     1.00 [  0.00]( 0.06)     1.00 [ -0.49]( 0.37)


==================================================================
Test          : stream-10
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:       tip[pct imp](CV)    place-initial-fix[pct imp](CV)
 Copy     1.00 [  0.00]( 6.04)     1.00 [ -0.21]( 7.98)
Scale     1.00 [  0.00]( 5.44)     0.99 [ -0.75]( 5.75)
  Add     1.00 [  0.00]( 5.44)     0.99 [ -1.48]( 5.40)
Triad     1.00 [  0.00]( 7.82)     1.02 [  2.21]( 8.33)


==================================================================
Test          : stream-100
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:       tip[pct imp](CV)    place-initial-fix[pct imp](CV)
 Copy     1.00 [  0.00]( 1.14)     1.00 [  0.40]( 1.12)
Scale     1.00 [  0.00]( 4.60)     1.01 [  1.05]( 4.99)
  Add     1.00 [  0.00]( 4.91)     1.00 [ -0.14]( 4.97)
Triad     1.00 [  0.00]( 0.60)     0.96 [ -3.53]( 6.13)


==================================================================
Test          : netperf
Units         : Normalized Througput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:         tip[pct imp](CV)    place-initial-fix[pct imp](CV)
 1-clients     1.00 [  0.00]( 0.61)     1.00 [  0.40]( 0.75)
 2-clients     1.00 [  0.00]( 0.44)     1.00 [ -0.47]( 0.91)
 4-clients     1.00 [  0.00]( 0.75)     1.00 [ -0.23]( 0.84)
 8-clients     1.00 [  0.00]( 0.65)     1.00 [ -0.07]( 0.62)
16-clients     1.00 [  0.00]( 0.49)     1.00 [ -0.29]( 0.56)
32-clients     1.00 [  0.00]( 0.57)     1.00 [ -0.14]( 0.46)
64-clients     1.00 [  0.00]( 1.67)     1.00 [ -0.14]( 1.81)
128-clients    1.00 [  0.00]( 1.11)     1.01 [  0.64]( 1.04)
256-clients    1.00 [  0.00]( 2.64)     0.99 [ -1.29]( 5.25)
512-clients    1.00 [  0.00](52.49)     0.99 [ -0.57](53.01)


==================================================================
Test          : schbench
Units         : Normalized 99th percentile latency in us
Interpretation: Lower is better
Statistic     : Median
==================================================================
#workers: tip[pct imp](CV)    place-initial-fix[pct imp](CV)
  1     1.00 [ -0.00]( 8.41)     1.05 [ -5.41](13.45)
  2     1.00 [ -0.00]( 5.29)     0.88 [ 12.50](13.21)
  4     1.00 [ -0.00]( 1.32)     1.00 [ -0.00]( 4.80)
  8     1.00 [ -0.00]( 9.52)     0.94 [  6.25]( 8.85)
 16     1.00 [ -0.00]( 1.61)     0.97 [  3.23]( 5.00)
 32     1.00 [ -0.00]( 7.27)     0.88 [ 12.50]( 2.30)
 64     1.00 [ -0.00]( 6.96)     1.07 [ -6.94]( 4.94)
128     1.00 [ -0.00]( 3.41)     0.99 [  1.44]( 2.69)
256     1.00 [ -0.00](32.95)     0.81 [ 19.17](16.38)
512     1.00 [ -0.00]( 3.20)     0.98 [  1.66]( 2.35)


==================================================================
Test          : ycsb-cassandra
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : Mean
==================================================================
metric          tip    place-initial-fix(%diff)
throughput      1.00    0.99 (%diff: -0.67%)


==================================================================
Test          : ycsb-mondodb
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : Mean
==================================================================
metric          tip    place-initial-fix(%diff)
throughput      1.00    0.99 (%diff: -0.68%)


==================================================================
Test          : DeathStarBench
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : Mean
Note	      : Comparisons contains additional commit 8dafa9d0eb1a
		("sched/eevdf: Fix min_deadline heap integrity") from
		tip:sched/urgent to fix an EEVDF issue being hit
==================================================================
Pinning      scaling    tip     place-initial-fix (%diff)
1CCD            1       1.00    1.00 (%diff: -0.09%)
2CCD            2       1.00    1.02 (%diff: 2.46%)
4CCD            4       1.00    1.00 (%diff: 0.45%)
8CCD            8       1.00    1.00 (%diff: -0.46%)

--

On 10/4/2023 6:39 PM, Daniel Jordan wrote:
> An entity is supposed to get an earlier deadline with
> PLACE_DEADLINE_INITIAL when it's forked, but the deadline gets
> overwritten soon after in enqueue_entity() the first time a forked
> entity is woken so that PLACE_DEADLINE_INITIAL is effectively a no-op.
> 
> Placing in task_fork_fair() seems unnecessary since none of the values
> that get set (slice, vruntime, deadline) are used before they're set
> again at enqueue time, so get rid of that (and with it all of
> task_fork_fair()) and just pass ENQUEUE_INITIAL to enqueue_entity() via
> wake_up_new_task().
> 
> Fixes: e8f331bcc270 ("sched/smp: Use lag to simplify cross-runqueue placement")
> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

> ---
> 
> v2
>  - place_entity() seems like the only reason for task_fork_fair() to exist
>    after the recent removal of sysctl_sched_child_runs_first, so take out
>    the whole function.
> 
> Still based on today's peterz/sched/eevdf
> 
>  kernel/sched/core.c |  2 +-
>  kernel/sched/fair.c | 24 ------------------------
>  2 files changed, 1 insertion(+), 25 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 779cdc7969c81..500e2dbfd41dd 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4854,7 +4854,7 @@ void wake_up_new_task(struct task_struct *p)
>  	update_rq_clock(rq);
>  	post_init_entity_util_avg(p);
>  
> -	activate_task(rq, p, ENQUEUE_NOCLOCK);
> +	activate_task(rq, p, ENQUEUE_INITIAL | ENQUEUE_NOCLOCK);
>  	trace_sched_wakeup_new(p);
>  	wakeup_preempt(rq, p, WF_FORK);
>  #ifdef CONFIG_SMP
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a0b4dac2662c9..3827b302eeb9b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -12427,29 +12427,6 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>  	task_tick_core(rq, curr);
>  }
>  
> -/*
> - * called on fork with the child task as argument from the parent's context
> - *  - child not yet on the tasklist
> - *  - preemption disabled
> - */
> -static void task_fork_fair(struct task_struct *p)
> -{
> -	struct sched_entity *se = &p->se, *curr;
> -	struct cfs_rq *cfs_rq;
> -	struct rq *rq = this_rq();
> -	struct rq_flags rf;
> -
> -	rq_lock(rq, &rf);
> -	update_rq_clock(rq);
> -
> -	cfs_rq = task_cfs_rq(current);
> -	curr = cfs_rq->curr;
> -	if (curr)
> -		update_curr(cfs_rq);
> -	place_entity(cfs_rq, se, ENQUEUE_INITIAL);
> -	rq_unlock(rq, &rf);
> -}
> -
>  /*
>   * Priority of the task has changed. Check to see if we preempt
>   * the current task.
> @@ -12953,7 +12930,6 @@ DEFINE_SCHED_CLASS(fair) = {
>  #endif
>  
>  	.task_tick		= task_tick_fair,
> -	.task_fork		= task_fork_fair,
>  
>  	.prio_changed		= prio_changed_fair,
>  	.switched_from		= switched_from_fair,

--
Thanks and Regards,
Prateek
