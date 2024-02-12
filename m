Return-Path: <linux-kernel+bounces-61823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B56368516FB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D7D82816E9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283713A8F0;
	Mon, 12 Feb 2024 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AZFj8b0Z"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52373C08F;
	Mon, 12 Feb 2024 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707747766; cv=none; b=i78pPEsNO4jb5mP3XBDR4CCKuREC4K6tJUrNVrXRU7C5wjudzdJSAMiEyIEnbga4IcB5TUUk1EL0i6sVnJ/wyYUg9l/FTPm+ts8Q5Sb4513t+GagAuutY9jgLHvFzMPO7+/bL/zwJlr1jFhFCGQBWz+0Sc93krkVPRjU7JHOHfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707747766; c=relaxed/simple;
	bh=RRPvf0qdG7QDCrZB+FM4EBm/fzFwbbNOGCddUVO/Jec=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=kfAB0f0dE/YEp4VSKJRK1cyLTm7ZMias6OsypyGkKQtaacIyOKiQ39TJ5I6oAvDiZm4LG1hG9FCmv3p+/c5YniDZ3VUkwsJrNb+r/uWtCW2VxtT/xfyyN7OJz17lkSwnYaoPEED1uEz0WC3cpXbFoAwffwOlM/g1t5BqIN4QL5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AZFj8b0Z; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8FFCBFF80B;
	Mon, 12 Feb 2024 14:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707747762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iKu/Mzo/VkSHFDHFRr+RISjZT3DqqRIm0Z2XuNpfVUk=;
	b=AZFj8b0ZTrVqIUF2QN41LOio2y2DEUa049qOU3Cbxo0CXJy5n8g1sxFAMltK2MjkYi1VT/
	t9xkqX5wu79p2WIzeTh4OBzUZ9HJBvMm6mk43xOHdcbQGp3MMhUpC7DoYiwF/ml3IvbzUd
	/YkWdzWrkKPttGsj9FYf8i3+eENyCmiZenkwRR690KzyN5KpMda+MXEdZeHlqZEafa72JP
	dounR7R5MY3Vies5GXTifLK79qCoWA9jwFsiNU8E9j/7WSGZMxGzqpd7aaXU3ZVIjK8Z84
	0xtnP25tui4Y7B7sVITFzK0xvUTaOJ8ngvbmFma9DweBLaRmNJFv/CaXEO3nDQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 12 Feb 2024 15:22:41 +0100
Message-Id: <CZ3622YJS316.3HPUUVRW20KSR@bootlin.com>
Subject: Re: [PATCH] spi: spi-mem: add statistics support to ->exec_op()
 calls
Cc: "Mark Brown" <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Dhruva Gole" <d-gole@ti.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.15.2
References: <20240209-spi-mem-stats-v1-1-dd1a422fc015@bootlin.com>
 <20240212111355.gle4titwolqtzwpi@dhruva>
In-Reply-To: <20240212111355.gle4titwolqtzwpi@dhruva>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Mon Feb 12, 2024 at 12:13 PM CET, Dhruva Gole wrote:
> Hi!
>
> On Feb 09, 2024 at 14:51:23 +0100, Th=C3=A9o Lebrun wrote:
> > Current behavior is that spi-mem operations do not increment statistics=
,
> > neither per-controller nor per-device, if ->exec_op() is used. For
> > operations that do NOT use ->exec_op(), stats are increased as the
> > usual spi_sync() is called.
> >=20
> > The newly implemented spi_mem_add_op_stats() function is strongly
> > inspired by spi_statistics_add_transfer_stats(); locking logic and
> > l2len computation comes from there.
> >=20
> > Statistics that are being filled: bytes{,_rx,_tx}, messages, transfers,
> > errors, timedout, transfer_bytes_histo_*.
> >=20
> > Note about messages & transfers counters: in the fallback to spi_sync()
> > case, there are from 1 to 4 transfers per message. We only register one
> > big transfer in the ->exec_op() case as that is closer to reality.
>
> Can you please elaborate on this point a bit? To me it feels then that
> the reported stats in this case will be less than the true value then?

To me, a transfer is one transaction with the SPI controller. In most
implementations of ->exec_op(), the controller gets configured once for
the full transfer to take place. This contrasts with the fallback case
that does from 1 to 4 transfers (cmd, addr, dummy & data, with the last
three being optional).

One transfer feels closer to what happens from my point-of-view. What
would be your definition of a transfer? Or the "official" one that the
sysfs entry represents?

> > This patch is NOT touching:
> >  - spi_async, spi_sync, spi_sync_immediate: those counters describe
> >    precise function calls, incrementing them would be lying. I believe
> >    comparing the messages counter to spi_async+spi_sync is a good way
> >    to detect ->exec_op() calls, but I might be missing edge cases
> >    knowledge.
> >  - transfers_split_maxsize: splitting cannot happen if ->exec_op() is
> >    provided.
>
> Credit where it's due - This is a very well written and verbose commit
> message.

Thanks!

> Just my personal opinion maybe but all this data about testing can go
> below the tear line in the description?

I see where you are coming from. I'll do so on the next revision (if
there is one).

> Or somewhere in the kernel docs would also be just fine. (I know we
> kernel developers consider git log as the best source of documentation
> :) ) but still.. if you feel like adding ;)

A first step would be to have the sysfs SPI statistics API be described
inside Documentation/. That is outside the scope of this patch
though. :-)

> No strong opinions there though.

Same.

[...]

> > +static void spi_mem_add_op_stats(struct spi_statistics __percpu *pcpu_=
stats,
> > +				 const struct spi_mem_op *op, int exec_op_ret)
> > +{
> > +	struct spi_statistics *stats;
> > +	int len, l2len;
> > +
> > +	get_cpu();
> > +	stats =3D this_cpu_ptr(pcpu_stats);
> > +	u64_stats_update_begin(&stats->syncp);
> > +
> > +	/*
> > +	 * We do not have the concept of messages or transfers. Let's conside=
r
> > +	 * that one operation is equivalent to one message and one transfer.
>
> Why 1 message _and_ 1 xfer and not simply 1 xfer?
> Even in the example of testing that you showed above the values for
> message and xfer are anyway going to be same, then why have these 2
> members in the first place? Can we not do away with one of these?

Mark Brown gave an answer to this. Indeed, with regular SPI operations,
one message doesn't map to one transfer.

[...]

> >  /**
> >   * spi_mem_exec_op() - Execute a memory operation
> >   * @mem: the SPI memory
> > @@ -339,8 +383,12 @@ int spi_mem_exec_op(struct spi_mem *mem, const str=
uct spi_mem_op *op)
> >  		 * read path) and expect the core to use the regular SPI
> >  		 * interface in other cases.
> >  		 */
> > -		if (!ret || ret !=3D -ENOTSUPP || ret !=3D -EOPNOTSUPP)
> > +		if (!ret || ret !=3D -ENOTSUPP || ret !=3D -EOPNOTSUPP) {
> > +			spi_mem_add_op_stats(ctlr->pcpu_statistics, op, ret);
> > +			spi_mem_add_op_stats(mem->spi->pcpu_statistics, op, ret);
> > +
>
> Just curious, how much does this impact performance? Have you been able
> to do some before / after profiling with/out this patch?
>
> For eg. for every single spimem op I'm constantly going to incur the
> penalty of these calls right?

I have indeed done some benchmarking. I was not able to measure anything
significant. Neither doing timings of end-to-end testing by reading
loads of data over UBIFS, nor by using ftrace's function_graph.

> Just wondering if we can / should make this optional to have the
> op_stats. If there is a perf penalty, like if my ospi operations start
> being impacted by these calls then I may not be okay with this patch.

I've asked myself the same question. It is being done unconditionally on
regular SPI ops, so I guess the question has been answered previously:
no need to make this conditional.

See spi_statistics_add_transfer_stats() in drivers/spi/spi.c.

> But if you have tested and not found it to be the case I am okay with
> these changes.
>
> If I find some time later, I'll try to test but I'm caught up with some
> other work. For now I'll leave my R-by with the above conditions
> addressed / answered.
>
> Mostly LGTM,
>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>

Thanks for your review! I don't regret adding you to the Cc list.

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

