Return-Path: <linux-kernel+bounces-9835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA6C81CC15
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4582830B7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176AC23765;
	Fri, 22 Dec 2023 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAfIdzz1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E4622F18;
	Fri, 22 Dec 2023 15:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A96C433C8;
	Fri, 22 Dec 2023 15:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703258345;
	bh=wSsIkqxATYMa5UJxXgmid2Oll6OKz7mFJxJg/rL87ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aAfIdzz1f4ffiiVuBpvEmy0hg1WYiPFOGaRWZYkq0tOIPEHfF0J1+GA0AWpOP0Ue5
	 vvh5qxkmZ9aQ/chvI3GkJAo4DdXlFR+scrjELUNoX2TzgOlUWIsUvMWM5tmTpduJBo
	 5aI4HCz1Xp3d1/CB1ksfcL8sOJ78AuKxxwniXWNP98ucDNEuCmZfLTfDunSt3PLKlc
	 VrNlkYspoP/yTUBV3cEDRP8+GGae/2kYooAbyg3FGkqg+JiF89W8B6dkvtH9QqsBoN
	 dpesWBP/br4b0TsNAR15mwcv0+vrmhJUgilejK7XnGEtH432gw66wDosnFsV7YC4oq
	 gHeceLtRddRRQ==
Date: Fri, 22 Dec 2023 15:18:55 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH 0/4] reset: gpio: ASoC: shared GPIO resets
Message-ID: <e3fa9582-bcf5-407a-9b17-783fd1453f2f@sirena.org.uk>
References: <20231222150133.732662-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cfx9Ht91O7Mwo0wc"
Content-Disposition: inline
In-Reply-To: <20231222150133.732662-1-krzysztof.kozlowski@linaro.org>
X-Cookie: Familiarity breeds attempt.


--cfx9Ht91O7Mwo0wc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 22, 2023 at 04:01:29PM +0100, Krzysztof Kozlowski wrote:

> I try to solve my case, hopefuly Chris' (2), partially Sean's (4) and maybe
> Hectors (5), using Rob's suggestion:

Hector's case wasn't an actual reset, it was a runtime power control, so
I'm not sure it'll fit there but otherwise this looks OK from an ASoC
point of view.

--cfx9Ht91O7Mwo0wc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWFqN8ACgkQJNaLcl1U
h9B9Dgf+J4td3JshFeqYWemOODB1NV3LYl68OZRErcrdtzvSKPeLBScAFOU0MfS+
9CDKWyHdbiMpAjlhUQ13E/kuMdjox9NMP4pNCJ7D4uxQrXbn5u+3R0wXGf5cZToM
B2La/7weV4yYnOPQ73uL5+5RRegYYa9jAYcaFN04Z/EBTbt2jg8lt40AuGW7bLVt
qb6Jr82C9YY5eenKxa/xIDDFGwP17i/uQh6jZ7DpI5RA0qS6hAQFmZGkgD8iTE+6
PEQdha8MDk5p5XajqQ+1ejDoTiuezdr81yXntBv6/PHd19mtUHL9qv5rOmtuGDcM
R+zkFrQmz7gHjj8uvg0nXqXSde7hog==
=7c2b
-----END PGP SIGNATURE-----

--cfx9Ht91O7Mwo0wc--

