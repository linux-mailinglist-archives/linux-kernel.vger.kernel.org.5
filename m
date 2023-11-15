Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93E07EBBA7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbjKODW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjKODWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:22:54 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1A3D7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 19:22:51 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507973f3b65so9000846e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 19:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700018569; x=1700623369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxR8SEff9QhQWGnC0bTicTu902xyqq/a50SrjOH4Vi4=;
        b=GvXV6Bi3Ef+fzSbrh2Qe11H5ZnG9zXavsPWTfLAumfwiATz5ZAeUnl+RVLYDVPsESG
         yQgUgxidJnTOayE9zCPOFE/cJhB63AI5JMq9pf+lKUZuUzrjN4RMqyTHZfcGtRdX0BuS
         arRK7ApDMwy3KqWYDO5HgTyziEHA8YLPtL9ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700018569; x=1700623369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxR8SEff9QhQWGnC0bTicTu902xyqq/a50SrjOH4Vi4=;
        b=ClCaehzIIVFCQiGO9MMJi6qE2x5LD2oGpms/9hTFdNERbeDBk7hSyLXAH+cC6cumdv
         ePeXvYAleecZVzaI91Qw/lrVPkeFOc35sy/nN601BiAaVMG9bbPFyt8yDZyAksyBOJX1
         ULQ/h3A/E+1dh77P6t/8fLOxxP1WxFJ/c+sAlf30FNICixcxWhpUL07hDkWwJVGlwFls
         FnSsAPEXSqUJdn50c8fzxe2yT4WMeWb0F/Kwg5a12U4fHK6cLZQRnTb9FXNliVdNkxAF
         P8MnDOMW9TOdzzX5u5/Zvkueb2ZLrsA+3I3Mab91aMzlxJlFvdNOk6u+Vm9kqi5iYpcE
         5rAA==
X-Gm-Message-State: AOJu0YwJyw46GqivhBuQk+W9uLwXp2R9kdl8l06oD9BiV8QwqFAxoqfb
        rdSK3jMl5XWnFOuhQjZWnt7xKBc6EElwQ0oDNOTkWg==
X-Google-Smtp-Source: AGHT+IH/sEG2Ucut35rGScW2osfDdxASphCbak+GNijQXM9mN/aThAmwkj5q5kBza+Bkt5p0XJPSi1hAi7h0K4LMw1k=
X-Received: by 2002:a05:6512:1107:b0:509:7141:fec with SMTP id
 l7-20020a056512110700b0050971410fecmr8866004lfg.48.1700018569194; Tue, 14 Nov
 2023 19:22:49 -0800 (PST)
MIME-Version: 1.0
References: <20231114104353.1693966-1-treapking@chromium.org>
In-Reply-To: <20231114104353.1693966-1-treapking@chromium.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 15 Nov 2023 11:22:37 +0800
Message-ID: <CAGXv+5FaCBdwhnwQPWPpxUN3=MW9HeGnpRtsK7a0A=E0rAJDKQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mt8173: Add G2Touch touchscreen node
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

On Tue, Nov 14, 2023 at 6:44=E2=80=AFPM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> Lenovo Ideapad C330 Chromebook (MTK) uses G2Touch touchscreen as a
> second source component.
>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> ---
>
>  arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi b/arch/arm=
64/boot/dts/mediatek/mt8173-elm-hana.dtsi
> index bdcd35cecad9..0d6dbc36c352 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
> @@ -29,6 +29,14 @@ touchscreen3: touchscreen@20 {
>                 interrupt-parent =3D <&pio>;
>                 interrupts =3D <88 IRQ_TYPE_LEVEL_LOW>;
>         };
> +
> +       touchscreen4: touchscreen@40 {

The label likely isn't needed.

Otherwise,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> +               compatible =3D "hid-over-i2c";
> +               reg =3D <0x40>;
> +               hid-descr-addr =3D <0x0001>;
> +               interrupt-parent =3D <&pio>;
> +               interrupts =3D <88 IRQ_TYPE_LEVEL_LOW>;
> +       };
>  };
>
>  &i2c4 {
> --
> 2.42.0.869.gea05f2083d-goog
>
