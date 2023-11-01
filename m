Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2128C7DE473
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 17:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbjKAQR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 12:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKAQRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 12:17:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AAFFD;
        Wed,  1 Nov 2023 09:17:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643B2C433C9;
        Wed,  1 Nov 2023 16:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698855438;
        bh=RzPC3u+sBenTEVtjN/LgXO2kCsI4d3YAfRrFeJzfKLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uj34ciNwfSdgbc621GZN/IT1umuDWUtTGONDSvZS5D8cygmgdD8f7TDWG8KT0E2T6
         vA5WmvwPex6a+Q7qE5oh3ET1GdYKxKVc2zVN6sVcNfg+GXql0UK9FRJRvlo0SwcuKw
         ROHkd6hD4xe972XVN1M4k/sLpFEVMVg43XnfXpUtkVjkKPLGCRrCfwiiULtKolwcTd
         Ze8qNwqdSFSlHHNETRevPct6BsLjy8Moj9NmWaQgVkQGM4uAXvsDo0dRnyk3dFVfTC
         FgBQSxyBeNiULNQcyQhIhUHvy8OPZ0+e++Baxp0K6s4eH8Ljhz5+B7eDlkDxLMFWaV
         JP0WCUvUuGt2w==
Date:   Wed, 1 Nov 2023 16:17:14 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Dmitry Rokosov <ddrokosov@salutedevices.com>,
        linux-leds@vger.kernel.org, lee@kernel.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru,
        andy.shevchenko@gmail.com, conor+dt@kernel.org, pavel@ucw.cz,
        krzysztof.kozlowski+dt@linaro.org, rockosov@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 11/11] dt-bindings: leds: aw200xx: fix led pattern and
 add reg constraints
Message-ID: <20231101-bolster-anaerobic-244cd1a8c205@spud>
References: <20231101142445.8753-1-ddrokosov@salutedevices.com>
 <20231101142445.8753-12-ddrokosov@salutedevices.com>
 <169885374980.409399.3653628333009308100.robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Wj/1IL1Pi5arDIEg"
Content-Disposition: inline
In-Reply-To: <169885374980.409399.3653628333009308100.robh@kernel.org>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Wj/1IL1Pi5arDIEg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2023 at 11:04:16AM -0500, Rob Herring wrote:
>=20
> On Wed, 01 Nov 2023 17:24:45 +0300, Dmitry Rokosov wrote:
> > AW200XX controllers have the capability to declare more than 0xf LEDs,
> > therefore, it is necessary to accept LED names using an appropriate
> > regex pattern.
> >=20
> > The register offsets can be adjusted within the specified range, with
> > the maximum value corresponding to the highest number of LEDs that can
> > be connected to the controller.
> >=20
> > Fixes: e338a05e76ca ("dt-bindings: leds: Add binding for AW200xx")
> > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > ---
> >  .../bindings/leds/awinic,aw200xx.yaml         | 64 +++++++++++++++++--
> >  1 file changed, 58 insertions(+), 6 deletions(-)
> >=20
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/l=
eds/awinic,aw200xx.example.dtb: led-controller@3a: led@0: Unevaluated prope=
rties are not allowed ('reg' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/leds/awinic,aw200xx.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/l=
eds/awinic,aw200xx.example.dtb: led-controller@3a: led@1: Unevaluated prope=
rties are not allowed ('reg' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/leds/awinic,aw200xx.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/l=
eds/awinic,aw200xx.example.dtb: led-controller@3a: led@2: Unevaluated prope=
rties are not allowed ('reg' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/leds/awinic,aw200xx.yaml#

Looks like you need to drop the second part of this hunk from the patch.
@@ -45,17 +45,12 @@ properties:
     maxItems: 1
=20
 patternProperties:
-  "^led@[0-9a-f]$":
+  "^led@[0-9a-f]+$":
     type: object
     $ref: common.yaml#
     unevaluatedProperties: false
=20
     properties:
-      reg:
-        description:
-          LED number
-        maxItems: 1
-
       led-max-microamp:
         default: 9780
         description: |

Each LED still only has one reg entry, right?

Cheers,
Conor.

--Wj/1IL1Pi5arDIEg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUJ6CQAKCRB4tDGHoIJi
0gxIAP99M/1guv/mcRC8vBLVHWGdy/7u4GS3C2KuIrGknM6UpQD+IAK7kPUnl+MM
UaKEaY+OtvOULeDUyiYn28TZADH3VQ0=
=ZZ3i
-----END PGP SIGNATURE-----

--Wj/1IL1Pi5arDIEg--
