Return-Path: <linux-kernel+bounces-80291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F866862CF9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2C771F220CC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D9A2F58;
	Sun, 25 Feb 2024 21:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NE9GVINS"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB62E17997
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 21:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708894816; cv=none; b=HD+SC3rxCgLTQODGqrXz9woW+2OVGNd8jmhMA5IJA45//pXorVIAauF3E8uFxcYwUYSCBkAGYdp9p4D6RFY3gOaxb1cjec2YNq6FAajncCugGswoWV5T2d4SliQgSgGmwFQ1w1zoHb4Scr0qo3v54itJM7wqOJ12v3d3dIc4xb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708894816; c=relaxed/simple;
	bh=RGnNJIFh2RlxUmTf+Jzt1Dq2dHc/VwgJ5UcUdS+OMfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3tWzLqfw1xEAl1KQC1CbJ0wXDNqNvUnTl0DVyJTObABvb/qkNTimaoQ7W0E7JgpDJW2Nzih5u0WfUuyKL6AkF0p/XEeZAW86OnWl3KQ5skTJj8iIhAKv/4MakrcPxEEMI5tfo5ECT5zCwol4ybUikPT7wxHNJrQEdaenOUgJ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NE9GVINS; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bb9d54575cso2085695b6e.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 13:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708894814; x=1709499614; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VTc8BgiqrwORqW1mws8ASxivs+vKldj5oWJyp0R6vLI=;
        b=NE9GVINS2qFWfiUWKyBakvO4wSHMySBRMVSl/MVDHDdNLpNtzJROtAt6+GAEqDList
         dykR5RVt9CnLS3MmZhTCkXA03N+Rn2RvPMYCwdRLaLf8fBucaHfPPxAlP2MqUcKhzqsk
         syPQNUFDv+HX/78LHiZmwzca56SLwgpPpiDpVCblAoX03h2U3fSKh6mFUWLquq8bSIeq
         h6wNAgdvgkBUflvgyjE86qgoo6TkSWqELDAvHHSKYV5F7vPIGH7by2enLNcURZiaqZUa
         SLMoc55IDiOmm0CMAk+QRCvSRSMGRzNQkdSZnnYMvyf+0xSqLmWdNhM+BwyoeEak+sFu
         FJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708894814; x=1709499614;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VTc8BgiqrwORqW1mws8ASxivs+vKldj5oWJyp0R6vLI=;
        b=pG6uDLQjT7X+Ao53mPju31hEDJCcFSg2dlCShofjI8fE8TvZVQoqlSy0twa6o7WMhR
         tnzk4f0cd3CLuMvg6tY8hn9HMx1MV7rAhjJ3aVvjnmDVrcESRuLH8LR/QXsi1spj9awO
         BVl9BPk0hbnDDpjlE+uXSW/YFoo7Xjiy27SnWkpNBbOHOdZN3YHvuJBbI6gZ0ugwI4+4
         TTXZf5g9SaQp9LptMxzTUzN6yrrvE+L9YsE++dFnwDRVxLEid3WJ4qGtVBh3p6AEK75g
         FrtMrlqz2Fbypt8YcZUhWozJIyZSmZ0QOOSnvMBlb+W1Bm++GUTUvnJLXp4JXLoKHqzs
         ERYg==
X-Forwarded-Encrypted: i=1; AJvYcCWzcPHZ4WAklC9Zjb7IAqpXQto9hIpqrRNU9eOkEiJkbj+3R8hFHDjtCw1ad+Jhyb6LgTjA3O5cZZVjjYXzHjoeD1yr7VTKFH5LSxRz
X-Gm-Message-State: AOJu0YyySVEkqGBaBnucUnv9c8XvCXSC0mxmFEhBPRbV1CWhw7ANkqgz
	KyFdaeYljafuSHGrGYab/3Ao0vtbfB+DTtdnzmthvvhH6hyWdXWNjOP8cPgLmj72gLZ4GIvXH4u
	lzqB0jBwfmG0FyaADSTJg44LCC1dTfloVfPgbZg==
X-Google-Smtp-Source: AGHT+IFdc0B7r0WWDHCZB3fKTckGL+wqd/Gdd8YziT9x9zVc2VZGhoIvTE0GCz3w3kcIFq43L0vVQvGlTDRZpVyRJWE=
X-Received: by 2002:a05:6808:2085:b0:3c1:51c1:f4ee with SMTP id
 s5-20020a056808208500b003c151c1f4eemr7018711oiw.48.1708894813963; Sun, 25 Feb
 2024 13:00:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225-gcc-ipq5018-register-fixes-v1-0-3c191404d9f0@gmail.com> <20240225-gcc-ipq5018-register-fixes-v1-1-3c191404d9f0@gmail.com>
In-Reply-To: <20240225-gcc-ipq5018-register-fixes-v1-1-3c191404d9f0@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 25 Feb 2024 23:00:02 +0200
Message-ID: <CAA8EJpqX5kwiQdPsSbJM=-7hd6mqwOSw_=7zyWOWQOi4=QYFJw@mail.gmail.com>
Subject: Re: [PATCH 1/3] clk: qcom: gcc-ipq5018: fix 'enable_reg' offset of 'gcc_gmac0_sys_clk'
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>, Varadarajan Narayanan <quic_varada@quicinc.com>, 
	Sricharan Ramabadhran <quic_srichara@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 25 Feb 2024 at 19:33, Gabor Juhos <j4g8y7@gmail.com> wrote:
>
> The value of the 'enable_reg' field in the 'gcc_gmac0_sys_clk'
> clock definition seems wrong as it is greater than the
> 'max_register' value defined in the regmap configuration.
> Additionally, all other gmac specific branch clock definitions
> within the driver uses the same value both for the 'enable_reg'
> and for the 'halt_reg' fields.
>
> Due to the lack of documentation the correct value is not known.
> Looking into the downstream driver does not help either, as that
> uses the same (presumably wrong) value [1].
>
> Nevertheless, change the 'enable_reg' field of 'gcc_gmac0_sys_clk'
> to use the value from the 'halt_reg' field so it follows the pattern
> used in other gmac clock definitions. The change is based on the
> assumption that the register layout of this clock is the same
> as the other gmac clocks.
>
> 1. https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4.r4/drivers/clk/qcom/gcc-ipq5018.c?ref_type=heads#L1889
>
> Fixes: e3fdbef1bab8 ("clk: qcom: Add Global Clock controller (GCC) driver for IPQ5018")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
>  drivers/clk/qcom/gcc-ipq5018.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

--
With best wishes
Dmitry

