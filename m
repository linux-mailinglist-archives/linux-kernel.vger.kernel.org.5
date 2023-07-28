Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BA67669A0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbjG1KAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbjG1KAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:00:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9800C35A3;
        Fri, 28 Jul 2023 03:00:23 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5CF73660716B;
        Fri, 28 Jul 2023 11:00:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690538422;
        bh=GfgvmH2WHbgBZoOFc/snpKhv9Aw7Q3s20trVQrjO9O0=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=SbDPJ5xi+Dx76BbLhKke2U/N/r+zPI49kYVVFhkfX1Am0Lr2Fakh487y1wuZyzZG9
         a5gqJxb9PqQR4xIk3d6YQI0qkVgBQzYkIyHDK+0jGtl80/fVLGbyGw3CIurDxZPqUB
         wV52ePLPdYWVNOS+QWlJsNN+sOEdOerYRWxu888KWLE7V3kQ/Gt4BkTrJGEi9z6Z0l
         rumZuZ36SkztWDOdzll+F1yeH8A9/dFixejh6AeXNhH8+f7HgYLzemrakU/hd6CLpI
         ejDaX9C4ziofdPtjA8QyPVJQOHIBrrXhZ256ikrQjF/wnT1GaftD8aHGK0HnaU2v65
         wtYU4i2A30QsQ==
Message-ID: <b2869bdd-04e8-262d-5d1a-4d835397360e@collabora.com>
Date:   Fri, 28 Jul 2023 12:00:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 6/6] ASoC: dt-bindings: mediatek,mt7986-afe: add audio
 afe document
Content-Language: en-US
To:     Maso Huang <maso.huang@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
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
 <20230728090819.18038-7-maso.huang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230728090819.18038-7-maso.huang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/07/23 11:08, Maso Huang ha scritto:
> Add mt7986 audio afe document.
> 
> Signed-off-by: Maso Huang <maso.huang@mediatek.com>
> ---
>   .../bindings/sound/mediatek,mt7986-afe.yaml   | 89 +++++++++++++++++++
>   1 file changed, 89 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt7986-afe.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt7986-afe.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt7986-afe.yaml
> new file mode 100644
> index 000000000000..ebb151c6400f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mediatek,mt7986-afe.yaml
> @@ -0,0 +1,89 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/mediatek,mt7986-afe.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek AFE PCM controller for MT7986
> +
> +maintainers:
> +  - Maso Huang <maso.huang@mediatek.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: mediatek,mt7986-afe
> +      - items:
> +          - enum:
> +              - mediatek,mt7981-afe
> +              - mediatek,mt7988-afe
> +          - const: mediatek,mt7986-afe
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 5
> +    items:
> +      - description: audio bus clock
> +      - description: audio 26M clock
> +      - description: audio intbus clock
> +      - description: audio hopping clock
> +      - description: audio pll clock
> +      - description: mux for pcm_mck
> +      - description: audio i2s/pcm mck
> +
> +  clock-names:
> +    minItems: 5
> +    items:
> +      - const: bus_ck
> +      - const: 26m_ck
> +      - const: l_ck
> +      - const: aud_ck
> +      - const: eg2_ck
> +      - const: sel
> +      - const: i2s_m
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - assigned-clocks
> +  - assigned-clock-parents

assigned-clocks and assigned-clock-parents are not a *required* property,
as that depends on a number of things and someone *may* want to omit it.

Besides, that's related to how the drivers interact with / setup the hardware
and not with the hardware itself... you can keep the assigned-clocks and
assigned-clock-parents in your examples, but again they're definitely not
required properties.

After fixing,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Regards,
Angelo

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/mt7986-clk.h>
> +
> +    afe@11210000 {
> +        compatible = "mediatek,mt7986-afe";
> +        reg = <0x11210000 0x9000>;
> +        interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&infracfg_ao CLK_INFRA_AUD_BUS_CK>,
> +                 <&infracfg_ao CLK_INFRA_AUD_26M_CK>,
> +                 <&infracfg_ao CLK_INFRA_AUD_L_CK>,
> +                 <&infracfg_ao CLK_INFRA_AUD_AUD_CK>,
> +                 <&infracfg_ao CLK_INFRA_AUD_EG2_CK>;
> +        clock-names = "bus_ck",
> +                      "26m_ck",
> +                      "l_ck",
> +                      "aud_ck",
> +                      "eg2_ck";
> +        assigned-clocks = <&topckgen CLK_TOP_A1SYS_SEL>,
> +                          <&topckgen CLK_TOP_AUD_L_SEL>,
> +                          <&topckgen CLK_TOP_A_TUNER_SEL>;
> +        assigned-clock-parents = <&topckgen CLK_TOP_APLL2_D4>,
> +                                 <&apmixedsys CLK_APMIXED_APLL2>,
> +                                 <&topckgen CLK_TOP_APLL2_D4>;
> +    };
> +
> +...


