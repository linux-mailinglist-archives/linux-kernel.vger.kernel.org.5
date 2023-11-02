Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406CE7DE93D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 01:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbjKBARZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 20:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjKBARY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 20:17:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F38109;
        Wed,  1 Nov 2023 17:17:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C268C433C7;
        Thu,  2 Nov 2023 00:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698884235;
        bh=TOJiriu7zo/tOZp6wt6uoQqF/K8RoG8GBogF+O+OlHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fjz3k9HJotc18Y2AY4yosYabz+yl+n9B5E2DMxuLA98Igdoc8atWUGT0w+Potdj6A
         vwaXd+5HCxLsFFXkHLjfI2gvOJCxDD4B39nauPuyv3sEEoJDz1HkBFHu37FoJErQ/L
         te5TuHlyVDtNK6u6J2UM/8xVrR9NnT70JwKk2XKUcws4GzIRlHV9Qqacaodm+VE7YA
         lWBAms4Kg4g33Uqcu4iLejvPxtJmK4y84z9URimUl4UZ4ArqtGty5L4+6b3BZJa5sc
         rdN7ZED6BS2xdswu9HFD3YCyfp5gV1Dxg8wlObHLVTXRMjzkgN+Q+XTR8+CpzamRHS
         Uw/8gSJq2YEJg==
Date:   Thu, 2 Nov 2023 00:17:11 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     Rob Herring <robh@kernel.org>, linux-leds@vger.kernel.org,
        lee@kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, andy.shevchenko@gmail.com,
        conor+dt@kernel.org, pavel@ucw.cz,
        krzysztof.kozlowski+dt@linaro.org, rockosov@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 11/11] dt-bindings: leds: aw200xx: fix led pattern and
 add reg constraints
Message-ID: <20231102-concave-untapped-804a5956faab@spud>
References: <20231101142445.8753-1-ddrokosov@salutedevices.com>
 <20231101142445.8753-12-ddrokosov@salutedevices.com>
 <169885374980.409399.3653628333009308100.robh@kernel.org>
 <20231101-bolster-anaerobic-244cd1a8c205@spud>
 <20231101174422.zs5er6tqethm46ur@CAB-WSD-L081021>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1KMrlXhM842v/S70"
Content-Disposition: inline
In-Reply-To: <20231101174422.zs5er6tqethm46ur@CAB-WSD-L081021>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1KMrlXhM842v/S70
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2023 at 08:44:22PM +0300, Dmitry Rokosov wrote:
> Hello Conor,
>=20
> On Wed, Nov 01, 2023 at 04:17:14PM +0000, Conor Dooley wrote:
> > On Wed, Nov 01, 2023 at 11:04:16AM -0500, Rob Herring wrote:
> > >=20
> > > On Wed, 01 Nov 2023 17:24:45 +0300, Dmitry Rokosov wrote:
> > > > AW200XX controllers have the capability to declare more than 0xf LE=
Ds,
> > > > therefore, it is necessary to accept LED names using an appropriate
> > > > regex pattern.
> > > >=20
> > > > The register offsets can be adjusted within the specified range, wi=
th
> > > > the maximum value corresponding to the highest number of LEDs that =
can
> > > > be connected to the controller.
> > > >=20
> > > > Fixes: e338a05e76ca ("dt-bindings: leds: Add binding for AW200xx")
> > > > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > > > ---
> > > >  .../bindings/leds/awinic,aw200xx.yaml         | 64 +++++++++++++++=
++--
> > > >  1 file changed, 58 insertions(+), 6 deletions(-)
> > > >=20
> > >=20
> > > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_ch=
eck'
> > > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > >=20
> > > yamllint warnings/errors:
> > >=20
> > > dtschema/dtc warnings/errors:
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindin=
gs/leds/awinic,aw200xx.example.dtb: led-controller@3a: led@0: Unevaluated p=
roperties are not allowed ('reg' was unexpected)
> > > 	from schema $id: http://devicetree.org/schemas/leds/awinic,aw200xx.y=
aml#
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindin=
gs/leds/awinic,aw200xx.example.dtb: led-controller@3a: led@1: Unevaluated p=
roperties are not allowed ('reg' was unexpected)
> > > 	from schema $id: http://devicetree.org/schemas/leds/awinic,aw200xx.y=
aml#
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindin=
gs/leds/awinic,aw200xx.example.dtb: led-controller@3a: led@2: Unevaluated p=
roperties are not allowed ('reg' was unexpected)
> > > 	from schema $id: http://devicetree.org/schemas/leds/awinic,aw200xx.y=
aml#
> >=20
> > Looks like you need to drop the second part of this hunk from the patch.
> > @@ -45,17 +45,12 @@ properties:
> >      maxItems: 1
> > =20
> >  patternProperties:
> > -  "^led@[0-9a-f]$":
> > +  "^led@[0-9a-f]+$":
> >      type: object
> >      $ref: common.yaml#
> >      unevaluatedProperties: false
> > =20
> >      properties:
> > -      reg:
> > -        description:
> > -          LED number
> > -        maxItems: 1
> > -
> >        led-max-microamp:
> >          default: 9780
> >          description: |
> >=20
> > Each LED still only has one reg entry, right?
>=20
> You're right... the maxItems for 'reg' is still needed. I'll back it in
> the next version.
> But I don't understand, why my dt_binding_check run doesn't show me this
> problem... I don't specify DT_CHECKER_FLAGS, maybe this is a root cause.

I dunno! I do `make dt_binding_check W=3D1 DT_SCHEMA_FILES=3D"$filename"` to
test stuff.

Also, you can keep the tag.

--1KMrlXhM842v/S70
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZULqhgAKCRB4tDGHoIJi
0q4BAQC5YTzHsZRRP1WxLFh3vu211rMVno+IX+YO5RazUkgsMAEArUlNxt0UhTjw
Nq+4zijW6+jINWj/Jd91+bh5kDWepgk=
=fKHp
-----END PGP SIGNATURE-----

--1KMrlXhM842v/S70--
