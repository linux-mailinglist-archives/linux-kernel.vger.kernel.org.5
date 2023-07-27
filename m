Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014BF764731
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjG0GtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjG0GtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:49:02 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6CA2698
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:49:00 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51e2a6a3768so760550a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690440539; x=1691045339;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c3X8Zj4OP70OiqAhYnmxGDR9inGCFFjwz8hO6iVPB9c=;
        b=YxC4YDI+Y31qmYG5osPjgudcxDzKIfFIlK0DZRrp54Peo8y6rVsb+LWS6tpf+eS7fl
         +oHJ/p/utFkIJoczkcJGZamK4aPLUBbro0OL9Zuy7jzrwDP7H6aKS++4R/QthKJ1qdfe
         u9y5TYVvaUhSSQemkMPlI/hOFEgd5m+4IVpSRi3hT62sTkk+Vqsg1PDUTZIhmDl03xvB
         3dS65AdFrL1d1XQCw2xHSrr1t1Pb7vAF4rfyqFmADmCgDp5Sg07OkIOkqDm32HWcef4l
         Xtxwk1LRDZSwFzm2z5UCYL2Ft7+cr5drXXjBR7XasFYirwjLzor+Jke8ABRsSUjwcFfm
         LkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690440539; x=1691045339;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c3X8Zj4OP70OiqAhYnmxGDR9inGCFFjwz8hO6iVPB9c=;
        b=lQIAkwC/TBzW/JxJi8fjCi49oecparaUA12Gi2LUKNvIsSTce6+2RKgk7U7h282qPj
         UN5DpdgKw89iq9b6zIdfUOcx9mYlEugvByVi3FqKXayS4+iAArcwRkDU+nVnsvMG5oN8
         8nyO3LA4OacUiTIbtFh+Nz0ops3uU/MyQIne8LPcdatMCzOn3ZxjEJuIKft3ELvPznz5
         62BdM4yJ6TNNDJ4/okDW+Vn9/HUVGa6NMlYwdEs6hNKWkv/L7MT/WRw0m9iqCk+N34YD
         H3rxj+iQXLKADJJGS1uUDb52R9s1+Tkeag9qY8GIKD5AZdrQ1XwAhZIEnlgmDrt2KiVK
         uzfA==
X-Gm-Message-State: ABy/qLZL1xBaqoasrgHkoL0Z1V7TFkvZkLYldP9NseozY/Qc6c8MmVP7
        fsLjuwzNy1sGMz4fcTLzlX49sQ==
X-Google-Smtp-Source: APBJJlF7LoqmSv1+Kkydpo8uSWljyUepJpwxz2Cw713ZEV3Gf/tzcJlwLjDc1tJeLlS6Qd/HmUEQpA==
X-Received: by 2002:a17:906:5385:b0:992:a0c7:8d2a with SMTP id g5-20020a170906538500b00992a0c78d2amr976108ejo.54.1690440539233;
        Wed, 26 Jul 2023 23:48:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id e6-20020a1709067e0600b0099315454e76sm375402ejr.211.2023.07.26.23.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 23:48:58 -0700 (PDT)
Message-ID: <c9062d5c-b536-f89c-b380-8a0c9b858526@linaro.org>
Date:   Thu, 27 Jul 2023 08:48:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: aspeed: add Facebook Yosemite V4
 board
Content-Language: en-US
To:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230727033926.1904529-1-Delphine_CC_Chiu@wiwynn.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230727033926.1904529-1-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2023 05:39, Delphine CC Chiu wrote:
> Document the new compatibles used on Facebook Yosemite V4.
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)

I got the same patch four times...

Best regards,
Krzysztof

