Return-Path: <linux-kernel+bounces-30001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D02B831686
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2A70B21B73
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911E4208A6;
	Thu, 18 Jan 2024 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="00BPwWzh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OhyBShu3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D0720B01;
	Thu, 18 Jan 2024 10:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705572899; cv=none; b=qthGXFc7mAum8KuWrzxpu3vHss9kLQccuDchEni1H1Alf/F9Pb+teMmFxh+CTMMF8HMgMlhLG0tdCuZjH/M8vLQc8px8uq+0/l/aS8rMthhLrBPiL/a2m8py8fcHnJTM6uPmEsdeM7Cw4xkqEJj1ejKVqoumcQP/65H2k9MmYtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705572899; c=relaxed/simple;
	bh=khhLqmve9Id0BgYdRyMNy+0ycxyLazuWpvl/uJGui2g=;
	h=From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type; b=lXHqzDSTDHYCWL7K1MqxBVfdaJFKq5BAEwresor8mArEmJe4mnu0cIpbeRpNTAdXysTVGkQkZCe0DeCDZSZpZsWsOtHdH5VM/du4aQBMi2cwWxoHryYKiCGyHcloKMegXfwx0b5LTw178wCdRt0Z2k4U+CExrlIIAqi8PE1h3oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=00BPwWzh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OhyBShu3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705572895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JzaKwCLLcrV0lAUYdlCr9JKsNWWBaBuoPxIK1F3gv1E=;
	b=00BPwWzhkm3L0MmROW6y6HEAbXbRET4sA0iC4Ai+lQv/jzdbl6G34U8dq8Pn3jZs273ZCv
	jRfhj0P6znPdKYDQrSt5Zif98zDwD9BrD9lXcwdg339ojVdSCOb59sbOlq06APX/HVDr60
	kZ8easq3iyu0BHyPy+ap7CceMr/hLd5ZhgWTb4s9M99CECwPoYgCVPNoe2CICOeUuMtnOR
	l5MBvzUU0UNhDcO1sw5VNYvczARNX7wfenFF+zfmJzH1RKD1GhDahNZp+Q2OYSbM9b+l6h
	enBYTToQzEtWNsNxJegZOXJaUhuaJ1bghnjr9dhUTMfz9F2gfMnnzHwKC5LDlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705572895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JzaKwCLLcrV0lAUYdlCr9JKsNWWBaBuoPxIK1F3gv1E=;
	b=OhyBShu3/6Q8I7chxynESX5SoYFTFP7rL4vBWYHnn8kw6OFW3gCs8YvDfD25+ChfzGY85O
	AQlsAppiMfXfY+Bw==
To: Sreenath Vijayan <sreenath.vijayan@sony.com>, corbet@lwn.net,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, rdunlap@infradead.org,
 pmladek@suse.com
Cc: rostedt@goodmis.org, senozhatsky@chromium.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, taichi.shimoyashiki@sony.com,
 daniel.palmer@sony.com, anandakumar.balasubramaniam@sony.com,
 sreenath.vijayan@sony.com
Subject: Re: [PATCH v3 1/2] printk: Add function to dump printk buffer
 directly to consoles
In-Reply-To: <87le8nas4f.fsf@jogness.linutronix.de>
References: <cover.1705331453.git.sreenath.vijayan@sony.com>
 <402f0cbc3a573503c7cc794113aa5137ed7f276c.1705331453.git.sreenath.vijayan@sony.com>
 <87le8nas4f.fsf@jogness.linutronix.de>
Date: Thu, 18 Jan 2024 11:20:54 +0106
Message-ID: <87fryvaqxt.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oops, for the current mainline code it is actually even simpler because
the console_unlock() will perform the flushing:

void dump_printk_buffer(void)
{
 	console_lock();
 	console_rewind_all();
 	console_unlock();
}

John

