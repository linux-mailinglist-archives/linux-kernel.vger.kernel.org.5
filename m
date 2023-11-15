Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFDC7ED28E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbjKOTk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbjKOTkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:40:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357A5CE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 11:40:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12590C433CC;
        Wed, 15 Nov 2023 19:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700077235;
        bh=Gn1w687cIR3BQUoucpzaPxl0Q1GbBJKVcB2M7xuBnuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LhI5JtKz5wz/vXpuWj71ouvklZMuSk/3RZQNVUlnGfbmI+bu8FtkzTplVnNwHppPC
         oZDJHP0IG3r7Sqg//4+4YWyV4rME9ph/f1Ti7CcP0LSOjBaPi2yRl+1WgkZz5RSkaP
         ftNATPozh7EcFT0EsLB0Q1pCmvt1rUAgXkWl8RATqGa0Hes2l7Ht6mEW+7uquGQQ3M
         5fB71zpUs/L5758F6mZwdt3CHQ5u36Arp3dd/73o2BX8kskYQTmaITxeNeZr2UzT1K
         KJx5gBNhKRAVOltojh1raAgIlC8sqtcanz+TOIQ1RAjQwPvLx6q6qfEzIbepoELrud
         sRWE0zqaJbycA==
Date:   Wed, 15 Nov 2023 19:40:31 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Anshul Dalal <anshulusr@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: trivial-devices: add aosong,ags02ma
Message-ID: <20231115-humble-sleek-e401e01de5dd@squawk>
References: <20231115125810.1394854-1-anshulusr@gmail.com>
 <20231115125810.1394854-2-anshulusr@gmail.com>
 <20231115-stability-arrive-e0458f6f7b0f@squawk>
 <9b1674d7-c41d-4d8b-bb28-09ed201c72cd@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6bQ9hniIbQJIrogH"
Content-Disposition: inline
In-Reply-To: <9b1674d7-c41d-4d8b-bb28-09ed201c72cd@gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6bQ9hniIbQJIrogH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 09:29:20PM +0530, Anshul Dalal wrote:
> On 11/15/23 20:08, Conor Dooley wrote:
> > On Wed, Nov 15, 2023 at 06:28:07PM +0530, Anshul Dalal wrote:
> >> Add bindings for Aosong AGS02MA TVOC sensor.
> >>
> >> The sensor communicates over i2c with the default address 0x1a.
> >> TVOC values can be read in the units of ppb and ug/m^3 at register 0x0=
0.
> >>
> >> Datasheet:
> >>   https://asairsensors.com/wp-content/uploads/2021/09/AGS02MA.pdf
> >> Product-Page:
> >>   http://www.aosong.com/m/en/products-33.html
> >>
> >> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
> >> ---
> >>
> >> Changes for v2:
> >> - Removed device from trivial-devices
> >=20
> > Your $subject still says "trivial-devices" though, so please fix that in
> > your next submission.
> >=20
> >> - Added standalone binding with vdd-supply property
> >> ---
> >>  .../bindings/iio/chemical/aosong,ags02ma.yaml | 48 +++++++++++++++++++
> >>  1 file changed, 48 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/aos=
ong,ags02ma.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/chemical/aosong,ags=
02ma.yaml b/Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.y=
aml
> >> new file mode 100644
> >> index 000000000000..4a0278c6318c
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.ya=
ml
> >> @@ -0,0 +1,48 @@
> >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/iio/chemical/aosong,ags02ma.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Aosong AGS02MA VOC Sensor
> >> +
> >> +description: |
> >> +  AGS02MA is an TVOC (Total Volatile Organic Compounds) i2c sensor wi=
th default
> >> +  address of 0x1a.
> >> +
> >> +  Datasheet:
> >> +    https://asairsensors.com/wp-content/uploads/2021/09/AGS02MA.pdf
> >> +
> >> +maintainers:
> >> +  - Anshul Dalal <anshulusr@gmail.com>
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - aosong,ags02ma
> >> +      - asair,ags02ma
> >=20
> > Why do you have two compatibles for the same device? Please document and
> > use only one of these. The aoson website says:
> > "Guangzhou ASAIR Electronic Co., Ltd"
>=20
> I'm sorry but I couldn't find any reference to such name on
> http://www.aosong.com/en/
> In the contact page (http://www.aosong.com/en/article-34.html),
> I could only find references to "Guangzhou Aosong Electronic Co., Ltd."

On the page you linked in your original submission:
www.aosong.com/m/en/products-33.html
(scroll down)

> > so I suspect "asair" is a more apt vendor prefix.
> >=20
>=20
> Asair is the brand name under which Guangzhou Aosong Electronics sells
> their products [0]. After a prior discussion with Krzysztof [1], I
> thought it would be the best to go with Aosong instead.
>=20
> The rationale being since a vendor can only have a single prefix, if
> Aosong were to sell some new product under the name Aosong, it would
> then have to have the same vendor-prefix as other products under the
> Asair brand.

Go with Aosong then, sure. But please drop the "asair" prefixed
compatible from your binding.

Cheers,
Conor,

--6bQ9hniIbQJIrogH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVUeqwAKCRB4tDGHoIJi
0tLpAQDj4G3DmRTIQHEIDDn1GmniyFse4HIbtrauRyEkPgM7vQEAnBi4IctZcpXS
Q/SrA/dHRQNpGzD2TDRyG5vYyzVcdAo=
=AjOV
-----END PGP SIGNATURE-----

--6bQ9hniIbQJIrogH--
