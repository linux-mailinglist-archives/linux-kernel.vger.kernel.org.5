Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3D1771C72
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 10:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjHGIlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 04:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjHGIlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:41:15 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6CC1724
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 01:41:13 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5222c5d71b8so5913736a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 01:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691397672; x=1692002472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FiBr4qX4MDbW0bMa0nAPFtANFmRzjD74lfH4gfwbvd0=;
        b=iWuFcNfomzzwUernqbjgnHDmBrxPuIdUyl+xhLNUfhmAumSwMafnFExzEChBJ+4S/s
         u4Fo6hpOHrgOqGV06jmqPnZtzU9BhNo/+5YzUOI+2hRYuG7eiw+HuJd6CsVpVZidHgNI
         cozJDgPKoDh9UFbmr53PofIQRClu2SWCr3ZhjbKVKE3wwo9/usoXH5N6CpLxb5njgJbs
         ZHZKcpMMlVDkswUaVLAIlfDLcRIdNJBtIDOYBma6dxkuwf0u9bI0xesAk9VgZY5BaFNb
         +9LNUl8PqK1KxO9HLlEvUcpkaZcNd2dBtGqK3yPxklaZGoDwvw0mm1qY35bJAZE5Sqbs
         b4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691397672; x=1692002472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FiBr4qX4MDbW0bMa0nAPFtANFmRzjD74lfH4gfwbvd0=;
        b=N4jDzH8ppFrQ97CZEvkokTZFRwcIh8a5SbNxOWJwfS/g5TkAXMqEGjdNLr+DKnCDrJ
         cpNXWMRXyUjBeokqjrVeI995WkUBjfGA8IzWiaeme0Vik3PzA7Xj/O71L30I4/BKuFMa
         U/ldOUXQPrCuhigs3qH8D0JG7NPIq/clrePYEpAvq3nHTNXIfy+/rUMHjH1BoQdqOC2P
         MtVByG4qqbllXCCgBLfliR5yBUtyQaOVsbO7E0ZGJJdJwTQblGGZ9iiXeAVfQCOcjKru
         +FWcfWIi1n/SX3akwLoB8/3gKd/u0qqg7SO2h5YiRdGa6orHv/jENGoc1I88WDcQkndi
         Mhew==
X-Gm-Message-State: AOJu0YwvatglSxEOCZ4z3txRl1btKeEv+7+HzikYLHwcgPoRw6EhqvtZ
        9FzVKkjmRGU84goml1Ol85VfEQ==
X-Google-Smtp-Source: AGHT+IE9kWCdDPfh1ysGqzXA+sR8LgRcYRK5cY280j1rlxyyCD7yEz8BYDWSnuErnViUGY4Xfb5luw==
X-Received: by 2002:a05:6402:6c1:b0:523:2da2:1ec4 with SMTP id n1-20020a05640206c100b005232da21ec4mr4356059edy.11.1691397672230;
        Mon, 07 Aug 2023 01:41:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id b4-20020aa7dc04000000b005224f840130sm4794190edu.60.2023.08.07.01.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 01:41:11 -0700 (PDT)
Message-ID: <f3c68353-720b-bacb-a4c4-fdce81fa4d13@linaro.org>
Date:   Mon, 7 Aug 2023 10:41:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RESEND PATCH v3 3/4] dt-bindings: clock: rk3588: export
 PCLK_VO1GRF clk id
To:     Conor Dooley <conor@kernel.org>,
        Elaine Zhang <zhangqing@rock-chips.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        kever.yang@rock-chips.com, heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangtao@rock-chips.com
References: <20230804025101.28438-1-zhangqing@rock-chips.com>
 <20230804-colonial-balsamic-c97491ebec12@spud>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230804-colonial-balsamic-c97491ebec12@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2023 17:38, Conor Dooley wrote:
> On Fri, Aug 04, 2023 at 10:51:01AM +0800, Elaine Zhang wrote:
>> add PCLK_VO1GRF clk id.
>>
>> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
>> ---
>>  include/dt-bindings/clock/rockchip,rk3588-cru.h | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/dt-bindings/clock/rockchip,rk3588-cru.h b/include/dt-bindings/clock/rockchip,rk3588-cru.h
>> index b5616bca7b44..864a321ab362 100644
>> --- a/include/dt-bindings/clock/rockchip,rk3588-cru.h
>> +++ b/include/dt-bindings/clock/rockchip,rk3588-cru.h
>> @@ -733,8 +733,9 @@
>>  #define ACLK_AV1_PRE			718
>>  #define PCLK_AV1_PRE			719
>>  #define HCLK_SDIO_PRE			720
>> +#define PCLK_VO1GRF			721
>>  
>> -#define CLK_NR_CLKS			(HCLK_SDIO_PRE + 1)
>> +#define CLK_NR_CLKS			(PCLK_VO1GRF + 1)
> 
> I only got this patch & not the rest of the series, so no idea what's
> going in those patches, but since CLK_NR_CLKS was put in a dt-binding
> header, is that value not now part of the ABI?

Technically yes, practically does not matter because no one should use
it. More bindings make the same mistakes, so it could be just dropped.

Best regards,
Krzysztof

