Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27B37E229E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjKFNAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjKFNAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:00:38 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E95EBD
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 05:00:35 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d9a3d737d66so3706676276.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 05:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699275634; x=1699880434; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GsPAHuuacaXRxIMIbqeYFW832Idaj5Z8NonFcgzOGQQ=;
        b=GjaU3l4kia/urkfICgVHVWjT+p9YlH/qqqDFw37gEX1L1V/x4qDAjH64Gd7xf5jzyf
         7OWi5dB1JwWhPmmrwhfxXZFp+v2CBRhezsaeM6ZBwIdvKm+W1p/Rc6B+aaIuOx4MpgB8
         jgPW5wHgzxxrH1e9yQITzkPJBBUrlc3UQCMeYvT5l0O9ZxhH8taMyCEwWL4p8CGoGfGv
         Y3mxeEt3QVAYZrxViNVmi5EOqJOF5doYCaHKKsUF4e2YqjVveFp3oMWgCWKh/0mXEGvf
         0so/rckVg2zownx+OZw3J9bgs029mrhUS0+irYpdJvY7ghTpME/RWSoCOC6Kg6fpVOu0
         JUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699275634; x=1699880434;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GsPAHuuacaXRxIMIbqeYFW832Idaj5Z8NonFcgzOGQQ=;
        b=TrS2qkVPU6JgWySqZ4jZnN6wIEA1vorzTheT51KmyImZcSqHevQXdVIQ/4ecsXySsF
         jxmGZWaWOiulMv7c6oo9R5dSy2NESX+IuMSBBJlCYo+En6YyRyo/l2CDbgbCxc0knYZT
         IzcYfhYHRAJJiO+VbyCiWFsvnjD23qNTe+1PXOyHeUxIe3dW5oKv15ho/htxmva8Jkiw
         9LhlfhNt/cJHJuNCDGpZlv/hvzgjmMZnC7CHOzkz1VcR5Zd8UVBAQF2lI+SrvLCfjKbS
         v9gXl+pcESgpocLq6dh/6anWEIe3ZmsYbh1sQc0HBeZ5Jl7YEeLFT2RDknPcmLZODpMT
         msyw==
X-Gm-Message-State: AOJu0YxGlEQ4ddr9ZuqklcOCPVST11eVAosDmPjQpSWS58z9WNLVfTRt
        +X5TUNFCH+HJVjKCTIoolZ+lzeiUg2Nzp8X39DupNQ==
X-Google-Smtp-Source: AGHT+IGGAQ0SPeS9k4vThxvaIdIq5zE1xB8+xmEuSjhUvM+qfy1Ks2t7vu34m9fYxaX8ybZo779u9UEx0SnF2U0/H4U=
X-Received: by 2002:a25:d047:0:b0:da0:3b6c:fc22 with SMTP id
 h68-20020a25d047000000b00da03b6cfc22mr24752762ybg.31.1699275634492; Mon, 06
 Nov 2023 05:00:34 -0800 (PST)
MIME-Version: 1.0
References: <20231106103027.3988871-1-quic_imrashai@quicinc.com> <20231106103027.3988871-3-quic_imrashai@quicinc.com>
In-Reply-To: <20231106103027.3988871-3-quic_imrashai@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 6 Nov 2023 15:00:23 +0200
Message-ID: <CAA8EJpqcyh1YrfHkdYaZfjyEDjKiV+HixrhcfPzsuTPwA5pzTQ@mail.gmail.com>
Subject: Re: [PATCH V3 2/4] clk: qcom: branch: Add mem ops support for branch2 clocks
To:     Imran Shaik <quic_imrashai@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2023 at 12:31, Imran Shaik <quic_imrashai@quicinc.com> wrote:
>
> From: Taniya Das <quic_tdas@quicinc.com>
>
> Clock CBCRs with memories need an update for memory before enable/disable
> of the clock, which helps retain the respective block's register contents.
> Add support for the mem ops to handle this sequence.
>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>

It would be nice to have a description of what is 'CBCR with memories'
and how does it differ from CBCR_FORCE_MEM_CORE_ON?

> ---
>  drivers/clk/qcom/clk-branch.c | 39 +++++++++++++++++++++++++++++++++++
>  drivers/clk/qcom/clk-branch.h | 21 +++++++++++++++++++
>  2 files changed, 60 insertions(+)
>
> diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
> index fc4735f74f0f..61bdd2147bed 100644
> --- a/drivers/clk/qcom/clk-branch.c
> +++ b/drivers/clk/qcom/clk-branch.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2013, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>
>  #include <linux/kernel.h>
> @@ -134,6 +135,44 @@ static void clk_branch2_disable(struct clk_hw *hw)
>         clk_branch_toggle(hw, false, clk_branch2_check_halt);
>  }
>
> +static int clk_branch2_mem_enable(struct clk_hw *hw)
> +{
> +       struct clk_mem_branch *mem_br = to_clk_mem_branch(hw);
> +       struct clk_branch branch = mem_br->branch;
> +       const char *name = clk_hw_get_name(&branch.clkr.hw);
> +       u32 val;
> +       int ret;
> +
> +       regmap_update_bits(branch.clkr.regmap, mem_br->mem_enable_reg,
> +                       mem_br->mem_enable_ack_mask, mem_br->mem_enable_ack_mask);
> +
> +       ret = regmap_read_poll_timeout(branch.clkr.regmap, mem_br->mem_ack_reg,
> +                       val, val & mem_br->mem_enable_ack_mask, 0, 200);
> +       if (ret) {
> +               WARN(1, "%s mem enable failed\n", name);
> +               return ret;
> +       }
> +
> +       return clk_branch2_enable(hw);
> +}
> +
> +static void clk_branch2_mem_disable(struct clk_hw *hw)
> +{
> +       struct clk_mem_branch *mem_br = to_clk_mem_branch(hw);
> +
> +       regmap_update_bits(mem_br->branch.clkr.regmap, mem_br->mem_enable_reg,
> +                                               mem_br->mem_enable_ack_mask, 0);
> +
> +       return clk_branch2_disable(hw);
> +}
> +
> +const struct clk_ops clk_branch2_mem_ops = {
> +       .enable = clk_branch2_mem_enable,
> +       .disable = clk_branch2_mem_disable,
> +       .is_enabled = clk_is_enabled_regmap,
> +};
> +EXPORT_SYMBOL_GPL(clk_branch2_mem_ops);
> +
>  const struct clk_ops clk_branch2_ops = {
>         .enable = clk_branch2_enable,
>         .disable = clk_branch2_disable,
> diff --git a/drivers/clk/qcom/clk-branch.h b/drivers/clk/qcom/clk-branch.h
> index 0cf800b9d08d..8ffed603c050 100644
> --- a/drivers/clk/qcom/clk-branch.h
> +++ b/drivers/clk/qcom/clk-branch.h
> @@ -38,6 +38,23 @@ struct clk_branch {
>         struct clk_regmap clkr;
>  };
>
> +/**
> + * struct clk_mem_branch - gating clock which are associated with memories
> + *
> + * @mem_enable_reg: branch clock memory gating register
> + * @mem_ack_reg: branch clock memory ack register
> + * @mem_enable_ack_mask: branch clock memory enable and ack field in @mem_ack_reg
> + * @branch: branch clock gating handle
> + *
> + * Clock which can gate its memories.
> + */
> +struct clk_mem_branch {
> +       u32     mem_enable_reg;
> +       u32     mem_ack_reg;
> +       u32     mem_enable_ack_mask;
> +       struct clk_branch branch;
> +};
> +
>  /* Branch clock common bits for HLOS-owned clocks */
>  #define CBCR_CLK_OFF                   BIT(31)
>  #define CBCR_NOC_FSM_STATUS            GENMASK(30, 28)
> @@ -85,8 +102,12 @@ extern const struct clk_ops clk_branch_ops;
>  extern const struct clk_ops clk_branch2_ops;
>  extern const struct clk_ops clk_branch_simple_ops;
>  extern const struct clk_ops clk_branch2_aon_ops;
> +extern const struct clk_ops clk_branch2_mem_ops;
>
>  #define to_clk_branch(_hw) \
>         container_of(to_clk_regmap(_hw), struct clk_branch, clkr)
>
> +#define to_clk_mem_branch(_hw) \
> +       container_of(to_clk_branch(_hw), struct clk_mem_branch, branch)
> +
>  #endif
> --
> 2.25.1
>


-- 
With best wishes
Dmitry
