Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896BC766D7A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236667AbjG1Mmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236343AbjG1Mmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:42:40 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C573A96
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:42:35 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-98e011f45ffso281131866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690548154; x=1691152954;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4/n7cm36/8yWDoKasp6hGU9B6mkk1aGAdqGxIqpZEnY=;
        b=ed6jiUJoPqmsqmG7Bqa2r5KSCdJ7pe9J8g7h4ylgzGcegewSJ+VDab2gSJWjlxUrrO
         u97uw1IQBglfBoxHOBJqYnX4CfWZNbMd0SqLDqq3uUwlLoxD2eakNZ/7CkGUauF8Zmak
         i1Z6f7cqjKlq4nnknGqPP2XwEVVliIu3+xgx0T/GHeOQuSDKqRutTJ1VOo/P/e8y9J+Z
         SEcfcQzktw/vaKYRUWBP8xXfozJAa22MmGqwVObYIzHM2uSERGbtOgbzN7KCFXnhvEZ4
         WgSmJ467Yr/VBm2SRZlf+SpeAMFnxAbXl+v/UdfIFe9DRSZkUiEXT3RsnqRzOyhfs/ia
         52wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690548154; x=1691152954;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4/n7cm36/8yWDoKasp6hGU9B6mkk1aGAdqGxIqpZEnY=;
        b=X4ZeDkAAOR6+l3C9KUu+1kq19psMEgAZxIE8rf66rQyJsINAGBtp8/U2cSjUYTk3ft
         qwW2+DTxqjXZ3LSa8s3qTdcMq0/AmXcnHnb2hrw4g4jklBd4rVrZBunnYutZhqJ9CzLV
         bn86hqPsUVVBtwJhdxYz/+7ZKPdKLYG0tRCTchShXF/HxWw81+J0iSAesg0pAtIhJRwk
         KwY1P9hmVrp0FVXwuIKyhZ/lbhY51AGgA7DnCdVzuMP9tkLmZdaCxRumefwBS1JuUF+e
         HSde59gEhb4EXSvkUWUqfY2tIxC59MzwFvHhhoLoCCmENXIdmL8HBg06HDGxmSQiv6wR
         G85A==
X-Gm-Message-State: ABy/qLbVvZkVfUDsMauqy54/Sp0orIeGHnaoI6rBk2Z1pTU6WilPLqPR
        3Yp8odvSCvWLsBhNWJSPKTRk7w==
X-Google-Smtp-Source: APBJJlEZH/0is+8y1HyQY1lIeG9Yt8Xja4a00Mqlmm5oRRuVPRkp0uJyDLZS+43g8qmr0zLrGqyqlA==
X-Received: by 2002:a17:906:2257:b0:989:450:e585 with SMTP id 23-20020a170906225700b009890450e585mr1947892ejr.45.1690548154377;
        Fri, 28 Jul 2023 05:42:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id t25-20020a1709066bd900b0098e2eaec395sm2020526ejs.130.2023.07.28.05.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 05:42:33 -0700 (PDT)
Message-ID: <8661f940-6c36-d654-664d-35156dcaffe4@linaro.org>
Date:   Fri, 28 Jul 2023 14:42:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 18/50] dt-bindings: atmel-ssc: add microchip,sam9x7-ssc
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        claudiu.beznea@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230728102607.266187-1-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728102607.266187-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 12:26, Varshini Rajendran wrote:
> Add microchip,sam9x7-ssc to DT bindings documentation.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  Documentation/devicetree/bindings/misc/atmel-ssc.txt | 1 +


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

