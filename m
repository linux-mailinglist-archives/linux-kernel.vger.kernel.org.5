Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02EB7F9777
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 03:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjK0CXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 21:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjK0CXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 21:23:09 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE2E110
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 18:23:15 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507e85ebf50so5045855e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 18:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701051793; x=1701656593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSfUfP4XMvfz52jafZIehWTyVLB2dDTGY7kE9uvmNFU=;
        b=lvOihoDW4lY6vqpx6yHq3pQ5KwszwjW1Kovs6sOmLW/hfz/EkDT/O/75b4KzpdGNLr
         arST+53WS51vCjpSOwnInF9G5EOg6WkXLSYFlqY4twlMkp4br+9lGGn/r03op2qzurGr
         +g5IyrARJfSOCQJLyL7PYtKSx0KhEX0xYg6PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701051793; x=1701656593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSfUfP4XMvfz52jafZIehWTyVLB2dDTGY7kE9uvmNFU=;
        b=N4m7sTyvxuIvVoRAlfIgnTWR2tZQiDUYf+zo8GMGZr2fIVVIuHBPU9NDGtmDDafc2k
         OcKPL88Cb44QiU+DvLKYfXtFLAcEqKzQFErGKCEfG/tTGwRk+de99Ce+cySqiBfRcoTJ
         huCMwrO/m4JRaVtnesV/pDt6Ju6YkNO5KTzkTSQ4viqxanIrv6SmQNl3GfMpAkuvTRix
         XJBTQl32lFr+kuymn0MZQxGj2csrMDpC3CYXuQWORHm9qJNCIiLey+BuqJPGGg0LqWaX
         oQjFkmBZnplXYNWKARAc9NsoPSoaPfkv1zcFi02WaRoqlcMIOXz2GZrM0nGiBS1yVJwK
         eCNg==
X-Gm-Message-State: AOJu0YxGKzDcgq6dombk+me7VZtmlfLiEufpbvUuxYD6/vuCyAorDjIQ
        gpeKAWNhdWBIAij8q76x3r4NYRI6RCWcRkxPkw1c5g==
X-Google-Smtp-Source: AGHT+IHBN8N/+MmMOgool09rAcTcq2woF4lPrPkErpOndnaGQ8U2/8WOta2kePf5kfxSK+34TvzCKH3CIswlBBRauYc=
X-Received: by 2002:a05:6512:3b87:b0:508:264e:2ded with SMTP id
 g7-20020a0565123b8700b00508264e2dedmr8780303lfv.38.1701051793170; Sun, 26 Nov
 2023 18:23:13 -0800 (PST)
MIME-Version: 1.0
References: <20231012230237.2676469-1-wenst@chromium.org> <20231012230237.2676469-3-wenst@chromium.org>
 <20231124-old-each-230d55963934@spud>
In-Reply-To: <20231124-old-each-230d55963934@spud>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 27 Nov 2023 10:23:02 +0800
Message-ID: <CAGXv+5HQkTUVXVDsHjy-T+iDU3Lr-K1sPeMA5EnzvHJxg8fkYg@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 10:09=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
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
> >
> > The extra SKU IDs for the Tentacruel devices map to different sensor
> > components attached to the Embedded Controller. These are not visible
> > to the main processor.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>
> I had a chat with Doug at Plumbers about the limitations of your
> firmware. As a result, I am fine with acking this if you switch the
> order of the sku compatibles to be in descending order.

Thank you for taking the effort to understand our weird firmware
implementation. And a thank you to Doug for discussing this. I'll
send out the next version shortly.

> The firmware can handle that, right?

Yes. The firmware basically takes a list of machine compatibles, and
runs them against all the DTs it has with of_machine_is_compatible().

Thanks
ChenYu

>
> Cheers,
> Conor.
>
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
