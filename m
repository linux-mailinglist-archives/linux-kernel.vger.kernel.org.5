Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274B27B6CEB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjJCPUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjJCPUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:20:05 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858DDAF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 08:20:02 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d849df4f1ffso1141061276.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 08:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696346401; x=1696951201; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J9n7qJH5dKjKjDWMds6U5WZJV1JGy3FQs/DoOpcjJEw=;
        b=fFQF0jkbn7DKjchBzN3FTOYcPOY0MEy2MpkeqN1hl95gciUl3nP29yReXqmjM0xKl8
         yFabwr1lo6ypLc5uKzWmbEjLU5UvL1b4eC3l9TNefvY0tAU1LObsLm7/JhCNRaUBNipA
         hvvIR8gah8NeOytW20Lgd/jLDtjbAq/AbhvyLi53TrCkkrxtoD9HWNWv5TzUzJwWXt1k
         YpsQGB7Gb3D61onie4hmRWwL88gH7gy1T0w6xHkzI3bHdIz5hw61RdOP36H+W2zrUjsn
         v0elWjdY3Ltt9dVcUSblFJqXetUxzn7dPeIj0YLAYaGAmkPFapsZRwSdRwcl3vsmyju6
         1Tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696346401; x=1696951201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J9n7qJH5dKjKjDWMds6U5WZJV1JGy3FQs/DoOpcjJEw=;
        b=kzJXtfupfxSvLpol3U0LdZjn+nISR4wjTEmh2V/wY1f5Zyq4xhf6QhkjjQLDBCox9o
         sQXFa23hiy7Uajth4/lPYvTtRAQMZ7oChpXcrLxBVPk05SFsUclGzdKwfbsEZaIy6gwy
         ENFoyRvflOoddJ7lZ31lH1GJyOEOtinynnBIyfOoqQHsQ++XhVsAVCRN3nQVKzxEFMYU
         MZBG5Cww0Ku49JUtxjLzXarwCsC8VVHjWdhPnj4ncdP2aHIiyZ9VV6LKMlgERSO6c5Rl
         cFy0wLkUKMcOmL/zk1EOryFCr4yl2TGzYe5zOygML++gtecFw/DGRD+wiSKb1uawVxRd
         4/JQ==
X-Gm-Message-State: AOJu0YydfkS+TZqJdChZg2B2jz2oPlMfG7mxP6BHPGjVrX7OrelJo+4X
        gOxE/SEfoai7F0JatcCjjXZ8avxehahq/SANt6zSxQ==
X-Google-Smtp-Source: AGHT+IHylk+ABoXP1gkWE01a+0EpIeQSeiPnSh4yQB5nw6TcBeX1Cvei99wpL6PTinUs/7vO4T3ns4RM4Rw5j2VOiwE=
X-Received: by 2002:a25:86cf:0:b0:d62:9b77:a41a with SMTP id
 y15-20020a2586cf000000b00d629b77a41amr13626504ybm.31.1696346401567; Tue, 03
 Oct 2023 08:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231003120846.28626-1-quic_nsekar@quicinc.com> <20231003120846.28626-5-quic_nsekar@quicinc.com>
In-Reply-To: <20231003120846.28626-5-quic_nsekar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 3 Oct 2023 18:19:50 +0300
Message-ID: <CAA8EJpqbBRGEQ7ZFsngwivkovycOt97SU1Pge7JEHhCs+aQe=Q@mail.gmail.com>
Subject: Re: [PATCH 4/6] PCI: qcom: Add support for IPQ5018
To:     Nitheesh Sekar <quic_nsekar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        mani@kernel.org, p.zabel@pengutronix.de, quic_srichara@quicinc.com,
        quic_varada@quicinc.com, quic_ipkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Anusha Rao <quic_anusha@quicinc.com>,
        Devi Priya <quic_devipriy@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2023 at 15:10, Nitheesh Sekar <quic_nsekar@quicinc.com> wrote:
>
> Added a new compatible 'qcom,pcie-ipq5018' and modified
> get_resources of 'ops 2_9_0' to get the clocks from the
> device-tree.
>
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Co-developed-by: Devi Priya <quic_devipriy@quicinc.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index e2f29404c84e..bb0717190920 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -197,10 +197,10 @@ struct qcom_pcie_resources_2_7_0 {
>         struct reset_control *rst;
>  };
>
> -#define QCOM_PCIE_2_9_0_MAX_CLOCKS             5
>  struct qcom_pcie_resources_2_9_0 {
> -       struct clk_bulk_data clks[QCOM_PCIE_2_9_0_MAX_CLOCKS];
> +       struct clk_bulk_data *clks;
>         struct reset_control *rst;
> +       int num_clks;
>  };
>
>  union qcom_pcie_resources {
> @@ -1048,17 +1048,10 @@ static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
>         struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
>         struct dw_pcie *pci = pcie->pci;
>         struct device *dev = pci->dev;
> -       int ret;
>
> -       res->clks[0].id = "iface";
> -       res->clks[1].id = "axi_m";
> -       res->clks[2].id = "axi_s";
> -       res->clks[3].id = "axi_bridge";
> -       res->clks[4].id = "rchng";
> -
> -       ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);

Changing this to devm_clk_bulk_get_optional would be easier and will
follow the design of the driver.

> -       if (ret < 0)
> -               return ret;
> +       res->num_clks = devm_clk_bulk_get_all(dev, &res->clks);
> +       if (res->num_clks < 0)
> +               return res->num_clks;
>
>         res->rst = devm_reset_control_array_get_exclusive(dev);
>         if (IS_ERR(res->rst))
> @@ -1071,7 +1064,7 @@ static void qcom_pcie_deinit_2_9_0(struct qcom_pcie *pcie)
>  {
>         struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
>
> -       clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
> +       clk_bulk_disable_unprepare(res->num_clks, res->clks);
>  }
>
>  static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
> @@ -1100,7 +1093,7 @@ static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
>
>         usleep_range(2000, 2500);
>
> -       return clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
> +       return clk_bulk_prepare_enable(res->num_clks, res->clks);
>  }
>
>  static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
> @@ -1605,6 +1598,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>         { .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
>         { .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
>         { .compatible = "qcom,pcie-ipq4019", .data = &cfg_2_4_0 },
> +       { .compatible = "qcom,pcie-ipq5018", .data = &cfg_2_9_0 },
>         { .compatible = "qcom,pcie-ipq6018", .data = &cfg_2_9_0 },
>         { .compatible = "qcom,pcie-ipq8064", .data = &cfg_2_1_0 },
>         { .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
> --
> 2.17.1
>


-- 
With best wishes
Dmitry
