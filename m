Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F2D7D6E02
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344599AbjJYN7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344545AbjJYN6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:58:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F19132;
        Wed, 25 Oct 2023 06:58:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68816C433C8;
        Wed, 25 Oct 2023 13:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698242329;
        bh=UlTZEI3okYwEXOfqTgk+bCPT0BOZMTu5VbgUq9Mk0hM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gESLI8s/yysIu3Do5iEPzsQY1bHaGM5GwL/ilzz2jiuw8Ib3qR/2Tp+kj7zV6XWUP
         wRgW1ZPNuhRjAJux9fc4IV56ezNfgMAQA8xW9Q/Fic2WvO9b+2XfWrGVXMtlp+L7QA
         DdWghilDA8bvvmshc+0rLvXIYGp5VufLYpjhbv/Txo1k8YotgvxprDQss49FrwuyrW
         a3Y+29MwjuUUiAzAIzaxORwMtq06jC5KlZeYnE6olvpLtC2XFkWAhGpML7ZC3vIvPI
         3kaNYGI3B1jxfdYtN1nHACAk2nG/0Sg86FKHQUEPTVnkXAzZs7pa2S/wlb3g3Cffji
         yd8xYIhECv5gw==
Date:   Wed, 25 Oct 2023 14:58:44 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Richard Leitner <richard.leitner@linux.dev>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: hwmon: ti,ina238: add ti,ina237
Message-ID: <20231025-unclip-ion-826a58681a12@spud>
References: <20231025-ina237-v1-0-a0196119720c@linux.dev>
 <20231025-ina237-v1-4-a0196119720c@linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pE6BoEu0EbdyHUId"
Content-Disposition: inline
In-Reply-To: <20231025-ina237-v1-4-a0196119720c@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pE6BoEu0EbdyHUId
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 10:34:14AM +0000, Richard Leitner wrote:
> Add ti,ina237 binding to ti,ina238 as they share the same driver.
>=20
> Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
> ---
>  Documentation/devicetree/bindings/hwmon/ti,ina238.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina238.yaml b/Doc=
umentation/devicetree/bindings/hwmon/ti,ina238.yaml
> index aba89e5f34b3..17408076696c 100644
> --- a/Documentation/devicetree/bindings/hwmon/ti,ina238.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/ti,ina238.yaml
> @@ -22,6 +22,7 @@ description: |
>  properties:
>    compatible:
>      enum:
> +      - ti,ina237

The driver patch you have done implies no difference between the
programming model for both of these devices. It'd seem to make more sense
for the ina237 to fall back to the ina238, thereby requiring no change in
the driver to support it.

Cheers,
Conor.

>        - ti,ina238
> =20
>    reg:
>=20
> --=20
> 2.40.1
>=20

--pE6BoEu0EbdyHUId
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTkfEwAKCRB4tDGHoIJi
0pu2AQCAxnniBjz6rcPwfkiVyxIlV2tWkTei9kpP4WDrtKDCdwD+OebGU9904K9V
R2HVKdB53Bhw0pxQXt5EW4gUi6BysQI=
=tFzz
-----END PGP SIGNATURE-----

--pE6BoEu0EbdyHUId--
