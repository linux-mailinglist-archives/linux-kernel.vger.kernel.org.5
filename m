Return-Path: <linux-kernel+bounces-28825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3AA830373
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98F121C23EB0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B787814A93;
	Wed, 17 Jan 2024 10:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4LowLd/C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pfH6KXdN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF38E1429A;
	Wed, 17 Jan 2024 10:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705487092; cv=none; b=smRpuxlHQHLrswI6FjHhYQy9JuvJLgbm7D7dDLRJ8G8wIARmErgkJ547GW36tpzULwC59CyLoruIFxjGbsUh9oOeowA6VqnLK+LhtefZFxwN0OFGACafWKw+T4mNonmmX7wfswgKp5TkJi1uu8ky6nvi9Qai+tb2JWGcMmCGzwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705487092; c=relaxed/simple;
	bh=YqEOUrfg8We4Z/uU2D6sdtwX7hJPwc174WZj5eopShE=;
	h=Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=ZKAFhB9hTbNFKaYYHas9RRNjGVX6byF3Tk9cMvCa1IBNMihAHmKdnrWEMX8jLIVnPCUgBydEmsRISm2YHXLSGDBgIlrPF0vCp+YiXIyyg4wpUmKtaxEF47IcWZMT8WN6BM2unirodnoR+VchBaTop2aPlXtAugVOy+tOo3nA5T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4LowLd/C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pfH6KXdN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Jan 2024 11:24:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705487088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6wBPLNOGkBTQln7J8+pZY7EWcp+BxJ8kTDDAKHKqHnc=;
	b=4LowLd/Ctq9/yY2o9Mk2IN7dxb7PoHxtXsmEGqeiOEudD+YT449Frgd7m4wWGY87Mi4MJP
	bOH73ORPXFrFc39CtbP2LbfVvGWb8YlwujTcBB2ooOz5NjKljqWaF1ftqQC+Qaqnhmix9/
	FJDjXN/rr3A4C1K04PfPsJ7HGXUUiebFRYJo7wqYTjqVjKWXx6xFGDiJeaGSWIhbXw2Yu9
	MNuSMiJfEXXvo1K1bDG5bOWAAsw7dBQzg5P8LzTeX8FIp5gKVI5ARXxpL60psIyvuKIH5e
	xEc6/ISy/o5Yvur+7d+u8Df/bSKWLq1tgoH3qD6XtFm6CnZzkRa8C1/CDtZPNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705487088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6wBPLNOGkBTQln7J8+pZY7EWcp+BxJ8kTDDAKHKqHnc=;
	b=pfH6KXdNuyuUlu4tjxmYhK4BphXthBi+yKxa1nA/aao7HlZ7Z6pKTnYbI3Qu2PeJqwLgRk
	OaV0gpKRIQefNCBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: John Ogness <john.ogness@linutronix.de>
Cc: "Chang, Junxiao" <junxiao.chang@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Li, Hao3" <hao3.li@intel.com>, "Li, Lili" <lili.li@intel.com>,
	"Gao, Jianfeng" <jianfeng.gao@intel.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: RE: [PATCH] printk: nbcon: check uart port is nbcon or not in
 nbcon_release
Message-ID: <20240117102446.itexUYMc@linutronix.de>
References: <20240117065226.4166127-1-junxiao.chang@intel.com>
 <871qagtlk2.fsf@jogness.linutronix.de>
 <BN9PR11MB5370065F4E7443FEA156347EEC722@BN9PR11MB5370.namprd11.prod.outlook.com>
 <87y1cos2dv.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y1cos2dv.fsf@jogness.linutronix.de>

On 2024-01-17 11:09:24 [+0106], John Ogness wrote:
> On 2024-01-17, "Chang, Junxiao" <junxiao.chang@intel.com> wrote:
> > There are several serial ports in one Intel ADL hardware, they are
> > enumerated as ttyS0, ttyS1, ttyS4, and so on. Multiple console options
> > might be appended to kernel command line. For example,
> > "console=ttyS0,115200n8 console=ttyS4,115200n8
> > console=ttyS5,115200n8".
> >
> > In this case, several uarts "cons" pointers are same.
> 
> So I ask again. Please explain how this is possible.

I have here
| 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
| 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A

and I have

| root        2315  0.0  0.0   5480  1792 ttyS0    Ss+  11:19   0:00 /sbin/agetty -o -p -- \u --keep-baud 115200,57600,38400,9600 - vt220
| root        2502  0.1  0.0   5480  1792 ttyS1    Ss+  11:20   0:00 /sbin/agetty -o -p -- \u --keep-baud 115200,57600,38400,9600 - vt220

and I can stop both of them without any trouble. 
Can this be reproduced on an ordinary x86 hardware given they have more
than one UART (up to four).
Is any of this ADL hardware upstream?

> John

Sebastian

