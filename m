Return-Path: <linux-kernel+bounces-32667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24399835EAD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45E0CB23195
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259F53A1D0;
	Mon, 22 Jan 2024 09:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gSzw/4C+"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E6C3A1CC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705916928; cv=none; b=SsEQMmI9k8ngHt31KRANFxvcBtYKf0mXco7E63x+sQZOUsHAMYQh+k1PDWCt4uHJ4bCngX33mVr5ihvaXnD9DqfQVlj9EO129ZFGjKkqOO6KzSKFOhArQHltDCSwA9W24SZLRbE203pB2HNlmGsNoMibiwqjuWR8zYeJZKfpX1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705916928; c=relaxed/simple;
	bh=zs+IzWv7BGf0iHoLa92wO1JHvP42ItYzZZEb2+pBCPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iQXPAjBqwpRQ39q7O7KTXdooddzMNdnWHDuJAMSqIEjzZWLQXjdiWOrUnI/DNnRkggH1u05ZT38aQIWu0TS7pzeWURi3i5PCFstJ0+icYLKW1HbfvjU0n8cNkuvFYtaiNbIYHDB+wudquIQF2uNAe3X7NVeGtRoJYnzvYxMbRRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gSzw/4C+; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40eaf973eb4so3954025e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 01:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705916925; x=1706521725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eihKfD4ZeFfvr2mt5r4HJbd6GNB7vmqvwDp7Bwjnuto=;
        b=gSzw/4C+JyMfxovfnYtZy/BYFkxGiEfZ5yRtY38JH/Bx1lhvOkd+3XMMt5chosOz+4
         ylPj7YBEEAMplD49ceVJUi4Llf80lcHfA0KeOVhXEPx4dHw6RIsgcQGfRhCuuVWbrf1B
         KpHSq9P7SpHottufUpxR3MMV6ErOfq4WFJlYerbPZFP/N2CNgZKSL4G24y7dMPixvhK+
         IxjF+AJLNQtQpBprdxmKYlcme7fWx6vF6QSRA0pwzr5CJ6O06EWiFYYCzvzM74hXcHyN
         7Us0bbBh7Lc/uc9SoWG53LNMYc0Df3UR4sRRUJZgfB3wr7/467HFvoWTzRrd1fPPXHLV
         2nqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705916925; x=1706521725;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eihKfD4ZeFfvr2mt5r4HJbd6GNB7vmqvwDp7Bwjnuto=;
        b=E/1KZvouU2DRXN0yaypDO+0FaTcytyKHxlJnVISUUeQQeI6OmAsep8FGQ8MIWBTMpX
         fXnxx7X3qJymYCJ8QXFzcl3p0Uy+6XHxmsmRuymVDYBPLWi+/2xqDo4QC2+1/mtBbDpt
         jJLGJC/w8cVgrBbXxTZh3ne0ZN+VPykZZ1yeM4WfpKSyklHOvTNEcpGx/aD8e+NrYHvG
         VaRRGf2h8SA+xXg+m0ho8IBJq+BpzDpscrCEO4BrQNvyt4ZPtzoARuuCXe6bEw+ziv0Q
         5CjKyBMWGZ2+XB0rxjwDR8XC2F2tEteQew2Uz2T3xBd1sR0JzIZJVjN5hAsmlznweeAo
         lg4Q==
X-Gm-Message-State: AOJu0YwEYt0KG0fTP1Yn+IdQZqgopswpYCvYBzXkrUt3P0EYlyAzFkZ+
	h7dQ3czXW61zTw/PfgxK3ckAa0UMF94htIJ8mz0/vY8+Oo8mZF+mxOxJt3ldMn8=
X-Google-Smtp-Source: AGHT+IG4aNoKyllQO2WLngbFXQ8EDRWtArYfZNoNzMSn+fF6TtXPxNEzchM5uLlLMkb9vpVx2ia+tg==
X-Received: by 2002:a7b:cd10:0:b0:40e:550c:a29e with SMTP id f16-20020a7bcd10000000b0040e550ca29emr2318548wmj.220.1705916925116;
        Mon, 22 Jan 2024 01:48:45 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id x16-20020adfcc10000000b00337b47ae539sm3154432wrh.42.2024.01.22.01.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 01:48:44 -0800 (PST)
Message-ID: <12e04abf-7720-4c2c-9f1f-0cfee7ba004e@linaro.org>
Date: Mon, 22 Jan 2024 10:48:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ARM: dts: qcom: msm8974: Add device tree for Samsung
 Galaxy S5 China
Content-Language: en-US
To: Rong Zhang <i@rong.moe>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>
References: <20240121154010.168440-1-i@rong.moe>
 <20240121154010.168440-5-i@rong.moe>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240121154010.168440-5-i@rong.moe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/01/2024 16:39, Rong Zhang wrote:
> This device has little difference compared to Samsung Galaxy S5 (klte),
> so the device tree is based on qcom-msm8974pro-samsung-klte.dts. The
> only difference is the gpio pins of i2c_led_gpio. With pins corrected,
> the LEDs and WiFi are able to work properly.
> 
> Signed-off-by: Rong Zhang <i@rong.moe>


> diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-kltechn.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-kltechn.dts
> new file mode 100644
> index 000000000000..5a8d59ea4439
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-kltechn.dts
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "qcom-msm8974pro-samsung-klte.dts"
> +
> +/ {
> +	model = "Samsung Galaxy S5 China";
> +	compatible = "samsung,kltechn", "samsung,klte", "qcom,msm8974pro", "qcom,msm8974";

That's not what you said in the binding.

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

Best regards,
Krzysztof


