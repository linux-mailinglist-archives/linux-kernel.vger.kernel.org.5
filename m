Return-Path: <linux-kernel+bounces-111946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE9488731A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19F51C233B2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9196774E;
	Fri, 22 Mar 2024 18:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VxxM7E8U"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2544766B5A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711132187; cv=none; b=WWj3nYp7nk8o/j8hx5Ur/Xtqwe1V9rixjpBh8keyIIBej/SrgnuIw+c3ge29OC0EFhhOQJcmdx/AaxIMUpnyRZsApIo8XHcleNTMsBDLDnBl4plAMc7euuRSGhaQ6BW1JYW6usMbNlEOykTxI66rCXOgND8vHje6Dvz7dGAl/s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711132187; c=relaxed/simple;
	bh=X3GBYauhqIuqvIcR7Hb7hsupuQZottATKa79BnUfIrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHydle/8tD4Vg0+O3j8luACcV/4NUBnxiQiHLOBvB0bF47TYGbrjIE3nsAWYjExQiJuJq4i4w2zd2OwaAb3SEwF+t7C3nGYUUk/B8LpcdhxkzMdV9TVsMfVdP7RrSq9hHyX2A0RETz4IIm5E5yJFgnAdEittayQuarmPVWzbXgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VxxM7E8U; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a468004667aso346406166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 11:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711132184; x=1711736984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+mRICY5TnCZqU/4Za2HtNxYqccp5/DnWXp0xELZHP8I=;
        b=VxxM7E8UcXrd1l+ROvM+2urvSAARE3aUVc0e+6dLE9dBcBGDbqOUzwGPXum4+vX48C
         DrgDZ2tMj40aiNJekufouEemf0v/6+RCWBjQAiH8mBFq7OtTqIAwMmdJZW1/6Imvd/mD
         kopYfW56zgVHMRPl9Z1DoZ3hO+g3nx5wYJRTKoVz8nPFF6qc2JfuYjo9byWbMHigN67h
         8eQW78mn+/qsGBYKdI4/rJVjkmrf0BgtVf5eOko/yey6uSPMvgrcli7Jj2Ek7qjDnxdA
         hV1wprTbq64dctW+HoKmeUv45aMA408G/qb4vNeM5ulOKuuHPvKnGXdvq2xfjCqg6PqX
         pOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711132184; x=1711736984;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+mRICY5TnCZqU/4Za2HtNxYqccp5/DnWXp0xELZHP8I=;
        b=vczy01XS7d/rHOcWe9xHQ0l1mFcwVaY5Ky5AAIVtR84xC6Uk1cAPrO5SdI6WLCsaCw
         0UZ1wMN1FwnBs49lplyDOKqvUzQ2dL4avxPF3s8pdXRbgFdJKO5xMaYHbxXT3V/CLM3f
         ElZ0vfQ8dL1dCzfCSXgWlqRweQK5/YmU6SjaAiNyXxZKbijH05mC6vG4ItoTK8O18NCG
         uW6hpHVzoHSnn9UQTclqSdLx+ickG32ri7WMzf6nhJ3sm2bKUYc1hb8w61cAvm0pXBMM
         IEcRCIkcmBSFToAZB8dkHN0IpslDQamIJZ2JfIdqW3Pe8cHZ0j8cmIZoKH56FXdRJGZA
         0clw==
X-Forwarded-Encrypted: i=1; AJvYcCVydZcOymY1IWUyuFVSYJaP6IXCWp4GEGUnYHDNicMFxmyRMe5FbALJqY0SJBuyana7J1Wft8USxN3XGZHAu4zdbFbWjWrCqtABld4u
X-Gm-Message-State: AOJu0Yy1ROyj9hnT+xkJiqNmEoyLEEXXgoOncxqqTfiumO20ajzH18kF
	lsBuuao+WFz8BCh78Io0JAm68RMpIjKQFesDzbzDO99l9Lzp8qtWGwZAYY/TmzWplixLd8PuIMi
	HiSc=
X-Google-Smtp-Source: AGHT+IFBZ+qwOlzXEQiwepS8gMRPMWRkRTNO0hBdFwot4ZoVlYJC6MggnFQCwIYRRgK7FkDCrd63VQ==
X-Received: by 2002:a17:906:6d6:b0:a47:398f:1a0e with SMTP id v22-20020a17090606d600b00a47398f1a0emr389221ejb.33.1711132184394;
        Fri, 22 Mar 2024 11:29:44 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090679d500b00a4739efd7cesm92418ejo.60.2024.03.22.11.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 11:29:43 -0700 (PDT)
Message-ID: <4bf8bd0a-4e9e-43fd-a99b-a9b552f70798@linaro.org>
Date: Fri, 22 Mar 2024 19:29:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] clk: qcom: apss-ipq-pll: reuse Stromer reg offsets
 from 'clk_alpha_pll_regs'
Content-Language: en-US
To: Gabor Juhos <j4g8y7@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240321-apss-ipq-pll-cleanup-v2-0-201f3cf79fd4@gmail.com>
 <20240321-apss-ipq-pll-cleanup-v2-1-201f3cf79fd4@gmail.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240321-apss-ipq-pll-cleanup-v2-1-201f3cf79fd4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.03.2024 08:49, Gabor Juhos wrote:
> The register offset array defined locally for the
> CLK_ALPHA_PLL_TYPE_STROMER_PLUS is the same as the
> entry defined for CLK_ALPHA_PLL_TYPE_STROMER in the
> 'clk_alpha_pll_regs' array.
> 
> To avoid code duplication, remove the local definition
> and use the global one instead.
> 
> No functional changes.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

