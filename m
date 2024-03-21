Return-Path: <linux-kernel+bounces-109880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1324885705
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0B41C21AE4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951AC55E75;
	Thu, 21 Mar 2024 10:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k19gMiE8"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5BC55774
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 10:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711015426; cv=none; b=tJElQQUEoo74ctc+84F9JjA17+jY+rZ5g9baKzKwrQvzAy5rVHJCw6Am9ksjBdq/gZH9H0ZVLn7Rh6d8HwjvKt/7Rdi3o4rQUuqr6oUeKrmSfJfEze2qVIfApZmiQQYfsT0dHycIZpl8pXC0MhEuIrEw9jHaVQGpOLOyHzrq6ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711015426; c=relaxed/simple;
	bh=9mBsSCywB1UYVK5EIoAzSbSWRc36LYtQG7L15yc7v9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jjRCpJm5Y6Z7KFAWmI9O+JDin9ANcFTTDsEQx/Uezz5rFF/ZK7VqO9FgtrUmm8b5FaiSAg1QgK/ebBz/LYv1devZVNOCBayWRbsvp01bUnvaq4Fl6st+t0QqP/KOnlLjjK3Cmlx6E5KuhBFz91ikCVa7KUtLm+QnGal/PfNKdWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k19gMiE8; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc6d8bd618eso666030276.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 03:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711015424; x=1711620224; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QSqCEacDmuyhGjW4tIZGQOCZnmnjyg2MSjCQM9ns3PM=;
        b=k19gMiE8HnSOcxpo/+oGc6con8ZQSioz148eupvUPE8htxpUkuWXuVoBNjC8TazZBG
         TfqoiNaKwPg8AbXIg9lX/SRUY5nm7NRpHpvpMwBcuWKf0v3aii2REGgayDcCNmUzzlJd
         mZ6aHzMtQZteyfV/Bz0IB5F/q5Tg1Znzp0SXQquQSpP3SWIdGqIS4D49ttwPf19+b760
         qokZWazG/6NqXnzpGA/ds8Ke0mUkKvaNYmP1S1drQZKUO0Q5IIs7wvJJFy2GJAzXCKpb
         UQ10iul7c0m9z2f2VSLZ6pKs6AW0d3ZJe5DAyJthxn6lXrZ1HYTNB16Mpz4td/8Dhtph
         NzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711015424; x=1711620224;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSqCEacDmuyhGjW4tIZGQOCZnmnjyg2MSjCQM9ns3PM=;
        b=bOU9CujOEs+3XXB/Q3l/KP41oU+3alpckEm9GMXnCb/k61GloTt5nFcMaaymaPAd76
         a5tJO4Wn3+414evkkTpcI2MgjBHKQUR5c8NnoGEwZJhBLyiR5uT5aqmdRq6jB1rOynk4
         3Bor0w5XMA0hVrelJRSTRFMME2AO3s7Vtlc2A4U6Kp36aTUREBsGe8aZEWeTAboe61H3
         pG9mBoTY/U3jUA5eKjDi6w+kBZ4X81Hc+jLwOvt6TuvVxTkgFDsWI4z5qi9WoTZ7Lh8l
         rVS+RyzxqsHRNwG0drcL82qGuIJsbmlS/kwAUNVt7ZZIi68QYS4Y8ci1K5Hvu6FM7/Ed
         iI7w==
X-Forwarded-Encrypted: i=1; AJvYcCX3nIlETTnn8/rpBnbVAI+hcPP7qUEfbt+wLbGz4WSTSsUwuZ4Hho7L0DeGw7DODqpEyKUAdVWxedOQ5L1Gb3Rew0KDnpn3H1k+W4LB
X-Gm-Message-State: AOJu0Yzq66XldrG3Yd/vFgu9n/3WH0j0Ck3wbfAxcSg/0tHZB//xHwKH
	SGYavHV60JiCu58Cqm2tHt9alRcjfvZjHUVhHQRBPKfbMGy6ciTKIkVpjgxv1rtZh7UITtshpRt
	ELxz37qIfPwIXPm5kkbtA1IsMqp7rAKZ/Zx1PZw==
X-Google-Smtp-Source: AGHT+IE9o5xv1E+a+C5db8AW+UAGMIBoieSfVU/7OhyJYyIyX0EhBpq7st4JqdhP6/XI91PKF3215+N4PdtJ8bZCO4Y=
X-Received: by 2002:a05:6902:4c4:b0:dc7:465d:c06d with SMTP id
 v4-20020a05690204c400b00dc7465dc06dmr17513281ybs.28.1711015424255; Thu, 21
 Mar 2024 03:03:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321092529.13362-1-quic_jkona@quicinc.com> <20240321092529.13362-4-quic_jkona@quicinc.com>
In-Reply-To: <20240321092529.13362-4-quic_jkona@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 21 Mar 2024 12:03:32 +0200
Message-ID: <CAA8EJpq11ZeYrMqdKWrcs3=cx_Pr7wc1Y87SHMqP6B_9XtusVg@mail.gmail.com>
Subject: Re: [PATCH V2 RESEND 3/6] clk: qcom: videocc-sm8550: Add SM8650 video
 clock controller
To: Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>, 
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Mar 2024 at 11:27, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
>
> Add support to the SM8650 video clock controller by extending
> the SM8550 video clock controller, which is mostly identical
> but SM8650 has few additional clocks and minor differences.
>
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>



> @@ -411,6 +540,7 @@ static int video_cc_sm8550_probe(struct platform_device *pdev)
>  {
>         struct regmap *regmap;
>         int ret;
> +       u32 offset = 0x8140;

Nit: this variable seems misnamed. Please rename to something like
sleep_clk_offset;

>
>         ret = devm_pm_runtime_enable(&pdev->dev);
>         if (ret)
> @@ -426,12 +556,27 @@ static int video_cc_sm8550_probe(struct platform_device *pdev)
>                 return PTR_ERR(regmap);
>         }
>
> +       if (of_device_is_compatible(pdev->dev.of_node, "qcom,sm8650-videocc")) {
> +               offset = 0x8150;
> +               video_cc_pll0_config.l = 0x1e;
> +               video_cc_pll0_config.alpha = 0xa000;
> +               video_cc_pll1_config.l = 0x2b;
> +               video_cc_pll1_config.alpha = 0xc000;
> +               video_cc_mvs0_clk_src.freq_tbl = ftbl_video_cc_mvs0_clk_src_sm8650;
> +               video_cc_mvs1_clk_src.freq_tbl = ftbl_video_cc_mvs1_clk_src_sm8650;
> +               video_cc_sm8550_clocks[VIDEO_CC_MVS0_SHIFT_CLK] = &video_cc_mvs0_shift_clk.clkr;
> +               video_cc_sm8550_clocks[VIDEO_CC_MVS0C_SHIFT_CLK] = &video_cc_mvs0c_shift_clk.clkr;
> +               video_cc_sm8550_clocks[VIDEO_CC_MVS1_SHIFT_CLK] = &video_cc_mvs1_shift_clk.clkr;
> +               video_cc_sm8550_clocks[VIDEO_CC_MVS1C_SHIFT_CLK] = &video_cc_mvs1c_shift_clk.clkr;
> +               video_cc_sm8550_clocks[VIDEO_CC_XO_CLK_SRC] = &video_cc_xo_clk_src.clkr;
> +       }
> +
>         clk_lucid_ole_pll_configure(&video_cc_pll0, regmap, &video_cc_pll0_config);
>         clk_lucid_ole_pll_configure(&video_cc_pll1, regmap, &video_cc_pll1_config);
>
>         /* Keep some clocks always-on */
>         qcom_branch_set_clk_en(regmap, 0x80f4); /* VIDEO_CC_AHB_CLK */
> -       qcom_branch_set_clk_en(regmap, 0x8140); /* VIDEO_CC_SLEEP_CLK */
> +       qcom_branch_set_clk_en(regmap, offset); /* VIDEO_CC_SLEEP_CLK */
>         qcom_branch_set_clk_en(regmap, 0x8124); /* VIDEO_CC_XO_CLK */
>
>         ret = qcom_cc_really_probe(pdev, &video_cc_sm8550_desc, regmap);
> --
> 2.43.0
>
>


-- 
With best wishes
Dmitry

