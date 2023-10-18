Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E50B7CE19A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjJRPrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjJRPrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:47:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C784CD57
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:47:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5582BC433C8;
        Wed, 18 Oct 2023 15:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697644032;
        bh=InG035hMLurwAeKeC47GtRoHkwnqDLCor7MaeAfrvrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F/iCTYgucw81j5t/RFOEvdBl8DFGb/olHT6bk2KuaDxwbmqGgWgXwZt6uhSCCh8J6
         iiMHO9XX+z1cIxV1+FkRqR9NRC1NQPnerNOi7dCoS8MNaNIC7OBc8S3ymK5zRtnSc8
         NNVgzrA9OXwGP4MRpbxmbcRFN8vC09nKz1oMcN2FDhT8farNjT55ivsos0qOoNtQfo
         xkd/hZQ1GeHGSD4BcqSwkxxjZhyJg9JJZ1dSSSagNr0+It4bm4hn1Yjuu+rZnkaWu3
         FmqS6lLRDHggp7YxES1oWyAOuUnB4vS8ByC/Lj5deDk77lVgtMCyRFsfUC5DWWw1dI
         9PRhPZUHxs4tA==
Date:   Wed, 18 Oct 2023 16:47:07 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Anand Moon <linux.amoon@gmail.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: usb: vialab,vl817: remove reset-gpios
 from required list
Message-ID: <20231018-luminous-uncanny-f474a87bf2af@spud>
References: <20231018150448.1980-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RZusTGGTVMT5+wnc"
Content-Disposition: inline
In-Reply-To: <20231018150448.1980-1-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RZusTGGTVMT5+wnc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 11:04:48PM +0800, Jisheng Zhang wrote:
> The "reset-gpios" is optional in real case, for example reset pin is
> is hard wired to "high". And this fact is also reflected by the
> devm_gpio_get_optional() calling in driver code.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>=20
> since v1:
>  - remove th1520 usb dt-binding part, this isn't related.
>=20
>  Documentation/devicetree/bindings/usb/vialab,vl817.yaml | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/vialab,vl817.yaml b/Do=
cumentation/devicetree/bindings/usb/vialab,vl817.yaml
> index 76db9071b352..c815010ba9c2 100644
> --- a/Documentation/devicetree/bindings/usb/vialab,vl817.yaml
> +++ b/Documentation/devicetree/bindings/usb/vialab,vl817.yaml
> @@ -37,7 +37,6 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - reset-gpios
>    - vdd-supply
>    - peer-hub
> =20
> --=20
> 2.40.1
>=20

--RZusTGGTVMT5+wnc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZS/9+wAKCRB4tDGHoIJi
0pcOAQDuNchpYF/y/RhpvZGEw6IGgDbYw5KpnXkvSBk/zG0DQAD/VlbKt3FeHqNO
Yq/WDm0rrFeSleCyY2v6/pPl1EyEvAE=
=lUXz
-----END PGP SIGNATURE-----

--RZusTGGTVMT5+wnc--
