Return-Path: <linux-kernel+bounces-140014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9F28A0A5B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE8DEB25096
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA72013E410;
	Thu, 11 Apr 2024 07:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gHd6kS88"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5413A13DB87
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821523; cv=none; b=ucwkX/Jg9sgYxtyZN+HJHTauEXU8sApvnRkatU/dPg3MK01Rvs98pzb9lsmKXabxfLx6nx0CeLdlJwmtYrsYVVHZgNo/f9O11RnYHCFq3FSzRRZk1/vIrZTG5oCP4Smpfbu+0uVWlyNlc0N33ntOt+YLffn10Uy5eoEx2b3NAxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821523; c=relaxed/simple;
	bh=6YFvOkxzVG/OrPmpq2vbiEb411+jZ7BnYY36umhWwnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mZyJgY/tHcGKNgA/PNTswYJ5sDnmkBNukAAdeERza4B0N98hLDHe7AsSFbCx7CS2KmtcV80JGKwizGV7AF8gDAbujHT+sL84PhZwxuPZq7L3XMrA4PGC8L2NsD7sF+OV1eqm05rvgmfzw/LNtAXn6RAgMT1DoFxcCaoyWKn8hF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gHd6kS88; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-34641b7c49aso1622088f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712821520; x=1713426320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hPDlPE6oBe5a0i4vETkj5Md0yyIeHGfoneg9iKQ/qNk=;
        b=gHd6kS88E6sSrLUJ3Q0aZxhxtZs+gbvzqxOHi6jfdd3biOC8BSkIj6hpUr/4sn1Ghi
         ACLo68Ss0qLWzGhVjJ0s7yGlOQwDZC25ff+ydchGB/314GWXU4UB2eWMwftxhkroYl4/
         0oHWBeVEl1QGh/HTD5lp2tPpaYBO5qx8mTuxPaN1M2zGM5X57XcVStDP+Ud+w3dfU9nC
         So3d3nOyn/lfMXPSrhoSxIMbbdbgMwzpJFVUGj2YEZoWvqMj+rDPagYQJVDBKNH4QoiD
         6hsrnvXM1xL6kEIksJHnpRCmxciE1wn0egqmg2zsGZoUIYr5KCcw6E8IeULGdBfLKzFH
         OevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712821520; x=1713426320;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPDlPE6oBe5a0i4vETkj5Md0yyIeHGfoneg9iKQ/qNk=;
        b=TdW6YKIDkPQWFvke54cE3Q9MJzEKUYRqvF8LkMprywaHR3TYe8w5XjXZBnUV57RFq5
         UazfZGVBZDYN8lROPYv9icrYMqAU0/86SQkRJyGbPd3pC1E6fX826oDvdknRB/6i+tU/
         ij/MHvmCoQtF8YWyJD29/CIzGnhAHm+Klsp9IZh8WOdz571fhUAk9jMJ3Y0HmpzCNYr6
         7wl+3FavRuejIowpI2KfA0Ar0i0lR4iivk0tmLHkoY3Lwd+C/SjJCe8bITckdtwdG6m7
         s31FCixDQPjxXNbTqphEkx9joyIc7IM+cr8mbWpJMa7+1AlwgplUXKbFTyhV54JY/eDp
         aqEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7qWGoM7tdmqdaY5FP52TT8ByBTRf7y5Lnuvh4s50MrVSlQ0d1MSk3KN1ubUeCqQcp4DvYvkGx18aTZiZ0ffyv90aWiJSbY565dArH
X-Gm-Message-State: AOJu0Yyp8Medmml4qGPuQXwPKpW6rKyFRu4b2MazJLKxIUyvwCv4uvUw
	oPimRvh5lrodEMq3QVzdNEbrAEvW4fhHXq5JrPjCXwh1unqJm/pJrovuCRcxgs4=
X-Google-Smtp-Source: AGHT+IFmUUptE6LCXyNJ3ry2O84HuMggdM4AfUWmYul1g1Trqn93I43+JxlpHKxteA6eYJUAW4/jGg==
X-Received: by 2002:a5d:6da2:0:b0:346:bbd9:424 with SMTP id u2-20020a5d6da2000000b00346bbd90424mr696540wrs.12.1712821519689;
        Thu, 11 Apr 2024 00:45:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id k9-20020adff289000000b0033e45930f35sm1130203wro.6.2024.04.11.00.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 00:45:19 -0700 (PDT)
Message-ID: <e1bfd56a-7e06-4bd3-bfaf-f1757edbaf6b@linaro.org>
Date: Thu, 11 Apr 2024 09:45:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] ARM: dts: microchip: sama5d2: Remove the empty
 lines 47 and 63
To: Mihai Sain <mihai.sain@microchip.com>, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240411073353.3831-1-mihai.sain@microchip.com>
 <20240411073353.3831-4-mihai.sain@microchip.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240411073353.3831-4-mihai.sain@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/04/2024 09:33, Mihai Sain wrote:
> Remove the empty line 47 from etb node.
> Remove the empty line 63 from etm node.
> 
> Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
> ---
>  arch/arm/boot/dts/microchip/sama5d2.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/microchip/sama5d2.dtsi b/arch/arm/boot/dts/microchip/sama5d2.dtsi
> index 5f8e297e19ed..7aea6c2368a2 100644
> --- a/arch/arm/boot/dts/microchip/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/microchip/sama5d2.dtsi
> @@ -44,7 +44,6 @@ pmu {
>  	etb@740000 {
>  		compatible = "arm,coresight-etb10", "arm,primecell";
>  		reg = <0x740000 0x1000>;
> -

Do not remove line by line in one patch. This is trivial. One patch per
all your boards doing such simple cleanuops.

Your subject already shows the ridiculousness of this split.

Best regards,
Krzysztof


