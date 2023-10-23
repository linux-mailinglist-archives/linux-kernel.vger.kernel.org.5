Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A687D40E8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 22:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjJWU2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 16:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjJWU2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 16:28:10 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAD7D79;
        Mon, 23 Oct 2023 13:28:07 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7a66aa8ebb7so143812139f.3;
        Mon, 23 Oct 2023 13:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698092887; x=1698697687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BtorBiTAqkC2vFXm3dsPMBRxE7TMLbnZ/0poxgEUxAI=;
        b=GEmp7xkLPNA+eygYC0nKsdYQL5UM66bBTmrUnVNcdoVLK/wyuvOR2FE7VpkRmv3AMA
         /w+if9gZa6gjC3zjsQeIWTzk2+mgDglbLuw4GR9kXOo6gMPtPPj4JvjFfZwHCfIQ3Hn0
         5/sP6y+s5JYMC0GEBAHmnUwJhBzfWWLQ8Te4YATp1Zdt2g1WddV68rtvz4qKyoKp2j+8
         ybx+sSVQcCctnj1BuLAis6/PCZlMThkE05dZvQKl8cakFs4s5dx6gxtGHhKyBlvxGpl3
         wa2Fu/YJF3rJnE1WTyPU/Yq/r4XlKvCdczWyHepzDYlA1royneA9+fRoPdgCaahHZtiu
         IoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698092887; x=1698697687;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BtorBiTAqkC2vFXm3dsPMBRxE7TMLbnZ/0poxgEUxAI=;
        b=WY5BZ31j6fRdsP7qjcFWvgMDQnObxqwX0QERSsVFyncq5xaB8vCxnbQon4GoCYR2CA
         Qr2kKNA+QU/F7cmmSwCuwmSNcFfupIuAfW2y2wjndm2DM0gGprmdRvyll5KESJ3F6Syq
         8H0puvVqIdnGRpIBg0hVO7QjH5cL5Qh/gdOsikD28aor2lnHuaUKtO3X8aJ26KQLv418
         hE5i7nImdcw6uJM88mtM0B31nAHXkfdsspP67eeexJLfz5uMqs7pPwbrZw/LZhu3yUnA
         cNRNXWrbS64rIFPBN4kOgxxwEwnxaXSuTq8eOwJJ8Okhqr1sIxDTQ+B7x4MDCqPUM/L7
         uFTw==
X-Gm-Message-State: AOJu0YwTPuXBzEfVHBU617dVII54bpAVq/eNSEMmQc+S8YHHb8s0UJh1
        hOGlkgBXyBg5XlJLbJFNSA==
X-Google-Smtp-Source: AGHT+IEj5EEnfTcf/gw6571wylJf8QGV8TB8FvMcTYoU2jxYL1CZtc99KrnZruv8iwZPZ1C4SMQsjQ==
X-Received: by 2002:a92:c087:0:b0:357:46e3:58be with SMTP id h7-20020a92c087000000b0035746e358bemr10523881ile.1.1698092886678;
        Mon, 23 Oct 2023 13:28:06 -0700 (PDT)
Received: from [192.168.1.3] ([161.97.241.227])
        by smtp.googlemail.com with ESMTPSA id o7-20020a92c687000000b0034ff58af12dsm2668398ilg.77.2023.10.23.13.28.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 13:28:06 -0700 (PDT)
Message-ID: <62349c78-14b8-4d5c-87ea-00dbd662fe26@gmail.com>
Date:   Mon, 23 Oct 2023 14:28:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] arch/x86: port I/O tracing on x86
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-serial <linux-serial@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org,
        andriy.shevchenko@linux.intel.com, quic_saipraka@quicinc.com,
        Steven Rostedt <rostedt@goodmis.org>
References: <b8eae358-a3b3-fd68-82f1-b2c53534b922@gmail.com>
 <2023100344-dart-jailbreak-c371@gregkh>
 <94e2b77c-9cc4-534f-e650-06d7e0697f9f@gmail.com>
 <20231004195001.76a57417@gandalf.local.home>
 <80b84be0-a0ad-d1a9-607a-a87c6cf509e0@gmail.com>
 <cc7fba3b-9da2-b9eb-95c8-7336e1cd4449@gmail.com>
 <2023102122-diabetes-trend-57d0@gregkh>
Content-Language: en-US
From:   Dan Raymond <raymod2@gmail.com>
In-Reply-To: <2023102122-diabetes-trend-57d0@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/2023 10:00 AM, Greg KH wrote:> This is now outside of my subsystems to review, sorry.  It's going to> have to go through the x86 tree, so you are going to have to convince
> them that this is something that actually matters and is needed by
> people, as maintaining it over time is going to add to their workload.

Tracing is not needed, per se, but it can be incredibly useful for
debugging certain types of problems.  I think the utility of tracing is
well accepted by the community.  

Quoting Peter Zijlstra:

   "...tracepoints in general are useful"

Quoting Andy Shevchenko:

   "...you may trace any IO on some architectures (at least x86), it's
   called mmiotracer (I have used it like 5 years ago or so to trace UART)"

Similar trace functionality is already present in the kernel today
(CONFIG_MMIOTRACE and CONFIG_TRACE_MMIO_ACCESS) and it does anecdotally
get used.  However, as mentioned in the patch description, those tracing
features don't work with port-based I/O hence the need for this patch.
I don't see how this is going to create a maintenance burden.  It adds
two lines of code to a macro that rarely if ever changes.

>> --- a/arch/x86/boot/Makefile
>> +++ b/arch/x86/boot/Makefile
>
> Note, you are keeping tracing from working in a few areas that might not
> be good...
>> Now I know why you did that for this patch (i.e. so early boot doesn't
> get the printk mess), but that kind of defeats the use of tracepoints at
> all for this part of the kernel, is that ok?  Are any existing
> tracepoints now removed?

Some of the kernel sources (arch/x86/boot/* and arch/x86/realmode/*) are
not part of the kernel proper and they don't have the infrastructure to
support tracepoints.  When these sources include header files that
reference tracepoints it causes compiler errors.  I previously worked
around this issue with include guard checks but you objected to that:

   "I see what you are doing here in trying to see if a .h file has been
   included already, but now you are making an assumption on both the .h
   file ordering, and the #ifdef guard for those .h files, which are
   something that we almost never remember or even consider when dealing
   with .h files files."

Therefore I implemented a more reliable mechanism to disable tracepoints.
I explained this earlier in the thread:

   "What we need is to disable tracepoints altogether in arch/x86/boot/*
   so I added -DDISABLE_TRACEPOINTS to the relevant Makefiles and I added
   a check for that symbol in tracepoint-defs.h.  I will submit a v4
   version of my patch with these changes shortly.

   This resolves the problem with <asm/msr.h> as well.  After applying
   the v4 patch I was able to call rdmsr()/wrmsr() from
   arch/x86/boot/misc.c.  Theoretically we can now remove
   arch/x86/boot/msr.h but I had trouble with that due to compiler
   warnings and errors.  The include files in arch/x86/boot are a mess.
   Maybe this can be cleaned up in another patch."

>> --- a/arch/x86/include/asm/cmpxchg_32.h
>> +++ b/arch/x86/include/asm/cmpxchg_32.h
> 
> Why are these needed to be changed at all?  What code changes with it,
> and it's not mentioned in the changelog, so why is it required?

I did mention these changes in the changelog:

   "fix compiler warnings due to signed/unsigned mismatch in arch_cmpxchg64()"

These warnings appear to be a latent defect which was triggered by the
include file changes in this patch.  I assume that introducing compiler
warnings (even indirectly) is not allowed so I fixed them on this patch.

>> +	if (tracepoint_enabled(portio_write))				\
>> +		do_trace_portio_write(value, port, #bwl[0]);		\
> 
> Your level of indirection here seems deep, why doesn't
> do_trace_portio_write() belong in a .h file here and do the
> tracepoint_enabled() check?
> 
> Is this a by-product of the tracing macros that require this deeper
> callchain to happen?

Please reference Documentation/trace/tracepoints.rst:

   "If you require calling a tracepoint from a header file, it is not
   recommended to call one directly or to use the
   trace_<tracepoint>_enabled() function call, as tracepoints in header
   files can have side effects..."

The tracepoint_enabled() macro is very efficient and causes only one
instruction of overhead (a nop) when tracing is disabled.  I verified
this by disassembling vmlinux.

>> +obj-$(CONFIG_TRACEPOINTS) += trace_portio.o
> 
> So you are always enabling these if any CONFIG_TRACEPOINTS is enabled?
> That seems brave.

This doesn't enable the tracepoints.  It just adds support for portio
tracepoints to the kernel image.  The tracepoints are disabled by default
and must be explicitly enabled by the user at runtime.  The overhead is
very modest when portio tracing is disabled (as I mentioned above).

> Again, you prevent any tracepoints from this code chunk, is that going
> to be ok going forward?

I addressed this question above.

> Nit, "extern" isn't needed in .h files anymore.  Not a big deal, just
> for other work you do going forward.

Noted.

>> -#ifdef CONFIG_TRACEPOINTS
>> +#if defined(CONFIG_TRACEPOINTS) && !defined(DISABLE_TRACEPOINTS)
> 
> Why this global change?

I addressed this question above.  This is how we prevent tracepoint
logic in header files from causing compiler errors in source files that
aren't part of the kernel proper.

> Anyway, it's up to the x86 maintainers now, good luck!
> 
> But personally, I don't see the real need for this at all.  It's a
> debugging thing for what exactly?  Who needs this?  Who will use it?
> When will they use it?  And why?

This comment confuses me.  As you know I originally submitted a patch
that added I/O tracing just to the 8250 serial driver.  The patch was
titled "create debugfs interface for UART register tracing".  You said
this at the time:

   "Anyway, again, cool feature, I like it, but if you can tie it into
   the existing trace framework better (either by using that entirely
   which might be best), or at the least, putting your hook into the
   data path with it, that would be best."

My original patch went through a few revisions before Andy Shevchenko
suggested I should add portio tracing instead in a manner similar to
how CONFIG_TRACE_MMIO_ACCESS works.  You agreed.  Hence I created this
patch.





