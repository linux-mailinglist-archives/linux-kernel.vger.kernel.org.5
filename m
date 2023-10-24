Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B3F7D5BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344278AbjJXTqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 15:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjJXTqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:46:43 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DA910CF
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 12:46:41 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-5844bc378feso1907278eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 12:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698176800; x=1698781600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ko81kVFawiPk62I2UsRSceb9b1VOPxmBQiQP7A61UvE=;
        b=ggSESHXogeyEi2KMclNLSh6AieR4p/uZ47mGljvRfiliGJKwa0ZrrX1gtPh2vUkH5S
         k3k4nARuZ7Sb8H3d1DxOUWKB60USYi0W+wjvtcMqsOtD0o+oKL66Poqjdx6/kc+y0Ess
         6AG4Qtpxi/Jp0wDWBzM3fg+M3kna8cZXw5Wuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698176800; x=1698781600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ko81kVFawiPk62I2UsRSceb9b1VOPxmBQiQP7A61UvE=;
        b=Om32hObHFFDBOtLTYi4rjujTvPhS+KADK84Tj5F+/RBWq/V87oUqUp5HoopnM+lCXX
         Rmjxx2/0Fkn2z/co+3yKaTbN7xhZEw4nOEuGQ0oAYep5yDIbat7beA9gK8nZiZxuPmZM
         +KkF0OWSuvE8L2cfjopaEpFeaEa7sibbIvNQ6o53bkiM0076nQXmIAbnN78eagdSPrem
         qgT1cSB8qbOFVMMDSqKZfywsPoMDceyz/xrkPiVPExLa82PNHKU+Tg2GGV6Fywn4x47m
         KbpjR8YwEbMiSgMA/cTgcBAmeqcRQO6OvhODvLsQCDBDgeLt3LvkXD5RXkV04fq1H5T0
         HxpA==
X-Gm-Message-State: AOJu0YxgO44fEtZZ8VC1+pLMbIFf15CNjxtpZ3tUM7R11VQtHGAKFEVT
        L5+6VTtLRd/YN0fICqsbtKQSg5XYIzpQLR5yyHoI8w==
X-Google-Smtp-Source: AGHT+IGZLu9siBSnt2MbWkvBMR/N7snwcPPmuPMWWr58Q8rokuqI3qNHuZ9YSR/3f+pgfmtMzYR7ZeBgSq+sGhGPjVQ=
X-Received: by 2002:a4a:bb0f:0:b0:571:1fad:ebe0 with SMTP id
 f15-20020a4abb0f000000b005711fadebe0mr13943983oop.3.1698176800424; Tue, 24
 Oct 2023 12:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231024000724.57714-1-hsinyi@chromium.org> <20231024000724.57714-2-hsinyi@chromium.org>
 <20231024-reenact-wildfowl-de6575bbe6f6@spud>
In-Reply-To: <20231024-reenact-wildfowl-de6575bbe6f6@spud>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 24 Oct 2023 12:46:14 -0700
Message-ID: <CAJMQK-g2hWi1GO+9HxE=0AUDWMNF1YSQc9z8=imdF8FduOr+MA@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-katsu
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 8:15=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Mon, Oct 23, 2023 at 05:02:24PM -0700, Hsin-Yi Wang wrote:
> > Add katsu and katsu sku38 which uses different audio codec.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> >  Documentation/devicetree/bindings/arm/mediatek.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Docu=
mentation/devicetree/bindings/arm/mediatek.yaml
> > index a5999b3afc35..fe8c488a3207 100644
> > --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> > +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> > @@ -235,6 +235,12 @@ properties:
> >          items:
> >            - const: google,kappa
> >            - const: mediatek,mt8183
> > +      - description: Google Katsu (ASUS Chromebook Detachable CZ1)
> > +        items:
> > +          - enum:
> > +              - google,katsu
> > +              - google,katsu-sku38
>
> This seems a little odd - does the non sku38 not have an sku of its own?
>

It's actually sku32. I'll update that in the next version. Thanks.

> > +          - const: mediatek,mt8183
> >        - description: Google Kodama (Lenovo 10e Chromebook Tablet)
> >          items:
> >            - enum:
> > --
> > 2.42.0.758.gaed0368e0e-goog
> >
