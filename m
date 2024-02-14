Return-Path: <linux-kernel+bounces-65107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5898547E2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68AC11F248C3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2F01B59B;
	Wed, 14 Feb 2024 11:14:46 +0000 (UTC)
Received: from gepdcl09.sg.gdce.sony.com.sg (unknown [121.100.38.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE94618E2F;
	Wed, 14 Feb 2024 11:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.100.38.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707909286; cv=none; b=VbFS34wa9CKuM1Gkn/dum9kSxzK3TtLPZAYpPFI49WwWDEQVr9/jqocbXlObkVWegpN77VTYbvbeqU6o/oRlYhhc7Vf6p056Umt5dRR169bU445zP+gAyC4MgEhPvt7aSbgViivrchYuewQ4bNFTiQNnnUNbYgDFEHuBg0ftOOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707909286; c=relaxed/simple;
	bh=l+i0yIxLpwQsUo4QfGAzTGFABUordW6G5AbZmrrcfq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hcgqxpawrug8kr1AdCwrUKFOZ2tVHoGLRopOwcOGHPNI/9D2wKD8+kPRKS0UAkYORTkBSWjxuu9q+o1UE/2CFbS39bnxPu0JLCxevwKhL5n4Nn52VdyDNuivIPHaL+bkHfPlqx4L+gstNcoRiEeOQV12YQb6AcyHQBjMVhbZ/ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; arc=none smtp.client-ip=121.100.38.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
Received: from gepdcl02.s.gdce.sony.com.sg (SGGDCSE1NS07.sony.com.sg [146.215.123.196])
	by gepdcl09.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 41EBE4g3027632;
	Wed, 14 Feb 2024 19:14:16 +0800
Received: from mail.sony.com ([43.88.80.246])
	by gepdcl02.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 41EBE2jV014297;
	Wed, 14 Feb 2024 19:14:02 +0800
Received: by mail.sony.com (Postfix, from userid 1000)
	id 6BA9420C089E; Wed, 14 Feb 2024 16:42:36 +0530 (IST)
Date: Wed, 14 Feb 2024 16:42:36 +0530
From: Sreenath Vijayan <sreenath.vijayan@sony.com>
To: Petr Mladek <pmladek@suse.com>
Cc: john.ogness@linutronix.de, corbet@lwn.net, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, rdunlap@infradead.org, rostedt@goodmis.org,
        senozhatsky@chromium.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        taichi.shimoyashiki@sony.com, daniel.palmer@sony.com,
        anandakumar.balasubramaniam@sony.com, sreenath.vijayan@sony.com
Subject: Re: [PATCH v4 2/2] tty/sysrq: Dump printk ring buffer messages via
 sysrq
Message-ID: <ZcygJOj9TaHZUKd-@sony.com>
References: <cover.1706772349.git.sreenath.vijayan@sony.com>
 <ca8dd18e434f309612c907d90e9f77c09e045b37.1706772349.git.sreenath.vijayan@sony.com>
 <ZcOdLrOPiPJmCec5@alley>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcOdLrOPiPJmCec5@alley>

On Wed, Feb 07, 2024 at 04:09:34PM +0100, Petr Mladek wrote:
> On Thu 2024-02-01 13:12:41, Sreenath Vijayan wrote:
> > When terminal is unresponsive, one cannot use dmesg to view printk
> > ring buffer messages. Also, syslog services may be disabled,
> > to check the messages after a reboot, especially on embedded systems.
> > In this scenario, dump the printk ring buffer messages via sysrq
> > by pressing sysrq+D.
> 
> I would use sysrq-R and say that it replays the kernel log on
> consoles.
> 
> The word "dump" is ambiguous. People might thing that it calls
> dmesg dumpers.
>

Ok noted. We proposed sysrq-D as it is an alternative to dmesg
command and might be easier to remember.
 
> Also the messages would be shown on the terminal only when
> console_loglevel is set to show all messages. This is done
> in __handle_sysrq(). But it is not done in the workqueue
> context.
>

Yes, the initial implementation was using write() of consoles
so the messages would be shown irrespective of the console log
level. The current implementation depends on the console log
level but many other sysrq keys dump the messages at KERN_INFO
level. In my understanding, __handle_sysrq() dumps only the
sysrq header at the manipulated loglevel. It restores original
loglevel before calling callback function for the key.
If console_loglevel is set to show KERN_INFO messages, it would
dump most of the important printk messages in our case. Also the
loglevel can be modified using sysrq itself now.
 
> Finally, the commit message should explain why workqueues are used
> and what are the limitations. Something like:
> 
> <add>
> The log is replayed using workqueues. The reason is that it has to
> be done a safe way (in compare with panic context).
> 
> This also means that the sysrq won't have the desired effect
> when the system is in so bad state that workqueues do not
> make any progress.
> </add>
> 
> Another reason might be that we do not want to do it in
> an interrupt context. But this reason is questionable.
> Many other sysrq commands do a complicate work and
> print many messages as well.
>

Noted. Will add this if we proceed with workqueue implementation.
 
> Another reason is that the function need to use console_lock()
> which can't be called in IRQ context. Maybe, we should use
> console_trylock() instead.
> 
> The function would replay the messages only when console_trylock()
> succeeds. Users could repeat the sysrq when it fails.
> 
> Idea:
> 
> Using console_trylock() actually might be more reliable than
> workqueues. console_trylock() might fail repeatably when:
> 
>     + the console_lock() owner is stuck. But workqueues would fail
>       in this case as well.
> 
>     + there is a flood of messages. In this case, replaying
>       the log would not help much.
> 
> Another advantage is that the consoles would be flushed
> in sysrq context with the manipulated console_loglevel.
> 
> Best Regards,
> Petr

Yes, this seems to work well from interrupt context when the
console lock owner is not stuck. We can also manipulate
the console_loglevel. Something like this:

//in printk.c
void console_replay_all(void)
{
       if (console_trylock()) {
               __console_rewind_all();
               console_unlock();
       }
}

//in sysrq.c
static void sysrq_handle_dmesg_dump(u8 key)
{
       int orig_log_level = console_loglevel;
       console_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
       console_replay_all();
       console_loglevel = orig_log_level;
}


The downside I see is that the user may have to hit the
key multiple times or give up trying if the console lock
owner is busy at the time of key press. This information
should probably be updated in the documentation.

Please let me know your opinion.

Regards,
Sreenath

