Return-Path: <linux-kernel+bounces-81054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E10386702E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 562E3B25F0D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F46F5676C;
	Mon, 26 Feb 2024 09:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WxB6hAmH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wJpL+/Vd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB2E56749;
	Mon, 26 Feb 2024 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708939718; cv=none; b=bMVONVjpi/sJvmc4GBGsTEYgNalbXHHb6j4M+SHsOHdAGT8Z11fxNHPpTRfbz9m9+GwdIUGI5BrlyYkpxCEEl2fITZqZe+1Up0csS50iXM0xG3VIxxMpHvnJoWlD+kOiNy2wZeKOb/n40xoqLjUZh3NnbsI9c+hhZD8V7lHhmbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708939718; c=relaxed/simple;
	bh=IMfTdzaYr23cn0GQ+nOjzHAnQKCPCy/ZeIIVITUuN7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sxvegcx3JB1sUS47lOb2I3PrHtFR2w7K187tg9MObf+jAa/Qi0dmsQzvZByB2uZSY0sAYWlEXjMO+ucqgz8yRXE4wTFXkxkk+PWlbhXvMmUb9qZjW2i7vKYNnqIdgmt+Q4i0locH9PISEsRPZpBtv2XvdCZB38p0KDlG9VVOJ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WxB6hAmH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wJpL+/Vd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708939714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GBE6bUQOSsuuwgeWOC5yzNo9MZMN9zrmK6wDaJAswtw=;
	b=WxB6hAmHsN5nXTRaoxI0wwzAxSYoXjJUJC+BEFAIsAu1a8D23Lzv0bIxAWeZEfPhTT+bfi
	g4H7vli3yzu6aXk0Ey4g35Sqvwkto56lo7WyBuT4hwd2/WBgu50N1nVR6lcIdum9mUPWk4
	3xL7Iv2Ax4wEtKKS5ZJ+A2MtzHulqtnukWTb++mQHLkFZhp7f1bwHkx+7ahhM7khw5nGJe
	hj8gyEvA7THyBZ4IM1LyI7PPPN/rIHhN3X8+TsvUY5FTPEMxwopNGHP/CKfCPG/Gn/IXxf
	+dncYE4K4eI396ykm/KG1Hu3sTamxq0ujglxzwkhVXEb9UIa6QqHnnyOlpfpMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708939714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GBE6bUQOSsuuwgeWOC5yzNo9MZMN9zrmK6wDaJAswtw=;
	b=wJpL+/Vd0VEo4M4ljrH9RCLTzSb+n5rMWny6rWKGKI6tgFZIHPSV7wKUtbgJnjAbT6egx0
	oFRhN7no7T1uYJBw==
To: Sreenath Vijayan <sreenath.vijayan@sony.com>, Petr Mladek
 <pmladek@suse.com>
Cc: corbet@lwn.net, gregkh@linuxfoundation.org, jirislaby@kernel.org,
 rdunlap@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, taichi.shimoyashiki@sony.com,
 daniel.palmer@sony.com, anandakumar.balasubramaniam@sony.com,
 sreenath.vijayan@sony.com
Subject: Re: [PATCH v4 2/2] tty/sysrq: Dump printk ring buffer messages via
 sysrq
In-Reply-To: <ZcygJOj9TaHZUKd-@sony.com>
References: <cover.1706772349.git.sreenath.vijayan@sony.com>
 <ca8dd18e434f309612c907d90e9f77c09e045b37.1706772349.git.sreenath.vijayan@sony.com>
 <ZcOdLrOPiPJmCec5@alley> <ZcygJOj9TaHZUKd-@sony.com>
Date: Mon, 26 Feb 2024 10:34:06 +0106
Message-ID: <87h6hvmv6h.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-02-14, Sreenath Vijayan <sreenath.vijayan@sony.com> wrote:
> //in printk.c
> void console_replay_all(void)
> {
>        if (console_trylock()) {
>                __console_rewind_all();
>                console_unlock();
>        }
> }
>
> //in sysrq.c
> static void sysrq_handle_dmesg_dump(u8 key)
> {
>        int orig_log_level = console_loglevel;
>        console_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
>        console_replay_all();
>        console_loglevel = orig_log_level;
> }

Note that there is already a sysrq 0-9 to change the loglevel. That may
be more appropriate.

John

