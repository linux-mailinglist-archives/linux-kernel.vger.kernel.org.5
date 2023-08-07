Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249B1771A3D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjHGGX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjHGGXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:23:54 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E322610F9
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 23:23:52 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe4ad22eb0so24868885e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 23:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691389431; x=1691994231;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3A446E/kT3GEJ5OdOfp6vlTjEoG2ufXKFcEfUJuKEMI=;
        b=wY2Bp5xhxoMYp9AWapejnTHfg+ixw+U4HdSL7LFDfxm1JL3Sd3BL4myGDItmJgB6/s
         zV5taHSANXkoO8LH9RME+CUJLq4IgqsXy6oZRYJjWa7b+FLh+ec28dPyngJlywQwWSST
         Rfj+3Hujx0jViEih2fanVRArvPyRS348FK6ZIXEydCv7x0nvC7JTz3h5ggDqtScEpfYh
         sI/YoU6nhDalj3uqCPbhdKZ+v3FBy5xJp8Hy3hd7AckJJxUMGa6yqx+paVcadbX/FxO5
         PklfjvLiwNpWgZ11q/yhX3nh9dXdHsMitzgLHwl/3lej+1dFTGXN7CELuu2MU89O/th1
         +aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691389431; x=1691994231;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3A446E/kT3GEJ5OdOfp6vlTjEoG2ufXKFcEfUJuKEMI=;
        b=SzgXQm59TWyVjmjKdRo4zcfGo/3gfXt0qolAiPkf7l1aFG6YSIAdue45dO7HbP+6zy
         qWbeRk+eaFnJ2FNdQH3eJZl+p5jocvMr1GyAKYOdm0nHkz+U9c9HrosPZHbHcmElAVEi
         2lK9/3tlBYc5sxVfytIVmjfo9LAqvbgy4g4dzCB0Hyfos7L6J+WAnh0MpQn4CU8tNI9i
         XglhBNxyXyR7rR6kD41KVxgVZIRlNKwCJcp5o9KMVZrePEgtmaHncVn8kiZj+/7QHtjn
         3DxYmnJUXrFtWttks3avyhv9dpyr3Mxl6q6/Jk/o0a71RiS0OEGf8MsTblEIu9ROIXLK
         qLfQ==
X-Gm-Message-State: AOJu0Yzvg9shBN8oSvC6Zt5hNincvox84nRPj2k5+zf9g3JXzylq6Thc
        6X98jYroIkfYJacheVLXX/FMQA==
X-Google-Smtp-Source: AGHT+IG0HwQnerR7/Jt+ZlEFWrzo/YHVAHF7jx+cIf1OJDRkcHOwo7Ixn6i8JDQMCLC5UL0HXqh+Aw==
X-Received: by 2002:a05:600c:2286:b0:3fa:8c68:4aba with SMTP id 6-20020a05600c228600b003fa8c684abamr6193638wmf.25.1691389430634;
        Sun, 06 Aug 2023 23:23:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id t25-20020a1c7719000000b003fe2b6d64c8sm13923548wmi.21.2023.08.06.23.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Aug 2023 23:23:50 -0700 (PDT)
Message-ID: <6bf91ced-076f-ecc1-f626-f531f7d991bd@linaro.org>
Date:   Mon, 7 Aug 2023 08:23:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 4/9] regulator: dt-bindings: mediatek: Add MT6366 PMIC
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Zhiyong Tao <zhiyong.tao@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230803074249.3065586-1-wenst@chromium.org>
 <20230803074249.3065586-5-wenst@chromium.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230803074249.3065586-5-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2023 09:42, Chen-Yu Tsai wrote:
> From: Zhiyong Tao <zhiyong.tao@mediatek.com>
> 
> The MediaTek MT6366 PMIC is similar to the MT6358 PMIC. It is designed
> to be paired with the MediaTek MT8186 SoC. It has 9 buck regulators and
> 29 LDO regulators, not counting ones that feed internally and basically
> have no controls. The regulators are named after their intended usage
> for the SoC and system design, thus not named generically as ldoX or
> dcdcX, but as vcn33 or vgpu.
> 
> Add a binding document describing all the regulators and their supplies.
> 
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> [wens@chromium.org: major rework and added commit message]
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since Zhiyong's last version (v4) [1]:
> - simplified regulator names
> - added descriptions to regulators
> - removed bogus regulators (*_sshub)
> - merged vcn33-wifi and vcn33-bt as vcn33
> - added missing regulators (vm18, vmddr, vsram-core)
> - cut down examples to a handful of cases and made them complete
> - expanded commit message a lot
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20220823123745.14061-1-zhiyong.tao@mediatek.com/
> 
>  .../regulator/mediatek,mt6366-regulator.yaml  | 154 ++++++++++++++++++
>  1 file changed, 154 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.yaml
> new file mode 100644
> index 000000000000..715c6ffcb3ab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.yaml
> @@ -0,0 +1,154 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/mediatek,mt6366-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MT6366 Regulator from MediaTek Integrated
> +
> +maintainers:
> +  - Zhiyong Tao <zhiyong.tao@mediatek.com>
> +
> +description: |
> +  Regulator part of the MT6366 PMIC. This node should be under the PMIC's
> +  device node.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6366-regulator
> +
> +  vsys_ldo1-supply:

Don't use underscores in property names. Only hyphens, if needed.

> +    description: Supply for LDOs vfe28, vxo22, vcn28, vaux18, vaud28, vsim1, vusb, vbif28
> +  vsys_ldo2-supply:



Best regards,
Krzysztof

