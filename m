Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45157AAEEF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjIVJ5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjIVJ5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:57:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1AF194;
        Fri, 22 Sep 2023 02:57:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69C9C433C7;
        Fri, 22 Sep 2023 09:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695376662;
        bh=Lfg64vDBMqqMuekyEShYM/GguXqls4PxLGqLNLeMVQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t/RhEJc/+n34ONrY1ylE/pq0kRonnc5VfiydY7HWO0N7NLeIPD9XgdaKB7qtHPncW
         w/KRdPGIAAuNEyrQQMZ+W1b8CwWq2Mm7oCk155jEUQgJnIw/dAIQQufz6XX0z5FUJm
         j4IduZfdMbcSk22cStuwAjqbG2JFRFXzjrwPghF2COD60L6et/QMuPOaGxM22iGIoy
         AO/NWv/iTykwQE3Xkn+ckgNaOBkbi+Yw3D5g82qapaTx9VY7iWO0PmAh0zSmHvESv5
         j3HepWM0yPGlL3F674r9723GkHHfevPS/eC8ej8KuR5Vq6+Kjm5z6MNNRlHcj+5TnT
         d13G5qryQ6mRA==
Date:   Fri, 22 Sep 2023 10:57:36 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Xi Ruoyao <xry111@xry111.site>, Han Gao <gaohan@iscas.ac.cn>,
        Icenowy Zheng <uwu@icenowy.me>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/6] dt-bindings: mmc: sdhci-of-dwcmhsc: Add T-Head
 TH1520 support
Message-ID: <20230922-parish-ice-a22e93dc3027@spud>
References: <20230921-th1520-mmc-v1-0-49f76c274fb3@baylibre.com>
 <20230921-th1520-mmc-v1-1-49f76c274fb3@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eawcWMQ/3FYJXdeS"
Content-Disposition: inline
In-Reply-To: <20230921-th1520-mmc-v1-1-49f76c274fb3@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eawcWMQ/3FYJXdeS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Drew,

On Thu, Sep 21, 2023 at 06:49:48PM -0700, Drew Fustini wrote:
> Add compatible value for the T-Head TH1520 dwcmshc controller and add
> thead,phy-pull-up property.
>=20
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
>  Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yam=
l b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> index a43eb837f8da..46b768d46712 100644
> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> @@ -19,6 +19,7 @@ properties:
>        - rockchip,rk3568-dwcmshc
>        - rockchip,rk3588-dwcmshc
>        - snps,dwcmshc-sdhci
> +      - thead,th1520-dwcmshc
> =20
>    reg:
>      maxItems: 1
> @@ -60,6 +61,9 @@ properties:
>      description: Specify the number of delay for tx sampling.
>      $ref: /schemas/types.yaml#/definitions/uint8
> =20
> +  thead,phy-pull-up:
> +    description: Enable weak pull-up on PHY pads
> +    type: boolean

Why is the weak pull-up required? How would the dts author know if they
need to use this property?

Thanks,
Conor.

> =20
>  required:
>    - compatible
>=20
> --=20
> 2.34.1
>=20

--eawcWMQ/3FYJXdeS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQ1lEAAKCRB4tDGHoIJi
0ur5AP9J83si/VNah9uXWQh6yWcqwodTBG01tc11Lr8CYSXRhAEAs3heA19N2euY
iKJcToy85ytl2YnADrdTAOVK+RzGMgE=
=kKS5
-----END PGP SIGNATURE-----

--eawcWMQ/3FYJXdeS--
