Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AC57F18D0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjKTQn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjKTQn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:43:26 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02olkn2011.outbound.protection.outlook.com [40.92.50.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2317D93
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 08:43:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5tk3/EPKlbDDotQhHTjA0BcVdP94vtDMSmKrOqBjPZyxMMV7SUAFdw7gx82u/fD/FElkRSIHP9GyLxqJpp55mP9YqKLdMnUCPqtcXITut+sX/96Xh3w0T1ZZc4SpJDRXUDmx5bdwZBNhHpJmQo4aN070Hk8ZEK/i6170XDzLYgxL0mGzHrzT62h9+Eb/f/Hal1o6ikSOB8tDFotyOoKpluhoq6rzCazllcq+6/nCDdQM00hd8EYSF8hVxk/K10o1xdoFoIrAyVRIhy5zZ4rJn6ZVHsH3oa5Lcl5JysD3mU3QH/1GK9wiTSRKurD0lnTKoHB6jkA/h6J59/LdbWBBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUUd7Qaqqlx26g+hvUdCUjSnTlgSfTcAHhwOoTTu4EY=;
 b=R4fu5EJEpHVwHCNx9Amr3FJDG1VIYXeY1CNgfRVeU+v9rngxWkzL71v/2OIhVEHwNF05ZOGtDHWllh5A8UmfUgMLp98znCskCZ+mGnWoAPdRCXC5MookWNgJumvkbbG5qpV3VmU+W49ZMaVaZuSNs6AY8Q4awdIyddWUUwjsbt9mUCe2HtejtiWbS8bFrSdipZ4QYihtFdge1MHEi5AttfmZGKBpCjKbStNteL5lQmBeJsLxeYfygIWT/ywNHRoZ8kPs4fRdxWylUJXVIjXZJxzWFz22rvE6jSBA6t9kPUi99NsEOtMCm2aDylhyHyjsrObS2eoyZnqh/59qI6SYNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUUd7Qaqqlx26g+hvUdCUjSnTlgSfTcAHhwOoTTu4EY=;
 b=uSyRA/5ZAZA8oZiHQHm3Oc29l9YsIo4RM6PTA5rUTiddPJBRkMu8XAYHpr02PHTcNpDBfIlzs0MnMJOqg/tcxqemig3nTjROOkOR0Zs5Xq0RmiHeMIvDckXqULQvK6RPz3ch16w4YM3HpO4+M3hI78Zy93wo72d6yHl6usx9mmBxTjOsb5kYbdLAYKFM15oYiOH5SHOcXTeInWEF/xa3ELYKOSLXFsovTFIoPTfLJqFVyY7+esP2lYwM7K41p8tZCSghODn+s5t/1H+GWbGboaYtt8xCbn0aaKKL0drmnhSqLCk6YCFslixvZqlA2wRakHBv2yK1Qv4crEyzKZhSmQ==
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:32::19)
 by GV1P193MB2342.EURP193.PROD.OUTLOOK.COM (2603:10a6:150:26::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 16:43:17 +0000
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::fdd2:7dbf:e16c:f4a4]) by VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::fdd2:7dbf:e16c:f4a4%4]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 16:43:16 +0000
Message-ID: <VI1P193MB075297D24A59F4D3C4C5705099B4A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
Date:   Tue, 21 Nov 2023 00:43:15 +0800
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
 <VI1P193MB075265616010AF82CE201ADD99B1A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
 <CACT4Y+ZE8DO1u6NHATXC9tfcVS4diM0LO4r3cQ15HaGHVoFAbQ@mail.gmail.com>
From:   Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CACT4Y+ZE8DO1u6NHATXC9tfcVS4diM0LO4r3cQ15HaGHVoFAbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [grPbA94z/9Se25uc77kipyZ9G37VvmWR]
X-ClientProxiedBy: LO4P123CA0552.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::14) To VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:32::19)
X-Microsoft-Original-Message-ID: <6e732cdb-10ac-4e5d-8a4a-1dea8acf9662@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0752:EE_|GV1P193MB2342:EE_
X-MS-Office365-Filtering-Correlation-Id: 1533dee8-00cf-4d12-e31d-08dbe9e7cb5a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x36eBV6H83kkdngm6j8D074ToCkITpQn3LmvJehI/abytwZr4+KLbOp+HA5CPR0Bt6V0Gq4m18nJHtSQmbtKINjGCEdqAZQHj6ZBkKOzAjPi1Xa/8ZZSWIkpxKw0LgoKCyFTVxTr9XPcSpd7WSv9nLo54DGofMN5xm+CwqvOVPHKxGyObPO8dndcGIK8sptVMaryoEkw5lM3PitFRKb1+Vza5JoAyrvBFPyktyMFcFszVi3UEflq63cVWj8X8Oy7oBJ5yveAhVr2039HYKoJpwm88TSLsyDMp2xXMTmtzOwy2ycS2tXCdyDxmBUp+rTkvmefbp9p9MiGHJY8rRmwir2MKtd3PnYKiB6xXa6HWg1Wn9AhE8ZVb1WnKjOPh0WPQTax1wa6CFUpQqa5Ac1dkgNaqUwg4BbVG1BJBIP4zaoUf+5NgoALxouFIuOfd+w05tv4MQYyLSHPoLh3x+b4iiQZj0Rpbbtj9lp4jnblify0OkEYMvw+sHaTSrV8wbWoZ23h5ej2wfE65E/L2jvnYMiNby86sf8p1g1bKx62M9epnkl0yrIMQn0ueJ94mJDCS9ThPsw+RsiYOTOlDO06zgdH+uHnR2r3o22tLXHc84kd2BmgHy93t8nZjRYJmVHQ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2NjZWp5U0NIOWZLYmgvdWkvRkxFcXBrOE0yTnBvcThBbTVQaDVuWUNjRnB2?=
 =?utf-8?B?V3ZSVWFYVnBzVEhRUEZQM3RzaG8xUzdNMFgyenltRDIyYndOV3VqQUxobmNK?=
 =?utf-8?B?ZGUramZuditxSVJFWjkxVUhNaGpxT25hRmQrZzJST29FQzFBYU5oOXkwMkNB?=
 =?utf-8?B?N3Q3NW9NNjkreUNFWWRmUEtqQ3B0OFhqc1NPbkE4M0JtOTZCVnU2d2Q2TXNV?=
 =?utf-8?B?S0krcUlabFhtNktBUkZTUUlpS0ZhTmZrTVRsSjcrSXhreis3RlhuTUVrRGQ0?=
 =?utf-8?B?M2pxV0VIMW5ZLzFGM2xJcXA0TkF6R0dnRWNzdjVjcVhVSlc0b09hcGxNRTZp?=
 =?utf-8?B?b3lNYm9qeWE1VGVrUkVscGIybTkvamZwUzBOdGNVRURJWmlMRXJJTGcvSlBy?=
 =?utf-8?B?cXhwR0ZQNCtlbmQ5Tk9JNEx6YzVJdVNPeDZHT2FoWU83aElwMjRmQlN2QlBy?=
 =?utf-8?B?WStSSXh6cG9URXl4SUIwUHhjUVFpMk1PZ0RrQ21uMUk4S1RTaXNFTzhaNURj?=
 =?utf-8?B?dlNZVGJmNlNXQmdNTW9UV2FEZU1ZREFoaVhGOUlWRTcxTjNmcGlQZ3dUeFhp?=
 =?utf-8?B?Z25Dc3AxdW44RHFqeU1aRkNhU05zdGo0L0E3TzBVek1QMC9uUlZQOEo5bENB?=
 =?utf-8?B?US9KcnVkaGI0VlFnTXFsQjVRNmlWVUZvVTRxbVNoRWp5QkUyVHNTR3ZzUG5W?=
 =?utf-8?B?Yi9kMC9aZG9nU3ArQXN1bURVa0ZYa0ZTK0JJV1daMkVGbHdwaml1a244WTNR?=
 =?utf-8?B?Uy9raUF4dk9RTkN0QU8zRU8zQnFxVlVwUHg0anZsVzZrZFhkUUZTMG95OWRp?=
 =?utf-8?B?dHhMRTdSTFlPdk5JaG5nK1dOUVVFVldwR3BMRWxIeGgyamh0aDd1MEo3UVJi?=
 =?utf-8?B?anBIMEd3aUNUQldxRTBIdHhPRnhZd3Q1djg4bDMyVHh2Y3UxOXpYUlZvamtz?=
 =?utf-8?B?L1BsM0kzR1lqTm5jTmt4ZjkrZEkyRTVTT21xY0wrUjlVM1c1RjgzSXhCQS9B?=
 =?utf-8?B?djllT0RkeUpxcmRpUDRDNExYSWlZTE9RU3EvQmRWSC9pS2FUZXArVFBoTkpu?=
 =?utf-8?B?TFdNNFZ3YkZyNHlvREN0OEJuYVNiQXZ3ZFl2bTJnYzVURXBVQk1DTEZCZ0JJ?=
 =?utf-8?B?RmNDSjcxblp1akI4NDhad2EwaE9aYXIwSjlrSEdUc0ZneU1ac0gxSWs3Ynpx?=
 =?utf-8?B?SllJYmg1eVZjY1J5SXNlTjlhN25sMEgwZ3BQWjA2d3dTZ2k5ejBsRytsN1VM?=
 =?utf-8?B?M1pMMUNWNkgwWnJ5d2FwcnJjbGlUSHRlYm9McEdqamgrUGRGRU14TlRoQjdz?=
 =?utf-8?B?c1U5a1ZYRVFPQ3NYYUpjcklOUjFvcTBDSGFTMWdlenJnWm90YW43QVJYTGNz?=
 =?utf-8?B?WnNJLyt3WktIK0Zzend0Z3RBYlJvenoreHJLVnI3MEFHVmRwNlRwTVhXa1JD?=
 =?utf-8?B?WnJmZlZON0lFYXhBNFArNGNya1VFOXBSNVl3dFBYM0c3SGtlRmJiR1JZVjF5?=
 =?utf-8?B?ZFhWK2Q0YThqMHNneDA1TGEybnpEZmlFYVhibXl5aTF0WTIzRUd3R1lzdUhW?=
 =?utf-8?B?WnF0TE5aamVVdnB2ZWp3K2YyR0dJc1U1cy9KVlNleWhVS3BXS2JDSjQ0cjhZ?=
 =?utf-8?Q?cDjRh9e8Pn/l6OTcjqkCZ80tTq3RjjZpkUsL3KW3sOGo=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1533dee8-00cf-4d12-e31d-08dbe9e7cb5a
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 16:43:16.8169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P193MB2342
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/20 19:06, Dmitry Vyukov wrote:
> On Wed, 15 Nov 2023 at 22:53, Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>> On 2023/11/14 15:27, Dmitry Vyukov wrote:
>>> On Mon, 13 Nov 2023 at 22:17, Juntong Deng <juntong.deng@outlook.com> wrote:
>>>>
>>>> Record and report more information to help us find the cause of
>>>> the bug (for example, bugs caused by subtle race condition).
>>>>
>>>> This patch adds recording and showing CPU number and timestamp at
>>>> allocation and free (controlled by CONFIG_KASAN_EXTRA_INFO), and
>>>> adds recording and showing timestamp at error occurrence (CPU number
>>>> is already shown by dump_stack_lvl). The timestamps in the report use
>>>> the same format and source as printk.
>>>>
>>>> In order to record CPU number and timestamp at allocation and free,
>>>> corresponding members need to be added to the relevant data structures,
>>>> which may lead to increased memory consumption.
>>>>
>>>> In Generic KASAN, members are added to struct kasan_track. Since in
>>>> most cases, alloc meta is stored in the redzone and free meta is
>>>> stored in the object or the redzone, memory consumption will not
>>>> increase much.
>>>>
>>>> In SW_TAGS KASAN and HW_TAGS KASAN, members are added to
>>>> struct kasan_stack_ring_entry. Memory consumption increases as the
>>>> size of struct kasan_stack_ring_entry increases (this part of the
>>>> memory is allocated by memblock), but since this is configurable,
>>>> it is up to the user to choose.
>>>>
>>>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
>>>> ---
>>>>    lib/Kconfig.kasan      | 11 +++++++++++
>>>>    mm/kasan/common.c      |  5 +++++
>>>>    mm/kasan/kasan.h       |  9 +++++++++
>>>>    mm/kasan/report.c      | 28 ++++++++++++++++++++++------
>>>>    mm/kasan/report_tags.c | 18 ++++++++++++++++++
>>>>    mm/kasan/tags.c        | 15 +++++++++++++++
>>>>    6 files changed, 80 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
>>>> index fdca89c05745..d9611564b339 100644
>>>> --- a/lib/Kconfig.kasan
>>>> +++ b/lib/Kconfig.kasan
>>>> @@ -207,4 +207,15 @@ config KASAN_MODULE_TEST
>>>>             A part of the KASAN test suite that is not integrated with KUnit.
>>>>             Incompatible with Hardware Tag-Based KASAN.
>>>>
>>>> +config KASAN_EXTRA_INFO
>>>> +       bool "Record and report more information"
>>>> +       depends on KASAN
>>>> +       help
>>>> +         Record and report more information to help us find the cause of
>>>> +         the bug. The trade-off is potentially increased memory consumption
>>>> +         (to record more information).
>>>> +
>>>> +         Currently the CPU number and timestamp are additionally recorded
>>>> +         at allocation and free.
>>>
>>> Hi Juntong,
>>>
>>> Thanks for working on this.
>>>
>>
>>
>> Thanks for your reply!
>>
>>
>>> As a KASAN developer I understand what this is doing, but I am trying
>>> to think from a position of a user that does not know details of KASAN
>>> implementation. From this position it may be useful to say somewhere
>>> that information is recorded "per heap allocation". Perhaps something
>>> like:
>>>
>>> "Currently the CPU number and timestamp are additionally recorded for
>>> each heap block at allocation and free time".
>>
>>
>> Yes, I agree, that is a better expression.
>>
>>
>>>
>>> Also it's unclear what the memory consumption increase is. You say
>>> "potentially|, so may it not increase at all? If it increases, by how
>>> much? I obviously want more information, if I can afford it, but I
>>> can't understand if I can or not based on this description. I would
>>> assume that this may be a problem only for small/embedded devices.
>>> Can we provide some ballpark estimation of the memory consumption
>>> increase? And somehow say that's probably not an issue for larger
>>> machines?
>>>
>>
>>
>> How about this expression?
>>
>> Currently, in order to record CPU number and timestamp, the data
>> structure to record allocation and free information will increase
>> by 12 bytes.
>>
>> In Generic KASAN, this affects all allocations less than 32 bytes.
>> In SW_TAGS KASAN and HW_TAGS KASAN, depending on the stack_ring_size
>> boot parameter increases the memory consumption by
>> 12 * stack_ring_size bytes.
> 
> Let's go with this version.
> 
> 
>>>>    endif # KASAN
>>>> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
>>>> index 256930da578a..7a81566d9d66 100644
>>>> --- a/mm/kasan/common.c
>>>> +++ b/mm/kasan/common.c
>>>> @@ -20,6 +20,7 @@
>>>>    #include <linux/module.h>
>>>>    #include <linux/printk.h>
>>>>    #include <linux/sched.h>
>>>> +#include <linux/sched/clock.h>
>>>>    #include <linux/sched/task_stack.h>
>>>>    #include <linux/slab.h>
>>>>    #include <linux/stacktrace.h>
>>>> @@ -50,6 +51,10 @@ void kasan_set_track(struct kasan_track *track, gfp_t flags)
>>>>    {
>>>>           track->pid = current->pid;
>>>>           track->stack = kasan_save_stack(flags, true);
>>>> +#ifdef CONFIG_KASAN_EXTRA_INFO
>>>> +       track->cpu = raw_smp_processor_id();
>>>> +       track->ts_nsec = local_clock();
>>>
>>> What does "local_" mean? Is this clock value comparable across CPUs?
>>>
>>
>>
>> No, local_clock is the local CPU clock and cannot be used for comparison
>> across CPUs, I made a mistake here.
>>
>> I delved into the clock subsystem of the Linux kernel today and I found
>> that we have two choices.
>>
>> - sched_clock(): based on jiffies, high performance, but on some
>> hardware, it will drift between CPUs.
>>
>> - ktime_get_boot_fast_ns(): based on clocksource, highly accurate,
>> can be compared between CPUs, but performance is worse (seqlock).
>>
>> I tested 100000 calls respectively on my laptop, the average of
>> sched_clock() is 17ns and the average of ktime_get_boot_fast_ns()
>> is 25ns.
>>
>> ktime_get_boot_fast_ns() takes about 1.5 times as long as sched_clock().
>>
>> With Generic KASAN enabled, the average of one memory allocation is
>> 3512ns on my laptop.
>>
>> Personally, I prefer ktime_get_boot_fast_ns() because it is more
>> accurate and the extra time is insignificant for the time required for
>> one memory allocation with Generic KASAN enabled.
>>
>> But maybe using ktime_get_boot_fast_ns() would have a more serious
>> impact on small/embedded devices.
>>
>> Which do you think is the better choice?
> 
> I don't have a strong preference.
> 
> Re drift of sched_clock(), do you mean unsynchronized RDTSC on
> different cores? I had the impression that RDTSC is synchronized
> across cores on all recent CPUs/systems.
> 


https://elixir.bootlin.com/linux/latest/source/kernel/trace/trace_clock.c#L27
https://docs.kernel.org/timers/timekeeping.html#sched-clock
https://lore.kernel.org/lkml/20100612023457.14850.50439.stgit@austin.mtv.corp.google.com/
https://lkml.org/lkml/2020/3/16/902

All of the above seems to indicate that sched_clock() is not reliable
for comparison across CPUs.

Comparing time across CPUs, ktime is probably the only reliable option.


> 
>>>> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>>>>    }
>>>>
>>>>    #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>>>> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
>>>> index 8b06bab5c406..b3899a255aca 100644
>>>> --- a/mm/kasan/kasan.h
>>>> +++ b/mm/kasan/kasan.h
>>>> @@ -187,6 +187,10 @@ static inline bool kasan_requires_meta(void)
>>>>    struct kasan_track {
>>>>           u32 pid;
>>>>           depot_stack_handle_t stack;
>>>> +#ifdef CONFIG_KASAN_EXTRA_INFO
>>>> +       u32 cpu;
>>>> +       u64 ts_nsec;
>>>
>>> This increases the size of meta from 8 to 24 bytes.
>>> Can we somehow store the timestamp as 32 bits? Maybe compress the CPU
>>> number (it shouldn't be larger than 20 bits?)?
>>> I see below we report on microseconds, so we don't low bits of the
>>> timestamp as well.
>>>
>>
>>
>> Maybe we can use bit field.
>>
>> struct kasan_track {
>>          u32 pid;
>>          depot_stack_handle_t stack;
>> #ifdef CONFIG_KASAN_EXTRA_INFO
>>          u64 cpu:20;
>>          u64 ts_sec:22;
>>          u64 ts_usec:22;
>> #endif /* CONFIG_KASAN_EXTRA_INFO */
>> };
>>
>> For example, 20-bit cpu, 22-bit ts_sec, 22-bit ts_usec, 64 bits
>> (8 bytes), and the data structure is 16 bytes in total.
> 
> This looks better.
> Can't we have a single field for time instead of ts_sec/usec?
> Both sched_clock() and ktime_get_boot_fast_ns() return just u64.
> 
>> If the data structure becomes 16 bytes, it will not affect objects
>> larger than 16 bytes.
>>
>> But the bit field can only be used in struct kasan_track (Generic),
>> and cannot be used in struct kasan_stack_ring_entry (SW_TAGS KASAN
>> and HW_TAGS KASAN).
>>
>> Because we need to use READ_ONCE and WRITE_ONCE to read and write
>> struct kasan_stack_ring_entry, but READ_ONCE and WRITE_ONCE cannot
>> read or write bit field.
> 
> If that's necessary, we could store both values as a single u64 and
> the manually pack/unpack.
> 


I will try to store the CPU and timestamp in a u64, unpack it
when reporting, and send PATCH V2.


> 
>>> I see there is a deficiency in kasan_cache_create():
>>> https://elixir.bootlin.com/linux/latest/source/mm/kasan/generic.c#L412
>>>
>>> If free_meta does not fit into the object, we add it after the object.
>>> But we could overlap it with the object.
>>> For example if the object size is 16 bytes and free_meta size is 24
>>> bytes, we could increase object size to 24, while currently we
>>> increase it to 16+24 = 40.
>>> We need to place it after the object only if we have these other cases
>>> "(cache->flags & SLAB_TYPESAFE_BY_RCU) || cache->ctor".
>>>
>>> Currently it affects only kmalloc-8 slab.
>>> But with this change it will affect at least kmalloc-16 slab as well.
>>>
>>
>>
>> I completely agree that we can use both object space and redzone
>> space to store free meta, thereby further reducing the extra memory
>> consumption caused by KASAN.
>>
>> Of course, in this case we need to readjust the offset of the
>> alloc meta.
>>
>> If you agree I can make this change in a separate patch.
> 
> This would be good. Thanks.
> 


I have sent a patch for this.

[PATCH] kasan: Improve free meta storage in Generic KASAN


>>>> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>>>>    };
>>>>
>>>>    enum kasan_report_type {
>>>> @@ -202,6 +206,7 @@ struct kasan_report_info {
>>>>           size_t access_size;
>>>>           bool is_write;
>>>>           unsigned long ip;
>>>> +       u64 ts_nsec;
>>>>
>>>>           /* Filled in by the common reporting code. */
>>>>           const void *first_bad_addr;
>>>> @@ -278,6 +283,10 @@ struct kasan_stack_ring_entry {
>>>>           u32 pid;
>>>>           depot_stack_handle_t stack;
>>>>           bool is_free;
>>>> +#ifdef CONFIG_KASAN_EXTRA_INFO
>>>> +       u32 cpu;
>>>> +       u64 ts_nsec;
>>>> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>>>>    };
>>>>
>>>>    struct kasan_stack_ring {
>>>> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
>>>> index e77facb62900..b6feaf807c08 100644
>>>> --- a/mm/kasan/report.c
>>>> +++ b/mm/kasan/report.c
>>>> @@ -25,6 +25,7 @@
>>>>    #include <linux/types.h>
>>>>    #include <linux/kasan.h>
>>>>    #include <linux/module.h>
>>>> +#include <linux/sched/clock.h>
>>>>    #include <linux/sched/task_stack.h>
>>>>    #include <linux/uaccess.h>
>>>>    #include <trace/events/error_report.h>
>>>> @@ -242,27 +243,40 @@ static void end_report(unsigned long *flags, const void *addr, bool is_write)
>>>>
>>>>    static void print_error_description(struct kasan_report_info *info)
>>>>    {
>>>> +       unsigned long rem_usec = do_div(info->ts_nsec, NSEC_PER_SEC) / 1000;
>>>> +
>>>>           pr_err("BUG: KASAN: %s in %pS\n", info->bug_type, (void *)info->ip);
>>>>
>>>>           if (info->type != KASAN_REPORT_ACCESS) {
>>>> -               pr_err("Free of addr %px by task %s/%d\n",
>>>> -                       info->access_addr, current->comm, task_pid_nr(current));
>>>> +               pr_err("Free of addr %px by task %s/%d at %lu.%06lus\n",
>>>> +                       info->access_addr, current->comm, task_pid_nr(current),
>>>> +                       (unsigned long)info->ts_nsec, rem_usec);
>>>>                   return;
>>>>           }
>>>>
>>>>           if (info->access_size)
>>>> -               pr_err("%s of size %zu at addr %px by task %s/%d\n",
>>>> +               pr_err("%s of size %zu at addr %px by task %s/%d at %lu.%06lus\n",
>>>>                           info->is_write ? "Write" : "Read", info->access_size,
>>>> -                       info->access_addr, current->comm, task_pid_nr(current));
>>>> +                       info->access_addr, current->comm, task_pid_nr(current),
>>>> +                       (unsigned long)info->ts_nsec, rem_usec);
>>>>           else
>>>> -               pr_err("%s at addr %px by task %s/%d\n",
>>>> +               pr_err("%s at addr %px by task %s/%d at %lu.%06lus\n",
>>>>                           info->is_write ? "Write" : "Read",
>>>> -                       info->access_addr, current->comm, task_pid_nr(current));
>>>> +                       info->access_addr, current->comm, task_pid_nr(current),
>>>> +                       (unsigned long)info->ts_nsec, rem_usec);
>>>>    }
>>>>
>>>>    static void print_track(struct kasan_track *track, const char *prefix)
>>>>    {
>>>> +#ifdef CONFIG_KASAN_EXTRA_INFO
>>>> +       unsigned long rem_usec = do_div(track->ts_nsec, NSEC_PER_SEC) / 1000;
>>>> +
>>>> +       pr_err("%s by task %u on cpu %d at %lu.%06lus:\n",
>>>> +                       prefix, track->pid, track->cpu,
>>>> +                       (unsigned long)track->ts_nsec, rem_usec);
>>>> +#else
>>>>           pr_err("%s by task %u:\n", prefix, track->pid);
>>>> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>>>>           if (track->stack)
>>>>                   stack_depot_print(track->stack);
>>>>           else
>>>> @@ -544,6 +558,7 @@ void kasan_report_invalid_free(void *ptr, unsigned long ip, enum kasan_report_ty
>>>>           info.access_size = 0;
>>>>           info.is_write = false;
>>>>           info.ip = ip;
>>>> +       info.ts_nsec = local_clock();
>>>>
>>>>           complete_report_info(&info);
>>>>
>>>> @@ -582,6 +597,7 @@ bool kasan_report(const void *addr, size_t size, bool is_write,
>>>>           info.access_size = size;
>>>>           info.is_write = is_write;
>>>>           info.ip = ip;
>>>> +       info.ts_nsec = local_clock();
>>>>
>>>>           complete_report_info(&info);
>>>>
>>>> diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
>>>> index 8b8bfdb3cfdb..4d62f1b3e11d 100644
>>>> --- a/mm/kasan/report_tags.c
>>>> +++ b/mm/kasan/report_tags.c
>>>> @@ -26,6 +26,18 @@ static const char *get_common_bug_type(struct kasan_report_info *info)
>>>>           return "invalid-access";
>>>>    }
>>>>
>>>> +#ifdef CONFIG_KASAN_EXTRA_INFO
>>>> +static void kasan_complete_extra_report_info(struct kasan_track *track,
>>>> +                                        struct kasan_stack_ring_entry *entry)
>>>> +{
>>>> +       u32 cpu = READ_ONCE(entry->cpu);
>>>> +       u64 ts_nsec = READ_ONCE(entry->ts_nsec);
>>>> +
>>>> +       track->cpu = cpu;
>>>> +       track->ts_nsec = ts_nsec;
>>>> +}
>>>> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>>>> +
>>>>    void kasan_complete_mode_report_info(struct kasan_report_info *info)
>>>>    {
>>>>           unsigned long flags;
>>>> @@ -82,6 +94,9 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
>>>>
>>>>                           info->free_track.pid = pid;
>>>>                           info->free_track.stack = stack;
>>>> +#ifdef CONFIG_KASAN_EXTRA_INFO
>>>> +                       kasan_complete_extra_report_info(&info->free_track, entry);
>>>> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>>>>                           free_found = true;
>>>>
>>>>                           /*
>>>> @@ -97,6 +112,9 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
>>>>
>>>>                           info->alloc_track.pid = pid;
>>>>                           info->alloc_track.stack = stack;
>>>> +#ifdef CONFIG_KASAN_EXTRA_INFO
>>>> +                       kasan_complete_extra_report_info(&info->alloc_track, entry);
>>>> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>>>>                           alloc_found = true;
>>>>
>>>>                           /*
>>>> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
>>>> index 7dcfe341d48e..474ce7e8be8b 100644
>>>> --- a/mm/kasan/tags.c
>>>> +++ b/mm/kasan/tags.c
>>>> @@ -13,6 +13,7 @@
>>>>    #include <linux/memblock.h>
>>>>    #include <linux/memory.h>
>>>>    #include <linux/mm.h>
>>>> +#include <linux/sched/clock.h>
>>>>    #include <linux/static_key.h>
>>>>    #include <linux/string.h>
>>>>    #include <linux/types.h>
>>>> @@ -92,6 +93,17 @@ void __init kasan_init_tags(void)
>>>>           }
>>>>    }
>>>>
>>>> +#ifdef CONFIG_KASAN_EXTRA_INFO
>>>> +static void save_extra_info(struct kasan_stack_ring_entry *entry)
>>>> +{
>>>> +       u32 cpu = raw_smp_processor_id();
>>>> +       u64 ts_nsec = local_clock();
>>>> +
>>>> +       WRITE_ONCE(entry->cpu, cpu);
>>>> +       WRITE_ONCE(entry->ts_nsec, ts_nsec);
>>>> +}
>>>> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>>>> +
>>>>    static void save_stack_info(struct kmem_cache *cache, void *object,
>>>>                           gfp_t gfp_flags, bool is_free)
>>>>    {
>>>> @@ -124,6 +136,9 @@ static void save_stack_info(struct kmem_cache *cache, void *object,
>>>>           WRITE_ONCE(entry->pid, current->pid);
>>>>           WRITE_ONCE(entry->stack, stack);
>>>>           WRITE_ONCE(entry->is_free, is_free);
>>>> +#ifdef CONFIG_KASAN_EXTRA_INFO
>>>> +       save_extra_info(entry);
>>>> +#endif /* CONFIG_KASAN_EXTRA_INFO */
>>>>
>>>>           /*
>>>>            * Paired with smp_load_acquire() in kasan_complete_mode_report_info().
>>>> --
>>>> 2.39.2
>>>>
>>

