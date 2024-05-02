Return-Path: <linux-kernel+bounces-166491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C29DF8B9B60
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C5821F2108E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D816283CD7;
	Thu,  2 May 2024 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pq0FcFFd"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4A643158
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714655553; cv=none; b=ddtwLebziprOWeP4MljCo2HesfK6xy/jIe5ARtLUASyrAa5AMGFkK1WagAprl+ODdxHDPtZOBujV4u9WmQZPgSZHzA0AXmYYxiF/lDGatOFhBedyHbv4BzEIm155IYcdv34JGK5y2RzZm2NH41IaM2wA1IpO5BY322OnlOIedNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714655553; c=relaxed/simple;
	bh=w36A9qNTkHew7BT2vRvvyNspByFD2CNRYwskOpKFMNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5dTkK+KM6K3Hjb5AMj4ugmf0Rf8L0iocRDXOQ8KQtttOt1U+ZumGy4Jcksl7Wn7UIutzfWD3sz7/DrCNiKo+jx8PU1+uGkDE4Qv3CQp/M0LaIGQ5aRc7aAD8eRce9KKqMcYMkP1KB3AmHK/ezEtJY81NMbd853dLwe5sSwvK2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pq0FcFFd; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-ddda842c399so8146524276.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 06:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714655551; x=1715260351; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e9IfF2XRrC1/or05aEZt3Pgg1CS/l8eHWqh1tFVKZN4=;
        b=pq0FcFFdFyslHFHmW4iDwTqhNMjI0Wh4AibrlCf4ipmtVjIjnYVOtFEx6iTp/NHEUT
         aDweGprtPI6uW1sFtvp9lL1iWFibsYbLvZF8d1rkGCTwF5UwpqB5EaUv6Z8K91HJdd6T
         WsNfJ8lZKuHcX1EVeYLgQsAxyltsXipHtgW3hFiBe2esvPEw39UbzopxfT+NAyfRt1Wf
         LKEQQyYtdCdrITo8RIreOGb1qzRE5ev4YZDz7TnodKFOFKz6luibL7eoEcNt9FUBF5oH
         qItPSV7p8nnPY6VM88twrhz3mDUB0+F80g+zqDnSZbEEcbvChgxhGdow+iwFeZAdQd9b
         4+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714655551; x=1715260351;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e9IfF2XRrC1/or05aEZt3Pgg1CS/l8eHWqh1tFVKZN4=;
        b=TxJGUenC1rgeXSzKwPGG/BXp9trjbN+jXUG/3pxAyesztFp5U9wzluakQt70Py1paW
         dcLAEn23G3ARZAa27kB/TsHjqfOU5stdg4K/DYG+D1yE+8rg0B2W/HWEXRh5WSCXRQ7Y
         mIQsOA554s+9bvnUSyj3542z+dJH3QuSUXHqSuGtyHikw1TfeWcS727WI6qStAqEW8rS
         ovpjmeL8+K1cjCLPCaDGjy8cTvqLWkZ+Z/WVrvacFmcqVENUpsDRceYsdUSEfDIvdHtX
         E25L83IGZUZillosrpJ6vDzKZ4YIAQzmiWANRLMKw3Bj9xdInu48N+64LStlygvNahV1
         UwEw==
X-Forwarded-Encrypted: i=1; AJvYcCXb1OlGS8Wqefiica2mk494fVox5iQC6IxW24KUm9n+12I4MLiHt87BKeeoGBYafgPQgJjCbVQBa0u6joOk0iKFhDVok3wjfJ5Ei1p5
X-Gm-Message-State: AOJu0YzFs4H7++cbG803y7Xe3rgchx1k61nAPk0AbYTX7Oqt+36MUB1f
	OvRvWccq6HvTZIk7S2BAH+zOKWdBh2U0aBCAF1f4YzR5F97PbAzMzXIQg3w9Ojf8V/ZNAAlJaww
	K3TaYLnI+20cT4UG6BWBCUM1Kng91ORWaY9qwoA==
X-Google-Smtp-Source: AGHT+IEmkdUGj5jxW8y/dVl1d+EP/OPmo0I1J+BrgLeQOzwiCRVJgZVKxM+VVh8ViBEG0rKvwXQFvcvTYJR/P/usunM=
X-Received: by 2002:a25:db8e:0:b0:dca:a3e8:a25a with SMTP id
 g136-20020a25db8e000000b00dcaa3e8a25amr2216795ybf.62.1714655551232; Thu, 02
 May 2024 06:12:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502123312.31083-1-quic_ugoswami@quicinc.com>
In-Reply-To: <20240502123312.31083-1-quic_ugoswami@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 2 May 2024 16:12:20 +0300
Message-ID: <CAA8EJppeQTadmny=hcs4xCQDXHwXEBHXjeecvZCUVcSXmwBTgg@mail.gmail.com>
Subject: Re: [PATCH] phy: qcom-snps-femto-v2: Add load and voltage setting for
 LDO's used
To: Udipto Goswami <quic_ugoswami@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 May 2024 at 15:33, Udipto Goswami <quic_ugoswami@quicinc.com> wrote:
>
> The Femto phy depends on 0.88/ 1.8/ 3.3V regulators for its operation.
> If one of the regulators is not voted to the required minimum voltage
> for phy to operate, then High speed mode of operation will fail.
>
> On certain targets like (qcm6490_rb3gen2) where the minimum voltage
> of the regulator is lower than the operating voltage of the phy.
> If not voted properly, the phy supply would be limited to the min value
> of the LDO thereby rendering the phy non-operational.
>
> The current implementation of the regulators in the Femto PHY is not
> setting the load and voltage for each LDO. The appropriate voltages and
> loads required for the PHY to operate should be set.

Please move min/max voltages to the DTS. There is no need to set them
from the driver.

Also, is there any reason why you can't use `regulator-initial-mode =
<RPMH_REGULATOR_MODE_HPM>;` like other boards do?

>
> Implement a bulk operation api to set load & voltages before doing bulk
> enable. This will ensure that the PHY remains operational under all
> conditions.
>
> Signed-off-by: Udipto Goswami <quic_ugoswami@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c | 121 +++++++++++++++++-
>  1 file changed, 114 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
> index eb0b0f61d98e..cbe9cdaa6849 100644
> --- a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
> +++ b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
> @@ -78,11 +78,39 @@
>
>  #define LS_FS_OUTPUT_IMPEDANCE_MASK            GENMASK(3, 0)
>
> -static const char * const qcom_snps_hsphy_vreg_names[] = {
> -       "vdda-pll", "vdda33", "vdda18",
> +
> +struct qcom_snps_hsphy_regulator_data {
> +       const char *name;
> +       unsigned int enable_load;
> +       unsigned int min_voltage;
> +       unsigned int max_voltage;
> +};
> +
> +static const struct qcom_snps_hsphy_regulator_data hsphy_vreg_l[] = {
> +       {
> +               .name = "vdda-pll",
> +               .enable_load = 30000,
> +               .min_voltage = 825000,
> +               .max_voltage = 925000,
> +       },
> +
> +       {
> +               .name = "vdda18",
> +               .enable_load = 19000,
> +               .min_voltage = 1704000,
> +               .max_voltage = 1800000
> +       },
> +
> +       {
> +               .name = "vdda33",
> +               .enable_load = 16000,
> +               .min_voltage = 3050000,
> +               .max_voltage = 3300000
> +       },
> +
>  };
>
> -#define SNPS_HS_NUM_VREGS              ARRAY_SIZE(qcom_snps_hsphy_vreg_names)
> +#define SNPS_HS_NUM_VREGS              ARRAY_SIZE(hsphy_vreg_l)
>
>  struct override_param {
>         s32     value;
> @@ -132,12 +160,90 @@ struct qcom_snps_hsphy {
>         struct clk_bulk_data *clks;
>         struct reset_control *phy_reset;
>         struct regulator_bulk_data vregs[SNPS_HS_NUM_VREGS];
> +       const struct qcom_snps_hsphy_regulator_data *vreg_list;
>
>         bool phy_initialized;
>         enum phy_mode mode;
>         struct phy_override_seq update_seq_cfg[NUM_HSPHY_TUNING_PARAMS];
>  };
>
> +static int __vdda_phy_bulk_enable_disable(struct qcom_snps_hsphy *hsphy, bool on)

Separate functions, please.

> +{
> +       int ret = 0;
> +       int i;
> +
> +       if (!on)
> +               goto disable_vdd;
> +
> +       for (i = 0; i < SNPS_HS_NUM_VREGS; i++) {
> +
> +               ret = regulator_set_load(hsphy->vregs[i].consumer,
> +                                        hsphy->vreg_list[i].enable_load);
> +
> +               if (ret < 0) {
> +                       dev_err(hsphy->dev, "unable to set HPM of %s %d\n",
> +                                               hsphy->vregs[i].supply, ret);
> +                       goto err_vdd;
> +               }
> +       }
> +
> +       for (i = 0; i < SNPS_HS_NUM_VREGS; i++) {
> +               ret = regulator_set_voltage(hsphy->vregs[i].consumer,
> +                                           hsphy->vreg_list[i].min_voltage,
> +                                           hsphy->vreg_list[i].max_voltage);
> +               if (ret) {
> +                       dev_err(hsphy->dev,
> +                               "unable to set voltage of regulator %s %d\n",
> +                                               hsphy->vregs[i].supply, ret);
> +                       goto put_vdd_lpm;
> +               }
> +       }
> +
> +       ret = regulator_bulk_enable(ARRAY_SIZE(hsphy->vregs), hsphy->vregs);
> +       if (ret)
> +               goto unconfig_vdd;
> +
> +       return ret;
> +
> +disable_vdd:
> +       regulator_bulk_disable(ARRAY_SIZE(hsphy->vregs), hsphy->vregs);
> +
> +unconfig_vdd:
> +       for (i = 0; i < SNPS_HS_NUM_VREGS; i++) {
> +               ret = regulator_set_voltage(hsphy->vregs[i].consumer, 0,
> +                                           hsphy->vreg_list[i].max_voltage);
> +               if (ret) {
> +                       dev_err(hsphy->dev,
> +                       "unable to set voltage of regulator %s %d\n",
> +                                       hsphy->vregs[i].supply, ret);
> +               }
> +       }
> +
> +put_vdd_lpm:
> +       for (i = 0; i < SNPS_HS_NUM_VREGS; i++) {
> +               ret = regulator_set_load(hsphy->vregs[i].consumer, 0);
> +
> +               if (ret < 0) {
> +                       dev_err(hsphy->dev, "unable to set LPM of %s %d\n",
> +                                               hsphy->vregs[i].supply, ret);
> +               }
> +       }
> +
> +err_vdd:
> +       return ret;
> +
> +}
> +
> +static int vdda_phy_bulk_enable(struct qcom_snps_hsphy *hsphy)
> +{
> +       return __vdda_phy_bulk_enable_disable(hsphy, true);
> +}
> +
> +static int vdda_phy_bulk_disable(struct qcom_snps_hsphy *hsphy)
> +{
> +       return __vdda_phy_bulk_enable_disable(hsphy, false);
> +}
> +
>  static int qcom_snps_hsphy_clk_init(struct qcom_snps_hsphy *hsphy)
>  {
>         struct device *dev = hsphy->dev;
> @@ -390,7 +496,7 @@ static int qcom_snps_hsphy_init(struct phy *phy)
>
>         dev_vdbg(&phy->dev, "%s(): Initializing SNPS HS phy\n", __func__);
>
> -       ret = regulator_bulk_enable(ARRAY_SIZE(hsphy->vregs), hsphy->vregs);
> +       ret = vdda_phy_bulk_enable(hsphy);
>         if (ret)
>                 return ret;
>
> @@ -471,7 +577,7 @@ static int qcom_snps_hsphy_init(struct phy *phy)
>  disable_clks:
>         clk_bulk_disable_unprepare(hsphy->num_clks, hsphy->clks);
>  poweroff_phy:
> -       regulator_bulk_disable(ARRAY_SIZE(hsphy->vregs), hsphy->vregs);
> +       ret = vdda_phy_bulk_disable(hsphy);
>
>         return ret;
>  }
> @@ -482,7 +588,7 @@ static int qcom_snps_hsphy_exit(struct phy *phy)
>
>         reset_control_assert(hsphy->phy_reset);
>         clk_bulk_disable_unprepare(hsphy->num_clks, hsphy->clks);
> -       regulator_bulk_disable(ARRAY_SIZE(hsphy->vregs), hsphy->vregs);
> +       vdda_phy_bulk_disable(hsphy);
>         hsphy->phy_initialized = false;
>
>         return 0;
> @@ -592,8 +698,9 @@ static int qcom_snps_hsphy_probe(struct platform_device *pdev)
>
>         num = ARRAY_SIZE(hsphy->vregs);
>         for (i = 0; i < num; i++)
> -               hsphy->vregs[i].supply = qcom_snps_hsphy_vreg_names[i];
> +               hsphy->vregs[i].supply = hsphy_vreg_l[i].name;
>
> +       hsphy->vreg_list  = hsphy_vreg_l;
>         ret = devm_regulator_bulk_get(dev, num, hsphy->vregs);
>         if (ret)
>                 return dev_err_probe(dev, ret,
> --
> 2.17.1
>
>


-- 
With best wishes
Dmitry

