Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE87766BF3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbjG1LmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbjG1LmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:42:14 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0E03AA8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:42:13 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51ff0e3d8c1so2626073a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690544532; x=1691149332;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mR0vubutJvZiyfIcQHfdlTgaJxVlWxEWJ1FEfJyqDiM=;
        b=jSR68sE2qwl0WC8NCUe6EYJNJWYxH7Zppm8u9dPiEOe3sKfaCzxfAZko7u1t96EQa1
         c4sIS7plaeGT4KyloIPJiPIwJFjwlodDkZWonDnbHlB0ny3oVZkp3g5bHd1Cjbv5U4Tt
         DZ+4BOM+RKb7Q7yv4+QqW8mUbUnI68afn7aW6w5qXU66dqVf8htJVN79Xe7xQTAeUGgB
         lgSBfA8G2pRx9bjqoymdNhTzXrq+IynEz7wSe14re09aHImhksT4dzO/uBR41UOu+wjr
         y7MKMVyMt8/Px1ZVZ4eX9pDXpG/V1LFO7qszHmuDbSRkS+afz9PfyYKSJ/TvdgDQCGMu
         rzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690544532; x=1691149332;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mR0vubutJvZiyfIcQHfdlTgaJxVlWxEWJ1FEfJyqDiM=;
        b=Mlx64MgSZRTJeU19astF6ZKwACAPW8q40NiEaIcMt1DBzjCAxw+Gum8rNg0Ua7/xle
         q68T63OBH5teXouIbZn4CJcOdJz73rjbUUHUfzt3YmkIggR8CHBcC8efZ4nTQusUfJjZ
         nQ8Kzvm68IPXtKvNyB24shHO9jNdDqVL86egHQisSl5mGaaPlhF2v6du5qzjhAcaPkJT
         Uz2KVJuu/x2FH+FT7eOWm0aSDcUfjCu1nQrYrri+fr1R8mgroJdruxMSYOQ04fiS2bQ9
         X+dVCdoD1vuU6tfmRL54T+Q6J8sJov8bGdp496D5qdA2Ks88zJCjL8j+1sU4hpQKwXXQ
         devg==
X-Gm-Message-State: ABy/qLZdZn1E+UGLqkezFC4I6w9KeUj7zbobqlrCjeL9K4/7Kj9cbaUn
        q7/bdGqAnGKDhki0z93kFrOwrg==
X-Google-Smtp-Source: APBJJlGmOkKumVsZNMRhfQNbATj7U2nqkAcsWB3JJIE6wwtiZnOHT9kLfbPPcVVdjkU/bxEFuWvOJA==
X-Received: by 2002:a17:906:5354:b0:992:4d30:dc4a with SMTP id j20-20020a170906535400b009924d30dc4amr1514766ejo.74.1690544532532;
        Fri, 28 Jul 2023 04:42:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id b14-20020a1709062b4e00b00992acab8c45sm1993668ejg.12.2023.07.28.04.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 04:42:12 -0700 (PDT)
Message-ID: <d96477cb-63c9-1a2c-ae7d-8ab688e93f85@linaro.org>
Date:   Fri, 28 Jul 2023 13:42:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 07/50] dt-bindings: power: reset: atmel,sama5d2-shdwc:
 add sam9x7
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        claudiu.beznea@microchip.com, sre@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230728102407.265617-1-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728102407.265617-1-varshini.rajendran@microchip.com>
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

On 28/07/2023 12:24, Varshini Rajendran wrote:
> Add shutdown controller DT bindings.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  .../devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml   | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

