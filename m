Return-Path: <linux-kernel+bounces-148406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DF08A8221
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B716D1F243B5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868B913CF85;
	Wed, 17 Apr 2024 11:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I+MXI56D"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C5713C8EE
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713353417; cv=none; b=HB+jTi9CAIxhDAX2X9H5JCYyzRzc3CBAP1qJcQys5c26xbCbkqta7PPmdZwK7Hm9McDapos4GoyVI+f3DtjQz2KWHmSvdd0CbP3EC5bWUdPKl+TBVAQkBAKH9F1bOU6U86Zh49qZBvI4fqGuYa5n2/6xlVSw1qqCIwl8HuGFl2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713353417; c=relaxed/simple;
	bh=mkpvver1UANTt4sIRnGN0yjFucJ2ShtaKzZ05VzBgPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hBVS1SpsEwzC6hYXPx8Xr/g11mMEi/5/l7uWbX7vJ5U1nNtU6CoUeddk65wT6nkf4xb8SkQgj7he/rzAnq8dEAnYwL8ZJbzktPKN1aWkrOrf392CDLExZvsBPIaC+twnTo0A14oG9DF3ijAmeLfkakONU1rKXLa09AYVS9Kb1Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I+MXI56D; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-61816fc256dso48430267b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 04:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713353414; x=1713958214; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ke0ATAaeGNIlN1VFqyXkTgin2tXlHpdkeNUSBYd+YQY=;
        b=I+MXI56DvTNqLdha13Vv1esqK33GYTQ3TuGUCwklGKB+d5UfMx11jrSRiZDsCuqdIT
         Qo5of76Gh0BMJEo+5VQxgHA1pdgx6ccOECPnZPI7UmnPYg2SevIK6nBm8v+oCOpbuXJP
         qORfmDNU896F7Revy/NMEGu/mh/iJpvw6svn7BVLMisS7o+VOU8/yTV0uRHErm11e9Ly
         2yRga919WNdDYtixMc3yWZs6WA7ZwYM0A0X7HYGsGxzXO/P9QDKwJ2OGs9A2QZyvrhQH
         VjqlaLkvNjcCpJ291F31MeqSYIbpscfm1eB/VEu1L52VgBjbt9XcAF37uNdIrtYDXMlb
         uJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713353414; x=1713958214;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ke0ATAaeGNIlN1VFqyXkTgin2tXlHpdkeNUSBYd+YQY=;
        b=MUvrYNqRqwSfydTf+vNVaZECVVqicJzYozY2wgSD937zn8e9gxhEQVfof9B+N11iS+
         BN0YJMmgDxG/jn40sMOCmksXBLPU8VSlLR+BIbjtrr7aJ3Rl/vvG1xqm4NiwkUf5pOLY
         Y39HuI/534ZzKgZkvNyga8g9S+iaSIKHrGmwe1QwClResxjBMh2+jVip3FPGk7CZFD7s
         aQFNy1QynDDsXXpt8v+NkhrtOetgBY3NQYPPvIz5aMt+URJBl4kd7D+Im7ZiF3aj5lgt
         Y88G7XUeVgdR+A4cNVbFdoJnYXhKep03m6yKsMx/4NNQMvP1NlXMbnTG6kJJNToVF9+K
         N9DA==
X-Forwarded-Encrypted: i=1; AJvYcCVv0h2cP48OJ/4mJ7afI2fVU+ew4XROmDOVpP9ncg86XBq5ciLjG4SxUTsUpCOQgFYnVWjhsvLsIEsZ6dOVzdSLvR1WXkxarZeGXCv+
X-Gm-Message-State: AOJu0YzUlhvzRfYHWaSXY5Ut4pM7d97bNL+m6I7CcmRWmuQjfeb2Xitx
	j5XcTP/CE2bzhCTopl/rAtAPMJ6jpqJHjA+PBeRWD0TZm0dZVZaabheCqoF/oz1S8gTV53QXZFz
	6dmbiKLda4xd9nW6k5cEEinJi2mXrVBgGS0iWlQ==
X-Google-Smtp-Source: AGHT+IGoRTggqGH8ruCDDtVwQPfVj6cDUlkPo/svCjQ8WcMzuJiLc+4dGgghXvHuRhUlChH/sWfgCNi/lqJOPO4b+9g=
X-Received: by 2002:a25:905:0:b0:de0:d497:1ba7 with SMTP id
 5-20020a250905000000b00de0d4971ba7mr13957110ybj.39.1713353413890; Wed, 17 Apr
 2024 04:30:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417105605.836705-1-quic_varada@quicinc.com> <20240417105605.836705-7-quic_varada@quicinc.com>
In-Reply-To: <20240417105605.836705-7-quic_varada@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 17 Apr 2024 14:30:02 +0300
Message-ID: <CAA8EJpruv2dmw61Z4c4C0p5662CKwSqzRBjDQU+_KSMNU=cL5g@mail.gmail.com>
Subject: Re: [PATCH v8 6/7] clk: qcom: ipq9574: Use icc-clk for enabling NoC
 related clocks
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	konrad.dybcio@linaro.org, djakov@kernel.org, quic_anusha@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Apr 2024 at 13:57, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> Use the icc-clk framework to enable few clocks to be able to
> create paths and use the peripherals connected on those NoCs.
>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v8: Bind clock and interconnect using master and slave ids
>     Use indices instead of clock pointers
> v7: Auto select INTERCONNECT & INTERCONNECT_CLK in COMMON_CLK_QCOM
>     to address build break with random config build test, with the
>     following combination
>
>         CONFIG_COMMON_CLK_QCOM=y
>                 and
>         CONFIG_INTERCONNECT_CLK=m
>
>     the following error is seen as devm_icc_clk_register is in a
>     module and being referenced from vmlinux.
>
>         powerpc64-linux-ld: drivers/clk/qcom/common.o: in function `qcom_cc_really_probe':
>         >> common.c:(.text+0x980): undefined reference to `devm_icc_clk_register'
>
> v6: Move enum to dt-bindings and share between here and DT
>     first_id -> icc_first_node_id
> v5: Split from common.c changes into separate patch
>     No functional changes
> ---
>  drivers/clk/qcom/Kconfig       |  2 ++
>  drivers/clk/qcom/gcc-ipq9574.c | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 8ab08e7b5b6c..b65a373f2e6b 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -17,6 +17,8 @@ menuconfig COMMON_CLK_QCOM
>         select RATIONAL
>         select REGMAP_MMIO
>         select RESET_CONTROLLER
> +       select INTERCONNECT
> +       select INTERCONNECT_CLK
>
>  if COMMON_CLK_QCOM
>
> diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
> index 0a3f846695b8..7983e9ba0f35 100644
> --- a/drivers/clk/qcom/gcc-ipq9574.c
> +++ b/drivers/clk/qcom/gcc-ipq9574.c
> @@ -4,6 +4,7 @@
>   */
>
>  #include <linux/clk-provider.h>
> +#include <linux/interconnect-clk.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -12,6 +13,7 @@
>
>  #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
>  #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
> +#include <dt-bindings/interconnect/qcom,ipq9574.h>
>
>  #include "clk-alpha-pll.h"
>  #include "clk-branch.h"
> @@ -4301,6 +4303,32 @@ static const struct qcom_reset_map gcc_ipq9574_resets[] = {
>         [GCC_WCSS_Q6_TBU_BCR] = { 0x12054, 0 },
>  };
>
> +#define IPQ_APPS_ID                    9574    /* some unique value */
> +
> +static struct qcom_icc_hws_data icc_ipq9574_hws[] = {
> +       HWS_DATA(ANOC_PCIE0, GCC_ANOC_PCIE0_1LANE_M_CLK),

Have you seen other parts of the qcom framework using macros to wrap
around structure initialisation? I don't think so. Please follow the
suit and inline the macro here.

> +       HWS_DATA(SNOC_PCIE0, GCC_SNOC_PCIE0_1LANE_S_CLK),
> +       HWS_DATA(ANOC_PCIE1, GCC_ANOC_PCIE1_1LANE_M_CLK),
> +       HWS_DATA(SNOC_PCIE1, GCC_SNOC_PCIE1_1LANE_S_CLK),
> +       HWS_DATA(ANOC_PCIE2, GCC_ANOC_PCIE2_2LANE_M_CLK),
> +       HWS_DATA(SNOC_PCIE2, GCC_SNOC_PCIE2_2LANE_S_CLK),
> +       HWS_DATA(ANOC_PCIE3, GCC_ANOC_PCIE3_2LANE_M_CLK),
> +       HWS_DATA(SNOC_PCIE3, GCC_SNOC_PCIE3_2LANE_S_CLK),
> +       HWS_DATA(USB, GCC_SNOC_USB_CLK),
> +       HWS_DATA(USB_AXI, GCC_ANOC_USB_AXI_CLK),
> +       HWS_DATA(NSSNOC_NSSCC, GCC_NSSNOC_NSSCC_CLK),
> +       HWS_DATA(NSSNOC_SNOC_0, GCC_NSSNOC_SNOC_CLK),
> +       HWS_DATA(NSSNOC_SNOC_1, GCC_NSSNOC_SNOC_1_CLK),
> +       HWS_DATA(NSSNOC_PCNOC_1, GCC_NSSNOC_PCNOC_1_CLK),
> +       HWS_DATA(NSSNOC_QOSGEN_REF, GCC_NSSNOC_QOSGEN_REF_CLK),
> +       HWS_DATA(NSSNOC_TIMEOUT_REF, GCC_NSSNOC_TIMEOUT_REF_CLK),
> +       HWS_DATA(NSSNOC_XO_DCD, GCC_NSSNOC_XO_DCD_CLK),
> +       HWS_DATA(NSSNOC_ATB, GCC_NSSNOC_ATB_CLK),
> +       HWS_DATA(MEM_NOC_NSSNOC, GCC_MEM_NOC_NSSNOC_CLK),
> +       HWS_DATA(NSSNOC_MEMNOC, GCC_NSSNOC_MEMNOC_CLK),
> +       HWS_DATA(NSSNOC_MEM_NOC_1, GCC_NSSNOC_MEM_NOC_1_CLK),
> +};
> +
>  static const struct of_device_id gcc_ipq9574_match_table[] = {
>         { .compatible = "qcom,ipq9574-gcc" },
>         { }
> @@ -4323,6 +4351,9 @@ static const struct qcom_cc_desc gcc_ipq9574_desc = {
>         .num_resets = ARRAY_SIZE(gcc_ipq9574_resets),
>         .clk_hws = gcc_ipq9574_hws,
>         .num_clk_hws = ARRAY_SIZE(gcc_ipq9574_hws),
> +       .icc_hws = icc_ipq9574_hws,
> +       .num_icc_hws = ARRAY_SIZE(icc_ipq9574_hws),
> +       .icc_first_node_id = IPQ_APPS_ID,
>  };
>
>  static int gcc_ipq9574_probe(struct platform_device *pdev)
> --
> 2.34.1
>


-- 
With best wishes
Dmitry

