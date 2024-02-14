Return-Path: <linux-kernel+bounces-65094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 053668547AB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93F391F24471
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE76A18E20;
	Wed, 14 Feb 2024 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Tk/FiVYe"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69CF18E0F;
	Wed, 14 Feb 2024 10:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707908396; cv=none; b=nw5KSgWkbJixXU6j3kw/p3OjQHje7h6SvnMut7zonWqDjj+IPkiQSGJqzBq0FacSCOa6sqlXVx5eSN1tcSquk/UmVUjJaDK15gFZIALIett34oECw3HmsBGFgY4UxQ9mpK89zXmDlOD9ByB3Nqd/ZGu8XwU6NYQ35QdhjphXUpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707908396; c=relaxed/simple;
	bh=2YSzh5b837LaM0eg2XU8A6dNFtANZqD5laac0BCInEw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=n0kFZzXRPd92PZd7AA8mT9bZjWqfiDrrFH+j4McczcYN88ii7f48F4VAKeW63GQzkNUYVHr38wBzowJYYK9EtY1x684r7Qd+ER9ytObufEJaAGjNp0wYhg3slDE3Wvxw7L9zs43cclW0R18ZhPo9LCggSUON5lNmNf9z6zgfoaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Tk/FiVYe; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4F4DB40013;
	Wed, 14 Feb 2024 10:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707908391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o6bzV5rKBOoAiPA6G28Xjo7+PQUFbe8kxnJ2q3EXQoA=;
	b=Tk/FiVYeIWjCHKiB7TWKNptAO9Bb6Yuxb2bad/0TiFFlJ2Nkrzh1KlwECZD7356Uh0MqhE
	+yF87TyMxbgdx1Rvy0ndo0jMIIAgxkgbabpt1qFCbaFRsDvkUshvSCiAwjnH1gXwjJiuuA
	3xUcjkSnq6YyFCvDN9hJeJOl/NbpTJMqxw8ovs+3QtQL7P2Csij2cnoiVu3ZnV16fJmXU5
	or3aZxDUuWcfV68XFAujOU0oCfiUq6xHcmHI+Di+ZKk5vIOPv1GVaicTc4IDfY1AWrOq+N
	JuoWgogY+QflxwG1OaHkXGMh8iVFsy55SvW9fsRIR0QokkvFqcuZXZOvIguTkw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Feb 2024 11:59:49 +0100
Message-Id: <CZ4QZUSQXV4Q.3QRIRM4V0SYF8@bootlin.com>
Subject: Re: [PATCH] spi: spi-mem: add statistics support to ->exec_op()
 calls
Cc: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhruva
 Gole" <d-gole@ti.com>, "Gregory CLEMENT" <gregory.clement@bootlin.com>,
 "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Mark Brown"
 <broonie@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.15.2
References: <20240209-spi-mem-stats-v1-1-dd1a422fc015@bootlin.com>
 <b0844e5a-ee4b-4608-99a1-877660e01d57@linaro.org>
 <CZ41HDHS7WX6.6MJL1O2PBVW1@bootlin.com>
 <7b3c08b0-80ed-4409-96d4-d55b938df6f4@linaro.org>
 <CZ4O9QACM45B.2HA0L2O4QL5PL@bootlin.com>
 <c5230e6b-b988-4fdb-a8d6-543c3e9cda23@linaro.org>
In-Reply-To: <c5230e6b-b988-4fdb-a8d6-543c3e9cda23@linaro.org>
X-GND-Sasl: theo.lebrun@bootlin.com

On Wed Feb 14, 2024 at 10:29 AM CET, Tudor Ambarus wrote:
> On 2/14/24 08:51, Th=C3=A9o Lebrun wrote:
> > On Wed Feb 14, 2024 at 9:00 AM CET, Tudor Ambarus wrote:
> >> On 2/13/24 15:00, Th=C3=A9o Lebrun wrote:
> >>> On Tue Feb 13, 2024 at 1:39 PM CET, Tudor Ambarus wrote:
> >>>>>  /**
> >>>>>   * spi_mem_exec_op() - Execute a memory operation
> >>>>>   * @mem: the SPI memory
> >>>>> @@ -339,8 +383,12 @@ int spi_mem_exec_op(struct spi_mem *mem, const=
 struct spi_mem_op *op)
> >>>>>  		 * read path) and expect the core to use the regular SPI
> >>>>>  		 * interface in other cases.
> >>>>>  		 */
> >>>>> -		if (!ret || ret !=3D -ENOTSUPP || ret !=3D -EOPNOTSUPP)
> >>>>> +		if (!ret || ret !=3D -ENOTSUPP || ret !=3D -EOPNOTSUPP) {
> >>>>> +			spi_mem_add_op_stats(ctlr->pcpu_statistics, op, ret);
> >>>>> +			spi_mem_add_op_stats(mem->spi->pcpu_statistics, op, ret);
> >>>>> +
> >>>>
> >>>> Would be good to be able to opt out the statistics if one wants it.
> >>>>
> >>>> SPI NORs can write with a single write op maximum page_size bytes, w=
hich
> >>>> is typically 256 bytes. And since there are SPI NORs that can run at=
 400
> >>>> MHz, I guess some performance penalty shouldn't be excluded.
> >>>
> >>> I did my testing on a 40 MHz octal SPI NOR with most reads being much
> >>> bigger than 256 bytes, so I probably didn't have the fastest setup
> >>> indeed.
> >>
> >> yeah, reads are bigger, the entire flash can be read with a single rea=
d op.
> >>
> >>>
> >>> What shape would that take? A spi-mem DT prop? New field in the SPI
> >>> statistics sysfs directory?
> >>>
> >>
> >> I think I'd go with a sysfs entry, it provides flexibility. But I gues=
s
> >> we can worry about this if we have some numbers, and I don't have, so
> >> you're fine even without the opt-out option.
> >=20
> > Some ftrace numbers:
> > - 48002 calls to spi_mem_add_op_stats();
> > - min 1.053000=C2=B5s;
> > - avg 1.175652=C2=B5s;
> > - max 16.272000=C2=B5s.
> >=20
> > Platform is Mobileye EyeQ5. Cores are Imagine Technologies I6500-F. I
> > don't know the precision of our timer but we might be getting close to
> > what is measurable.
> >=20
> Thanks.
>
> I took a random SPI NOR flash [1], its page program typical time is 64=C2=
=B5s
> according to its SFDP data. We'll have to add here the delay the
> software handling takes.
>
> If you want to play a bit more, you can write the entire flash then
> compare the ftrace numbers of spi_mem_add_op_stats() with spi_nor_write()=
.

It is unclear to me why you are focusing on writes? Won't reads be much
faster in the common case, and therefore where stats overhead would
show the most? For cadence-qspi, only issuing command reads (reads below
8 bytes) would be a sort of pathological case.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

