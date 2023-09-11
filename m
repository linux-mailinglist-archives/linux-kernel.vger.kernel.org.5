Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3886879AB45
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 22:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjIKUrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236936AbjIKLne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:43:34 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751E7E50
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:43:28 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31f915c3c42so1726407f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694432607; x=1695037407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zhvqmtlPbl/ToiLBkS2C664oW0NpQWmg1Qdfqpzz/ks=;
        b=h85qjoOzihIC+Jfm/OgJKc4r5B0bSGnKrJPXJzit6opvv+s72AytROOKIJwpVsL0hG
         6SkGak0t3IIVzqDzPAFSQdHqwZ319hzXuWe/SayI/RLJA7r7hU+xSl4fZYUz8kZ0Ui5j
         IOzNBPhcW1wOlGRiHqn1Zmfz030RUBC5LmyfA5RIzlFNpye7jCf3s/9nnPUUaMcn1f+n
         MzeDofjuT9JXein4Qje7K7cCr3piT2UpaaqDoiXDV2DudODEtMluqwHgWBS9RuXlGy3w
         kB+dOFMqH8gHfLqMFpRyw/GDG875jW7CfRuAkA+31gn1VY5NZvD65PAgLyGuTv4sSNg0
         1hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694432607; x=1695037407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zhvqmtlPbl/ToiLBkS2C664oW0NpQWmg1Qdfqpzz/ks=;
        b=rvo9shyqRLC87wuIZaPFNOOH1pAOKcCWKTVWK6v2KWC0+ynGqhyxeS0uOGj8cL0gHB
         nkbFmU6rPhYn0b6otVosBIoZzEwyg+G32saxYaR/A7rhzKqUzb2K1TJ7M3vqbw5fxlEH
         n3jKPJ9bfQF7F4ZPOEPuiCJfazjDOuKevPMXs4lvaV3x8WY3rZN6FYJZ+g5tSiQ2yS+B
         2IHWZgtK/V5QRus0u/U/PAQCihg3wKMH6wpnvNJohcs8+bZ88XiEAuvnDrJvQBiQDVDT
         PfxryO7Bp7s0nLL6sAJWg/cgxCOjpiC1i3YJHtI2r9Fd00uGONy8kXwjgGWAYV6Ftk9N
         tPwg==
X-Gm-Message-State: AOJu0YxYvpjjBlpQKzYeT9NbioyiUF2Va4/ltSZ7tK2daqvG4JGA6hmH
        QaouGBAmXeQMM7RMlmI62PdDjg==
X-Google-Smtp-Source: AGHT+IHDWHlDL5vz5A1MoSOGg/s1su6sfKxPHNvw4o1B8UIig50Xaff6LXy44TsmqogO5HVIRr8EMQ==
X-Received: by 2002:a5d:6302:0:b0:316:f3cf:6f12 with SMTP id i2-20020a5d6302000000b00316f3cf6f12mr7051795wru.48.1694432606716;
        Mon, 11 Sep 2023 04:43:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id r15-20020a056000014f00b0031c6dc684f8sm9771891wrx.20.2023.09.11.04.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 04:43:25 -0700 (PDT)
Message-ID: <15898954-3b47-651d-43f4-844f45da171e@linaro.org>
Date:   Mon, 11 Sep 2023 13:43:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: Add Qualcomm SM4450
Content-Language: en-US
To:     Tengfei Fan <quic_tengfan@quicinc.com>,
        Rob Herring <robh@kernel.org>
Cc:     will@kernel.org, arnd@arndb.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_kaushalk@quicinc.com,
        peng.fan@nxp.com, kernel@quicinc.com, catalin.marinas@arm.com,
        rafal@milecki.pl, krzysztof.kozlowski+dt@linaro.org,
        nfraprado@collabora.com, quic_shashim@quicinc.com,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
        linux-pm@vger.kernel.org, quic_tsoni@quicinc.com,
        geert+renesas@glider.be, andersson@kernel.org, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, agross@kernel.org,
        quic_tdas@quicinc.com, djakov@kernel.org, konrad.dybcio@linaro.org
References: <20230908064427.26999-1-quic_tengfan@quicinc.com>
 <20230908064427.26999-2-quic_tengfan@quicinc.com>
 <169415894359.3239551.14338430937225080028.robh@kernel.org>
 <375df554-e661-42ad-8a6f-f862aa05b654@quicinc.com>
 <5f172a8f-ecd7-44b0-9b02-48eb13d40497@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5f172a8f-ecd7-44b0-9b02-48eb13d40497@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2023 12:15, Tengfei Fan wrote:
>>>
>>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>>
>>> yamllint warnings/errors:
>>>
>>> dtschema/dtc warnings/errors:
>>> Documentation/devicetree/bindings/interconnect/qcom,sm4450-rpmh.example.dts:18:18: fatal error: dt-bindings/clock/qcom,gcc-sm4450.h: No such file or directory
>>>     18 |         #include <dt-bindings/clock/qcom,gcc-sm4450.h>
>>>        |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> compilation terminated.
>>> make[2]: *** [scripts/Makefile.lib:419: 
>>> Documentation/devicetree/bindings/interconnect/qcom,sm4450-rpmh.example.dtb] Error 1
>>> make[2]: *** Waiting for unfinished jobs....
>>> make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1500: 
>>> dt_binding_check] Error 2
>>> make: *** [Makefile:234: __sub-make] Error 2
>>>
>>> doc reference errors (make refcheckdocs):
>>>
>>> See 
>>> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230908064427.26999-2-quic_tengfan@quicinc.com
>>>
>>> The base for the series is generally the latest rc1. A different 
>>> dependency
>>> should be noted in *this* patch.
>>>
>>> If you already ran 'make dt_binding_check' and didn't see the above
>>> error(s), then make sure 'yamllint' is installed and dt-schema is up to
>>> date:
>>>
>>> pip3 install dtschema --upgrade
>>>
>>> Please check and re-submit after running the above command yourself. Note
>>> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
>>> your schema. However, it must be unset to test all examples with your 
>>> schema.
>>>
>> Thanks review this patch, will setup new env for verify again.
>>
> this error is due to have dependence with: 
> https://lore.kernel.org/linux-arm-msm/20230824173410.550126-1-quic_ajipan@quicinc.com/, 
> will add this link to coverletter.

The patch should have it for the bot to understand it.

Best regards,
Krzysztof

