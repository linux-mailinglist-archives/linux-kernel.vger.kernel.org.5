Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4122178CA49
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237634AbjH2RJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237681AbjH2RIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:08:49 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2638DCD9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:08:43 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99c93638322so3835466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693328921; x=1693933721;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Y6xwhXZeIWCEXZ5vr7dzE9G7VScMJ9tEufwZ22ual4=;
        b=ozq42sOrus8s+QMO4NSh1vtz+nHirPwWGbxi5qYgBx+XhrDq2ALaEsNKHws7toBrFx
         jkqYdbMuQXHMTwRshBmPUbmwwQaox0aHmb82gBbDiOavYFrWjKb1l8tZGJTt45LKu6Kw
         lV0apf1CkpqTzW4D48zIfek/TFTo8yDqjlhUiVUXi7a8Jh50VSx4l0IWac0SViiFPceR
         ko6j+yPFyPQI9N+Cx/6AL5pV9le7Q5L5F8XvgBtg0XyZ13Zr0VRpOG8kmVMF4U8FW7Jk
         mRMPHpSawyd+HlFezW+LxUNzo0mwkpL5+sn0PPmEUudjEA82ATFRESR+XB4Wl1nvKhOr
         qebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693328921; x=1693933721;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Y6xwhXZeIWCEXZ5vr7dzE9G7VScMJ9tEufwZ22ual4=;
        b=Fg2rz++Pya+wy5aUEtONvHoohNYblZxMPg1hN9gOUCTLts2Wk1RPmUrb9oN+ByDa+i
         UCFJ+B8n5edfpcBv7n4wHnBNudrguY+c/UmmfqWXcXrPmFUqHItPG+sMeG5VoPSS4OJQ
         fJMoI64KdM76eIIdrYzP4GpxY8809qacfRDkXRZkJziB6YJPqvZ8wuFgm5l+pxUPuAnD
         Iq6aqQyxXk4scWirBh7yMIEciG4nQV63TEH+yOdoFGZkkIjGE0X2lqM+MP8PZuVQI5cm
         NUniAodeyK8PXUPCgzr3xbqA0qI/sb1dTTy7ySDGqKtDI2TDTvJGdhKPL4hi1DZ6Jf9v
         Rhlw==
X-Gm-Message-State: AOJu0YxaABBKOk/Rz92to9iDXLsLeH0kfcqnc396XUYCECqkHq9UNxAh
        UtQf8xK7ON8ZLNwye5H1rcE9qw==
X-Google-Smtp-Source: AGHT+IGR+OgfkxR/pvgIU4IfhbqLmZPUFloowFJ2WgFHwAD/wIDoUIxefynrgHh9HHoOQH0l6a8GqQ==
X-Received: by 2002:a17:907:9051:b0:9a2:474:4aa1 with SMTP id az17-20020a170907905100b009a204744aa1mr3352763ejc.10.1693328921676;
        Tue, 29 Aug 2023 10:08:41 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id x8-20020a170906710800b0099c971ba285sm6143766ejj.5.2023.08.29.10.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 10:08:41 -0700 (PDT)
Message-ID: <17e2413b-6d06-a113-e35b-30cc078a6e83@linaro.org>
Date:   Tue, 29 Aug 2023 19:08:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 4/9] dt-bindings: phy: qcom,uniphy: Add ipq5332 USB3 SS
 UNIPHY
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Praveenkumar I <quic_ipkumar@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@kernel.org, robert.marko@sartura.hr, robh+dt@kernel.org,
        geert+renesas@glider.be, peng.fan@nxp.com,
        konrad.dybcio@linaro.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, will@kernel.org,
        conor+dt@kernel.org, p.zabel@pengutronix.de,
        quic_varada@quicinc.com, vkoul@kernel.org, nfraprado@collabora.com,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, quic_wcheng@quicinc.com,
        rafal@milecki.pl, gregkh@linuxfoundation.org,
        luka.perkov@sartura.hr, andersson@kernel.org, arnd@arndb.de,
        linux-usb@vger.kernel.org, agross@kernel.org,
        catalin.marinas@arm.com
References: <20230829135818.2219438-1-quic_ipkumar@quicinc.com>
 <20230829135818.2219438-5-quic_ipkumar@quicinc.com>
 <169331975886.2142011.7345682428392154402.robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <169331975886.2142011.7345682428392154402.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 16:35, Rob Herring wrote:
> 
> On Tue, 29 Aug 2023 19:28:13 +0530, Praveenkumar I wrote:
>> Add ipq5332 USB3 SS UNIPHY support.
>>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> ---
>>  .../devicetree/bindings/phy/qcom,uniphy.yaml  | 117 +++++++++++++++++-
>>  1 file changed, 114 insertions(+), 3 deletions(-)
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> In file included from Documentation/devicetree/bindings/phy/qcom,uniphy.example.dts:45:
> ./scripts/dtc/include-prefixes/dt-bindings/clock/qcom,ipq5332-gcc.h:19: warning: "GCC_BLSP1_AHB_CLK" redefined
>    19 | #define GCC_BLSP1_AHB_CLK                               10
>       | 

So the only patch which actually needed dependency information did not
have it. All other patches have something, even defconfig (!). Confusing.

Best regards,
Krzysztof

