Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95C97F9D44
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjK0KOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbjK0KOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:14:36 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DE9EA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:14:42 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c871d566cfso44478131fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701080081; x=1701684881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CNHHiLpeR2Ce67c7aTqgpQJDINa9GFsM154ew5MCzfw=;
        b=ZiW1iVnQBf6sLUnq7bdjd9OajnObpl1WlsqKeXpFS5yWjQudUTsb7O72Zplc6IxAP4
         MMg6uxGbrIELfZZ7IYYEkpYMM0xhIJ8oK3zPF04gykx2ODWe7F5MNdzFlV9uI1zIkyqB
         LABDws6uGAecjBaiBqKnJ8aDbuvGGkEvkWBsS2dkSzngBMgheQDabE6fM/MuWK/n4XkW
         dtS5M7vsvC22SDHYXyGoM/1wzztKYJwgDC+9d93mAZgCOfgBsZx0sJ7wRD3XvPOfmfFu
         keDwJF4EvUdP2vseRwDe6ay6VjKp54Ad/HyNhsBdXLQRBNqi2EdAQDDssDIJQnF6By4M
         yijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701080081; x=1701684881;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CNHHiLpeR2Ce67c7aTqgpQJDINa9GFsM154ew5MCzfw=;
        b=sl++EeKcKqpbbQT+4cudz0+KrVDpOrsUEHH/1Cs3ybzdlHinR/ZD+zzGAJJptoPs9D
         c35eqMSIzxRaE0IWzzWirRyBJbYgcT5/FdywkXBRHXZvubcNC5BJAz3La69+0W8O6dFc
         gy5KU/nIG0UZ0n+1TCEbge9YXYPykgX/HNWRK3SY1RtvX5hNKxbbtF43uzMtTWF+VsFo
         UgPj4RCePiHX2BWt6mlIX++OJOMDOapt17VcqCwzfc+6gEfKZQuFpmJsEsz7BAHsmaAC
         KzJssh7aKwbpmnO9RLdgXOLk42TI61VmyyxUlNCNRuBW1QzBu/u5tWYU5bv4h0a2+P0l
         ybzw==
X-Gm-Message-State: AOJu0YykHvU3trcOEaK67EG06XoShDmnwoUEYr2YUDwdlWlyqr3EWPJ8
        l3RT+PavpZeHblg/Opbd1XUj27AhpxAu0I7iJZ2Oubk6
X-Google-Smtp-Source: AGHT+IGZZYfB3M3w67wDWKNxuZZ/I8T9o4pe5ERsw+U2o/eGYk7sBQ/Ca2iXcUuYEFwHhDVFGdC32A==
X-Received: by 2002:a2e:9e8a:0:b0:2b9:412a:111d with SMTP id f10-20020a2e9e8a000000b002b9412a111dmr7268289ljk.42.1701080081083;
        Mon, 27 Nov 2023 02:14:41 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id b5-20020a05600c4e0500b003feae747ff2sm14185211wmq.35.2023.11.27.02.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 02:14:40 -0800 (PST)
Message-ID: <37422200-7954-4f0d-92ad-37da3a98b36d@linaro.org>
Date:   Mon, 27 Nov 2023 10:14:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: sm8250-xiaomi-elish: Add pm8150b
 type-c node and enable usb otg
Content-Language: en-US
To:     Jianhua Lu <lujianhua000@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20231126022849.14273-1-lujianhua000@gmail.com>
 <20231126022849.14273-2-lujianhua000@gmail.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20231126022849.14273-2-lujianhua000@gmail.com>
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

On 26/11/2023 02:28, Jianhua Lu wrote:
> Add type-c node to feature otg function and set usb-role-switch property
> for usb_1_dwc3 to enable usb otg.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> ---
> Changes in v3:
>    1. squash patch[3/3].
>    2. update commit message.
>    3. add pm8150b_vbus node.
> 
> No changes in v2:
> 
>   .../dts/qcom/sm8250-xiaomi-elish-common.dtsi  | 43 ++++++++++++++++++-
>   1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
> index 3d4ea428e4cb..946365f15a59 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi

lgtm

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

