Return-Path: <linux-kernel+bounces-127739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFDA89503B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E431F2701B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE37A6994C;
	Tue,  2 Apr 2024 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P+wvg4Xr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DU0xq7e6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905B8657B5;
	Tue,  2 Apr 2024 10:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054063; cv=none; b=m2hvFWAELyyWeLqWv4TuU4CKNI0lNclI+EM3N7JQ+KatEPKKZl9tyMes1G43K4EJRffTQxLZ6emY0d82BbqjWCIwJpF5oYzy95WOKKh1mFatafontaAsSUaiSQXkRwkA1tOP8aBXFfGhynnlbpfOhJngSSaI+rj5ObPRRGsD0d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054063; c=relaxed/simple;
	bh=Q4MlAhRm+AkBxTUeVkfth/yvDYTiPwojE4biBVagZF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjImjdoG4AuCJgfJusTzNBCCWhnKx/h43/HJK401KHH1kTkywfT4ThjHE0mDNETU3mCkmcek7GxGuiphFU6foUo1W6T6FRWB0/tZ1grsXZQj++uHD3nzxePyYqMP0SNe8ZPnGf5KZnCbFHyqwRaW0VtVDvoc7tyouBSwNE1Wjlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P+wvg4Xr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DU0xq7e6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 2 Apr 2024 12:34:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712054056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STfe/Rz3uPOTuqu4DrUcO9QjfwomKLwaXdLP6m2yfFc=;
	b=P+wvg4XrkSa8qrUqLFplrxzRc04v5G0AvSoJPkYGlnle/rjdCGNtOirGpbAtrYWaEZXYxt
	4MJNjH23Yd4yTmtC6fiUTr4j0YItovd5T8MM6bnEgHMaQd3WCYoVcqZJt98XClr1A2bQe2
	86VQaBn4BpbWfcBmBxUvBtS0TWVcPjz5xNjJ68Yg7zn5kErEW5RBvG/JnPBoNim7zKkTLj
	78kAn6brpoybVRsNrDCx9Yjbb2U7LYCZj13nQI4+NPCiAshU7C4wpu64BBEUVwNmIsEIhu
	MbcWc1vc4KSf48ABCVdipi6cgNLlfjGLDXIDQQNwJeOtHVrG4JrSXM0zo9pt4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712054056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=STfe/Rz3uPOTuqu4DrUcO9QjfwomKLwaXdLP6m2yfFc=;
	b=DU0xq7e60IJtZQNOzYay7B8VjNffiXJvrNL+NVaf3TXBUWY82qsg3vKThsIZFpW6m3IDhW
	k+pyEg7w0w0dUpDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
	Clark Williams <williams@redhat.com>,
	Juri Lelli <jlelli@redhat.com>, Derek Barbosa <debarbos@redhat.com>,
	Bruno Goncalves <bgoncalv@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: NMIs reported by console_blast.sh with 6.6.20-rt25
Message-ID: <20240402103414.KkkX5RuV@linutronix.de>
References: <ZfSfrzak9WS0ZFv7@thinkpad2021>
 <20240322122921.U3WRsO4X@linutronix.de>
 <ZgSvVCDja6yFCC0Y@thinkpad2021>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZgSvVCDja6yFCC0Y@thinkpad2021>

On 2024-03-27 19:44:20 [-0400], John B. Wyatt IV wrote:
> > where is this output from? The `ret' opcode usually does not cause a
> > trap. My guess is that the machine has been interrupted by an external
> > user at this position.
>=20
> Just before the sysrq that crashes the system.

so this is intentional.

=E2=80=A6
> > Side note: This is using early_printk, correct?
>=20
> I believe so, but it might be preempted? This is the part it stopped in.
>=20
> static void io_serial_out(unsigned long addr, int offset, int value)
> {
> 	outb(value, addr + offset);
> }

The function is invoked in NMU context so it can't be preempted.

> > According to this, someone issued a `crash' via sysrq. Why?
> >=20
>=20
> This is part of the console_blast.sh script that John Ogness sent me.
>=20
> Please see below:
=E2=80=A6

Okay. Then everything works as it should=E2=80=A6

> > > NMI Backtrace for 6.6.20-rt25 no forced preemption with tuned through=
put-performance profile
> > > -----------------------------
> >=20
> > This and the following backtrace shows the same picture: The CPU is
> > crashing due to proc/sysrq request and does CPU-backtraces via NMI and
> > polls in early_printk, waiting for the UART to become idle (probably).
> >=20
> > I don't see an issue here so far.
>=20
> Luis Goncalves discussed it with me after reading your response. Thank
> you for your help. The NMI was needed to flush the buffers upon the
> system crashing itself. Does this part about NMI watchdog need to be
> documented?

Not sure about that one. There is an _a_ _lot_ to be printed from NMI
and the NMI watchdog might trigger if nothing is triggering the
NMI-watchdog during the print job. Also, the crash was requested.

Sebastian

