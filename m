Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894897D5A57
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343995AbjJXSW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 14:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbjJXSW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:22:28 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C6A10A
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 11:22:26 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6ce2add34c9so3240974a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 11:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698171746; x=1698776546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5Je0y3MKSY9EnJ0vnn4Sf8bQ8bTdsG8Jn34SwdnM5U=;
        b=XIIJEYa0tXG6hRoaQe9MU0/PfbTJwW++f1jWwLwKM6QqGSu0h6czoVg3Wq/QFHvrSm
         6Y16y8vzmGPGnmKbvwL4Mskyd8LSPV7UuYk5eIFWMgROC09W1sRtAKIaln7w3+6Oz0xa
         Wnmi18eHYp6cvyCM+s/tANPcVzD5k6K0h9K9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698171746; x=1698776546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5Je0y3MKSY9EnJ0vnn4Sf8bQ8bTdsG8Jn34SwdnM5U=;
        b=F8x9KrMtc6YF/QQhM+9olMyyquEQzG+JXl3nc5CZp+R+lDs+vRxpwvGyl5dqmwD6d4
         oTx2/R6KiVqRyO9+psYp14Y541Nx6ZbN+4FPOECkHq1NIy7Re3llolOWki7hpwi5vBKE
         0CZnEHAjy3a9ud499kQ0xdHJfIruZrOl9BX5l3oLFcXiQN55eBd7769mDOQxFOkH+eo2
         tvnDyDUeOOWwxJuM7+Ckzgg2jrVgEHG021gKITh3uN/U5MqN+Y9gpmD/nnERp2SyjlIy
         MZORCKQOmeLh97wI9c4W6wYaMWiMGzecclZLuG8nPSZyL4bhrmE2b1CB1u/912gXA13r
         z8Og==
X-Gm-Message-State: AOJu0YwIneOICS9IP6nyfJTJv0SSsb1s24tYo/hneC79SRtDzwW1JFTS
        8t/aQRlnCYua++IutRbvVyzj7a+GgqyTi0voWvaeAQ==
X-Google-Smtp-Source: AGHT+IELaHYYxIByrxXgKujkDSN0ViXa19s603EMKyAcH2uHi+NrtNxd6KmykPPX38FeGkI5PStPU/mX/HVy7qowNd0=
X-Received: by 2002:a05:6830:442a:b0:6c6:4473:6f05 with SMTP id
 q42-20020a056830442a00b006c644736f05mr13078761otv.9.1698171745825; Tue, 24
 Oct 2023 11:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231024000724.57714-1-hsinyi@chromium.org> <20231024000724.57714-4-hsinyi@chromium.org>
 <20231024-bobbed-although-06f341259ebb@spud>
In-Reply-To: <20231024-bobbed-although-06f341259ebb@spud>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 24 Oct 2023 11:22:00 -0700
Message-ID: <CAJMQK-hvhjNGFUfgqb7pm=pAYjJ0wZAhkPGXxDCUJ5cnUDh2gw@mail.gmail.com>
Subject: Re: [PATCH 3/6] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-makomo
To:     Conor Dooley <conor@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
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

On Tue, Oct 24, 2023 at 8:17=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Mon, Oct 23, 2023 at 05:02:26PM -0700, Hsin-Yi Wang wrote:
> > Add makomo sku0 and sku1 which uses different audio codec.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> >  Documentation/devicetree/bindings/arm/mediatek.yaml | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Docu=
mentation/devicetree/bindings/arm/mediatek.yaml
> > index fe8c488a3207..b131e0bdbf01 100644
> > --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> > +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> > @@ -250,6 +250,18 @@ properties:
> >                - google,kodama-sku32
> >            - const: google,kodama
> >            - const: mediatek,mt8183
> > +      - description: Google Makomo (Lenovo 100e Chromebook 2nd Gen MTK=
 2)
> > +        items:
> > +          - const: google,makomo-rev4-sku0
> > +          - const: google,makomo-rev5-sku0
>
> With these bindings, how does one describe a makomo-rev5-sku0?
> What you have here is only suitable for describing the makomo-rev4-sku0.
>
makomo-rev5-sku0 and makomo-rev4-sku0 uses the same dts:

compatible =3D "google,makomo-rev4-sku0", "google,makomo-rev5-sku0",
                      "google,makomo", "mediatek,mt8183";

In this case, can bindings be listed like that?




> Cheers,
> Conor.
>
> > +          - const: google,makomo
> > +          - const: mediatek,mt8183
> > +      - description: Google Makomo (Lenovo 100e Chromebook 2nd Gen MTK=
 2)
> > +        items:
> > +          - const: google,makomo-rev4-sku1
> > +          - const: google,makomo-rev5-sku1
> > +          - const: google,makomo
> > +          - const: mediatek,mt8183
> >        - description: Google Willow (Acer Chromebook 311 C722/C722T)
> >          items:
> >            - enum:
> > --
> > 2.42.0.758.gaed0368e0e-goog
> >
