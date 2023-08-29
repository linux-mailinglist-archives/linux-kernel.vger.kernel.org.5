Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12B478CA4F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237626AbjH2RLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237650AbjH2RKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:10:54 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA3BFD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:10:50 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-500c63c9625so1072764e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693329049; x=1693933849;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kUDDfMckAfjBAxdn8UbsV0PI1LaLGtDpMC0izbCsEyw=;
        b=pbC+E701z8pgAN9J67YbQJLsxBdHLBVuAwWonWR5+gntMBHPmLJHBjfbBiNQVphcP8
         cBwZkTZLuowp76ilvXiunTr2QEfNU2Y/kgamH0fblMtM4htx8QtaOJm2UTSYJbumxECf
         TtipZgQX+Tp1ub30QDnmp33Jf/yIg9cuJ9Hq1tc17nN/TkJBtcY7mnKK9Tb83yC9hvgN
         TvWBsyvgSjU54aVkyabIYO/HiUae25sHmytR4eDgGArQhWIt30MMh3PTM/MB3q53Zzoz
         uyp0CLPUJlieiZpN/RSgt4gNmxiGPKdhKEywcGPGiOxEwoYbZyVvSkobOX6Qbf/CaZP/
         X2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693329049; x=1693933849;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kUDDfMckAfjBAxdn8UbsV0PI1LaLGtDpMC0izbCsEyw=;
        b=i1ONmRtUf/TtefP9k23nt4BwXWoNKYRoR+3X0AmSBk2Ku02scjrWyiFxNM81yzRvu0
         FuuYZxbkemYR3RRA4tVcjo6mtbX0Wtk5WxNaG3MAHMOXkrdMCsnaptdfIaGxyl+nb13l
         RPUIMxRCvEGVZ62ZFjV/YEd5i103dfaFenra/WNZpMlXR0g7Dxxl3qlKVpP00NPgRiE9
         T9PWh92Cx5+3BCOslzDiWclzzYhdAz8zlI+7OX7zxozBaeg7q4Us+0yAiiYzqWJtJnGI
         ZqD+t4RHSYyW6pFoi00klEVv/RkTSo7gF9a0vG/ujlCODZxZaBx3l5aiEjnRe2GqAQmG
         YwEA==
X-Gm-Message-State: AOJu0YysBgxT4UDiT+tWXdqIdk6Uop9CaxZdMf3zwBDIMH3NTv+G4x59
        jGYwlcn74OviAzUFzyjYb8Y/JQ==
X-Google-Smtp-Source: AGHT+IHHQks1xGIxY16uCjwppAfUaLvnxxPfEhYUrLLX0rUNO4P/6kbFaMYJqOrLlPhWdG/DG/E4ew==
X-Received: by 2002:a05:6512:224e:b0:4fd:c84f:30c9 with SMTP id i14-20020a056512224e00b004fdc84f30c9mr24645234lfu.47.1693329049106;
        Tue, 29 Aug 2023 10:10:49 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id q4-20020a170906144400b00992eabc0ad8sm6136008ejc.42.2023.08.29.10.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 10:10:48 -0700 (PDT)
Message-ID: <ab0d99ca-54b9-2535-a783-967a3b2443bf@linaro.org>
Date:   Tue, 29 Aug 2023 19:10:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: adc: adding MCP3564 ADC
Content-Language: en-US
To:     marius.cristea@microchip.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230829154133.40716-1-marius.cristea@microchip.com>
 <20230829154133.40716-2-marius.cristea@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230829154133.40716-2-marius.cristea@microchip.com>
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

On 29/08/2023 17:41, marius.cristea@microchip.com wrote:
> From: Marius Cristea <marius.cristea@microchip.com>
> 
> This is the device tree schema for iio driver for
> Microchip family of 153.6 ksps, Low-Noise 16/24-Bit
> Delta-Sigma ADCs with an SPI interface (Microchip's
> MCP3461, MCP3462, MCP3464, MCP3461R, MCP3462R,
> MCP3464R, MCP3561, MCP3562, MCP3564, MCP3561R,
> MCP3562R and MCP3564R analog to digital converters).
> 
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> ---
>  .../bindings/iio/adc/microchip,mcp3564.yaml   | 205 ++++++++++++++++++

What changed? Cover letter says nothing about binding, so this patch
must say. Especially that you decided to ignore review.

Best regards,
Krzysztof

