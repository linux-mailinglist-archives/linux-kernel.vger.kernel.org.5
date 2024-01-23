Return-Path: <linux-kernel+bounces-35209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA25838DB4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE7FB1F2369F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF315D8EB;
	Tue, 23 Jan 2024 11:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V1h+dgnf"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CC75A114
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706010186; cv=none; b=bbja6MCW6u8tZsKCZJ7q12riOelQvNSgx+ebtYN7Mx7xK5mYxD3+gAUkfQXyTne/ZF3eO/hp8jW0DEyg+5qAKynCKUpvTeu5FaONxNEB/QuduEvoe7/NkZrMDdvUBh48Sa1moSDRLCZB378yyp7JQQOHJqnb7q51LiqFU9AUUe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706010186; c=relaxed/simple;
	bh=yD5zgikaBnzqRFckUp4Iw29O6Q9Cu/bTBJbJ1D6g47o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJL3vs7vT1XIlPkUi1Sa7Kh8scBC+lDbEYhjL10ZRjEdcYXSiFIOXpAy4q8G3qeqk2J/1oVo+Em3MoxUCOIdm2Z/qGapGDq4FyiwabTNsjOsnvZqFSS4kuU6snaCOcSIFm+qQ68k8/6Griinjoaowk0oHPrnZIEulF1SA/Tq4do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V1h+dgnf; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a2cea0563cbso617862266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 03:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706010183; x=1706614983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rCBz3mYv0AakBZqsbV887sBgjYgjKky8SqdijPrpvLA=;
        b=V1h+dgnfOmdGp+fkvd/vqG/nSF2tHTDNQjcgkv+N4qbtZ55BenntJPRZxPifaAvYMx
         D/4XwKXBS/okr2bG5D2R5r9HG1eEK3XbLEz8N7SQH3HPbvvlpGTZ2a0HHp1M14+q5eFG
         kZmvq3J2eRWJJqVcNYHEA0W+HJp2EoDZZP3bGM3byOYK2av8hloVDIo8fa0W/RbAvpY/
         0yEOd2ZuVr+FuWXw8VmZ4dzR47mDoXYFqV4NgR5LDBymZpLEfMbVt6LDvMSdAiOEPT/v
         c7jQvWjtOPfAw2CIAXl/kRWM36ug8dLX2FW8CgUq2dwQqbyYtJ3QiQ7vfxTijIPGEC02
         3ByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706010183; x=1706614983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCBz3mYv0AakBZqsbV887sBgjYgjKky8SqdijPrpvLA=;
        b=LWDl0FJDHoHyLTd9hFqeSV3Zjsw9QpXCXvymWpKMYltEJCkac8luB7VdZ8Cp+T4PpG
         43ReEBMrSM3f7qyYR7rfwjmz+2fWaQh5qxglRZ5BsESnVemOxmjyjpAwFCQUsIivsFAd
         wgussMdVv60wzqNDVmmEORvU8ghrXEac2p+65koGHjxe1prUxwkY4byjWivezPC1ld1f
         IFQerZfwOfc8iwyp2BCl98ftkXFSr5H8ytaiBTDXUFIE0uU+joA9PMEYOmxyx+bcmBzS
         fhAdLU7UM5xgi/UXcr7LgE9AnjELfDdN5bAZAMydk9+iv9hWUGuJgUkUBjnj1dVE9nEb
         xjhQ==
X-Gm-Message-State: AOJu0YyDRRlsTZOJXQWN0PbRGLUTA35FQSKuBb4IM3avu3anRsSwTpFK
	g8b0/vl/o3+GmWYqCA58rteN5sYNgBR0PUePmLhYVptrvbxgiOTk+5KqrUKjIcw=
X-Google-Smtp-Source: AGHT+IFyov8dO82PiLmNVMmgfIb+vNpzx5fstoBpC7KEjzuH7yt3y/nlkS6ebQk5bLYliqGYMX2O7w==
X-Received: by 2002:a17:907:c001:b0:a2f:bf0e:ed99 with SMTP id ss1-20020a170907c00100b00a2fbf0eed99mr3629890ejc.86.1706010183301;
        Tue, 23 Jan 2024 03:43:03 -0800 (PST)
Received: from linaro.org ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id tl12-20020a170907c30c00b00a30abba5089sm730935ejc.206.2024.01.23.03.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 03:43:02 -0800 (PST)
Date: Tue, 23 Jan 2024 13:43:01 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: Re: [PATCH v2 08/10] clk: qcom: Add GPU clock driver for x1e80100
Message-ID: <Za+mRZD0v6zNZ27r@linaro.org>
References: <20231214-x1e80100-clock-controllers-v2-0-2b0739bebd27@linaro.org>
 <20231214-x1e80100-clock-controllers-v2-8-2b0739bebd27@linaro.org>
 <fc6f8e78-f704-4104-b3c5-bd10627c33b4@nexus-software.ie>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc6f8e78-f704-4104-b3c5-bd10627c33b4@nexus-software.ie>

On 23-12-15 12:40:45, Bryan O'Donoghue wrote:
> On 14/12/2023 16:49, Abel Vesa wrote:
> > From: Rajendra Nayak <quic_rjendra@quicinc.com>
> > 
> > Add Graphics Clock Controller (GPUCC) support for X1E80100 platform.
> > 
> > Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> 
> > +static struct platform_driver gpu_cc_x1e80100_driver = {
> > +	.probe = gpu_cc_x1e80100_probe,
> > +	.driver = {
> > +		.name = "gpu_cc-x1e80100",
> 
> I think these underscores are very unnecessary and subtractive of meaning.
> 
> .name = "gpucc-x1e80100"
> 
> > +		.of_match_table = gpu_cc_x1e80100_match_table,
> > +	},
> > +};
> > +module_platform_driver(gpu_cc_x1e80100_driver);
> > +
> > +MODULE_DESCRIPTION("QTI GPU_CC x1e80100 Driver");
> 
> "QTI GPU Clock Controller Driver"

Again, please look at other platforms (SM8650, SM8550, etc).

> 
> ---
> bod

