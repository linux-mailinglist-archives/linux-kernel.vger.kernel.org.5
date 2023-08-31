Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4303D78ECF6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 14:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345525AbjHaMWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 08:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240724AbjHaMWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:22:02 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143971A6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:21:55 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-58d31f142eeso8990297b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693484514; x=1694089314; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bwx8x4YtYezNUMgi8q+uTUrpHBYEE2Cu4KRHN4N06co=;
        b=iP8fheTS/32j0rX87XC3FfXVBW87D1H0lmG8rIZgCUOu+LQzQa0j5HBCQ/LciZI2QD
         EacHjbYnejhUqu/FgzTi6Qly70KikuhNj63p+EIi4ZuZp7bYb9eos9eKdkgAlIynJMOh
         ggw/MYAfgX4T0rvLaxVvPdpz+Lh7ot3+/GPeqPKqHI6njRcDAQ+F4BaD5l0pBsbcGtr7
         ghBHCZL4j3dO6wOQOZIT96LSj4nNopokqXajNZdAopeh1Zo4KQULrxNi9KONYOWrF1fz
         P7A2w/L09pXTclCZvCt3oztyJf4ImpJF9SLmrFfLXwHaeTl/ggNXiQwcbV641Kl+nvEw
         QKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693484514; x=1694089314;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bwx8x4YtYezNUMgi8q+uTUrpHBYEE2Cu4KRHN4N06co=;
        b=dwXGREB+nQHbeyjf9X2FigtllNLc+sD3JYZxWYnvR1IEJLWwLVAPVfMhNNZTeI4LEs
         bDQoJcfQXzJS8g7VAMgHNV1NFPsiXJdzz1yBXVOtPJIGmfpsfqfylYyQ6fjdA87NyNS/
         Y/QexlFNUFVUujcdFeD+xBo00W1f9+ZGrY1EZ4zPaq64+GxPjIdd++/fqjW1RN4kZDB6
         9P2xKb7PAt+laz94PrmRe/IwGvDdHYriaPgJ6u4b6kKYaEQEcV7hW8eSc3FkIqGNSYA/
         K8fR8rvOCC/zF/98tfRnBmg/OuVkoarmHn0X1CNRIlUsrcKxtsZ7uDvW+My3+/o8zxIu
         Iddg==
X-Gm-Message-State: AOJu0YyJMDYKqHT7qFHUxGsMp++p+OuhVKijQC7E7pUqcrqw/rnPATMz
        EYdiyGj43XK3YYarLypZfAhvT0wAV6FtWO0ObEqaPw==
X-Google-Smtp-Source: AGHT+IEo8NkEEu0Mba1RWLUMRB4w7afRpOH0sbqEazlACaU2jB+LyYPESyYrSiL6PqveSzE4onlwPh0ZMuVpwsJCsf0=
X-Received: by 2002:a25:dbd2:0:b0:d7b:a834:3b2c with SMTP id
 g201-20020a25dbd2000000b00d7ba8343b2cmr4698974ybf.1.1693484514213; Thu, 31
 Aug 2023 05:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230829135818.2219438-1-quic_ipkumar@quicinc.com>
 <20230829135818.2219438-9-quic_ipkumar@quicinc.com> <CAA8EJpqraO6UXBs=aPpWNuhEPjdcQ01FyV_Np1KtuJtEkJE0Hg@mail.gmail.com>
 <2ff8ef8e-c7d8-4a02-a764-ef2a3f83e87c@quicinc.com>
In-Reply-To: <2ff8ef8e-c7d8-4a02-a764-ef2a3f83e87c@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 31 Aug 2023 15:21:43 +0300
Message-ID: <CAA8EJpoFYeHFJ5SDaJJYUO09JO31dv8fnsG8207ginpe6mQ0ag@mail.gmail.com>
Subject: Re: [PATCH 8/9] phy: qcom: uniphy: Add ipq5332 USB UNIPHY support
To:     Praveenkumar I <quic_ipkumar@quicinc.com>
Cc:     robert.marko@sartura.hr, luka.perkov@sartura.hr, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, p.zabel@pengutronix.de, arnd@arndb.de,
        geert+renesas@glider.be, nfraprado@collabora.com, rafal@milecki.pl,
        peng.fan@nxp.com, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_varada@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 at 15:13, Praveenkumar I <quic_ipkumar@quicinc.com> wrote:
>
>
> On 8/29/2023 8:15 PM, Dmitry Baryshkov wrote:
>
> On Tue, 29 Aug 2023 at 17:00, Praveenkumar I <quic_ipkumar@quicinc.com> wrote:
>
> This patch adds ipq5332 USB SS UNIPHY support.
>
> First, please read to Documentation/process/submitting-patches.rst,
> then rewrite the commit message.
>
> Next, I tend to say that this driver doesn't have a lot in common with
> the ipq4019 driver you have modified. Please consider adding new
> driver for ipq5332, then we can see whether it makes sense to fold
> ipq4019 to use new infrastructure.
>
> Sure, will add new driver for IPQ5332 USB3 PHY. Thanks a lot for the review.

No HTML mail please. Ever. And use proper quotation. Thank you.

>
> --
> Thanks,
> Praveenkumar
>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> ---
> This patch depends on the below series which adds support for USB2 in
> IPQ5332
> https://lore.kernel.org/all/cover.1692699472.git.quic_varada@quicinc.com/
>
>  drivers/phy/qualcomm/phy-qcom-uniphy.c | 37 ++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-uniphy.c b/drivers/phy/qualcomm/phy-qcom-uniphy.c
> index eb71588f5417..91487e68bb6e 100644
> --- a/drivers/phy/qualcomm/phy-qcom-uniphy.c
> +++ b/drivers/phy/qualcomm/phy-qcom-uniphy.c
> @@ -26,6 +26,10 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
>
> +#define PCIE_USB_COMBO_PHY_CFG_MISC1           0x214
> +#define PCIE_USB_COMBO_PHY_CFG_RX_AFE_2                0x7C4
> +#define PCIE_USB_COMBO_PHY_CFG_RX_DLF_DEMUX_2  0x7E8
> +
>  struct uniphy_init_tbl {
>         unsigned int offset;
>         unsigned int val;
> @@ -37,6 +41,12 @@ struct uniphy_init_tbl {
>                 .val = v,               \
>         }
>
> +static const struct uniphy_init_tbl ipq5332_usb_ssphy_init_tbl[] = {
> +       UNIPHY_INIT_CFG(PCIE_USB_COMBO_PHY_CFG_RX_AFE_2, 0x1076),
> +       UNIPHY_INIT_CFG(PCIE_USB_COMBO_PHY_CFG_RX_DLF_DEMUX_2, 0x3142),
> +       UNIPHY_INIT_CFG(PCIE_USB_COMBO_PHY_CFG_MISC1, 0x3),
> +};
> +
>  struct uniphy_cfg {
>         const struct uniphy_init_tbl *init_seq;
>         int num_init_seq;
> @@ -83,6 +93,32 @@ static const struct uniphy_cfg ipq4019_usb_hsphy_cfg = {
>         .reset_udelay   = 10000,
>  };
>
> +static const char * const ipq5332_usb_ssphy_clk_l[] = {
> +       "phy_ahb", "phy_cfg_ahb", "pipe",
> +};
> +
> +static const char * const ipq5332_usb_ssphy_reset_l[] = {
> +       "por_rst",
> +};
> +
> +static const char * const ipq5332_usb_ssphy_vreg_l[] = {
> +       "vdda-phy",
> +};
> +
> +static const struct uniphy_cfg ipq5332_usb_ssphy_cfg = {
> +       .init_seq       = ipq5332_usb_ssphy_init_tbl,
> +       .num_init_seq   = ARRAY_SIZE(ipq5332_usb_ssphy_init_tbl),
> +       .clk_list       = ipq5332_usb_ssphy_clk_l,
> +       .num_clks       = ARRAY_SIZE(ipq5332_usb_ssphy_clk_l),
> +       .reset_list     = ipq5332_usb_ssphy_reset_l,
> +       .num_resets     = ARRAY_SIZE(ipq5332_usb_ssphy_reset_l),
> +       .vreg_list      = ipq5332_usb_ssphy_vreg_l,
> +       .num_vregs      = ARRAY_SIZE(ipq5332_usb_ssphy_vreg_l),
> +       .pipe_clk_rate  = 250000000,
> +       .reset_udelay   = 1,
> +       .autoload_udelay = 35,
> +};
> +
>  static int phy_mux_sel(struct phy *phy)
>  {
>         struct qcom_uniphy *uniphy = phy_get_drvdata(phy);
> @@ -396,6 +432,7 @@ static int qcom_uniphy_probe(struct platform_device *pdev)
>  static const struct of_device_id qcom_uniphy_of_match[] = {
>         { .compatible = "qcom,usb-hs-ipq4019-phy", .data = &ipq4019_usb_hsphy_cfg},
>         { .compatible = "qcom,usb-ss-ipq4019-phy", .data = &ipq4019_usb_ssphy_cfg},
> +       { .compatible = "qcom,ipq5332-usb-ssphy", .data = &ipq5332_usb_ssphy_cfg},
>         { },
>  };
>  MODULE_DEVICE_TABLE(of, qcom_uniphy_of_match);
> --
> 2.34.1
>


-- 
With best wishes
Dmitry
