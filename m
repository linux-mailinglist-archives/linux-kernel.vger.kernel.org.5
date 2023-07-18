Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E6F757AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjGRLmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjGRLmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:42:35 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BBD19B2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:42:15 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-986d8332f50so729893066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689680532; x=1692272532;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EK+VTwTdErg5iekBiaTeYX5r7dT6fD+apvm8qmzsbyc=;
        b=voyAqL/BTsrNt3HDNRmbRDHgSrt/GORWFQdAFHOHVQqONTRIr+g5TQSVqxfLjF+Ozv
         9wGzzi6OWeLozlp2c0O1nwswzsNvFVR9NQFDRp1h5tVX82fFbpcGWLZcsUGIqjCeKdbC
         Cm6z/bmm+X4PNNdjUArZx4WfQfI3JwZ95uhn8lrv0yaFyJgk/nry1fZolo9ek9AHY3mU
         PGfVsElxK+0jBG9duHBBpzcn3YuTUxrNdRI/XUYIRON1jHqdIKIwR7Cj9eJcl1oP8IOy
         LWn39/AdwLPhObwPc6/n1KvCS4BUjstNsJ6dCPVRHa9fw3RuS+TwyH9Qb9LE3n46YiHh
         8h3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689680532; x=1692272532;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EK+VTwTdErg5iekBiaTeYX5r7dT6fD+apvm8qmzsbyc=;
        b=VWZa6QcsB7S01IHdYh1ijIJO+feWhKfg4h0DrJU0yaLJ25Vn8VwDSpeuY7uG5UZim7
         fETk/mjfQRdgqtmMf+tfua90yAIYcx+C0jmcT1/SmPaYiwTQ4I+4N9hbwLJX3o7yUTeY
         5oAiiXJIl8PdjkxVmglCdXMhAvxjrUZ7qecPir9bpXNdMVwglQT1UENUWqEqTtjQJXi7
         YNqk/Gq5knDDPqAhnPVDaz1tAUrh+OfCiehmyKM2iNYa+1NjsGKszgADwZDFh/dtSeoS
         MJeLQSEHmLZVIUE6vTq0YGQrk+dxM8daHubMnRIGq+4B+0LUMCEN5PGM1k6Etbif4jrs
         r5cQ==
X-Gm-Message-State: ABy/qLbxZ7ZzBcUGzuT7lhbjRFovMKYqeFtrKBfPjQv0CpkWwyiMU5eu
        0D+48V003ajUbacjUxMROgAi9g==
X-Google-Smtp-Source: APBJJlHEPY03BmEn7p4RayPmGdhzkVvZpcfhx9g9ys0BJCFXp8fGzQQDkatuBE5ckYJw5eR7d0RtzA==
X-Received: by 2002:a17:906:739e:b0:977:befe:d888 with SMTP id f30-20020a170906739e00b00977befed888mr14595037ejl.13.1689680530844;
        Tue, 18 Jul 2023 04:42:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id l5-20020a1709065a8500b00992c92af6easm904900ejq.161.2023.07.18.04.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 04:42:10 -0700 (PDT)
Message-ID: <b974af38-af5d-5d09-0e18-791769c95522@linaro.org>
Date:   Tue, 18 Jul 2023 13:42:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] dt-bindings: soc: mediatek: Add mtk-socinfo driver
Content-Language: en-US
To:     William-tw Lin <william-tw.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230718112143.14036-1-william-tw.lin@mediatek.com>
 <20230718112143.14036-3-william-tw.lin@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230718112143.14036-3-william-tw.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 13:21, William-tw Lin wrote:
> dt-binding documentation for mtk-socinfo driver.
> mtk-socinfo driver provides SoC-related information.
> Such information includes manufacturer information, SoC name,
> SoC segment name, and SoC marketing name.
> 
> Signed-off-by: William-tw Lin <william-tw.lin@mediatek.com>
> ---
>  .../bindings/soc/mediatek/mtk-socinfo.yaml    | 58 +++++++++++++++++++

Put it in appropriate place - hwinfo.

>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mtk-socinfo.yaml

Wrong filename: missing vendor prefix, not matching compatibles.

> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mtk-socinfo.yaml b/Documentation/devicetree/bindings/soc/mediatek/mtk-socinfo.yaml
> new file mode 100644
> index 000000000000..4420430a9bca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mtk-socinfo.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/mediatek/mtk-socinfo.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek SOC information
> +
> +maintainers:
> +  - William Lin <william-tw.lin@mediatek.com>
> +  - Matthias Brugger <matthias.bgg@gmail.com>
> +  - Kevin Hilman <khilman@kernel.org>
> +
> +description:
> +  The MTK socinfo driver can retrieve several

Driver? As in Linux driver? Drop. Describe hardware instead.

> +  SoC related information based on settings in eFuse.
> +  Such information include manufacturer information, SoC name,
> +  SoC segment name, and SoC marketing name.
> +
> +

Just one blank line.

> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt8173-socinfo
> +      - mediatek,mt8183-socinfo
> +      - mediatek,mt8186-socinfo
> +      - mediatek,mt8188-socinfo
> +      - mediatek,mt8192-socinfo
> +      - mediatek,mt8195-socinfo
> +
> +

Ditto...


> +  nvmem-cells:
> +    description:
> +      Phandle to the eFuse data for SoC differentiation.
> +    items:
> +      - description: eFuse data that mtk-socinfo driver uses for SoC differentiation
> +
> +  nvmem-cell-names:
> +    minItems: 1
> +    items:
> +      - const: socinfo-data1
> +      - const: socinfo-data2

This does not match your cells.

> +
> +required:
> +  - compatible
> +  - nvmem-cells
> +  - nvmem-cell-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +        mtk_socinfo: socinfo {

Broken indentation.

> +            compatible = "mediatek,mt8186-socinfo";
> +            nvmem-cells = <&socinfo_data1>;
> +            nvmem-cell-names = "socinfo-data1";

No other resources? So this is just DT description of driver? Does not
look like suitable for DT in the first place.



Best regards,
Krzysztof

