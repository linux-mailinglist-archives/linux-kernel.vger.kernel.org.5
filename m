Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94D07ED64B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343654AbjKOVxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjKOVxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:53:20 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2057.outbound.protection.outlook.com [40.92.90.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B08130
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:53:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+AuDQlqyaplWuDxOKJynCWmLCF/XQx9ZCOwl/D6NtUeVJGe/DcODuanJmLje+WDBX2kdesSiQ7BPeR8RGOOOWmRCXF9pTfUfQZks5W21lfEFKh5uhlQYawNm8qv7f4PxcgEiukRiYu06qeApnfTQtqfE55/z2//cCgFimvIizDj1sFMxb90WfaznGC+IsjQsFKgSDqTH6ceEJ1au3YnUu9yWOW7Sucd05cbLq3jpwZ7pZwWqEeJ9RAGPNdxYMZTg0n9TRV4u27TLXgZA7iWmhoH0b9aQtu9XnnMgiSSWPcCNIzs11nYUMvXuqKrjMY91jDaCWTXxA1JYLGIOzWxag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZckqlSOZAg0ch00Wd4Zv519VdUR6NBrskN57SxTLUvQ=;
 b=ZkU09di28Kl1flww2ubiAs2ZOoncsJU/QVJ7BH7sx/PoBB2FBiLjw5lmm2ipE+Tjt6w0THHfugjyfDI/UPxDovESEunVTG4IW50QxiXIFzooLNDsj+Ro+3uF3NRWOZ80gtvwvEirKzAvDyUg8uZZdedvgW38twsy2eMxOqIpcXdHERDmfBfI2Ee9amzxcBwgHO8zuzM8iDDOv00qGEBissVSRj1suRTRoVSD6aFaI6NVGo9JY0uhJCKh0NkA8RfOteTtV7eJrr5f7Wro6HvP6APED4OcXBCUkEvx/xI2k9baA2miQRIV2+9BbZiBI8mg7Tmw2yH5ZkJNIPd3sEhQhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZckqlSOZAg0ch00Wd4Zv519VdUR6NBrskN57SxTLUvQ=;
 b=DD9GUp3kPJ187qDhoqoKKrgeIlpePyqKlujpfq4e8WyXjAaIybQ2jdEYG5lbVq6J9xxvMKvYNFDm/2cJxDZKtEyT+MlwFcQIqQXRybqIJPXwB3AJf1rIwr6akmnotcukeOvIcNmPeNUu43GdwIiwCw+DThruDsQWGdFLecDqKl/Y97ImJsqp69URVm3cABKLcGqPpNgIG1/eA4EorwCLKHBOyKJTzFtwaJkwcBdUoQitR22GNcJpT0Y088yD1ucpyy9WgP36PVyPnIwPbj4W9eSAytW0LT0uLoWdpuP2xYr2jREyPe45y87AzQj6gFBMeUFzs+kWnJFHCBPXl/8zWg==
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:32::19)
 by AM9P193MB0952.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.33; Wed, 15 Nov
 2023 21:53:12 +0000
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::fdd2:7dbf:e16c:f4a4]) by VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::fdd2:7dbf:e16c:f4a4%4]) with mapi id 15.20.6977.033; Wed, 15 Nov 2023
 21:53:12 +0000
Message-ID: <VI1P193MB075265616010AF82CE201ADD99B1A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
Date:   Thu, 16 Nov 2023 05:53:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] kasan: Record and report more information
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        vincenzo.frascino@arm.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <VI1P193MB0752058FAECD2AC1E5E68D7399B3A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
 <CACT4Y+Ya4yTvAmaELJN5st3GJYo1KKzC9qw9sdD0g3jb48O7tg@mail.gmail.com>
From:   Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CACT4Y+Ya4yTvAmaELJN5st3GJYo1KKzC9qw9sdD0g3jb48O7tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [F4Pg4hzFkk+Yli+oK/r/FKTwR9murSSy]
X-ClientProxiedBy: LO2P265CA0132.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::24) To VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:32::19)
X-Microsoft-Original-Message-ID: <921b07de-569e-4475-b66d-b694d153953c@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0752:EE_|AM9P193MB0952:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d1bb850-aa11-499e-981e-08dbe625437a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LwJQTVneFg//Uk0fUvA08co9Bkvl9RxSlXE5dUSF5KPWnq1SmObhMcZz/tjl0psgKuV/1B6r968z4UvDeHNq7pYv1zpNMdROcJfIdeVtvLyLhMUnqrlB9qgPasCyecSIYVZHSSUFtpUja8oOywtuuYcq2qiHaualPMzh/q/c0Ws3gSq37u/v8IvPOLUgaB9pKbMsOEttvTtGRw4FrFmYEkKbnP5y9A9uTyHgNDEYjZJJUcagiWBzjf2fpJ34imvkSgOHQ1YrQDJde0XAdv8UQf3neVeOwDkiiPk37WdNZaqmfUUFvKcxiOrh6nQmMmpT2aWZ3nlyOCIXejaiDPolVydWVexKwjq1KLic3eOyLkaCKfH1Fmvg0qbkF1GkoB/vvlxUqyX3FlD1806VoV4XXC+5asawwEsJtZTcqKVMJ/eR7gH1uOBe9ZGftx74UGM3i3+90nVZJPrF+D4nO+17me2asEINZmVuRtHH7j1zYEnwcdscGBTA9xWfbtCHjSOs0/CmUVhZ2M+2BaFbCz8esGThEXdSmL7izFeru5a/pGHfGNJD403IqPLUNLJS81org+q5FzusR03V30UntTHrLyszpj76lWoJf/eLk0MJOx4=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDN4UVV1TWdaZlg4LzRmZDNLT0NRdlFwQ1VlTTRON3ozMjRJdlZ5T3F4N2Ry?=
 =?utf-8?B?dDdkeWZVRUNpSVN6UmtvTC94SFQ0cllXWUFDSlRnOHRGMFpNR2FoeHR2Q3dl?=
 =?utf-8?B?a0o2NDJ1b0d2SHE0OUNsa04wazJzZHpSVW14Y01kb2M0YVNyMTdhRUdyL3F4?=
 =?utf-8?B?eGFaNFdTSWsyYnFELzlWaXA1TlptVHNlbmJRUW1jbnZXeFVHOG4vUGVDa3hC?=
 =?utf-8?B?aWV3cTZMVWJlcVI2ekQ0TUUzTS9uRUZyaHd5dHdQK1JVZ3RaWk9KcGdnWU5q?=
 =?utf-8?B?K0trNjRyUnkzM3lYYU9OYVBXMVhZQUFwdUU1Ymdoajd1Q1JCWkFrUWQxZ2Rh?=
 =?utf-8?B?ZVQwdWhiV1QzdDh0ZWQvKzZmYTNKaWZLNVJCeTczMFhxSnREZG9COURETUp1?=
 =?utf-8?B?VjRFQjBIb0t4TlpaekRpQWZHWDQyb1doclY3RGplbXBUeG1iQUZZRTFNemdr?=
 =?utf-8?B?Y3hlQWQ5d1dodDZWZjl3YUMyU0NKQzlYQlhVSEZoMkU1cHdDUzc1K3FyeDZT?=
 =?utf-8?B?bnlOeWk4a2E4VHJmR29ONnQ2aTF4WHVTeEVmbk5tQWUySXp3RVBQTkFnRHBo?=
 =?utf-8?B?dnlyV1cyRXR0QUYvVnZGNllkOE95aWlLWXNSSlo3SW9Pd2JNUW9WYVQ5T0ls?=
 =?utf-8?B?QUY0Q2ttMDZ1ZXNXUlo5Yk9adHFmQ01mOWJCY0szRDNWWkthdWNJU1NoNm83?=
 =?utf-8?B?MWZIRFFUdVhRb3JlRzFLb3VsVWY2Qlg0MFNhZm1KVTRUNG9ESjJ0Y2JSUXJn?=
 =?utf-8?B?RmJsVkdNajhwTEdYSUQzYmV1aGFYN05FalpMME94aGVTbGlMbEV5NzBrMjA2?=
 =?utf-8?B?Rk5hd0N5ZkFwbE1ScFB5MjNjUU9jWW4yc3U1cFBWV01UU2Ftc2x0MHVNYmVi?=
 =?utf-8?B?ZFRnMUpPZmtLL1JUaitYdy9jYW0yOUFOUTIyTXdQOVVyVEhUVnZYU2dxelVE?=
 =?utf-8?B?QzJKb3ZJalNoNmtCTWppdDZFZ2NVZ1hFN2UzdlduQXlKSXFNcHNiOW1WVERF?=
 =?utf-8?B?aHNqQU90bmc0UGtlWG1jZUhxU1E0NGRCSWlJSTlEWjBNT3NaUFdJNGtjYU5S?=
 =?utf-8?B?akQ2MVI4ZHJjYlpyYnpaUHllTDJ5SFhzaFgxcWw5N3V1ckhUdVg2dE1wMVZ6?=
 =?utf-8?B?R0tBUllZbE1mcnppR3hBbUVtL0ZhelEyZDZoS1RqdzQyQUJpMFI1eVhUSVNr?=
 =?utf-8?B?OEc2QjhadzdvMmx1cVlHOGpqWTRYM1p4SU9YYzlhQWdyV2tUVFh6RG14OElH?=
 =?utf-8?B?cmV2dTJwZ050UXg2OHhSYlRKUFIwNnRRNDVwWUt0bFJnOVc0cUxMTG5VQXNx?=
 =?utf-8?B?M0ZNdnF1L0VXMk5ESDcwZWxSYzVMQThUUldqSzdZQm5hMk1hbnM2V21Pdjhn?=
 =?utf-8?B?OVZQdG9hUUg2MXBudUxOd2drUHgvU1F3MC84L2xqaXUwQlBuK3hXcm9RcjU3?=
 =?utf-8?B?UWV1dmdwQWNsNlp4S1gzYW5LNUlPcENPaFJBdm0wVnUzc3FQV1FaYzZWTUJ2?=
 =?utf-8?B?VG8wRDUrVExXQnJoakZReXhoRVFGd00vZWcrOGoxNUx4Qy9kVHRQbDdrV0NI?=
 =?utf-8?B?WFJyRjdQdUNmdzFjRlpNRUZqVU1lQzlHUDdPTy9CWUlSNFJwbjJTb2pzc2l2?=
 =?utf-8?Q?mW1fpzLjU/k+4aKJrwkDHADn+7pRgTrJd4ZX8G1QiPD4=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1bb850-aa11-499e-981e-08dbe625437a
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 21:53:12.6865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB0952
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

On 2023/11/14 15:27, Dmitry Vyukov wrote:
> On Mon, 13 Nov 2023 at 22:17, Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>> Record and report more information to help us find the cause of
>> the bug (for example, bugs caused by subtle race condition).
>>
>> This patch adds recording and showing CPU number and timestamp at
>> allocation and free (controlled by CONFIG_KASAN_EXTRA_INFO), and
>> adds recording and showing timestamp at error occurrence (CPU number
>> is already shown by dump_stack_lvl). The timestamps in the report use
>> the same format and source as printk.
>>
>> In order to record CPU number and timestamp at allocation and free,
>> corresponding members need to be added to the relevant data structures,
>> which may lead to increased memory consumption.
>>
>> In Generic KASAN, members are added to struct kasan_track. Since in
>> most cases, alloc meta is stored in the redzone and free meta is
>> stored in the object or the redzone, memory consumption will not
>> increase much.
>>
>> In SW_TAGS KASAN and HW_TAGS KASAN, members are added to
>> struct kasan_stack_ring_entry. Memory consumption increases as the
>> size of struct kasan_stack_ring_entry increases (this part of the
>> memory is allocated by memblock), but since this is configurable,
>> it is up to the user to choose.
>>
>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
>> ---
>>   lib/Kconfig.kasan      | 11 +++++++++++
>>   mm/kasan/common.c      |  5 +++++
>>   mm/kasan/kasan.h       |  9 +++++++++
>>   mm/kasan/report.c      | 28 ++++++++++++++++++++++------
>>   mm/kasan/report_tags.c | 18 ++++++++++++++++++
>>   mm/kasan/tags.c        | 15 +++++++++++++++
>>   6 files changed, 80 insertions(+), 6 deletions(-)
>>
>> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
>> index fdca89c05745..d9611564b339 100644
>> --- a/lib/Kconfig.kasan
>> +++ b/lib/Kconfig.kasan
>> @@ -207,4 +207,15 @@ config KASAN_MODULE_TEST
>>            A part of the KASAN test suite that is not integrated with KUnit.
>>            Incompatible with Hardware Tag-Based KASAN.
>>
>> +config KASAN_EXTRA_INFO
>> +       bool "Record and report more information"
>> +       depends on KASAN
>> +       help
>> +         Record and report more information to help us find the cause of
>> +         the bug. The trade-off is potentially increased memory consumption
>> +         (to record more information).
>> +
>> +         Currently the CPU number and timestamp are additionally recorded
>> +         at allocation and free.
> 
> Hi Juntong,
> 
> Thanks for working on this.
> 


Thanks for your reply!


> As a KASAN developer I understand what this is doing, but I am trying
> to think from a position of a user that does not know details of KASAN
> implementation. From this position it may be useful to say somewhere
> that information is recorded "per heap allocation". Perhaps something
> like:
> 
> "Currently the CPU number and timestamp are additionally recorded for
> each heap block at allocation and free time".


Yes, I agree, that is a better expression.


> 
> Also it's unclear what the memory consumption increase is. You say
> "potentially|, so may it not increase at all? If it increases, by how
> much? I obviously want more information, if I can afford it, but I
> can't understand if I can or not based on this description. I would
> assume that this may be a problem only for small/embedded devices.
> Can we provide some ballpark estimation of the memory consumption
> increase? And somehow say that's probably not an issue for larger
> machines?
> 


How about this expression?

Currently, in order to record CPU number and timestamp, the data
structure to record allocation and free information will increase
by 12 bytes.

In Generic KASAN, this affects all allocations less than 32 bytes.
In SW_TAGS KASAN and HW_TAGS KASAN, depending on the stack_ring_size
boot parameter increases the memory consumption by
12 * stack_ring_size bytes.


> 
> 
> 
>>   endif # KASAN
>> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
>> index 256930da578a..7a81566d9d66 100644
>> --- a/mm/kasan/common.c
>> +++ b/mm/kasan/common.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/module.h>
>>   #include <linux/printk.h>
>>   #include <linux/sched.h>
>> +#include <linux/sched/clock.h>
>>   #include <linux/sched/task_stack.h>
>>   #include <linux/slab.h>
>>   #include <linux/stacktrace.h>
>> @@ -50,6 +51,10 @@ void kasan_set_track(struct kasan_track *track, gfp_t flags)
>>   {
>>          track->pid = current->pid;
>>          track->stack = kasan_save_stack(flags, true);
>> +#ifdef CONFIG_KASAN_EXTRA_INFO
>> +       track->cpu = raw_smp_processor_id();
>> +       track->ts_nsec = local_clock();
> 
> What does "local_" mean? Is this clock value comparable across CPUs?
> 


No, local_clock is the local CPU clock and cannot be used for comparison
across CPUs, I made a mistake here.

I delved into the clock subsystem of the Linux kernel today and I found
that we have two choices.

- sched_clock(): based on jiffies, high performance, but on some
hardware, it will drift between CPUs.

- ktime_get_boot_fast_ns(): based on clocksource, highly accurate,
can be compared between CPUs, but performance is worse (seqlock).

I tested 100000 calls respectively on my laptop, the average of
sched_clock() is 17ns and the average of ktime_get_boot_fast_ns()
is 25ns.

ktime_get_boot_fast_ns() takes about 1.5 times as long as sched_clock().

With Generic KASAN enabled, the average of one memory allocation is
3512ns on my laptop.

Personally, I prefer ktime_get_boot_fast_ns() because it is more
accurate and the extra time is insignificant for the time required for
one memory allocation with Generic KASAN enabled.

But maybe using ktime_get_boot_fast_ns() would have a more serious
impact on small/embedded devices.

Which do you think is the better choice?


> 
>> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>>   }
>>
>>   #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
>> index 8b06bab5c406..b3899a255aca 100644
>> --- a/mm/kasan/kasan.h
>> +++ b/mm/kasan/kasan.h
>> @@ -187,6 +187,10 @@ static inline bool kasan_requires_meta(void)
>>   struct kasan_track {
>>          u32 pid;
>>          depot_stack_handle_t stack;
>> +#ifdef CONFIG_KASAN_EXTRA_INFO
>> +       u32 cpu;
>> +       u64 ts_nsec;
> 
> This increases the size of meta from 8 to 24 bytes.
> Can we somehow store the timestamp as 32 bits? Maybe compress the CPU
> number (it shouldn't be larger than 20 bits?)?
> I see below we report on microseconds, so we don't low bits of the
> timestamp as well.
> 


Maybe we can use bit field.

struct kasan_track {
	u32 pid;
	depot_stack_handle_t stack;
#ifdef CONFIG_KASAN_EXTRA_INFO
	u64 cpu:20;
	u64 ts_sec:22;
	u64 ts_usec:22;
#endif /* CONFIG_KASAN_EXTRA_INFO */
};

For example, 20-bit cpu, 22-bit ts_sec, 22-bit ts_usec, 64 bits
(8 bytes), and the data structure is 16 bytes in total.

If the data structure becomes 16 bytes, it will not affect objects
larger than 16 bytes.

But the bit field can only be used in struct kasan_track (Generic),
and cannot be used in struct kasan_stack_ring_entry (SW_TAGS KASAN
and HW_TAGS KASAN).

Because we need to use READ_ONCE and WRITE_ONCE to read and write
struct kasan_stack_ring_entry, but READ_ONCE and WRITE_ONCE cannot
read or write bit field.


> 
> I see there is a deficiency in kasan_cache_create():
> https://elixir.bootlin.com/linux/latest/source/mm/kasan/generic.c#L412
> 
> If free_meta does not fit into the object, we add it after the object.
> But we could overlap it with the object.
> For example if the object size is 16 bytes and free_meta size is 24
> bytes, we could increase object size to 24, while currently we
> increase it to 16+24 = 40.
> We need to place it after the object only if we have these other cases
> "(cache->flags & SLAB_TYPESAFE_BY_RCU) || cache->ctor".
> 
> Currently it affects only kmalloc-8 slab.
> But with this change it will affect at least kmalloc-16 slab as well.
> 


I completely agree that we can use both object space and redzone
space to store free meta, thereby further reducing the extra memory
consumption caused by KASAN.

Of course, in this case we need to readjust the offset of the
alloc meta.

If you agree I can make this change in a separate patch.


> 
> 
> 
>> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>>   };
>>
>>   enum kasan_report_type {
>> @@ -202,6 +206,7 @@ struct kasan_report_info {
>>          size_t access_size;
>>          bool is_write;
>>          unsigned long ip;
>> +       u64 ts_nsec;
>>
>>          /* Filled in by the common reporting code. */
>>          const void *first_bad_addr;
>> @@ -278,6 +283,10 @@ struct kasan_stack_ring_entry {
>>          u32 pid;
>>          depot_stack_handle_t stack;
>>          bool is_free;
>> +#ifdef CONFIG_KASAN_EXTRA_INFO
>> +       u32 cpu;
>> +       u64 ts_nsec;
>> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>>   };
>>
>>   struct kasan_stack_ring {
>> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
>> index e77facb62900..b6feaf807c08 100644
>> --- a/mm/kasan/report.c
>> +++ b/mm/kasan/report.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/types.h>
>>   #include <linux/kasan.h>
>>   #include <linux/module.h>
>> +#include <linux/sched/clock.h>
>>   #include <linux/sched/task_stack.h>
>>   #include <linux/uaccess.h>
>>   #include <trace/events/error_report.h>
>> @@ -242,27 +243,40 @@ static void end_report(unsigned long *flags, const void *addr, bool is_write)
>>
>>   static void print_error_description(struct kasan_report_info *info)
>>   {
>> +       unsigned long rem_usec = do_div(info->ts_nsec, NSEC_PER_SEC) / 1000;
>> +
>>          pr_err("BUG: KASAN: %s in %pS\n", info->bug_type, (void *)info->ip);
>>
>>          if (info->type != KASAN_REPORT_ACCESS) {
>> -               pr_err("Free of addr %px by task %s/%d\n",
>> -                       info->access_addr, current->comm, task_pid_nr(current));
>> +               pr_err("Free of addr %px by task %s/%d at %lu.%06lus\n",
>> +                       info->access_addr, current->comm, task_pid_nr(current),
>> +                       (unsigned long)info->ts_nsec, rem_usec);
>>                  return;
>>          }
>>
>>          if (info->access_size)
>> -               pr_err("%s of size %zu at addr %px by task %s/%d\n",
>> +               pr_err("%s of size %zu at addr %px by task %s/%d at %lu.%06lus\n",
>>                          info->is_write ? "Write" : "Read", info->access_size,
>> -                       info->access_addr, current->comm, task_pid_nr(current));
>> +                       info->access_addr, current->comm, task_pid_nr(current),
>> +                       (unsigned long)info->ts_nsec, rem_usec);
>>          else
>> -               pr_err("%s at addr %px by task %s/%d\n",
>> +               pr_err("%s at addr %px by task %s/%d at %lu.%06lus\n",
>>                          info->is_write ? "Write" : "Read",
>> -                       info->access_addr, current->comm, task_pid_nr(current));
>> +                       info->access_addr, current->comm, task_pid_nr(current),
>> +                       (unsigned long)info->ts_nsec, rem_usec);
>>   }
>>
>>   static void print_track(struct kasan_track *track, const char *prefix)
>>   {
>> +#ifdef CONFIG_KASAN_EXTRA_INFO
>> +       unsigned long rem_usec = do_div(track->ts_nsec, NSEC_PER_SEC) / 1000;
>> +
>> +       pr_err("%s by task %u on cpu %d at %lu.%06lus:\n",
>> +                       prefix, track->pid, track->cpu,
>> +                       (unsigned long)track->ts_nsec, rem_usec);
>> +#else
>>          pr_err("%s by task %u:\n", prefix, track->pid);
>> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>>          if (track->stack)
>>                  stack_depot_print(track->stack);
>>          else
>> @@ -544,6 +558,7 @@ void kasan_report_invalid_free(void *ptr, unsigned long ip, enum kasan_report_ty
>>          info.access_size = 0;
>>          info.is_write = false;
>>          info.ip = ip;
>> +       info.ts_nsec = local_clock();
>>
>>          complete_report_info(&info);
>>
>> @@ -582,6 +597,7 @@ bool kasan_report(const void *addr, size_t size, bool is_write,
>>          info.access_size = size;
>>          info.is_write = is_write;
>>          info.ip = ip;
>> +       info.ts_nsec = local_clock();
>>
>>          complete_report_info(&info);
>>
>> diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
>> index 8b8bfdb3cfdb..4d62f1b3e11d 100644
>> --- a/mm/kasan/report_tags.c
>> +++ b/mm/kasan/report_tags.c
>> @@ -26,6 +26,18 @@ static const char *get_common_bug_type(struct kasan_report_info *info)
>>          return "invalid-access";
>>   }
>>
>> +#ifdef CONFIG_KASAN_EXTRA_INFO
>> +static void kasan_complete_extra_report_info(struct kasan_track *track,
>> +                                        struct kasan_stack_ring_entry *entry)
>> +{
>> +       u32 cpu = READ_ONCE(entry->cpu);
>> +       u64 ts_nsec = READ_ONCE(entry->ts_nsec);
>> +
>> +       track->cpu = cpu;
>> +       track->ts_nsec = ts_nsec;
>> +}
>> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>> +
>>   void kasan_complete_mode_report_info(struct kasan_report_info *info)
>>   {
>>          unsigned long flags;
>> @@ -82,6 +94,9 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
>>
>>                          info->free_track.pid = pid;
>>                          info->free_track.stack = stack;
>> +#ifdef CONFIG_KASAN_EXTRA_INFO
>> +                       kasan_complete_extra_report_info(&info->free_track, entry);
>> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>>                          free_found = true;
>>
>>                          /*
>> @@ -97,6 +112,9 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
>>
>>                          info->alloc_track.pid = pid;
>>                          info->alloc_track.stack = stack;
>> +#ifdef CONFIG_KASAN_EXTRA_INFO
>> +                       kasan_complete_extra_report_info(&info->alloc_track, entry);
>> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>>                          alloc_found = true;
>>
>>                          /*
>> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
>> index 7dcfe341d48e..474ce7e8be8b 100644
>> --- a/mm/kasan/tags.c
>> +++ b/mm/kasan/tags.c
>> @@ -13,6 +13,7 @@
>>   #include <linux/memblock.h>
>>   #include <linux/memory.h>
>>   #include <linux/mm.h>
>> +#include <linux/sched/clock.h>
>>   #include <linux/static_key.h>
>>   #include <linux/string.h>
>>   #include <linux/types.h>
>> @@ -92,6 +93,17 @@ void __init kasan_init_tags(void)
>>          }
>>   }
>>
>> +#ifdef CONFIG_KASAN_EXTRA_INFO
>> +static void save_extra_info(struct kasan_stack_ring_entry *entry)
>> +{
>> +       u32 cpu = raw_smp_processor_id();
>> +       u64 ts_nsec = local_clock();
>> +
>> +       WRITE_ONCE(entry->cpu, cpu);
>> +       WRITE_ONCE(entry->ts_nsec, ts_nsec);
>> +}
>> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>> +
>>   static void save_stack_info(struct kmem_cache *cache, void *object,
>>                          gfp_t gfp_flags, bool is_free)
>>   {
>> @@ -124,6 +136,9 @@ static void save_stack_info(struct kmem_cache *cache, void *object,
>>          WRITE_ONCE(entry->pid, current->pid);
>>          WRITE_ONCE(entry->stack, stack);
>>          WRITE_ONCE(entry->is_free, is_free);
>> +#ifdef CONFIG_KASAN_EXTRA_INFO
>> +       save_extra_info(entry);
>> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>>
>>          /*
>>           * Paired with smp_load_acquire() in kasan_complete_mode_report_info().
>> --
>> 2.39.2
>>

