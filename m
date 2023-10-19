Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BE57CFC1B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346027AbjJSOIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345723AbjJSOIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:08:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFF6131;
        Thu, 19 Oct 2023 07:08:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D62C433C7;
        Thu, 19 Oct 2023 14:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697724523;
        bh=lhJF9TO9qDHVZeczKmduBiUarXg9CHGv9aAPKmSdQ6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QhQVvKe+lXrjNK7ePC/gXDPrdG3kPTYXMjuEAqKdYUOV4fiTPEQuxTfT75OKdP6OF
         nBDPC2sDE6D2AjjKu6FXtrSWRIGa8S/pUSFzzxvkz21Q0Uzpr+b3ZDRWp5rzqYbyLu
         9lPxQrg7COBuzoyyEPfMs3X4oRXx5aeUmRC5r/oyxvlbpiTLI19gL30tE1+jof7mK5
         7FSwVDXVj2TZZVelKsPa/KsJ7oQmi1lSLu5Zp1yPHxv6+yT8k8z/QjljZdEKkpHae/
         jkFUaXelPQurfONpAp4IdUIMSKPS+XymSCnYa0DsA2vnIKXhC+GT4wZP13ypmsmJTV
         aJqqOd8zUyL4A==
Date:   Thu, 19 Oct 2023 15:08:38 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     lee@kernel.org, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andy.shevchenko@gmail.com, kernel@sberdevices.ru,
        rockosov@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 11/11] dt-bindings: leds: aw200xx: fix led pattern and
 add reg constraints
Message-ID: <20231019-clarify-unstopped-71fe018b6a8b@spud>
References: <20231018182943.18700-1-ddrokosov@salutedevices.com>
 <20231018182943.18700-12-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="583YNsUVrmxxvyQI"
Content-Disposition: inline
In-Reply-To: <20231018182943.18700-12-ddrokosov@salutedevices.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--583YNsUVrmxxvyQI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 09:29:43PM +0300, Dmitry Rokosov wrote:
> AW200XX controllers have the capability to declare more than 0xf LEDs,
> therefore, it is necessary to accept LED names using an appropriate
> regex pattern.
>=20
> The register offsets can be adjusted within the specified range, with
> the maximum value corresponding to the highest number of LEDs that can
> be connected to the controller.

Do all of these controllers have identical max numbers of LEDs?

Cheers,
Conor.

>=20
> Fixes: e338a05e76ca ("dt-bindings: leds: Add binding for AW200xx")
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  .../devicetree/bindings/leds/awinic,aw200xx.yaml       | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml b=
/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> index efb18ddce383..677c73aa6232 100644
> --- a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> +++ b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> @@ -42,16 +42,18 @@ properties:
>      maxItems: 1
> =20
>  patternProperties:
> -  "^led@[0-9a-f]$":
> +  "^led@[0-9a-f]+$":
>      type: object
>      $ref: common.yaml#
>      unevaluatedProperties: false
> =20
>      properties:
>        reg:
> -        description:
> -          LED number
> -        maxItems: 1
> +        items:
> +          description:
> +            LED number
> +          minimum: 0
> +          maximum: 108
> =20
>        led-max-microamp:
>          default: 9780
> --=20
> 2.36.0
>=20

--583YNsUVrmxxvyQI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTE4ZgAKCRB4tDGHoIJi
0iZpAQDHMFTIGQM98jN9qRcYxmQFMSfULTdz7fFQwWy8EkVwDQEA9IP7oOx+D2LZ
DY30ZjJVn3jbDrBPalja65VIPiUAWww=
=Aktz
-----END PGP SIGNATURE-----

--583YNsUVrmxxvyQI--
