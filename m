Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49317903BC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 00:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349974AbjIAWuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 18:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345537AbjIAWuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 18:50:04 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6C02115
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 14:50:12 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d7260fae148so2042708276.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 14:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693605011; x=1694209811; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lA/gYj4G9dBVeXUfikZ7kSFesNkiwy9bpcMTmp53A5g=;
        b=Df9m0Zb0XoB4vJn0lpjDR/qkENwptWimLSJ4AY5Rmbt7PAHxmeIivyRbLYSDT1g4tV
         QW50GwFZ/wRqop9ReuCUdo/ewoGQGPJ3s65AZpjNAh9+a+RYoJ/ZcRFiTuf2dzveENbZ
         Wy26uhiAfzMAp9+Q0TVK1x4GKdCmnkWkI4bOmcUDTrtKQLyBUFejl1ibCy1LQQ40l3On
         075O8kIws/ebJXupO5S3BCVrbJt4yXiUunidFB54Otm7Iq65OwOccZNIZvO5ISRYH6mf
         x+890tG/k060/SJDtybsAQTehuTCdYII7Ulp7MVp9tCuKkSAhkHbBGSWF1gsfdbXddp6
         EKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693605011; x=1694209811;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lA/gYj4G9dBVeXUfikZ7kSFesNkiwy9bpcMTmp53A5g=;
        b=EeCRB8/WPik8UkqQ2AXxmU+LFWQDIO+O4UKM5AvQAfbcMh7g5svO33N8SX3TqRnHI0
         QEY5oOzndeGadn+3arUsgkfn3PQuyppF+UQUZvWZ2f1Vq5Bof3wLVVL94sLoDMHBST9a
         sET9LvATkMzRqtsTmyqkmEcAGou2kqxY7UlUDai4OtrWy/87P65lvg6QzNKWwr9gnr+1
         jJl+i5qmtwy/uoKghZWnvJJ1hInoSAEzSnbWWFunYMIYtqbXFZX/Kx/JKFMTdNaF8olq
         RcQMZvgOg09LU6VaLw4GtwPuAlmsLTdkTczqcuiR8tDs2KbNep0+WnFZ0TVWjPbXJkaw
         4HqA==
X-Gm-Message-State: AOJu0YwOGdytPP3AxzexbqchujED2xzomfFI+7toD2EYwcYjnkljJRku
        qLR5TtOie9pT1BZLlI6m9dG/HgzxSAqXYx9hZGZ8Fg==
X-Google-Smtp-Source: AGHT+IFAIw3fZY5uif8FGyQUm6GVIBe/G3nd55d0OfG3nGHm9snPjGrA8RAKabs/WWggVm9iSiyma2/CBVv19LYToSA=
X-Received: by 2002:a25:348b:0:b0:d78:1311:aa1b with SMTP id
 b133-20020a25348b000000b00d781311aa1bmr4040638yba.48.1693605011562; Fri, 01
 Sep 2023 14:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230901092645.20522-1-quic_nsekar@quicinc.com> <20230901092645.20522-3-quic_nsekar@quicinc.com>
In-Reply-To: <20230901092645.20522-3-quic_nsekar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 2 Sep 2023 00:50:00 +0300
Message-ID: <CAA8EJppej++gbrWrRU9EFBntjzck4-9xbgS_sCPBfcxEofUo3Q@mail.gmail.com>
Subject: Re: [PATCH V3 2/4] phy: qcom-m31: Add compatible, phy init sequence
 for IPQ5018
To:     Nitheesh Sekar <quic_nsekar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, quic_srichara@quicinc.com,
        quic_varada@quicinc.com, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sept 2023 at 12:27, Nitheesh Sekar <quic_nsekar@quicinc.com> wrote:
>
> Add phy init sequence and compatible string for IPQ5018
> chipset.
>
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> ---
> V3:
>         Dropped 0 delay inits.
>         Added static const type for m31_ipq5018_regs.
> V2:
>         Updated the commit message.
> ---
>  drivers/phy/qualcomm/phy-qcom-m31.c | 49 +++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-m31.c b/drivers/phy/qualcomm/phy-qcom-m31.c
> index ed08072ca032..ceee38695d7d 100644
> --- a/drivers/phy/qualcomm/phy-qcom-m31.c
> +++ b/drivers/phy/qualcomm/phy-qcom-m31.c
> @@ -82,6 +82,48 @@ struct m31_priv_data {
>         unsigned int                    nregs;
>  };
>
> +static const struct m31_phy_regs m31_ipq5018_regs[] = {
> +       {

C99 initializers, please?

> +               USB_PHY_CFG0,
> +               UTMI_PHY_OVERRIDE_EN
> +       },
> +       {
> +               USB_PHY_UTMI_CTRL5,
> +               POR_EN,
> +               15
> +       },
> +       {
> +               USB_PHY_FSEL_SEL,
> +               FREQ_SEL
> +       },
> +       {
> +               USB_PHY_HS_PHY_CTRL_COMMON0,
> +               COMMONONN | FSEL | RETENABLEN
> +       },
> +       {
> +               USB_PHY_REFCLK_CTRL,
> +               CLKCORE
> +       },
> +       {
> +               USB_PHY_UTMI_CTRL5,
> +               POR_EN
> +       },
> +       {
> +               USB_PHY_HS_PHY_CTRL2,
> +               USB2_SUSPEND_N_SEL | USB2_SUSPEND_N | USB2_UTMI_CLK_EN
> +       },
> +       {
> +               USB_PHY_UTMI_CTRL5
> +       },
> +       {
> +               USB_PHY_HS_PHY_CTRL2,
> +               USB2_SUSPEND_N | USB2_UTMI_CLK_EN
> +       },
> +       {
> +               USB_PHY_CFG0

What is the value written? While it didn't make sense to write 0
delays, it is sensible to write 0 register values here.

> +       },
> +};
> +
>  struct m31_phy_regs m31_ipq5332_regs[] = {
>         {
>                 USB_PHY_CFG0,
> @@ -268,6 +310,12 @@ static int m31usb_phy_probe(struct platform_device *pdev)
>         return PTR_ERR_OR_ZERO(phy_provider);
>  }
>
> +static const struct m31_priv_data m31_ipq5018_data = {
> +       .ulpi_mode = false,
> +       .regs = m31_ipq5018_regs,
> +       .nregs = ARRAY_SIZE(m31_ipq5018_regs),
> +};
> +
>  static const struct m31_priv_data m31_ipq5332_data = {
>         .ulpi_mode = false,
>         .regs = m31_ipq5332_regs,
> @@ -275,6 +323,7 @@ static const struct m31_priv_data m31_ipq5332_data = {
>  };
>
>  static const struct of_device_id m31usb_phy_id_table[] = {
> +       { .compatible = "qcom,ipq5018-usb-hsphy", .data = &m31_ipq5018_data },
>         { .compatible = "qcom,ipq5332-usb-hsphy", .data = &m31_ipq5332_data },
>         { },
>  };
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>


-- 
With best wishes
Dmitry
