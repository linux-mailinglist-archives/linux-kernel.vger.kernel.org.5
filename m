Return-Path: <linux-kernel+bounces-67409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC26856B01
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053851C22930
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B908B137C59;
	Thu, 15 Feb 2024 17:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsUwywqh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9331369BF;
	Thu, 15 Feb 2024 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708018187; cv=none; b=jNVUdU0MRnRvFL3/Qtx+pLaJR3gqU84bfKY94+RJDmXEauzuQQLH5/vTHjVGDEJU07ECWXAZ2cDIhh89evBKsZHiLN+NcxRKt7EHTq2grX98ACE92S5emeY/7FhdHxi2MxeQSQ1ArLdD0pzshVrVO+5FPVp+nMmAPje4tn8CCxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708018187; c=relaxed/simple;
	bh=xGmTgBLilTN6fWGK0q/dhszZ3xW+TO9kc1nLJ9c0Cxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVaOVyWcJ8rupBF5yfssfwd76T/37WNZjmDHXTcxIlLfqEmPL1RfytuYoVfir4qEId+iblVl4hjeJ9PB3dhVJ3ZZsm60AxLNhdf8MiFKgJhPoMm87lgAtFwic48c/7d6/k4LltXN/tRGxHwRks+mmQwK5NGUZHJRfcIPVcSHU1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsUwywqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244D8C433C7;
	Thu, 15 Feb 2024 17:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708018186;
	bh=xGmTgBLilTN6fWGK0q/dhszZ3xW+TO9kc1nLJ9c0Cxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XsUwywqhBibh7Nv0quuN/TTKxrYrGRYyWGcYr7Abta1V0DhGrg3J9h9+bXqRGbnqw
	 v+A9ci8EMo3tJMFYYaws9C+AVD45z9PhoXPrjknlm2taJHmMpY4z1LkJXK36HDBBrG
	 I14DC3cwO+7HubyV/9pDwQHCxvHKzjXUf1/QzifXnL9poFyL6veVp3ydBJRS11vqIF
	 OMGrNZ0UiBonFgJnP5hSW8N9uwBERdhzIe7EVVcIfwxwno6mGTk6c2kSacy9ftzIqC
	 lg2xLO1mOveZ/UaT6BsOVC711kanQvq1aA6ZozLXRDNAkBZHBXI7SQ3xavWA3iDNBG
	 jrO7rv0XjiUMw==
Date: Thu, 15 Feb 2024 17:29:40 +0000
From: Conor Dooley <conor@kernel.org>
To: =?utf-8?B?UGF3ZcWC?= Anikiel <panikiel@google.com>
Cc: airlied@gmail.com, akpm@linux-foundation.org, conor+dt@kernel.org,
	daniel@ffwll.ch, dinguyen@kernel.org, hverkuil-cisco@xs4all.nl,
	krzysztof.kozlowski+dt@linaro.org,
	maarten.lankhorst@linux.intel.com, mchehab@kernel.org,
	mripard@kernel.org, robh+dt@kernel.org, tzimmermann@suse.de,
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	chromeos-krk-upstreaming@google.com, ribalda@chromium.org
Subject: Re: [PATCH 7/9] media: dt-bindings: Add Chameleon v3 framebuffer
Message-ID: <20240215-supervise-concerned-55a18554a120@spud>
References: <20240212131323.2162161-1-panikiel@google.com>
 <20240212131323.2162161-8-panikiel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C43cJgjesa1CmRR7"
Content-Disposition: inline
In-Reply-To: <20240212131323.2162161-8-panikiel@google.com>


--C43cJgjesa1CmRR7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 01:13:21PM +0000, Pawe=C5=82 Anikiel wrote:
> The Chameleon v3 uses the framebuffer IP core to take the video signal
> from different sources and directly write frames into memory.
>=20
> Signed-off-by: Pawe=C5=82 Anikiel <panikiel@google.com>
> ---
>  .../bindings/media/google,chv3-fb.yaml        | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/google,chv3-f=
b.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/media/google,chv3-fb.yaml =
b/Documentation/devicetree/bindings/media/google,chv3-fb.yaml
> new file mode 100644
> index 000000000000..ba6643cc7232
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/google,chv3-fb.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/google,chv3-fb.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Google Chameleon v3 video framebuffer
> +
> +maintainers:
> +  - Pawe=C5=82 Anikiel <panikiel@google.com>
> +
> +properties:
> +  compatible:
> +    const: google,chv3-fb
> +
> +  reg:
> +    items:
> +      - description: core registers
> +      - description: irq registers
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  google,legacy-format:
> +    type: boolean
> +    description: The incoming video stream is in 32-bit padded mode.
> +
> +  google,no-endpoint:
> +    type: boolean
> +    description:
> +      The framebuffer isn't connected to a controllable endpoint.
> +      The video interface still works, but EDID control is unavailable
> +      and DV timing information only reports the active video width/heig=
ht.

Why does this need a dedicated property? Is it not sufficient to check
that there are no endpoints in the devicetree?

Cheers,
Conor.

> +
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +allOf:
> +  - if:
> +      not:
> +        required:
> +          - google,no-endpoint
> +    then:
> +      required:
> +        - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    video@c0060500 {
> +        compatible =3D "google,chv3-fb";
> +        reg =3D <0xc0060500 0x100>,
> +              <0xc0060f20 0x10>;
> +        interrupts =3D <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> +        google,legacy-format;
> +        google,no-endpoint;
> +    };
> +
> +  - |
> +    video@c0060600 {
> +        compatible =3D "google,chv3-fb";
> +        reg =3D <0xc0060600 0x100>,
> +              <0xc0060f30 0x10>;
> +        interrupts =3D <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
> +
> +        port {
> +            fb_mst0_0: endpoint {
> +                remote-endpoint =3D <&dprx_mst_0>;
> +            };
> +        };
> +    };
> --=20
> 2.43.0.687.g38aa6559b0-goog
>=20

--C43cJgjesa1CmRR7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc5KBAAKCRB4tDGHoIJi
0lysAQDdxf2465AvkKhF49ZcHnwSHInQqU4NtSRwzZOwOHT1hQEAqOZCSrEz6g2o
2S9hN9oun805ifFuz83SNRi4jo99oAg=
=3pwD
-----END PGP SIGNATURE-----

--C43cJgjesa1CmRR7--

