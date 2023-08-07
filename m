Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B4E771C79
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 10:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjHGIlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 04:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjHGIlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:41:37 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371F519BD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 01:41:33 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99c0290f0a8so551148466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 01:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691397691; x=1692002491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MUj1t86IIglhpvqbCl+JW1p0KP0RIykK8lcH5sYs7WE=;
        b=uHaH2GdpgclUraDoPzTb4pV1nYPdWxfiaaGHpD8ip5S2erNhUbkFpcvX3tLQPwuJiE
         P4w4rynffTyS+jg2bYa24bS/McH0qUG3jz9KDhRnz2F5jH91vq9rmtL+Tk9O0eapCLd4
         L0Vk1ld06IK76WOh6X1ctPA1RF6HLNgNr+HQfD9oEfnOXkOc9mlLixdgJELnWCCVD3g8
         PN9Xmpj1Uys9VXyFqYLJdaWgPGTMGER4GOkL4uPDNdWW+1C0cELVq4G6zwyRCdF37L+u
         DYyG+mNCr5YKoucMXI07rg+RsfSmjKMQBuunc7mfZWG7kx4F7ULRa4mLEP9cRuGIGiVv
         qYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691397691; x=1692002491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MUj1t86IIglhpvqbCl+JW1p0KP0RIykK8lcH5sYs7WE=;
        b=OvFP3YPrltwxFSuHEZ0GfN+yoCGmRHcjtKymrynvFEln5wAVRLng4XjF49F9pecZK7
         HuxYzzf3YpGcEwwfG0Utr3pjRM6XZHZ0hEZnXqmJP2Jq0FXgv/XyZto45DC7hQXtnPhb
         Aa1hdvJb9DTNg4E2JND9F16P3mVJsCry74pfyeYwFISaR8BHZpgV1VYH4r0y5mSXKKBp
         maaNfkeNgmCKU7JlqGBUSkBD8o4+V2qV6onvo7OoGuT5i77cA5r9xVpBTuW+hu2Yt8n7
         LA2EfoZ8GoAXSDOg+raKmZ/SsJIhunv/miZl53wjk+vfzk5IGIpSbiqikqeFySCpvPLa
         riRg==
X-Gm-Message-State: AOJu0YxdrWzjlx0QHuANIqGrzIhXrc0piHUoeCB7ACkPTNb9VZ/w31fh
        rI7XPJ/Ji0CqdysfJ5JIKOTQLg==
X-Google-Smtp-Source: AGHT+IHNAZnHDcoJmsBlY3w8kuDDoRD76fbpds8ZCkkKxNciisv0f5lhiixQKkV5SSVUmlWzXnq+Tg==
X-Received: by 2002:a17:907:2e0d:b0:99c:a07f:8c41 with SMTP id ig13-20020a1709072e0d00b0099ca07f8c41mr6204519ejc.28.1691397691504;
        Mon, 07 Aug 2023 01:41:31 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id v2-20020a1709063bc200b009890e402a6bsm4885380ejf.221.2023.08.07.01.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 01:41:31 -0700 (PDT)
Message-ID: <6caa3739-fb5a-28e5-38cc-9b22830775e0@linaro.org>
Date:   Mon, 7 Aug 2023 10:41:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RESEND PATCH v3 3/4] dt-bindings: clock: rk3588: export
 PCLK_VO1GRF clk id
Content-Language: en-US
To:     Elaine Zhang <zhangqing@rock-chips.com>, mturquette@baylibre.com,
        sboyd@kernel.org, kever.yang@rock-chips.com, heiko@sntech.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangtao@rock-chips.com
References: <20230807065942.9937-1-zhangqing@rock-chips.com>
 <20230807065942.9937-4-zhangqing@rock-chips.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230807065942.9937-4-zhangqing@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2023 08:59, Elaine Zhang wrote:
> add PCLK_VO1GRF clk id.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  include/dt-bindings/clock/rockchip,rk3588-cru.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Consider dropping CLK_NR_CLKS

Best regards,
Krzysztof

