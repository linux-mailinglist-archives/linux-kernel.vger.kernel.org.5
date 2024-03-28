Return-Path: <linux-kernel+bounces-123692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D9F890CBF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A339293D9B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F76113B591;
	Thu, 28 Mar 2024 21:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dm/ZHUab"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AB6651B2;
	Thu, 28 Mar 2024 21:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711662895; cv=none; b=Pk3PrVfu98ixZAlOcRihObjD7x25kqrmL0OEdXpmQ7mPS/Da0kHCf6nfXoFmTMpTBnbk0vU3ii56Wd7LxijjDpeVreDP7ix45wYac569G1gThD+9Qnoqi5kwEB2aWtRWjKMc5dR+xzg2f2+M316UC9CBcN6w8i2/fdibmIYsZ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711662895; c=relaxed/simple;
	bh=LsTydrprTuBThTeqctYGN5ue6gnuxzroUgqiktF3q/c=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:To:Date; b=SElXwPXWnatNH9mcCHsxXABMHbGqWBvDd2gm0KwGOQz4mA1sJqWZOdpMzWgnpnSfGaZSsNfn2F2p2XxB448vBU/6af2Anczk0NuFl8+GeSBJ64rmh08aksg/ouJrktpf68pqyRzjkIjB0HfxXGrHzOXqzLO7lweo+fnVqMId4a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dm/ZHUab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC662C433F1;
	Thu, 28 Mar 2024 21:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711662895;
	bh=LsTydrprTuBThTeqctYGN5ue6gnuxzroUgqiktF3q/c=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=Dm/ZHUab21Urpoc/3Y53vRwsy1aPnZ7LrrtWFHTiNbtSyeqQji0KxGIoZDT5cJQZA
	 3PSa1WYd1ZkifVPyuIGKi3AcjvzMULnrYeHdMHUg3SunZs1IzQhgn0S6np+mdUxR8O
	 +OhOho7trzyz3KNhShMGBjim8sFmBeaeD3n+pXMs0CtPl6zSIxet8Te7R6kbH/Cyy2
	 ZnIF2oN8azAFa4dIHuK2yygX5K45iX6j2ZERSHlv37ozTA1bBjqGtW55Kv7XCz5cF1
	 qbl2eK5or2HeBm/iXiFQS+/l/zpM31ppMqHtfIzNcjUv99Z4YMAg1f3x7DQ7rNpK41
	 AN4VgLqhosyfg==
Message-ID: <80131262978e6e4799864cdfd0784fdf.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240328075936.223461-4-quic_varada@quicinc.com>
References: <20240328075936.223461-1-quic_varada@quicinc.com> <20240328075936.223461-4-quic_varada@quicinc.com>
Subject: Re: [PATCH v5 3/5] clk: qcom: common: Add interconnect clocks support
From: Stephen Boyd <sboyd@kernel.org>
To: andersson@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, djakov@kernel.org, dmitry.baryshkov@linaro.org, konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mturquette@baylibre.com, quic_anusha@quicinc.com, quic_varada@quicinc.com, robh@kernel.org
Date: Thu, 28 Mar 2024 14:54:52 -0700
User-Agent: alot/0.10

Quoting Varadarajan Narayanan (2024-03-28 00:59:34)
> diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
> index 75f09e6e057e..9fa271812373 100644
> --- a/drivers/clk/qcom/common.c
> +++ b/drivers/clk/qcom/common.c
> @@ -8,6 +8,8 @@
>  #include <linux/regmap.h>
>  #include <linux/platform_device.h>
>  #include <linux/clk-provider.h>
> +#include <linux/interconnect-clk.h>
> +#include <linux/interconnect-provider.h>

Do we need the second include?

>  #include <linux/reset-controller.h>
>  #include <linux/of.h>
> =20
> @@ -234,6 +236,41 @@ static struct clk_hw *qcom_cc_clk_hw_get(struct of_p=
handle_args *clkspec,
>         return cc->rclks[idx] ? &cc->rclks[idx]->hw : NULL;
>  }
> =20
> +#if IS_ENABLED(CONFIG_INTERCONNECT_CLK)
> +static int qcom_cc_icc_register(struct device *dev,
> +                               const struct qcom_cc_desc *desc)
> +{
> +       struct icc_clk_data *icd;
> +       int i;
> +
> +       if (!desc->icc_hws)
> +               return 0;
> +
> +       icd =3D devm_kcalloc(dev, desc->num_icc_hws, sizeof(*icd), GFP_KE=
RNEL);
> +       if (!icd)
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < desc->num_icc_hws; i++) {
> +               icd[i].clk =3D devm_clk_hw_get_clk(dev, desc->icc_hws[i],=
 "qcom");

Make the con_id "icc" instead please, so we know the consumer is
icc_clk. Even better would be for the icc_clk device itself to be the
one requesting with devm_clk_hw_get_clk() so that we associate the clk
handle with the consumer device. It would also help us make it so that
drivers defer probe until their clk isn't an orphan.

> +               if (IS_ERR(icd[i].clk))
> +                       return dev_err_probe(dev, PTR_ERR(icd[i].clk),
> +                                            "get clock failed (%ld)\n",
> +                                            PTR_ERR(icd[i].clk));
> +
> +               icd[i].name =3D clk_hw_get_name(desc->icc_hws[i]);
> +       }
> +
> +       return PTR_ERR_OR_ZERO(devm_icc_clk_register(dev, desc->first_id,
> +                                                    desc->num_icc_hws, i=
cd));
> +}
> +#else
> +static int qcom_cc_icc_register(struct device *dev,
> +                               const struct qcom_cc_desc *desc)
> +{
> +       return 0;
> +}

Instead of this please have an

	if (!IS_ENABLED(CONFIG_INTERCONNECT_CLK))
		return 0;

> +#endif
> +
>  int qcom_cc_really_probe(struct platform_device *pdev,
>                          const struct qcom_cc_desc *desc, struct regmap *=
regmap)
>  {
> @@ -303,7 +340,7 @@ int qcom_cc_really_probe(struct platform_device *pdev,
>         if (ret)
>                 return ret;
> =20
> -       return 0;
> +       return qcom_cc_icc_register(dev, desc);
>  }
>  EXPORT_SYMBOL_GPL(qcom_cc_really_probe);
> =20
> diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
> index 9c8f7b798d9f..d8ac26d83f3c 100644
> --- a/drivers/clk/qcom/common.h
> +++ b/drivers/clk/qcom/common.h
> @@ -29,6 +29,9 @@ struct qcom_cc_desc {
>         size_t num_gdscs;
>         struct clk_hw **clk_hws;
>         size_t num_clk_hws;
> +       struct clk_hw **icc_hws;
> +       size_t num_icc_hws;
> +       unsigned int first_id;

'first_id' is gross.

