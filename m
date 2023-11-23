Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD747F5B10
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjKWJ3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWJ3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:29:33 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2108.outbound.protection.outlook.com [40.92.91.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB061A4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 01:29:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJ+FhHo1l3NSYKFk1ooc2YryJYcsMmf/pXLoYtHYoZeUdvtN9+pVNdoZyU1rFMVVtTeaRDNKnxu0POgrecMBdjxWj0FtPU2SSr/6D7Kbzd6O/zAQke0HRutcJgENeuYSiLoDMSC7yrr1p9SmyJfbTJYiL8ufOb6Uk7jnWqcKKv4tojhPpELNn1QTT9WdQ7uWjdvhFia9LKUBdtwKzK48pVemrZC7n9hnuND6oKSxJwoV+RhYNgwdyO+m3knbk6QNfbMqlpvtOWUkNeluVpKzhffDUpRoIlsGHSK3rTLqw2ppHYnRcJOt4gDf610rqxGL8ZL2Qi8wCiMFGxF2f6xH6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GH3/rj16Y5HSx/xV+g6xT9t81Hcil6EtJlo12wuPdAA=;
 b=kKMR8nyvcBRJtW/lbW4xsqulLluSa6Gva5Y6x2czPK6l13J1TnAkTrt43BKl1RtT/9nCsLiJ2ckBU26Pj8DTA5RMz6iNLVZZ8IawbpgmriP43RPua4zCZshGe96cNwfPsP5O5aGQaQ8sicjhnSbpW4TNmbxk7iOWZR48JHycFpUZSTo770Z1DZw735oFS5Yet53ED5CO1oSFj3o1MnX61NfR4cdL6xmMQPAfioxqFtz4pAj7nN1WTieU7ISWE0C1qR+F3rnuHpeI+t4IPP6DV4en3ZavB05Pf7SwwsVofNGShtQxnRVHYAB1p+C7/XQ30S2+TLK+vXUAgL1mqgMHVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GH3/rj16Y5HSx/xV+g6xT9t81Hcil6EtJlo12wuPdAA=;
 b=BWhD3/10s+l8TOU5VFJLpM0uoTOqHNiPfLcDeWOBWdouNBUm3dR3F3PvSlnRWBqmGjo38qL5M6oDkm16Om4eFKD0NY4Tfs+KPc8rZ4VJFfuW/fpQ+GF1ZvTYFhBnZCo7j+1bFj37pLEDE7QdHmObLjHzCzDimxT9ufa4E+SMglqNc4pKs6/Wh6DnqwbOcYlO21VTyDXrgZ7BFwa/smXV2SLK4zqtXwVVu2av6xZtJhW5XWZrHG1ZXZV7gnFvi2fYDOe7245NpXDR5kaDF9pPd9Hbrtz2jSlgMQMIiyEiouKzi28FP6k6FQw1Law3n8WTRNbR6R5qKxp1wfLdEfaoeA==
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:32::19)
 by AS8P193MB1159.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:339::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 09:29:33 +0000
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::fdd2:7dbf:e16c:f4a4]) by VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::fdd2:7dbf:e16c:f4a4%5]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 09:29:33 +0000
Message-ID: <VI1P193MB0752D8881930F88BACFB56A499B9A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
Date:   Thu, 23 Nov 2023 17:29:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kfence: Replace local_clock() with
 ktime_get_boot_fast_ns()
To:     Marco Elver <elver@google.com>
Cc:     glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <VI1P193MB0752A2F21C050D701945B62799BAA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
 <CANpmjNPvDhyEcc0DdxrL8hVd0rZ-J4k95R5M5AwoeSotg-HCVg@mail.gmail.com>
 <VI1P193MB0752E3CA6B2660860BD3923D99BAA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
 <CANpmjNMejg7ekEhuuwdxpzOk5-mO+xn+qEL1qmx8ZVQG9bz_XA@mail.gmail.com>
From:   Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CANpmjNMejg7ekEhuuwdxpzOk5-mO+xn+qEL1qmx8ZVQG9bz_XA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [oXIrqfHfyek/BZEUsSm1zbxFEZXRlLz8]
X-ClientProxiedBy: LO2P123CA0066.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::30) To VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:32::19)
X-Microsoft-Original-Message-ID: <16b08365-3909-4ff6-83fc-3ecc3dbc49af@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0752:EE_|AS8P193MB1159:EE_
X-MS-Office365-Filtering-Correlation-Id: 2652ba79-b967-42a4-c5ac-08dbec06b3ac
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AgXhaP6WO9FQYIdYg4Gpy3uIhOk/yyKqcPyUXsWrSSj44ToYw2aEgV0hLcx24gUaq8OAAwOjd03AXMUDGPwcZY5lUvXOy6cWPzWStzvBiCEy2Wq/sh7OcQyalochA9a5qf3xd6CKANbtuXmU9OPT9odPSs1ssm1uraGeE7IxdPVGZZQE3xbUXLvnueu1IUGZVDNl8Uxv93x8ckdW2Z7GOBXGgSLpW7w8yWdSFtyFPra8e3RmPlsA2QdBFkUITMcwZGsilLOdj91wWLzPVW/rMSajzLKo/+4OV/yu+PTQGA8lfbpK8C6U6kn6YFvpCJ4RmSakfuqu+VzSryOQasnmd+dGtTN4hY24glwacoRqDb1rdbRbDDA4997Ve1hYSorxRYLSp7P0WFch0DhS+F7vw2enYlbNTGuV8V79bmweRrnFPg6ghqzhSv/qR0AHEdiJCPlJFvnmplwOswLBKB/XKrbZAu8PMe0izuMXqqDihVq0LLLKbY+HkGrqSR5dqec/ia4hxQFtJ9KwFehUihxy9F/psmnoPaja9RRaBV5vdKnj9YVvOm0Hdv3xp8ZSjdml
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0I1Z09XTHl3RXViS3NrajBmdTM5UG1EWkQ2dDNjRHd5ZWlKWjZFMmc0SnVj?=
 =?utf-8?B?WXJ2Q24yRENuaEp3blJuQ2FEWEMwVkZUVHpwTldLMDJOdUJvREhPcGFaVWFx?=
 =?utf-8?B?LytJL3N3ZUJQUXJBTHNhMyttWjc3Yjl1NWVTekRUeDhPSHRFNUVUNEdHNFRD?=
 =?utf-8?B?WUVGZUhvVmlzeHVtalovNTQ2ZC94RE12SDU5VnVsODYyL000Rm9Qc29HV1lw?=
 =?utf-8?B?RjY4dm1kSWQzQmo4K013V0Vma2NKdmZMa01lSHRiMFdoeG1rVElsR3J2cEox?=
 =?utf-8?B?UWk4VWswQXZGQk8ydWhtOVkzKzNSbTZheGtvR0N0SHRNM1hDOUFiZnlpTXVZ?=
 =?utf-8?B?VDdWVG5mRWNzY0t4OHpEQ2xwVXM4UjlSSy9xejdTWkxpeVRmNHhySFhBc0Ju?=
 =?utf-8?B?eWFDbHlCRy9KTUVWQllWdFFQUzd6UnJ5eHNLNDdqWkNCdEpxYjVBYUtDVlgz?=
 =?utf-8?B?QnZobDdJZnRKZXlRQzNHd2kwNFd5Mk5nYkt5VE16Mmkra04yS0t4eGJnRTVm?=
 =?utf-8?B?QVpQK2N5dHlqUFVWUUVNZXF4WUl5Wm1jM2ljU05vVGZleXFUSFZxZUpGMDdj?=
 =?utf-8?B?djd4eXM5KzNLOXN3VFEwWjZPbzdyNUVJOVg1bHNiZzRRbWF6c3F2K0NnTnVH?=
 =?utf-8?B?d3ZocFV5QnBMVmZNQW56Sm5WcVo3YUZFcmI1Z3ZYSmtObEFodWQ4OXZlNUsz?=
 =?utf-8?B?RXJpQk1WRkd3TThPbDJKYlVtMmlnSEgrVGV0MTh1NWYzZm5IS1lnd1Q1QkRF?=
 =?utf-8?B?TzNXSEZtSDlrMDVsVTBrc1BTZW94bnUwSSs2L2xjSzMzMU93dmdMb3hvQUhC?=
 =?utf-8?B?Z2sxOHBiUmJJbGtzNzFqWTZBMHhnOHlzS3BGTXNOYU5BNkJCZ3JEVVVaKzds?=
 =?utf-8?B?eTF5eXFId2hZRFJHUEtnakR1V0R5Rm5XdVdzZ3dja2xGOGZrU1JEckphZmpo?=
 =?utf-8?B?TnFCcHZmcWhMdC8vTHBTM1JSQUVrRE5taVltREhKS2RTbzJPNU5rVUMvL0Z6?=
 =?utf-8?B?NEpXYjRUVXJxd2FOaExlelBUV093QUZQUmhGQ0NzTUNpMkI1TldkdXM5ZlVF?=
 =?utf-8?B?WE5DNDduSFR6SWF6aWhwOEs0dU9sTCtQRS95RndtelNIWEpKMmNkSFZyVndX?=
 =?utf-8?B?OW9FdnZMRmQyVnBtdE81ZkpWQld5dmZZWkUxOGw4dXE2Qk5aZ3BtRHAyMFJB?=
 =?utf-8?B?TlhDcDBOR25YL2lvbGthczNhWkRPb0JWNGZrcXJtS0YyQng5YmtTMXhvSDhZ?=
 =?utf-8?B?WXRwMlhTdk1ac1NOQ0pjNm9JTnhlcTVTdVJVWThadjJ1cTZWb2Qrcll6cWtJ?=
 =?utf-8?B?bTRDUk1USjZuZlhXOGFyaVpKOXN2Mk9LZlhTeW9ETWthaGlaazF5ZVlSbnJP?=
 =?utf-8?B?c2hQNk1vMWJkNHpxSmc0STVyS2dYckE0WktKN0VXKzhVV21GUGkzSlBicks1?=
 =?utf-8?B?TkhEZVo3WlgvNE0wUzBoME5jSm1uNTFEbFZOOTRXV0Qzb054TlNqTmxmcWNt?=
 =?utf-8?B?T0lVSVEzTGhIdHF2c1U3ZGx5Q1F2cm1xdHR1dXdBYTYvNm5PQTRvZUlPa3pG?=
 =?utf-8?B?YWE3TUtyWGYxYWMyWXNiSFRKbUR0U3llN1lhbk1lVXorcUVuWklaM2dMZjRY?=
 =?utf-8?Q?SMRr19uUMIsSdRSmq4o75LlXjHVweZn/fY78xyHrqfKU=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2652ba79-b967-42a4-c5ac-08dbec06b3ac
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 09:29:33.6566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB1159
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/23 6:19, Marco Elver wrote:
> On Wed, 22 Nov 2023 at 22:36, Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>> On 2023/11/23 4:35, Marco Elver wrote:
>>> On Wed, 22 Nov 2023 at 21:01, Juntong Deng <juntong.deng@outlook.com> wrote:
>>>>
>>>> The time obtained by local_clock() is the local CPU time, which may
>>>> drift between CPUs and is not suitable for comparison across CPUs.
>>>>
>>>> It is possible for allocation and free to occur on different CPUs,
>>>> and using local_clock() to record timestamps may cause confusion.
>>>
>>> The same problem exists with printk logging.
>>>
>>>> ktime_get_boot_fast_ns() is based on clock sources and can be used
>>>> reliably and accurately for comparison across CPUs.
>>>
>>> You may be right here, however, the choice of local_clock() was
>>> deliberate: it's the same timestamp source that printk uses.
>>>
>>> Also, on systems where there is drift, the arch selects
>>> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK (like on x86) and the drift is
>>> generally bounded.
>>>
>>>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
>>>> ---
>>>>    mm/kfence/core.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
>>>> index 3872528d0963..041c03394193 100644
>>>> --- a/mm/kfence/core.c
>>>> +++ b/mm/kfence/core.c
>>>> @@ -295,7 +295,7 @@ metadata_update_state(struct kfence_metadata *meta, enum kfence_object_state nex
>>>>           track->num_stack_entries = num_stack_entries;
>>>>           track->pid = task_pid_nr(current);
>>>>           track->cpu = raw_smp_processor_id();
>>>> -       track->ts_nsec = local_clock(); /* Same source as printk timestamps. */
>>>> +       track->ts_nsec = ktime_get_boot_fast_ns();
>>>
>>> You have ignored the comment placed here - now it's no longer the same
>>> source as printk timestamps. I think not being able to correlate
>>> information from KFENCE reports with timestamps in lines from printk
>>> is worse.
>>>
>>> For now, I have to Nack: Unless you can prove that
>>> ktime_get_boot_fast_ns() can still be correlated with timestamps from
>>> printk timestamps, I think this change only trades one problem for
>>> another.
>>>
>>> Thanks,
>>> -- Marco
>>
>> Honestly, the possibility of accurately matching a message in the printk
>> log by the timestamp in the kfence report is very low, since allocation
>> and free do not directly correspond to a certain event.
> 
> It's about being able to compare the timestamps. I don't want to match
> an exact event, but be able to figure out which event happened
> before/after an allocation or free, i.e. the logical ordering of
> events.
> 
> With CONFIG_PRINTK_CALLER we can see the CPU ID in printk lines and
> are therefore able to accurately compare printk lines with information
> given by KFENCE alloc/free info.
> 


That makes sense.


>> Since time drifts across CPUs, timestamps may be different even if
>> allocation and free can correspond to a certain event.
> 
> This is not a problem with CONFIG_PRINTK_CALLER.
> 
>> If we really need to find the relevant printk logs by the timestamps in
>> the kfence report, all we can do is to look for messages that are within
>> a certain time range.
>>
>> If we are looking for messages in a certain time range, there is not
>> much difference between local_clock() and ktime_get_boot_fast_ns().
>>
>> Also, this patch is in preparation for my next patch.
>>
>> My next patch is to show the PID, CPU number, and timestamp when the
>> error occurred, in this case time drift from different CPUs can
>> cause confusion.
> 
> It's not quite clear how there's a dependency between this patch and a
> later patch, but generally it's good practice to send related patches
> as a patch series. That way it's easier to see what the overall
> changes are and provide feedback as a whole - as is, it's difficult to
> provide feedback.
> 
> However, from what you say this information is already given.
> dump_stack_print_info() shows this - e.g this bit here is printed by
> where the error occurred:
> 
> | CPU: 0 PID: 484 Comm: kunit_try_catch Not tainted 5.13.0-rc3+ #7
> | Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2
> 04/01/2014
> 
> And if the printk log has timestamps, then these lines are prefixed
> with the timestamp where the error occurred.
> 


Thanks, I found that information.

Since this information is at the bottom of the report, I had previously
ignored them.

I would suggest considering moving this information to the top of
the report, for example

BUG: KFENCE: out-of-bounds read in test_out_of_bounds_read+0xa6/0x234

CPU: 0 PID: 484 Comm: kunit_try_catch Not tainted 5.13.0-rc3+ #7
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 
04/01/2014

Out-of-bounds read at 0xffff8c3f2e291fff (1B left of kfence-#72):
...

This more clearly correlates this information with the occurrence of
the error.

If the timestamp of the printk is used as the timestamp of when the
error occurred, then my patch is unnecessary.


>> For example, use-after-free caused by a subtle race condition, in which
>> the time between the free and the error occur will be very close.
>>
>> Time drift from different CPUs may cause it to appear in the report that
>> the error timestamp precedes the free timestamp.
> 
> That doesn't matter. I recommend that you go through a hypothetical
> debugging scenario:
> 1. We are not interested in the absolute timings of events, but the
> logical ordering between them.
> 
> 2. The logical ordering of events is inherent from how KFENCE
> operates: an error _always_ follows an allocation and/or free. From a
> debugging point of view, the timestamps do not have any value here.
> 
> 3. The timestamps _do_ add value when trying to figure out the logical
> ordering between allocation, free, or the erroneous access _with
> other_ events in the system. A stream of other events is always shown
> in the kernel log (printk). Other streams of events can be obtained
> via e.g. ftrace (which also uses local_clock(), see
> kernel/trace/trace_clock.c).
> 
> So, the timestamp that KFENCE should show is the one that most likely
> allows us to deduce the logical ordering with other events in the
> system.


Thanks for the detailed explanation.

I now have a better understanding of the purpose of timestamps in
KFENCE reports.


