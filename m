Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0987C8C53
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 19:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjJMR3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 13:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjJMR3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 13:29:40 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11491A9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 10:29:39 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5079fa1bbf8so430096e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 10:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697218177; x=1697822977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOIrFGsafUUFipy0EmdcVavE31dFTWyMITdmJ3ogb1U=;
        b=KUYr+01PAdUXVPAvopM7cqn9QoBRxPMonUPkJV4xTtEknyJhOiZG9Ki9kia05EM3su
         s9AnFRgpko5bB3qeZ6cqVMl1TqI0m6kxF1talr/M1vdlIPcvZf4HihRBqU56limndRB4
         bHBIe93M4uaLGKw4DhE9qBmmFrFAVf4UodoZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697218177; x=1697822977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOIrFGsafUUFipy0EmdcVavE31dFTWyMITdmJ3ogb1U=;
        b=iuKcxfOYqbpDNQEOxdchXyFuMzSiBbUotTUojhtNU27MSvFKYvTAvF+yDc8wFPfBHw
         8LiKU4IRMGWOA28OvwZq5WPMkt2ar4oqTk2EvUGo0Lw+1LX7Wbqxnhhx7Ncbs/ULmZDg
         MVgOin3GOOIwXNMHdWiiv0/aiOn3wGTrNTXLs05Mx8MZwGLHXFsVz3O1fOTmjdSZGca+
         wD5KDqX2PuFiJnVOGMbgSCalbXc2MQ20iK8sQF8VKPxPwyUGLWCIU32NCHgt1MLFL2KI
         2BYuGyQqQHymzyKPH0EZiEqYnYs5cRfI0OV2n/smnJAvyp1q5a9NRTr5z8swBKN4Hsmk
         7jGg==
X-Gm-Message-State: AOJu0YygV6FsmsdEMsfvJ2mWcWLa1GptqPnJi4fVL1bWIU86tobZ97g+
        aivDQvquyhOjAsaWXRsaHxQTxrGrrVuN/SFAgBxQcu8fsAJ33TiQl1pfFA==
X-Google-Smtp-Source: AGHT+IHlXOJUPgc4YdKF/GwqBVPUCLNSqtKKe94qTc6GOyoD0rJldQQHCAq2U9X6KxHG9reLUEBxj80c3R0OY+ZYNl8=
X-Received: by 2002:a05:6512:230e:b0:507:95ea:1e72 with SMTP id
 o14-20020a056512230e00b0050795ea1e72mr4194306lfu.22.1697218176696; Fri, 13
 Oct 2023 10:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231012230237.2676469-1-wenst@chromium.org> <20231012230237.2676469-3-wenst@chromium.org>
 <20231013-washer-mortally-b27c196ac50f@spud>
In-Reply-To: <20231013-washer-mortally-b27c196ac50f@spud>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 13 Oct 2023 10:29:25 -0700
Message-ID: <CAGXv+5GF7HfQSOg9c=G+c4DPUW24Ax7LX4raTynDbE3xc8iCdg@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 8:11=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Fri, Oct 13, 2023 at 07:02:28AM +0800, Chen-Yu Tsai wrote:
> > Add entries for MT8186 based Tentacruel / Tentacool Chromebooks. The tw=
o
> > are based on the same board design: the former is a convertible device
> > with a touchscreen, stylus, and some extra buttons; the latter is a
> > clamshell device and lacks these additional features.
> >
> > The two devices both have two variants. The difference is a second
> > source touchpad controller that shares the same address as the original=
,
> > but is incompatible.
>
> > The extra SKU IDs for the Tentacruel devices map to different sensor
> > components attached to the Embedded Controller. These are not visible
> > to the main processor.
>
> Wha? Given your ordering, is a "google,tentacruel-sku262144" a super-set
> of "google,tentacruel-sku262145"? If not, this compatible ordering
> doesn't make sense. I can't tell from your description, and the
> absence of a
> items:
>           - const: google,tentacruel-sku262145
>           - const: google,tentacruel-sku262146
>           - const: google,tentacruel-sku262147
>           - const: google,tentacruel
>           - const: mediatek,mt8186
> suggests that there is no google,tentacruel-sku262145
> device?

AFAIK all four SKUs exist. And as far as the main processor is concerned,
they look completely identical, so they should share the same device tree.
As mentioned in the commit message, the differences are only visible to
the embedded controller, which fuses the sensor inputs.

Writing it this way avoids having four identical device tree files.

We also do this for many other device families, though those cover
different revisions, such as:

      - description: Google Hana (Lenovo Chromebook N23 Yoga, C330, 300e,..=
.)
        items:
          - const: google,hana-rev6
          - const: google,hana-rev5
          - const: google,hana-rev4
          - const: google,hana-rev3
          - const: google,hana
          - const: mediatek,mt8173


ChenYu

> Cheers,
> Conor.
>
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >  .../devicetree/bindings/arm/mediatek.yaml     | 26 +++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Docu=
mentation/devicetree/bindings/arm/mediatek.yaml
> > index 60337b439744..aa7e6734b336 100644
> > --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> > +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> > @@ -206,6 +206,32 @@ properties:
> >            - enum:
> >                - mediatek,mt8183-pumpkin
> >            - const: mediatek,mt8183
> > +      - description: Google Tentacruel (ASUS Chromebook CM14 Flip CM14=
02F)
> > +        items:
> > +          - const: google,tentacruel-sku262144
> > +          - const: google,tentacruel-sku262145
> > +          - const: google,tentacruel-sku262146
> > +          - const: google,tentacruel-sku262147
> > +          - const: google,tentacruel
> > +          - const: mediatek,mt8186
> > +      - description: Google Tentacruel (ASUS Chromebook CM14 Flip CM14=
02F)
> > +        items:
> > +          - const: google,tentacruel-sku262148
> > +          - const: google,tentacruel-sku262149
> > +          - const: google,tentacruel-sku262150
> > +          - const: google,tentacruel-sku262151
> > +          - const: google,tentacruel
> > +          - const: mediatek,mt8186
> > +      - description: Google Tentacool (ASUS Chromebook CM14 CM1402C)
> > +        items:
> > +          - const: google,tentacruel-sku327681
> > +          - const: google,tentacruel
> > +          - const: mediatek,mt8186
> > +      - description: Google Tentacool (ASUS Chromebook CM14 CM1402C)
> > +        items:
> > +          - const: google,tentacruel-sku327683
> > +          - const: google,tentacruel
> > +          - const: mediatek,mt8186
> >        - items:
> >            - enum:
> >                - mediatek,mt8186-evb
> > --
> > 2.42.0.655.g421f12c284-goog
> >
