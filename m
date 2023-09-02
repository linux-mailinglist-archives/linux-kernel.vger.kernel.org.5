Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E941A7907CE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 14:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352130AbjIBMXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 08:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbjIBMXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 08:23:03 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673AC10F5
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 05:22:57 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4ff9b389677so4644312e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 05:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693657375; x=1694262175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=inkHgVlv/XrMvFjg8YzebzCQsHBV+fhNXbfLxuaBdsc=;
        b=EztvANhUDBwtoS26/ikGWtxMwVFhEsKZRftZPOFBVz+A6E2ZgfsEiuCrVVaMjVieNr
         eUbr7PlTDAtydKpV1sLNAgaFyTCfsE2bmf9k+a9WXscgTN/i1ize/6QY/2Bdg/re0gxm
         ZxAoTceJYYAJhViowiVcYbw+jdK8TndSrXQfYFDxNfFF0WmUQoKQzAAUatpgJKGPEN6W
         L+ZmW7tOVv9m/sJ0cC3Fr3tFP0TRJwdWjU9M+rA22H83RpbLMOSvjM/qMKMRAsjkE+tX
         p/kCcZFCHFwj/rhSNo/4JMNWzXKpOah4yaBaUi62yj+z05Szo/afXAZAo2QHlQkgK4Ii
         TYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693657375; x=1694262175;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=inkHgVlv/XrMvFjg8YzebzCQsHBV+fhNXbfLxuaBdsc=;
        b=FR2OQ3WW/7ak5ZZotfM2cIbO8C3Kc6ZeZni8b59P652SOeApx8PfE0ZaQWzjBkavKi
         rYb1qgZJ2ntRr1AgsEEu70JpGYHucjAsrFFQNKJ+KioycUsVa86/9N8urOGrLO5xxVaS
         oABX7Y4zR85M6a/l3wLqWpap0BpgkzRChweZYPoJbzmBZshJ0lWUTzRCeopZIVhSNxDz
         dVolMnnEA1s+lbzv1648jaG5BucP0SPgsNVFIfK+lHL7TXE4W3Zl9DH88cPpZh0F525Y
         H12biWDyLJE99u3bdhglPVsM9azLqKc9005BP2qXxafAEZq32b9ZoMULqT9fCA7YH903
         9n4w==
X-Gm-Message-State: AOJu0YyEndxJmdZj6bFYbIzqRbWBIr+T/DSOfG+U22lORVTEmPaElmbE
        ZMQZHGM3A44t3QQjrIjFjC7mZQ==
X-Google-Smtp-Source: AGHT+IFstkLJDS/HETwMajNV3deWCdOK9KBKLsTmQVXdkjplL/Yy2wh4gmT+Mnvc6W55XwcgNKkBow==
X-Received: by 2002:a05:6512:1103:b0:500:bb99:69a6 with SMTP id l3-20020a056512110300b00500bb9969a6mr4499765lfg.39.1693657375475;
        Sat, 02 Sep 2023 05:22:55 -0700 (PDT)
Received: from [192.168.1.101] (abxi170.neoplus.adsl.tpnet.pl. [83.9.2.170])
        by smtp.gmail.com with ESMTPSA id a2-20020a056512020200b004ff89a88ef7sm975884lfo.14.2023.09.02.05.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Sep 2023 05:22:55 -0700 (PDT)
Message-ID: <295f0c31-3612-428c-849b-9469a6136f47@linaro.org>
Date:   Sat, 2 Sep 2023 14:22:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: dts: ipq5018: Correct uart1_pins pinconf
Content-Language: en-US
To:     Ziyang Huang <hzyitc@outlook.com>, agross@kernel.org
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_gokulsri@quicinc.com, quic_srichara@quicinc.com,
        quic_varada@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <TYZPR01MB5556D24A77DAFA013F93B551C9E4A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <TYZPR01MB5556D24A77DAFA013F93B551C9E4A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1.09.2023 16:10, Ziyang Huang wrote:
> In pinctrl, the pinconfigs for uart are named "blspX_uartY".
>   X is the UART ID. Starts from 1.
>     1-6 are in BLSP Block 1.
>     7-12 are in BLSP Block 2.
>   Y is the index of mux config. Starts from 0.
> 
> In dts, the serials are also named "blspX_uartY", but with different logic.
>   X is the BLSP Block ID. Starts from 1.
>   Y is the uart id inside block.
>     In "ipq6018.dtsi" and "ipq8074.dtsi", it starts from 1.
>     But in "ipq5332.dtsi" and "ipq9574.dtsi", it starts from 0.
> 
> +-----------------+-----------------+-------------+-----------------+
> |     Block ID    | ID inside Block |  dts name   | pinconfig name  |
> | (Starts from 1) | (Starts from 1) |             |                 |
> +-----------------+-----------------+-------------+-----------------+
> |        1        |        1        | blsp1_uart1 |   blsp0_uartY   |
> |        1        |        2        | blsp1_uart2 |   blsp1_uartY   |
> |        1        |        6        | blsp1_uart6 |   blsp5_uartY   |
> |        2        |        1        | blsp2_uart1 |   blsp6_uartY   |
> |        2        |        6        | blsp2_uart6 |   blsp12_uartY  |
> +-----------------+-----------------+-------------+-----------------+
> 
> In "ipq5018.dts", "blsp1_uart1" (dts name) is the first serial (confimed
> by the address), So its pinconfig should be "blsp0_uart0" (pinconfig name,
> use GPIO 20 and 21) or "blsp0_uart1" (pinconfig name, use GPIO 28 and 29).
Surely only one pair of wires is connected? Why is there an "OR"?

Konrad
