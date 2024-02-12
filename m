Return-Path: <linux-kernel+bounces-61195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18563850EC4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A130B21116
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1C9F4E1;
	Mon, 12 Feb 2024 08:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZP9/7/bC"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B29F7483
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707725929; cv=none; b=YDd6O7Uk4zb0ybzUfQehVvQEGaYSqXEGiwKZ9ZliuQPC0NM/Pba2u42sjjqJUMi+hp7/kPhOUgYYI+kbH5k509jbk762QGhM1aUF89kC8NUSC1ZR+nt3P2en/xPyMxKUu64ZxNbC6xAo/EbrUMtsaHE9Iq33HAbiQ4FDyiSBhTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707725929; c=relaxed/simple;
	bh=aE+vwMPNRjWR+VsxSAOOJ7YdtM9ap1d6sefqLdi1rOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j4kWn6XwqtZnjHCVb4IoSL/ae9vlehrQXRPNRsapMdAka+JNh4CyHR9cSGTv3Tc6Rcliv82MvTxJrv2/0Svl8D6/o2Va7xMx+I+rCB13Pvb7ZX7ABz8MDKW/uvrJmU35zuHVf384yv3XaoEBYwOUC5MrLxl41Ur2ekOkmcNdL8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZP9/7/bC; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d0aabed735so38448721fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 00:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707725926; x=1708330726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gYWIRjrSUW22uXLH8UjjigHbgGMEP4sVuAGyPysRNHY=;
        b=ZP9/7/bCvEQJ9Fdd6WdJ4INoZrJYS/rPfRm1fbLn3OFtWWaRglAuAJRl0YNyU3mhA3
         V0nrDXhAoaFyCFj58iXhPH9q6TdqvCUtXsYLAAXvxvYNctYaFzXE0FL+vXRII6W4RGbg
         5vBW4c82SEPlvERqvCHvtqaef6e2bmwR6GA4Yb8ecsfDUiMQMljQS1YS/epS3JHF6Rmm
         RRLJNm0/TX0w2Ur8L0qMfJ5eR7pH3wLHtg5u+ezTFuhEBxMEfC/F90RV+fACij5tv6T2
         wOozh6Fa+y3DtqmhoNjPi3bABBEBQZHkg/hX1oqTxQ9oxplyFCZauwpOmFOKcmclVPjI
         ESgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707725926; x=1708330726;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gYWIRjrSUW22uXLH8UjjigHbgGMEP4sVuAGyPysRNHY=;
        b=dA89qyi+v0PtDzF6hZrgPS9A0ag0Jvi8E40F1ao0eX6cq5da4SheN5YA8BWOQ3sW89
         YAkA5rhZBwp8D9b3BDdkX5SY7XHy0vUIk55yB0GeVqkHtUW/ca1UenkqgCzCgpNQVeTh
         xQ74XH/tWM/iLtCXEJQ5UITeBQGLBynMMywWHvtXv8SECXWH/3ajJWdNlqlf3nn0AoQa
         537AmUV7hLawWidejLO5mCwQr96jPLHKg5wpuaW2ztaqXYfNTT3govJeiJ6ek1QyMZAZ
         x3aDaXOMDazToC3uwYFNSSyrHGvD45PyLW+Dz/7j+WaXF6XnqvaCO6Gvp5K1UU6iC+k7
         +XzA==
X-Forwarded-Encrypted: i=1; AJvYcCWYuILEkqtd6mRTNf76rHRsllDHSf5L/vziRhsGfALheiO1ujeIuK/R39hdzXu+S2T1XvsVVSehs/zIIRuckfc/wNDFfbSG4xsGq3cf
X-Gm-Message-State: AOJu0YyorQjRtQORFX4uSSSm6D/Ih4xXHG/uejCqnv4AXfTQU9RZTBOw
	ykK6zBEZD0abrEKzL6utktcO/HtGafXGPuTMRWpkQCYPDKJ7XvyU4qXaAebn+nA=
X-Google-Smtp-Source: AGHT+IGMbWMbRr6Qyrie2NxQXGz+pucq3WcIeaZwemZHcq0zaawjIYMTFULFMShlhMDstAvJPX4T6w==
X-Received: by 2002:a2e:819a:0:b0:2d0:78b4:329a with SMTP id e26-20020a2e819a000000b002d078b4329amr4263049ljg.35.1707725926449;
        Mon, 12 Feb 2024 00:18:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUOacQcMtrLbdI5pWj4LubTiZxFWdckqUbohlhhzfAAjKk/m6yGMJ4Sn6RoD/b9INqNLCVPdBrYYJV5NUeBv3pFSKACza7aCOZ3qN7lYev48MlEy6jiHTLvuhV9CUkdj/s68m0bfADFt/Nf7Gh5hACckuYj2oZuvc1+dZPwIDZacsKnlUmLY/lsGmYo+1EZ7fFahGEmzFX/NSegeghJ3+biRI+NPNl7cMIaW1LvGJxqQF5srZkbQsJkCQJviSX6kaq2V6oMhqMwJv3NDaceLTk5YwEnAi6S+Y2ppbbC5l7ydiDht+r6ocWntj3OdY1RRipJCPBEVqN+FeBnaCX55rGlA4zVSDvLEtsRzTAZpCez7mb1Zt0L3DSMMrqq7xBjbbnu/TTXRovz6ANxnk/SYm66+iEnlKtvdbQfNoLsdmhQ4Kw4iHxf6umqb6s/c3Ze6FH3k8peNkfJ9E/RU/CTBwZE7pTvpCkiHyQwco+5E86EYuD/rAVxtZJTu/4m1EicorfcW+/U9ERXw4nqPgYk5tx1NjUy8IqPWBuGBIwGo0hbV/ZKdJGyVP4TBPPO3FiqZWNjcyOrJdXx11BBIhCY640aKTJz04e53z/t9vF/HTbyvIk3lSIBcijY+qRFHiSmTYB8qH9CuGnYig==
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id c8-20020adfef48000000b0033b47ee01f1sm6010609wrp.49.2024.02.12.00.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 00:18:46 -0800 (PST)
Message-ID: <416c6a40-ec35-4e3b-babd-740f9281eb41@linaro.org>
Date: Mon, 12 Feb 2024 09:18:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/13] dt-bindings: soc: mobileye: add EyeQ5 OLB system
 controller
Content-Language: en-US
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-gpio@vger.kernel.org
References: <20240209-mbly-clk-v5-0-f094ee5e918a@bootlin.com>
 <20240209-mbly-clk-v5-6-f094ee5e918a@bootlin.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240209-mbly-clk-v5-6-f094ee5e918a@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/02/2024 15:31, Théo Lebrun wrote:
> Add documentation to describe the "Other Logic Block" syscon.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

..

> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +  ranges: true
> +
> +patternProperties:
> +  "^clock-controller@[0-9a-f]+$":

If there is going to be new posting, keep consistent quotes: either " or '.

> +    $ref: /schemas/clock/mobileye,eyeq5-clk.yaml#
> +


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof


