Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934258128CF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbjLNHMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjLNHMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:12:14 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D53100
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:12:19 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-db3fa47c2f7so8006667276.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702537939; x=1703142739; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BeQY4H3SvQ0wdp8LNZJHZHNl8zWKZa5eAoAO6u6SBqw=;
        b=yfQBWOAGBpJrLDiYeJiIU4q81B+ykK4WOAl4O+IlfvroT7Oz7u8Cj+lfvZ2LyMVggu
         bQHbGlY7Tl+0pq8js5jLCIgF9oSQvUTVltU3kWvTquUBzFl2Dsr3LdnBOYkVixZhPGC9
         pWFR0xJ4tSmxBavtrlJfhhNReGPBsJNLLxcr+hn98HmHKAYnHB/RYm54ya8beerh3I1B
         d4FuXkqXHCmazyu3+wTONk84c9AtBkvUxFxxNmwsSRLtNqE/XpkK1ZOQaz5Vvugtb+EM
         17J9TD/chFmOYqlpkAaf4nbPh9somuTTc9AXi8c3sGdfYO2cvB11Cq3VwGL1X1BPHzTD
         BnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702537939; x=1703142739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BeQY4H3SvQ0wdp8LNZJHZHNl8zWKZa5eAoAO6u6SBqw=;
        b=Bq66+CWS4MtmHonIOD9VtsY50e2LNtpTlm20cAboikwKCQRWTVYWKA0LxuZ1lIhoQD
         M3FBrlRniTJSkgH/ingufSB4gz7m0UuTJ9QZ/+V6gy1GDI/beI7BYjzM8TOQnL6cdZam
         ic4wlAo7Qmjmn44VxGTogkQiCCPQ3VbKaqgEURn5aVG3RMrHwJcLiVzc+uueHDawJYJ8
         Z9NLtGfU7UfIX4KLh6O9+ENkJGBLkkQt5XfBRQb+WLjzGVoXhTm4x0E6TcBzIba4Xj1t
         lR+3YHmx/9dR4ImFb/89pBgVsLprjAKKm+CoYZ+Bg7doEKcFHGUf+gr4GzteClvZHqvN
         I/Fg==
X-Gm-Message-State: AOJu0YztKG2xiscCKNnLe69c2lzdyj3K1GFvfHFqhTM88wI5nuHKCvcR
        jiob1N+fJ/lBlxE0LN+0l4fUVRSzYGv/2HsYTB4W7A==
X-Google-Smtp-Source: AGHT+IH29F7oDPcW96XqPra5HyXoBDO1YudpygTc5FlbxagbsYbyzPBTWsjhToTqAubKvWeBHVd6Jk+uBDLmOzLIaqk=
X-Received: by 2002:a0d:ca84:0:b0:5e2:8d1d:e323 with SMTP id
 m126-20020a0dca84000000b005e28d1de323mr2294917ywd.41.1702537939001; Wed, 13
 Dec 2023 23:12:19 -0800 (PST)
MIME-Version: 1.0
References: <20231214062847.2215542-1-quic_ipkumar@quicinc.com> <20231214062847.2215542-7-quic_ipkumar@quicinc.com>
In-Reply-To: <20231214062847.2215542-7-quic_ipkumar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 14 Dec 2023 09:12:08 +0200
Message-ID: <CAA8EJppSXeV9LSv8VAwYSP9nDzq+uHTvbiEzD4PebEHoOJySNg@mail.gmail.com>
Subject: Re: [PATCH 06/10] phy: qcom: ipq5332: Add support for g3x1 and g3x2
 PCIe PHYs
To:     Praveenkumar I <quic_ipkumar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
        vkoul@kernel.org, kishon@kernel.org, mani@kernel.org,
        quic_nsekar@quicinc.com, quic_srichara@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        quic_varada@quicinc.com, quic_devipriy@quicinc.com,
        quic_kathirav@quicinc.com, quic_anusha@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2023 at 08:30, Praveenkumar I <quic_ipkumar@quicinc.com> wrote:
>
> Add support for single-lane and dual-lane PCIe UNIPHY found on
> Qualcomm IPQ5332 platform. This UNIPHY is similar to the one
> present in Qualcomm IPQ5018.
>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> ---
> This patch depends on the below series which adds PCIe support in
> Qualcomm IPQ5018
> https://lore.kernel.org/all/20231003120846.28626-1-quic_nsekar@quicinc.com/
>
>  .../phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c  | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c b/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c
> index 9f9a03faf6fa..aa71b85eb50e 100644
> --- a/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c
> @@ -34,6 +34,10 @@
>  #define SSCG_CTRL_REG_6                0xb0
>  #define PCS_INTERNAL_CONTROL_2 0x2d8
>
> +#define PHY_CFG_PLLCFG                         0x220
> +#define PHY_CFG_EIOS_DTCT_REG                  0x3e4
> +#define PHY_CFG_GEN3_ALIGN_HOLDOFF_TIME                0x3e8
> +
>  #define PHY_MODE_FIXED         0x1
>
>  enum qcom_uniphy_pcie_type {
> @@ -112,6 +116,21 @@ static const struct uniphy_regs ipq5018_regs[] = {
>         },
>  };
>
> +static const struct uniphy_regs ipq5332_regs[] = {
> +       {
> +               .offset = PHY_CFG_PLLCFG,
> +               .val = 0x30,
> +       },
> +       {
> +               .offset = PHY_CFG_EIOS_DTCT_REG,
> +               .val = 0x53ef,
> +       },
> +       {
> +               .offset = PHY_CFG_GEN3_ALIGN_HOLDOFF_TIME,
> +               .val = 0xCf,
> +       },
> +};
> +
>  static const struct uniphy_pcie_data ipq5018_2x2_data = {
>         .lanes          = 2,
>         .lane_offset    = 0x800,
> @@ -121,6 +140,23 @@ static const struct uniphy_pcie_data ipq5018_2x2_data = {
>         .pipe_clk_rate  = 125000000,
>  };
>
> +static const struct uniphy_pcie_data ipq5332_x2_data = {
> +       .lanes          = 2,
> +       .lane_offset    = 0x800,
> +       .phy_type       = PHY_TYPE_PCIE_GEN3,
> +       .init_seq       = ipq5332_regs,
> +       .init_seq_num   = ARRAY_SIZE(ipq5332_regs),
> +       .pipe_clk_rate  = 250000000,
> +};
> +
> +static const struct uniphy_pcie_data ipq5332_x1_data = {
> +       .lanes          = 1,
> +       .phy_type       = PHY_TYPE_PCIE_GEN3,
> +       .init_seq       = ipq5332_regs,
> +       .init_seq_num   = ARRAY_SIZE(ipq5332_regs),
> +       .pipe_clk_rate  = 250000000,
> +};

Please keep structs sorted out.

> +
>  static void qcom_uniphy_pcie_init(struct qcom_uniphy_pcie *phy)
>  {
>         const struct uniphy_pcie_data *data = phy->data;
> @@ -270,6 +306,14 @@ static const struct of_device_id qcom_uniphy_pcie_id_table[] = {
>                 .compatible = "qcom,ipq5018-uniphy-pcie-gen2x2",
>                 .data = &ipq5018_2x2_data,
>         },
> +       {
> +               .compatible = "qcom,ipq5332-uniphy-pcie-gen3x2",
> +               .data = &ipq5332_x2_data,
> +       },
> +       {
> +               .compatible = "qcom,ipq5332-uniphy-pcie-gen3x1",
> +               .data = &ipq5332_x1_data,

The entries here should be sorted out.

> +       },
>         { /* Sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, qcom_uniphy_pcie_id_table);
> --
> 2.34.1
>
>


-- 
With best wishes
Dmitry
