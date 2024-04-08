Return-Path: <linux-kernel+bounces-135208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F4289BCBB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 738DAB2399E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6332252F89;
	Mon,  8 Apr 2024 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dgj9G9WP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bopQl6Di"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E57E52F62;
	Mon,  8 Apr 2024 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571053; cv=none; b=IL0XfR3w5hIH5Bt09pTw05nyd7iJrhv6SkBahhgCTJ77yCFlqKRZ8/dNMp8gRD4zzIyZp9/wa5VFyQjA9NL+Ub40rInJpZeJBWsc+SWUIkGqYLbf0fPZUHzvE6G3ukTlXNTRkUAvniwhHThyG6OlrSjeIe2kb4BOyw41rz7/opM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571053; c=relaxed/simple;
	bh=B4rQPE94P3aujXloU7ftUrVf3lGbBt4puGB/YdeaHFE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NG+vGfvyLR13LHUzR/VRSyoWUxarBo1kRvz6cDR7hnIEBDvsBIFbzQwusnI5nd8nJTbClvLtnQGeH8PdV48YPay+/ZiXs/qqsbqO4JMX9O1KYJ842yrKlaAic3qppOLUsNyLs4YQDJPc6CErv5b/GSN9snK9ATdX4LzU67CUU24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dgj9G9WP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bopQl6Di; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712571050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xkuYcuI16dURy3oTi3zJG28xJKQbdmrLBH1vWgCz7x8=;
	b=Dgj9G9WP+bSK4rMhObFtbYpfW3CFTns2hMp3/BQguAFyiSjW1iQtIuI8IpUCxbRGLY4QeA
	wQKd9N6rp8cUhxhRiqYqle5RHZQ8XfvNaj8dH9WHrSN27OiakWWGSnZ4bqJ5f0x3m4/RNm
	/3opUAUF+miN9IcFbZuk6GRO7bDqLifIdm4bdz3VtT88Bfu/KDruhbTq7BdUwRVbO+TxSY
	2utdmpQLGWbB6kv3I7oMLONLHEWSU9mkwq8us5aXfd24FfhMMYFcIFMZrfnaZRIrHnT7Pw
	XpAgE0VMLlPKnamLGzal8TUGwUt6omzUqQFoxb0GI/o33G3hP6MJ5OBcwzaGKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712571050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xkuYcuI16dURy3oTi3zJG28xJKQbdmrLBH1vWgCz7x8=;
	b=bopQl6Di5DcfSGRbP1aL9LcUvKPgxqp13SEfcMBYNoI23bxRusn+QEJpJJFgvuaxqs8Krr
	dXW7ADwb9gkvKjBQ==
To: Paul Menzel <pmenzel@molgen.mpg.de>, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org
Subject: Re: NOHZ tick-stop error: local softirq work is pending, handler
 #08!!! on Dell XPS 13 9360
In-Reply-To: <354a2690-9bbf-4ccb-8769-fa94707a9340@molgen.mpg.de>
References: <354a2690-9bbf-4ccb-8769-fa94707a9340@molgen.mpg.de>
Date: Mon, 08 Apr 2024 12:10:49 +0200
Message-ID: <87o7ak411y.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Paul,

Paul Menzel <pmenzel@molgen.mpg.de> writes:

> Dear Linux folks,
>
>
> On Dell XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022, with Linux 6.9-rc2+ 
> built from commit b1e6ec0a0fd0 (Merge tag 'docs-6.9-fixes' of 
> git://git.lwn.net/linux) the external USB-C adapter Dell DA300 stopped 
> working (only the Ethernet port was used). Linux logged:

thanks for the report. Can you please provide a trace beside the dmesg
output? The following trace events should be enabled (via kernel command
line):

trace_event=timer:*,timer_migration:*,sched:sched_switch,sched:sched_wakeup,sched:sched_process_hang,irq:softirq_entry,irq:softirq_raise,irq:softirq_exit

Thanks,

	Anna-Maria

