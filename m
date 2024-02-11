Return-Path: <linux-kernel+bounces-60862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB8E850A48
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 994671F243E2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC5F5C607;
	Sun, 11 Feb 2024 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mdr+kjaE"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C535C5EB
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 16:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707668584; cv=none; b=cGhyYKVBZQ5ALmKCv7iQyljGGyle2D7XJ+ipgJBFX4GzTTjplzDahlc4Ah7iB2lm8z7KK8qmm7BMTCtWLWmFBv+kZxvpTYr/GXrt/WmR6XD6J9s/+IfuRDpYvuligv/oN8Eb1+gMTO9SnesSKDp9RFVyM0Bo5CdJSSluFMLozLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707668584; c=relaxed/simple;
	bh=iu3S9N8b4nf6mh8iXDmQ6W+Tjbnoag1YQVv/idRN4HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BIgnaw4izopNZoC1aOvxAvu1NYW68rqGJDb0jOXwd5XPL+5OdRvjuPPtdfqUfdkOixz3/vkrPWSOzyvP0B9HvLa86aaS3v+DZ0pL1TrufAN1H9KNBWI7SiZzuGacMAHOX6iCs4tWGb8a1kkpuJnJUfYKyNk+2/W2znn37vdW8G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mdr+kjaE; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-410980dfddeso7653255e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 08:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707668581; x=1708273381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CCjH/haJJgLGo2vPGZgrjndT54YAzQ3/yApSbYjOY9U=;
        b=Mdr+kjaEMh3BxnVTFK43LAm1POXiGtwqoioX8ttXLZfQSvettYGodT5UpJymaoQb0l
         39UnjTrtMHcv7N3sDc9y7o6Wl2z8gGZTsNgIpRkcD557q5HHvZO+fcCT7x0s7lzhsDWd
         TWCbC2PJvBKRZy9pOfHSGkTaNnH456oKDLGZeTjGVxLlQpiPjMBC4R64JFm2MGCWNNqF
         OCYKGDyBInZd248AGjwz9axH9cJo9++N7kR6xHQBcPfnJCatFDzDNd/ZEA4bdxOBltN8
         LqrAVmKu103jmeCYyFDzFYjhOep7AN4PcXDJtMNIWg6rsOkDl0uNUu0AMtj3lAYuzH/X
         Zadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707668581; x=1708273381;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCjH/haJJgLGo2vPGZgrjndT54YAzQ3/yApSbYjOY9U=;
        b=C4BeOHxV944C5Q5a3YCkW6xtwdTzaKIqaGzX80JUvkci5+1RKke5go+ZmwTlEaduTR
         FRDfb+xzi/mXA2w1PeY5+HNR4hbfR6fi6F+myS2T/QL2aPkDPU14yiWZRrOqAQFcacSO
         o3xBGicLcxEyIGIVtUxJy68gsY4inqPDsb1AA/sHNGfQ1seQt6GDr9sYAcWx+riI068S
         f8L6M+rQ2WkFDOc1GMyQqJgwhJk+EyhnUmPpDle6AOrD255IsoPwyz2C9dJnefaDgI+S
         ybDbP1W78VEf08YYvi71L33D5jNMqAAsRKUTyFs3AccgBn3Zk0Gma0+azVhcdN1mt7r5
         SYPA==
X-Forwarded-Encrypted: i=1; AJvYcCVIZ+8QNl/aL9CI5WS1rcLGP1rnLmBV8HCmoeOR2MjsqJXaNT/HmzuZWdLswIHV9EOriCghn2g8LdbNdGJBKDrcV9inIkWihdkH2Orp
X-Gm-Message-State: AOJu0YxaeFA+v3IrWE/y8EkveKppmDSduXQ6w9QuE19tH9LFqAXSVrkZ
	J5YDEHl+Sy2CcQGo2QbRUEXe/4lW3c8pfP8XIQReaBsNH3UQcK14/ewlF2B7MUA=
X-Google-Smtp-Source: AGHT+IGQMRJJCBt8XBIIFRQx1wn5c664Fbac1uLGdaR/wCufBGfUszPiKQjT5n8Q5PM5uvodo9PjuQ==
X-Received: by 2002:a05:600c:3c9e:b0:410:6a6a:7634 with SMTP id bg30-20020a05600c3c9e00b004106a6a7634mr3588555wmb.10.1707668581532;
        Sun, 11 Feb 2024 08:23:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWvVwoS3T4Hvm/EmZEWrqemV17CXwAYjVubAVEmhkSWKKt/JxBg1lvqQvrfIBVemwPaJYXzRTiYdDYCpExPKHJ5mUX4XC0IJHufaChqftpNSmQlggZl1HDy56spvFDtHt7WkOJhzig1mhuZFvdAtJ7NGbtL1X9pMQxk/SO1iIVnVhQuE0DrF5ALhJ8IbYFjK4sCDdwmx/vpRcTzuiBBHQPDxjdQ9yxNNFDmqKV+lvAfbsqyP9Del/5qqq2+gup31h748V+Cy3vS0zql36Ld1gvBQqcdRWgLJfVp60X19rIlsCP6QqowVl2xKicD+WMtnTpJmhYCGLOw9/m8nhAwzM2u4DKZy6yqSTtR/s76RuXfgMxdR3UPnQszApQjkjRqtsaaRq+j5128bEO95QJ2oZucLR0tWHNRKmHj0KwRFyMAtoVQLO0K9a1lb/bx4urPzvkNc4SfZpHVHglJqlgV3eZ39BYNbUdAIVY8U+ikJ9J23PCv3oicMm7anA==
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c298400b0040fdc7f4fcdsm6216986wmd.4.2024.02.11.08.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 08:23:01 -0800 (PST)
Message-ID: <59ad05fa-0553-4833-b10b-99a75e064427@linaro.org>
Date: Sun, 11 Feb 2024 17:22:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: net: dp83826: support TX data voltage
 tuning
Content-Language: en-US
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, afd@ti.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, bsp-development.geo@leica-geosystems.com,
 m.felsch@pengutronix.de
References: <20240209123628.2113971-1-catalin.popescu@leica-geosystems.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240209123628.2113971-1-catalin.popescu@leica-geosystems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/02/2024 13:36, Catalin Popescu wrote:
> Add properties ti,cfg-dac-minus-one-bp/ti,cfg-dac-plus-one-bp
> to support voltage tuning of logical levels -1/+1 of the MLT-3
> encoded TX data.
> 
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
> ---
> Changes in v2:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


