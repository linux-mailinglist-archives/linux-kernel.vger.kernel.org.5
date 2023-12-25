Return-Path: <linux-kernel+bounces-11111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C92C81E164
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 16:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22503280CA7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 15:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89629524C9;
	Mon, 25 Dec 2023 15:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KyjK3XNu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2125.outbound.protection.outlook.com [40.107.6.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4885A524B8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 15:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8yMu2ooCFrMtgEWkBlV+YUF+U5DFe824uO/gxDxGuDrULWP7F82mgu/8wbwTZ7Ar7nfLCsyz1LSTHrvRReP36ray2H9moe7A3qsgN3J2jCh9H90EDpjsZaMGZW3w54JV6sHTbIaVDQHWxSwelxiFarzCQ6tHTLc1eUABD33Qtpp4EbQbLm4siiplU4yqk0EgqHg1NrDude6tQjK8P2OSOaBAvsAm4TBkEp/emd6sMOkUEH9jgKtma7r08ztVaq6uFRoRurpnNtWlGKvB4h4zit4gPoAT3q26EE3Nl8CunXdthUs0xJkGbrWs8do0qgHIdAkJanBDxJo0/TB0eWDqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTkgoP7jjfmg5fz9y6TifOVzoo4f2yeESGFRmZlmjFM=;
 b=ChlOSv+c6YI5PNJY+BW3IwoDu0w7Y2uoXfjmDpRq5gH3mh0/0LL2g/Atcf5ix3Z69jwrNQ04CjTCzJon6P9WlKFnXpHk1ADnLlwOQcg4+y+0cfW2WmFfPfPgsz4AE8vX2NrUA8fITjGpk/Rx671tZwrZGZ8NV4A67NQe51Tuf14QaEy5FpwVmIDKSw1wTQrfag+PNusCCXZY3ljM6vBQsq3NlRFrOXSuzYBLvJ1pw60kroihwCyPq1CZbm4GeWUsiCFdkJUNVSAsyMYPElEMff2sdctdOg1l/cmHS6IvgdD/Ye+vAsu349cchhU/rIP34dc8PCwlOM9vf7Gc375TdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTkgoP7jjfmg5fz9y6TifOVzoo4f2yeESGFRmZlmjFM=;
 b=KyjK3XNuaUXo+yvK3MigYbFqpcc33Kk2IQLcN9Qoj5IcBjvcw0CoflJMTXygMe+lWFrEEJoNoHDd+UWIvdnV9+jy4MnrhCvQQt/HpsLca4CG9ONAnzrBCKW7A1PNqWSu0NXOO5s10K0LwVxTRBiSVV0aleXI8uAzraJ62uEqcBetT6J7iIEJK80AGIs/WW4+Xv80DHbSs0d2gWliMc59k/k7ksSznC/JY5QDQ0UfgGuZXZEzFFoiTQONo6BbxMoZPIuMdFXyWOfef2urUA1aKA2GShIffH9PfWvHt2Onms0QNBsN8QSKrqJF0TjUS+jV1wpC+I0eYzPpOLCIx7E3Iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PR3PR08MB5836.eurprd08.prod.outlook.com (2603:10a6:102:8f::10)
 by VI0PR08MB10557.eurprd08.prod.outlook.com (2603:10a6:800:20b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Mon, 25 Dec
 2023 15:17:53 +0000
Received: from PR3PR08MB5836.eurprd08.prod.outlook.com
 ([fe80::b1a4:bfbf:c799:d818]) by PR3PR08MB5836.eurprd08.prod.outlook.com
 ([fe80::b1a4:bfbf:c799:d818%7]) with mapi id 15.20.7113.023; Mon, 25 Dec 2023
 15:17:52 +0000
Message-ID: <2cf94373-4f25-4a33-a0b4-cab04031bae7@virtuozzo.com>
Date: Mon, 25 Dec 2023 16:17:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Do not scan non-movable tasks several times
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
 linux-kernel@vger.kernel.org
References: <20231214144204.2179345-1-khorenko@virtuozzo.com>
 <CAKfTPtAqkY+attpekOyjeY10dcwgK0eND5_385cH6+wjR3EkTw@mail.gmail.com>
Content-Language: en-US
From: Konstantin Khorenko <khorenko@virtuozzo.com>
In-Reply-To: <CAKfTPtAqkY+attpekOyjeY10dcwgK0eND5_385cH6+wjR3EkTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0127.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::11) To PR3PR08MB5836.eurprd08.prod.outlook.com
 (2603:10a6:102:8f::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3PR08MB5836:EE_|VI0PR08MB10557:EE_
X-MS-Office365-Filtering-Correlation-Id: b25c64f5-b91c-4231-7668-08dc055ca9b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sdsZZCI0eXzcZJDPRD5kemWf9iSWnQDhAssshnj9IyJnLL4HG0E7nQXzjPM5YwJlnTbaRRjWDAzNU1fr+uFyg674x4NmPRBOyMpHtfBm353+lnRxxoUv4rlmKWWheehXy8p+KZCyw6AnDqObXMWFo7V0pTJCc5jFMdchOrMP9AsiaSiZe6DEoPvcExJ/ew4hJhNPTW17Ht0tuQcf+MBQwne/OCVF3vfdzEy22uUfWGIaEF3hpZx3FKXUVFec+o+CzmOd6Lu+trttNpoRBU34EZyzW45M/xvoS1l8CUvPx9fhvaMA1dvycQTY99m+5+K7ctZBi/MKicWAAiPHEltA+A0iIzDMFKQKY8s+7fGSs4Pm68oQq+cZdyW15oN65yJMlJh/z32Is7ot9FappxJOSbUU+EFysdtv+nz+XkZy/HwjtXi3HmZzFGZtWko3Qt/t6hkIOaVyr1RVgvVoDFjD4WKdCe/DBq1mm7JT40OcQl17pa9EqwV87LMzUgu41k8GmHvTbKaYqaiD5215ifLMpZajKgoQsexK3jGebyLLGFE+GMqm2ngiOvxx0sdwoCeYlGGTHN9dIYHOhq/gev1fzox087a5vyFeVkL+61LlVgbXJH4LROk5HflgvFf8pKHs1T4Zunj5p0z99V6re3h1sQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5836.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39840400004)(376002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2906002)(31686004)(66476007)(6916009)(66556008)(66946007)(5660300002)(7416002)(4326008)(8676002)(8936002)(316002)(54906003)(41300700001)(53546011)(36756003)(478600001)(6486002)(6666004)(6506007)(2616005)(26005)(6512007)(31696002)(86362001)(38100700002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDM5OFMwZWZxNWtrMURvSnd5cENEZDBzMXUxd3lWTHRDSmJiY29zYUx2RU9u?=
 =?utf-8?B?djFzWTVYcVUyOFRQaGNreUloZ083UzhIbWYrSlVkb3pYRjJoWjVIQlh2dVVo?=
 =?utf-8?B?MlQ3NVpEYjY5SFBHdkVUN3B5cUs1Kyt6eVVJWDBOK1ZmMUVtb1pYSjVFS1Fi?=
 =?utf-8?B?QTlRS3FFQlp5aVZaRnJ0YzhWQ2UyOTVmaGZOT2ZNOVRlWm8yTysyUVZxeU9J?=
 =?utf-8?B?NVNta2dxVHE5UFBBKzJzWkZPZ29ESEk0MEZsdEJzZ1FvTlpXczZyMHJLWW9H?=
 =?utf-8?B?M2g3bDZScGhsak9rK2hwQWFpV2FweXRyMEl4bWEraUlCbHlIT3FqRXFZZ2tQ?=
 =?utf-8?B?c0RhUlA5R1docytsVUxSNnJmN3ZmNFVBVW1tWERQcDA5RFhmL1JPekJBRWNO?=
 =?utf-8?B?MWpPYmFTV0dQZEVndmdkVDJTaFJIaWhiZGJFSHptQWRLQjRxYis3Z0JReVVX?=
 =?utf-8?B?SHp4M01ENjcrY05HU1VBNDdFbVNzSnBYZlF0dVJrcXZ6Vno1QTRjNVYwbTNY?=
 =?utf-8?B?a3MrVExaQW8yYVhxTDltcStaenZ4NFJuTXQ2NTMveFVSaHJ5ZWZVU3JrNWNr?=
 =?utf-8?B?WTdGRGFYNmZGK0FpRUxZN2RmbVN3NmMwWi9sUmlUSlQvK21NTW9tZC8rRmcy?=
 =?utf-8?B?NVh4V2FKeDZWamFxbnBwR2NuNXZIM3NlOWFIbzRTSWduQnI1Q2ZZUEdvaWlv?=
 =?utf-8?B?RUNONWtEdkdCdGZleTZ4VWIxVGg0djRzdWVjQzYrZmtGdGM5QXN1NjVWVU5P?=
 =?utf-8?B?L3hTbjVxanorVHRlYU04ZUd4Q0VLRnNUeVhyelRGN0FMb1lkNUtmMWtpelk2?=
 =?utf-8?B?WU5WZGNvaDFzM3l5RnFza1NqY3dZdE9IeDE3elYrYU8zOUd2MHdqbDFqNmV0?=
 =?utf-8?B?N2Q1c2lvaXZpN3hUTVVZaFpuWVZObkpYdlFpWWZ4Q2Q2OEQyVEt5WlZFQTA3?=
 =?utf-8?B?OGpRQklEQkdrQ3EydnMzS3gybENsbDdVZ3ZxZVVBWmtaM3BISE4xYzBiZlRV?=
 =?utf-8?B?MFNyQ2xmL0tmU1FpYkNvZ3hlV1YyK2Y0a3U4Vjd2NTErdW5nbGRnQnpGdng4?=
 =?utf-8?B?NnphMmdZd3VMN2RmZUxBZTQwV1dvYmQ2dWp2ak5DSU0xalZZSGp3akY3bkZG?=
 =?utf-8?B?Ni96ZjYxT2liS2tmMGIwalF5YUdwUDBoU09nK1NKbkNNTjdjWnRTc0lYRTZL?=
 =?utf-8?B?NHc0NUh4SHRlTlZWMm5MOWxvT25rSnJaSzh0cUJFZzY3bHNFT2ZydnY4Rmp6?=
 =?utf-8?B?Uk0wK3ZYRWJEYTRweEJiQlRkSFBjNCtqd3MxZWx3R244eTA5YkJOR0swTG9t?=
 =?utf-8?B?Q3RUdWRWRUp1c0tiNm9GM0FiQndOQ2ZwOWw2WktzTW4zcXZDc1NwYVVlWlJt?=
 =?utf-8?B?ckYzRGRHNm9lb2NwcUxxemo5cnppN3c3NksrK3M2YUhUSjN0OUdzYUd6VXdT?=
 =?utf-8?B?QnpNTC9qRWVPZG9STHMvT2VUcThSSFgzcm5lWnJ5VXRrcUJQVkdRZ2taYU5k?=
 =?utf-8?B?bEhPVzRaaTFpTXY3YU1kLzRQclRVZkZhUkZpWDhaUjZZbVJ1NkNSdWJ6N0xh?=
 =?utf-8?B?QTFaRS9jOEc0Vk8rRDgyL0JQVWo0bkppbmhKanVGQkYzMHFnN0l0MGoxa0FQ?=
 =?utf-8?B?QXZCWEZuTkZKZGRYancyMDV3Slh5aHJ2Y3FoVWpjVjNVTWtGM0dkTnI2SmFm?=
 =?utf-8?B?WGMveUU0SmRzcjRuTUVxTkR3NTJYMFlLWC8wSmpOYUdUZmpKcUg5VE9oelFF?=
 =?utf-8?B?Z1owQWtBd2ozcUF6WGExY0xXTDlISnhmb1VESWpJNXpwWFdHZlFkUjBzU25V?=
 =?utf-8?B?RGJPU0trREhCVWE2VTVCK2VuSXZHaWhpQnIvcHh0TS9hbTFUUGpEbTVIbGhG?=
 =?utf-8?B?dUlZc3J5UjR5RjE1Y3ZFUFJpWk5tU0kwWTNOS2IweWJJMy8xNUo5M3JraTlE?=
 =?utf-8?B?SE1zOVN5ZXMySTJLVGY4Z25vaEtuaFJZVVhvNXgvbHJyVEpKLzhFU1pmeDZ6?=
 =?utf-8?B?czhpbWRVaDJaclZZd2duRjRrSjJ2cFU1MGloRVdxdTEwUjlnZmxBbDNKQlhy?=
 =?utf-8?B?TUtmSnlIT2VHbU5ZN1l2RzB4eDVLakdNeXZ1cUxDRkx6aThLRVZpQVJBeHAx?=
 =?utf-8?B?cGRlK28yL2FGWEYzdkNFa2FWSEJFTzNtbS9RNGFuYmxDOUI4QVVESUxXQjdi?=
 =?utf-8?B?SEE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b25c64f5-b91c-4231-7668-08dc055ca9b6
X-MS-Exchange-CrossTenant-AuthSource: PR3PR08MB5836.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2023 15:17:52.6651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7Mb/jx3vFFKh0gJvPyUkXCEpTbwsJQVvJ33bT6QNfA4HS9P2YwH2LvhcTCU3bX753NkMk6+xRUhlUEexiREkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10557

On 18.12.2023 17:48, Vincent Guittot wrote:
> On Thu, 14 Dec 2023 at 15:42, Konstantin Khorenko
> <khorenko@virtuozzo.com> wrote:
>>
>> If busiest rq is small, nr_running < SCHED_NR_MIGRATE_BREAK and all
>> tasks are not movable, detach_tasks() should not iterate more than tasks
>> available in the busiest rq.
>>
>> Previously the (env->loop > env->loop_max) condition prevented us from
> 
> It's usually better to give the commit directly when we know it :
> Before commit : b0defa7ae03e ("sched/fair: Make sure to try to detach
> at least one movable task"),
> the (env->loop > env->loop_max) condition prevented us from ...

You are definitely right, added.

>> scanning non-movable tasks more than rq size times, but after we start
>> checking the LBF_ALL_PINNED flag, the "all tasks are not movable" case
>> is under threat.
>>
> 
> Fixes: b0defa7ae03e ("sched/fair: Make sure to try to detach at least
> one movable task")

Added this too, thank you.

>> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
>> ---
>>   kernel/sched/fair.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index d7a3c63a2171..faa2a765e899 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -11219,7 +11219,6 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>>                  .dst_rq         = this_rq,
>>                  .dst_grpmask    = group_balance_mask(sd->groups),
>>                  .idle           = idle,
>> -               .loop_break     = SCHED_NR_MIGRATE_BREAK,
>>                  .cpus           = cpus,
>>                  .fbq_type       = all,
>>                  .tasks          = LIST_HEAD_INIT(env.tasks),
>> @@ -11265,6 +11264,12 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>>                   * correctly treated as an imbalance.
>>                   */
>>                  env.loop_max  = min(sysctl_sched_nr_migrate, busiest->nr_running);
>> +               /*
>> +                * If busiest rq is small, nr_running < SCHED_NR_MIGRATE_BREAK
>> +                * and all tasks are not movable, detach_tasks() should not
>> +                * iterate more than tasks available in rq.
>> +                */
>> +               env.loop_break = min(SCHED_NR_MIGRATE_BREAK, busiest->nr_running);
> 
> Should it be after more_balance: ?
> In case we do "more_balance:" on a new_dst_cpu and it ends up that
> finally there is no more movable task as we released the lock of
> busiest rq in the meantime ?

Well, both yes and no here.
If we simply move the env.loop_break assignment after "more_balance" label,
we will break the handling LBF_NEED_BREAK case.

But you are right, the new_dst_cpu case should also not just reset loop_break to 
SCHED_NR_MIGRATE_BREAK, but do the same min() calculation.

So i've added one more label before the env.loop_break = min(...) and used it in
the new_dst_cpu case.

> Also you can remove one more superfluous init of loop_break:

Yep, dropped it, thank you.

> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11361,7 +11361,6 @@ static int load_balance(int this_cpu, struct
> rq *this_rq,
>                           */
>                          if (!cpumask_subset(cpus, env.dst_grpmask)) {
>                                  env.loop = 0;
> -                               env.loop_break = SCHED_NR_MIGRATE_BREAK;
>                                  goto redo;
>                          }
>                          goto out_all_pinned;
> 
>>
>>   more_balance:
>>                  rq_lock_irqsave(busiest, &rf);
>> --
>> 2.39.3
>>

