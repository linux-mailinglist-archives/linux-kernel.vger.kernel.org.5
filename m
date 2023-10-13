Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693477C8CFC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 20:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjJMSTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 14:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjJMSTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 14:19:33 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BDE91
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 11:19:30 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50433d8385cso3149669e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 11:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697221168; x=1697825968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEgHxjwiwSD+JRPgq4r1DGbDGCyxlMf5LLDf02rxVSQ=;
        b=czzPJTEweFW02bQ/pslv2EJzlCyCKGIAaMFjiNC/Iwiu/N7A7N1c5vYjDE3jfOQ+MO
         selRqnhrmtQIYTuPwfHiVGnbZsunAs61PNjjcWDintga7vGEOclBM6h5tl7aNLHNMjpF
         tvJElZTgoNetDYJW7xUnIo5rn1o2P+sxvG+RA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697221168; x=1697825968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEgHxjwiwSD+JRPgq4r1DGbDGCyxlMf5LLDf02rxVSQ=;
        b=xRcQ1GL01xgX9ai+kXfhukLime+Uo3ilL2Ttg1PVRA0Km0C07do7hihfMlR0XK4e6e
         O4B18cz/iFbWZpFMu1fa+eP8LgwDIYr4bPaWX37cIPNxqvoxl/L1iAaWyCMuldas8JB7
         T4WODbgZKInE+dzw2zpRSPXjw/w346mh0b7UYArLh4SFYnUhE2Q8Kq5FG9H+NjLL+meR
         V1CNEnEhVIgALOi5zFcBrdje4B95CMS3e2HU7anZBgOpqVJPNLB7K3NKoE5Am9iaAJSY
         pKNZKsGy5IqpilSSe1ALr4CeqRbO4iCEAnRyBCoPf7I6Sh5DTFyT1OzQMQMlf/8ffJLA
         +IEQ==
X-Gm-Message-State: AOJu0YyXndZDeiFnUitU54KEgPuDy5oxbsCRgrdTg9BulN8K4wn4vt2I
        bQiyFmoGHwjsIstlBheg9cQLbhpqQdyv4jhJcVIJVQ==
X-Google-Smtp-Source: AGHT+IHCR/XWbMEw/7F9XyyRPeoXZ9MnoyEFxOLCKO/wr0+Lb7yofS3QRyunjmulj+PrGwKMooLxL/YlXpRMF32w0gU=
X-Received: by 2002:ac2:5976:0:b0:507:96cd:928c with SMTP id
 h22-20020ac25976000000b0050796cd928cmr3079950lfp.48.1697221167978; Fri, 13
 Oct 2023 11:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231012230237.2676469-1-wenst@chromium.org> <20231012230237.2676469-3-wenst@chromium.org>
 <20231013-washer-mortally-b27c196ac50f@spud> <CAGXv+5GF7HfQSOg9c=G+c4DPUW24Ax7LX4raTynDbE3xc8iCdg@mail.gmail.com>
 <20231013-panic-vaseline-350c10e7d585@spud>
In-Reply-To: <20231013-panic-vaseline-350c10e7d585@spud>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 13 Oct 2023 11:19:16 -0700
Message-ID: <CAGXv+5EmLDWi3Lnca1vPft=9z9Cp2L2ee08in_b_21hipf9ieQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] dt-bindings: arm: mediatek: Add MT8186 Tentacruel /
 Tentacool Chromebooks
To:     Conor Dooley <conor@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 10:55=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Fri, Oct 13, 2023 at 10:29:25AM -0700, Chen-Yu Tsai wrote:
> > On Fri, Oct 13, 2023 at 8:11=E2=80=AFAM Conor Dooley <conor@kernel.org>=
 wrote:
> > >
> > > On Fri, Oct 13, 2023 at 07:02:28AM +0800, Chen-Yu Tsai wrote:
> > > > Add entries for MT8186 based Tentacruel / Tentacool Chromebooks. Th=
e two
> > > > are based on the same board design: the former is a convertible dev=
ice
> > > > with a touchscreen, stylus, and some extra buttons; the latter is a
> > > > clamshell device and lacks these additional features.
> > > >
> > > > The two devices both have two variants. The difference is a second
> > > > source touchpad controller that shares the same address as the orig=
inal,
> > > > but is incompatible.
> > >
> > > > The extra SKU IDs for the Tentacruel devices map to different senso=
r
> > > > components attached to the Embedded Controller. These are not visib=
le
> > > > to the main processor.
> > >
> > > Wha? Given your ordering, is a "google,tentacruel-sku262144" a super-=
set
> > > of "google,tentacruel-sku262145"? If not, this compatible ordering
> > > doesn't make sense. I can't tell from your description, and the
> > > absence of a
> > > items:
> > >           - const: google,tentacruel-sku262145
> > >           - const: google,tentacruel-sku262146
> > >           - const: google,tentacruel-sku262147
> > >           - const: google,tentacruel
> > >           - const: mediatek,mt8186
> > > suggests that there is no google,tentacruel-sku262145
> > > device?
> >
> > AFAIK all four SKUs exist. And as far as the main processor is concerne=
d,
> > they look completely identical, so they should share the same device tr=
ee.
> > As mentioned in the commit message, the differences are only visible to
> > the embedded controller, which fuses the sensor inputs.
>
> Then it makes very little sense to write a binding like this.
> If this was just for the 252144 SKU, this would be fine.
> For the other SKUs, there is no way to uniquely identify them, as
> all four of google,tentacruel-sku262144, google,tentacruel-sku262145,
> google,tentacruel-sku262146 and google,tentacruel-sku262147 must be
> present.
> Given that, why even bother including the SKUs in the first place,
> since no information can be derived from them that cannot be derived
> from google,tentacruel?
> There's something that I am clearly missing here...

There are incompatible variants of google,tentacruel. This is why this
patch has four google,tentacruel based entries. Of them, two are Tentacool,
which are clamshell laptops, and two of them are Tentacruel, which are
convertibles.

Within each group there are two variants: the second variant swaps out
the I2C touchpad controller. These two controllers use the same I2C
address but use different compatible strings, so it's not possible to
have them coexist within the same device tree file like we do for many
other second source components.

So the relationship looks like the following:

google,tentacruel --- Tentacruel --- google,tentacruel-sku26214[4567]
                   |              |
                   |              -- google,tentacruel-sku2621{48,49,50,51}
                   |
                   -- Tentacool ---- google,tentacruel-sku327681
                                 |
                                 --- google,tentacruel-sku327683

Also, the devices themselves only know their own SKU ID. The firmware
will generate a list of compatible strings like:

  google,tentacruel-rev4-sku262144
  google,tentacruel-rev4
  google,tentacruel-sku262144
  google,tentacruel

and try to find a match in the kernel FIT image. The method we currently
use is to include all the applicable board compatible strings.

> Also, why is the order inverted, with the lower SKUs being super-sets of
> the higher ones? The Hana one you show below makes a little more sense
> in that regard.

Either way works. The SKU IDs have no particular order. Nor do the
individual bits in the SKU ID have meaning. They are just arbitrarily
assigned by the manufacturer. They just have to all be present so any
of the SKUs will match.

Hope that explains things better.


Regards
ChenYu

> > Writing it this way avoids having four identical device tree files.
> >
> > We also do this for many other device families, though those cover
> > different revisions, such as:
> >
> >       - description: Google Hana (Lenovo Chromebook N23 Yoga, C330, 300=
e,...)
> >         items:
> >           - const: google,hana-rev6
> >           - const: google,hana-rev5
> >           - const: google,hana-rev4
> >           - const: google,hana-rev3
> >           - const: google,hana
> >           - const: mediatek,mt8173
> >
> >
> > ChenYu
> >
> > > Cheers,
> > > Conor.
> > >
> > > >
> > > > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > > > ---
> > > >  .../devicetree/bindings/arm/mediatek.yaml     | 26 +++++++++++++++=
++++
> > > >  1 file changed, 26 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/=
Documentation/devicetree/bindings/arm/mediatek.yaml
> > > > index 60337b439744..aa7e6734b336 100644
> > > > --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> > > > +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> > > > @@ -206,6 +206,32 @@ properties:
> > > >            - enum:
> > > >                - mediatek,mt8183-pumpkin
> > > >            - const: mediatek,mt8183
> > > > +      - description: Google Tentacruel (ASUS Chromebook CM14 Flip =
CM1402F)
> > > > +        items:
> > > > +          - const: google,tentacruel-sku262144
> > > > +          - const: google,tentacruel-sku262145
> > > > +          - const: google,tentacruel-sku262146
> > > > +          - const: google,tentacruel-sku262147
> > > > +          - const: google,tentacruel
> > > > +          - const: mediatek,mt8186
> > > > +      - description: Google Tentacruel (ASUS Chromebook CM14 Flip =
CM1402F)
> > > > +        items:
> > > > +          - const: google,tentacruel-sku262148
> > > > +          - const: google,tentacruel-sku262149
> > > > +          - const: google,tentacruel-sku262150
> > > > +          - const: google,tentacruel-sku262151
> > > > +          - const: google,tentacruel
> > > > +          - const: mediatek,mt8186
> > > > +      - description: Google Tentacool (ASUS Chromebook CM14 CM1402=
C)
> > > > +        items:
> > > > +          - const: google,tentacruel-sku327681
> > > > +          - const: google,tentacruel
> > > > +          - const: mediatek,mt8186
> > > > +      - description: Google Tentacool (ASUS Chromebook CM14 CM1402=
C)
> > > > +        items:
> > > > +          - const: google,tentacruel-sku327683
> > > > +          - const: google,tentacruel
> > > > +          - const: mediatek,mt8186
> > > >        - items:
> > > >            - enum:
> > > >                - mediatek,mt8186-evb
> > > > --
> > > > 2.42.0.655.g421f12c284-goog
> > > >
