Return-Path: <linux-kernel+bounces-109081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0656988146C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3833E1C203DB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C6254BCA;
	Wed, 20 Mar 2024 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzZyDMRT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23AF5472A;
	Wed, 20 Mar 2024 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948066; cv=none; b=PU/iN63w+mXraQ/bDFGk7HkxGHFw8rBbZf8ALMApQOxefzdXWwNHt91MQwT+X8gB3toiNIf4CeL4XddpEXLaDkrqLjzNGfYVkXEpvPF6sEPvr68jZ9TysSKgq3MjY5qe6wpURVPzn5dW9QJ/eQ6TNE5uiAIaddLvt6XVj9t7sqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948066; c=relaxed/simple;
	bh=1tGig6cMdiKntUIQI2Cqx4/KYJV/11C4ppZ+rg59blM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiyT6iRBbmwDRgZI3ZFcLjP1JTm73ylZgJVlxNDKrX/m/NAHSsUFGmGiaB+wXjij60UtfN9MBDObrKN0wrYiJ6zKZQuvm68ppPcc4cXEBcd+SierN6XRCaj3VyS1ythZa8aOppvMF2qE2ZPy844Jlncsrq0QJk80TJjo1hCH2wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzZyDMRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3B8C433C7;
	Wed, 20 Mar 2024 15:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710948065;
	bh=1tGig6cMdiKntUIQI2Cqx4/KYJV/11C4ppZ+rg59blM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VzZyDMRTD6tiu8t50ps7WpB9F2ZgXz9wsf3Z1pWLWaVhFhGl+tOTmDDwtVpMdx6XX
	 jdYCKWoHwCZs9loN8cbi5K/+hop+jJQEQE0nhUFuYwTKUTfLff35CoTNr4JzN+IS9/
	 niFqFBP7OI8c8pCVAD4iUwsZemY4TlJOnNuuC+BrBui+8Bw2gN1CyKYoMqwny/a1YO
	 V1PVogkpeRKB+CDSbTxg6VXRWUFwf++QeHvGRhLWFiEgy/30AlaGi8VmMkWZDeeHcb
	 sueTSFUU78dR6iZInmbbdCebwwDxztEp19M1OzmsXGbSQr++TLM5tbGRXWLYccx3bm
	 S3NNG6oHJoyPA==
Date: Wed, 20 Mar 2024 15:21:00 +0000
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Xingyu Wu <xingyu.wu@starfivetech.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Claudiu Beznea <Claudiu.Beznea@microchip.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ASoC: cdns: Add drivers of Cadence Multi-Channel
 I2S Controller
Message-ID: <aeac0262-1054-4bc9-b5e9-653785305162@sirena.org.uk>
References: <20240320090239.168743-1-xingyu.wu@starfivetech.com>
 <20240320090239.168743-3-xingyu.wu@starfivetech.com>
 <1d0399d2-684f-490e-8711-f636e987a0b8@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V7Pu1AxS8JZcWuN0"
Content-Disposition: inline
In-Reply-To: <1d0399d2-684f-490e-8711-f636e987a0b8@linux.intel.com>
X-Cookie: Androphobia:


--V7Pu1AxS8JZcWuN0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 20, 2024 at 10:00:24AM -0500, Pierre-Louis Bossart wrote:

> > +	for (i = 0; i < CDNS_I2S_FIFO_DEPTH; i++) {
> > +		if (format == SNDRV_PCM_FORMAT_S16_LE) {
> > +			data[0] = p16[tx_ptr][0];
> > +			data[1] = p16[tx_ptr][1];
> > +		} else if (format == SNDRV_PCM_FORMAT_S32_LE) {
> > +			data[0] = p32[tx_ptr][0];
> > +			data[1] = p32[tx_ptr][1];
> > +		}

> what about other formats implied by the use of 'else if' ?

In general things like this should be written as switch statements.

--V7Pu1AxS8JZcWuN0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX6/tsACgkQJNaLcl1U
h9BupQf/TIN+i7DTxIw1TfTwOUo18dvWHR8fAtRPMkNvvTXlDI+sAFwhdGomSgtj
7gHyw1/ZmMWHeGC6CffzXKwU4g3z/HyEidwFO6s2LdVxEvl2t8wE0Xo+c5Sgy9G/
iOdGpcwiRCqHh53rhK1UWdIP+paItr1ghPq6ySCASwQZFtvH7CMX4GWbNOEysO1V
6oQcPRwNkQ0k18dVdhsid+PvdPckEJVJGH8+H/YXeR/macDHMiyAJJEdTajQwAuX
iptwgUav7/bLABLR08oqMAaaczvDQgrhm0gRMdLqZQbgeTeq6Liap+HE039e3W9V
LUtcRjsLp6oOIB79EuRycmDey0JzUQ==
=f9S8
-----END PGP SIGNATURE-----

--V7Pu1AxS8JZcWuN0--

