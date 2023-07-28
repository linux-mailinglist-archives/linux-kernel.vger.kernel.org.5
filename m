Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77B6766D79
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbjG1Mmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjG1Mmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:42:36 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5071530DC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:42:28 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bed101b70so99281966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690548146; x=1691152946;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+KbO4xdPKJxm7Y0Oug/f+rZlfVccGAPsaII8ga9t1IE=;
        b=vjrwpTRqUy2wlGKrIoJwZG5PcfakgQE7OkxTehJXyQnMzMuH/KomDE7HxoYSO+LJ7S
         /bCYtJd93SaBwor/cOS/JoPjJZSyG3HKi4j50VpTaxRJgdZc5GZnsvmjDhLccOBqRDpy
         hjrImt0C0jpF4a7eC84I2gOvU/sDq7bF+RNekBFCzdC6ONkHJc2LqyEsL00XFdazJMWT
         1Qb/1Y6yRiJm2AYyCEX7TAbDuJ29g3/U5vS0wS+CzWXvLGYdUWOaCjozY6sRoMSPMawo
         SwRlnNQPcwf8zXxoSijQOjV0eWlfJpRkeineEfa0zvfq5yHwOGxa9TeBj430cw53vP+P
         Ifzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690548146; x=1691152946;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+KbO4xdPKJxm7Y0Oug/f+rZlfVccGAPsaII8ga9t1IE=;
        b=jT2zbo8qxVobcMyesUwjlJRvroxmbs8SlMv1yUwrMK/MKrWa3UWsiM5HUHp77/vHSn
         yl/QYjWjZ0mVYKZo+3ubgVhq4pe7MHvfBHLefN/Kkv14u9uvrFE+A6HPqLV+vX/aXuAN
         I+SUIJoiUDT09UV72WwVmBuVJSL5Q/G+CCKhzv02BF6RQ9APdF/yb8wQQf17i0UHFdhJ
         keecmN8fcs1ezbive1qzTqD0paGRsFsLm/6FZ7ytvi4FLUgQ75eC3LpKRT/tp33Ch2G9
         ghyYd8XpKkm5drmj6U/GfPlH19JDiBXaVx6A713h1kwXq1wfJ3nq94xDR9N3bbtMpao+
         K7wQ==
X-Gm-Message-State: ABy/qLbL28MGXyQUyb84bwKPXx6ll0URAs1YyPsuSTzP1sCf5S0cCsgj
        C/eZwMDLtTGIs7THQh055/FP2A==
X-Google-Smtp-Source: APBJJlEbH3li+eeUrEvnIvtZqxvXF5f76Uz3szFx86grPDRc1mLQ/Zl9p+vNHsqSRyk1MjkK6rxqLw==
X-Received: by 2002:a17:906:95:b0:99b:c7dc:b02 with SMTP id 21-20020a170906009500b0099bc7dc0b02mr2295644ejc.57.1690548146740;
        Fri, 28 Jul 2023 05:42:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id cw25-20020a170906c79900b0098d2d219649sm2041956ejb.174.2023.07.28.05.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 05:42:26 -0700 (PDT)
Message-ID: <c28e3f10-0df5-ddd6-490e-7c644c71b861@linaro.org>
Date:   Fri, 28 Jul 2023 14:42:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 19/50] dt-bindings: sdhci-of-at91: add
 microchip,sam9x7-sdhci
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230728102616.266235-1-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728102616.266235-1-varshini.rajendran@microchip.com>
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

On 28/07/2023 12:26, Varshini Rajendran wrote:
> Add microchip,sam9x7-sdhci to DT bindings documentation.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-atmel.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

