Return-Path: <linux-kernel+bounces-135530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAC089C73A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0DAF1F22103
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA9813E8BD;
	Mon,  8 Apr 2024 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NLcU8zB4"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D28D13CFAF;
	Mon,  8 Apr 2024 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587142; cv=none; b=c4zwLkS4MhLPAHgFzRq1PnOTN7i7DSpJt04yHQZ1KKjV3zfqGnJzxn99Zjy5tCe7Hvjs51rIYAU+PwTqA9Zbs+b/VSvpPkvuMX04daaxhEiHxdupKrty0Dx/Vbu2Tbg1rpftahzUDRYVIzYTw40c3UXiuHwjHTfUcYJe3WdNS8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587142; c=relaxed/simple;
	bh=3wDoUF5pxGrcrqOJXtZo0C1ZtYn3BHT7grHApLKhOXI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=Lg1X0MTlHU9choB/T5Kf31ptNZW4t+YH0ncxnu13eQTrdCu9mvoR2vD5Puv6GpkECD7dhYGlpPZDgj+LUaAXjOSKduPYqcxLKad6MZ8pF9+SNuf0OFK9LqsPjwfdBDoDXs93gm0eFOu83tJCGP64gNuYRSrbuMv/mQchZ/cY2P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NLcU8zB4; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C7BC8C0007;
	Mon,  8 Apr 2024 14:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712587137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ZlC/UZKOWqyEBpP3eksr4VHpijr8KpH0sG0zM7Z4oM=;
	b=NLcU8zB4415/RLIr9hLOQwFYzyp0qixe6CGQnkNxYsiHM9sH2mdiYPpE5Qhvul+24BKNDZ
	O/y1mKm4OHtBD760iW4Bt5lmHzSvtq9f33UdtSeJAvbU0W1SOITnjmj2d/Iz8i9pN0LMNE
	4DO4+u6p4+cIjA+wPnwtniTvGP5XMnzrOx2iWbMs6ylPNeMQXz2BhyU2lyuMmvJLybn/aq
	GwE/Dy7IoKBkZDgIbpcxMOfJv1/h7waJBqvQHcG+dzR4e6kX9Ssm9mF5OcK4mOOZK/qQ0x
	zReKPpD9/VzAFA2uG/igcaSPGqGcOz0NmpKEwj2RQIRquelGSqItmd90P8f9iw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Apr 2024 16:38:56 +0200
Message-Id: <D0ETH1AG1ONG.1M1FPSZM69H0Z@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v2 05/11] spi: cadence-qspi: add FIFO depth detection
 quirk
Cc: "Rob Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Vaishnav Achath" <vaishnav.a@ti.com>, "Thomas Bogendoerfer"
 <tsbogend@alpha.franken.de>, "Rob Herring" <robh@kernel.org>,
 <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mips@vger.kernel.org>, "Vladimir
 Kondratiev" <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Mark Brown" <broonie@kernel.org>
X-Mailer: aerc 0.15.2
References: <20240405-cdns-qspi-mbly-v2-0-956679866d6d@bootlin.com>
 <20240405-cdns-qspi-mbly-v2-5-956679866d6d@bootlin.com>
 <551bea0a-1c9e-4e04-87db-c643fdaee85e@sirena.org.uk>
In-Reply-To: <551bea0a-1c9e-4e04-87db-c643fdaee85e@sirena.org.uk>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Mon Apr 8, 2024 at 4:10 PM CEST, Mark Brown wrote:
> On Fri, Apr 05, 2024 at 05:02:15PM +0200, Th=C3=A9o Lebrun wrote:
>
> > Use hardware ability to read the FIFO depth thanks to
> > CQSPI_REG_SRAMPARTITION that is partially read-only. Keep current
> > behavior identical for existing compatibles.
>
> The behaviour is not identical here - we now unconditionally probe the
> FIFO depth on all hardware, the difference with the quirk is that we
> will ignore any DT property specifying the depth.

You are correct of course. Wording is incorrect. I wanted to highlight
that FIFO depth does not change for existing HW and still relies as
before on devicetree value.

> > -	if (of_property_read_u32(np, "cdns,fifo-depth", &cqspi->fifo_depth)) =
{
> > +	if (!(ddata && ddata->quirks & CQSPI_DETECT_FIFO_DEPTH) &&
> > +	    of_property_read_u32(np, "cdns,fifo-depth", &cqspi->fifo_depth)) =
{
> >  		dev_err(dev, "couldn't determine fifo-depth\n");
>
> It's not obvious from just the code that we do handle having a FIFO
> depth property and detection in the detection code, at least a comment
> would be good.

I see. Will add comment or rework code to make more straight forward, or
both.

> > +static void cqspi_controller_detect_fifo_depth(struct cqspi_st *cqspi)
> > +{
> > +	const struct cqspi_driver_platdata *ddata =3D cqspi->ddata;
> > +	struct device *dev =3D &cqspi->pdev->dev;
> > +	u32 reg, fifo_depth;
> > +
> > +	/*
> > +	 * Bits N-1:0 are writable while bits 31:N are read as zero, with 2^N
> > +	 * the FIFO depth.
> > +	 */
> > +	writel(U32_MAX, cqspi->iobase + CQSPI_REG_SRAMPARTITION);
> > +	reg =3D readl(cqspi->iobase + CQSPI_REG_SRAMPARTITION);
> > +	fifo_depth =3D reg + 1;
> > +
> > +	if (ddata && ddata->quirks & CQSPI_DETECT_FIFO_DEPTH) {
> > +		cqspi->fifo_depth =3D fifo_depth;
> > +		dev_dbg(dev, "using FIFO depth of %u\n", fifo_depth);
> > +	} else if (fifo_depth !=3D cqspi->fifo_depth) {
> > +		dev_warn(dev, "detected FIFO depth (%u) different from config (%u)\n=
",
> > +			 fifo_depth, cqspi->fifo_depth);
> > +	}
>
> It's not obvious to me that we should ignore an explicitly specified
> property if the quirk is present

DT value isn't expected for compatibles with CQSPI_DETECT_FIFO_DEPTH
quirk, therefore we do not ignore a specified property. Bindings agree:
prop is false with EyeQ5 compatible.

> - if anything I'd more expect to see
> the new warning in that case, possibly with a higher severity if we're
> saying that the quirk means we're more confident that the data reported
> by the hardware is reliable.  I think what I'd expect is that we always
> use an explicitly specified depth (hopefully the user was specifying it
> for a reason?).

The goal was a simpler devicetree on Mobileye platform. This is why we
add this behavior flag. You prefer the property to be always present?
This is a only a nice-to-have, you tell me what you prefer.

I wasn't sure all HW behaved in the same way wrt read-only bits in
SRAMPARTITION, and I do not have access to other platforms exploiting
this driver. This is why I kept behavior reserved for EyeQ5-integrated
IP block.

> Pulling all the above together can we just drop the quirk and always do
> the detection, or leave the quirk as just controlling the severity with
> which we log any difference between detected and explicitly configured
> depths?

If we do not simplify devicetree, then I'd vote for dropping this patch
entirely. Adding code for detecting such an edge-case doesn't sound
useful. Especially since this kind of error should only occur to people
adding new hardware support; those probably do not need a nice
user-facing error message. What do you think?

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


