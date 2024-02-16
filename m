Return-Path: <linux-kernel+bounces-68326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8518578C2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 818D0B217AA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58EA1B966;
	Fri, 16 Feb 2024 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qFpPyopj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vqSY7Xwh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B360F1B95D
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 09:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708075388; cv=none; b=ra+NuklocwXWT1Fn/d9ASKrLNscIYUganAdzfyqacBMLQHKotDHjwzlgDVh4MSRQ4x5PlI5MS5ftCR90/sS/3hyQ+0tfbIK0NNQWdZx4Aob5O8E91sfRCOr8ocNL7eZuaYsilPuvpDYu+XaZ/SuVVZ/D+P1mvh4G6fk+U43tExE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708075388; c=relaxed/simple;
	bh=svr/tG93+IhRjX3JlqAVKVH56EQboOnBEuSSo7Dfcac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pV2xLHOK+YNulNncCbZirYyesbE05XzKzsTB2uI4u1H4fthc1WVcQ8JaN7N8XlB1Aw7QUy1/WqqCUsZjYVNnWdGSxDCTwUsqNu1Mo8XejyWTg6Vd/ySYHnvWaWjy93t9jMB/zMXHECU+Yjcw4XsYKBFT8g430Zk4B7Rs0RaMQ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qFpPyopj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vqSY7Xwh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708075384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=svr/tG93+IhRjX3JlqAVKVH56EQboOnBEuSSo7Dfcac=;
	b=qFpPyopjiaOKr9Bf6XrK720PVB0dMLOvho+du5tVdDUZ1qft8YwkL2JwBORKgnoIyWW3o2
	Rvlb2Sp0E0ZOGGNC+mixsuXB+778n4WSo6fBbM1gVrY/0g+igWlzArLL9aI8Yc+Im8WOec
	M5eLGOCTrAghca1mLE+6KufInx1CIMKCdZgYY68Jwm5lxEwl3lcPVAl8E+BO+8lRG1TgYW
	2Daj/cao8YTgxXvemqeNIA3xvPmQgJdl22C3VzBz+SdlYGsZO6+i+/IL80Ce+Hv5uqUjGN
	LAjl2OXjO6vwqN0hjk/wujaSPIrMrjTX4rzT+cw4jCLGlS7KZwyfxtH5Vxoi7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708075384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=svr/tG93+IhRjX3JlqAVKVH56EQboOnBEuSSo7Dfcac=;
	b=vqSY7XwhX8Xmi7zOWwE/1fj3g2KxcOJjLlJBPIBw+ZsZmUWyVuLvRwLYPf9CAexm7fQzTK
	Zn6X36wlEpDSw5BQ==
To: Stephen Brennan <stephen.s.brennan@oracle.com>,
 linux-kernel@vger.kernel.org
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Stephen Brennan
 <stephen.s.brennan@oracle.com>
Subject: Re: [PATCH] printk: save loglevel before console_verbose()
In-Reply-To: <20240216005128.1045812-1-stephen.s.brennan@oracle.com>
References: <20240216005128.1045812-1-stephen.s.brennan@oracle.com>
Date: Fri, 16 Feb 2024 10:28:46 +0106
Message-ID: <87eddcsqzd.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-02-15, Stephen Brennan <stephen.s.brennan@oracle.com> wrote:
> In panic() cases, console_verbose() is called, clobbering the
> console_loglevel value. If the bug which led to the panic related to
> printk, it can be useful to know the log level prior to the
> console_verbose() call.

I've done a *lot* of printk debugging over the past 6 years and have
never had a case where this would be useful (or even interesting).

I assume there is some rare and particular scenario you are trying to
debug. And once you've debugged it, it is no longer useful for you
either.

IMHO this does not warrant adding an extra global variable for all Linux
users.

When Petr gets back from vacation, maybe he will have a different
opinion.

John Ogness

