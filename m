Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01317E22BC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjKFNE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjKFNE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:04:27 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7DBF3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 05:04:23 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1e9bb3a0bfeso2721310fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 05:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699275862; x=1699880662; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C5eVmNAONKBSMMyy+trlqek0ekUCKHBQR7aBuMQnyPY=;
        b=w5+RSnfIZ1i/wrJLGONhXwhSF2NsxCq/ABmriO19yWQgerpFS4xnVvZnfveHQuYsHl
         5oegPAailI3FZfe4LQPl5fDCZJVENGtu9eqCXsr95zWGjfLrVSjCItkiFMxQe5vmMB7P
         gZD5WUY0nORtPLYTowruHUGTptSCdP6ImULotgiCe9VEFEoTjSRW3vZv0pYpAERyTCOY
         pj6/JAvMb+4WM0DvzQ7den9494khoul24y3M3nKpcBeZUoa4wGxGBXGZSjAf0TaXSNKW
         9+dfXYdVfyuw4GTeedKGRp5MYz/ImTsAz8JAKOlg/YpxMMnEOLGd5bYzlAZZak8wCX3w
         6+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699275862; x=1699880662;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5eVmNAONKBSMMyy+trlqek0ekUCKHBQR7aBuMQnyPY=;
        b=tjecIj+OJp5vv6Umjp5jJbXqvSZYLgIYVHN6QJYIJiQhJTxeoifUGQx+F7yj3pBRQx
         rc8dylz8fzzKl2jAa9Yo9u9TBYJpzokszJHKObGP8wjZcA3JaxoF02H4990rOcvRArCZ
         2eGgeutFRBWNHtlIx7r9q+05O2+K4M9rLBqISdBu15WH0oJVEaILYLXqf1KzHsnKqHNv
         /NiqPiYWkiOHtjYu5YgNnJWlslVYM65Vhekvp4axW+CeMaf/Xp5YXAKGsetKexBKVH+X
         BVL9ryGCk+bj6Zd7CTLJxrgoCxp8mmo+vj142e/jFn11iZQit1MRga7IfBMpQoVD6GQL
         qpXw==
X-Gm-Message-State: AOJu0YyiGy26qPfPe5KVCc2caFDHR68l9Dl1MGi6KtTNdLBvZoSCLCLH
        TdIBjDxHFJbCg3DkCCKc8FGiwR66W+QILzsm9QUkXw==
X-Google-Smtp-Source: AGHT+IFHqKhB1wMxHu8Srrew3duilO6EXP4mM1DNi+Ebxai0n13IsIUNU62pjLo9Oj624Z2/oLchCiWUtIxMa1P6w8A=
X-Received: by 2002:a05:6870:90d5:b0:1d0:d9e2:985f with SMTP id
 s21-20020a05687090d500b001d0d9e2985fmr30085226oab.57.1699275862329; Mon, 06
 Nov 2023 05:04:22 -0800 (PST)
MIME-Version: 1.0
References: <20231106103027.3988871-1-quic_imrashai@quicinc.com> <20231106103027.3988871-4-quic_imrashai@quicinc.com>
In-Reply-To: <20231106103027.3988871-4-quic_imrashai@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 6 Nov 2023 15:04:10 +0200
Message-ID: <CAA8EJpoGLCfrWQ5r8cOcqyWmF2ZTTqPxFy_HVzPC-A-dCiV48A@mail.gmail.com>
Subject: Re: [PATCH V3 3/4] clk: qcom: Add ECPRICC driver support for QDU1000
 and QRU1000
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

On Mon, 6 Nov 2023 at 12:32, Imran Shaik <quic_imrashai@quicinc.com> wrote:
>
> Add ECPRI Clock Controller (ECPRICC) support for QDU1000 and QRU1000 SoCs.

After reading this series I have one main question. What is ECPRI?
You've never expanded this acronym.

>
> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
> ---
>  drivers/clk/qcom/Kconfig           |    9 +
>  drivers/clk/qcom/Makefile          |    1 +
>  drivers/clk/qcom/ecpricc-qdu1000.c | 2456 ++++++++++++++++++++++++++++
>  3 files changed, 2466 insertions(+)
>  create mode 100644 drivers/clk/qcom/ecpricc-qdu1000.c
>
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index ad1acd9b7426..9e54afc67519 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -668,6 +668,15 @@ config QDU_GCC_1000
>           QRU1000 devices. Say Y if you want to use peripheral
>           devices such as UART, SPI, I2C, USB, SD, PCIe, etc.
>
> +config QDU_ECPRICC_1000
> +       tristate "QDU1000/QRU1000 ECPRI Clock Controller"
> +       depends on ARM64 || COMPILE_TEST
> +       select QDU_GCC_1000
> +       help
> +         Support for the ECPRI clock controller on QDU1000 and
> +         QRU1000 devices. Say Y if you want to support the ECPRI
> +         clock controller functionality such as Ethernet.
> +
>  config SDM_GCC_845
>         tristate "SDM845/SDM670 Global Clock Controller"
>         depends on ARM64 || COMPILE_TEST
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 17edd73f9839..607ed0fabf36 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -65,6 +65,7 @@ obj-$(CONFIG_QCM_DISPCC_2290) += dispcc-qcm2290.o
>  obj-$(CONFIG_QCS_GCC_404) += gcc-qcs404.o
>  obj-$(CONFIG_QCS_Q6SSTOP_404) += q6sstop-qcs404.o
>  obj-$(CONFIG_QCS_TURING_404) += turingcc-qcs404.o
> +obj-$(CONFIG_QDU_ECPRICC_1000) += ecpricc-qdu1000.o
>  obj-$(CONFIG_QDU_GCC_1000) += gcc-qdu1000.o
>  obj-$(CONFIG_SC_CAMCC_7180) += camcc-sc7180.o
>  obj-$(CONFIG_SC_CAMCC_7280) += camcc-sc7280.o
> diff --git a/drivers/clk/qcom/ecpricc-qdu1000.c b/drivers/clk/qcom/ecpricc-qdu1000.c
> new file mode 100644
> index 000000000000..a430b7228c26
> --- /dev/null
> +++ b/drivers/clk/qcom/ecpricc-qdu1000.c
> @@ -0,0 +1,2456 @@
> +// SPDX-License-Identifier: GPL-2.0-only

[skipped]


> +
> +static struct clk_mem_branch ecpri_cc_eth_phy_0_ock_sram_clk = {
> +       .mem_enable_reg = 0x8404,
> +       .mem_ack_reg = 0x8418,
> +       .mem_enable_ack_mask = BIT(6),
> +       .branch = {
> +               .halt_reg = 0xd140,
> +               .halt_check = BRANCH_HALT,
> +               .clkr = {
> +                       .enable_reg = 0xd140,
> +                       .enable_mask = BIT(0),
> +                       .hw.init = &(const struct clk_init_data) {
> +                               .name = "ecpri_cc_eth_phy_0_ock_sram_clk",
> +                               .ops = &clk_branch2_mem_ops,

This (and several following branch clocks) do not have a parent
defined. From which clock are they derived from?

> +                       },
> +               },
> +       },
> +};
> +
> +static struct clk_mem_branch ecpri_cc_eth_phy_1_ock_sram_clk = {
> +       .mem_enable_reg = 0x8408,
> +       .mem_ack_reg = 0x841C,
> +       .mem_enable_ack_mask = BIT(6),
> +       .branch = {
> +               .halt_reg = 0xd148,
> +               .halt_check = BRANCH_HALT,
> +               .clkr = {
> +                       .enable_reg = 0xd148,
> +                       .enable_mask = BIT(0),
> +                       .hw.init = &(const struct clk_init_data) {
> +                               .name = "ecpri_cc_eth_phy_1_ock_sram_clk",
> +                               .ops = &clk_branch2_mem_ops,
> +                       },
> +               },
> +       },
> +};
> +
> +static struct clk_mem_branch ecpri_cc_eth_phy_2_ock_sram_clk = {
> +       .mem_enable_reg = 0x840c,
> +       .mem_ack_reg = 0x8420,
> +       .mem_enable_ack_mask = BIT(6),
> +       .branch = {
> +               .halt_reg = 0xd150,
> +               .halt_check = BRANCH_HALT,
> +               .clkr = {
> +                       .enable_reg = 0xd150,
> +                       .enable_mask = BIT(0),
> +                       .hw.init = &(const struct clk_init_data) {
> +                               .name = "ecpri_cc_eth_phy_2_ock_sram_clk",
> +                               .ops = &clk_branch2_mem_ops,
> +                       },
> +               },
> +       },
> +};
> +
> +static struct clk_mem_branch ecpri_cc_eth_phy_3_ock_sram_clk = {
> +       .mem_enable_reg = 0x8410,
> +       .mem_ack_reg = 0x8424,
> +       .mem_enable_ack_mask = BIT(6),
> +       .branch = {
> +               .halt_reg = 0xd158,
> +               .halt_check = BRANCH_HALT,
> +               .clkr = {
> +                       .enable_reg = 0xd158,
> +                       .enable_mask = BIT(0),
> +                       .hw.init = &(const struct clk_init_data) {
> +                               .name = "ecpri_cc_eth_phy_3_ock_sram_clk",
> +                               .ops = &clk_branch2_mem_ops,
> +                       },
> +               },
> +       },
> +};
> +
> +static struct clk_mem_branch ecpri_cc_eth_phy_4_ock_sram_clk = {
> +       .mem_enable_reg = 0x8414,
> +       .mem_ack_reg = 0x8428,
> +       .mem_enable_ack_mask = BIT(6),
> +       .branch = {
> +               .halt_reg = 0xd160,
> +               .halt_check = BRANCH_HALT,
> +               .clkr = {
> +                       .enable_reg = 0xd160,
> +                       .enable_mask = BIT(0),
> +                       .hw.init = &(const struct clk_init_data) {
> +                               .name = "ecpri_cc_eth_phy_4_ock_sram_clk",
> +                               .ops = &clk_branch2_mem_ops,
> +                       },
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_mss_emac_clk = {
> +       .halt_reg = 0xe008,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xe008,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_mss_emac_clk",
> +                       .parent_hws = (const struct clk_hw*[]) {
> +                               &ecpri_cc_mss_emac_clk_src.clkr.hw,
> +                       },
> +                       .num_parents = 1,
> +                       .flags = CLK_SET_RATE_PARENT,
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_mss_oran_clk = {
> +       .halt_reg = 0xe004,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xe004,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_mss_oran_clk",
> +                       .parent_hws = (const struct clk_hw*[]) {
> +                               &ecpri_cc_ecpri_oran_clk_src.clkr.hw,
> +                       },
> +                       .num_parents = 1,
> +                       .flags = CLK_SET_RATE_PARENT,
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy0_lane0_rx_clk = {
> +       .halt_reg = 0xd000,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd000,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy0_lane0_rx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy0_lane0_tx_clk = {
> +       .halt_reg = 0xd050,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd050,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy0_lane0_tx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy0_lane1_rx_clk = {
> +       .halt_reg = 0xd004,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd004,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy0_lane1_rx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy0_lane1_tx_clk = {
> +       .halt_reg = 0xd054,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd054,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy0_lane1_tx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy0_lane2_rx_clk = {
> +       .halt_reg = 0xd008,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd008,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy0_lane2_rx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy0_lane2_tx_clk = {
> +       .halt_reg = 0xd058,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd058,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy0_lane2_tx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy0_lane3_rx_clk = {
> +       .halt_reg = 0xd00c,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd00c,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy0_lane3_rx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy0_lane3_tx_clk = {
> +       .halt_reg = 0xd05c,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd05c,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy0_lane3_tx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy1_lane0_rx_clk = {
> +       .halt_reg = 0xd010,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd010,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy1_lane0_rx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy1_lane0_tx_clk = {
> +       .halt_reg = 0xd060,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd060,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy1_lane0_tx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy1_lane1_rx_clk = {
> +       .halt_reg = 0xd014,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd014,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy1_lane1_rx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy1_lane1_tx_clk = {
> +       .halt_reg = 0xd064,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd064,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy1_lane1_tx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy1_lane2_rx_clk = {
> +       .halt_reg = 0xd018,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd018,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy1_lane2_rx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy1_lane2_tx_clk = {
> +       .halt_reg = 0xd068,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd068,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy1_lane2_tx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy1_lane3_rx_clk = {
> +       .halt_reg = 0xd01c,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd01c,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy1_lane3_rx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy1_lane3_tx_clk = {
> +       .halt_reg = 0xd06c,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd06c,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy1_lane3_tx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy2_lane0_rx_clk = {
> +       .halt_reg = 0xd020,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd020,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy2_lane0_rx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy2_lane0_tx_clk = {
> +       .halt_reg = 0xd070,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd070,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy2_lane0_tx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy2_lane1_rx_clk = {
> +       .halt_reg = 0xd024,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd024,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy2_lane1_rx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy2_lane1_tx_clk = {
> +       .halt_reg = 0xd074,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd074,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy2_lane1_tx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy2_lane2_rx_clk = {
> +       .halt_reg = 0xd028,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd028,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy2_lane2_rx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy2_lane2_tx_clk = {
> +       .halt_reg = 0xd078,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd078,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy2_lane2_tx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy2_lane3_rx_clk = {
> +       .halt_reg = 0xd02c,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd02c,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy2_lane3_rx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy2_lane3_tx_clk = {
> +       .halt_reg = 0xd07c,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd07c,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy2_lane3_tx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy3_lane0_rx_clk = {
> +       .halt_reg = 0xd030,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd030,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy3_lane0_rx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy3_lane0_tx_clk = {
> +       .halt_reg = 0xd080,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd080,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy3_lane0_tx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy3_lane1_rx_clk = {
> +       .halt_reg = 0xd034,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd034,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy3_lane1_rx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy3_lane1_tx_clk = {
> +       .halt_reg = 0xd084,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd084,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy3_lane1_tx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy3_lane2_rx_clk = {
> +       .halt_reg = 0xd038,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd038,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy3_lane2_rx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy3_lane2_tx_clk = {
> +       .halt_reg = 0xd088,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd088,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy3_lane2_tx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy3_lane3_rx_clk = {
> +       .halt_reg = 0xd03c,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd03c,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy3_lane3_rx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy3_lane3_tx_clk = {
> +       .halt_reg = 0xd08c,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd08c,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy3_lane3_tx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy4_lane0_rx_clk = {
> +       .halt_reg = 0xd040,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd040,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy4_lane0_rx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy4_lane0_tx_clk = {
> +       .halt_reg = 0xd090,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd090,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy4_lane0_tx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy4_lane1_rx_clk = {
> +       .halt_reg = 0xd044,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd044,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy4_lane1_rx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy4_lane1_tx_clk = {
> +       .halt_reg = 0xd094,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd094,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy4_lane1_tx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy4_lane2_rx_clk = {
> +       .halt_reg = 0xd048,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd048,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy4_lane2_rx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy4_lane2_tx_clk = {
> +       .halt_reg = 0xd098,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd098,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy4_lane2_tx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy4_lane3_rx_clk = {
> +       .halt_reg = 0xd04c,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd04c,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy4_lane3_rx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch ecpri_cc_phy4_lane3_tx_clk = {
> +       .halt_reg = 0xd09c,
> +       .halt_check = BRANCH_HALT,
> +       .clkr = {
> +               .enable_reg = 0xd09c,
> +               .enable_mask = BIT(0),
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "ecpri_cc_phy4_lane3_tx_clk",
> +                       .ops = &clk_branch2_ops,
> +               },
> +       },
> +};

[skipped]

> +static int ecpri_cc_qdu1000_probe(struct platform_device *pdev)
> +{
> +       struct regmap *regmap;
> +
> +       regmap = qcom_cc_map(pdev, &ecpri_cc_qdu1000_desc);
> +       if (IS_ERR(regmap))
> +               return PTR_ERR(regmap);
> +
> +       clk_lucid_evo_pll_configure(&ecpri_cc_pll0, regmap, &ecpri_cc_pll0_config);
> +       clk_lucid_evo_pll_configure(&ecpri_cc_pll1, regmap, &ecpri_cc_pll1_config);
> +
> +       return qcom_cc_really_probe(pdev, &ecpri_cc_qdu1000_desc, regmap);
> +}
> +
> +static struct platform_driver ecpri_cc_qdu1000_driver = {
> +       .probe = ecpri_cc_qdu1000_probe,
> +       .driver = {
> +               .name = "ecpri_cc-qdu1000",
> +               .of_match_table = ecpri_cc_qdu1000_match_table,
> +       },
> +};
> +
> +module_platform_driver(ecpri_cc_qdu1000_driver);
> +
> +MODULE_DESCRIPTION("QTI ECPRICC QDU1000 Driver");
> +MODULE_LICENSE("GPL");
> --
> 2.25.1
>


-- 
With best wishes
Dmitry
