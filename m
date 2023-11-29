Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554E67FE177
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbjK2U7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbjK2U7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:59:48 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B83D69
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:59:54 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b2fa4ec5eso1514005e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701291592; x=1701896392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FzQQfOp27wgqk+mvGXV7TAJbuPcrusmFmRn6zVsoj4c=;
        b=fCMh6vsPNm/I17BBfoq0wveOG2abeVkXoSFKIpjIJCbUKMtYEQrPlVqqqGOnheiqK5
         v6kHPHC2e8fQewcK1aJ6bqWdel9R60PVktOlJFMEvucxIsdk09drbberBgJVT1qZpddt
         AJ4EDXHR/QHOIj7G9UJk6hnmSmgI5204eQMnxtbo33SbblrdId6L3gSaZ10/RRSUSRXL
         fXdez2ex4ze/6whhycFZa80Aj1jyWYn4y1Tp5UQKaj7LYHSjhvB3wPRp4NQjO9AfnRz6
         tXlXGGktRw233ZavCIlVXZprd1EXXOCqoagorpfU6k5b2d7HKI+En1Th853pOpwtPmdn
         ciWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701291592; x=1701896392;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FzQQfOp27wgqk+mvGXV7TAJbuPcrusmFmRn6zVsoj4c=;
        b=Kc0I/CfNx+jQ09Skifm0znp64xjFqjo7asxmwvH0WDXVCzcxfuWLk8va3o+czkqzw9
         /UP7m6PBTh2m6f2PqvJJVMITcRB2CxPQQLFw4o2jWEf9JuAihEhQZFupzaUhEZvgrEN9
         IBgoTDlVeXYr1wSgxqD+br7XxRxFf87KdpBh2HsWilkSPJSaJJ1ifq9xFI/ucaDbI6wM
         gDsJe+MUk3i8QMUw5cTAR7m0DTjNTo1nUPjEb6KFqcqpfQqe/o9bvtK2gVVkXibBN3ct
         oeuI+RXigvPm4QUHK8u00e8SLw7eGRTXaf9f/iWW3goxhv2LzOtBYIlNLGFzyEZIJlaT
         Ju3g==
X-Gm-Message-State: AOJu0YxmD3fzKkpiWD87YqbqsyJ8n9Juk02vj/tJ20kagbTj3PsYfHR/
        DcNF3fklmeGsKjKfBO/JkPgmsA==
X-Google-Smtp-Source: AGHT+IFSqhdoAfTiT6S2k82UhyjDcshJX0U75yjF7Rv6AWlXKr5UKlcpowl5+2AHrDv4ASj5TZwRIA==
X-Received: by 2002:a5d:6343:0:b0:32f:a5af:99ca with SMTP id b3-20020a5d6343000000b0032fa5af99camr13822722wrw.69.1701291592610;
        Wed, 29 Nov 2023 12:59:52 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id hg11-20020a05600c538b00b0040b48690c49sm3410823wmb.6.2023.11.29.12.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 12:59:51 -0800 (PST)
Message-ID: <d65653d1-e7f6-45c6-ba2c-0ef973866ffb@linaro.org>
Date:   Wed, 29 Nov 2023 20:59:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] clk: qcom: Use qcom_branch_set_clk_en()
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230717-topic-branch_aon_cleanup-v2-0-2a583460ef26@linaro.org>
 <20230717-topic-branch_aon_cleanup-v2-2-2a583460ef26@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230717-topic-branch_aon_cleanup-v2-2-2a583460ef26@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 29/11/2023 18:59, Konrad Dybcio wrote:
> Instead of magically poking at the bit0 of branch clocks' CBCR, use
> the newly introduced helper.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

> -	/*
> -	 * Keep clocks always enabled:
> -	 *	cam_cc_gdsc_clk
> -	 *	cam_cc_sleep_clk
> -	 */
> -	regmap_update_bits(regmap, 0x1419c, BIT(0), BIT(0));
> -	regmap_update_bits(regmap, 0x142cc, BIT(0), BIT(0));
> +	qcom_branch_set_clk_en(regmap, 0x1419c); /* CAM_CC_GDSC_CLK */
> +	qcom_branch_set_clk_en(regmap, 0x142cc); /* CAM_CC_SLEEP_CLK */

This all looks functionally correct to me, wondering what your 
motivation for changing the comment is though.

Anyway, IDK that matters.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
