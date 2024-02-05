Return-Path: <linux-kernel+bounces-52493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352A08498F0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E153B2640A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE86518AEE;
	Mon,  5 Feb 2024 11:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tum.de header.i=@tum.de header.b="AgzJMd+i"
Received: from postout2.mail.lrz.de (postout2.mail.lrz.de [129.187.255.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF371AACB;
	Mon,  5 Feb 2024 11:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.187.255.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707132882; cv=none; b=Xkgne6zAj8Z+VdKvS2rcgb8kyXwT5kpr2uKe2hswH0N9cvSxb3nRj40E5RPk8ujsQahIKLCXAE7xgpD/8qJGSrBIvH7psbL+8H360AIFMKM0rwHRN0rmcRrT1X3qYuOUyIeK3lNWa1AX22fV+GNmqg+BDmebT8fejDFbSeTHaKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707132882; c=relaxed/simple;
	bh=KQyUWjy/NdoHci/K8diYvLaWbBMLu+ejjcDwBS9zE18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPAC6vDLYDjmEkY3E64gAVAbIOBMlBK47D+n6Yl+t0Xz/oBq+XaRjlHZjbtpwy7rSxgx+rHYjVgxUsMgeeDRVMU3LNboRvZgUgDKsh3U9MakUFvF3BE3rwamYLSKQ+t4KLPQ+zNTgst8xljtO5YulqgRo5nSlAp7mz2Q5+q/+g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tum.de; spf=pass smtp.mailfrom=tum.de; dkim=pass (2048-bit key) header.d=tum.de header.i=@tum.de header.b=AgzJMd+i; arc=none smtp.client-ip=129.187.255.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tum.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tum.de
Received: from lxmhs52.srv.lrz.de (localhost [127.0.0.1])
	by postout2.mail.lrz.de (Postfix) with ESMTP id 4TT46C4ZldzyTH;
	Mon,  5 Feb 2024 12:34:27 +0100 (CET)
Authentication-Results: postout.lrz.de (amavisd-new); dkim=pass (2048-bit key)
	reason="pass (just generated, assumed good)" header.d=tum.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tum.de; h=
	in-reply-to:content-transfer-encoding:content-disposition
	:content-type:content-type:mime-version:references:x-mailer
	:message-id:subject:subject:from:from:date:date:received
	:received; s=tu-postout21; t=1707132865; bh=KQyUWjy/NdoHci/K8diY
	vLaWbBMLu+ejjcDwBS9zE18=; b=AgzJMd+il+HHqT8DO7f+SSnkGUn36ua1L3WI
	x7DZSgAlQSgTwY4sx5T7KfH+BZlMyGWLbqD/+Och/ICOkaOI2M0t/WkXMGENGHdq
	Okbi60fc0VsJ/CagPxWFz9Up46cJ1RGkDPC5/jYU0leSRCP4PfBMKlInjQXD9odf
	03JEaEsozc9jLXIn6GROW7G2IgL4yWy5AdhBCEAKXPcbIWEMtwXesCkIhKG47PMH
	M1Ka+CzcxN2D4DY8g1XWk9S1w0C6Lh8HRaAsJ03ivH8LJOeEivq8qGn86n3vAM1Z
	qH+3cY3gGFQ+E1NMHNPrM843O6USxuXvF02VTbu5gWYmhT9g9g==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs52.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -2.884
X-Spam-Level:
Received: from postout2.mail.lrz.de ([127.0.0.1])
	by lxmhs52.srv.lrz.de (lxmhs52.srv.lrz.de [127.0.0.1]) (amavisd-new, port 20024)
	with LMTP id hTsJ2oxF2cFS; Mon,  5 Feb 2024 12:34:25 +0100 (CET)
Received: from pine.fritz.box (unknown [IPv6:2001:a61:2560:7f01:69dc:22b:b206:7a57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by postout2.mail.lrz.de (Postfix) with ESMTPSA id 4TT4681dSGzyTL;
	Mon,  5 Feb 2024 12:34:24 +0100 (CET)
Date: Mon, 5 Feb 2024 12:34:20 +0100
From: Paul =?utf-8?Q?Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>
To: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Peter Collingbourne <pcc@google.com>, andrey.konovalov@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrey Konovalov <andreyknvl@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v3 1/3] kasan: switch kunit tests to console tracepoints
Message-ID: <8D76B3E2-91CD-46BC-B990-59D6D60AC9BA@tum.de>
X-Mailer: MailMate (1.14r5937)
References: <CA+fCnZebmy-fZdNonrgLofepTPL5hU6P8R37==sygTLBSRoa+w@mail.gmail.com>
 <fv7fn3jivqcgw7mum6zadfcy2fbn73lygtxyy5p3zqpelfiken@5bmhbdufxgez>
 <CA+fCnZfQEueCifc-8d5NVWEUtAiOG1eRW-LFKbOhab_Y7jqU0Q@mail.gmail.com>
 <osqmp2j6gsmgbkle6mwhoaf65mjn4a4w3e5hsfbyob6f44wcg6@7rihb5otzl2z>
 <CANpmjNMw3N09x06Q+0mFCEeTKfUsDdXwXM2hdgAQ+wwbZGpB9w@mail.gmail.com>
 <rbcdbilhh67fvjdgnstu25v4jnfeesthoxstnzzglynbngu5bk@5ozwgzaulbsx>
 <CA+fCnZf5kxWUWCzK8EKgUuq_E2rYv5aw=SqZMDb93+=7vSUp+w@mail.gmail.com>
 <rgndtm3sawyzdh76oofoqp22jyqdb25sd4326k2heevjmxum7f@wfgwvdf4iuyi>
 <CANpmjNN5Q+byA3sWv1uB_R=QYQxKg5YsLKayqv7WNWokkL5H4Q@mail.gmail.com>
 <h7qw4rhqovyq5trm5kyvabshqmxcpwlrdr55xadhtv5iifxjem@gz4wjtng7b42>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <h7qw4rhqovyq5trm5kyvabshqmxcpwlrdr55xadhtv5iifxjem@gz4wjtng7b42>



On 7 Jan 2024, at 19:22, Paul Heidekrüger wrote:

> On 12.12.2023 10:32, Marco Elver wrote:
>> On Tue, 12 Dec 2023 at 10:19, Paul Heidekrüger <paul.heidekrueger@tum.de> wrote:
>>>
>>> On 12.12.2023 00:37, Andrey Konovalov wrote:
>>>> On Tue, Dec 12, 2023 at 12:35 AM Paul Heidekrüger
>>>> <paul.heidekrueger@tum.de> wrote:
>>>>>
>>>>> Using CONFIG_FTRACE=y instead of CONFIG_TRACEPOINTS=y produces the same error
>>>>> for me.
>>>>>
>>>>> So
>>>>>
>>>>>         CONFIG_KUNIT=y
>>>>>         CONFIG_KUNIT_ALL_TESTS=n
>>>>>         CONFIG_FTRACE=y
>>>>>         CONFIG_KASAN=y
>>>>>         CONFIG_KASAN_GENERIC=y
>>>>>         CONFIG_KASAN_KUNIT_TEST=y
>>>>>
>>>>> produces
>>>>>
>>>>>         ➜   ./tools/testing/kunit/kunit.py run --kunitconfig=mm/kasan/.kunitconfig --arch=arm64
>>>>>         Configuring KUnit Kernel ...
>>>>>         Regenerating .config ...
>>>>>         Populating config with:
>>>>>         $ make ARCH=arm64 O=.kunit olddefconfig CC=clang
>>>>>         ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
>>>>>         This is probably due to unsatisfied dependencies.
>>>>>         Missing: CONFIG_KASAN_KUNIT_TEST=y
>>>>>
>>>>> By that error message, CONFIG_FTRACE appears to be present in the generated
>>>>> config, but CONFIG_KASAN_KUNIT_TEST still isn't. Presumably,
>>>>> CONFIG_KASAN_KUNIT_TEST is missing because of an unsatisfied dependency, which
>>>>> must be CONFIG_TRACEPOINTS, unless I'm missing something ...
>>>>>
>>>>> If I just generate an arm64 defconfig and select CONFIG_FTRACE=y,
>>>>> CONFIG_TRACEPOINTS=y shows up in my .config. So, maybe this is kunit.py-related
>>>>> then?
>>>>>
>>>>> Andrey, you said that the tests have been working for you; are you running them
>>>>> with kunit.py?
>>>>
>>>> No, I just run the kernel built with a config file that I put together
>>>> based on defconfig.
>>>
>>> Ah. I believe I've figured it out.
>>>
>>> When I add CONFIG_STACK_TRACER=y in addition to CONFIG_FTRACE=y, it works.
>>
>> CONFIG_FTRACE should be enough - maybe also check x86 vs. arm64 to debug more.
>
> See below.
>
>>> CONFIG_STACK_TRACER selects CONFIG_FUNCTION_TRACER, CONFIG_FUNCTION_TRACER
>>> selects CONFIG_GENERIC_TRACER, CONFIG_GENERIC_TRACER selects CONFIG_TRACING, and
>>> CONFIG_TRACING selects CONFIG_TRACEPOINTS.
>>>
>>> CONFIG_BLK_DEV_IO_TRACE=y also works instead of CONFIG_STACK_TRACER=y, as it
>>> directly selects CONFIG_TRACEPOINTS.
>>>
>>> CONFIG_FTRACE=y on its own does not appear suffice for kunit.py on arm64.
>>
>> When you build manually with just CONFIG_FTRACE, is CONFIG_TRACEPOINTS enabled?
>
> When I add CONFIG_FTRACE and enter-key my way through the FTRACE prompts - I
> believe because CONFIG_FTRACE is a menuconfig? - at the beginning of a build,
> CONFIG_TRACEPOINTS does get set on arm64, yes.
>
> On X86, the defconfig already includes CONIFG_TRACEPOINTS.
>
> I also had a closer look at how kunit.py builds its configs.
> I believe it does something along the following lines:
>
>     cp <path_to_kunitconfig> .kunit/.config
>     make ARCH=arm64 O=.kunit olddefconfig
>
> On arm64, that isn't enough to set CONFIG_TRACEPOINTS; same behaviour when run
> outside of kunit.py.
>
> For CONFIG_TRACEPOINTS, `make ARCH=arm64 menuconfig` shows:
>
>     Symbol: TRACEPOINTS [=n]
>     Type  : bool
>     Defined at init/Kconfig:1920
>     Selected by [n]:
>     	- TRACING [=n]
>     	- BLK_DEV_IO_TRACE [=n] && FTRACE [=y] && SYSFS [=y] && BLOCK [=y]
>
> So, CONFIG_TRACING or CONFIG_BLK_DEV_IO_TRACE are the two options that prevent
> CONFIG_TRACEPOINTS from being set on arm64.
>
> For CONFIG_TRACING we have:
>
>     Symbol: TRACING [=n]
>     Type  : bool
>     Defined at kernel/trace/Kconfig:157
>     Selects: RING_BUFFER [=n] && STACKTRACE [=y] && TRACEPOINTS [=n] && NOP_TRACER [=n] && BINARY_PRINTF [=n] && EVENT_TRACING [=n] && TRACE_CLOCK [=y] && TASKS_RCU [=n]
>     Selected by [n]:
>     	- DRM_I915_TRACE_GEM [=n] && HAS_IOMEM [=y] && DRM_I915 [=n] && EXPERT [=n] && DRM_I915_DEBUG_GEM [=n]
>     	- DRM_I915_TRACE_GTT [=n] && HAS_IOMEM [=y] && DRM_I915 [=n] && EXPERT [=n] && DRM_I915_DEBUG_GEM [=n]
>     	- PREEMPTIRQ_TRACEPOINTS [=n] && (TRACE_PREEMPT_TOGGLE [=n] || TRACE_IRQFLAGS [=n])
>     	- GENERIC_TRACER [=n]
>     	- ENABLE_DEFAULT_TRACERS [=n] && FTRACE [=y] && !GENERIC_TRACER [=n]
>     	- FPROBE_EVENTS [=n] && FTRACE [=y] && FPROBE [=n] && HAVE_REGS_AND_STACK_ACCESS_API [=y]
>     	- KPROBE_EVENTS [=n] && FTRACE [=y] && KPROBES [=n] && HAVE_REGS_AND_STACK_ACCESS_API [=y]
>     	- UPROBE_EVENTS [=n] && FTRACE [=y] && ARCH_SUPPORTS_UPROBES [=y] && MMU [=y] && PERF_EVENTS [=n]
>     	- SYNTH_EVENTS [=n] && FTRACE [=y]
>     	- USER_EVENTS [=n] && FTRACE [=y]
>     	- HIST_TRIGGERS [=n] && FTRACE [=y] && ARCH_HAVE_NMI_SAFE_CMPXCHG [=y]
>
>>> I believe the reason my .kunitconfig as well as the existing
>>> mm/kfence/.kunitconfig work on X86 is because CONFIG_TRACEPOINTS=y is present in
>>> an X86 defconfig.
>>>
>>> Does this make sense?
>>>
>>> Would you welcome a patch addressing this for the existing
>>> mm/kfence/.kunitconfig?
>>>
>>> I would also like to submit a patch for an mm/kasan/.kunitconfig. Do you think
>>> that would be helpful too?
>>>
>>> FWICT, kernel/kcsan/.kunitconfig might also be affected since
>>> CONFIG_KCSAN_KUNIT_TEST also depends on CONFIG_TRACEPOITNS, but I would have to
>>> test that. That could be a third patch.
>>
>> I'd support figuring out the minimal config (CONFIG_FTRACE or
>> something else?) that satisfies the TRACEPOINTS dependency. I always
>> thought CONFIG_FTRACE ought to be the one config option, but maybe
>> something changed.
>
> If we want a minimal config, setting CONFIG_BLK_DEV_IO_TRACE,
> CONFIG_SYNTH_EVENTS or CONFIG_USER_EVENTS seem like viable options, for
> instance. But AFAICT, setting them in the context of KASan doesn't really make
> sense, and I might be missing an obvious choice here too.
>
> What do you think?
>
>> Also maybe one of the tracing maintainers can help untangle what's
>> going on here.
>>
>> Thanks,
>> -- Marco
>
> Many thanks,
> Paul

Hi all,

Just giving this thread a polite bump, hoping that someone has some pointers.

The TL;DR is the following: I’m trying to run KASan KUnit tests with the 
following local .kunitconfig:

	CONFIG_KUNIT=y
	CONFIG_KUNIT_ALL_TESTS=n
	CONFIG_FTRACE=y
	CONFIG_KASAN=y
	CONFIG_KASAN_GENERIC=y
	CONFIG_KASAN_KUNIT_TEST=y

The problem is that on arm64, this does not appear to be enough to set all of 
CONFIG_KASAN_KUNIT_TEST’s dependencies, namely CONFIG_TRACEPOINTS.

An additional option is needed to enable CONFIG_TRACEPOINTS. As per `make 
menuconfig`, this is either CONFIG_BLK_DEV_IO_TRACE or any (combination of) 
option(s) that enable(s) CONFIG_TRACING. See the `make menuconfig` output in my 
previous email for details.

Which option do you think is appropriate here? Or am I missing something?

For anyone wanting to reproduce, use:
/tools/testing/kunit/kunit.py run —kunitconfig=<path_to_above_kunitconfig> --arch=arm64

Many thanks,
Paul


