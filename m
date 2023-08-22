Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF48D784A93
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjHVTjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjHVTjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:39:10 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FE6128
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:39:08 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9a1681fa868so579150666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692733146; x=1693337946;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iM6e3frb++PnR0Ib4XyJCUAjxCXxDSOFOSMsGthGDoA=;
        b=AVJJGRIzF/BOLoOeKW9LHFOjdnH1qOIDSXTJKBKxQMeC6rE2ZxDhJlF1VFpkn/QpDh
         /gTyfowsMLpI6+z8s5iHfyXUf1NV/jA5K4y+qf01cJjq1nj460Toc+GFMRH9RRk4A4K5
         WoGAMxC31j+l3cGco4oRngxq1g9vQgFPGPxo9XHhThZzqMjvLaM0i7UQXC4FlzzxDwpX
         RtWqsImeFTIOL0Kdw+2LPuEzPNBD52a2JfqR27RvoJbqcLpAe0RUzdTKtQvK8Nd6TlGX
         E5WtLBXPVw7hCb2XkOF9wXRWG8iCndlspEdk6fDb3qwJxejrTIJ5uHEzTB1DsjPngW4e
         WEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692733146; x=1693337946;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iM6e3frb++PnR0Ib4XyJCUAjxCXxDSOFOSMsGthGDoA=;
        b=VHOBYv8nBrrT6xpkFbQ3az7GWwuGCWs4s/VqnYBCY9k/zYfzPVGk0ixjviqGCPuwb4
         8pd5CqZweq7oxpV7TGTBS3dHs71aRNd7mGil+HiRQuJgHGAbUCsiWhp11jIqNM3BtKQk
         F8wOKYyyWUI/kaXcghh8q435xmGNfpMktJ+brV/zJ2WPw1cqXTSBs56/GX6sG0Gqq/7q
         MRjbgsdrajAB91/MZxTjsDMLFoWtNEyOqqu2Or7PI/gY8iR/aNeZDxyxWbWNmqUUcS7e
         GOO32LyP2uGWWL2X+p4CLWPOOGp/rAoIzRJZmvppWI7zVge2mliad4f4Ev8JVrUD36SO
         KMmA==
X-Gm-Message-State: AOJu0YxihuWHwR0VXz1QG+FsLQcaL78BvMCaahQjtjCZcSmnKDrquXQO
        MbAg3AVq8ivRQsXVh8QKA9Xx6g==
X-Google-Smtp-Source: AGHT+IEvqf7NBIX9sYu34ZeTHC01Kg056aUDNnpPAva4BftQurbBYDw/CJMFf9oPIvERhZk2AT4yzQ==
X-Received: by 2002:a17:906:3003:b0:99d:f2dc:97e3 with SMTP id 3-20020a170906300300b0099df2dc97e3mr8841240ejz.20.1692733146583;
        Tue, 22 Aug 2023 12:39:06 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id sa4-20020a170906eda400b00992665694f7sm8635013ejb.107.2023.08.22.12.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 12:39:06 -0700 (PDT)
Message-ID: <337f20d5-4dfe-90ef-16b9-c10b14060b97@linaro.org>
Date:   Tue, 22 Aug 2023 21:39:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 05/11] regulator: dt-bindings: mediatek: Add MT6366
 PMIC
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
References: <20230822084520.564937-1-wenst@chromium.org>
 <20230822084520.564937-6-wenst@chromium.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230822084520.564937-6-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2023 10:45, Chen-Yu Tsai wrote:
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
> Changes since v1:
> - Replaced underscores in supply names to hyphens
> - Merged with MT6358 regulator binding
> - Added MT6358 fallback compatible to MT6366 regulator
> 
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
>  .../regulator/mediatek,mt6358-regulator.yaml  | 227 +++++++++++++-----
>  1 file changed, 168 insertions(+), 59 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
> index 82328fe17680..b350181f33ff 100644
> --- a/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
> @@ -16,14 +16,18 @@ description: |
>  
>  properties:
>    compatible:
> -    const: mediatek,mt6358-regulator
> +    oneOf:
> +      - const: mediatek,mt6358-regulator
> +      - items:
> +          - const: mediatek,mt6366-regulator
> +          - const: mediatek,mt6358-regulator
>  
>    vsys-ldo1-supply:
>      description: Supply for LDOs vfe28, vxo22, vcn28, vaux18, vaud28, vsim1, vusb, vbif28
>    vsys-ldo2-supply:
> -    description: Supply for LDOs vldo28, vio28, vmc, vmch, vsim2
> +    description: Supply for LDOs vldo28 (MT6358 only), vio28, vmc, vmch, vsim2
>    vsys-ldo3-supply:
> -    description: Supply for LDOs vcn33, vcama1, vcama2, vemc, vibr
> +    description: Supply for LDOs vcn33, vcama[12] (MT6358 only), vemc, vibr
>    vsys-vcore-supply:
>      description: Supply for buck regulator vcore
>    vsys-vdram1-supply:
> @@ -43,75 +47,138 @@ properties:
>    vsys-vs2-supply:
>      description: Supply for buck regulator vs2
>    vs1-ldo1-supply:
> -    description: Supply for LDOs vrf18, vefuse, vcn18, vcamio, vio18
> +    description: Supply for LDOs vrf18, vefuse, vcn18, vcamio (MT6358 only), vio18
>    vs2-ldo1-supply:
> -    description: Supply for LDOs vdram2
> +    description: Supply for LDOs vdram2, vmddr (MT6366 only)
>    vs2-ldo2-supply:
>      description: Supply for LDOs vrf12, va12
>    vs2-ldo3-supply:
> -    description: Supply for LDOs vsram-gpu, vsram-others, vsram-proc11, vsram-proc12
> -  vs2-ldo4-supply:
> -    description: Supply for LDO vcamd
> -
> -patternProperties:
> -  "^buck_v(core|dram1|gpu|modem|pa|proc1[12]|s[12])$":
> -    description: Buck regulators
> -    type: object
> -    $ref: regulator.yaml#
> -    unevaluatedProperties: false
> -
> -  "^ldo_v(a|rf)12":
> -    description: LDOs with fixed 1.2V output and 0~100/10mV tuning
> -    type: object
> -    $ref: regulator.yaml#
> -    unevaluatedProperties: false
> -
> -  "^ldo_v((aux|cn|io|rf)18|camio)":
> -    description: LDOs with fixed 1.8V output and 0~100/10mV tuning
> -    type: object
> -    $ref: regulator.yaml#
> -    unevaluatedProperties: false
> -
> -  "^ldo_vxo22":
> -    description: LDOs with fixed 2.2V output and 0~100/10mV tuning
> -    type: object
> -    $ref: regulator.yaml#
> -    unevaluatedProperties: false
> -
> -  "^ldo_v(aud|bif|cn|fe|io)28":
> -    description: LDOs with fixed 2.8V output and 0~100/10mV tuning
> -    type: object
> -    $ref: regulator.yaml#
> -    unevaluatedProperties: false
> -
> -  "^ldo_vusb":
> -    description: LDOs with fixed 3.0V output and 0~100/10mV tuning
> -    type: object
> -    $ref: regulator.yaml#
> -    unevaluatedProperties: false
> -
> -  "^ldo_vsram_(gpu|others|proc1[12])$":
> -    description: LDOs with variable output
> -    type: object
> -    $ref: regulator.yaml#
> -    unevaluatedProperties: false
> -
> -  "^ldo_v(cama[12]|camd|cn33|dram2|efuse|emc|ibr|ldo28|mc|mch|sim[12])$":
> -    description: LDOs with variable output and 0~100/10mV tuning
> -    type: object
> -    $ref: regulator.yaml#
> -    unevaluatedProperties: false

I don't understand. You just added it and it is already wrong? Please,
do not add code which is clearly incorrect.


Best regards,
Krzysztof

