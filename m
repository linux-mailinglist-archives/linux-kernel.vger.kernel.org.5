Return-Path: <linux-kernel+bounces-21111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 110A8828A08
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 240821C2467E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CDC39AF9;
	Tue,  9 Jan 2024 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tf2Lg3md"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE672A953;
	Tue,  9 Jan 2024 16:32:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496CCC433F1;
	Tue,  9 Jan 2024 16:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704817927;
	bh=skn/kd0lj/n94s6TTYlvAU/eDiNdCAKqCSmLkhxw9vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tf2Lg3mdzPb9Do2w61/NdSYk7cr1pry8fm1LB8dYwfEA8ZDAbUqSFacvBm46hVaCv
	 gseCXMnHKgodVEcuMHwx9mGW74dXLkDs4vkkpPbDib6YLe2JKWtfHu859owFxBoeyK
	 NXcxRMK3WlwKq9Bfx97hKJKuAZh9PzGsPMnPTGyOGBDOvmuPPRNdhLpTohdLeMq0Yc
	 0THnrs4KEHineUuaplpWiAYw1HXBUfkZpR8ocG7HrpQpDstp/NnTZO9W7wkq2NlqJk
	 kMVPvzR3tjBhfKv6PdF300V90IoP0A4oOt9TOhETMzpPlwWiDE82v2wqM6NN5R3pM9
	 Xe0+LCL9LufmQ==
Date: Tue, 9 Jan 2024 16:32:00 +0000
From: Conor Dooley <conor@kernel.org>
To: Shengyang Chen <shengyang.chen@starfivetech.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
	neil.armstrong@linaro.org, quic_jesszhan@quicinc.com,
	sam@ravnborg.org, airlied@gmail.com, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	wahrenst@gmx.net, dave.stevenson@raspberrypi.com,
	thierry.reding@gmail.com, changhuang.liang@starfivetech.com,
	keith.zhao@starfivetech.com, jack.zhu@starfivetech.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel: panel-simple: Add
 compatible property for waveshare 7inch touchscreen panel
Message-ID: <20240109-worsening-material-fae02ff4e611@spud>
References: <20240109070949.23957-1-shengyang.chen@starfivetech.com>
 <20240109070949.23957-2-shengyang.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IR02Rzu4WY2FHH6P"
Content-Disposition: inline
In-Reply-To: <20240109070949.23957-2-shengyang.chen@starfivetech.com>


--IR02Rzu4WY2FHH6P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 03:09:48PM +0800, Shengyang Chen wrote:
> The waveshare 7" 800x480 panel is a clone of Raspberry Pi 7" 800x480 panel
> It can be drived by Raspberry Pi panel's process but it needs different
> timing from Raspberry Pi panel. Add compatible property for it.
>=20
> Signed-off-by: Keith Zhao <keith.zhao@starfivetech.com>
> Signed-off-by: Shengyang Chen <shengyang.chen@starfivetech.com>
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple=
=2Eyaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index 11422af3477e..02f6b1b2ddc9 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -335,6 +335,8 @@ properties:
>        - vivax,tpc9150-panel
>          # VXT 800x480 color TFT LCD panel
>        - vxt,vl050-8048nt-c01
> +        # Waveshare 7" (800x480) touchscreen LCD panel
> +      - waveshare,7inch-touchscreen

Is "7inch-touchscreen" really a specific enough identifier for this
device?

>          # Winstar Display Corporation 3.5" QVGA (320x240) TFT LCD panel
>        - winstar,wf35ltiacd
>          # Yes Optoelectronics YTC700TLAG-05-201C 7" TFT LCD panel
> --=20
> 2.17.1
>=20

--IR02Rzu4WY2FHH6P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZ11AAAKCRB4tDGHoIJi
0vx9AQCV8uXH0qEaWc0GOrSxDu6YvkBzMwFW4Q2dCINJB3ujQAEAnK2VBDNXzYLX
fge09RVbAQLbLfs1Z29O1zBmZJrNPAo=
=KAKZ
-----END PGP SIGNATURE-----

--IR02Rzu4WY2FHH6P--

