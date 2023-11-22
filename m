Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9907F4BAF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344376AbjKVPzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjKVPzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:55:31 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263CD101
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:55:28 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50a6ff9881fso10159374e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700668526; x=1701273326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tuUSCKitbZ3SGvzXZg/oUjqEJ+iFFMtGQawxrjsdu7o=;
        b=mOrWO93okSlWgGBufvDV4HfEG1Wmpyodus1zA0TSmWII4ehJUOLBhKxoC8wAaBCVZq
         X+qwGkubMkM5SpmXEeRBk563nDfHuKWYxhG2haPDbGCyzB1mctQwxXn2qONNty7bM2xW
         6nS7bQCFOxq21w7zup02YBt+bskBY1V2METz6fAHFJqaRLKlyYBVXBD1faEH5MPydOJx
         9lhSUmlqXlqRcazrt+UYYF1Eg2GIhl+bnV0C06O1wjdM1NijRP/ShCzzcR8kKn36WYjw
         Fvu9jQRbEL591BNF/fLb1vrOIMZQ4cpqogEwL2tfBVEJK6O9aHjNPfaCJ/61YgKqjqxB
         uH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700668526; x=1701273326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tuUSCKitbZ3SGvzXZg/oUjqEJ+iFFMtGQawxrjsdu7o=;
        b=g2cI7+WOnyzjmTybZiYKGREvPTImSMWCLtgJcfn5w1kFLsUzTf/2jYSi+9axsDMRH8
         8pth3OUJCA2wtnaBwq8orWgjTbiU3Y1rgHpNuoyJNaoSpDhnpALtcYdO2FJXXrkX7oCt
         j5cFmUVtI5O8SbMnvFcZ0SWHscL1Zf1PmT6B/3uJfxphTuwTW/p5DhpFuOdsKkoir5gi
         TCEHRFlmp9nE1XDAqJF8s3cPy6VG4YXY31kSnwtR0sfzn8pyyasw4txfALfWoUAGM32w
         pi7Af6DycQ/1eK3Njx/puURhcVaVs8eC4wHLphTIDDi9mpsnxou9wGTBeqRotvakl8xc
         73lA==
X-Gm-Message-State: AOJu0YwJqDW7RJ2e/QD1f5fzLsVGVBRiTbtFowYb05jRhcgqWwNOZ40W
        uBihpoyzHaCe7foies4QbxvKrg==
X-Google-Smtp-Source: AGHT+IFqAGojedce1elFd2BPwcWFUIy9NXz5jsXKRY6OKpwaxzJFqHBgoXDG5A2VKxkV81eYQDCVIA==
X-Received: by 2002:a05:6512:3e02:b0:502:9bb6:3aba with SMTP id i2-20020a0565123e0200b005029bb63abamr742848lfv.14.1700668526169;
        Wed, 22 Nov 2023 07:55:26 -0800 (PST)
Received: from [172.30.204.227] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id s7-20020a19ad47000000b0050aa9df16fbsm1323460lfd.179.2023.11.22.07.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 07:55:25 -0800 (PST)
Message-ID: <029d9924-0f02-40ac-856c-04547c2cb678@linaro.org>
Date:   Wed, 22 Nov 2023 16:55:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clk: qcom: Add TCSR clock driver for x1e80100
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231122-x1e80100-clk-tcsrcc-v1-0-43078c6d6452@linaro.org>
 <20231122-x1e80100-clk-tcsrcc-v1-2-43078c6d6452@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231122-x1e80100-clk-tcsrcc-v1-2-43078c6d6452@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/22/23 14:42, Abel Vesa wrote:
> The TCSR clock controller found on X1E80100 provides refclks
> for PCIE, USB and UFS. Add clock driver for it.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
[...]


> +static int tcsr_cc_x1e80100_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap;
> +
> +	regmap = qcom_cc_map(pdev, &tcsr_cc_x1e80100_desc);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	return qcom_cc_really_probe(pdev, &tcsr_cc_x1e80100_desc, regmap);
> +}
qcom_cc_probe

other than that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
