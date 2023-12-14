Return-Path: <linux-kernel+bounces-92-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF113813C0B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0BF81C21B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8EE6A35B;
	Thu, 14 Dec 2023 20:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FfoMFynM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785082DF66
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 20:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a1f6433bc1eso209667666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 12:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1702587047; x=1703191847; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=70Y7o3IdU9xF6jWzjwutAl8ZEw5YbkckBXgTZi3FBa0=;
        b=FfoMFynMFOxD2ydWLHwg2k1Vn5PZ898lYI5PZoP+z020RE1SNUzT2jwNvaAYIjYpnd
         hdGSfSgrIST54KTK1rCQkphZHpqHL9nTq9eIjW/6Q/T/ySagqKXX5dXMp2bKl1aFpSO8
         YblI4YcHcxpx0A2t9ioMk71y+T7KKeKo19aHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702587047; x=1703191847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=70Y7o3IdU9xF6jWzjwutAl8ZEw5YbkckBXgTZi3FBa0=;
        b=YiEj61N8z5Z1tr3T8wPQTbHXKOWE+nRvtvIjK4clHYbMa2LT6TEZldD/7SRvI9p0vJ
         oYXwU3RHfVOkxgvwlVLdNZFHBGkf5/d4VJ7GUU2yUCLN6Qh+ZQYkcesiYiVEL1JG3blS
         moJO4ri4i25UPkyedsJjPGKfZgq9ts4ldmXHsHEp5stkyKRxZbPj0ASr5hQfvTIDh4a1
         c8Z5unfyzuX2E6vyqglmuHCV7B+ruVrWNFITwSPVGpD9XBw93ksBq1n91YW5wjsfqivI
         X1C56lXiYBGmf/SrEJQ1E6bPCMWuZfStdJFFBxB9BMMG5RyMvdu8ViaOiW0Fs3LepGzY
         l+KA==
X-Gm-Message-State: AOJu0YzfkPy6TZ6t2TVGHGlL+ma9xUXjEFKZul3f2VBAFJZMxKJh9lPR
	HsA3793bVGx3o15Gob+YQhaqGPte3+7BLRzlqqAQj+Vp
X-Google-Smtp-Source: AGHT+IGVeSxsx1F1/IBHZ6hyWi91KBHpIHxbGSJ0F0ga7cqoezlx3fqSAX8sTTaAwHhCVgCuzczkgQ==
X-Received: by 2002:a17:906:3e92:b0:a1d:1be7:59f with SMTP id a18-20020a1709063e9200b00a1d1be7059fmr9523159ejj.74.1702587047501;
        Thu, 14 Dec 2023 12:50:47 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id th19-20020a1709078e1300b00a1bda8db043sm9721455ejc.120.2023.12.14.12.50.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 12:50:47 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a1ca24776c3so212637866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 12:50:47 -0800 (PST)
X-Received: by 2002:a17:906:608e:b0:a04:e1e7:d14c with SMTP id
 t14-20020a170906608e00b00a04e1e7d14cmr11442076ejj.32.1702587046729; Thu, 14
 Dec 2023 12:50:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213211126.24f8c1dd@gandalf.local.home> <20231213214632.15047c40@gandalf.local.home>
 <CAHk-=whESMW2v0cd0Ye+AnV0Hp9j+Mm4BO2xJo93eQcC1xghUA@mail.gmail.com>
 <20231214115614.2cf5a40e@gandalf.local.home> <CAHk-=wjjGEc0f4LLDxCTYvgD98kWqKy=89u=42JLRz5Qs3KKyA@mail.gmail.com>
 <20231214153636.655e18ce@gandalf.local.home>
In-Reply-To: <20231214153636.655e18ce@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Dec 2023 12:50:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wieVSfyjTpe8L5kmwC4mk9dRge9dvyJiMZEkyz4-tOvow@mail.gmail.com>
Message-ID: <CAHk-=wieVSfyjTpe8L5kmwC4mk9dRge9dvyJiMZEkyz4-tOvow@mail.gmail.com>
Subject: Re: [PATCH] ring-buffer: Remove 32bit timestamp logic
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Dec 2023 at 12:35, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 14 Dec 2023 11:44:55 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > On Thu, 14 Dec 2023 at 08:55, Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > And yes, this does get called in NMI context.
> >
> > Not on an i486-class machine they won't. You don't have a local apic
> > on those, and they won't have any NMI sources under our control (ie
> > NMI does exist, but we're talking purely legacy NMI for "motherboard
> > problems" like RAM parity errors etc)
>
> Ah, so we should not worry about being in NMI context without a 64bit cmpxchg?

.. on x86.

Elsewhere, who knows?

It is *probably* true in most situations. '32-bit' => 'legacy' =>
'less likely to have fancy profiling / irq setups'.

But I really don't know.

> > So no. You need to forget about the whole "do a 64-bit cmpxchg on
> > 32-bit architectures" as being some kind of solution in the short
> > term.
>
> But do all archs have an implementation of cmpxchg64, even if it requires
> disabling interrupts? If not, then I definitely cannot remove this code.

We have a generic header file, so anybody who uses that would get the
fallback version, ie

arch_cmpxchg64 -> generic_cmpxchg64_local -> __generic_cmpxchg64_local

which does that irq disabling thing.

But no, not everybody is guaranteed to use that fallback. From a quick
look, ARC, hexagon and CSky don't do this, for example.

And then I got bored and stopped looking.

My guess is that *most* 32-bit architectures do not have a 64-bit
cmpxchg - not even the irq-safe one.

For the UP case you can do your own, of course.

            Linus

