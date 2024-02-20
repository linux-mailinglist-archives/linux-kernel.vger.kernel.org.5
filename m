Return-Path: <linux-kernel+bounces-73636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E74285C55D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4259B2857AF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A2014C5AB;
	Tue, 20 Feb 2024 20:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1k3QNyy"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7811C14A0B7
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 20:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708459285; cv=none; b=fIFTGWV18zqkRsWV/KJXLI8wgVvJpemequbW4C1uCnGSCqTxiufuFaTtv9UBtlY3bKn4C/68RxZY3da/eW4/a16e5SUFGP+JR2rod1MLoBwBrgQNZ50s4OtgEEyqw+hBQJyvx8p4xISmWEuH88v0xUGOVImtWrQZe2wD1KCCQpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708459285; c=relaxed/simple;
	bh=H0OqSoyPMkNjLT+pSoJDz6lzuRZUfrTWgoL7fXQcM0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZjvOs+4rSbhAMSpvj76Lli+W73wyaYbX6hGtyM684dZ+ymoc17HZOJ8V1539ImXIQvyovs9AAKK2Xk/rT0KhY+zPwuLjhmMAmF4QL5zfjAPVAXiKWi4yEY6KjVBQ/Vmi3Bj1qtn5KGL3ZcfIjySIz4HwP7sMYekzfZA790nhpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1k3QNyy; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e4884770d4so373444b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708459282; x=1709064082; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+BTLFzt0+pif+FJZs4rp/gi/2rjb27aKNMsMZ5GhVoM=;
        b=j1k3QNyyb3HZ8d5giE6yngRzKEpH+DBmz/zjXg7AKdLqvlQaG1rOhqFHKO0nwlLmRW
         jYxvp55VQdhywyKsmdKkRgB9Re6G0+bE1h7qIPKARK/5/7cITWrkPax5SPilAfl6hDfe
         Vr171ft7z18PHCDRKKLbhcHeUkULfova4Or/xwxzJIunHrDLnggXtZQ1IGt87g6zvsI/
         tURKsF2/EUyMcAQrPmuLgaWZVI7zbAwjS5OVrKlesjghDvKoJ+Gk0IXizq7ZK5F9k0U3
         JwwZ18eLGtAA8JhaGXiQ5YwTzrVBJ+l5ij1/X4LDWclLS7qzDdYr9k+v+57yEWV7r9Nq
         mL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708459282; x=1709064082;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+BTLFzt0+pif+FJZs4rp/gi/2rjb27aKNMsMZ5GhVoM=;
        b=QIGH0l7iPjsGlsP3//eoWY8+lfbd5w7if/aYZWPm/LFniy4rB5AqcboDEYV8C40U0G
         AtzjLc8JBl+seyrPrzFAGcyRGY7Ur0enVVXwSuttaxhDmzFXAX4lePKnMLHtGK8lc7Yw
         5HfGEFVX5p4xhk7dhvjaMtbGQDwCj5JVkenel/SfggIkVMLOIFMf7NsEgrnq6qQjhDUV
         Vfa/ifZtXHKjOPXrmDaVAYJnWUA6mxnMN0WKJ/4Vu9G6O2Ppuwi1cOdeuKZqnw2ku93V
         Lf0TXsBghTG6vBP/R8u+WlObic51ZFuPWoi1SzT4LnuV0AwvMq32qOGn+/MyvF5foAoi
         A+Jg==
X-Forwarded-Encrypted: i=1; AJvYcCVIB7WwsXcACbw1ly3ztShUIC9dpYbtrAji1Odra+1Ziel+hqL+rWSOhfjztul0lGgPYVn9swGUxQuNviH/7FmPu84QhCGIfTk8bBTr
X-Gm-Message-State: AOJu0YzL3f6ilv0lkP7PSlQeW3myN6crxIyNW7sD+UkmcZ2LBe3oU01x
	83oTKh12tFgRmB5HjAsaXKTwhbSQD/RZ1Dx0o/AgmpcM0bCeAPUQlQnQ3U97hSw=
X-Google-Smtp-Source: AGHT+IGfc2g2KrS2qeWItOGi6kUgUUR2E5eJQrP6AnVBmZn9AS3rSUK50sN05ecefr51aUz9/GdY2w==
X-Received: by 2002:a05:6a20:4b22:b0:19e:cd14:1f8d with SMTP id fp34-20020a056a204b2200b0019ecd141f8dmr12888739pzb.35.1708459282480;
        Tue, 20 Feb 2024 12:01:22 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id p21-20020aa78615000000b006e0949b2548sm6607017pfn.209.2024.02.20.12.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 12:01:22 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 20 Feb 2024 10:01:20 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH 16/17] workqueue: Allow cancel_work_sync() and
 disable_work() from atomic contexts on BH work items
Message-ID: <ZdUFEGm9PYfmdQYX@slm.duckdns.org>
References: <20240216180559.208276-1-tj@kernel.org>
 <20240216180559.208276-17-tj@kernel.org>
 <CAJhGHyBR6up3o9Svxn=uL2a0rRcu-q3BR8TgdpLykR6iTZ3Aew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJhGHyBR6up3o9Svxn=uL2a0rRcu-q3BR8TgdpLykR6iTZ3Aew@mail.gmail.com>

Hello,

On Tue, Feb 20, 2024 at 03:33:34PM +0800, Lai Jiangshan wrote:
> Hello, Tejun
> 
> On Sat, Feb 17, 2024 at 2:06 AM Tejun Heo <tj@kernel.org> wrote:
> 
> > @@ -4072,7 +4070,32 @@ static bool __flush_work(struct work_struct *work, bool from_cancel)
> >         if (!pool)
> >                 return false;
> >
> > -       wait_for_completion(&barr.done);
> > +       if ((pool->flags & POOL_BH) && from_cancel) {
> 
> pool pointer might be invalid here, please check POOL_BH before
> rcu_read_unlock()

Right, it had a local variable caching the test result from inside the
rcu_read_lock() section and I removed it by mistake while splitting patches.
Will fix.

> > +               /*
> > +                * We're flushing a BH work item which is being canceled. It
> > +                * must have been executing during start_flush_work() and can't
> > +                * currently be queued. If @work is still executing, we know it
> > +                * is running in the BH context and thus can be busy-waited.
> > +                *
> > +                * On RT, prevent a live lock when current preempted soft
> > +                * interrupt processing or prevents ksoftirqd from running by
> > +                * keeping flipping BH. If the tasklet runs on a different CPU
> > +                * then this has no effect other than doing the BH
> > +                * disable/enable dance for nothing. This is copied from
> > +                * kernel/softirq.c::tasklet_unlock_spin_wait().
> > +                */
> 
> s/tasklet/BH work/g

Updated.

> Although the comment is copied from kernel/softirq.c, but I can't
> envision what the scenario is when the current task
> "prevents ksoftirqd from running by keeping flipping BH"

Yeah, that sentence is not the easiest to parse. The following parentheses
might be helpful:

 prevent a live lock (when current (preempted soft interrupt processing) or
 (prevents ksoftirqd from running)) by keeping flipping BH.

> since the @work is still executing or the tasklet is running.

eb2dafbba8b8 ("tasklets: Prevent tasklet_unlock_spin_wait() deadlock on RT")
is the commit which added the flipping to tasklet_unlock_spin_wait(). My
understanding of RT isn't great but it sounds like BH execution can be
preempted by someone else who does the busy wait which would be sad. IIUC,
it looks like flipping BH off/on makes the busy waiting one yield to BH
processing.

> > @@ -4179,6 +4203,11 @@ static bool __cancel_work_sync(struct work_struct *work, u32 cflags)
> >
> >         ret = __cancel_work(work, cflags | WORK_CANCEL_DISABLE);
> >
> > +       if (*work_data_bits(work) & WORK_OFFQ_BH)
> > +               WARN_ON_ONCE(in_hardirq());
> 
> When !PREEMPT_RT, this check is sufficient.
> 
> But when PREEMP_RT, it should be only in the contexts that allow
> local_bh_disable() for synching a BH work, although I'm not sure
> what check code is proper.
> 
> In PREEMPT_RT, local_bh_disable() is disallowed in not only hardirq
> context but also !preemptible() context (I'm not sure about it).
>
> __local_bh_disable_ip() (PREEMP_RT version) doesn't contain
> full check except for "WARN_ON_ONCE(in_hardirq())" either.
> 
> Since the check is just for debugging, I'm OK with the current check.

We should have enough test coverage with !RT kernels. If you can think of a
better notation for RT, please be my guest.

Thanks.

-- 
tejun

