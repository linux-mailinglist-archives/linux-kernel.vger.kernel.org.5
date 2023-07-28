Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E30766D98
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbjG1MtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjG1MtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:49:15 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9340730E1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:49:14 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bcfe28909so286514866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690548553; x=1691153353;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pbse/FL/bYEXl8Mf1x5aLqpTAzrAh7Ly043ErMcYY4k=;
        b=c/cFY5nVzAvu7QFQu1rz7uRvwVsVKG81Ki6j04f4TsAe7ATGVGdS4FzmF8VIboOogg
         dd5WRmUNjpKbJGx/YMPDWZl10r9zQSNGavTTjKyMXEow2Vb5e7LH6bUbiGpHpcML3k8v
         3SeNsF7yJU0tZijtUh+Kw4f0T7YzLA9+NPx9BRBafhkq92wHdco7DuK1vfE0xMxB55gv
         QRjZ+hijsp+NXXVbCzxb+sdm1X9NtOsNCCw5b9At1K7cQkiTGixF5vzjb92P7AyY//vo
         Zym9fOFDvmUsQxhpPloWOrTnZE/T1K7GJXtg5Wfr3E1WhYhI3qE8i9OryjYPlcbM6xJr
         HEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690548553; x=1691153353;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pbse/FL/bYEXl8Mf1x5aLqpTAzrAh7Ly043ErMcYY4k=;
        b=jt87Qvt6s2M43TFte+JneGmpLtBW+nKrikdjdizZuvw3Ae+JPo8HUHaWjSZ12YXXgs
         szIOVFiJAbz7rQaykD4B1jmQlPKyd19zBjNaQs+AqECPFTjjv80UhGUbn4fYy+B6KON0
         Tx7WQmu8lXZ/avQe0scqXMLUPDL0e9gx8JjFlZdraVX5BfFT2c1VvzYELmGrOfewWFXA
         k9I1Tc6DNv37DxmIl/selIfe95vphe9lSacSWEYXBK0A7enFHs5I7zaCEfL1iwRdKUEZ
         wjhZg7yEvL8QJ4BS6AdIvS7cY8Old2T96nB1Lh+ksMSyV6GwlRLY8AbGVtJTNKSPktHj
         3bCQ==
X-Gm-Message-State: ABy/qLYAgXlgmqpUiMNcXVj2BozBoaKNS2AQ8b9otaetH9KtvLlMJK53
        oAWOqX8VXxWOn8LNEMghMZwTiA==
X-Google-Smtp-Source: APBJJlE7Un/8lOfEtuAAfoTFWj+mEND0Z4JJSWgUz9Y7zsFlTWcgLUkH/JhnP38nXuMjCviOhje1ng==
X-Received: by 2002:a17:906:64d5:b0:991:e458:d14 with SMTP id p21-20020a17090664d500b00991e4580d14mr2238981ejn.34.1690548552914;
        Fri, 28 Jul 2023 05:49:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id mb5-20020a170906eb0500b0098963eb0c3dsm2010040ejb.26.2023.07.28.05.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 05:49:12 -0700 (PDT)
Message-ID: <7d70f893-ee75-d355-4b4c-4afe7a72cd7c@linaro.org>
Date:   Fri, 28 Jul 2023 14:49:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 5/6] ASoC: dt-bindings: mediatek,mt7986-wm8960: add
 mt7986-wm8960 document
Content-Language: en-US
To:     Maso Huang <maso.huang@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230728090819.18038-1-maso.huang@mediatek.com>
 <20230728090819.18038-6-maso.huang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728090819.18038-6-maso.huang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 11:08, Maso Huang wrote:
> Add document for mt7986 board with wm8960.
> 
> Signed-off-by: Maso Huang <maso.huang@mediatek.com>
> ---
>  .../sound/mediatek,mt7986-wm8960.yaml         | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt7986-wm8960.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt7986-wm8960.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt7986-wm8960.yaml
> new file mode 100644
> index 000000000000..76394f7e5502
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mediatek,mt7986-wm8960.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/mediatek,mt7986-wm8960.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT7986 sound card with WM8960 codec
> +
> +maintainers:
> +  - Maso Huang <maso.huang@mediatek.com>
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt7986-wm8960-machine
> +
> +  mediatek,platform:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of MT7986 platform.
> +
> +  audio-routing:
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    description:
> +      A list of the connections between audio components. Each entry is a
> +      sink/source pair of strings. Valid names could be the input or output
> +      widgets of audio components, power supplies, MicBias of codec and the
> +      software switch.
> +
> +  mediatek,audio-codec:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of wm8960 codec.
> +

How did you implement Rob's comment? Or did you just ignore it?

Best regards,
Krzysztof

