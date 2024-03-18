Return-Path: <linux-kernel+bounces-106202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBA187EAAD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2380FB2280D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87C04C627;
	Mon, 18 Mar 2024 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GGxIxtJh"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91AE4CB20
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710771418; cv=none; b=S9cKgKg19r//kkzLiiCNmceG45hXjIMrS/p8RNWGBYaR0p4SpsFrEVXbwsiKynqZOiUTNXM+nXabvtjPcWRkD5V7En2CMsJs+CGaN+93c+1Pkleqc6IpKmie2Wo4aQfpB6KJJqQ9go8UOa2fhGLMGOwbfGlERUlxfdLcLxpZC1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710771418; c=relaxed/simple;
	bh=rOzlSTthASyQgwpZVjNchS4VHdUqgwg+0fthytEsCP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F6jJFMTDdP/XnlX4lCsNyggSltSLwCM9G25WYfWxUMaeyijgDCMJKQKitXeR56631L0o9/mmHJW+yAiljjExCx/WKou6wMJQfEv+Y6U29USVP4a4RKJ8r3CRhv+qsKPZCYTh6GHlZevWrH9e46NwGB/hLGEw9mOOXLZ98334hDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GGxIxtJh; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-609f4d8551eso55394167b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 07:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710771415; x=1711376215; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8J4xg8pL+JVnZ2d+xdfnq4XTZIIQf2BljKguZHBIW44=;
        b=GGxIxtJhxPDWVQ6BqtVsdXA8qDfl2tdxBvTZrAlsWiJoSwQj1QiX7IvG9Z0SXsRCtM
         2gKL1vNT63/aiK47fPlDHs4LCN0AEe38x2MntPIuz2IjqDyvTtGB2kQiRIzgqdNCKHWb
         em4gm5AxjJcjZtLNOwqUp4S/haRFXmDGAMYJEo52EiwKyEPL8eOqLv4XBgtA0xpqOgjv
         P9hhYUH9Pio2NpT6HYKhisOmmX2cBjYKH4UVpw2SX58gt5Zzf09q0Figv1UEqaqx6gZM
         kQanxyPtZDdrJRZcGo2TKVL5b7UWEcqh8O4Lw0QwwiZ480STAOSaN+29dX4ZnRQylOe5
         ZWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710771415; x=1711376215;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8J4xg8pL+JVnZ2d+xdfnq4XTZIIQf2BljKguZHBIW44=;
        b=TAYpqvHXv+sU0vQcbQbVS8pTX7ZZW2NVSOSiI4dCfNCWmjUCIAYAeMutTVB1hMN+0+
         C6MUQ0NVyVoq7EHrsJ/ZKhSMDr10OC/9OGARlbfczMYt0sxwXmQtRlVV8drlPo/RsnUe
         aUUZq2KFcwoYfhbgC/kV4qFbWgkogLDkqI7WEy6v12DcMHsl1dvwFtj2v9uHKX2MNjsG
         AgPozprZHLQ2Z6kUq16sEUzFlVUANzQ1/SRVK+u+VGRKGZZFcmOc6DLU6Hfd7DJSr3ht
         nsAQFCsEc8eVHPQYXnFo9R571kD6a80JnNNGY/ws/j4idfzkAp5U+yKAFWFopn8CeLJa
         EHfg==
X-Forwarded-Encrypted: i=1; AJvYcCUEbaEwPpZgUM/fn31C2lW2jD+f2d7Wb3+CCPx4QGg6L3D17zezcNaKru4aHpfUSMjHg2E7NTkMuaAsGCA7Zzx8il+HmUr9mvX1tOuZ
X-Gm-Message-State: AOJu0YzXMz8zwsPaqrapQph78HhIXcQ9sZ8SILgpAreDXL4QpbrCNVC3
	AsroqcVFytL78FQjmrG0//B3nGwiGeuWim389pjdwgtzX3QWEIYS1UtrasnJKJcORTczab8F3k+
	ORlpwbGED63x7sjtLiyhYq+h3fyL5yXgpjFAi2Q==
X-Google-Smtp-Source: AGHT+IEvFYwE5sS/ZdUGl4QC1VMK4V6gFZsyCtq7eO/fPjCvn7WtuPLxgRxXP4/a0hitKTpfQiEy5JVcez/WdWvhImM=
X-Received: by 2002:a0d:d614:0:b0:609:e710:3a32 with SMTP id
 y20-20020a0dd614000000b00609e7103a32mr7648479ywd.12.1710771415485; Mon, 18
 Mar 2024 07:16:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318-apss-ipq-pll-cleanup-v1-0-52f795429d5d@gmail.com> <20240318-apss-ipq-pll-cleanup-v1-2-52f795429d5d@gmail.com>
In-Reply-To: <20240318-apss-ipq-pll-cleanup-v1-2-52f795429d5d@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 18 Mar 2024 16:16:44 +0200
Message-ID: <CAA8EJpo2Vo-XqstNk69dWW8pqNkGi0tz3UmHY7j6LLKd-yH22w@mail.gmail.com>
Subject: Re: [PATCH 2/5] clk: qcom: apss-ipq-pll: use an 1-D array for Huayra
 pll register offsets
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Mar 2024 at 13:20, Gabor Juhos <j4g8y7@gmail.com> wrote:
>
> The 'ipq_pll_offsets' is defined as a two-dimensional array, but it
> contains a sole element only so convert it to an one-dimensional
> array. Also, rename the variable to better reflect that it is used
> for the Huayra PLLs.
>
> No functional changes.
>
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
>  drivers/clk/qcom/apss-ipq-pll.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
> index ed3e6405f99cb..f5c7eaf8db374 100644
> --- a/drivers/clk/qcom/apss-ipq-pll.c
> +++ b/drivers/clk/qcom/apss-ipq-pll.c
> @@ -13,22 +13,20 @@
>   * are different from the one mentioned in the clk-alpha-pll.c, since the
>   * PLL is specific to APSS, so lets the define the same.
>   */
> -static const u8 ipq_pll_offsets[][PLL_OFF_MAX_REGS] = {
> -       [CLK_ALPHA_PLL_TYPE_HUAYRA] =  {
> -               [PLL_OFF_L_VAL] = 0x08,
> -               [PLL_OFF_ALPHA_VAL] = 0x10,
> -               [PLL_OFF_USER_CTL] = 0x18,
> -               [PLL_OFF_CONFIG_CTL] = 0x20,
> -               [PLL_OFF_CONFIG_CTL_U] = 0x24,
> -               [PLL_OFF_STATUS] = 0x28,
> -               [PLL_OFF_TEST_CTL] = 0x30,
> -               [PLL_OFF_TEST_CTL_U] = 0x34,
> -       },
> +static const u8 ipq_pll_huayra_regs[PLL_OFF_MAX_REGS] = {
> +       [PLL_OFF_L_VAL] = 0x08,
> +       [PLL_OFF_ALPHA_VAL] = 0x10,
> +       [PLL_OFF_USER_CTL] = 0x18,
> +       [PLL_OFF_CONFIG_CTL] = 0x20,
> +       [PLL_OFF_CONFIG_CTL_U] = 0x24,
> +       [PLL_OFF_STATUS] = 0x28,
> +       [PLL_OFF_TEST_CTL] = 0x30,
> +       [PLL_OFF_TEST_CTL_U] = 0x34,
>  };

Can you please move this to clk_alpha_pll? We can then drop it from
clk-cbf-8996.c too.

>
>  static struct clk_alpha_pll ipq_pll_huayra = {
>         .offset = 0x0,
> -       .regs = ipq_pll_offsets[CLK_ALPHA_PLL_TYPE_HUAYRA],
> +       .regs = ipq_pll_huayra_regs,
>         .flags = SUPPORTS_DYNAMIC_UPDATE,
>         .clkr = {
>                 .enable_reg = 0x0,
>
> --
> 2.44.0
>
>


-- 
With best wishes
Dmitry

