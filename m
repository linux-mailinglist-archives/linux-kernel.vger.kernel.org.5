Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C600813517
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573870AbjLNPoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573871AbjLNPoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:44:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA85D124
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:44:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D31BC433C8;
        Thu, 14 Dec 2023 15:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702568664;
        bh=XBqa/1I+JHuWGz1jvrpWZgqtc0G2D3jLjnviRzFB300=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o1HbXFA6KBPaAeDskIWyUusDha+Tj/GoqkRvGesnO53UHQ+ywSZaKmoYN9+Rrg7ir
         U2KyDjP+GZRFXHKOLzXrbUN56opS7XpA8Taslo1Kui4vLx97EXO2rDWDMmcD7eCOgV
         ZV4CnGzuaJ1BFEBrPF1o+4JPFS+RUN1kgf5FrdcB6VG/5bu+WHXGX3VyrvWRRAaN03
         wKCGpXZejVQstBE1o7g6AmYFCOP9kNkFYzNAqzl767YS/c07KCHgKL4OklWK3q+NsE
         7yObj2/Sutnzx5BQo5m6saXZAZLUeKtz5CMMckxCTYdzo5T6hPDnb9AfoECMBRFq2p
         P32G5SX2JDdlA==
Date:   Thu, 14 Dec 2023 15:44:19 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 03/16] dt-bindings: clock: qcom: Add missing UFS QREF
 clocks
Message-ID: <20231214-doormat-divinity-a3075c35ad13@spud>
References: <20231214091101.45713-1-manivannan.sadhasivam@linaro.org>
 <20231214091101.45713-4-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YD1SRurG6FcYRAfF"
Content-Disposition: inline
In-Reply-To: <20231214091101.45713-4-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YD1SRurG6FcYRAfF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 02:40:48PM +0530, Manivannan Sadhasivam wrote:
> Add missing QREF clocks for UFS MEM and UFS CARD controllers.
>=20
> Fixes: 0fadcdfdcf57 ("dt-bindings: clock: Add SC8180x GCC binding")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  include/dt-bindings/clock/qcom,gcc-sc8180x.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/include/dt-bindings/clock/qcom,gcc-sc8180x.h b/include/dt-bi=
ndings/clock/qcom,gcc-sc8180x.h
> index e893415ae13d..90c6e021a035 100644
> --- a/include/dt-bindings/clock/qcom,gcc-sc8180x.h
> +++ b/include/dt-bindings/clock/qcom,gcc-sc8180x.h
> @@ -246,6 +246,8 @@
>  #define GCC_PCIE_3_CLKREF_CLK					236
>  #define GCC_USB3_PRIM_CLKREF_CLK				237
>  #define GCC_USB3_SEC_CLKREF_CLK					238
> +#define GCC_UFS_MEM_CLKREF_EN					239
> +#define GCC_UFS_CARD_CLKREF_EN					240
> =20
>  #define GCC_EMAC_BCR						0
>  #define GCC_GPU_BCR						1
> --=20
> 2.25.1
>=20

--YD1SRurG6FcYRAfF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXsi0wAKCRB4tDGHoIJi
0pBnAP4lCEUnoDhuz+rT6c8a+4OyViA4Yn29QqeYkVxQEbHBWwEAoL2PGPrEe67K
0Tqm1woma0AIcYjuS2n/3Jh6F+rFQQw=
=F89W
-----END PGP SIGNATURE-----

--YD1SRurG6FcYRAfF--
