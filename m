Return-Path: <linux-kernel+bounces-73307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1792985C0B4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B742875EF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A456A627EA;
	Tue, 20 Feb 2024 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dzit3AHY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB932762DA;
	Tue, 20 Feb 2024 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708445088; cv=none; b=r3QTpxepRSxGf5rRynaxcrkvsl3zJgl921UC8xGs236ZgqrU11PrmT/yEouoLC142knW7pH5bhy98bnTaxtPNero+VevH3UT9H4UG7qFWgdoMjMOo8BW8XAk+g+RdG7MXh/QgF3umNr4ds03nQXr5nfJjomirx7eLNDRJ2Vvu4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708445088; c=relaxed/simple;
	bh=J1fK6jslfQkZJzg2jPwQHSC+4w+Ux+DicAEu9djZk9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdIkSlbILHRrUeZqZ87Y2ofL+VEjdQSC2YSxe1ZVBUjZc6Msm2HAZK0rd5p6SiKDR0ml8kgvuUMNpi8xUEX0IDDzL20bz1SP5Ja/APVMNH0PFChk9k29h8By8m26/QqxFfZK8EyTkv55LlPPKb8tataKF+DhEu5sS7xbw4uop7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dzit3AHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628B4C4166A;
	Tue, 20 Feb 2024 16:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708445087;
	bh=J1fK6jslfQkZJzg2jPwQHSC+4w+Ux+DicAEu9djZk9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dzit3AHYBMTM6EIcb3NGyAl04AmdWlCHyErY2wZxASbuJz5+G7g5emqHdd/RtULNB
	 IS12FBFzONThiujilhranlioF0I31opt503RIvWlbjanS2xIR3pt5BZ0JLp0EfV0OZ
	 g6rJOt04kvLmtjC3jC3CMOnmiktLrM2JrZgtEelfFg6J981McJzPAqwgRxI8BK+R8/
	 Sjj6i3+w12GI/5p1PJKSdeYYwvQhdtLma6+fYhXmCsBkHcDppUTGYKYwqKU8274CTx
	 QbvCMA/UMTEL/6XbOtUsFJOIlPiUAi2j7BZHLWALRdLLsTrEGWguzI2eZknQ/nt1/f
	 bpzmFfHNJDRPQ==
Date: Tue, 20 Feb 2024 16:04:40 +0000
From: Mark Brown <broonie@kernel.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
	quic_srichara@quicinc.com, quic_varada@quicinc.com
Subject: Re: [PATCH 3/5] spi: spi-qpic: Add qpic spi nand driver support
Message-ID: <8422fb6a-edd4-4911-89b7-2974c197981b@sirena.org.uk>
References: <20240215134856.1313239-1-quic_mdalam@quicinc.com>
 <20240215134856.1313239-4-quic_mdalam@quicinc.com>
 <21dde665-54b4-48e4-b963-1008ac890df3@sirena.org.uk>
 <4a0e51cf-d29a-5843-9c61-1d31a9721a3d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kjXP74qJYK0BefO/"
Content-Disposition: inline
In-Reply-To: <4a0e51cf-d29a-5843-9c61-1d31a9721a3d@quicinc.com>
X-Cookie: E = MC ** 2 +- 3db


--kjXP74qJYK0BefO/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 20, 2024 at 05:24:43PM +0530, Md Sadre Alam wrote:
> On 2/15/2024 7:44 PM, Mark Brown wrote:
> > On Thu, Feb 15, 2024 at 07:18:54PM +0530, Md Sadre Alam wrote:

> > > +	if (op->cmd.opcode == SPINAND_READID) {
> > > +		snandc->buf_count = 4;
> > > +		read_reg_dma(snandc, NAND_READ_ID, 1, NAND_BAM_NEXT_SGL);
> > > +
> > > +		ret = submit_descs(snandc);
> > > +		if (ret)
> > > +			dev_err(snandc->dev, "failure in submitting descriptor for readid\n");
> > > +
> > > +		nandc_read_buffer_sync(snandc, true);
> > > +		memcpy(op->data.buf.in, snandc->reg_read_buf, snandc->buf_count);

> > These memcpy()s don't seem great, why aren't we just reading directly
> > into the output buffer?

>   This reg_read_buf is being used in common API so that it will be used by both
>   serial nand as well raw nand, so I can't directly use the output buffer since
>   internally CW mechanism I have to maintain in common API.

We have control over all the source code in the kernel so if there's
problems with the internal interfaces we can improve them.

--kjXP74qJYK0BefO/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXUzZcACgkQJNaLcl1U
h9Ae6wf+Oq59OwYseL/VBULc5zFT+JBaAz+wC7NoE0Cl+JBwS9ar0CwNuWUQD6Ra
9Thdvn0Xmqk4vySveo4DKrtjIjai/iU87ZwjrMnDE5jVf+/m+n+h0YCfMSeA1qlY
WjqgbYKTJRpm9YfJitc6FuNjUnnww2cljwtvT1V6gLbHFmPtG+70m/RKRin6FJlL
JtVaTkjbHlUrwWANzGfylsAIeyz6q9BDDhN+q+7GkkLV/vUtuZiCeVHszJ8EwjUf
HpLkY1r/MGbpENGuqo9iiFOlSGHLhyrB83CGZ8e+hB0EiONvKPZqu+mB3wdnRLiF
oxAaV4xJrFzQNVDCHiDQXmHOhFCXhA==
=tp1U
-----END PGP SIGNATURE-----

--kjXP74qJYK0BefO/--

