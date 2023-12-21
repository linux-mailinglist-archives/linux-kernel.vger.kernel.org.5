Return-Path: <linux-kernel+bounces-8411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ED881B6C2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1671F26759
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE26079952;
	Thu, 21 Dec 2023 12:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCslwi3G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2899F7995C;
	Thu, 21 Dec 2023 12:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE2EC433C8;
	Thu, 21 Dec 2023 12:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703163337;
	bh=7NxpxM1STCMZ8Ns3Axc00mUiFhhRBcEYLIvZ8mqgJ+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZCslwi3GvMMaQxEaTeZGHOEFbcCU6AuRFQJ6RYpGW7hpi4KDBbZV1pstpAf7wWHPY
	 BM93nHNrkUIbxrxzLhthSeAmQX0xtBS2lbwxbrZ6pUiOF9RWzStLIwtlXkgPrQ5rWf
	 IKElmG672O0pocCtANJbDKH4LRMUqItWQTD0maTOUxwstEz086HmwJAJi/i+9HHyqV
	 tUy0+MFsRc8gfK8RXjhUY7fz6qq5FXTYINDrvPWchVcIOCgP+nVrFe00yWDB/LRfZQ
	 9tyCeM9FEmAIpXDsDCUnQ1DbdUAdayojwaveqMrlTN92+AvhW8q6BO2Rr8jeEOHvVK
	 UeKaRuO9sAaFA==
Date: Thu, 21 Dec 2023 12:55:31 +0000
From: Mark Brown <broonie@kernel.org>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Claudiu Beznea <Claudiu.Beznea@microchip.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Walker Chen <walker.chen@starfivetech.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v1 2/2] ASoC: starfive: Add drivers of Cadence
 Multi-Channel I2S Controller
Message-ID: <861f9b28-863d-48b0-8491-add4a286597e@sirena.org.uk>
References: <20231221033223.73201-1-xingyu.wu@starfivetech.com>
 <20231221033223.73201-3-xingyu.wu@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qiI6QTJLu38XlrMO"
Content-Disposition: inline
In-Reply-To: <20231221033223.73201-3-xingyu.wu@starfivetech.com>
X-Cookie: Results are not typical.


--qiI6QTJLu38XlrMO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 21, 2023 at 11:32:23AM +0800, Xingyu Wu wrote:

>  sound/soc/starfive/cdns-jh8100-i2s-pcm.c | 262 ++++++++
>  sound/soc/starfive/cdns-jh8100-i2s.c     | 727 +++++++++++++++++++++++
>  sound/soc/starfive/cdns-jh8100-i2s.h     | 171 ++++++

If this is a Cadence IP why is the entire driver SoC specific?

--qiI6QTJLu38XlrMO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWENcMACgkQJNaLcl1U
h9DmxQf/VKWNR8MkKD1nBaJ7Yag16lGPPoUKjVEA2U9WJHxwlAJ3QXQ5lsrIBeg4
yhP0BWeL9nEb5kF6zN02LHhXrsRxU7li5HUT0hS0CArT8uQjR/g2DEr5iIfNiBmb
+6gKFGsbitTZCdp4VYcmNjUYGOz/5Zl4ZzmXYxBtiZLoCaJgcSLEDJI6BOK8vNJb
/4fyTPW81F5T1Ww2lW9xSEW4sPaQCDYR1+SDNLd+tMZodWgOwLZ+QTUvdGEisUbk
QvjM9CcrWIs79/sCqHq052zO4bWnEL4w1lTcz+oojP8kEinpg9O7nQl3TMkh2OeV
ep3TrAzJvm3x176m5cODPhAJLYVlbg==
=xQrw
-----END PGP SIGNATURE-----

--qiI6QTJLu38XlrMO--

