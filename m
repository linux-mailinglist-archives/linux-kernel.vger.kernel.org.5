Return-Path: <linux-kernel+bounces-35717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A5D8395A0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34B67B2ED8F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B99C12BE91;
	Tue, 23 Jan 2024 16:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eCbhgJNJ"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C2912AAD5
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028573; cv=none; b=aAnRY2KnEnGSFPc8crbJFRHvfZ7fTuYaqCAqopglGi5lhiNvmuh6X+HV86SZnZ6hFoKNENiC7yOxZClYzYghvyWwMmP9XcG4qGy1l6WUE4QT0u7XchlN5DGUAf/OU+uEnLFXl/32sGE+/qx4zCU4VdAgFXMTFLSIrgDd4aI48Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028573; c=relaxed/simple;
	bh=0GodLf30+iNTBjP5Gh6/duXnvzTXZV9C69MvyxMo8U4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tZPFRO2GGirhmxsX9uRNtxmP/qoAM1TaBud07J46L0MbVVnLTHO1mNH1VYn8uOhgjPIcg+50gO/UO3fh7yR0YVVgvevAMcFB1ZbbJVjUQ+hRZ9YcbbnLLlyf9JYu1a8+tt7G88UIjBpG/pY6fV/R/J/xtMPUGBd0u3gILcBJgB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eCbhgJNJ; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5ff7dc53ce0so33423177b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 08:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706028570; x=1706633370; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aXz6WQyGCVGvl5jSp/sFyNgM0abYZYPNAeAICiPwHO8=;
        b=eCbhgJNJvcM1TmjWFhBZCwvo4N+jgvjxgMOR2MqTqudxEr99MPdQWJ+RJtEhwyxq7O
         eUqJTMAc32WZodMqMq9bhTuKCYpFqdH2q5DQw3qWnTJJz2KXCUqmZjpse1jA47qEr2Gm
         udGRMzYCeuPq2fQtBseRlG61FucIuhDcwa2JuYGJXldVDT2yDdKCB1vV8cZ4drdxw/ku
         Y0Yo7IT7FeW7sreqCbCreFWytvCnP6/L7RKDOAYl6MVzXX6a5HRRwBI4p53n/ED5Fh/+
         kq/F9dZaCW7sl3vYvWa4h9dKz/xXFsFhNfdQ7YWOTvNMFtTHN1fHXmAfkolTGRVOgRR9
         5D0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706028570; x=1706633370;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aXz6WQyGCVGvl5jSp/sFyNgM0abYZYPNAeAICiPwHO8=;
        b=AyhT9oazsstWX07Xx1aUIcV8K6QUXZ46g5nR4T4ZxAUXtwe2JWFq7fBPI0XyB/YDnV
         adRmbX4hbxvaXxpA6ej1eZIfLI/T3Q1yZh9gFd5b0SQMQIouyXSQUCwzt+ejNzyKLXRL
         /KpTclXduSsv5hYqa9kHRMhh7LtI97XZAxh05pcetHtotE7fcvSCwDUVdOir38LnsOiZ
         qHNLfGwQLEP5ciZMWb9zo6bcOT6NuXHB36nhTl2vYEDgPwnEpENJwDDuztWt5v+KsVdf
         DgC9OxZTXn/4MpjkQ0YLnFDxJzHvegf1icdn6NUzzfgToP/WeMkI5ISzxedIr6EUubMt
         4p/w==
X-Gm-Message-State: AOJu0YxwLvq34mtqIT7licGkKDgfpvkgppMhuYHN0Ngjc95dfjYlorsA
	A3PbakhYqEtw2UxgixJli/Yz2KOH25xH+OFgORxniWFQIqCWoeIwe2xvKs3vAz8fCMW7npMMEMN
	X/veBOb20PPys6fTabzDYxrPN5wklwJ9ei18+ag==
X-Google-Smtp-Source: AGHT+IEE5iwDZNZnKWCqP0X/hJ8GqixDXEFeBY9HQDXHizFGiA1pCXIi2xw17JvVbOPkrHIwHkzBMtTYGJvnD55grhc=
X-Received: by 2002:a0d:d50f:0:b0:5ff:9eaf:be5d with SMTP id
 x15-20020a0dd50f000000b005ff9eafbe5dmr3326432ywd.81.1706028570482; Tue, 23
 Jan 2024 08:49:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123-gcc-ao-support-v1-0-6c18d5310874@quicinc.com> <20240123-gcc-ao-support-v1-2-6c18d5310874@quicinc.com>
In-Reply-To: <20240123-gcc-ao-support-v1-2-6c18d5310874@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 23 Jan 2024 18:49:19 +0200
Message-ID: <CAA8EJpqLZQNMzn_oC7AbzXP2f==PujUe-atfUNgFC3VaFF8=Bg@mail.gmail.com>
Subject: Re: [PATCH 2/3] clk: qcom: gcc-sm8150: Add gcc_parents_0_ao support
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jan 2024 at 18:35, Satya Priya Kakitapalli
<quic_skakitap@quicinc.com> wrote:
>
> Add active_only support for gcc_parents_0, this is needed because
> some of the clocks under it are critical which would vote on xo
> blocking the suspend.

The kernel should be able to work with older DT files. Please add
support for using bi_tcxo as a fallback.

>
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> ---
>  drivers/clk/qcom/gcc-sm8150.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
> index 05d115c52dfe..2a0608c5a104 100644
> --- a/drivers/clk/qcom/gcc-sm8150.c
> +++ b/drivers/clk/qcom/gcc-sm8150.c
> @@ -123,6 +123,12 @@ static const struct clk_parent_data gcc_parents_0[] = {
>         { .hw = &gpll0_out_even.clkr.hw },
>  };
>
> +static const struct clk_parent_data gcc_parents_0_ao[] = {
> +       { .fw_name = "bi_tcxo_ao", .name = "bi_tcxo_ao" },
> +       { .hw = &gpll0.clkr.hw },
> +       { .hw = &gpll0_out_even.clkr.hw },
> +};
> +
>  static const struct parent_map gcc_parent_map_1[] = {
>         { P_BI_TCXO, 0 },
>         { P_GPLL0_OUT_MAIN, 1 },
> @@ -222,8 +228,8 @@ static struct clk_rcg2 gcc_cpuss_ahb_clk_src = {
>         .freq_tbl = ftbl_gcc_cpuss_ahb_clk_src,
>         .clkr.hw.init = &(struct clk_init_data){
>                 .name = "gcc_cpuss_ahb_clk_src",
> -               .parent_data = gcc_parents_0,
> -               .num_parents = ARRAY_SIZE(gcc_parents_0),
> +               .parent_data = gcc_parents_0_ao,
> +               .num_parents = ARRAY_SIZE(gcc_parents_0_ao),
>                 .flags = CLK_SET_RATE_PARENT,
>                 .ops = &clk_rcg2_ops,
>         },
>
> --
> 2.25.1
>
>


-- 
With best wishes
Dmitry

