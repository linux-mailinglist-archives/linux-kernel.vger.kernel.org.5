Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BD37692AD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjGaKFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbjGaKEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:04:43 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0611BD3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:04:04 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31783d02093so3940104f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690797843; x=1691402643;
        h=mime-version:message-id:in-reply-to:date:subject:to:from:user-agent
         :references:from:to:cc:subject:date:message-id:reply-to;
        bh=xmu3IjUQ2taW3zTxDp9/zo0P78kimt745EhKwmVkMfQ=;
        b=Vz8bn6xtRr9ajaVL2BYH/aU5C5qeoqk0tN1tW8v5Bz3+absmnMeoDLPOTrnC4mkk/M
         9+D9rninKuwW61xhv+cDJcG0P33QMQ5HZz1mfs7UiwCXi6dIM/vsZyh3HjQ9922kj/4s
         +jIin1qddCBn41gsu0Eo3jA+DxF8aM+9VZV6koeVX4ph6OqSYHlQ54AaEJNN4iEc1wD8
         3yclrtFuxve6PCVDn+11GlYIJWc0Ha3DyBodOsez5rv8FHqjZNRq2htMQzNF9Ho13HT8
         h/RrB+CklDlcmR7qAzMy0Ink/xkNE7JCgUqwrQsDQYYWQ6E9D+lOkpmzCoYZNzO26OPs
         82ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690797843; x=1691402643;
        h=mime-version:message-id:in-reply-to:date:subject:to:from:user-agent
         :references:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xmu3IjUQ2taW3zTxDp9/zo0P78kimt745EhKwmVkMfQ=;
        b=RNraS3t5kXApIJzQxtJ3Mqd0loR5xZMTBGcqqsIXI3g0+ofn6Tsg7Un0jFt957JpAd
         MaCmrpfKh6Px02n69l0bTjV1fEiqi/u9W+WIvs4JBFevtg3LH4WjrhkHMLRlPrjvN29c
         YfewYPWaszdKKdlOweiHVxAXI26kUG0uvAUThIrkgUjMM0dnokGaDf9bTPlDhSq68f1w
         Z4xPDV1rskOJ3PZgIop15wQfnWlOJgonTwDCO2shOjaQnfWAZwkrm2yb/TeWECp6TJGD
         p+/N5lUotYCimXO0kivwMC/lHnYD3tQuKtOuJwIccow3WZbhVCkgCvMczjdq34JGge25
         XOQw==
X-Gm-Message-State: ABy/qLYj55d+g44oRFMJ56pQCqfGN/bMnnecDsCSpN3F0CJ3kan7W8MB
        5VXEB5lzRmw9dSHyrTD1wHSKkA==
X-Google-Smtp-Source: APBJJlG/6YtIJ2PZyWt5JPzeSkuVMJs1cDNhO+1x9k/xAk4VYOxr9uirGMxr5kOpAVkpkBapLLbIcQ==
X-Received: by 2002:adf:f681:0:b0:314:46af:e1e7 with SMTP id v1-20020adff681000000b0031446afe1e7mr8192622wrp.34.1690797842657;
        Mon, 31 Jul 2023 03:04:02 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:686f:cc54:f527:35c0])
        by smtp.gmail.com with ESMTPSA id f11-20020adff58b000000b003143aa0ca8asm12553696wro.13.2023.07.31.03.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 03:04:02 -0700 (PDT)
References: <20230731094303.185067-1-krzysztof.kozlowski@linaro.org>
 <20230731094303.185067-2-krzysztof.kozlowski@linaro.org>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Rohit kumar <quic_rohkumar@quicinc.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Rao Mandadapu <srivasam@codeaurora.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 01/12] ASoC: dt-bindings: amlogic,gx-sound-card: correct
 maxItems constraints
Date:   Mon, 31 Jul 2023 11:52:53 +0200
In-reply-to: <20230731094303.185067-2-krzysztof.kozlowski@linaro.org>
Message-ID: <1jr0oowg6m.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 31 Jul 2023 at 11:42, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> minItems without maxItems implies upper limit, so add some high maxItems
> to fix dtbs_check warnings like:
>
>   meson-gxm-s912-libretech-pc.dtb: sound: audio-routing: ['AU2 INL', 'ACODEC LOLN', 'AU2 INR', 'ACODEC LORN', '7J4-14 LEFT', 'AU2 OUTL', '7J4-11 RIGHT', 'AU2 OUTR'] is too long

The only contraints is that values come in pair and there is no upper
limit to the number of routes a device (using this driver) may have.

The upper limit of 8 might work now but is very likely to be wrong for
the next device to come.

Is there way to correctly describe this "pair" contraint with DT schema ?

If not, then I guess the most adequate solution is to drop minItems and
give no bound, like simple-card is doing for the same type of properties.

Same goes for the audio-widgets property

>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/sound/amlogic,gx-sound-card.yaml        | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml b/Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml
> index b358fd601ed3..45d6202d9730 100644
> --- a/Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml
> +++ b/Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml
> @@ -21,6 +21,7 @@ properties:
>    audio-routing:
>      $ref: /schemas/types.yaml#/definitions/non-unique-string-array
>      minItems: 2
> +    maxItems: 32
>      description: |-
>        A list of the connections between audio components. Each entry is a
>        pair of strings, the first being the connection's sink, the second
> @@ -29,6 +30,7 @@ properties:
>    audio-widgets:
>      $ref: /schemas/types.yaml#/definitions/non-unique-string-array
>      minItems: 2
> +    maxItems: 8
>      description: |-
>        A list off component DAPM widget. Each entry is a pair of strings,
>        the first being the widget type, the second being the widget name

