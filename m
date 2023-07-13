Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D55A7526B3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbjGMPXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbjGMPXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:23:23 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2B8B4;
        Thu, 13 Jul 2023 08:23:20 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b701e1c80fso12860501fa.2;
        Thu, 13 Jul 2023 08:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689261798; x=1691853798;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDdZgOhDwUbK510C1X15KxW/EG5tgfWQIVz4txl1afI=;
        b=aq15ubxvRNdsaCsSt+kBMeyxULatVGXhLV/oJNfEBNz4NH9P8UDfSfZNFWO759cuUQ
         +AasouInhogNlRR1JHCjmUXxymnZm9IRn0aunfamqApmNTEWZnUGy3noDG28Hmvx8QSe
         nkAHLpsqt0ezPyoSpUZerB3vedGgcXb9rDE+AOgJrqPxwaBFk3e5SIJHbf+BqstYcvAb
         Yx2OMdqLY4bCXMlJLye35sn7xdpYFjM/4OyIAPMwTV3kfuin4nciqiHvcJwbFzpVOGDk
         X248s0GTzW9BQuBxsB6pygWi5IaIrJVR+NKKGwtT02cwy7uZRiURAyG5JJ9K3yztqoqa
         gejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689261798; x=1691853798;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDdZgOhDwUbK510C1X15KxW/EG5tgfWQIVz4txl1afI=;
        b=GmCKAFxZXkOdhNzBOlNhMygHzm+ZOA5/DiZhhFf6L4wu8NHvbHYgIML4dPbx9XSqta
         E0Fj6WFOAP9/gCSyV9Gc++kgeoFi8gHBCkxouJPmTGEjJoyTcF48yQi5IH3fK/+ZQA2w
         cZr/gMptZ7066g82lw6f4aomW4Z4bEx9N3Hd3fxfnc2pF+t2r/U1vWmkSJPVR54cNVkJ
         p6YHKpud+kblIpqsXYC7L0qEfLw2t5Ya0V+wWE+2CnvG3Ho+Gtd4dHcxQHRvGAha02/M
         23IlEusNBbXS+WMeLreU43MJE9y78n+04EOOHdhivyzotu7xjDXmlqvE04ps206gr73x
         JxeQ==
X-Gm-Message-State: ABy/qLYXz/qJJT2fr3VFIGra9TRwt21RBgm7jwG8x/PKjlJtxh9SPxyh
        cCawAVBQfQxKYXWdGox4fAI=
X-Google-Smtp-Source: APBJJlGtS2kjxCSUsa7LiR/rlP5gKiBaQi1jHjxIr+7psMeetmuzRa7ztrfPj7ELY+BkJUP5jG6Tew==
X-Received: by 2002:a2e:9f48:0:b0:2b6:a841:e686 with SMTP id v8-20020a2e9f48000000b002b6a841e686mr1558356ljk.6.1689261798215;
        Thu, 13 Jul 2023 08:23:18 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id w24-20020a1709064a1800b00993b381f808sm4144700eju.38.2023.07.13.08.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 08:23:17 -0700 (PDT)
Date:   Thu, 13 Jul 2023 17:23:16 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sameer Pujar <spujar@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH 1/2] arm64: tegra: correct audio-codec interrupt flag
 in P2972-0000
Message-ID: <ZLAW5MbvvNDI5xVG@orome>
References: <20230705064903.12690-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xksoUh4HTTxon0ro"
Content-Disposition: inline
In-Reply-To: <20230705064903.12690-1-krzysztof.kozlowski@linaro.org>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xksoUh4HTTxon0ro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2023 at 08:49:02AM +0200, Krzysztof Kozlowski wrote:
> GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
> These are simple defines so they could be used in DTS but they will not
> have the same meaning: GPIO_ACTIVE_HIGH =3D 0 =3D IRQ_TYPE_NONE.
>=20
> Correct the interrupt flags to a value used also in Tegra30 Beaver board
> with this device.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Sameer,

I can help test this if you're busy, but I don't know how to test
whether this work correctly. Can you share how we can validate this?

Thierry

>=20
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/ar=
m64/boot/dts/nvidia/tegra194-p2972-0000.dts
> index 64a3398fe7a6..7c400e024332 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> @@ -2115,7 +2115,7 @@ rt5658: audio-codec@1a {
>  				compatible =3D "realtek,rt5658";
>  				reg =3D <0x1a>;
>  				interrupt-parent =3D <&gpio>;
> -				interrupts =3D <TEGRA194_MAIN_GPIO(S, 5) GPIO_ACTIVE_HIGH>;
> +				interrupts =3D <TEGRA194_MAIN_GPIO(S, 5) IRQ_TYPE_EDGE_FALLING>;
>  				clocks =3D <&bpmp TEGRA194_CLK_AUD_MCLK>;
>  				clock-names =3D "mclk";
>  				realtek,jd-src =3D <2>;
> --=20
> 2.34.1
>=20

--xksoUh4HTTxon0ro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSwFuQACgkQ3SOs138+
s6EF8hAAu0zsCKA2Yrn6/fsfj3JiENpzFXVJ6Yp5vT6S1nGw3AT8rC0z0Ex0GQnJ
/pFFGSRZxL5rvdEntN8p8vGiciXSe8Cq6GFVVY21nAhoBXRUtR/6P1gNQaXsOS8B
xy/ItfGo1eb4/lFb4tfei3wYDHtn2LphlpI3vaS0eHLgccIm3qpQfC/dAB7VZ7Dl
Kmup0EG9cbdMj/OOtRu8SDi05taM11mIafNIafY3qgVlSmb4myCfu4Na0ugoKfXE
t+072lN2PXlaCwEWDYk0Njsl+HD7aYF3vFE9vTcGlblIftRfSIQslN88VZLQ2Gnd
QAFYqRKsKr0zLWFqBMI5WXK/BZg2/JjvLld0apJ9G22JqumMETTEs66eLNWy37jn
z5jU51ZfM9iqx7DzNdcC+YwEjQr99JFp4LDP0Xj+i5/0rpl7s8JothGdRgSSPIBu
qYoNrQsl4OV65Vg3oZEye/bzhBz0XkuRX9IMqo9VWHZ1GfXpFqbpNhwphycqTiXh
UGEOa6nw3+bXpLToP4/x+3ixnp6ktQixFbbTpVeqqDWlvYEJE9igUffMubtKUvS4
J4N8ddNL5mnW1hy86F+csNnR9ubDUWtacaYOlasDRD2pWUn++EDaCMHqqt7yA3h0
zzdr5z9ZjBUb5hNMPq0Z4kJu9VZhp86EggIZE7zvJeCodSG46Y0=
=41Bt
-----END PGP SIGNATURE-----

--xksoUh4HTTxon0ro--
