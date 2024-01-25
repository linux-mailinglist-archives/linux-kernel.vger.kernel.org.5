Return-Path: <linux-kernel+bounces-38500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB2E83C0BB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F911F25288
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A262C1B5;
	Thu, 25 Jan 2024 11:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="tpfl3Nwk"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DF64594D;
	Thu, 25 Jan 2024 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706181828; cv=none; b=Ze7rv4y/qhIvHAlvNxLMP0D00wCYEslPMeqSpWVwmIpv8/wrFIVSNUUEKzxsfsA7NBCNoB/gmn1imHS5nAxSY5OUPnlSApXSVgHJhWdD048LG2z3uuf+vi3RiIxnmNa9g03bs3mftGtBe5ewWEQ9wSB1dMtaw5CkI8Xg7agQF10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706181828; c=relaxed/simple;
	bh=Uu+Kk+F3SFhkK+G9oXazlo4Q3fgVXLCk2hDT+fOsZgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W/PCd9FHzvRg+YHwAWnrDRSpMhHjCCDECH6b4HNDsOO9OREz2x8VI+2qpx2FxU4b1sqhdZHSAs6gYay+nfUXPn2rHMCUuiqyzSR8aTvIey9OmKINKnrCXh0Eu3WubbJNlVoSQOPUtymtWNVsJtv7F3mQaaebcgSiFfi57Vp8mgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=tpfl3Nwk; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706181825;
	bh=Uu+Kk+F3SFhkK+G9oXazlo4Q3fgVXLCk2hDT+fOsZgE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tpfl3NwkDvB9rqHZp4zvSNJIQv4mPUBxpjbrijtRvWXAIrI16MWGKI7Jru0XlY3Mi
	 Fifv4/F93ks/6Fph6jKfjK0d9lijIIa/Ipoa9mWSvKLN0qIaF2Q7NUTMcRLEoDBtPX
	 ztVBB8R9PMfWwMS+5J12CVY7uEJwWvKjs8gDGruNTqfeN4T2+Dy+vTNVt8wRdXKxcR
	 plGG4GFTnvxsWvPDTKpiKURYkKjAcf2Cy52nC9dmNOZjdmqkO9rR0JRhHchYgFXqKd
	 LwxcBox227Gh/NJhnE9r2aLK6VIS5TzcQCZjxl3b4oWUJIRzJVvWpk/t7QVP9WfiKM
	 BvWZkvLLT3IWA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 93EA23781182;
	Thu, 25 Jan 2024 11:23:44 +0000 (UTC)
Message-ID: <2452472f-72ab-4422-97a3-1fda7ca8c862@collabora.com>
Date: Thu, 25 Jan 2024 12:23:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: mediatek-hw: Don't error out if supply is not
 found
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Mark Brown <broonie@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 "kernelci.org bot" <bot@kernelci.org>
References: <20240124-mtk-cpufreq-hw-regulator-enodev-fix-v1-1-6f9fb7275886@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240124-mtk-cpufreq-hw-regulator-enodev-fix-v1-1-6f9fb7275886@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 24/01/24 21:31, Nícolas F. R. A. Prado ha scritto:
> devm_regulator_get_optional() returns -ENODEV if no supply can be found.
> By introducing its usage, commit 788715b5f21c ("cpufreq: mediatek-hw:
> Wait for CPU supplies before probing") caused the driver to fail probe
> if no supply was present in any of the CPU DT nodes.
> 
> Use devm_regulator_get() instead since the CPUs do require supplies
> even if not described in the DT. It will gracefully return a dummy
> regulator if none is found in the DT node, allowing probe to succeed.
> 
> Fixes: 788715b5f21c ("cpufreq: mediatek-hw: Wait for CPU supplies before probing")
> Reported-by: kernelci.org bot <bot@kernelci.org>
> Closes: https://linux.kernelci.org/test/case/id/65b0b169710edea22852a3fa/
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Makes sense.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/cpufreq/mediatek-cpufreq-hw.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
> index a1aa9385980a..8d097dcddda4 100644
> --- a/drivers/cpufreq/mediatek-cpufreq-hw.c
> +++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
> @@ -312,7 +312,7 @@ static int mtk_cpufreq_hw_driver_probe(struct platform_device *pdev)
>   			return dev_err_probe(&pdev->dev, -EPROBE_DEFER,
>   					     "Failed to get cpu%d device\n", cpu);
>   
> -		cpu_reg = devm_regulator_get_optional(cpu_dev, "cpu");
> +		cpu_reg = devm_regulator_get(cpu_dev, "cpu");
>   		if (IS_ERR(cpu_reg))
>   			return dev_err_probe(&pdev->dev, PTR_ERR(cpu_reg),
>   					     "CPU%d regulator get failed\n", cpu);
> 
> ---
> base-commit: 9ac3ebaef3cc43ecd136911c44f1427286ee5a05
> change-id: 20240124-mtk-cpufreq-hw-regulator-enodev-fix-f614019689d0
> 
> Best regards,


