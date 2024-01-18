Return-Path: <linux-kernel+bounces-30438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D09A831EBB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED291B233E2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A06C2D603;
	Thu, 18 Jan 2024 17:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LYQH+sMI"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5172D057
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 17:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705600120; cv=none; b=ATECFx9eQmsSIEKCS0qzVhxrZQncl7YgJOnjNRllU8ua17lKxoLTy5/MV1IWJXb14K8rtHRQ4SBO0AdMCHrWwcTtgp2tnewCUGyQDYpCYi5e1dcNPQbigJX2fDVD3FLVpf6NbD8ZnGKLddppg7hzLkHvRjgsp/IjuTc2al0ZFwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705600120; c=relaxed/simple;
	bh=keLTQk+AvKOmkA5Q5qxRwla5u79ltM2//juuofixUWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OyLkNp7bpkoGkillBh7v0Fi118tmpoHRpEQNMvmeqG4FfOSdNvq9ALNIdj4RC7p25/uV0lIKnl4NPXQDifP1BVmX5kqOITD0SsFxtvwcz3cEdX7pOurEVMVGTN1mgJwQgVc5zRNi8dPYR7Y5TdOEzYOhfG/iaV2NudByZgSyLRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LYQH+sMI; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50e80d14404so909387e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 09:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705600117; x=1706204917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+LkCXUxxtx6J5Nl/krXuwZsTy4uKTB0BO66v6ghWpv8=;
        b=LYQH+sMIsYAyKEHIloqnBCDHoy5IMsfNe7xonzgOZw5Tr1QgFCY6P02ziruZVwr7ik
         vSTBMuQtoBaM80z0qs292No7z5BxG9LZNLGbESd6EHaxNGHNk5sj563VxttAAk9IX21B
         52OTuo1W2veN3nNv4g0ZiYoISv6LiuBNXRhlLiJ7/t5txipHToTHn8CRY1vvu0pySr5k
         tgQ0q0yMTPBu2UgWNEtFQuKL5ZGxvvX0y0NUmc1ZjfiaeCz4XLkciTlMPjoqMHxmfeTg
         qIgXDoHLGcyWrc7vd2n+0o/EhQJ0wzt5MjAz0oX5XM3OwWoz23OJq9mi59JzEyXX2bO9
         bbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705600117; x=1706204917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+LkCXUxxtx6J5Nl/krXuwZsTy4uKTB0BO66v6ghWpv8=;
        b=seo5c4r9jh+P9eJJViv8ugfK1U4nopskWPfmPuh8ObzvitjZoSDo+y/6j+ewn7vjXH
         J07POymW/EvwkeOv7+pKoGXi44N2Ao74LLE4usBFs1bQvBLlloj2jFKHKPPbANbX/0Eg
         e576viD7zE348pyzKQgLd6WweLf8WGwfRinba3NsA3Y8sAo7QNEeebSE92fhYYJ2sksx
         WL4VcCH+485FcJOAlrmfNJzASBFsooSMkZxO3uTblyRyAIUObE1yuxUaQTHY6jqg0fF5
         D3apGtiYLM1pZ6HyGJLpRnP9UM31TEolAdfw13b/gcP5xs2UDd8Y+EktSHsUPHgkZcnQ
         8yqw==
X-Gm-Message-State: AOJu0Ywl1WwjWWcV9rrmYvnQwPvBHIJNmcKR2R7NB522UtENE7V7MxK4
	KzENzS+U29iqvSoZlxiU8nqH6dIGF0+1LKE0zw0AGkLTNRNrTfKZgTDXQ6zKk8k=
X-Google-Smtp-Source: AGHT+IG1n4qraOcDtB+OxaJOSlZ4etRCW/HR1z6Lghjg+8zt4pAxHJfyfgyq04DeO6jqaft4oJwxlg==
X-Received: by 2002:a19:6408:0:b0:50e:7bed:af45 with SMTP id y8-20020a196408000000b0050e7bedaf45mr1928736lfb.33.1705600117035;
        Thu, 18 Jan 2024 09:48:37 -0800 (PST)
Received: from [172.30.205.26] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id y18-20020a196412000000b0050eed79975dsm722417lfb.24.2024.01.18.09.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 09:48:36 -0800 (PST)
Message-ID: <9b78a7c3-dea9-4d9c-bfd9-13d819d68890@linaro.org>
Date: Thu, 18 Jan 2024 18:48:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: gcc-ipq6018: add qdss_at clock needed for wifi
 operation
Content-Language: en-US
To: Mantas Pucka <mantas@8devices.com>, Bjorn Andersson
 <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1705486629-25592-1-git-send-email-mantas@8devices.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1705486629-25592-1-git-send-email-mantas@8devices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/17/24 11:17, Mantas Pucka wrote:
> Without it system hangs upon wifi firmware load. Bindings already exist
> for it, so add it based on vendor code.
> 
> Signed-off-by: Mantas Pucka <mantas@8devices.com>
> ---
>   drivers/clk/qcom/gcc-ipq6018.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gcc-ipq6018.c b/drivers/clk/qcom/gcc-ipq6018.c
> index b366912cd648..7cdaf7751566 100644
> --- a/drivers/clk/qcom/gcc-ipq6018.c
> +++ b/drivers/clk/qcom/gcc-ipq6018.c
> @@ -3522,6 +3522,22 @@ static struct clk_branch gcc_prng_ahb_clk = {
>   	},
>   };
>   
> +static struct clk_branch gcc_qdss_at_clk = {

Hm, QDSS stands for something something Qualcomm Debug SubSystem
if I recall correctly, so coresight and friends.. Are you sure
it's necessary?

> +	.halt_reg = 0x29024,
> +	.clkr = {
> +		.enable_reg = 0x29024,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_qdss_at_clk",
> +			.parent_hws = (const struct clk_hw *[]){
> +				&qdss_at_clk_src.clkr.hw },
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,

Does it need to be enabled 24/7, or can it be attached to the wifi device?

Konrad

