Return-Path: <linux-kernel+bounces-49928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A4F8471AA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F4E1F25D57
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3C513E204;
	Fri,  2 Feb 2024 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cyugpSWw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RCALL4gs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A4D7CF10;
	Fri,  2 Feb 2024 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706883178; cv=none; b=R5blcnydWcaN98c2n1Jaz4+IBfFOe7aEL1J7smXb6hLzd5Zv4ekZnDFyELTj/YoinanK45Orf1XMrnsdbt9aLjC2R1k1Sz83WTCz166b+G7USlfC2i4LfE1+8A+EcfpiMf4JJPDMgqtwxSzgHbOT+Cmi/jELX/FwHi8hmsSft08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706883178; c=relaxed/simple;
	bh=f5YKe3WMy628KgG7tbI3qgfPJacBwbHrVJ9RjrxaFGo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G/tLstf5oiQbzHRKut6qlVG8XbiS/9nZHlekKdyDDDKjvNRS2WlYrXwb4gZxJRhtnMl1Ov+CUZcoER/sIszYzldMX6kXnT7mcmtVpvPSGqVaFywXy7bos+jDPTSOG5EGGZFBAmRJGUu1ViRB0D4khhdcLAfss3rCOisMjlUAM1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cyugpSWw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RCALL4gs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706883173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ij6oDiAkJUq8zd7Ne/5DNIcQE+6hx5NUe30iVeKaeds=;
	b=cyugpSWwEO0wfeMAT251N9WbpgpEJDip9egujvXj09IhlEWunJ6JVoKo+N81zbnuwhUZY5
	AH14ryU2lrXdm+H0VzjAt7hDlX5Cutphup1qSJA6P1RpZABSfZHCiWI+mpatwaK0UXd1lJ
	f5LPaOHZ9c1+oiJnmpZReYa5OW4o2qCqCS+LqxwGIhadJLcPSOJkp5MZEXZpO3aIboTbmc
	uyHL8DqzqbaFd+lUyegACeoNpCvNE+tfkkc5szVnEVMDp1HgFJkUG/psjrVqmLXpih2mEM
	k91jslZL5mQhlRj47ym8oGJeAxT4NKbSpjz5RHagq2n1Hd+JMvRg5v9n+FIHNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706883173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ij6oDiAkJUq8zd7Ne/5DNIcQE+6hx5NUe30iVeKaeds=;
	b=RCALL4gszeocsYD5hgxqbJcFi8DLy4ZkwbKkxcCSJk11jZLxvKMo+lqdZBVPXzPJziCxPJ
	oXjN9osEQbjUIoAw==
To: paulmck@kernel.org, Tejun Heo <tj@kernel.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Petr Mladek <pmladek@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org
Subject: Re: [BUG] workqueues and printk not playing nice since next-20240130
In-Reply-To: <410d6a87-bf34-457e-b714-1e6149d48532@paulmck-laptop>
References: <410d6a87-bf34-457e-b714-1e6149d48532@paulmck-laptop>
Date: Fri, 02 Feb 2024 15:18:48 +0106
Message-ID: <87le83ara7.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-02-02, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> So the system really did boot and is running just fine.  It is just that
> there is no console output.  Details, details!
>
> Is there anything I can do to some combination of workqueues and printk
> to help debug this?

The printk ringbuffer contents would certainly be interesting.

If you build the GDB scripts (CONFIG_GDB_SCRIPTS) then you will have:

(gdb) lx-dmesg

As an alternative, you could copy the contents of
Documentation/admin-guide/kdump/gdbmacros.txt into your .gdbinit and
then will have:

(gdb) dmesg

There may be some hints in the kernel log as to why there is no console
output.

John

