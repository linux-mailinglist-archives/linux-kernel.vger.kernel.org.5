Return-Path: <linux-kernel+bounces-72594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D933385B5B9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663071F21B4A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2768D5D752;
	Tue, 20 Feb 2024 08:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y1o0x5KQ"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA2C5D729
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418728; cv=none; b=uFbP3K5OsalKEvwi3BlYaboiOgidH66+ZMJslmnPGszg/ayo/BxTYnTCNhC0WA2oSzkKjLpU9z91qkA/kj88NnEz+H6vyE/3HUCSC7cZl0sRGJIrBhzFAeKKxaI5iHAUf8ESFSegTfeQ/uzij9OUTIGvDoJqtbe5iOqfp7Lx6+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418728; c=relaxed/simple;
	bh=2Da2yGEaMTs8vDmi5koNm7fEyhXahGnIKYppNjXF3kQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ANLxNHMOZSeJSp6ccZeLK3UZy3pdpVpPV9xyvWWjHufcV9o+1cEXqrkZ3/gfF6PTNQESHjGYKa4U0sz20Q4K2ITui9lZ/lBRZD/zM5Q57m96XELqB82muOzkUfiCaE5UBUtZfxj1zxxdDGq66VUYWU1fPBpIM08JNz+F+rGdu+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y1o0x5KQ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4126cff4721so5246435e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 00:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708418725; x=1709023525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6AZ3xdN0JsEC0vOuf0v5oPIThn3IGXYW+LnXdnrO78Y=;
        b=y1o0x5KQJOsMFGy6td4BEH1RHmMAfY6G5+dRnaIDvebrR3isRpPb9quHW3AUu8kKgd
         FJOoxR4T1N0h7jFYbUjz17eSUcRLTKXg0NJUU0bmMGdEFdV9gZeysz11pFtpqBES5Jq4
         0co4Zqj8BgpWAcCMMVBddoYqJg32BWEM6WG1ATWOBGajwEubeSXj/TxM6qFVFjC+aMa8
         RcCzTkM2raaH3EDiiYSbWzmgewWxUsxzNXgDvmqLTtzj614TkUqBRCi4iteGq0fU4RR9
         yQ18BIPZA/b06ruMS1LL/hiPb9awa7+SmCyeytvJVbivBH8IqppZShfzi/bBPBnQaVN3
         INbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708418725; x=1709023525;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6AZ3xdN0JsEC0vOuf0v5oPIThn3IGXYW+LnXdnrO78Y=;
        b=VLLRTrNNdb+2GqF14K7vwP2LLyO/0aDjtkaHy3KrrKKWK92PVL3ucuSIIEsYPHrJE/
         2DEf3JQHMufX6pfFAmf1eOC/LWEO1wRqIR7YGIrlRdSl5X01ZEXB+vFWF24SFPSjfFx4
         amUFBsSmrgVlBUD9xOtUXLYgQjF6eF9tKPG7FAjGRrm6IN46vXa78qgDe4MhCDl/UnhE
         bO+Oro4zz5FSH6354yUGs+RUDjXYClA1a5jCV9vnxongX3FeUpww2oLBluyD2FdF73gJ
         JG2vmdnMkZapCjdi8XmRetngsGJtpqGI46hconne2fc5TI3lpY/f9PjugVMb9pcO0pu9
         9tNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1kRKdQFqp2uOfm8SEUK+Hl01p/Gy262UEZW+L3sK++IXgjQUPP41XMY/VINi5DwzCCY2n+J+PUzWGfnMPZHGzxdoOrGjQR1TGtR0o
X-Gm-Message-State: AOJu0YzqL08WcD0EFUkHbsNm20yeAfZGUDJvPslqKUtW83qGEjE4i6ar
	mfU5+EQrmaDHpw4HmCsXglESbIIWFhpHgv0HN697xvn5C5yWJ6Oe5KDvzQS4qOg=
X-Google-Smtp-Source: AGHT+IEbUV73whCrHR+PM0VrrwG2qQR3LYLC4F2W5iuevshMayA5OFOdLNp3iM6LsUl3OXNoiFjGRg==
X-Received: by 2002:a05:600c:45c6:b0:412:1500:beaa with SMTP id s6-20020a05600c45c600b004121500beaamr9238270wmo.40.1708418724981;
        Tue, 20 Feb 2024 00:45:24 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c4e8800b0040f0219c371sm13975615wmq.19.2024.02.20.00.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 00:45:24 -0800 (PST)
Message-ID: <5f1c9b8b-1e64-4b44-b7d5-a8f8136710a1@linaro.org>
Date: Tue, 20 Feb 2024 09:45:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] ARM: configs: at91: Enable LVDS serializer support
Content-Language: en-US
To: Dharma Balasubiramani <dharma.b@microchip.com>, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 manikandan.m@microchip.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux@armlinux.org.uk,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, geert+renesas@glider.be, arnd@arndb.de,
 palmer@rivosinc.com, akpm@linux-foundation.org, gerg@linux-m68k.org,
 rdunlap@infradead.org, vbabka@suse.cz, linux-arm-kernel@lists.infradead.org
Cc: Hari Prasath Gujulan Elango <hari.prasathge@microchip.com>
References: <20240207102802.200220-1-dharma.b@microchip.com>
 <20240207102802.200220-5-dharma.b@microchip.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240207102802.200220-5-dharma.b@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/02/2024 11:28, Dharma Balasubiramani wrote:
> Enable LVDS serializer support for display pipeline.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> Acked-by: Hari Prasath Gujulan Elango <hari.prasathge@microchip.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
> Changelog
> v2 -> v3
> - No Changes.
> ---

In other email thread you mentioned that this depends on driver changes,
while that's only partially correct. This patch does not make sense if
others are not accepted, but the others are not dependency for this one.
This should go via arm soc.

In the future, please state clearly dependencies in cover letter or each
patch changelog (so ---, not commit msg).

Best regards,
Krzysztof


