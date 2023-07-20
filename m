Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E7475A7F5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjGTHij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjGTHig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:38:36 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D72F2123
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:38:34 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b7430bda8bso6505651fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689838712; x=1690443512;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1n8N9J9B24EsiLuyq+qMu7/xWi95+D9RIHdWY4bjMlw=;
        b=GeoUaGrgnR0h6DBy8/tSBBkVuInqNGEx92wbx22OC7UH7M1q+9hhY5Y8BMhcpovfAr
         gbXzA2y28jDGSBLOi/7WASC624U4URepJAAw3xLUDEbq0RvtRSlX4B9DF+ZjgFO1wgAE
         KjkBihWI/MCIQEVdwbmYj2hZ7/CrT+CKGvKNehAsnydKvCcsy9OpxN+7HJPkCfEAnFVm
         rVNQkSKkJeGB6GEaOkFZmrOK0bnFnoDZU6G8nQenON5LagMQKHczqq6jB27YyADNsLL8
         mJBNOe2zjbuGc5KpXqGgETujd9heIcrJHnuqarGl6A2gcsJXlU4O+oNRhztP5gBhaYMk
         SDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689838712; x=1690443512;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1n8N9J9B24EsiLuyq+qMu7/xWi95+D9RIHdWY4bjMlw=;
        b=YiM9gQmmuZkI0L2/owYB07ZdXe9Lkf2avnq+jf7anRJyTZ+6sVWSWZ4hRmXEDGzMaB
         /s7RvZQ951andRvt8vo0JbM/Ket37J72hmm/2/oj7Y40c7DWm2M55RqWdWWKKolJOGZ5
         np0JJiaYj54peGtnuA5FkT7HMtl84g+k6oTG6wm2mj+GgVsO7jipiJFQ7JBd5C5sHAdQ
         HOAyBhCg20/IarAtfr1c2o1mOIL+MHYME+TQZTBzFyvGfA0F/sN78n38RPZEZPaJhg+L
         R/eRciLL/pq4YnYtG9996UuGsp58+Q0L4xG8Kt2yPxpYREsxK63hoOy6Kn9qlU2bk2ud
         pzRA==
X-Gm-Message-State: ABy/qLYCmlJALFu+yqZWi4z2+1BeLxwr0f30HSdqHrzc2AfhbRMt20Bc
        pDWSwLoQtM5B1i1wGAeqHZJnUw==
X-Google-Smtp-Source: APBJJlFj+lgK0tC3C5aVE3I2Z2W3jn+aS20PeB0Q63eFQsAZdHp7EgvN4ur9x2eS2Xh0+3VOD68efw==
X-Received: by 2002:a2e:908b:0:b0:2b9:6181:d255 with SMTP id l11-20020a2e908b000000b002b96181d255mr1847243ljg.20.1689838712194;
        Thu, 20 Jul 2023 00:38:32 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id t16-20020a2e9d10000000b002b6fe751b6esm103067lji.124.2023.07.20.00.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 00:38:31 -0700 (PDT)
Message-ID: <852984cc-ac76-31c1-ced5-38286c450544@linaro.org>
Date:   Thu, 20 Jul 2023 09:38:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] pinctrl: qcom: sm8350-lpass-lpi: add SM8350 LPASS
 TLMM
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230619092735.20323-1-krzysztof.kozlowski@linaro.org>
 <20230619092735.20323-2-krzysztof.kozlowski@linaro.org>
 <851790f2-f673-f754-08b8-d07cc2c809fb@linaro.org>
 <74f81a77-6cba-37eb-54ed-e7570db47632@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <74f81a77-6cba-37eb-54ed-e7570db47632@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.07.2023 21:05, Krzysztof Kozlowski wrote:
> On 24/06/2023 14:12, Konrad Dybcio wrote:
>> On 19.06.2023 11:27, Krzysztof Kozlowski wrote:
>>> Add driver for pin controller in Low Power Audio SubSystem (LPASS).  The
>>> driver is similar to SM8250 LPASS pin controller, with difference in one
>>> new pin (gpio14).
>>>
> 
> 
> 
>> <       LPI_MUX_swr_tx_data2,
>> 54d52
>> < static int gpio14_pins[] = { 14 };
>> 71d68
>> <       PINCTRL_PIN(14, "gpio14"),
>> 75c72
>> < static const char * const swr_tx_data_groups[] = { "gpio1", "gpio2", "gpio5", "gpio14" };
>> ---
>>> static const char * const swr_tx_data_groups[] = { "gpio1", "gpio2", "gpio5" };
>> 111d107
>> <       LPI_PINGROUP(14, 6, swr_rx_data, _, _, _),
>>
>>
>>
>> I really think adding just these pin14 entries to the 8250 driver would
>> be a good idea..
>>
> 
> 
> I could extend arrays with gpio14 and pass array size -1 to sm8250
> variant and full size to sm8350. However the difference will be in:
> 
> -static const char * const swr_tx_data_groups[] = { "gpio1", "gpio2", "gpio5" };
> +static const char * const swr_tx_data_groups[] = { "gpio1", "gpio2", "gpio5", "gpio14" };
> 
> I cannot create here variant "swr_tx_data_groups_sm8350" because the
> name is used in macros. Using bigger (with gpio14) group for sm8250
> should work, because there is no gpio14, but produces difference in the
> controller:
> 
> -/sys/kernel/debug/pinctrl/33c0000.pinctrl/pinmux-functions:function 18: swr_tx_data, groups = [ gpio1 gpio2 gpio5 ]
> +/sys/kernel/debug/pinctrl/33c0000.pinctrl/pinmux-functions:function 18: swr_tx_data, groups = [ gpio1 gpio2 gpio5 gpio14 ]
> 
> Therefore I will go with separate drivers.
Ack

Konrad
> 
> Best regards,
> Krzysztof
> 
