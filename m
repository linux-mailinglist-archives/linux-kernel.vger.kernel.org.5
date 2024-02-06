Return-Path: <linux-kernel+bounces-54709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B468A84B2B9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F4128A169
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A207338FA1;
	Tue,  6 Feb 2024 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sI6JEwa2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a8upz2Iz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B83C1EB2B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 10:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707216362; cv=none; b=mmEbF2AgA9A/BTaoA6xUR7HcZDZXm5tuX1RnPIRUJGlatgch4/CJUhLJJQbH6MkwFMcTRE+yjH06eZ0LSpsp6OyI765N4KquHFKLdmk2LBqYJ1Ws5XkWaIWRek77H+QNMtjYOUBVALgpV9SVN35HsvSOkWDdtnI9yRZYDnTBpQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707216362; c=relaxed/simple;
	bh=Qb+UQ65FDDvRjIOjrulbZQv61mUC3gZRLJFgkOLRTOE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uLVi8+/sPYTbl5Jmt1TmwhSIJLMhGz3wvwRsoys8IUWxm1O8eT0rPbTa2buXXcipR4dDGw7aclxsKVNqJ0CUUCiESeBzb9FraAblhQMIQP1PyejPB9fehHwzBS/sAlRk/NKCaz2VeFPFzh6MfvkfTUbdXa8QOgWQ4FSvIUZgbJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sI6JEwa2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a8upz2Iz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707216358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qb+UQ65FDDvRjIOjrulbZQv61mUC3gZRLJFgkOLRTOE=;
	b=sI6JEwa2QxvmSgg59qQHMO/5LokVd21+thiYf5XDhrDkuwnMJ4ryu+peG4n3ZMefneKFun
	omDq+bd50iKhGs9J/g9xv0rlWnunIFsFEm5AEmI/BF7V3vn1L/spjx5Wvb8J4uekYbHQxO
	2HZzboTEJKadtDBEk8D0bfUZ8phHTK1DCxAwhXn0r9/5pM3nlAd6PoJLgKh9JfSq/c0qMj
	lsoffzXJ8FhtMRcggzAqeoEbi1iSsKEMhNFsdo5/OEG3ebUWipb1s7n2h5YnxUbN7vtAR/
	GeJvySM1miErGxh2e4cMdqJoOnR4DtUOhODcxWB1PakaQrtp52qkRQMXI7rRLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707216358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qb+UQ65FDDvRjIOjrulbZQv61mUC3gZRLJFgkOLRTOE=;
	b=a8upz2IzsWKsdKpjzxKCb+ekcyuzwR+Ibn+TpJy+TT1+IH9BxqpZPeESQUKKMsoYVXqS88
	ZBNX6JuUUUy8mnAw==
To: Petr Mladek <pmladek@suse.com>, Douglas Anderson <dianders@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Li Zhe
 <lizhe.67@bytedance.com>, Pingfan Liu <kernelfans@gmail.com>, Lecopzer
 Chen <lecopzer.chen@mediatek.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] watchdog: Better handling of concurrent lockups
In-Reply-To: <ZcIGKU8sxti38Kok@alley>
References: <20231220211640.2023645-1-dianders@chromium.org>
 <ZcIGKU8sxti38Kok@alley>
Date: Tue, 06 Feb 2024 11:51:50 +0106
Message-ID: <87ttmlan1d.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-02-06, Petr Mladek <pmladek@suse.com> wrote:
> I have just got an idea how to make printk_cpu_sync_get_irqsave()
> less error prone for deadlock on the panic() CPU. The idea is
> to ignore the lock or give up locking after a timeout on
> the panic CPU.

This idea is out of scope for this series. But it is something we should
think about. The issue has always been a possible problem in panic().

> AFAIK, the lock is currently used only to serialize related
> printk() calls. The only risk is that some messages might be
> interleaved when it is ignored.
>
> I am not sure if this is a good idea though. It might create
> another risk when the lock gets used to serialize more
> things in the future and a race might create a real problem.

With the printk series we are currently working on [0], only the panic
CPU can store new printk messages anyway. So there would be nothing to
synchronize against (and it could be safely ignored).

kgdb uses the same technique to quiesce the CPUs. It does not use the
printk_cpu_sync for this, but it is an example of a possible future
usage not related to printk.

My vote is to make it a NOP for the panic CPU and then keep an eye on
any future uses. Should I add this to v4 of [0]?

John

[0] https://lore.kernel.org/lkml/20231214214201.499426-1-john.ogness@linutronix.de

