Return-Path: <linux-kernel+bounces-103924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C5F87C69A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81BD31F21C94
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE84E11CBD;
	Thu, 14 Mar 2024 23:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qUogpZee"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEE614A9D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 23:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710460179; cv=none; b=QsvkdpoYWIjua074nB5Zg6RJWjydUeXRAchy7KDuYzM14PT/5cmEzXNdHZ5gegf5HKw1JQADYfeuq4TGg8AgqjsXVxYncUDQFiinrz4uuwqfJCdiNKYsudiDkhoq2weonhuGpNFb4GaHqR5sGjsJ8u1qeRTynG6KUbm1+R50eDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710460179; c=relaxed/simple;
	bh=WENTUOp3D5qKgO+Me5EIUQATACagdW7x0MfwkgJNAYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q5TIefuUwY1NBdHLsq/Tg+Cs1t2SRgY/H1n0PirnL83rNHSqmKgvkqh5FA/cltBKt9gWe/8V4lRYbzmFROdY2aYrDYoL+jn3kIZBcOB+KzA2BW+JJ+73WZV7lASThDPl7XC7wqINMpVrXYUMgpMmqTd5/tAfaMa+7T2XIS/LFQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qUogpZee; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-513d609a889so480916e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710460175; x=1711064975; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JDDmMzCYMjAaKsu18+oLY6uSXCtu/11fL+3ri7il4Nk=;
        b=qUogpZee0pG8hv6hV+Bln4Zh2yetfz3hlxa5RLlmmPgCc14B+F7GeCyOcLXkrO/EyA
         d+Nq+KzuHCs7u32i+ac+qaGwAn/ssn3are/wx87iljSGgRz7iY7Wtt4zRhmq7hkdYUjQ
         svN7sr9IHnawYCaJnbeNu2DNs4If+7jAUiYpCYfGgGxgsW+P2KjESIaHD23eDnTagTCF
         qKlwf5Qhs2D1hWP4aQ6ogNtc911+IAZ9d+jCK5QJhdB7uXJlDzUIiJgAzDUxoIPA6v89
         Yg8YGWU8LArQ8VhQljwbodDq/vNqoqBrTDgzxVh6WTe9i/3LdJm8Z09TD4dAxy5x5spC
         NnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710460175; x=1711064975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JDDmMzCYMjAaKsu18+oLY6uSXCtu/11fL+3ri7il4Nk=;
        b=ZdgSYo714JuEm7ktpWEikPvasvWrrk4rtFnVesyfCmntg6LMUgF0kLq4Mdmiel/qOa
         0irtWcz32pGd8VETtts31kBjqpkM9pjHn+hnvmGpFQ1l2ORL9w5FJTXkbrqYhGNcw3qc
         RPOTznGcLrZHQfGSp6XktrkBLWWSSE8eXLCAWpVoklJZXW0SH7w2I/Qc5jMu5m/T78Ct
         /45uwIEr51dJ+UIa77d3X69jOTGxBg2g+WOxgQgJhtsnIw65LrJSf3a/J74iweqMjShY
         DL8g2Ypjc1otcYuzaHt944nEzU+rSKUWTK7iu3PpuCPykNK1pgIrIscg5UKdDxmJTwTU
         jTwA==
X-Forwarded-Encrypted: i=1; AJvYcCV7AHn9Zo1bHZDvGk5QtOR3vjoLxQiQjz247C4AIdfRrGhsI2TdJGOqVp/arnGIIj8J8IdbE0Gzh3uHDCcfG6z+xbkdiyFKbzIWYCH+
X-Gm-Message-State: AOJu0Yx9LclNY9/81JL3h3no5I2NoRbfUDeZoOuZU5ACPOkUDRAJ2Egi
	1eDajnfc+xgMieg19ET7i+o/9XA4ps3sfdP/0U76UzjHICDrBzlkgg6YGlcJQ9o=
X-Google-Smtp-Source: AGHT+IFEcYIa4GpGeC93soGHGUNc0pmDIvNhbFoVaCBY2T7BXc4vsb3knxKvgcBO/BTy2mEbvdXVlg==
X-Received: by 2002:a19:5e4f:0:b0:513:d3ea:ec5f with SMTP id z15-20020a195e4f000000b00513d3eaec5fmr820021lfi.34.1710460175498;
        Thu, 14 Mar 2024 16:49:35 -0700 (PDT)
Received: from [172.30.204.13] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id a17-20020a056512021100b00513cd2e23f0sm444666lfo.149.2024.03.14.16.49.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 16:49:35 -0700 (PDT)
Message-ID: <359dafcc-4774-4ff4-8df0-03e3641082e5@linaro.org>
Date: Fri, 15 Mar 2024 00:49:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm630-nile: add pinctrl for camera
 key
Content-Language: en-US
To: Sebastian Raase <linux@sraa.de>
Cc: marijn.suijten@somainline.org, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240314200037.549206-1-linux@sraa.de>
 <20240314232043.1441395-1-linux@sraa.de>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240314232043.1441395-1-linux@sraa.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/15/24 00:20, Sebastian Raase wrote:
> Add pinctrl configuration for gpio-keys. Without this,
> camera button half-presses are not detected.
> 
> Tested on discovery and pioneer.
> 
> Fixes: e781633b6067 ("arm64: dts: qcom: Add support for Sony Xperia XA2/Plus/Ultra (Nile platform)")
> Signed-off-by: Sebastian Raase <linux@sraa.de>
> ---
>   arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
> index 87d0293c728d..823c21d5ee59 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
> @@ -90,6 +90,8 @@ cam_vana_rear_vreg: cam-vana-rear-regulator {
>   
>   	gpio-keys {
>   		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gpio_keys_default>;

It's fine to keep the "non-preferred" order, I'll probably send some
changes to nile and fix up the style while at it in the near future.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

P.S.
For your next submissions, please send the follow-up revisions in
new mail threads

