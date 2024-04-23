Return-Path: <linux-kernel+bounces-155448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5327C8AEAB3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38507B212A7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DD513C9DA;
	Tue, 23 Apr 2024 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ehgBachH"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A333713BADD
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885383; cv=none; b=CXcwg3B4Pw6sMoEGqZ+20aJun5HZ2r9Zuo+FJSrQn7gQo2CaWmsOymAfKQP5DhWqFuHGRSyimkywbRn4XjeoXiBWRXZr6SEfgYpygfnvr8NpJ7tK7zHgc8CpmKO5BoJpnUTpdwXiL99FdHXY8jywQ/zbZugdoE7yRQkjwM418N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885383; c=relaxed/simple;
	bh=Ee6SOKmG30ewdCFK7IZvfE3CXz7QryXsQcMupsl4wzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A1s3shUesa3ZarbVxXdZJNzMrMU1EZb9sFr+CVs01cDrEAd+ClS2WG0vpSDH1uttvuLGywIkFyXLgmPKyC9wAj+Mgsd0OwTnvKEKSUD4QPehDi0u5cNBawrZ6leJjXWQ1nHqzPDuIJi0lICBOXmYeXYyQTWc+VBQXr2E38xkZyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ehgBachH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41ae3dbedf3so1506895e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713885378; x=1714490178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RuiSEPvnSGXD+pf12IY85A3YnTFQOj0AbVMfkpi/E4I=;
        b=ehgBachHm0KdpQZwLmC/ehrAgev5Y7kuynwgPvFz+a9SzaoQEKPQbG1m9cjAEMXEpY
         fHEcb04jBtAOWF6x4EplCq8RNk17J9zeQFFwizi/d/jlqU+7RN86gu2eJKEFc8m93Qrg
         cp1QBF4nJ16dtys+nzrXG1sbbAg1l5q8nILpOMGA0wGQ1YC/OFlV2DO9T0p+fCe7HwNm
         KW5sAosaZ6YiUhakvJGGSjrXZP6w7N4P5mgQGmsTnSgpQ6x8274F2zS6mvloHhRPsnyp
         NkGG6JRv+y2r3OsiFU4eYQVQzYNgUTaqzxBLp9PGYa4ZKsQvQ8kMrvohl19bCjsdogBx
         QsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713885378; x=1714490178;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RuiSEPvnSGXD+pf12IY85A3YnTFQOj0AbVMfkpi/E4I=;
        b=YUUtyKXzatXYkcqf0V1f0Mztt9HnUG1m7mCYe+QgdEnLIw5gl0TiEn3XTad/IlFUDV
         dWMvda2eXFAUCmsiQop85omzWrYqQMfzA5/CIQcLqNHaW1DyGNhwHlgN5gXbJt4CitIY
         1qJroC38f4bUijEH5PbZiMVopsLCuDeVlzXB30IXLQfFIhwwxS5mKAYDvUSHuFOSz/My
         4kAdD7vyXsHJ+4h0YvoKD8KrPVEyu8RROWUmApcQG0OjzXqOdaOCtkQLAcRwavuuWnNT
         p8P7hGmBxgirD6aRsjKW04GJdssjyFWQos4P4FxuCy/qHnLqCPOIql3keV/cdH88J3ut
         6XAA==
X-Forwarded-Encrypted: i=1; AJvYcCUyqQgTMMfq7zU0Qopp9JG2p9MrC4PsnId/19fljXF9I2UJBS5m21Nft9RzVIB3TBz62KM9wr8w0A9lk3XYYQ2GHfYlZ3UVveOwyW1T
X-Gm-Message-State: AOJu0YyJgkCVYy07igitLSvFL8P48LT0NI0gGvQiQlVJxY+f788ukNmi
	DqkCg2ACtU2hBPVDQUSJd4VazZnQbGW6nM0B0deOrFIa2ckhHNBmWbseoTnjRro=
X-Google-Smtp-Source: AGHT+IEZEeNJOV+O2KErqnekc/IwFsuAeuJ0QiSlGAwIa1yE2yEYiB+lGf9/WdiEdPordI/LeaKpKA==
X-Received: by 2002:a05:600c:35d6:b0:418:3eb7:e8c6 with SMTP id r22-20020a05600c35d600b004183eb7e8c6mr8015886wmq.5.1713885378312;
        Tue, 23 Apr 2024 08:16:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id b7-20020adff907000000b0034b3394f0e1sm4359000wrr.10.2024.04.23.08.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 08:16:17 -0700 (PDT)
Message-ID: <f60aac7f-dbba-4cba-8bb6-302b5c911b8c@linaro.org>
Date: Tue, 23 Apr 2024 17:16:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: vt8500: replace "uhci" nodename with generic
 name "usb"
To: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240423150728.91527-1-sheharyaar48@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240423150728.91527-1-sheharyaar48@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/04/2024 17:07, Mohammad Shehar Yaar Tausif wrote:
> Replace "uhci" nodenames with "usb" as it's generic and aligns with
> the schema binding.
> 
> Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
> ---
>  arch/arm/boot/dts/vt8500/vt8500.dtsi | 2 +-
>  arch/arm/boot/dts/vt8500/wm8505.dtsi | 2 +-
>  arch/arm/boot/dts/vt8500/wm8650.dtsi | 2 +-
>  arch/arm/boot/dts/vt8500/wm8750.dtsi | 4 ++--
>  arch/arm/boot/dts/vt8500/wm8850.dtsi | 4 ++--
>  5 files changed, 7 insertions(+), 7 deletions(-)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


