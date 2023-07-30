Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035D4768711
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 20:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjG3SJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 14:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjG3SJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 14:09:00 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694091FDC
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 11:08:40 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bcf2de59cso600208566b.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 11:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690740518; x=1691345318;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rfPh0rQxcpXl603MOWrHPrRTfxrFlYqNDM8hmhIpN5I=;
        b=JCezjIrSBcfhqzNXY9YsythVWHzvD8ErnLuKBP6QBwscMfItqs+U0r2Yc7X3hFjL7i
         t1BN+Dcmj/ijSuSnvlAl/kr2iRJ7I1VICgLgwWB76duYYFQvudb/IPD5c8jGXAop5/Ub
         asQ+959WHRTScFop01Z5XWFwYRVWliJFjKVhGFVQF68LHCtYD2qOa5162XTrZEmLURoV
         vbdtqHFkTwMj1zccO7uqbKXbk5FzDGo+yvI7TaDIh8qvyVg2Ob9AWu73mMFwT3JD9krL
         4r1tq5yjzi8PRMOifyXyyc3fe7+GyYEp+2y+aIW1Mji0uub1FfKHONlVX+TAWel/Ov7R
         u+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690740518; x=1691345318;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rfPh0rQxcpXl603MOWrHPrRTfxrFlYqNDM8hmhIpN5I=;
        b=Eaji37AYmK/XkkovlkN4yK9oNTxlivwL0ltKCNsBkwpwJzqZrlzbFEESxAbfz1wskT
         GCGcisF8l4XxECA/x0L85f11B2wDa5qb9gnQ+VVnMqZfLnCzfQhged/u4UB6oKWANS4c
         DjfecYJNk3Ue9unP2EtFKDEV5M3xEFRFUAKdjDMkqO+T6IPFP/OYCZuNyUHqDJpnLBD0
         +7kw1xOyaau2y14Ad31I5oPzCfAtpWgtsetfddaM97B+SWz1C/g8ekrxcag2xWLQkNYQ
         SFrdIgmOwGzgUxbd71suWsY7aBUoJAFxmZblt4pOo2IeRVOal7THvy54uGDXBo4l6zH+
         EbTA==
X-Gm-Message-State: ABy/qLaL0G5QEZ3+z2y6dCOzwlBaWwFEhX/JKwixIQD9BCWVXCuvV0VL
        yw+2JZeVzyzHlbfLpZjV7Wx6Qg==
X-Google-Smtp-Source: APBJJlHxY/MaR0paiPXpydEunRqNiPLIODON0sih2jzqQjy0Kg/zC761MpbUD5tSRmqd1DnrIEd86A==
X-Received: by 2002:a17:906:3294:b0:99b:cd2a:641 with SMTP id 20-20020a170906329400b0099bcd2a0641mr5097665ejw.23.1690740518078;
        Sun, 30 Jul 2023 11:08:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id f23-20020a170906495700b0098748422178sm4951807ejt.56.2023.07.30.11.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 11:08:37 -0700 (PDT)
Message-ID: <1078561c-d9f9-0678-0417-412a0beda6e3@linaro.org>
Date:   Sun, 30 Jul 2023 20:08:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v2 1/3] dt-bindings: power: supply: maxim,max17040: update
 properties
Content-Language: en-US
To:     Svyatoslav Ryhel <clamor95@gmail.com>,
        Iskren Chernev <me@iskren.info>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230730172648.71578-1-clamor95@gmail.com>
 <20230730172648.71578-2-clamor95@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230730172648.71578-2-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2023 19:26, Svyatoslav Ryhel wrote:
> Add status and temperature properties.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/power/supply/maxim,max17040.yaml | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
> index 2627cd3eed83..4bccf25a111c 100644
> --- a/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
> @@ -55,6 +55,14 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  io-channels:
> +    items:
> +      - description: battery temperature
> +
> +  io-channel-names:
> +    items:
> +      - const: temp
> +
>    wakeup-source:
>      type: boolean
>      description: |
> @@ -95,3 +103,26 @@ examples:
>          wakeup-source;
>        };
>      };
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c0 {

Just i2c

With above:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

