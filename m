Return-Path: <linux-kernel+bounces-148504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CCF8A83AD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF131C21AF9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061FF13D60D;
	Wed, 17 Apr 2024 13:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YdGzFwmv"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C07C13C3E0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359029; cv=none; b=kTpwqUZkVyMuHpYM5+LTVJ1J5MvWJ3PGggkQcAgWqfZ79hf7nKxmNMWZBSH7uvHfNVbpV3tXOSilxC5sVN1pJyAeQtHveJzokjJzzw9P/1qcvywrigeZyF9s/z0f7zjEIVc+ewJsLnKPWpbPBCLfEc5wytdl2hlOBFQt1DpO57k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359029; c=relaxed/simple;
	bh=p6eIUeILhXAGCgCt6mETi8QJIePkdSm4E+uCEJp4hJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ju17JyabcE1J/7T2fLoS7AUQauopR/qCFTktqUcm9nIsPfUc6r29rY19ywE5PnShYMzhoi2vxvgHWuS9YGzvHuYj7pf1YmlI/hB9wt/DW2rz0IUyWlA5XkPeEl/alMjVri8PDSE9J34R+Ob1+0iH5FH4N97duIVWty4u2HswZeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YdGzFwmv; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-346359c8785so4189281f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 06:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1713359023; x=1713963823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bYXUbvGplK26/DLuEVW07o3/H73ZeARH4JZzw1uQ1x8=;
        b=YdGzFwmvk/t5iKd7vHJMSJYgXbZeCUraB/CL21kuwk6NgQfzBRXu70DunstdAow1EW
         05Q+Vmi1l9sRtsPl6Xmb6g2zacNGpau0vGewJIWK9HMI0UA0Zn2jgYf6SaATIQIcGsOX
         pziQAQZI7iFw4olQJkkvwA/k2Bn+UXToUzN6b56yhvxS1Ls8k4/E6+oTAMsmcdmtcAPx
         TYK5PLC/Zu1krpMVGD1CwqOL01lCzagOjdBBp6P7hjA1dkZF+vYsi6GUumH5vZ5v9fh6
         O2tXKwM1wm3AZaasXRxY1bVENHaIphjKnQDnraiCJVQVvQ1VFRQF99w95bnk8Y2N1Ewu
         Xs9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713359023; x=1713963823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYXUbvGplK26/DLuEVW07o3/H73ZeARH4JZzw1uQ1x8=;
        b=PxjfNkQTAjMjJMAlVvJzG3farE0AjrS1MYc6oDMVBO5lEEE+xfXc4ac9PxNMD5/aMC
         uw833TMrPzyIGr8JY1hUvXlW+d1DVOS6anVNYzo9/h25t0YqRp06IdA51WrsdDg4O3+p
         6vZpzWkwdw58XWfNbjv1XAWzHufGD78n5a5jVLWSOnK5OtsNn0zJl3np62je58rsu+q3
         JBAOoKFgvl5TyVoOs+gzPKueXYltgmxBXmTyL/wk92HWDl1YSY3Ir6qahTm8d9pUzFyz
         iTkHzyVIFvywPjHZGST6Q4tw6NoTdhZjNh3EpfT7DBYxo+bfIjKy7Hte0UtGntA71ZUV
         n6AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS0B6cfl9m6FUSHQjB3nNx+0wzkw5/amEHv4G/k3f+h1md7dRbyBuOVMD1YcTRQy1PeMhKPYBRUp8Sa99gREAHPMS7DSgnfGoSx/65
X-Gm-Message-State: AOJu0YxkXPXLmKBtb/K3LiObnJdgCjMq9RbvkvvjYnp7sbtcgV9cI+CN
	g7AXQBreMjL+mA3enueYsz9b6HA66gF+UcpajolJ+0Hy0BC6Ux98BfOId917xn8rBIDoNgcGIUq
	I
X-Google-Smtp-Source: AGHT+IFoU1J1AGF3wFF5xhijCsDKNX4KrMcmA9VwsxrJb2V3Agvlvjtres5bxcGtUTFcCnxbpuzWUg==
X-Received: by 2002:a05:6000:912:b0:346:f79c:3256 with SMTP id cw18-20020a056000091200b00346f79c3256mr10198088wrb.7.1713359022793;
        Wed, 17 Apr 2024 06:03:42 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a16-20020adfed10000000b00349ac818326sm2126951wro.43.2024.04.17.06.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 06:03:42 -0700 (PDT)
Date: Wed, 17 Apr 2024 15:03:40 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v4 06/27] printk: nbcon: Add callbacks to
 synchronize with driver
Message-ID: <Zh_IrB4MyHwU8OJE@pathway.suse.cz>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-7-john.ogness@linutronix.de>
 <ZhUIatzxietD4F-m@localhost.localdomain>
 <87y19djqr0.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y19djqr0.fsf@jogness.linutronix.de>

On Tue 2024-04-16 17:07:39, John Ogness wrote:
> On 2024-04-09, Petr Mladek <pmladek@suse.com> wrote:
> >> Console drivers typically must deal with access to the hardware
> >> via user input/output (such as an interactive login shell) and
> >> output of kernel messages via printk() calls.
> >> 
> >> Follow-up commits require that the printk subsystem is able to
> >> synchronize with the driver. Require nbcon consoles to implement
> >> two new callbacks (device_lock(), device_unlock()) that will
> >> use whatever synchronization mechanism the driver is using for
> >> itself (for example, the port lock for uart serial consoles).
> >
> > We should explain here the bigger picture, see my comment
> > of the word "whenever" below.
> >
> > <proposal>
> > Console drivers typically have to deal with access to the hardware
> > via user input/output (such as an interactive login shell) and
> > output of kernel messages via printk() calls.
> >
> > They use some classic locking mechanism in most situations. But
> > console->write_atomic() callbacks, used by nbcon consoles,
> > must be synchronized only by acquiring the console context.
> >
> > The synchronization via the console context ownership is possible
> > only when the console driver is registered. It is when a particular
> > device driver is connected with a particular console driver.
> >
> > The two synchronization mechanisms must be synchronized between
> > each other. It is tricky because the console context ownership
> > is quite special. It might be taken over by a higher priority
> > context. Also CPU migration has to be disabled.
> >
> > The most tricky part is to (dis)connect these two mechanism during
> > the console (un)registration. Let's make it easier by adding two new
> > callbacks: device_lock(), device_unlock(). They would allow
> > to take the device-specific lock while the device is being
> > (un)registered by the related console driver.
> >
> > For example, these callbacks would lock/unlock the port lock
> > for serial port drivers.
> > </proposal>
> 
> I do not like this proposal. IMHO it is focussing only on nbcon
> registration details (a corner case) rather than presenting the big
> picture.

Fair enough.

> Yes, we will use these callbacks during registration/unregistration to
> avoid some races, but that is just one usage (and not the primary
> one). The main reason these callbacks exist is to provide driver
> synchronization when printing.
> 
> We want to avoid using nbcon console ownership contention whenever
> possible. In fact, there should _never_ be nbcon console owership
> contention except for in emergency or panic situations.
>
> In the normal case, printk will use the driver-specific locking for
> synchronization. Previously this was achieved by implementing the
> lock/unlock within the write() callback. But with nbcon consoles that is
> not possible because the nbcon ownership must be taken outside of the
> write callback:
> 
> con->device_lock()
> nbcon_acquire()
> con->write_atomic() or con->write_thread()
> nbcon_release()
> con->device_unlock()

This sounds like a strong requirement. So there should be a strong
reason ;-) I would like to better understand it [*] and
document it a clear way.

In principle, we do not need to take the full con->device_lock()
around nbcon_acquire() in the normal context. By other words,
when nbcon_acquire() is safe enough in emergency context
then it should be safe enough in the normal context either.
Otherwise, we would have a problem.

My understanding is that we want to take con->device_lock()
in the normal context from two reasons:

  1. This is historical, king of speculation, and probably
     not the real reason.

     In the initial RFC, nbcon_try_acquire() allowed to take over
     the context with the same priority.

     The con->device() taken in the kthread might have prevented
     stealing the context by another "random" uart_port_lock() call from
     a code which would not continue emitting the messages.

     But the current nbcon_try_acquire() implementation does not take
     over the context with the same priority. So, this reason
     is not longet valid. But it probably has never been the reason.


  2. The con->device() defines the context in which nbcon_acquire()
     will be taken and con->write_atomic() called to make it
     safe against other operations with the device driver.

     For example, con->device() from uart serial consoles would
     disable interrupts to prevent deadlocks with the serial
     port IRQ handlers.

     Some other drivers might just need to disable preemption.
     And some (future) drivers might even allow to keep
     the preemption enabled.


I believe that the 2nd reason is that right one. But it is far
from obvious from the proposed comments.


[*] I am pretty sure that we have had the same discussion during
    Plumbers 2023. I am sorry I do not recall all the details now.
    Anyway, this should be explained in public anyway.


> How about this for the commit message:
> 
> printk: nbcon: Add callbacks to synchronize with driver
> 
> Console drivers typically must deal with access to the hardware
> via user input/output (such as an interactive login shell) and
> output of kernel messages via printk() calls. To provide the
> necessary synchronization, usually some driver-specific locking
> mechanism is used (for example, the port spinlock for uart
> serial consoles).
>
> Until now, usage of this driver-specific locking has been hidden
> from the printk-subsystem and implemented within the various
> console callbacks.

So far, so good.

> However, for nbcon consoles, it is necessary
> that the printk-subsystem uses the driver-specific locking so
> that nbcon console ownership can be acquired _after_ the
> driver-specific locking has succeeded. This allows for lock
> contention to exist on the more context-friendly driver-specific
> locking rather than nbcon console ownership (for non-emergency
> and non-panic cases).

I guess that the part:

   This allows for lock contention to exist on the more
   context-friendly driver-specific locking

tries to explain the 2nd reason that I have described above.
But it looks too cryptic to me. I have got it only because
I knew what I was looking for.

> Require nbcon consoles to implement two new callbacks
> (device_lock(), device_unlock()) that will use whatever
> synchronization mechanism the driver is using for itself.


Honestly, I still think that we need con->device_lock() primary
to synchronize the console registration and unregistration.

In all other cases, we only need to know whether we have
to call nbcon_try_acquire() with interrupts disabled or not[**].
And we need to know this for any nbcon_try_acquire() access,
including the emergency context.

Maybe, we should pass this information another way because
we do not want to call con->device_lock() in
nbcon_cpu_emergency_exit().

[**] According to my last findings, we always need to disable
     preemption, see
     https://lore.kernel.org/r/Zhj5uQ-JJnlIGUXK@localhost.localdomain


I still have to shake my head around this. But I would first like
to know whether:

   + You agree that nbcon_try_acquire() always have to be called with
     preemption disabled.

   + What do you think about explicitly disabling preemption
     in nbcon_try_acquire().

   + If it is acceptable for the big picture. It should be fine for
     serial consoles. But I think that graphics consoles wanted to
     be preemptive when called in the printk kthread.


I am sure that it will be possible to make nbcon_try_acquire()
preemption-safe but it will need some more magic. Maybe, we could
do it later when really needed. The primary target are the slow
serial consoles anyway.


> P.S. I think it makes more sense to use your proposal for the commit
> message of the follow-up patch "printk: nbcon: Use driver
> synchronization while registering".

Yup, feel free to use it.

Best Regards,
Petr

