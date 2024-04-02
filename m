Return-Path: <linux-kernel+bounces-128556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E73B895C64
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DBC71F21D5D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986F715B962;
	Tue,  2 Apr 2024 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MBP1gaRV"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EFC15B569
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 19:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085841; cv=none; b=ctwU56RiRStqD7LfpPdPwq1tgqru083jhGjQiOXil8g10dVIdLK9GO7gr2uViT1g/cWL6J0nt2TgWNgqZrdxfrwYJIAUMSNNf1dI2/7Z3rZgaLZc/vkQV9xpTbB7EKUiTadhduXWtJeVk+rFu6GZdLa+byrF32ndczHW1cuQZuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085841; c=relaxed/simple;
	bh=P4lfJSIm/a7/ENCpKQM7Grq/UyklOWzj2htNKV1x5iU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=te/ONH8gVCumdlmjLKU7ZxaznmC7qMVatVHZJ0F4i6gGGo2ysShYacRllR3RRxsyXbEcG50RzHGJNA7vJXcv8joHol9cmfDrdjUtAmdVhpBo/Q52+5u6nCLbxE+lUBYnancbyn+5QB+MVbaLvAqwMNaZDb8BybeYE9nPDO2bXjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MBP1gaRV; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dd045349d42so4957056276.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 12:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712085839; x=1712690639; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MAyxhZkMhNdcgpLgRXSZaiWaWTqSFcs47y/RT6HYcts=;
        b=MBP1gaRVbKTN+N4bfDwSjGylTUF3W5/R01hldCURAF6wGKbKQ+/I+OloQIIGRCAK4/
         8+++zHpByNz7AXfQGaRD8pyh5whAeK7Do33lZlpiZV8xlT/uxszH3+C4j4pS0+KZApPp
         OFVRDR5nnkqiL8kpnD/7/XQGca5APl5JwMRKWGfN5Z89kkWJFi0+m8EkgUAIf5gxlGS0
         kq48uEW+bw54iAeZkq61//nahvQl1kABABboR6ftGOtvYUtP8rxgDHr6qiwhKUpS+pJE
         7uGPJG/KtKVFa6bSvH8hpxMhd0KznVYrDyCXNHqxazqt5KNKVcO3OQBjQ+igtLbEJsW3
         t8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712085839; x=1712690639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MAyxhZkMhNdcgpLgRXSZaiWaWTqSFcs47y/RT6HYcts=;
        b=V5Aq/cLi6hyOt3fb54+Qw/x9uOZhwPYh3Hy/5sk8pyuWylCJY5jAfDR24N6c8PbRkA
         fUWGvETmbwYIOOH+gMmbS92TE8T2Fu/pfsy0OSBusTV0n+dyCR1TeANySOXL7qvyYjAs
         yFovGttZZglyeAi31pv2mSal2UKXeVFW8YYDZQFcSjxo4kS/21pmoUNhx2Ko+CaFLCZh
         CEbcdoqXI9jqcyAYFG/hs1doyuQBJlYhqDYjpMPEvEme6Sfk4q2SvsHqvmVY8ImZ+2rB
         wHEY6nP1DRps16yDMorPNWUCV1GHYSclPOlhOdO3mfz7hj52q/1M5FsmXD0VegMfnY2F
         vOZA==
X-Forwarded-Encrypted: i=1; AJvYcCXVmQHOIHM26MQ+I9jkZutczUmo7W01Vi7yZE0LUyEDt+Py7sv0oCYcbWu/1yodaJOJ2MUFoOEaKmkWXM2CUS4tczjI57gAF+VBtdx1
X-Gm-Message-State: AOJu0YxzCPD/Mj6OCItKTUBijzvqVhyjZ8Mgwfb5+ZZqe8qMZkggbQGa
	uZDeH419ERaXv1FWAatcGcb2d40kQS+WZ0X49PZDQ64nWlH4PmLaXrE6SMKN3il0P+W7BNU0a6U
	JLvLSAsZPdJuDo4J3UDRYXDNvbDH9co8mctACXA==
X-Google-Smtp-Source: AGHT+IFKIQlrUzR3pAK1EBokqKddw9IyUrdsIuy+DVXrWjrRPHpJeV1kHARI2ZBes0kp+Iv9xc2UePgf1bkuKbGcdWM=
X-Received: by 2002:a25:741:0:b0:dd0:129f:16 with SMTP id 62-20020a250741000000b00dd0129f0016mr11007422ybh.11.1712085839219;
 Tue, 02 Apr 2024 12:23:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240330182817.3272224-1-quic_ajipan@quicinc.com>
 <20240330182817.3272224-8-quic_ajipan@quicinc.com> <CAA8EJprtCbePun+gpwxg5e6o5NaBnunEJrmDrCV+O8BdHEeuYQ@mail.gmail.com>
 <9106b0eb-e15d-f2fa-d681-4017412c4a76@quicinc.com>
In-Reply-To: <9106b0eb-e15d-f2fa-d681-4017412c4a76@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 2 Apr 2024 22:23:48 +0300
Message-ID: <CAA8EJprP4Skq0GxyuzoF7Eu9pF+2Vm2wwbu9m6jBohdSKjLR9g@mail.gmail.com>
Subject: Re: [PATCH 7/7] clk: qcom: Add GPUCC driver support for SM4450
To: Ajit Pandey <quic_ajipan@quicinc.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Taniya Das <quic_tdas@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, 
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 21:26, Ajit Pandey <quic_ajipan@quicinc.com> wrote:
>
>
>
> On 3/31/2024 7:09 AM, Dmitry Baryshkov wrote:
> > On Sat, 30 Mar 2024 at 20:30, Ajit Pandey <quic_ajipan@quicinc.com> wrote:
> >>
> >> Add Graphics Clock Controller (GPUCC) support for SM4450 platform.
> >>
> >> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
> >> ---
> >>   drivers/clk/qcom/Kconfig        |   9 +
> >>   drivers/clk/qcom/Makefile       |   1 +
> >>   drivers/clk/qcom/gpucc-sm4450.c | 806 ++++++++++++++++++++++++++++++++
> >>   3 files changed, 816 insertions(+)
> >>   create mode 100644 drivers/clk/qcom/gpucc-sm4450.c
> >>
> >
> > [skipped]
> >
> >> +static int gpu_cc_sm4450_probe(struct platform_device *pdev)
> >> +{
> >> +       struct regmap *regmap;
> >> +
> >> +       regmap = qcom_cc_map(pdev, &gpu_cc_sm4450_desc);
> >> +       if (IS_ERR(regmap))
> >> +               return PTR_ERR(regmap);
> >> +
> >> +       clk_lucid_evo_pll_configure(&gpu_cc_pll0, regmap, &gpu_cc_pll0_config);
> >> +       clk_lucid_evo_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config);
> >> +
> >> +       /* Keep some clocks always enabled */
> >> +       qcom_branch_set_clk_en(regmap, 0x93a4); /* GPU_CC_CB_CLK */
> >> +       qcom_branch_set_clk_en(regmap, 0x9004); /* GPU_CC_CXO_AON_CLK */
> >> +       qcom_branch_set_clk_en(regmap, 0x900c); /* GPU_CC_DEMET_CLK */
> >
> > Why? At least other drivers model these three clocks properly.
> >
> These clocks are POR on in SM4450 and required to be kept always enabled
> for GPU functionality hence keep them enabled from probe only.

Please, check how this is handled on the other platforms, please.
Hint: `git grep GPU_CC_DEMET_CLK`

>
> >> +
> >> +       return qcom_cc_really_probe(pdev, &gpu_cc_sm4450_desc, regmap);
> >> +}
> >> +
> >> +static struct platform_driver gpu_cc_sm4450_driver = {
> >> +       .probe = gpu_cc_sm4450_probe,
> >> +       .driver = {
> >> +               .name = "gpucc-sm4450",
> >> +               .of_match_table = gpu_cc_sm4450_match_table,
> >> +       },
> >> +};
> >> +
> >> +module_platform_driver(gpu_cc_sm4450_driver);
> >> +
> >> +MODULE_DESCRIPTION("QTI GPUCC SM4450 Driver");
> >> +MODULE_LICENSE("GPL");
> >> --
> >> 2.25.1
> >>
> >>
> >
> >
>
> --
> Thanks, and Regards
> Ajit



-- 
With best wishes
Dmitry

