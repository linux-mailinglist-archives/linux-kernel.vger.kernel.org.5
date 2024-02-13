Return-Path: <linux-kernel+bounces-63754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5BC85340D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3BB1F2AB6B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58AC5EE6D;
	Tue, 13 Feb 2024 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fsoi7BYS"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D889C58126;
	Tue, 13 Feb 2024 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836425; cv=none; b=Igcg/taK+AC/IbY2w1M7RV/z/UfpwKRsZ+9ayE7L05QJKI9fyKweFltyUHkzPyPsDTR9GpT/NP9paE07BQ+vEuO8GOMkVrBB1uB5n9jYfLUSFWUUBJmBlmn8ycHFvPPMfUOtUHKze3fqVyqWOWsCp3lxSZeWVyImB++yg9y3sTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836425; c=relaxed/simple;
	bh=gWsrd0/PgQYOHdRFEK2UvuRn9j/6BP+jXfidNB7p7bk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=UEGRtGXGt7hOC0FzxGogYmo0AqYqPdzEP7AJri7PnEwBERrxB5UdhPhodT7/d2TFttKuk9Y/cA/mb9ytC6G0tyenJqxU27S7xtu1aWRx17YW5r9BiulECkeqA3kLxFuAHa1xiz25BMtCxBICLYvDeHpR/UwE/JzHi4ndRHuXOiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fsoi7BYS; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 49CD7FF810;
	Tue, 13 Feb 2024 15:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707836414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4HDwpyy3tBnXbQ6lIyCh42gt9EtM1qPQ7jmDdySLbRg=;
	b=fsoi7BYSO+s2oMZcg7kY4xqmglEqIO21JJlQU2VNIOYaIu+58539Hn033rg3ISGS8h/t9k
	wpyJEIDHqI2M2SdvvG3JRn9pAHaiV8GUpiFLxnNKB4a+0KrhY6eQrgD3U/wPudAgKBWoWW
	25P3CrR1LZVCtX4sFF8QtCm2dHJzDEjHdnWptXec3kpByvq1BXW/vjaEaaPEf5Kte1COWg
	T1VnWHtABd25xQ4N2/rqZKsUyjVFVcbn5TtrIVqmDF67XbH95KxnKAbZLqBIBt+bqGd1/L
	U74ew7e/TuT9VJPhBU7k3h1HT/lVN3oY9zQcrvlqRww2G8ugjhSELSbtDqLjiw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 16:00:14 +0100
Message-Id: <CZ41HDHS7WX6.6MJL1O2PBVW1@bootlin.com>
Cc: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhruva
 Gole" <d-gole@ti.com>, "Gregory CLEMENT" <gregory.clement@bootlin.com>,
 "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Mark Brown"
 <broonie@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH] spi: spi-mem: add statistics support to ->exec_op()
 calls
X-Mailer: aerc 0.15.2
References: <20240209-spi-mem-stats-v1-1-dd1a422fc015@bootlin.com>
 <b0844e5a-ee4b-4608-99a1-877660e01d57@linaro.org>
In-Reply-To: <b0844e5a-ee4b-4608-99a1-877660e01d57@linaro.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello Tudor,

On Tue Feb 13, 2024 at 1:39 PM CET, Tudor Ambarus wrote:
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
> Would be good to be able to opt out the statistics if one wants it.
>
> SPI NORs can write with a single write op maximum page_size bytes, which
> is typically 256 bytes. And since there are SPI NORs that can run at 400
> MHz, I guess some performance penalty shouldn't be excluded.

I did my testing on a 40 MHz octal SPI NOR with most reads being much
bigger than 256 bytes, so I probably didn't have the fastest setup
indeed.

What shape would that take? A spi-mem DT prop? New field in the SPI
statistics sysfs directory?

Other remarks have been taken into account, thanks!

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

