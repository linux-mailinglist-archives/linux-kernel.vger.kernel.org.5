Return-Path: <linux-kernel+bounces-83630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0355869CA6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46CB4B3363F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584B34DA0C;
	Tue, 27 Feb 2024 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XrpNhUgy"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052982134A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051969; cv=none; b=sG/tEowrW5ZvtB+IVsHQBW3kRSmlJqvG3xK5gogctBoFnFzfJ5uX+TzZFZNH98ZFmGYYFA6gIcDCUw4G6jW1r6Ypc2cSw6V7hPdznoDE3zz3mSE8TTDIHKJFVg7QfUsp2e+GO1Hv7w0pu93EMjf+yE4ZcHo5UrtJgLFo1/ECvEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051969; c=relaxed/simple;
	bh=xlmPnaNHy8yMIHTWM3WhW/APl1SH2uV8+82axZU9Was=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7MdU9K0NEV9OGWc5TKHYa3G9KhSLb4vBD7iO0ZqTvunpYvt31vzMa70R/4MfSUygW1ir82HnVAc5aYjFxqeMKmFYI3Se6XfVeeODmm4CCDe8Lbmml0whOtZ3Hvd6gtZoMq0GvZKFKqobBjMPC8pMkpVRnc57asdUwNKUb4gzgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XrpNhUgy; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-565d1656c12so4868391a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 08:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709051964; x=1709656764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HXhHbmeTX5WXT1A0USM7Nvv/xmsG3XDkg99U0G6m5g4=;
        b=XrpNhUgyzFu1WAOqUvabEfX+DbxJem+7SrauKUl/fITAw/Nhmgf4p2f5kisAaz4GX6
         k/Qp07oU8DrQM9c/iPQ8SiHY6aZRsRf+tocgEcJBQsp7fI//VKpLE7BXGn3FvOMvlt5Z
         KIlyybkmhqpdo7UKqJMamQP+z5IzGfkKnzXm/stJiNd9i2k2SPfGmY2CRVGw1xvPnfUu
         8gwRpda1M/29Tx1NAKllbQMZJ9hQ9WehWu3zdr4B2v1SEAEO76iSM4Q2+MTo9M9aqCUU
         BDeCW0hGMWsFavaKY5iEmPSkBzeQbbUwx1H32zLB3oVj1ODVLPFwEMQ9Xz75unV/JqQe
         KEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709051964; x=1709656764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXhHbmeTX5WXT1A0USM7Nvv/xmsG3XDkg99U0G6m5g4=;
        b=bSjIMn0TZpaxWqrRyWXanyfQ8oWkuN2nC1s6bfUwU/sIUNYWdkqp1MNYmS3K6bBAj4
         3VMS8ekWJ3/rKrt/5he+S6BgCFQOmW9YzIF4c6ET/dsxH2KLJWCoc4h1eMG9cKOoLO19
         whgsSIAZLWteixeXx71Ekd1sA+7hFHUS3N4vCi62LPMn9W7E2LmfMCYI/DH57puXVjZW
         5TwyXjUKan3BpiyQBxtaIjPjFsDIQHnqTwXL5fFDIPMfv0nzyNgH9W67dCTWmvvKLZud
         RGZZPuEjQvcZH0gD4oMawrH5rNWU4/WlSHdN01iz3FThEBDEpM+T/O7F67HcTwhhn3kc
         chqw==
X-Forwarded-Encrypted: i=1; AJvYcCWJw1iHcMA00LH4e3fGO2xzg6tqjm4Gv4C36s0ZNjG1oQztjRgSlfUf2Mn+ydQcH95H4MJ0gjuoRgsV4oigQ7p8wyRJXtwEGOU55bVK
X-Gm-Message-State: AOJu0YywB3n6PQW092ARNtPKI9hPve0zaLECWjVZdRbaoqGQ5dRGzlsX
	1bk3OKK6pkrMnfdU9zsA4FJYUKu+J0jLgkz8lXKERLeekanTjQHutO4rYDiYwqDBiO3VCHTDO+l
	v
X-Google-Smtp-Source: AGHT+IEcI2NYOsDQrYqOqdN7aP93cve7FbWwpHklFilLF8yov9GrtPBtNmQgVK4NckxhWsSjGwtPxw==
X-Received: by 2002:a05:6402:194e:b0:561:f2b1:a68 with SMTP id f14-20020a056402194e00b00561f2b10a68mr9036996edz.20.1709051964278;
        Tue, 27 Feb 2024 08:39:24 -0800 (PST)
Received: from alley (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ef12-20020a05640228cc00b005662f95fa6dsm897815edb.89.2024.02.27.08.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 08:39:23 -0800 (PST)
Date: Tue, 27 Feb 2024 17:39:22 +0100
From: Petr Mladek <pmladek@suse.com>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: John Ogness <john.ogness@linutronix.de>, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] printk: save loglevel before console_verbose()
Message-ID: <Zd4QOqvJpayKJPFk@alley>
References: <20240216005128.1045812-1-stephen.s.brennan@oracle.com>
 <87eddcsqzd.fsf@jogness.linutronix.de>
 <ae1c5559-4469-448c-87d3-ab458c3c8b24@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae1c5559-4469-448c-87d3-ab458c3c8b24@oracle.com>

On Fri 2024-02-16 08:02:20, Stephen Brennan wrote:
> On 2/16/24 01:22, John Ogness wrote:
> > On 2024-02-15, Stephen Brennan <stephen.s.brennan@oracle.com> wrote:
> >> In panic() cases, console_verbose() is called, clobbering the
> >> console_loglevel value. If the bug which led to the panic related to
> >> printk, it can be useful to know the log level prior to the
> >> console_verbose() call.
> > 
> > I've done a *lot* of printk debugging over the past 6 years and have
> > never had a case where this would be useful (or even interesting).
> 
> Hi John,
> 
> That's fair! The point of sending it upstream is seeing if anybody else
> uses this information or if I'm the only one :)
> 
> > I assume there is some rare and particular scenario you are trying to
> > debug. And once you've debugged it, it is no longer useful for you
> > either.
> >> IMHO this does not warrant adding an extra global variable for all Linux
> > users.
> 
> I've been seeing bugs (to be fair, on older kernels without the latest
> printk/nbcon work, which resolves much of this) caused by excessive
> printk logging & slow serial consoles.

Yeah, printk() might block a non-preemptive context for a long time.
The current owner is responsible for flushing all messages which
might be added by other CPUs in parallel. There is some logic to
handover the console_lock() but it is not reliable.

And yes, these problems should be solved by the printk kthreads.
Even though, they would not help in panic() when the messages
must be flushed directly.

Well, there is a patch in linux-next which would block printk()
on non-panic CPUs. It would help with some problems as well.

> In some of these cases, the
> loglevel was set low at boot but modified by an application, so it has
> been nice to know what the _actual_ loglevel was at the time of the
> crash, which I can use with the console baud rates and the log buffer to
> get an idea for how backlogged the console was at a point in time.

I think that systemd or an log daemon might be configured to
modify the console_loglevel set by the kernel during boot.
They do so during boot when the userspace services are
being started.

The value might be read at runtime either by:

  $> cat /proc/sys/kernel/printk
  4       4       1       7

or by:

  $> sysctl kernel.printk
  kernel.printk = 4       4       1       7

It is a quite confusing interface. The console_loglevel
is the first number.

I doubt that any userspace application changes the loglevel
later when the system is up and running.

> But of course, the console sequence numbers can tell us how backlogged a
> console is at the time of crash, and you can infer the log level to some
> extent from that. So I can see this not being as valuable generally as
> it is for my use case.

Setting the right console_loglevel is problematic. It helps to remove
problems with too many "normal" messages, for example, during boot.
But people usually want to see warnings, errors, for example,
from rcu or softlockup watchdogs. The sad thing is when printk()
and slow consoles make the stall situation even worse. Let's
see how the printk kthreads would help.

Finally, I agree with John that this patch is not worth adding.
It does not add much value for most users.

Best Regards,
Petr

