Return-Path: <linux-kernel+bounces-29995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5257831665
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7590F1F23425
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373AC208AE;
	Thu, 18 Jan 2024 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jeKWojFv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LmHSGiMc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774791F951;
	Thu, 18 Jan 2024 10:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705572340; cv=none; b=MlAYmEIOt/k3wGTJ/MnxsAUK8rSum8WA2+j+zM/Q0q/CtC2qDDpNcgohpO1G/rC0WB41M80O/Zj1vV88NqeFRxFkHNGV+blQAtkWHjlTYBrtyEsAeWfBCko7VYNKi4XJJ6Rx0fwlVwIVIMFKUGPMLQskzZXIkQRYATfvC3fGnl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705572340; c=relaxed/simple;
	bh=hEDpkWKYdCUozZVhNgkCxtKawEDN121YeJ3ex11tiD8=;
	h=From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type; b=enia/FD4yAh8r688bwOIoCTzjkoRdPFPTLZyIzDEpGjRCJtunr+26HlMHjbcj8hA5rtAsNvA6fEaD9YHKJ9BXXegf7fuWifgSqafVmYqTRx2IOO9/l+7vL39Y/zmPh2USsYMoegK91LEK+474zW6Nh5YdC0xWMffy9CElDfsChw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jeKWojFv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LmHSGiMc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705572328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hEDpkWKYdCUozZVhNgkCxtKawEDN121YeJ3ex11tiD8=;
	b=jeKWojFvbaF/wh7/AlP9tuOuOPdwNzAU349h4xctVPcY4ren0B2NdZl3WKkdBkyA/Q8iYJ
	VFutwJS0YiOS/I89EiUdp69FgknAutp4jUGsE9nDKaeTQTejfev3bZUezIQOnJArOh3ddU
	iYNgpELBJm6ww6af3eYPSYyEr08mVIJL/Bk5KSlrGzuXrsBXx1qEN87qsxYofRFCWrsm+s
	H7OHPujOziF/Xc8B/3bZE2+GiPhIz+6QQPTaFrjY/LqFzsSf2IP1yLZ6BspAp/DCqXkjgh
	X+xBerk+pXBvBV7PJ2FReGucifDpliRCl1lNLE4N66/mxoUTEn6Y0wN2RrLnCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705572328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hEDpkWKYdCUozZVhNgkCxtKawEDN121YeJ3ex11tiD8=;
	b=LmHSGiMc9vDiLrpTw0No9fYBbraY19ibzOZe72TFgg9DkVrF9PmApnwpa906vdQG+N79Fs
	Cj+90yytExTxk9CQ==
To: Sreenath Vijayan <sreenath.vijayan@sony.com>, corbet@lwn.net,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, rdunlap@infradead.org,
 pmladek@suse.com
Cc: rostedt@goodmis.org, senozhatsky@chromium.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, taichi.shimoyashiki@sony.com,
 daniel.palmer@sony.com, anandakumar.balasubramaniam@sony.com,
 sreenath.vijayan@sony.com
Subject: Re: [PATCH v3 2/2] tty/sysrq: Dump printk ring buffer messages via
 sysrq
In-Reply-To: <57daf43c5270f7532b269b9f0e90d126ca012354.1705331453.git.sreenath.vijayan@sony.com>
References: <cover.1705331453.git.sreenath.vijayan@sony.com>
 <57daf43c5270f7532b269b9f0e90d126ca012354.1705331453.git.sreenath.vijayan@sony.com>
Date: Thu, 18 Jan 2024 11:11:27 +0106
Message-ID: <87il3rardk.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-01-17, Sreenath Vijayan <sreenath.vijayan@sony.com> wrote:
> When terminal is unresponsive, one cannot use dmesg to view printk
> ring buffer messages. Also, syslog services may be disabled,
> to check the messages after a reboot, especially on embedded systems.
> In this scenario, dump the printk ring buffer messages via sysrq
> by pressing sysrq+D.

Note that using sysrq+g with kgdb or kdb it is already possible to dump
the printk ringbuffer messages. However using this new sysrq+D is much
more comfortable, less intrusive, and generally safer.

I have no problems with this change. But I guess the tty maintainers
will need to speak up about extending the sysrq list.

John

