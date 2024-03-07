Return-Path: <linux-kernel+bounces-95673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF44875120
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69AB0286EF3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06D712DDAA;
	Thu,  7 Mar 2024 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UYEbyFS/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G+z+EPcb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E16712D753;
	Thu,  7 Mar 2024 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709820059; cv=none; b=BV69cTCUbbDdLtjLEihuKZZigWTCWBSCG1JK89uXQ3UeQGWnJp44yex/2gX5jeUaZsrM/6xybjKWFU8t+ADN3VQrHnwktFz/LAgpJ1AyYmMpu5/OWdAwlYPiAYXu9Vr28/KQ1TFq0Bcv0aynXk3vYkpvtofl7oP70IdFjTy/ICY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709820059; c=relaxed/simple;
	bh=vALcGQF1plJJ8B/ZtUQvvHBz+XmwU3FidOL/BO6pNac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=asJKYx4v8w6vMfR9Bux//FO+m9M1Bc8+o0eaWrP9JBus6xdApc/Mktur2GKBb+EWZR2EfVs5htWVolID/Q3m6PAIsnDFF4Na6U99mcyZZsfsQxJ0vvTdqrui/VMZ5VcY11XOpAUhpmFtFocdpNNwO2RvKeyHRw+OZr8MHM5HsFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UYEbyFS/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G+z+EPcb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709820055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8p7w7uyYIIhVOp8pjBiIgxh/TRc9ivPrHnvnX8VxwEI=;
	b=UYEbyFS/kfEHTHhY5HvuxQ8VjNsX/YK17Gjf2xfDGRDQx98yiooJn5wt7qqN7LyX26ucem
	6qQ348SwIf2nfhLzPvrpI8wxjIO8UCW8HuLUtX5mI2/2qd2NacDsBULiT3i3CyqpwVpJD6
	Vq33uhuvWy7j9OM+vwh2kR2tDaSWbqbJ1XQfZMSUbk9hizC8GfEISLaWpKSTlwhXrckjQR
	hi3SrMAdkcnJIKHniaCd3dpRBB+e3s/b03IYmECUyp8A/5KiM+bZ6uyx6gv0QzlEehUpge
	GH6rQ8z9861qsK17OSLeJDEudz9fdkHwW3vnvOATh2HDS/gaVxmCxAaFmgMZXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709820055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8p7w7uyYIIhVOp8pjBiIgxh/TRc9ivPrHnvnX8VxwEI=;
	b=G+z+EPcbKK5WrAONm8glGcndWD2cUeXGV3yXrXuFfdtkQdLkDlPLR2vsx/u0aa/HegMunG
	9RyGDHbscyCPLuBQ==
To: Sreenath Vijayan <sreenath.vijayan@sony.com>, pmladek@suse.com,
 corbet@lwn.net, gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: rdunlap@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, taichi.shimoyashiki@sony.com,
 daniel.palmer@sony.com, anandakumar.balasubramaniam@sony.com,
 sreenath.vijayan@sony.com
Subject: Re: [PATCH v5 2/2] tty/sysrq: Replay kernel log messages on
 consoles via sysrq
In-Reply-To: <bf9829e1b3785aca8b7e2d018fac0935522d00dc.1709277332.git.sreenath.vijayan@sony.com>
References: <cover.1709277332.git.sreenath.vijayan@sony.com>
 <bf9829e1b3785aca8b7e2d018fac0935522d00dc.1709277332.git.sreenath.vijayan@sony.com>
Date: Thu, 07 Mar 2024 15:06:17 +0106
Message-ID: <87wmqe87m6.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-03-07, Sreenath Vijayan <sreenath.vijayan@sony.com> wrote:
> diff --git a/Documentation/admin-guide/sysrq.rst b/Documentation/admin-guide/sysrq.rst
> index 2f2e5bd440f9..8098a1b4908d 100644
> --- a/Documentation/admin-guide/sysrq.rst
> +++ b/Documentation/admin-guide/sysrq.rst
> @@ -161,6 +161,8 @@ Command	    Function
>              will be printed to your console. (``0``, for example would make
>              it so that only emergency messages like PANICs or OOPSes would
>              make it to your console.)
> +
> +``R``	    Replay the kernel log messages on consoles.
>  =========== ===================================================================
>  
>  Okay, so what can I use them for?
> @@ -211,6 +213,12 @@ processes.
>  "just thaw ``it(j)``" is useful if your system becomes unresponsive due to a
>  frozen (probably root) filesystem via the FIFREEZE ioctl.
>  
> +``Replay logs(R)`` is useful to view the kernel log messages when system is hung
> +or you are not able to use dmesg command to view the messages in printk buffer.
> +User may have to press the key combination multiple times if console system is
> +busy. If it is completely locked up, then messages won't be printed. Output
> +messages depend on current console loglevel.
> +

I recommend including a reference to SysRq [0-9] about changing the
loglevel.

>  Sometimes SysRq seems to get 'stuck' after using it, what can I do?
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index 02217e3c916b..c4deea41a8b5 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -450,6 +450,17 @@ static const struct sysrq_key_op sysrq_unrt_op = {
>  	.enable_mask	= SYSRQ_ENABLE_RTNICE,
>  };
>  
> +static void sysrq_handle_replay_logs(u8 key)
> +{
> +	console_replay_all();
> +}
> +static struct sysrq_key_op sysrq_replay_logs_op = {
> +	.handler        = sysrq_handle_replay_logs,
> +	.help_msg       = "replay-kernel-logs(R)",
> +	.action_msg     = "replay kernel logs on consoles",

If I do:

$ grep '\.action_msg' drivers/tty/sysrq.c

This is the only action message that begins lowercase. Please start with
a capital letter for consistency.

With the change to the action message:

Reviewed-by: John Ogness <john.ogness@linutronix.de>

