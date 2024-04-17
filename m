Return-Path: <linux-kernel+bounces-148403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E3B8A820A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865B71C21D5A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875B413C9A1;
	Wed, 17 Apr 2024 11:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y5fIZBeH"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A4D13C912
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713353209; cv=none; b=MrO4mEd+j/ROunIoj2kzxu2LmcC+sKEx7elqpMsJxW69KqWfKwpYx2usX+83jM3IhEwSDgKNIFW+S4ZgjUxyFi0lqsi60E4oOGQUbUUEzwFkCqc8M8mOBLO9DodxmQkU/6I7vQRP+m2T4QKTdz/i64xnKpuT08YKVsgNCAT3f4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713353209; c=relaxed/simple;
	bh=9w15mbaH1qCPmMzqW2fuVbi4t+4cdxNW7m9J6W+SAcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dxq/l1Sy+OpFKA+OasCN0YX9KQVnucWwq2XqBG97O8rtsd1IJihFtFUEm0pbFLCffadd1v7FMtGU3qdZEur9zCFaWbyR2QhBGkHQzdASOBY4j7qA7IuiC0rN0lzHcA1CVLuKJhJwfIbY1i70AuA3SbVDk0HJ5Fa6gKASWfMRMP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y5fIZBeH; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so5389811276.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 04:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713353207; x=1713958007; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fEf0tlVvOtKKoShUsakltVb3hD3/VpXcFyQ1gefjJfU=;
        b=Y5fIZBeH5Vy4N3V6A691s9vvWkxIhtBUw9MmdpaEoVD3T9H1MljZRsfDVdd4zrdwub
         egO8NOLvTbbn0FedpzowPCK1rMFTJA4IjEygopfIzqnFyhdaeQBAD6XeRTOd+2OZHCiX
         KSfb7inzPb0p/Jf/F0I4GxCtZmG9z/V9I4IiOt4sopzJu8GGT40diQllvXnHsWG95P9i
         e/uOaDCNA+Azoik6ysPUxkrtaz29gLO7solHQQLdkpE25+hGGEBS0GQ/xLCogiFiyXlC
         MDGSUVHCyEXvANBW+LZywlaO3orhHIRWz0/SCCWj7oaru5ZcLNi3um46BuNY5b7kG+ft
         5T2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713353207; x=1713958007;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fEf0tlVvOtKKoShUsakltVb3hD3/VpXcFyQ1gefjJfU=;
        b=tque0Qgy1xwrRsPoEDRkcgWGOoiEIjCbuoVDRK0hVM7n+27QD4oI8uWpomOGqio1El
         60oNHNg6o9mo+l0SqgY2QskLLxrvaZAd+p0PkxbMzPcyCzXwy30g8ToYs84AaEVYPWx7
         QAlUHeXp0E6nO3XbOVk5L2Ocx6Mt1YXmc4Wqfb8SbNVLViIa8ND9Ei9v/oiAaqu8kxQa
         hrsfK4hnN52jL0pN8UDY6dmevvA0gzIMd5uAtCU7+9U6o6suLWqUKdu1XEsxpP6+A7d0
         KsR+oVXUBGKGJQfaL1hgqUi2GpUYzNt0HDIwQJq30FwVCKveVJDELch8qy7mfDijakKg
         eb0A==
X-Forwarded-Encrypted: i=1; AJvYcCWJ0Jr8ywgsf0kL8Ton4uyLKgCEh+BzvJvd3aBrVqSijAefOCjlbQ7ksuDUawdGQL646j/tyUsKtGApW5+LfJJdH0Y6WO+YuC/iS5RP
X-Gm-Message-State: AOJu0YyO4DvbcM+zKC67cHdTkS60sPp/AJ8YeWj1fp35AWKDBeS/WsGN
	wFMUOQFgpkpiL61kahISkprtdeZUX8PRdrRE4eE9sNbMJNjeszwamqDc7UpPcE+ybw92DTIEhWd
	AST89Y5Sh2FWMXU0C/0JQgC9Tqt12RURCkHiB2w==
X-Google-Smtp-Source: AGHT+IEQk/I5LetE/DhGDVVO0twPSlWrg1ZbN08OoWEw3G7KQntEEGuJ8Lq3vNPpkhg2jG26xZma+XZL1vf3+BIUoXY=
X-Received: by 2002:a25:d354:0:b0:dc7:45f4:44f7 with SMTP id
 e81-20020a25d354000000b00dc745f444f7mr12803841ybf.14.1713353207586; Wed, 17
 Apr 2024 04:26:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417105605.836705-1-quic_varada@quicinc.com> <20240417105605.836705-3-quic_varada@quicinc.com>
In-Reply-To: <20240417105605.836705-3-quic_varada@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 17 Apr 2024 14:26:36 +0300
Message-ID: <CAA8EJpqaXU=H6Nhz2_WTYHS1A0bi1QrMdp7Y+s6HUELioCzbeg@mail.gmail.com>
Subject: Re: [PATCH v8 2/7] clk: qcom: cbf-msm8996: Specify master and slave id
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	konrad.dybcio@linaro.org, djakov@kernel.org, quic_anusha@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Apr 2024 at 13:56, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> The icc-clk driver has been changed to take master and slave id
> from the caller instead of auto-generating them. Update
> clk-cbf-8996 accordingly.

This should be squashed into the previous patch. Otherwise the driver
is broken between two commits.

>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  drivers/clk/qcom/clk-cbf-8996.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/qcom/clk-cbf-8996.c b/drivers/clk/qcom/clk-cbf-8996.c
> index fe24b4abeab4..a077d4403967 100644
> --- a/drivers/clk/qcom/clk-cbf-8996.c
> +++ b/drivers/clk/qcom/clk-cbf-8996.c
> @@ -237,7 +237,12 @@ static int qcom_msm8996_cbf_icc_register(struct platform_device *pdev, struct cl
>         struct device *dev = &pdev->dev;
>         struct clk *clk = devm_clk_hw_get_clk(dev, cbf_hw, "cbf");
>         const struct icc_clk_data data[] = {
> -               { .clk = clk, .name = "cbf", },
> +               {
> +                       .clk = clk,
> +                       .name = "cbf",
> +                       .master_id = MASTER_CBF_M4M,
> +                       .slave_id = SLAVE_CBF_M4M,
> +               },
>         };
>         struct icc_provider *provider;
>
> --
> 2.34.1
>


-- 
With best wishes
Dmitry

