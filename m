Return-Path: <linux-kernel+bounces-46861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03468445F9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7786B30F59
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2448E12C55F;
	Wed, 31 Jan 2024 17:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUXtqNz7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E70C12BF31;
	Wed, 31 Jan 2024 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720700; cv=none; b=mgonOdazaLYMAthGwf2tCEW6LF/S3TPLxiZt5sWj9LZ0Ko3FsiJNmX7RRz4FpyLhn1I0VoD7SLnI3X2OPYO67I108wmWWguILrrhqmIiBFW5LY7zD1SFPOywLwxse04iFUDhU+ZlGLZwtR4AKOmCdsqPPfDWD086NZECnsuYX3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720700; c=relaxed/simple;
	bh=9YBjQBTUa0AsexR9AXcn+W7TxL4szVC3nEnblkHVLqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1863vkuLyrzTUDaIpVW66Srlqw3+3jzHgLE+ESqNSuSm1xQ7WJhJlJ4Kgnhg0qQyN7t3CO2apqWbyei0myW+99eOcjVkFbDVvn5TRciuz7J3i/tzdM+5Iqwd82rJKidcVRryRylWnHPhVUZe+9ocZA7nmNOhOfxlVk5VVTjKp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUXtqNz7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7EDC433C7;
	Wed, 31 Jan 2024 17:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706720699;
	bh=9YBjQBTUa0AsexR9AXcn+W7TxL4szVC3nEnblkHVLqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mUXtqNz703J4tBh8rmN0JrlkMGOv5LDOfdJdGirHdtn9yFqKgSmiChPIweMFhkr0D
	 pbbqYoPCnTmdYCa2wut4tTj6V3vS4NABudZNCWdnJaCJpr/NyVcJ0efIu/1UkHE8bD
	 EOoKKrCTnHYTSvfCHXz6mY6qbtZGjOebH4e5PFIxNFNnxEPYGIFOS5tfkBiK2P4s5v
	 r86JGoRLqxS/qSolpwLyixZm3o1Iordd+RyB05djV9Z3cmAdyE8vH0yTNsqGugnYnF
	 66ERNywfc3bEnjhvd4NZqFYTd1pKhmX1671R3AZrd+OW66LnJgHksndcOSBfnfKfGe
	 iIyPdNrJuckzw==
Date: Wed, 31 Jan 2024 17:04:53 +0000
From: Conor Dooley <conor@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: sam@ravnborg.org, bbrezillon@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lee@kernel.org, thierry.reding@gmail.com,
	u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
	hari.prasathge@microchip.com, manikandan.m@microchip.com
Subject: Re: [linux][PATCH v5 1/3] dt-bindings: display: convert Atmel's
 HLCDC to DT schema
Message-ID: <20240131-buffing-defendant-546bb08a5927@spud>
References: <20240131033523.577450-1-dharma.b@microchip.com>
 <20240131033523.577450-2-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x4Faj0Fmly0DK799"
Content-Disposition: inline
In-Reply-To: <20240131033523.577450-2-dharma.b@microchip.com>


--x4Faj0Fmly0DK799
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 31, 2024 at 09:05:21AM +0530, Dharma Balasubiramani wrote:
> Convert the existing DT binding to DT schema of the Atmel's HLCDC display
> controller.

I feel like I recall a request to only have a complete example in the
mfd binding but nowhere else.

Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> +examples:
> +  - |
> +    display-controller {
> +      compatible = "atmel,hlcdc-display-controller";
> +      pinctrl-names = "default";
> +      pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb565>;
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      port@0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        reg = <0>;
> +
> +        hlcdc_panel_output: endpoint@0 {
> +          reg = <0>;
> +          bus-width = <16>;
> +          remote-endpoint = <&panel_input>;
> +        };
> +      };
> +    };

--x4Faj0Fmly0DK799
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbp9tAAKCRB4tDGHoIJi
0jA8AP9MiGr0thtxbrsJ240AB+1N/ysHZ34FcPCS6PQuuTSivQD9FfOKosMWG1g4
U7rnJqMxAnyYgkQlbQJQ2024xHr5fQ0=
=yRS/
-----END PGP SIGNATURE-----

--x4Faj0Fmly0DK799--

