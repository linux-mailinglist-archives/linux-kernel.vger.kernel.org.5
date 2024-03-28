Return-Path: <linux-kernel+bounces-122702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F8E88FBBF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1B129F094
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D121E612F5;
	Thu, 28 Mar 2024 09:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p0+rLZq8"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63828535C2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711618647; cv=none; b=rblgXXOiF4rPFG/InjJx3iZ9I9UcwBPGNzob0qgsSQ0psoHWzs7mmsLEQ/FWdB6KTs9Lm+kAyT3kEcNNvIjrdG4h9ofJ7Mcdnk7sOo44nY+YEeQ8lf3LYzHFPaRVD+kKRW3q/aK5pBZeDLX7Oms0Dofu5v2BMvBTg5KeMRSrNpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711618647; c=relaxed/simple;
	bh=a4AjwX3WtlLWWVRufGXqLFoNRF3EKcANglNWbLJOHSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eNTG1n09Vpx5WDpDyQeunlI0IqEaE/qZq9W3PDSjOxZlNypQseC/i1pZ+wTBmRswAVTQHQXj6M9guFup9wQ6TdungZEjHhG2fxz4RHJ1EDwAEpfysNtt+bjCLPBNqbTPsJYf0WMYD7SCdi+qJ34yZSCWYBePrJfxVRMWYQ0gznY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p0+rLZq8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4141156f245so5258475e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711618643; x=1712223443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eKly607vWTdB5lp9kf/kHWzn2IFxC4Ylpr0pNRgNlvQ=;
        b=p0+rLZq8LLvRxMEWc5+eChdTSI7XRNcmV7w46OWBe7OBuYh2eOE2W9q7Tm1XffXPXy
         SH75rR6Bifvw2fjGVNqo/QfPhOk7JKaUyGJnTp/BSXQVQHvzxIKDEz0CCcOv5u2ohi5e
         W9OHD1QvgJ4vPihdUBkWwcEJM1FknPEw4caV7uZbHSErXNeDVjU5GJ11+2hlJnzcnOAo
         in6CViULtZ204+Bj6r6e9NPLo2IhlfKZObgU9lkeG4Dd2T0I8cgNHcAA9d5zTW3AJIzB
         vK1QmNGSQrVRjo7Va+gMqVDFAusbH6FHY7yf1mLlM+AbSUKn6/zZKXbQ4LRmI41/LYYf
         z46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711618643; x=1712223443;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKly607vWTdB5lp9kf/kHWzn2IFxC4Ylpr0pNRgNlvQ=;
        b=KbS2L62wT3gRvBjPeFHNKFPAuc38RfVH8s+YejGsIrVEkMptcu1c2+COFttd0bFEnN
         tTaKEN7WamxBIan8DXUkpeq+P5B3o8RPz4K/Zr/SfqFVefssB2QbMErFd8pKiJDekmt0
         IZ6gE9XNBbaEewLCMGpIPefaRviQDXuEZgsYiYpOrCiJwRGJEXw9rooc5kzg5pj1n1vU
         9hrAn1YZ8MuYmYzjgZ8u9xOdbqpWzABzsMi5n071Ukc0Ck1M5tKUam7up2NWXiys3B14
         CbBqmcvX3vD3+N3Sdpu/fxb3yosxvSb/waB3/gIknRTCXw0RhKfWsgce9Ux7TAA74+ca
         I1sA==
X-Forwarded-Encrypted: i=1; AJvYcCXxBcaew8BF9nqmGYasVzPlvpdBIEBLA62eV7+zviTSjJWfk09z3KOp2zgACHZZVHD/cWwTi67RN4kDDTfdo0zAosqz5isAZcVh/4En
X-Gm-Message-State: AOJu0Yw5+FxADtLlq16dSf43W2FK4mf4FSqEQV09QtoGWfmTG+C+PtpY
	thVSBtfr89fHwnGgiQMU1KiIoxTD75eZMJeOHxKZ3d7g6EI2E1LSTqID3qipp6Y=
X-Google-Smtp-Source: AGHT+IGc1fXqz2t2yynQDY1SoF+N1vGNHGjtG4xag0UmpCTCQGTcyNmJvYxwttdqMYEkSvTDxnoDDw==
X-Received: by 2002:a05:600c:a0b:b0:414:64de:160a with SMTP id z11-20020a05600c0a0b00b0041464de160amr2125627wmp.12.1711618643586;
        Thu, 28 Mar 2024 02:37:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.148])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c1d1400b004146a304863sm4874976wms.34.2024.03.28.02.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 02:37:23 -0700 (PDT)
Message-ID: <5b558086-f8a2-4798-b07f-2e0d71360dfc@linaro.org>
Date: Thu, 28 Mar 2024 10:37:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] devicetree: phy: rockchip-emmc: Document changed
 strobe-pulldown property
To: dev@folker-schwesinger.de, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>, Chris Ruehl <chris.ruehl@gtsys.com.hk>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Christopher Obbard <chris.obbard@collabora.com>,
 Alban Browaeys <alban.browaeys@gmail.com>,
 Doug Anderson <dianders@chromium.org>,
 Brian Norris <briannorris@chromium.org>,
 Jensen Huang <jensenhuang@friendlyarm.com>, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240326-rk-default-enable-strobe-pulldown-v1-0-f410c71605c0@folker-schwesinger.de>
 <20240326-rk-default-enable-strobe-pulldown-v1-2-f410c71605c0@folker-schwesinger.de>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240326-rk-default-enable-strobe-pulldown-v1-2-f410c71605c0@folker-schwesinger.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2024 19:54, Folker Schwesinger via B4 Relay wrote:
> From: Folker Schwesinger <dev@folker-schwesinger.de>
> 
> Document the changes regarding the optional strobe-pulldown property.
> These changes are necessary as the default behavior of the driver was
> restored to the Rockchip kernel behavior of enabling the internal
> pulldown by default.
> 

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

It's: dt-bindings: phy: rockchi.......

Best regards,
Krzysztof


