Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B5080EF6A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376852AbjLLOlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbjLLOlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:41:02 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7363EA8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:41:08 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c9f099cf3aso86641841fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702392067; x=1702996867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mt0RJuRzONksksmHKJ5+QxIw2yK885EP6NVJe05HDXw=;
        b=v0ai7RS7xku8P5+CKAU7nmTK7xVSK176EW1ujOLf0lgeLEFlPFRoKbOj1mLVuxwJmR
         nnV5PO2Zi2G2051WAzNQcJdtoSBKVijfLTIk5POcE7KC7nJTfbxbXEncLt6kEJGFE0af
         +HHLQys11GMBf5L1uj6J1Oa1tssiwedQhgroaQNpiOELekcT2eW5LQW5+hs4bRHooJ58
         fDl08svrsALgf2b3G8kyGnSJ+aIbuJfhWaxq+PT/DeXOqqXgjgJH/3q/kV6f4H3jQBIl
         CI+MZle2CIVVMEqagkSOGqOBq1Mid2GG3sIO87NCqWk+rpWIwJjfvO2ZDDx/hbV0OKMS
         SO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702392067; x=1702996867;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mt0RJuRzONksksmHKJ5+QxIw2yK885EP6NVJe05HDXw=;
        b=cQZYFQU5vzKQ6p2irYoYzNo9qPysnV/t6XSL1/i0iX94Ubyh8YUYHJBWMF3xgk08cS
         pXUX4uiJ5hVEQrOhO0KXMW8l8o/fYX9qNGY6StSSgs2G1UofXfZ+vNFiBUJEv3V9JBpJ
         EI+DaqqHU5doL4VrferANtqVDHgckWknmCCsjIZ1WhqYsvCHfrCpQtimQL5F7OQ4h5uq
         LgJjyuWtZzryy1bQFMFM15PrSCQu+B3gUetalfRJ5Uh0gaorGDHuWb8auWSr/qfAJ+JI
         96RTTYrq1JVlFUnTMt5yMFd1D0ToHS6MP3k4ycEmmbd6AaQA3RO4+VMvY1h8tnnJlWU5
         WXcQ==
X-Gm-Message-State: AOJu0Yxd/kSMR7x5IfF2Fx+9zAyxBczCSq9kOnjfSqqUB2yFQXFfb3Cb
        3E3zTBI0MtMzBWCxw+fk8/BIBA==
X-Google-Smtp-Source: AGHT+IHjmt9N5sHhVDkteIF1PnQFUta/ditveaR0cep4gfy0ZgiiYwB3FbpejBjBcD769GhWHVUzMQ==
X-Received: by 2002:a2e:9ec4:0:b0:2ca:5e:d16f with SMTP id h4-20020a2e9ec4000000b002ca005ed16fmr2990790ljk.18.1702392066690;
        Tue, 12 Dec 2023 06:41:06 -0800 (PST)
Received: from [172.30.205.64] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id t27-20020a2e8e7b000000b002cc21cc7710sm638479ljk.68.2023.12.12.06.41.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 06:41:06 -0800 (PST)
Message-ID: <52aa1fdb-ebdf-4cef-80d6-6c1b83d626ab@linaro.org>
Date:   Tue, 12 Dec 2023 15:41:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm8650: drop unneeded assigned-clocks
 from WSA macro
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231212133143.100575-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231212133143.100575-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/23 14:31, Krzysztof Kozlowski wrote:
> Review of v1 patch resulting in commit 58872a54e4a8 ("arm64: dts: qcom:
> sm8650: add ADSP audio codec macros") pointed to remove unneeded
> assigned-clock-rates from macro codecs.  One assignment was left in WSA
> macro codec, so drop it now as it is redundant: these clocks have fixed
> 19.2 MHz frequency.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Thanks, could you also check if they're fixed on older platforms?

Konrad
