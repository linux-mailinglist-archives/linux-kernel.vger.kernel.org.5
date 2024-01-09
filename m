Return-Path: <linux-kernel+bounces-21538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7998290E8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE921F24ACF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5442C364D5;
	Tue,  9 Jan 2024 23:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DqYyH2yJ"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250FE249E1
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 23:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a277339dcf4so386723466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 15:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704843648; x=1705448448; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ratO5wv52gU4f+PNndYNohTxrLZGvzvXbs9f9x8H7LY=;
        b=DqYyH2yJokRvrEh9BhHeIxXSjy97nS0rfPxRZSlChnxyq4w2xgT19k/bigLTf1Lie0
         AdPpBGoPN69tRlzqFoEKS5Ww8SQvYkxBLqk+Wm2wA/d7S0Jmg4k+KqyNLSHg+6VT0c8C
         4IFWOkPX1FLHT+IGcrerPXvoh7m3hAEp4s1BU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704843648; x=1705448448;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ratO5wv52gU4f+PNndYNohTxrLZGvzvXbs9f9x8H7LY=;
        b=b9ipINXV7qYhvgWvba87ZhCNgontpiKd/w8xuouCtwRxA5pUmr/b5u/QDL90k7vPFD
         RAWCLBQP/s1I/HJBkvaXuga+PdzoQfnw3Urg9SW9NNxxk/L+EfaYqBrKtfFSCfdpJlO+
         xGD2TPEo9M/zRF4ENnodn+m7l0pO0DQ5EcjQM1O3xQh1agFT1WsZUWyJGHmcNzaVyZek
         O3GnSb5ShIHQ4t1kVs4ZsFN61X0SHf0SdC6ToGz0hyPygBHCJEKxO/1bHbOqlHv+hTbK
         3N0DinfK5J2AxqUoYIdSewL4nNeGAym63oObcTaEIuenlSZlfk3oMhMhWgCJmbL0LlEP
         7xig==
X-Gm-Message-State: AOJu0YyvnCUnkbWjUEkMre4EltTL+HjH0OcCLGTaZume5iy7efMukwcj
	PgzmvZHrl/XXG3hOT0y80AkFH2D9glV+N57LRF+Zgtj49EqSaePp
X-Google-Smtp-Source: AGHT+IFJiDLm3cF8PgirpYytrcRINx9UBRvY78iInxdMQq5B8AVwlCEXvXtWeQKRzUHhB8pXnX847w==
X-Received: by 2002:a17:906:c397:b0:a28:aab9:911c with SMTP id t23-20020a170906c39700b00a28aab9911cmr109082ejz.47.1704843648056;
        Tue, 09 Jan 2024 15:40:48 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id v27-20020a170906181b00b00a2ae0aa9002sm1509125eje.40.2024.01.09.15.40.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 15:40:47 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a28d25253d2so387126466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 15:40:46 -0800 (PST)
X-Received: by 2002:a17:906:7813:b0:a29:40fe:254d with SMTP id
 u19-20020a170906781300b00a2940fe254dmr99523ejm.69.1704843646355; Tue, 09 Jan
 2024 15:40:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401081028.0E908F9E0A@keescook> <CAHk-=wgznerM-xs+x+krDfE7eVBiy_HOam35rbsFMMOwvYuEKQ@mail.gmail.com>
 <D01C78AC-830C-4D73-9E9F-7FD38CEF2E82@kernel.org> <ZZ2W_xzCSyOgltad@localhost>
In-Reply-To: <ZZ2W_xzCSyOgltad@localhost>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 9 Jan 2024 15:40:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi75tFVtZdzFRr4hsDeUKmeACbgD46rLe+2bcd=4mHBBw@mail.gmail.com>
Message-ID: <CAHk-=wi75tFVtZdzFRr4hsDeUKmeACbgD46rLe+2bcd=4mHBBw@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.8-rc1
To: Josh Triplett <josh@joshtriplett.org>
Cc: Kees Cook <kees@kernel.org>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, 
	Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jan 2024 at 10:57, Josh Triplett <josh@joshtriplett.org> wrote:
>
> But I do think the spawnbench
> benchmark I provided (which has fork-execvpe and vfork-execvpe and
> posix_spawnp variants) is representative of real-world patterns for how
> programs execute other programs on $PATH.

No, it really isn't.

I already pointed out that the benchmark is entirely broken, because
what it times is broken.

It basically shows the difference in times between the parent and
child both doing a clock_gettime(), but what happens in between those
is
 - the parent doing a fork
 - the child doing an execve
 - the child reading the time
and that makes it a "at which point did we happen to schedule"
benchmark, not an execve() benchmark.

Just as an example, imagine if we schedule the child immediately after
the fork, and the parent doesn't run at all.

That obviously gives the minimum time difference - what your benchmark
then treats as "best". Agreed?

Except does it?

You have random details like "who happens to do a page fault and has
to copy the the stack page that has been marked COW, and that both the
parent and child have mapped and both will write to immediately  after
the fork()"

If the child runs first, the child will take that page fault, and the
child will have to do the page copy and insert it into its own VM.

So maybe it's better if the parent runs first and takes the page fault
and does the copy, and the child runs on another CPU just a little bit
later, and sees that it now has an exclusive page and doesn't need to
copy it at all? Maybe it gets to the execve() faster that way, and
gets a lower time difference just by pure luck? Or at least has a CPU
core of its own while the parent does something else?

Now, with "fork()" *something* has to do the page copy before the
execve() happens, unless it's all very lucky and the child happens to
run with the stack just at a page boundary and just gets its own page
that way.

I suspect you'll get the best performance if you run everything on
just one CPU, and don't try to spread things out, at least if your L2
caches are big enough to fit there - just for the best cache
utilization.

Because if you try to run the two loads on different CPU cores (and
maybe avoid HT siblings too, to get the best throughput), you'll have
to push all the cached contents from the parent to the child.

And maybe thats' ok on this one. It's almost certainly a good thing on
*some* loads, particularly if the child then ends up having more work
it does longer-term.

And yes, our scheduler tries to actually take cache affinity etc into
account, although the interaction with fork() may or may not be
optimal.

But my point is that what you are testing isn't actually the execve()
cycle, you're basically testing all these scheduler interactions on a
benchmark that doesn't actually match any real load.

Now, using vfork() instead of fork() will improve things, both from a
performance standpoint and from a "not as much a scheduler benchmark"
standpoint.

At least we don't have the issue with COW pages and trying to aim for
cache re-use, because there will be no overlap in execution of the
child and parent while they share the same VM. The parent is going to
stop in vfork(), the child is obviously best run on the same CPU until
it does an execve() and releases the parent, and at that point it's
*probably* best to try to run the new child on a different CPU, and
bring the parent back on the original CPU,.

Except that behavior (which sounds to me like the best option in
general) is not AT ALL what your benchmark would consider the best
option - because all your spawn bench thing looks at is how quickly
the child gets to run, so things like "cache placement for parent" no
longer matter at all for spawnbench.

So for that benchmark, instead of maybe trying to keep the parent
local to its own caches, and run the (new) child with no cache
footprint on another CPU, the best numbers for your benchmark probably
come from running the new execve() on the same CPU and not running the
parent at all until later.

And those are good numbers for the spawnbench just because the process
was already on that CPU in the kernel, so not running the parent where
it makes sense is good, because alll that matterns by then is that you
want to run the child asap.

See? your benchmark doesn't actually even *attempt* to time how good
our fork-execve sequence is. It times something entirely different. It
basically gives the best score to a scheduler decision that probably
doesn't even make sense.

Or maybe it does. Who knows? Maybe we *should* change the scheduler to
do what is best for spawnbench.

But do you see why I think it's at least as much a scheduler benchmark
as it is a execve() one, and why I think it's likely not a very good
benchmark at all, because I _suspect_ that the best numbers come from
doing things that may or may not make sense..

Now, I sent out that other benchmark, which at least avoids the whole
scheduler thing, because it does everything as one single process. I'm
not saying that's a sensible benchmark _either_, but at least it's
targeted to just execve().

Another option would be to not time the whole "parent clock_gettime ->
child clock_gettime" sequience that makes no sense, but to just time
the whole "fork-execve-exit-wait" sequence (which you can do in the
parent).

Because at that point, you're not timing the difference between two
random points (where scheduling decisions will change what happens
between them), you're actually timing the cost of the *whole*
sequence. Sure, scheduling will still matter for the details, but at
least you've timed the whole work, rather than timed a random *part*
of the work where other things are then ignored entirely.

For example, once you time the whole thing, it's no longer a "did the
parent of the child do the COW copy"? We don't care. One or the other
has to take the cost, and it's part of the *whole* cost of the
operation. Sure, scheduling decisions will still end up mattering, so
it's not a pure execve() benchmark, but at least now it's a benchmark
for the whole load, not just a random part of it.

              Linus

