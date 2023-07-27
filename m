Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9E0765715
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbjG0PL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjG0PLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:11:23 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3671BD1;
        Thu, 27 Jul 2023 08:11:19 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-992ca792065so144784966b.2;
        Thu, 27 Jul 2023 08:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690470678; x=1691075478;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rf62hs1ejTaEIoI4FqGDyw6TQJaaolUeJwHL+w88ryc=;
        b=IjlQLHyUnHEu00B7Qy6f+Y30kxLDfQmNfxvNcD9bv1Us+i0FAly0rXozGaKPjyS5x2
         IOLkzjcBw5qe3HpewfeKx9KS0MAVrcK8L4GrBfTtvXmcOYkxqXAAL57Kl3f2ML6NdWRD
         m9uZNIEtj+6VQwA4cOk5eglj64/c+h+WNVwFoYmAnFB7aDuXg6cFv1ZTOzkLfcemeQFT
         JQQeddoqzon5fpmXewvVwuQX2wtF4fYHHLfXlA1jO2DOQGPYA/mlt0CjS7q5AkdUOgiM
         /MX8Prfu0jUq5iqATseYSaWMH0kl2FgG/za6tNKLGy+bqtz705NQW49/Z4n0R4bt0bjt
         EB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690470678; x=1691075478;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rf62hs1ejTaEIoI4FqGDyw6TQJaaolUeJwHL+w88ryc=;
        b=YieXcPJZLvdU01xWRx8g++ti6wXPUekaOt6dsHbNyH/D9POq0LRVXA2fezF8C3cM8M
         asOuRRhz9u7pp53/lXmRirfXv8gaRR/girqwYUUme0LUtA3MBX+cYMVgyaBJAtoH5nAs
         LGafL68XmJFnP99Pfbp0/ncA2w6YoKtjTfa4JOKCrbQDCHoIbTFoGhbNNtl/3aQF6jOv
         wLXfabMczNw4MB7Fw8cbXIYfS9I+c5+3cnDYLNVCL4Q+HPlpP7/ho8h3PPUJmY/0lz5S
         CaBszZHRo0TxgqQdNhQ3ZNtYcx7qKl759n7z7JurxCsstMxltPBSTK5swXzevP8dOMBU
         +TzA==
X-Gm-Message-State: ABy/qLbIJqplun6EpHfdn6qncoN74LwPPGlZWfU/f77m2Jis6feCt2/L
        gpQFp3SQLmGwtEXkNFiLixU=
X-Google-Smtp-Source: APBJJlEl+Qg5j7Vyl8VRwP5KwrQQXAuT04cxYsbyyz4Rv/CKQmt3ycUxpq1s6g46wacCBDYhC+c7dQ==
X-Received: by 2002:a17:906:5a60:b0:974:1ef7:1e88 with SMTP id my32-20020a1709065a6000b009741ef71e88mr2260231ejc.13.1690470677961;
        Thu, 27 Jul 2023 08:11:17 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id j16-20020a170906831000b00993cc1242d4sm869521ejx.151.2023.07.27.08.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 08:11:17 -0700 (PDT)
Date:   Thu, 27 Jul 2023 17:11:15 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/2] ARM: tegra: transformers: add connector node
Message-ID: <ZMKJE1G87-jWeg2_@orome>
References: <20230618085046.10081-1-clamor95@gmail.com>
 <20230618085046.10081-3-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hlXONs87O1x4A5Mj"
Content-Disposition: inline
In-Reply-To: <20230618085046.10081-3-clamor95@gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hlXONs87O1x4A5Mj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 18, 2023 at 11:50:46AM +0300, Svyatoslav Ryhel wrote:
> All ASUS Transformers have micro-HDMI connector directly available.
> After Tegra HDMI got bridge/connector support, we should use connector
> framework for proper HW description.
>=20
> Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS TF T30
> Tested-by: Robert Eckelmann <longnoserob@gmail.com> # ASUS TF101 T20
> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # ASUS TF201 T30
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  arch/arm/boot/dts/tegra20-asus-tf101.dts      | 22 ++++++++++++++++---
>  .../dts/tegra30-asus-transformer-common.dtsi  | 21 ++++++++++++++++--
>  2 files changed, 38 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/tegra20-asus-tf101.dts b/arch/arm/boot/dts=
/tegra20-asus-tf101.dts
> index c2a9c3fb5b33..97350f566539 100644
> --- a/arch/arm/boot/dts/tegra20-asus-tf101.dts
> +++ b/arch/arm/boot/dts/tegra20-asus-tf101.dts
> @@ -82,9 +82,11 @@ hdmi@54280000 {
>  			pll-supply =3D <&hdmi_pll_reg>;
>  			hdmi-supply =3D <&vdd_hdmi_en>;
> =20
> -			nvidia,ddc-i2c-bus =3D <&hdmi_ddc>;
> -			nvidia,hpd-gpio =3D <&gpio TEGRA_GPIO(N, 7)
> -				GPIO_ACTIVE_HIGH>;
> +			port@0 {
> +				hdmi_out: endpoint {
> +					remote-endpoint =3D <&connector_in>;
> +				};
> +			};

Does this need a bindings change? nvidia,tegra20-hdmi currently doesn't
support OF graphs, so this would probably fail to validate if we merge
it without a corresponding DT bindings update.

Thierry

--hlXONs87O1x4A5Mj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmTCiRMACgkQ3SOs138+
s6E9qxAAlNVbjPuB+C8Cgsu4EsoY/eiPXDFu2GUEmDJ9NdiJs1gnzIfBd6o53zjW
58Ozc/9jcrMoqjO8yhCtF/5DxZL3EQnyjIat/VQI5wd8bUjJwqrE8N/TAgcOU9qR
q3EWJs51pe0QQGImdz5hadlzRHIVIFtMJsCKTEvfytYiRkM5DIAN0JFEPqIWTJ8u
08aZaATSY16sPtnvu6Kao0tZfCkY5nrrS5/81EJ4cfMxYyhR0WtEr7AQdLOfWh3l
9p/v3+wZheNbgfy+3Rq2wWVPFoZ6GZgzr+LOSbt9TsV8neyqKTE75PF2Ni3cUhGd
+KWyVNinysYAkGmsPEhwkNhbBF6re4ZtKL+9VZTMxFNMgrJev8V6wIMZIBjhHseW
g35apJYPFtnW6JEz108iexlCDOrV9Q5cLnA4eM/8nOoWd9/2oWtPhSYKQDJz1MYf
7V13e+u11thmiGysZ1SP8SpN7ZV3zyWAxBqx3/vniObofLGkG8mN9/e5kuHblYB4
S8JVwYmxATIL/gFPwng9xojBWxYyy++QvQI7enHjtRXcS+3wmYOIWYLul+r7AQ+/
18kdezTzOIEGKtqtIusmMwJN048x48I5fcU6Xea2Ov2Wzwf0LcJx5iK+MJMvt4U5
j7bk6I8DsMu3/n98qAUGr5ZvBulb6Qp9M5c6e4aS/NEDCbM3gp0=
=emKT
-----END PGP SIGNATURE-----

--hlXONs87O1x4A5Mj--
