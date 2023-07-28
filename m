Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4B6766D84
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236696AbjG1MnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236690AbjG1MnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:43:15 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B16E78
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:43:09 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-986d8332f50so288306566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690548188; x=1691152988;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z+iuqBx3ekrCVidOhllN+DMVt0RJH/HxgzRnhtmgkRk=;
        b=jhmZ6nb9rdRM74KE1d31aXbj9qY8QbNw1AW+onH8CMQiI2u5oxP8VsyI4wwSTzGLe6
         R3GDJPe/khDxiPOu1MhaISrik2ADMdy5KvuoCmbNJn2h4BxPQxVEiVu4LmMlB9hw4QXw
         vsUXhFtiLD2GdDYVpz5Ej2YwGhCvwzTxBs3c4oyaXSM2nnJFaw1xPEms+R1xvOz3QFFt
         y1vjypb5JkUfgjbMNh+MiXQ8qbI8r9+nv3jCm+O+QxKCwn2BXPq0nHfX9Z/WnB00IW/9
         xlNgwBsJZ9Z/Dc/LkrCpi8filvPTGk/qL5NZFzbOTCauPURkqSXUw1fiSpUdSYRmJIyr
         GYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690548188; x=1691152988;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+iuqBx3ekrCVidOhllN+DMVt0RJH/HxgzRnhtmgkRk=;
        b=lFfzCYPduDH7UymwJI2pi2JL1foWBCBx7rKY4ACD446vCwRnyulWSWBd4+BJkRFuOJ
         Uy/caiNwKmL8TvJALov5tRFkxsBlzjzjveFJjynaHVy/guqGN8Wo5OyTLJ/q5FTYZFLw
         r0CmGQNs8oZt/C5YTZVkIxoxIhv6tkBQLBI+bgB21759pwoXrRLOwLy8mYraBFqddYdu
         +9I8uEDyjsKeADld48p3hezvcg2rryv2rbkVH+CUPDeAVj6FtwHuoz7bjh0LHhXr4+LZ
         hmBC0m5wVWE725Ekc4AYgzzqPmeH0lH1bcn3TFIQGwnQGA47sy2MwrUx4Q8qDwqWmm+7
         z74Q==
X-Gm-Message-State: ABy/qLbP5+9ukBzNgU/1j18VyG96euMx+Rn9bI8/j9FSvC+P4nPYJTbt
        1HBTMw8OpIbp75Fxz4TBjqqrxA==
X-Google-Smtp-Source: APBJJlFTIFM47y2zWx3yLO6+5yOItfReFp8Cvo1mAkBhk2WY4PAX7iOKwaIW3APeJuYx6lE7g+AJng==
X-Received: by 2002:a17:906:101e:b0:987:47b3:6e34 with SMTP id 30-20020a170906101e00b0098747b36e34mr1730208ejm.67.1690548188345;
        Fri, 28 Jul 2023 05:43:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id o13-20020a1709061b0d00b0099bcb44493fsm2026617ejg.147.2023.07.28.05.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 05:43:07 -0700 (PDT)
Message-ID: <ae317334-e3f0-f6b7-0477-c10cf10ca2c7@linaro.org>
Date:   Fri, 28 Jul 2023 14:43:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 12/50] dt-bindings: dmaengine: at_xdmac: add compatible
 with microchip,sam9x7
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230728102451.265869-1-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728102451.265869-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 12:24, Varshini Rajendran wrote:
> Add compatible for sam9x7.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  Documentation/devicetree/bindings/dma/atmel-xdma.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

