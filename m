Return-Path: <linux-kernel+bounces-60783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C97B2850962
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 14:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9571F2247E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDCF5B200;
	Sun, 11 Feb 2024 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tovtWCiI"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A193E5A784
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 13:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707658000; cv=none; b=bgmGzLBz+I4caSWTRxGbfHcmuY/L5//bB9JA+fbp5lMH/U98YDXBmtyKNZ7eMmaNSGiPwDiaVi9gsIX/7UsgeXN43vEORtc/+XnU0OcuRnP0MVHKq/xffTHkHaxOiqo0Gvr4072uTmj4S4VsK7Cu9vdc780KhktS06OEinOFWnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707658000; c=relaxed/simple;
	bh=FjS7shovD5LOW6BT11KewGOSXb3ZkciiNn0s91FqGvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X7kPaJmOBUzttOUM9vEKeYgyFAp+UUrbBvPBmXkjtP1bPEF4A8FhK2PsjTDqMdkFXQQSUes8kSIj66WoWahYXzI6bwikpNVQmEXa9ZgaE6FughqSn4gFnNzr0o5AMfllwckIPZEnQ4CS7Z/gETddC5Pm92d3vasfWtmCxI6GZTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tovtWCiI; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-410a12519bcso8004675e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 05:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707657997; x=1708262797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xPxJ93+8KK95I02oJbouz0NonAQApt5QRGNRPQGNo0k=;
        b=tovtWCiIlnNnwpB7C3NSuFiV+k7iFxiUFxIJRNPVU8HYGWW8LF+mveSHliRxrYXw31
         N9QebS0oSJKtzM5wTu93TZP7Bm7yychyGdStdaGAYt2awUi6YmrSJRx9PDFHapGiLaCx
         IB484w8mjnah2WeWq2OhgeMw35gu6Za+U6TOimJ5F3NLWWeI32ZPKjtE36TG3/RQmCOl
         5r21Lby2IdIpi35leYf4pDSCtMc0zEcGQRj/Sav7vX6J75EEAKzYNujSFDm4QjdfaGVR
         hP+60fILxhL9NXL4J0NS3/EkhLA1ebUwBMAjBf1Tpzm7FUJ1tz/d8bBQgxD3LCzw8nC+
         hl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707657997; x=1708262797;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPxJ93+8KK95I02oJbouz0NonAQApt5QRGNRPQGNo0k=;
        b=QIk3Sxq4dYSgvwJSyXSbulbqCD1qC5wJaq6OdguA0LCdIf+Xa+dr5S5Jdoe0hIAI88
         9gY1aiSmJDLd3Ttie/5keDVnP9nGqE47miMvD0Wo/aqx+QF4wNcCchFrQoP8SDVMVEKK
         /mjlBifzn0yJNMW3OVmXr6sFIfvgRTcOm/H0e+D/5ShHG3FuzriWo76HMO4D512IR70V
         ekvs+nKf4wTwjaM3G09+hE7AC7Oge9DQnYOqoQkxhPe02oRFzBZxAtMa99YCQE2bmxkH
         NgKkn2Jif9Kce0a5udV6dhHCshbThjYreWiHciOI/22cQ4WC3vg1MQOMHngJTOLIkE8C
         hK9Q==
X-Gm-Message-State: AOJu0YxjKlNDIq7cSHZofEERwLieBFIju2EAhmuOuQrX+tTHpXafSCgt
	nuD67+zSgJ5o0oYNJb5ZL5j0ZlAVpzpzMo4/VeBJzFk0XJm6Hvksy9I91xVC6r0=
X-Google-Smtp-Source: AGHT+IHSuP9KfPsmFMyKD6O+HI2IJr0O7fuSFaE+bYaU9fWG0+7VNib1QkzMDMEJCx0ZKWDpn5N+cw==
X-Received: by 2002:a05:600c:a385:b0:40e:f9f4:eeb3 with SMTP id hn5-20020a05600ca38500b0040ef9f4eeb3mr3875760wmb.39.1707657996904;
        Sun, 11 Feb 2024 05:26:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUuWZLRlQlD4S4QjUZ9pVJ9XReAJWPED191j8STFihW6pAK544LmDhapzOb7lBUL//zT0k8e3k8SrKCfh7G9PEUocSGjshk/Fkn14ccsogenOTA6oYB4zblwbALpzEleOGtjWNGShmBUsFJjsMoEE+PNIo2tD6FhaoxUw+if+RxXbikzjX0FuKvAkVim+czBc52ni9I/pRROJ+iRR4+8iaExJoWQrpbc8sWTDB9on1siQWKnAzUZcavVkd7ke0LiMG/vvAGzBIMV3nfndIQEKNLHX8upfvuU4SITjQIrCe4HKSXOQbUXKBJ7aA7GAbcoICV/aP5hhVf7YUj+dqDAb9v3zQbhrtp5kW0HqbR0w51NMdtF8N3nDIb+gtMQW7dxtqAcTTvuFBnaS9ZLjCo+iBvDS3N9N1tqwdJbjg/KPzVLMmtzkUwKfAVXJ08Se9d6eBp8Ng/wSTIWCQ7VVfDQJQ8jaNLiRgHDmZUn2f0bcoiBnfIP13FGnkjJ6KQpbvWajUeSXN3isIjZQrNnmttSF/CwdIGkCgQhB8rNedbs7Jiq17pQ1cUl3uAyUKn7tf+9gZqkQQa92Sc152HZnm9ZkaJ7HDK
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c378c00b00410c95ea9b3sm841333wmr.1.2024.02.11.05.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 05:26:36 -0800 (PST)
Message-ID: <a6ce4811-2a3d-4df6-aad3-9942a1bcfedd@linaro.org>
Date: Sun, 11 Feb 2024 14:26:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/22] dt-bindings: gpio: Add binding for ChromeOS EC GPIO
 controller
To: Stephen Boyd <swboyd@chromium.org>, chrome-platform@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
 Pin-yen Lin <treapking@chromium.org>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 linux-gpio@vger.kernel.org
References: <20240210070934.2549994-1-swboyd@chromium.org>
 <20240210070934.2549994-2-swboyd@chromium.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240210070934.2549994-2-swboyd@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/02/2024 08:09, Stephen Boyd wrote:
> The ChromeOS embedded controller (EC) supports setting the state of
> GPIOs when the system is unlocked, and getting the state of GPIOs in all
> cases. The GPIOs are on the EC itself, so the EC acts similar to a GPIO
> expander. Add a binding to describe these GPIOs in DT so that other
> devices described in DT can read the GPIOs on the EC.

..

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      cros-ec@0 {
> +        compatible = "google,cros-ec-spi";
> +        reg = <0>;
> +        interrupts = <101 0>;

This is should be proper define but then are you sure interrupt is type
NONE? Does not look right.

Best regards,
Krzysztof


