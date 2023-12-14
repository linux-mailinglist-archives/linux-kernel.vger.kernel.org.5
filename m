Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFF08128D4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbjLNHMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjLNHMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:12:44 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD0C100
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:12:51 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5e3b9c14e46so1026857b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702537970; x=1703142770; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=93QX/jgZBqRf6fwN+rr8BYXawe/tGzkWINFxkuFYXG4=;
        b=dfzg5m5cRX7sJEbzHZkDU1RpFdYfhM9dqpHmaRCh9PD7VuxEib1ezVAoSwiaq6rreV
         sizhc+8uHaMbd+0784yyeK0ic77oeRl99O79Iyr34nKGtN5KMw2wWQDpqVoRC0l8RAG8
         /J9SVHewGzhyX3jNErvlN9OiRYGz4JKSmlJ8UtLZnoLHZR31VBPxJiwJme98bV3rYLkw
         LtOMIImPKnGyTwzKayLExy9OFzXFFUh2vU2PmR9nPBp/gxpGVfLFfXvROuoot4xz52LL
         A57MfkS+6SNteP8vkGj/bmdcs3SPCGHn1zpV8KZUUmTUghmqIzEQXv4iAzaZGNRuSsZA
         3Tkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702537970; x=1703142770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=93QX/jgZBqRf6fwN+rr8BYXawe/tGzkWINFxkuFYXG4=;
        b=XfJQZ25cQ8ccm/XIiyCeWMg1Fi033Fey54uSxNngC+oidLTNK0Uu4pZnLRAKqpbTpD
         xk9aHfB/+gsCXKZi4REA2SsIpIa/IqRab9drzigqFpkvKj9gJnxEs+Eq2AV9hsQURRX2
         0FIwJ3w7+y27XfMkBDOJDfr1hcJErQlXeBmw9rgFQRK2g4XEJpkJt4YMbZKbGJ6RxsJD
         DknEOsT443LBcKx41cvWM4X3AkKZyTWtiVqJ/eESFhxAhus+MXMAadLIyw4gDaJNuTg6
         mlf7UiPP6VNjLreIw7dadumBPCVyzMpEVSGAg7M3G1FG9I7owoANVsZiuSKaAjzYJpEZ
         cQFw==
X-Gm-Message-State: AOJu0YzGhKxyH3Pu3UavI5Uo69+lF/3Sgpi+fRYnkyfH5q2992ySnBUS
        JeeQSlz1a9irlSPmKMkuJ8jgPvGGQ07yjwrtXqdkhQ==
X-Google-Smtp-Source: AGHT+IGhCYJ6oqVzy6LbBhSToBcgh/7Ie6zjhhlYJRcHkOc+QFWGJAo1D/JpyUKQrMnIvCrzM0Nb9dc+JGLDE73Mp5g=
X-Received: by 2002:a81:49c8:0:b0:5de:93b6:7045 with SMTP id
 w191-20020a8149c8000000b005de93b67045mr8139176ywa.39.1702537970292; Wed, 13
 Dec 2023 23:12:50 -0800 (PST)
MIME-Version: 1.0
References: <20231214062847.2215542-1-quic_ipkumar@quicinc.com> <20231214062847.2215542-5-quic_ipkumar@quicinc.com>
In-Reply-To: <20231214062847.2215542-5-quic_ipkumar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 14 Dec 2023 09:12:39 +0200
Message-ID: <CAA8EJppV1UnC_Howfn1_4Ox-jftrRRF63QesFzqCSX+tC4c6FQ@mail.gmail.com>
Subject: Re: [PATCH 04/10] phy: qcom: Add support for Pipe clock rate from
 device data
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2023 at 08:29, Praveenkumar I <quic_ipkumar@quicinc.com> wrote:
>
> Qualcomm IPQ5332 has the same PCIe UNIPHY PHY with different pipe
> clock rate. Add support to define the pipe clock rate in device
> data.
>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>

With the name fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
> This patch depends on the below series which adds PCIe support in
> Qualcomm IPQ5018
> https://lore.kernel.org/all/20231003120846.28626-1-quic_nsekar@quicinc.com/
>
>  drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c b/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c
> index 5ef6ae7276cf..9f9a03faf6fa 100644
> --- a/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c
> @@ -54,6 +54,7 @@ struct uniphy_pcie_data {
>         unsigned int phy_type;
>         const struct uniphy_regs *init_seq;
>         unsigned int init_seq_num;
> +       unsigned int pipe_clk_rate;
>  };
>
>  struct qcom_uniphy_pcie {
> @@ -117,6 +118,7 @@ static const struct uniphy_pcie_data ipq5018_2x2_data = {
>         .phy_type       = PHY_TYPE_PCIE_GEN2,
>         .init_seq       = ipq5018_regs,
>         .init_seq_num   = ARRAY_SIZE(ipq5018_regs),
> +       .pipe_clk_rate  = 125000000,
>  };
>
>  static void qcom_uniphy_pcie_init(struct qcom_uniphy_pcie *phy)
> @@ -232,6 +234,7 @@ static int qcom_uniphy_pcie_get_resources(struct platform_device *pdev,
>  static int phy_pipe_clk_register(struct qcom_uniphy_pcie  *phy,
>                                  struct device_node *np)
>  {
> +       const struct uniphy_pcie_data *data = phy->data;
>         struct clk_fixed_rate *fixed;
>         struct clk_init_data init = { };
>         int ret;
> @@ -247,7 +250,7 @@ static int phy_pipe_clk_register(struct qcom_uniphy_pcie  *phy,
>                 return -ENOMEM;
>
>         init.ops = &clk_fixed_rate_ops;
> -       fixed->fixed_rate = 125000000;
> +       fixed->fixed_rate = data->pipe_clk_rate;
>         fixed->hw.init = &init;
>
>         ret = devm_clk_hw_register(phy->dev, &fixed->hw);
> --
> 2.34.1
>
>


-- 
With best wishes
Dmitry
