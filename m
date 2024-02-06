Return-Path: <linux-kernel+bounces-54665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 350D384B236
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 709E6B24220
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B699C12E1E6;
	Tue,  6 Feb 2024 10:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OIGtq8VF"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413EA12D15B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214418; cv=none; b=FmjYcsXpt6IW/WFazSZEw+Z/3FspIUnJNq2Di4U77kayTCmL7foLOxnArXzuBP0+dBHPY7ffII0O60XfGRZCxZ0TFua0SwO3KP5tnbIznfSLeXf9sHjRawXDSTSjcMCwH08Q6tDsGe90qviJ1q3s458OABmaNTXbL7/AFA4MMIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214418; c=relaxed/simple;
	bh=ES5DulenbO2jNzgXEvkVALHaZcmMMTTNwhTpxCi7ykk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zn4jv4nzzPYvqFjMF+UEqPoA4V9+0SwcjWiDAQTjlsSYZ7F/xDLd6zzMEIbqkskEqDpD+0sNGdVGxXD0NDyUHq4a2OWz3qNtgrwAIp/+LWe8nORmEdvCH1AjCi9XBDo3erZpfKZKEEtky0t5mnLUsaj15TZESf6UTyA61vHn6oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OIGtq8VF; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51160b0ecd9so255627e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 02:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707214415; x=1707819215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4TauOb4HWAK+0/oVOi1TP0gSxUqaGVxDXkZkXlGvmMI=;
        b=OIGtq8VFpK1hAEQ+98OUwuNxv01fMoRDqYFF1iQA3vIJhJ79klH3/QWckwWrR0kyAx
         NT14x2RK8+1VNDxGN2evooe+7cCmn49U+S0ju30ZQ4cTtjL44H/t2LEBedKyV7Nkp+/r
         KhWuE28o9jqW2bO0mhIA8z8J52zY2GwbDVUVgl1I8eYKVmWSRJORVvNjYUsto5S1mBsI
         9KcHF0X4n8OPoabF2uol1XfkzcQS4gdoN4zQRnhZfTHYPQqhi4zwmH6PDzFUFeYDGaDW
         fS/43orF5nhGCLSNUlUIXWWJWTaTBW/DTy1pYmqqbBk+jz9yt5y/oY1T5sI+jXBGGYoN
         kYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707214415; x=1707819215;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4TauOb4HWAK+0/oVOi1TP0gSxUqaGVxDXkZkXlGvmMI=;
        b=DAVMnta7W+rSyr2Ygkoe/YoesEgIu5RZ0kXl8YCAJBg5jofC6ue2BM4cTjl+QZvS4A
         g01cZqnYduhFqUBpA9ZiKEoSpRB6CyWaBtIbrhK+DV5P7QTek0FeeNCNDU0ID/vpqE8P
         zPgl7JexkQuJzqNyBlbrl0t1kfIo5nHDy29dFdj8fPR9n7nkFBdlCUpYfm2IrrSZmYE/
         aHVN3xLiUfoTwcY6sfESgV6yp3vPSt1pfB8dUp9GtjRHjX1KVZXFin/GWyTRngbhvq+f
         6gCsfjOPNOXlB9JW927d216bW2lm7KsQxzf+LLc2FTGn3jrrPiUnDOhmkYFLFdHwF5Ms
         PsQQ==
X-Gm-Message-State: AOJu0YwinDTXz/gXeb/YYOudJlOd5JPTGo3Et22GSf6lXChZpLmn4JCi
	EDQnVhybsnNxeRST0V6MEHuiiiY2U0Erx1MeUNhjN84RnhBX83/uNHYZUX0hQbo=
X-Google-Smtp-Source: AGHT+IECd+tPDV8Ho5+Rq6CRF89fOpY9JOCpM1FHCbpH2BySf7oEQKM8dwlrbShMUitQuI84SXd3+g==
X-Received: by 2002:a05:6512:1248:b0:511:5ff3:bd91 with SMTP id fb8-20020a056512124800b005115ff3bd91mr907076lfb.69.1707214415361;
        Tue, 06 Feb 2024 02:13:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWMOCT+WeCpXwCwC+tguk9v8O+HUYh1uRrStg1Y9vebrN8l7qyqr6DTkxJ21jleoB4qTmBbiphxUseKtYHwdueekgb/vQxA/bJuJw2ZAHPh4ojgeCi/Z+CCfsVWWw4JRX9nshMtjuKwqPbp1gDuWZ+bydqHesaTkLr/Xs9/2JmXxHkpG+JCG3gzyKOvgcr6pR1zOX7Lug4F+3kTjBYAbPhUJwC8eanZPqYN9Y6CjR1NRVtRQ8eWzMlcMu09EW0LLxF+SWf/iHz9b6vAsQx2Pv+/ka1Nhwv59uTqHITWOWNZX0JwF2HDP33qUe8VaKFmkOuq6ybKcqYOOLVpBmwP2JdLjGbX0SOCaf2/6HqZoPEsdHd2W8IaV4px5GrFcy/j7G5mUFYxRbu4/6EeIuFTM9MyukVG2gDXPxBnuawk2mbTU5q9sFhWErqfqbvXWON5JRLAGCWA8ZxtAZutK3YEbe4WvPjP+R6GlTOwfO9jdnC6bf4M7zZyYUn2KYjK3ZlVvhLYhn2+LjEFiRcoKnghSoIerRsKmCEtqtqa0WQ7Yjhc1mzo6M6Ll20YoQH400134404X9I8KFMy5rXZRIwhbTJ6RfVnqpCOEyuPAi+vVdHAzH4BXw==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id f17-20020a05600c4e9100b0040ec66021a7sm1484053wmq.1.2024.02.06.02.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 02:13:34 -0800 (PST)
Message-ID: <4c648128-8f87-46b0-a38d-31700d0f0e8d@linaro.org>
Date: Tue, 6 Feb 2024 11:13:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: exynos: gs101: add chipid node
Content-Language: en-US
To: Alexey Klimov <alexey.klimov@linaro.org>, alim.akhtar@samsung.com,
 linux-samsung-soc@vger.kernel.org, semen.protsenko@linaro.org,
 peter.griffin@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, klimov.linux@gmail.com,
 kernel-team@android.com, tudor.ambarus@linaro.org, andre.draszik@linaro.org,
 saravanak@google.com, willmcvicker@google.com, arnd@arndb.de
References: <20240201172224.574238-1-alexey.klimov@linaro.org>
 <20240201172224.574238-2-alexey.klimov@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240201172224.574238-2-alexey.klimov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/02/2024 18:22, Alexey Klimov wrote:
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
>  arch/arm64/boot/dts/exynos/google/gs101.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> index d838e3a7af6e..156fec2575bc 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> +++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> @@ -283,6 +283,11 @@ soc: soc@0 {
>  		#size-cells = <1>;
>  		ranges = <0x0 0x0 0x0 0x40000000>;
>  
> +		chipid@10000000 {
> +			compatible = "google,gs101-chipid";
> +			reg = <0x10000000 0xd000>;

ChipID has size around 0x20 or 0x30, not 0xd000. Maybe you are defining
some other device like OTP?

Best regards,
Krzysztof


