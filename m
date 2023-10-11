Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23A67C4F69
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjJKJvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjJKJvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:51:44 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FDA9D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 02:51:42 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40675f06f1fso4261335e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 02:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697017901; x=1697622701; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mx2O9LvJ3u9j57vC8yl+GJ60dYLRS7SdOeY49WiO/Ug=;
        b=VAxof5lsMa6Tguwk3Kbj2SYrKSZSwdnJLKEgC6CdDUiyMSD9cSiVRbnrN36oLyHtHO
         t1ee8XX1EAYAMND2BeE+0uCY4/AO3FLzoWF4RgVZ25BLuAnS44a8qAmBrrF2AkPwZMNb
         yGWziOBG92wnNQ18HC2vbGalLvLsYjCqhtEv5uhPcnDM06rIUM3tfF6Sbj7E811S20Pn
         qHf/66rCIoZrgHZ8t/wuP80W9ppeagP6+x3TLhVuDrpcmM53wroHA+KoG2HaSETH3Txv
         xH50FQnUoHrg/AqbjmbJWITvoZ4MzHjLC9VtTl80QKE7/oLX97mzPxDCKge72bStYjtd
         AP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697017901; x=1697622701;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mx2O9LvJ3u9j57vC8yl+GJ60dYLRS7SdOeY49WiO/Ug=;
        b=bqQZlzcDk6toIiFGcrImEwhrKIXPBcrdEidUCVd1Dr2+myOOqBGG+ZNieRIuwLrgMx
         59qdLO6TefK4xie/CB281PUkxj9HowXjnqW9H68gYBZ7LrmMbmzOjZ9z7lEcu1nHdJuh
         FNYhYsisqGg8IPSlq6P7z/9/K/TnJqcT1Fe8Q8I03GDxOzedABKsLeY0NXdiYZwZkYsN
         hVUS20khbtU9Os8fh0sO+lEjPj1IZCBXhwNaIaZUamHvOS2riFlhx1NTbtgeTbIjV/b2
         S5gAorOC+DL8iJqi0PmbIgE6inQBhO8rbb1goIqoWhz/361t0Dm6f67llIJ/uD8fz+sd
         rSbg==
X-Gm-Message-State: AOJu0Yyn6fOjdj1MUBL5WBGGjeniyEZXgvB1G4MvyQwbSyXwZCdSqVn/
        e4LHy8b+4CXDsRaVaMi8OG6nxQ==
X-Google-Smtp-Source: AGHT+IGRm9S+iDcNgkRLNy2rPtHQKT7OJSqDxOIUjCChPJozR/FiDEnaBZFHqXYGtkUSzokN8dK/0w==
X-Received: by 2002:a7b:c044:0:b0:3fb:c075:b308 with SMTP id u4-20020a7bc044000000b003fbc075b308mr16319058wmc.12.1697017900872;
        Wed, 11 Oct 2023 02:51:40 -0700 (PDT)
Received: from [172.30.204.44] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id y6-20020a1c4b06000000b00405588aa40asm16372580wma.24.2023.10.11.02.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 02:51:40 -0700 (PDT)
Message-ID: <ac3fc5fd-b6fa-4386-aa62-f182547d1a59@linaro.org>
Date:   Wed, 11 Oct 2023 11:51:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/4] clk: qcom: branch: Add mem ops support for branch2
 clocks
Content-Language: en-US
To:     Imran Shaik <quic_imrashai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20231011090028.1706653-1-quic_imrashai@quicinc.com>
 <20231011090028.1706653-3-quic_imrashai@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231011090028.1706653-3-quic_imrashai@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/23 11:00, Imran Shaik wrote:
> From: Taniya Das <quic_tdas@quicinc.com>
> 
> Clock CBCRs with memories need an update for memory before enable/disable
> of the clock, which helps retain the respective block's register contents.
> Add support for the mem ops to handle this sequence.
> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
> ---
>   drivers/clk/qcom/clk-branch.c | 37 +++++++++++++++++++++++++++++++++++
>   drivers/clk/qcom/clk-branch.h | 21 ++++++++++++++++++++
>   2 files changed, 58 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
> index fc4735f74f0f..9ac8d04b425a 100644
> --- a/drivers/clk/qcom/clk-branch.c
> +++ b/drivers/clk/qcom/clk-branch.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright (c) 2013, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>    */
>   
>   #include <linux/kernel.h>
> @@ -134,6 +135,42 @@ static void clk_branch2_disable(struct clk_hw *hw)
>   	clk_branch_toggle(hw, false, clk_branch2_check_halt);
>   }
>   
> +static int clk_branch2_mem_enable(struct clk_hw *hw)
> +{
> +	struct clk_mem_branch *mem_br = to_clk_mem_branch(hw);
> +	const char *name = clk_hw_get_name(&mem_br->branch.clkr.hw);
> +	u32 val;
> +	int timeout = 200, ret;
Reverse-Christmas-tree, please

You can drop the timeout variable and pass the int literal.

> +
> +	regmap_update_bits(mem_br->branch.clkr.regmap, mem_br->mem_enable_reg,
> +			mem_br->mem_enable_ack_bit, mem_br->mem_enable_ack_bit);
This is a mask, not a bit.

> +
> +	ret = regmap_read_poll_timeout(mem_br->branch.clkr.regmap, mem_br->mem_ack_reg,
> +			val, val & mem_br->mem_enable_ack_bit, 0, timeout);

[...]

> +/**
> + * struct clk_mem_branch - gating clock which are associated with memories
> + *
> + * @mem_enable_reg: branch clock memory gating register
> + * @mem_ack_reg: branch clock memory ack register
> + * @mem_enable_ack_bit: ANDed with @mem_ack_reg to check memory enablement
@dog: woofs

Describe what it is instead.

Konrad
