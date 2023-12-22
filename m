Return-Path: <linux-kernel+bounces-9712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8241D81CA16
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4D511C224E6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76626182BB;
	Fri, 22 Dec 2023 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7EACPxm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC4218038;
	Fri, 22 Dec 2023 12:39:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717BDC433C7;
	Fri, 22 Dec 2023 12:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703248764;
	bh=hFpzxk40jH07vGKrSWCqaia7hpuI2qY6e5LSmvyVvOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n7EACPxmrhepNnSpfUi/hpy99QHH46fkH104/LL0i/e0xDl6pmzSOyXZqJGaddhO5
	 X0rcGrRR8vwmhv5hQ7EyC4Sl31McB+4U0a1GFTRKk/uQqgvDTvLiByHtLhUiONmEiN
	 3CnYA17jsiTlkt887S2xZ3TnhMbDe8YfMLwymyvJOMXjNBwgkiFBQ1ZuGv2eU3W4Nc
	 xS0i0nK0W9ER42wPLBv+d2haszXYzknS7yb6Wj+bzc/LYWv/HN2iGvkYKXRygYqQDO
	 PfItA4SHCY6MrY6UcVkHXPIzybmKFMKy2JWmwbeWXRUeatozcvl/iETpm29WLVI7On
	 8NP4URUVPKl5Q==
Date: Fri, 22 Dec 2023 12:39:18 +0000
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
Message-ID: <27155281-573c-493d-96fe-1f28ebb0ce5e@sirena.org.uk>
References: <20231221033223.73201-1-xingyu.wu@starfivetech.com>
 <20231221033223.73201-3-xingyu.wu@starfivetech.com>
 <861f9b28-863d-48b0-8491-add4a286597e@sirena.org.uk>
 <c94b377a-1e21-4361-ae82-ca84d1dce60a@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GXw0TGVqm50qN3Wu"
Content-Disposition: inline
In-Reply-To: <c94b377a-1e21-4361-ae82-ca84d1dce60a@starfivetech.com>
X-Cookie: Familiarity breeds attempt.


--GXw0TGVqm50qN3Wu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 22, 2023 at 05:11:17PM +0800, Xingyu Wu wrote:
> On 2023/12/21 20:55, Mark Brown wrote:
> > On Thu, Dec 21, 2023 at 11:32:23AM +0800, Xingyu Wu wrote:

> >>  sound/soc/starfive/cdns-jh8100-i2s-pcm.c | 262 ++++++++
> >>  sound/soc/starfive/cdns-jh8100-i2s.c     | 727 +++++++++++++++++++++++
> >>  sound/soc/starfive/cdns-jh8100-i2s.h     | 171 ++++++

> > If this is a Cadence IP why is the entire driver SoC specific?

> This a new driver about this Cadence I2S controller. Should I create a new folder and file like this:

> sound/soc/cdns/cdns-i2s*

> and I use different compatible to support other SoC like JH8100?

Yes, that seems more what I'd expect - with a fallback compatible for
things that don't need any special quirks.

--GXw0TGVqm50qN3Wu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWFg3UACgkQJNaLcl1U
h9DNPQf/Rl6ymRLUqxntVfRZKh7LXfMrl/p7IFbdJ3TL1Va26hUGWaxLaDYFOn0l
eRZ3lJIhJzHDrMG5JHhKlHZtW8MkIc4rjiwMgnbeyuKAVYdXLmmKLEEj2vPCeM7P
SqVOUSUEWTRl3WU7t1sOZF97OLaG/MXZY7toq0a3Rgbs83HLbBHfPFIbHEvVw4+P
HQ0ZQBDfXGTVhwcihfQnDutiMNAjcwYJ4SvgEkLxaEovAEvbbUcJQG45Z8UWHz/r
vh3cAf9wUAbywvC2PA6o9TzinDnijr/gqLDZ8ZES41LK9ixmYTWFER21atmgFT3O
K/OhReCSQA/+/qK0INKuAIgDYp0Mxw==
=J5Oy
-----END PGP SIGNATURE-----

--GXw0TGVqm50qN3Wu--

