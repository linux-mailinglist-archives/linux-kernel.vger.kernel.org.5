Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BEF783ADB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjHVH2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjHVH2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:28:32 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC14611C;
        Tue, 22 Aug 2023 00:28:29 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9a18a4136a9so293926366b.2;
        Tue, 22 Aug 2023 00:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692689308; x=1693294108;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OoVq2aQG2PZ6wC1UnXS/aAZAjiDXppj1nzI2Mwf3CQQ=;
        b=KRHQTn0Lw9fL4mG8PDwSBodFOaNZs6uqJ+qlwNRe2n5irl1bXTwy6nPt3KKOmlmZcQ
         yoP8pDluiTyGH7Z1VM4WbDqj78Uw9jDQS0p0OwNEacSWCejeZ8jWf/f/AcUztyryOg82
         ScCQdOhAQhbhE1CjGf1bEuMhDt8tJWu3Ru1ev2guofZBFTPqKOF+n/DuvC5iXxovjAYn
         N5ZKWzSmnaIGBsjTi2B8/+2lX0ayZbVCZLXb0kwyxkSnpv+99RryxRrsXn9ZLlUac4qq
         fHm+OHGm3kLqduEQR2Wp6iKa31kNVONu4MXaMwrSfJRARRPfA0tnmvvBCl1ZpfMHn/BP
         VNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692689308; x=1693294108;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OoVq2aQG2PZ6wC1UnXS/aAZAjiDXppj1nzI2Mwf3CQQ=;
        b=a68h2AP9uuS2HRm6K2h4tzl8SYxs/vYZEa9KSQpPdTRR0STpd0GQrVC1zHVip9m0Fo
         uj6O7QCto0Gw+3f1IXfXnvt09iBkpQSnKAsyPDJx/hVPqbOhAbYupIknrN8FaGv42f7W
         ANR5Klc4+NOzXDuTcyJCqVxr2jUwl1dllTFKJkVT3NTDhJm856nJYWuYzm1RoBGpmVh8
         SFU0UmHG82HTvFw/iCx3PE1NlGuHc9PI4z7uQ6vch5zuzl08cDEJiHmQmSzMliojp1BP
         DRxn6XdNgbmr/XYaISxDo5XyDvWITcNzyVqJbJRZiEdMCaVUrvPVuENEXZ5Wra033+pO
         N/Cg==
X-Gm-Message-State: AOJu0YwfjWGmbSloYYXP4EJkrwsxMOiBU2+wlDKDkQKORWB9cTJfKrII
        P2d0cvdcHg4iYPrVCCQE0bU=
X-Google-Smtp-Source: AGHT+IGuCZUskIEAnTK1yBK8JvjWHA0h/ZsRkZiBDyyIrQMGbJhYCPi9BlOWE+x1YsXAUlJY+8x6Uw==
X-Received: by 2002:a17:906:2011:b0:99c:56d1:7c71 with SMTP id 17-20020a170906201100b0099c56d17c71mr6647307ejo.26.1692689307966;
        Tue, 22 Aug 2023 00:28:27 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id k21-20020a1709063fd500b0099bcf1c07c6sm7797573ejj.138.2023.08.22.00.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 00:28:27 -0700 (PDT)
Date:   Tue, 22 Aug 2023 09:28:25 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: pinctrl: Drop 'phandle' properties
Message-ID: <ZORjmR3QoYXCq18G@orome>
References: <20230819010946.916772-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lgwtEg2EGBEaqI76"
Content-Disposition: inline
In-Reply-To: <20230819010946.916772-1-robh@kernel.org>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lgwtEg2EGBEaqI76
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2023 at 08:09:44PM -0500, Rob Herring wrote:
> 'phandle' properties are implicitly supported on all nodes, so it
> shouldn't be listed in schemas.
>=20
> dtschema had a bug where 'phandle' and other implicit properties weren't
> being added under 'additionalProperties' schemas. That was fixed in
> v2023.07 release.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/pinctrl/ingenic,pinctrl.yaml          | 4 ----
>  .../devicetree/bindings/pinctrl/nvidia,tegra114-pinmux.yaml   | 2 --
>  .../devicetree/bindings/pinctrl/nvidia,tegra124-pinmux.yaml   | 2 --
>  .../devicetree/bindings/pinctrl/nvidia,tegra194-pinmux.yaml   | 2 --
>  .../devicetree/bindings/pinctrl/nvidia,tegra20-pinmux.yaml    | 2 --
>  .../devicetree/bindings/pinctrl/nvidia,tegra210-pinmux.yaml   | 2 --
>  .../devicetree/bindings/pinctrl/nvidia,tegra30-pinmux.yaml    | 2 --
>  Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml    | 4 ----
>  .../devicetree/bindings/pinctrl/renesas,rza1-ports.yaml       | 4 ----
>  .../devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml    | 4 ----
>  .../devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.yaml     | 4 ----
>  .../devicetree/bindings/pinctrl/renesas,rzv2m-pinctrl.yaml    | 4 ----
>  .../bindings/pinctrl/socionext,uniphier-pinctrl.yaml          | 2 --
>  13 files changed, 38 deletions(-)

I see it's already applied, but for the record:

Acked-by: Thierry Reding <treding@nvidia.com>

--lgwtEg2EGBEaqI76
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmTkY5YACgkQ3SOs138+
s6G7Fw//YU/MCCwoCZGynV8zKCE3BWyMblDBfcf7bn/Uusn5hLVSEBbMGzBihBhC
O0QO8tWasWfBLczIYRutySJdwL8s8ZPcF1c8RvahyFUi5BNxVwYu0GkTUzIIttmK
ZIuLn5dklgi91TLUZrqctAMNmCWG1+4lJJybRkvByzs/6gIhwdzrpd5TlHZC/0zy
A/UCgckYT0CS/WZKX6AQnPhHY4bm9bSL8keW0c0GbPHINefLftNx/IeDzUK/R5Nb
secRLpgtIxrqsnNPz0rsJeI9CCaffjLeeSjujyrZeuQD7/seU9snLyXIuVr9Mygr
KQTNfq0cm4iRuoIrVM3LXGp1P1lEmkWklMei4kGDR6JMeQbfftW1ppJr4PPKOUio
qzC3xjy7sT+ysZIu3dZYHtYjFt7Ntyfxyhlv2TttDPpSlAU1II6jBIzuMYiTli14
4vq+oG170nUmNoomfClWeSZZQTj3u74SrSiZISCYKHX+KZrh0pBFTXYpcHjo6Vfy
GMzD8E0wrNlokSxg0S1LO3v4h0OFGf0Sjt0bFiMixqBednxTdWSjqKzDsu4jH1KC
0Tr6VhJtgZNAdhyaZolLm/uS6/8s9JkXr+Ft27JS6UFxxyDG3coSNjqwN3NNxxt2
bJN6TBKhoiyMyApb7XM8WWwysYGiI6bElL9Kf6lpEX5vJbarvd0=
=PAJ0
-----END PGP SIGNATURE-----

--lgwtEg2EGBEaqI76--
