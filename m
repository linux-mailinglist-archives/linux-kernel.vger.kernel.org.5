Return-Path: <linux-kernel+bounces-64887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E70854454
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1CAD2856C0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1748D79D2;
	Wed, 14 Feb 2024 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Gk3z30vZ"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D6C6FDC;
	Wed, 14 Feb 2024 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707900711; cv=none; b=IpC8qCds4n9Okgq/KCEjHTcp0eZc8EzkZmLVPEA4PeYOTdBidEuSWxuHUsENHtBmtBwCZprOidW1SJm8la4Z9iwLY/vzOiwP8tiNFmTrYOrgmauKgP9pP+s28qxUEvJ44KMAiNFoMvOhbFWziquRsJlPHjjq8E2SVkRnhMYDzpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707900711; c=relaxed/simple;
	bh=enSiykOQ8N3JlqyINcLjzoJCOx2xCmGKN0l6xtncU0o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=mpRvsdDfk5XszVRTlKynpqlTEz7X5l3dnnvKWRzGn3zMzcTDjZJ3382mciC16RLH1Y2jbwhUktDf8eoltHrGriFm2yyAhIuTIRLm4hRpfW8AVyM4O0mdS5RN0PN0XHnxJ+AmtWeBjubDe+fE9aCmLBjZ3W4sizpdlDTOvfb1Aw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Gk3z30vZ; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D5D5C240004;
	Wed, 14 Feb 2024 08:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707900701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NcaJN4aL+1eJm0OAqfQB+wrvwEsb6ZrlXGfdnsmoM24=;
	b=Gk3z30vZS7hg+4gIAjFYUXRTnEpVba7F1suW7XDIu4o9drbR/2KGTQUh0A417M0t4tCbkr
	BTXiBZ+F8/PLo5VSjB2VANa2mr1TUl+fUqh9vhgghygSCoWz3vVahTkP1YDqTg5GdC8Pqo
	YtORhz66HW8NSOsUiyOAGCIWsahjiqQCm+pHgfhku3m/SeILR+FJ7dz4MjA6tIFUpCx38l
	zazB1gRVa/RnASjnzMDf/F+zfFMBQnLRF/ZcMAg4XWslMoSEYh1cGB4hiZo6f8wP6vjVu5
	BI/nlmAa516e+5OqvvfxmqMDM2t78tQhM+d1sYAuxB1WB9TEOWTnotAw5YnEFQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Feb 2024 09:51:40 +0100
Message-Id: <CZ4O9QACM45B.2HA0L2O4QL5PL@bootlin.com>
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
 <CZ41HDHS7WX6.6MJL1O2PBVW1@bootlin.com>
 <7b3c08b0-80ed-4409-96d4-d55b938df6f4@linaro.org>
In-Reply-To: <7b3c08b0-80ed-4409-96d4-d55b938df6f4@linaro.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Wed Feb 14, 2024 at 9:00 AM CET, Tudor Ambarus wrote:
> On 2/13/24 15:00, Th=C3=A9o Lebrun wrote:
> > On Tue Feb 13, 2024 at 1:39 PM CET, Tudor Ambarus wrote:
> >>>  /**
> >>>   * spi_mem_exec_op() - Execute a memory operation
> >>>   * @mem: the SPI memory
> >>> @@ -339,8 +383,12 @@ int spi_mem_exec_op(struct spi_mem *mem, const s=
truct spi_mem_op *op)
> >>>  		 * read path) and expect the core to use the regular SPI
> >>>  		 * interface in other cases.
> >>>  		 */
> >>> -		if (!ret || ret !=3D -ENOTSUPP || ret !=3D -EOPNOTSUPP)
> >>> +		if (!ret || ret !=3D -ENOTSUPP || ret !=3D -EOPNOTSUPP) {
> >>> +			spi_mem_add_op_stats(ctlr->pcpu_statistics, op, ret);
> >>> +			spi_mem_add_op_stats(mem->spi->pcpu_statistics, op, ret);
> >>> +
> >>
> >> Would be good to be able to opt out the statistics if one wants it.
> >>
> >> SPI NORs can write with a single write op maximum page_size bytes, whi=
ch
> >> is typically 256 bytes. And since there are SPI NORs that can run at 4=
00
> >> MHz, I guess some performance penalty shouldn't be excluded.
> >=20
> > I did my testing on a 40 MHz octal SPI NOR with most reads being much
> > bigger than 256 bytes, so I probably didn't have the fastest setup
> > indeed.
>
> yeah, reads are bigger, the entire flash can be read with a single read o=
p.
>
> >=20
> > What shape would that take? A spi-mem DT prop? New field in the SPI
> > statistics sysfs directory?
> >=20
>
> I think I'd go with a sysfs entry, it provides flexibility. But I guess
> we can worry about this if we have some numbers, and I don't have, so
> you're fine even without the opt-out option.

Some ftrace numbers:
- 48002 calls to spi_mem_add_op_stats();
- min 1.053000=C2=B5s;
- avg 1.175652=C2=B5s;
- max 16.272000=C2=B5s.

Platform is Mobileye EyeQ5. Cores are Imagine Technologies I6500-F. I
don't know the precision of our timer but we might be getting close to
what is measurable.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

