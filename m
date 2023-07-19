Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8097759407
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjGSLRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGSLRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:17:46 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F4B18D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 04:17:43 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fba86f069bso11110971e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 04:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689765462; x=1692357462;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dA4XBjNreRbs/RKP90hsuoW35QaS3sIYpUWqA3D9MVo=;
        b=eib+6ZdSavk8Cc7sMu9UiLLoRzeurRV7U17SqJAdIFseBdo83QH88dnHOpILFO0Cln
         0IsGbyvcRl9w1gqFMOXu6ygsn+ZNxcwzWfrTXb+x6bQwtDHOXXRdkQtSBFhgMsJ5YGLv
         m6bv7v664SZsFyXtW9kOLlL2QlyBrdsLjGHQmCoEvj4vKzL3HnMDW3G0SVkadJlWUF1t
         EoJBekxklR+oaT/Tayym1DlLl93ebF2f1gs0w3nVaL3QzdoKjUiG5ooM38p36cBDrDJ1
         bgdBpngvJemNnogm2kWA1g2JyfP+Ni+xP1LyxHVRNFhGNoJeDS6JKqhyJmBAkHEy/gi4
         gGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689765462; x=1692357462;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dA4XBjNreRbs/RKP90hsuoW35QaS3sIYpUWqA3D9MVo=;
        b=UWDOsLD9cEnMuUaB3PGk0PpoUGQ/bDanOBLG1S69rdKQLLqpAUNK3u1P9DszGGtqBS
         0iQ6Zx7XAYp8rJnT+OdU2MO5FHBxNFP0uCSC1sqwIxhh6qUIxJECYteu4W4NGJ0bd5n4
         TxOXGhWuP4KYdXsFmvdCH38TqCOj3XDICbIUA0hctO/VyCb6QpXxPJH1jgi1+BDRA+1i
         g3tZc6ikOjaruF7JK//jDWFM5sjVS9mwSgi8Q1BUFpeeKCo2x+UUkKZ7YSq9VFXOLJXu
         ps9ltPfZ9JSYT2ON1hmweSAJjXfg172ZmRo1ht6yqEUo5t1U29PkXFMnp8lTBOZvubqI
         7MUg==
X-Gm-Message-State: ABy/qLYgsuwoy+84wc3HnkRJT8yFQqnqh+9jQh80GbA3vJR6gRXABJor
        rrcp97npvOoOXx4DJdQW6wkAZw==
X-Google-Smtp-Source: APBJJlEfuMb3x/pT172dL5k+uZlxwymyIEwasIcdDQtVo1m66C7A/ws6DIO7Zn/FYWiF+K/45DMeag==
X-Received: by 2002:a05:6512:2394:b0:4f6:2b51:2f74 with SMTP id c20-20020a056512239400b004f62b512f74mr2003719lfv.52.1689765461798;
        Wed, 19 Jul 2023 04:17:41 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id r21-20020aa7cb95000000b0051e28d315a2sm2570977edt.78.2023.07.19.04.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 04:17:41 -0700 (PDT)
Message-ID: <7c60b8b5-ce8b-c911-043f-f916430bacc9@linaro.org>
Date:   Wed, 19 Jul 2023 13:17:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,sa8775p-tlmm: add gpio
 function constant
Content-Language: en-US
To:     Shazad Hussain <quic_shazhuss@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     bartosz.golaszewski@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230719110344.19983-1-quic_shazhuss@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230719110344.19983-1-quic_shazhuss@quicinc.com>
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

On 19/07/2023 13:03, Shazad Hussain wrote:
> Alternative function 'gpio' is not listed in the constants for pin
> configuration, so adding this constant to the list.
> 
> Fixes: 9a2aaee23c79 ("dt-bindings: pinctrl: describe sa8775p-tlmm")

Cc: <stable@vger.kernel.org>


> Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

