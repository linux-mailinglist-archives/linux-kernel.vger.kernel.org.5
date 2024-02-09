Return-Path: <linux-kernel+bounces-59124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB6384F196
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D97562883B7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1959E664AD;
	Fri,  9 Feb 2024 08:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HX/i/UR+"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5B065BDC
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707468436; cv=none; b=VPRfolCz5OZi4yHPc3e1AoQmNBAjmWvBM6P8mqMfO2GxnuxI6KMM2DmmUaNfYVhjIiO3BfIW7P+A1nitU+Ib8UcdhC+SaTvwweK9r+pkAibtVHXv3kz81v62B3Jb9pBMq3WjJcxJ71RexsmyBg29YZXRO4CGW1tdtQ10E391iGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707468436; c=relaxed/simple;
	bh=Yq5UujJZ9gNbxx0FJ5Q+MkbZItwoSotxmpynItNcFus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Opnlg1zJ3H7sLH0kY8IoRNOUTVeNngf+tMGymtUb3g6yTkGFn9sVFgx2CLdbnHXcAkBZk5v6dHy23hhcNqXDIMMEjaPRd8V3HK7wm9uTKWQ1a4IBXgWMOniYgWRiA5ZNFaMzojOPN8Znul6xnMPJ7vA/nhz1YwPIZ1xM3aHwmdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HX/i/UR+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4102f273c46so6293445e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 00:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707468433; x=1708073233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UY1Vpgyo2v6mTMBq+DCCOOF+OZjFSypG4UZjWG/dUO8=;
        b=HX/i/UR+OPF+Mtthoo9fNQlVo0kKJpxqDgvqkM7K09tWChshWnA0EPckoVTHvKX4K/
         hxhRzeLWjM7D2vYgOgWNigybwT1xA9M17uzdAHq5lSMHODubcmqtM/b3mMas+B6tQCy3
         H5kaSMsyTfUGWD1TOF9DEn4ADCjTgrvsFKdDTbuf+8DcA6f0uE3CK0HPAz/wEoVnUSQV
         EvvBiq/5NWIFhwtnoC3gh5w4EyAf8+4vSddBzuzHaWrlzSbMWsM6VI6ODdd0XEIEtaNF
         A1qxD1PR1oXSyTIuavaf0+YNO+5fF/xPNyMFVULcKczurtfGJvfFGQBqMUg6EQlJ8hvs
         I58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707468433; x=1708073233;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UY1Vpgyo2v6mTMBq+DCCOOF+OZjFSypG4UZjWG/dUO8=;
        b=rPpAfXO+/LEzXpnnlPzHwREgVVmKrSYHipTv6/Zuugj51p5W8bQ1z0/V7xVRe15mS8
         S0JoVOJslpzcO+rLQ3xUPNOKFoRHrh/K/eG65VGhp0LJxrlPEf0VQgLbfdGXUZO/LHhw
         UJaeLvcvwL/ooWsqX5m51e7DSkh5Vnx83xuRVQEZ3OGT622Fz1N+Kr+uDmJ9JgN3qCZg
         0MwsL59ZIr4GRZXqkelWitIYUiAQKqLeopvP4bTpT3p6NdH21nTqTLcQAtxf17IHR+ZV
         PxiTphiGouO54IZMMoCPUMMtcCTmXFEp5OoK0D4z4KPRAm+/wxFHIwgJR02pBKBLhSZC
         Qz6A==
X-Forwarded-Encrypted: i=1; AJvYcCWtu29KDy+lsA4SVpRio5eGAmBONXF3HQe1CPHQRmY9uEAS9jeBsdcko4utGExD9qIdVulvnaaGef8YtZBLdM6T1fHEvWj15oXGIcW4
X-Gm-Message-State: AOJu0YwUpYhQG5la/qV+3yhMvYkz9F6xV5hPsBmFGaFzGa+qqPSc8dop
	viDF4snEHvW5NMEDaxWXRfqcoWA2VYD7WnkUkEgfHGvwvN9ptw5eTdyZfWPPw2c=
X-Google-Smtp-Source: AGHT+IGYc6ccFIwyY+17ihQxJo6gmJqAtVVZcbiKeu9XGw0w0Ok+us7bRBJ4gZkuC2yi5j4jmkSpQQ==
X-Received: by 2002:adf:e481:0:b0:33b:636e:c966 with SMTP id i1-20020adfe481000000b0033b636ec966mr615845wrm.3.1707468432773;
        Fri, 09 Feb 2024 00:47:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVv052/KJlbCgLKxvBt6afA6D2iipuGWt1C8qZUQPHgMTVlvPN4z/Vlg3XfPgo0vYwvRQTqZ7hFYOez5Af3clcBhvSEwrDAh2GhWpkhHu6P/9bBGLquGXgC3mBHg4gP1aEQD32GKW3OWEBMf8RkyY2yC3MEhG6ImbFB8/StHDWI5DJ90VYh2Y/av3TfjRh1V8by8BENe0t3NRVeTL/f9Q5rRzLL5XDEvCgZQHlydz6uIem2d15p3CLOq6z+TH1rKvlcUvmyPKL2DM26gYYhwP3e+bVLQxjbfjaF/RW7pIa2xzE/cVA49iFUEcwDpu4irWspnYS7y7S6Rw1sepbdsYSqHSXcg0AVE7XhUSuamGWTmVnhCcmAL/6uGsbMzLMbxrr5cDXVcITydyZX1y4V8BmCKviIS+slId97oJ3FXGQxmc8OkyyLrSUT13xuAMtQLHz48ZEl4J/XA3B+eUg1f2npjxbZL6fgD7Q=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id n3-20020a5d4c43000000b0033b3ceda5dbsm1239275wrt.44.2024.02.09.00.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 00:47:12 -0800 (PST)
Message-ID: <f6f19f9f-b94a-4194-a5e5-b549471cf47e@linaro.org>
Date: Fri, 9 Feb 2024 09:47:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: input: atmel,captouch: convert bindings
 to YAML
Content-Language: en-US
To: Dharma Balasubiramani <dharma.b@microchip.com>,
 dmitry.torokhov@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: hari.prasathge@microchip.com
References: <20240209064755.47516-1-dharma.b@microchip.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240209064755.47516-1-dharma.b@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/02/2024 07:47, Dharma Balasubiramani wrote:
> Convert the Atmel capacitive touchscreen bindings to YAML format.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
> Changelog
> v1 -> v2
> - Drop autorepeat property.
> - Use unevaluatedProperties instead of additionalProperties.
> - Use node name "touch@51" instead of "atmel-captouch@51".


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


