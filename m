Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3F17C8C9C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 19:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjJMRzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 13:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMRzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 13:55:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7EDBB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 10:55:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661EBC433C7;
        Fri, 13 Oct 2023 17:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697219705;
        bh=7IamPXTmz8rMuid6Tr9dVZoV3lmTXmDMvdIcBzXdT7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rjET7qMd2cdxkddUY8YlBjojhX6lMYkx7Y805KW6478kUEPfy0tZ/vzU1kh+HH2wB
         hKXl/GuHRBBYoeENwBoPanwRT9cha7kYXprM82kqBQOg/kP0nzja9Yj+DaXy8yiEkb
         uEzQ9Q/tqJbXdS1Nnqzrdx0SBnyIrDAwhP9z5Fx/Z7S+jOGnqBGTC4klhWb0V/A6Le
         6bQR+y3cgLTZToI3cIE0bg8uIs1wSdWpvRANW1l2QCyNlL8JXc6ai5fYC+32N6yubA
         8cvYEdy/LZTx9J2cHHZ7ZKEbD8sB//rXEQmMS4sKrlqzZfPTKBXw6Qeems1Xk859pd
         003wY0EBdRxRA==
Date:   Fri, 13 Oct 2023 18:55:01 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] dt-bindings: arm: mediatek: Add MT8186 Tentacruel /
 Tentacool Chromebooks
Message-ID: <20231013-panic-vaseline-350c10e7d585@spud>
References: <20231012230237.2676469-1-wenst@chromium.org>
 <20231012230237.2676469-3-wenst@chromium.org>
 <20231013-washer-mortally-b27c196ac50f@spud>
 <CAGXv+5GF7HfQSOg9c=G+c4DPUW24Ax7LX4raTynDbE3xc8iCdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9NYY4vQdb9ornYDu"
Content-Disposition: inline
In-Reply-To: <CAGXv+5GF7HfQSOg9c=G+c4DPUW24Ax7LX4raTynDbE3xc8iCdg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9NYY4vQdb9ornYDu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 10:29:25AM -0700, Chen-Yu Tsai wrote:
> On Fri, Oct 13, 2023 at 8:11=E2=80=AFAM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Fri, Oct 13, 2023 at 07:02:28AM +0800, Chen-Yu Tsai wrote:
> > > Add entries for MT8186 based Tentacruel / Tentacool Chromebooks. The =
two
> > > are based on the same board design: the former is a convertible device
> > > with a touchscreen, stylus, and some extra buttons; the latter is a
> > > clamshell device and lacks these additional features.
> > >
> > > The two devices both have two variants. The difference is a second
> > > source touchpad controller that shares the same address as the origin=
al,
> > > but is incompatible.
> >
> > > The extra SKU IDs for the Tentacruel devices map to different sensor
> > > components attached to the Embedded Controller. These are not visible
> > > to the main processor.
> >
> > Wha? Given your ordering, is a "google,tentacruel-sku262144" a super-set
> > of "google,tentacruel-sku262145"? If not, this compatible ordering
> > doesn't make sense. I can't tell from your description, and the
> > absence of a
> > items:
> >           - const: google,tentacruel-sku262145
> >           - const: google,tentacruel-sku262146
> >           - const: google,tentacruel-sku262147
> >           - const: google,tentacruel
> >           - const: mediatek,mt8186
> > suggests that there is no google,tentacruel-sku262145
> > device?
>=20
> AFAIK all four SKUs exist. And as far as the main processor is concerned,
> they look completely identical, so they should share the same device tree.
> As mentioned in the commit message, the differences are only visible to
> the embedded controller, which fuses the sensor inputs.

Then it makes very little sense to write a binding like this.
If this was just for the 252144 SKU, this would be fine.
For the other SKUs, there is no way to uniquely identify them, as
all four of google,tentacruel-sku262144, google,tentacruel-sku262145,
google,tentacruel-sku262146 and google,tentacruel-sku262147 must be
present.
Given that, why even bother including the SKUs in the first place,
since no information can be derived from them that cannot be derived
=66rom google,tentacruel?
There's something that I am clearly missing here...

Also, why is the order inverted, with the lower SKUs being super-sets of
the higher ones? The Hana one you show below makes a little more sense
in that regard.

> Writing it this way avoids having four identical device tree files.
>=20
> We also do this for many other device families, though those cover
> different revisions, such as:
>=20
>       - description: Google Hana (Lenovo Chromebook N23 Yoga, C330, 300e,=
=2E..)
>         items:
>           - const: google,hana-rev6
>           - const: google,hana-rev5
>           - const: google,hana-rev4
>           - const: google,hana-rev3
>           - const: google,hana
>           - const: mediatek,mt8173
>=20
>=20
> ChenYu
>=20
> > Cheers,
> > Conor.
> >
> > >
> > > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > > ---
> > >  .../devicetree/bindings/arm/mediatek.yaml     | 26 +++++++++++++++++=
++
> > >  1 file changed, 26 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Do=
cumentation/devicetree/bindings/arm/mediatek.yaml
> > > index 60337b439744..aa7e6734b336 100644
> > > --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> > > @@ -206,6 +206,32 @@ properties:
> > >            - enum:
> > >                - mediatek,mt8183-pumpkin
> > >            - const: mediatek,mt8183
> > > +      - description: Google Tentacruel (ASUS Chromebook CM14 Flip CM=
1402F)
> > > +        items:
> > > +          - const: google,tentacruel-sku262144
> > > +          - const: google,tentacruel-sku262145
> > > +          - const: google,tentacruel-sku262146
> > > +          - const: google,tentacruel-sku262147
> > > +          - const: google,tentacruel
> > > +          - const: mediatek,mt8186
> > > +      - description: Google Tentacruel (ASUS Chromebook CM14 Flip CM=
1402F)
> > > +        items:
> > > +          - const: google,tentacruel-sku262148
> > > +          - const: google,tentacruel-sku262149
> > > +          - const: google,tentacruel-sku262150
> > > +          - const: google,tentacruel-sku262151
> > > +          - const: google,tentacruel
> > > +          - const: mediatek,mt8186
> > > +      - description: Google Tentacool (ASUS Chromebook CM14 CM1402C)
> > > +        items:
> > > +          - const: google,tentacruel-sku327681
> > > +          - const: google,tentacruel
> > > +          - const: mediatek,mt8186
> > > +      - description: Google Tentacool (ASUS Chromebook CM14 CM1402C)
> > > +        items:
> > > +          - const: google,tentacruel-sku327683
> > > +          - const: google,tentacruel
> > > +          - const: mediatek,mt8186
> > >        - items:
> > >            - enum:
> > >                - mediatek,mt8186-evb
> > > --
> > > 2.42.0.655.g421f12c284-goog
> > >

--9NYY4vQdb9ornYDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSmEdQAKCRB4tDGHoIJi
0vjhAP9fKNGUBz2HMnG2ILJzOr0cgfze+4tqoryOMOIyWAjHDAEAwCbqZBVwT61j
WfBudZ6XiijDWDUaS2LAIEvxmyMGzAs=
=TciW
-----END PGP SIGNATURE-----

--9NYY4vQdb9ornYDu--
