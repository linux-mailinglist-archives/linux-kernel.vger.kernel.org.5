Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B2C78DDA9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245486AbjH3SwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243644AbjH3LUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:20:33 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EAB122
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 04:20:30 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so162852966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 04:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693394428; x=1693999228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2edGeLLjwmBS5v07/x8wBG8ynN8bGWmxjzGyhRyL4R4=;
        b=tBbXUCpYIsf4uI6RHC8V2cNr0SWyOAQb86/HvZfzbbmAD1OQ6j3NqkCn68yVpsunYn
         lgVrnSUDibNlEW+il/3FMWuQnFZcRNkpdoWSgetbZtFu2oCHkYwIlmcXhKigPcW7UMnh
         UZMiGETooME6v+LNR9+ldiyAm5/14YLdC2NWGncLz8uW1fe5f1fmZNQXndjvlECA9F4o
         6u+yPzgH46YwH9V4yi08z/sqPflGE1JJQ45bJ5GixTVxPcm5CtYMaeuF05UFgzvGT8vo
         0H833vCXMqsnYcbmeyeHeZnFuOpdB8+s4NBYI4DS61nDXEDib/QOKJIwzD8HZlkdczdi
         Qt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693394428; x=1693999228;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2edGeLLjwmBS5v07/x8wBG8ynN8bGWmxjzGyhRyL4R4=;
        b=c5KX8fnc1Uze8IH0hPbAVjB/Rv49L/VR3JAq/YHd25l2pd8ldnOFuFGRuqSfn7smgK
         vMlnwszvuvb+GIByaivwCYU0xUabjpLZOlhpjTPjNcm2axwY99FUmfARuJRtuhDfMYzp
         nCXyN4yDgZLJH6g/di4VtLm5vWHxZqjUPzIiNa80XrM2X8/HDV9HrXndeOUxbmWtFlS8
         7oYLclrwYzhK6rDfR+3J7+MT5V/CKKXmC0/tExDnGly5yGNoGPLR/ePctaf3on7sfvSO
         q7UDKBDVh8nu8MyPzoH+bvZwDHNGLfHGpXqF5KggAMQCBzRRuCcs4LWp1sumJT+QRG6A
         desw==
X-Gm-Message-State: AOJu0Yya3uaEkvn+bK0ILTvpBaRCYN3yNnui7AlVWJ0jzmCY2AbnYyaR
        +9myzEkveX9QrwB7XI/Go9M9BQ==
X-Google-Smtp-Source: AGHT+IGWmLI8SNyABERgpk/JQhn4b2kn6YcGVWoqyPZlcujUm5Gv0Gjrq5MgGtIM1CvqGV3TUZIN6w==
X-Received: by 2002:a17:906:6a19:b0:9a1:bb8f:17d5 with SMTP id qw25-20020a1709066a1900b009a1bb8f17d5mr2988524ejc.30.1693394428553;
        Wed, 30 Aug 2023 04:20:28 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id c11-20020a170906924b00b0099297c99314sm7126710ejx.113.2023.08.30.04.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 04:20:27 -0700 (PDT)
Message-ID: <7cba182f-2b35-84e5-16c7-770a6aff5062@linaro.org>
Date:   Wed, 30 Aug 2023 13:20:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 3/4] arm64: dts: mediatek: mt6360: add PMIC MT6360
 related nodes
Content-Language: en-US
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
References: <20230825114623.16884-1-macpaul.lin@mediatek.com>
 <20230830111532.9048-1-macpaul.lin@mediatek.com>
 <20230830111532.9048-3-macpaul.lin@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230830111532.9048-3-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2023 13:15, Macpaul Lin wrote:
> +
> +	led {
> +		compatible = "mediatek,mt6360-led";
> +	};
> +
> +	regulator {
> +		compatible = "mediatek,mt6360-regulator";
> +		LDO_VIN3-supply = <&mt6360_emi_vddq_buck2_reg>;
> +
> +		mt6360_emi_vdd2_buck1_reg: buck1-emi-vdd2 {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

Best regards,
Krzysztof

