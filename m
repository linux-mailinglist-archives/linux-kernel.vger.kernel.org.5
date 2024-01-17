Return-Path: <linux-kernel+bounces-28795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8205E83031A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1CA287CD1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4D91429C;
	Wed, 17 Jan 2024 09:58:22 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAB714294
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 09:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485501; cv=none; b=BUqY8ZhIbGWnAX52VJ5ibqlkOPvMRLPUcfw07qnk01rsv3GBLN8QZHpeVeSUC7U4Fm2Px8RZOZmRGvsPlOmFra3sA2Beq9/0bmg7Bc0n0O8I2WKHVCgN5HlbL2DAW2XDn3Qx6zWK6B/cHokbUOrlWlF/twXIvlcNCrOKo090I80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485501; c=relaxed/simple;
	bh=QGHHevF8YQdvBtIYC1f3KFH0iYomiMAEYr5gjnvwyQk=;
	h=Received:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:
	 X-SA-Exim-Scanned:X-PTX-Original-Recipient; b=cCi9qH1+JM+VJSDgYKuHOCWglvkxXR1oMtnYAKwxLZq5kn7XGTO/epUrI2cLqj/6puRUSDAgdnaokPAUlu9vfrook22ZMpQFuBSNTFiUx7S+JLb5S27xFtys35VDbAaVFn3KUm5h2aCpYtBrp56fgyEuur6neaxp+rwZTpDECuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rQ2gS-0005ZN-8j; Wed, 17 Jan 2024 10:58:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rQ2gP-000QyH-KQ; Wed, 17 Jan 2024 10:58:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rQ2gP-001Zpp-1k;
	Wed, 17 Jan 2024 10:58:05 +0100
Date: Wed, 17 Jan 2024 10:58:05 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org, JunYi Zhao <junyi.zhao@amlogic.com>
Subject: Re: [PATCH v4 2/6] dt-bindings: pwm: amlogic: add new compatible for
 meson8 pwm type
Message-ID: <4rdb2be2bfzak3s4uaizthcdcdwdrxnx4kr2sgn527hvsie3pb@gfqciim7yryz>
References: <20231222111658.832167-1-jbrunet@baylibre.com>
 <20231222111658.832167-3-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gr6tisr4x6hvjf6f"
Content-Disposition: inline
In-Reply-To: <20231222111658.832167-3-jbrunet@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--gr6tisr4x6hvjf6f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Dec 22, 2023 at 12:16:50PM +0100, Jerome Brunet wrote:
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Doc=
umentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> index a1d382aacb82..eece390114a3 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> +++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> @@ -21,23 +21,35 @@ properties:
>            - amlogic,meson-g12a-ee-pwm
>            - amlogic,meson-g12a-ao-pwm-ab
>            - amlogic,meson-g12a-ao-pwm-cd
> -          - amlogic,meson-s4-pwm
> +        deprecated: true
>        - items:
>            - const: amlogic,meson-gx-pwm
>            - const: amlogic,meson-gxbb-pwm
> +        deprecated: true
>        - items:
>            - const: amlogic,meson-gx-ao-pwm
>            - const: amlogic,meson-gxbb-ao-pwm
> +        deprecated: true
>        - items:
>            - const: amlogic,meson8-pwm
>            - const: amlogic,meson8b-pwm
> +        deprecated: true

I think deprecating the old binding and adding a new compatible should
be done in two commits.

> +      - const: amlogic,meson8-pwm-v2
> +      - items:
> +          - enum:
> +              - amlogic,meson8b-pwm-v2
> +              - amlogic,meson-gxbb-pwm-v2
> +              - amlogic,meson-axg-pwm-v2
> +              - amlogic,meson-g12-pwm-v2
> +          - const: amlogic,meson8-pwm-v2
> +      - const: amlogic,meson-s4-pwm

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gr6tisr4x6hvjf6f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWnpKwACgkQj4D7WH0S
/k6AaggAin0jCt53AVKx89sNgzh9ZmocciEzqNU5jAkggiecMPVDrBNA50/rCvpN
9IUDrfQxZcFW4/bzKGeFsD/kww1TuC23erTmXdTmDSo9jMJfU6EEAkMcya0KMfyZ
Eu6/6wpNdkDNodfkhHMmLYq0ghfI4Q5ivtv21BxInc3jCfm85jhpjwAA840Z11WK
Rpl85eBQPbgHWrEZu8kL3i1V11nStyVoJg8q3b1wsNWxjZGfN/3bGBq9D9smBa79
tv0wLo/wfoxEgj+t5afko75zR8/bFoslSp96gLI+NdKf597Skd0U44MhMeztiAp1
SYIMrB7UsPDMFZETx8Wulu/Jh2Pk+w==
=bl1g
-----END PGP SIGNATURE-----

--gr6tisr4x6hvjf6f--

