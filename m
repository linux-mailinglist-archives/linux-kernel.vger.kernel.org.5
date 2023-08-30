Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEBF78E09E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237304AbjH3U1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239068AbjH3U1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:27:38 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C374B03
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:24:49 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6bcac140aaaso178326a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693427009; x=1694031809; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aJIb62bEI+abOZ0+u4aCxcyg1D1ywbkZPjZNGK2GZY0=;
        b=Y+vVUFVXuPTRKH9+KGJtFvPMhLlmUtk1DfF3Z++Spiy3MmRzKszw5mFb7eJZCenXze
         URpo+T/e6sz6gkpRLlp8IaDC/3vGe68V0YtGZk+5LG42RS+1yGfAKrAzkJITwweTNwid
         bFoAXOnjsFHev96QV6Oo+wtQLVqYTrxv01eASSSakOg1EjgUhBFuQZJoX2xjI+YDCjHS
         ek3CfTeM4EMEkXw7t+S/hi+tbZ7kaRJLlGkCTzcRa3rAjXXfe5SQGhKv2tT38S9dslp5
         nGHQhtBul/Wy92G75RHbWMR2X3LMij0RUtq4H4uYyllAwpmo8vXq1EhpChjRDtbmlLM1
         yVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693427009; x=1694031809;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJIb62bEI+abOZ0+u4aCxcyg1D1ywbkZPjZNGK2GZY0=;
        b=MP0O8veXPyag298CeId2wFAWkOSFBy3blPl4VA+DlnwTqubGsy5PE/D4bMS+Ei8Usn
         zSati/J84RARtmSmQoTe3nYLN2Lo1128c20h0Ueas1DwY1TyIt0Gr8Q9ej9rRE1OLw0d
         MlrC+qw2ATonPf+QGByqV9w70ZU0Ezj2lMs2S8O/Ms/lh0/rdPpwf7lgE8/IfP3H+4id
         iFvKAnaOdAtdhU9smZQGQzRRAwGTgAr5E+8W3L85M+zhM7soLbPOEjGM7PVMoNWgnqS/
         tZI7HO93JuPw6AqlWQd02HuiqvvacAuHAkBRPtGHNQZZjoPXh+/wHfV8kh5M2Ll8CHie
         MjaQ==
X-Gm-Message-State: AOJu0YyhMBH+rtN8pQ6sm0vZVavJWcmz1k2qpW2SiacAOIbHsbdX7WCP
        2s7Odb3oGKfEE2A6FMcItQyBQC86SbqyBmZPZlqT1trHwk+drqFs
X-Google-Smtp-Source: AGHT+IGZVwnuEqzyqkBgaq+ePEab/gUlpPuMtKnej5Gso+diHBC4efLmP1AVk+hUUq9mcyqV6DF3d9cFfKSKASs5OEo=
X-Received: by 2002:a25:b06:0:b0:d78:26a0:ab8b with SMTP id
 6-20020a250b06000000b00d7826a0ab8bmr3151567ybl.55.1693426180516; Wed, 30 Aug
 2023 13:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230830111722.19380-1-quic_nsekar@quicinc.com> <20230830111722.19380-3-quic_nsekar@quicinc.com>
In-Reply-To: <20230830111722.19380-3-quic_nsekar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 30 Aug 2023 23:09:29 +0300
Message-ID: <CAA8EJpohi35ic7Lwb29cz17n2gLqxWQ2WUAQfkBSvX3wkOHaEA@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] phy: qcom-m31: Add compatible, phy init sequence
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2023 at 21:32, Nitheesh Sekar <quic_nsekar@quicinc.com> wrote:
>
> Add phy init sequence and compatible string for IPQ5018
> chipset.
>
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> ---
> V2:
>         Updated the commit message.
> ---
>  drivers/phy/qualcomm/phy-qcom-m31.c | 60 +++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-m31.c b/drivers/phy/qualcomm/phy-qcom-m31.c
> index ed08072ca032..81b72ebde305 100644
> --- a/drivers/phy/qualcomm/phy-qcom-m31.c
> +++ b/drivers/phy/qualcomm/phy-qcom-m31.c
> @@ -82,6 +82,59 @@ struct m31_priv_data {
>         unsigned int                    nregs;
>  };
>
> +struct m31_phy_regs m31_ipq5018_regs[] = {
> +       {
> +               USB_PHY_CFG0,
> +               UTMI_PHY_OVERRIDE_EN,
> +               0
> +       },

c99 initialisers? And maybe drop the 0 delay inits.

> +       {
> +               USB_PHY_UTMI_CTRL5,
> +               POR_EN,
> +               15
> +       },
> +       {
> +               USB_PHY_FSEL_SEL,
> +               FREQ_SEL,
> +               0
> +       },
> +       {
> +               USB_PHY_HS_PHY_CTRL_COMMON0,
> +               COMMONONN | FSEL | RETENABLEN,
> +               0
> +       },
> +       {
> +               USB_PHY_REFCLK_CTRL,
> +               CLKCORE,
> +               0
> +       },
> +       {
> +               USB_PHY_UTMI_CTRL5,
> +               POR_EN,
> +               0
> +       },
> +       {
> +               USB_PHY_HS_PHY_CTRL2,
> +               USB2_SUSPEND_N_SEL | USB2_SUSPEND_N | USB2_UTMI_CLK_EN,
> +               0
> +       },
> +       {
> +               USB_PHY_UTMI_CTRL5,
> +               0x0,
> +               0
> +       },
> +       {
> +               USB_PHY_HS_PHY_CTRL2,
> +               USB2_SUSPEND_N | USB2_UTMI_CLK_EN,
> +               0
> +       },
> +       {
> +               USB_PHY_CFG0,
> +               0x0,
> +               0
> +       },
> +};
> +
>  struct m31_phy_regs m31_ipq5332_regs[] = {
>         {
>                 USB_PHY_CFG0,
> @@ -268,6 +321,12 @@ static int m31usb_phy_probe(struct platform_device *pdev)
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
> @@ -275,6 +334,7 @@ static const struct m31_priv_data m31_ipq5332_data = {
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
