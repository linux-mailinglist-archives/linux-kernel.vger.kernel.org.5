Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C820766C1B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbjG1Lwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236048AbjG1Lwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:52:34 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6343AB4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:52:33 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-98e011f45ffso274667566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690545152; x=1691149952;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iiua700OASvsqx+4N6h+76MQoIGha7eYc6GZhNCHoSg=;
        b=zP6ATR3sH7pclpk8xF0g/e7n9NSYW+DyV1gKVzZ2V3cTxBzlPpZRL8DQR/JRF0/lU1
         Niw9y4ADhCkzQqqQINcCHKXTmafHkV6sJcG5i8DdYVyjteUEIUjs4O2Dkv0QBvl3aa7h
         eCGei7kTQ9ri/Ip5bfqT9UWnpBRwZUP900ACSNTD9CoMORZF/GrF/Sn8eUr44L+Ij/xg
         3221NlFXn7HDv/N0CsTp4WrKj/LAWXh2QWfMd7U1dBl0yGHRA6iQAaOA1HyfR6QQRrRz
         +xkFQJK76bUPrQ3k2fRfckKQH44Rf4XGQoeUQ90bubiN+YxiUTQxZNDCrJ4EpBJWs2iv
         vF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690545152; x=1691149952;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iiua700OASvsqx+4N6h+76MQoIGha7eYc6GZhNCHoSg=;
        b=ZW4UZLE40Z3oDKiTBfryn7fBx0dYJ/F+10H5KjB5o2YD+xYIT4O0t8ljnejsQmgPop
         yDQjn1F2cVAEnPYhaddc9z8VlVy4XXI2ArNpp6uKMgZDH3z0R+enIj9L73gNVryh6yS6
         IGV2b56D7t+OzsiMJUQB2Xe9vd5da2F/98i9QSoEi8MUSlmPya5QKYz+VSPs12Xg03bf
         E8bzK8vhuNCySYF69IImA45dBAMy/u2Vk+TToBa4nBpoG/+tLgGj/gMIkLffvCaJdv82
         QT1lc7qlpwlRVwVB0djp8+4bjxokBqlDxMkrXuuYQ8PpuDOyIHLqmJRBe9XRPkI5k52/
         uuvg==
X-Gm-Message-State: ABy/qLYD3W6Yy4COQQKJTvziEfSOJegTZY5L9mFq8+7i0DnjSJAZhizP
        UKeGF2tx7qxU336OXJYg0/1Ntg==
X-Google-Smtp-Source: APBJJlHNFxtHHADT5A5mi91qIiLOJkthz65ykm4RsB2Iw1LptVsPGrHt6ovpSdG+WRxjW7mSwhw02g==
X-Received: by 2002:a17:907:781a:b0:993:ea6b:edf6 with SMTP id la26-20020a170907781a00b00993ea6bedf6mr1865674ejc.0.1690545152266;
        Fri, 28 Jul 2023 04:52:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id t7-20020a1709063e4700b0098d15d170a0sm1960002eji.202.2023.07.28.04.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 04:52:31 -0700 (PDT)
Message-ID: <234b1c9e-728b-3c24-a03d-c068a1d75b52@linaro.org>
Date:   Fri, 28 Jul 2023 13:52:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 22/50] dt-bindings: rng: atmel,at91-trng: add sam9x7
 TRNG
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        olivia@selenic.com, herbert@gondor.apana.org.au,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230728102701.266408-1-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728102701.266408-1-varshini.rajendran@microchip.com>
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

On 28/07/2023 12:27, Varshini Rajendran wrote:
> Add compatbile for Microchip sam9x7 TRNG.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

