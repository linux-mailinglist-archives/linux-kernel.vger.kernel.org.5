Return-Path: <linux-kernel+bounces-60785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A6285096A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 14:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0A11F225E2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AA45B5B0;
	Sun, 11 Feb 2024 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="goECzwq/"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8F35B1F9
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707658541; cv=none; b=UMWxNgrTCaVMeDS2ZTzvHxRS9hTHOf/0GG6h27z6namrm95pS5IY8XWUaXYIgzm6ElQz7IBpQAKTIDydUsjD9vBRhlHJyRXzGPzUfae6sxq0TInUOHnFYCfCIoWNaOQhjoTrbEvfzDHi9a0moKmLY7p5vL7tGerPjXv46nPzZlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707658541; c=relaxed/simple;
	bh=DJSbRDAuFmTc1MlhG1zXU51ssBuCCydk6zoiWl4dFCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kfN8aMjZBgknAs7QOoComCRStotaCeFa3Ha/5ZHyNAwPOSdEQqxdevdzl2fXmf7qvCsVdEjwMxZXv9bTw4bcG8z2nzKYGyoaCt+mtEcJw/0HRtCz24C+AVqgSHfGSnhDw0ss3mRTZrfwrSHCRxnWLtJAHEEMxojLtnx3laVPW84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=goECzwq/; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41090edfeb3so7623265e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 05:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707658537; x=1708263337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WNM7KxTxqOC6h3zLzqmshbGyQgeE0x7q4wE47o6Tv6E=;
        b=goECzwq/HV/9qAhS5seX5gWW7T1mZEvkjAh3C5ZSJiiJ4zOgMEKhakLd/zRLQHsGDg
         2u53n2D+ElOJr/Ui/OM2hbhDvD0Hyyzaicod5EI44s35rV/7VnXRCbmbLSfVnp2oNBbj
         lq+UXYfTUjadmEGqg0v+wx8vwCBrTPnL+wy2SSfO2HtKoY6yOCsCgz42uVMbSQUBKZw2
         3j8Suz5afcmMDaEkpJvM2DRkVeG1FVi9JF/ZGb9oDUi7Vl4VmoWT5Reo3XOnMWCcVr6r
         I6yZcV950O/5tzQ3bvG4UarmxyMLmjDSC0AtTBF/+YaxlglnxPWqVdhnYawCbTWpV52p
         BTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707658537; x=1708263337;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WNM7KxTxqOC6h3zLzqmshbGyQgeE0x7q4wE47o6Tv6E=;
        b=D8NVeLi/MRFphWNmAKFg+RrWTrpgNQtwJ8OmVz1edO3PaZcV2vk6oJTqjShp9lYgHC
         eezm6zIxw5ciD1CoBwqvVyucGEQ6sAg5zPByhVP+fwFxH1j2W05xgsBfjDmtnT6mtwWO
         zEzGWIDH4N86ZHQzEmNdw6vlxHfnOKJ8mRxhHMr4iyS4oUE3v8th8yi0k4qEbZ4+j+yG
         WxG39QQ9NhoK7MAhLcjUfRkINbHaqfJ5u0bE8AckP0B1bM4FlLLqnU6XxG7bactPw2Hc
         yzZlt21XHEcdeEBe9TlQ0sQAlcw0fjj9Y2cHf5CqqDPTVN5+rnT0hw+oB62ToLu2YuMc
         i8gg==
X-Gm-Message-State: AOJu0YwXmxQLQbSx6oX7yIprSedXfHzfr5oifekKhgXPd/l57i6YqfoQ
	4i9e4pSOT9PrzSSZub9+WC5KnsaWMcBwPzF/Ws1A8xfb64Tx5fD0ON2fa4pTvXI=
X-Google-Smtp-Source: AGHT+IGN75xPhnd1CMUxGBm8NtGEOaPzey9Vd2xIOm9A6AMn5Ba6uk7c43rphjVTHhlDsx1gH7DhqA==
X-Received: by 2002:a05:600c:1d86:b0:40e:f3ee:5622 with SMTP id p6-20020a05600c1d8600b0040ef3ee5622mr3409852wms.11.1707658537250;
        Sun, 11 Feb 2024 05:35:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJZwKSjTN/aUWYpNKgzMj3IPbRrymCkKm8d4FOswr+DsaejnpfkIXo++Dt5cEnqf3jhHIoDE/uzsJcKc6Wsv0MNEPdWSpHIwMpqzgp7WEnqwj8kUiSof7J1HKDxpPqq6ZUxRqJ9RjQv9ZI6PC8I0J7EPVFIjvbcFMuExjL8xrfi89xlCZAEkORSbljJJPy7QZpGkEKgo4angGQAJKtauaLEmTB0cThK7+eDGYLM/I2kOYBuJ/yp5sJ8xD3zmmCQJCejoZs7v3A9tmqbRgYPaEt3+KMwimzcUHa/C88hFI4ivdSzH++SXfLpLs2mgoIhfUlCE95lYAWeRYzrVBtUoNErcKEzyYfTiQ8BaPNFVCytaFHrVtFafyIPz0uXtjfBJAU6P3WM5N5yB2mprXPyDYVL1yT4gTHPb5dAOIaYrxUHvrgroU7Z2jCi4yARA2TAvgWJnSm5hEfT6wqlf8UE0PFggTo6e2jiHFMGyA2xBbjfkbRAX3ecVM3b36RdZPDYs+CQuFWSGOKXiRGcH8LlylBBESslLe/accZVrWemKMJ7x7zZPCP+Cuj
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c298400b0040fdc7f4fcdsm5876671wmd.4.2024.02.11.05.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 05:35:36 -0800 (PST)
Message-ID: <8c7e41c9-8dcb-46f4-b8e6-8da2a6391993@linaro.org>
Date: Sun, 11 Feb 2024 14:35:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/22] dt-bindings: chrome: Add
 google,cros-ec-typec-switch binding
Content-Language: en-US
To: Stephen Boyd <swboyd@chromium.org>, chrome-platform@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
 Pin-yen Lin <treapking@chromium.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 Prashant Malani <pmalani@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>
References: <20240210070934.2549994-1-swboyd@chromium.org>
 <20240210070934.2549994-14-swboyd@chromium.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240210070934.2549994-14-swboyd@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/02/2024 08:09, Stephen Boyd wrote:
> Add a binding for the USB type-c switch controls found on some ChromeOS
> Embedded Controllers (ECs). When this device is a mode switch, it takes
> one DisplayPort (DP) port as input and some number (possibly zero) of
> USB SuperSpeed ports (bundles of USB SS lanes) as input, and muxes those
> lanes into USB type-c SuperSpeed lanes suitable for the SSTRX1/2 pins on
> a usb-c-connector. When this device is an orientation switch, it
> redirects the DP lanes to the proper USB type-c SSTRX lanes.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Prashant Malani <pmalani@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: <chrome-platform@lists.linux.dev>
> Cc: Pin-yen Lin <treapking@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../chrome/google,cros-ec-typec-switch.yaml   | 365 ++++++++++++++++++
>  .../bindings/mfd/google,cros-ec.yaml          |   5 +
>  2 files changed, 370 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-ec-typec-switch.yaml

Ah, and wrong placement. There is no hardware called "chrome", please
don't stuff things there. USB switches go to other USB switches (git
grep usb-switch.yaml will give you hints).

Best regards,
Krzysztof


