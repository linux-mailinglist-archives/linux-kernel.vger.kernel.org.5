Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C42A7BC6D8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 12:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343829AbjJGKgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 06:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343795AbjJGKgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 06:36:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D7392;
        Sat,  7 Oct 2023 03:36:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68AA1C433C7;
        Sat,  7 Oct 2023 10:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696675006;
        bh=v/WXLYgb6BqL0vB6xdnedE9f7p/YOe7av+z9qkOq7uA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EydEweVS2gYgQ/Oe74RNgW8PQDVzQb6T0RPXODOvwckxP035KnxcqNvx3oLt2DRZ1
         xNXOjvkOpibee6glErXh+thqtj+egVYMvkHFz5wUjoa1UpfCZ0OlAC99sblt3/NNFY
         /zyCtRDNtAsrEiKVkplhwSVnMmlWXhyrflDM1DbzloorbBsa6iEuFbjSr7AjNiQvoj
         dbKl4yzUC6Ophv0YLYbpqzob61wG83ZZ/Sj7vdenJd4LvO9RYpQEdiqMx4kEcPQtPJ
         IOBiWp+axF3rg4xOlmb8yn7ox8F8ZVLQo1zIwUn9PUddaeM2GEhcici4/zdlT4FV3i
         WRblF+z/yNZ7A==
Date:   Sat, 7 Oct 2023 11:36:42 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Hermes Zhang <Hermes.Zhang@axis.com>
Cc:     sre@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, kernel@axis.com,
        Hermes Zhang <chenhuiz@axis.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: bq24190: Add BQ24296
 compatible
Message-ID: <20231007-tablet-hunk-d9f13553831a@spud>
References: <20231007020701.1912553-1-Hermes.Zhang@axis.com>
 <20231007020701.1912553-2-Hermes.Zhang@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GAidJ2fG47DIHjuO"
Content-Disposition: inline
In-Reply-To: <20231007020701.1912553-2-Hermes.Zhang@axis.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GAidJ2fG47DIHjuO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 07, 2023 at 10:07:00AM +0800, Hermes Zhang wrote:
> From: Hermes Zhang <chenhuiz@axis.com>
>=20
> The BQ24296 is most similar to the BQ24196, but the:
> 1. OTG config is split from CHG config (REG01)
> 2. ICHG (Fast Charge Current limit) range is smaller (<=3D3008mA)
> 3. NTC fault is simplified to 2 bits
>=20
> Signed-off-by: Hermes Zhang <chenhuiz@axis.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/power/supply/bq24190.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.yaml =
b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
> index d3ebc9de8c0b..131b7e57d22f 100644
> --- a/Documentation/devicetree/bindings/power/supply/bq24190.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
> @@ -20,6 +20,7 @@ properties:
>        - ti,bq24192
>        - ti,bq24192i
>        - ti,bq24196
> +      - ti,bq24296
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.30.2
>=20

--GAidJ2fG47DIHjuO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSE0uQAKCRB4tDGHoIJi
0hrxAP40V/Cau0h6qS7og70nKzPelwXlSpyduLWH0G01c9ppeQD/f1uvwHm3CvW0
Ns685SiP/CB2FAMoZRYOpbFLNvuxBQ4=
=lpUM
-----END PGP SIGNATURE-----

--GAidJ2fG47DIHjuO--
