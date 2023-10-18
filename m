Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3F17CDE13
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344813AbjJRN6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344811AbjJRN57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:57:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCC111D;
        Wed, 18 Oct 2023 06:57:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B336C433C7;
        Wed, 18 Oct 2023 13:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697637476;
        bh=9CmkbilECnd6ujEwZdATorH+rM11Zfb8aq81/Ubbn+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u5AciNiqCUVqfWrstP1MVrMTugREQ2IjVcYCWzfDKjkJvtOw4vyyxAejqyWGMgDr8
         SOaeOx6lWLiKz0j2COAB/qb8L2Rm6KJ0BmJwOkAz2+T5KJt0zxK5cC85xMfkAIGJ/I
         zXlV7bSkmjWoqgUkK2EHknjEo3TYmU6RsXWTSMcQnKqVRS/mc3zy+Nvw/KGqgrbIDq
         WS3BUnm5hYQ8pG4q96QdFMtCW2HHwQEphyUsatEFi9RUg6ajwiaNYMpvyyj1Xc8Zfg
         QGgsQInTyaIo+Yph8bsl4vnh3DayUsBFEyi5F+nhFO/9JzkwCbQcplGGdoVRMVbVB0
         tiSuzu9D90oiQ==
Date:   Wed, 18 Oct 2023 14:57:50 +0100
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
Subject: Re: [PATCH v2 6/7] riscv: dts: thead: Enable BeagleV Ahead eMMC
 controller
Message-ID: <20231018-dating-yogurt-d7f3a65a873e@spud>
References: <20231017-th1520-mmc-v2-0-4678c8cc4048@baylibre.com>
 <20231017-th1520-mmc-v2-6-4678c8cc4048@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EJhQKjdNlUN6WevH"
Content-Disposition: inline
In-Reply-To: <20231017-th1520-mmc-v2-6-4678c8cc4048@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EJhQKjdNlUN6WevH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 01:43:52PM -0700, Drew Fustini wrote:
> Add properties to the emmc node and enable it and set the frequency for
> the sdhci clock.
>=20
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
>  arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/ri=
scv/boot/dts/thead/th1520-beaglev-ahead.dts
> index 70e8042c8304..bf55319ba950 100644
> --- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> +++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> @@ -52,6 +52,10 @@ &uart_sclk {
>  	clock-frequency =3D <100000000>;
>  };
> =20
> +&sdhci_clk {
> +	clock-frequency =3D <198000000>;
> +};
> +
>  &dmac0 {
>  	status =3D "okay";
>  };
> @@ -59,3 +63,13 @@ &dmac0 {
>  &uart0 {
>  	status =3D "okay";
>  };
> +
> +&mmc0 {
> +	bus-width =3D <8>;
> +	max-frequency =3D <198000000>;
> +	mmc-hs400-1_8v;
> +	non-removable;
> +	no-sdio;
> +	no-sd;
> +	status =3D "okay";
> +};

Is this file meant to be in alphanumerical order?


--EJhQKjdNlUN6WevH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZS/kXgAKCRB4tDGHoIJi
0ob5AQCRV10xGur/a43BpgYcA5A0R9y8m/5uK2GBbJL6LVr59QEAopmqh+brNf3r
URiqy36uFplvPJ9tsOe2/+aAmZRtWQU=
=DFYd
-----END PGP SIGNATURE-----

--EJhQKjdNlUN6WevH--
