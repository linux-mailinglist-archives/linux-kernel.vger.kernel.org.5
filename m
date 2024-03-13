Return-Path: <linux-kernel+bounces-101557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E329587A8AB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907E61F2466F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7839D41238;
	Wed, 13 Mar 2024 13:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J1KVgT+H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W1urmu50"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638954174A;
	Wed, 13 Mar 2024 13:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710337610; cv=none; b=JPMb/ZNvxmYJcZ+iRS4B/w/4H05qWQXOdsVIIS9Q4bnk9WIEBI141U+m80F3bZ+QnWr3MCKbBFnZLeuHQnnZboYJPBaHKUZZz3I5ODmecEuzBBpLSxjSqPDuzvp/9AUdh/mfnNDvuTazN4zFstqlz5QzhdWkupG6iBa3Atv3YO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710337610; c=relaxed/simple;
	bh=vIjAdfBoiWL33bZ0WTDYgYhPbH4wUcMAQ5Y8wEr1dZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgviVFqb0d9VAcCnx6b64XHvSldqqPEUBW0CPegvcSuAeYhzfeTapOxPP+seGqFmEMI7y1z80R4nzfjaLHj2jRhirD1Rce681qNC0W8sjuyIVNX2kzE8KUzH0PtPy/MLVH8htWWsrcKsV01eRpQWHK6fvEbF+nkF/JJGUksiGi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J1KVgT+H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W1urmu50; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Mar 2024 14:46:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710337607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vIjAdfBoiWL33bZ0WTDYgYhPbH4wUcMAQ5Y8wEr1dZY=;
	b=J1KVgT+H/VBL8Agxtd3g3sdQEzrXIQCmmgC3w0ULmKRAro3/j4L9H3Gay8WHXFA7sIFsc9
	L5Hdx7X3dY8JXM55fuYBhZfzR7xbh4agBFaLwpl7QRN+Q4E2K8YeHqlVfUV+03R3t+qO6I
	3V0R6JXK/Vp+TecJ3zTb+hvR61wOZj/1BJ8FtJrkHRHjGWYsgbO3dXGN8F1QfuF3hR2L/M
	RyMv8SnSLCMKAQPpwdcKpzEnOt1T2stcSxy38finxf63UjMH07uYRIidk8dhPX78DgZSh4
	Kl0Z89JWHMTUpylW+thitV5soAJqvgbndIila2qyVAny64jmK8XkIlMdihuvSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710337607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vIjAdfBoiWL33bZ0WTDYgYhPbH4wUcMAQ5Y8wEr1dZY=;
	b=W1urmu50u6l/cXHFtJauFiPDwtDppplz/TQaBN0m9x4jLBK3dO38RFJgZ4cBxIZe96oMHQ
	Pxbw7Fs0NUgpCVBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Marco Elver <elver@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 0/4] perf: Make SIGTRAP and __perf_pending_irq() work
 on RT.
Message-ID: <20240313134645.bO-XyxAM@linutronix.de>
References: <20240312180814.3373778-1-bigeasy@linutronix.de>
 <ZfDMTlTH2SdwlB9M@x1>
 <20240313081303.DClwQrvb@linutronix.de>
 <ZfGqCWzyVzyGQrAQ@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZfGqCWzyVzyGQrAQ@x1>

On 2024-03-13 10:28:41 [-0300], Arnaldo Carvalho de Melo wrote:
> > One part I don't get: did you let it run or did you kill it?
>=20
> If I let them run they will finish and exit, no exec_child remains.
>=20
> If I instead try to stop the loop that goes on forking the 100 of them,
> then the exec_child remain spinning.

Okay. So that problem only exists if you intervene. And you can
reproduce this odd behaviour with my patches but not without them,
right?

> > it shouldn't remain there for ever. And my guess, that it is in spinning
> > in userland and not in kernel.
>=20
> Checking that now, the stack is the one I posted:
>=20
> > > [root@nine ~]# cat /proc/24263/stack
> > > [<0>] irqentry_exit_to_user_mode+0x1c9/0x1e0
> > > [<0>] asm_sysvec_apic_timer_interrupt+0x16/0x20
> > > [root@nine ~]#

could you resolve irqentry_exit_to_user_mode+0x1c9/0x1e0, please?

> > I tried it on bare metal and VM and couldn't reproduce this.
>=20
> All my tests are in bare metal.

Would you mind sending me your .config? The shell is bash I guess. I
will try to reproduce your setup on another box=E2=80=A6

> - Arnaldo

Sebastian

