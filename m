Return-Path: <linux-kernel+bounces-47819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC15845352
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0239D290C87
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983F615AADE;
	Thu,  1 Feb 2024 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QuztIaIc"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177C915AABD
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 09:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706778040; cv=none; b=KuMlT8nbVHX1JZcnSGkp+QckWuVHD6xHyC095GnoLWQoo9j5ICOK3EKR/SYIf4KQOMsT7KDVPeNUJuZLhp0oBhG5eFwAiozHI4vd4tIAGQaEGkxKBl+7jkUB/LE/7R8yWI9yV3BmOrqAIjv6m+sHuz0ixTy/YO3XUdH5qjmeeXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706778040; c=relaxed/simple;
	bh=fYslxJEf/Z/rscvFq7DdJSRqxFpOsrNJssNF4gqBFkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPx/E/DAdpQ2++ZDhRYt+MOajiaDkl6o5SN9nfgR4DUuc+6EkhUhxSjRxZEHnAwAE/KmqjEZ525Ks+5//GXsYgIVuX4RA8Ku5YWwxMLGAxnlaP5Bmnx08+KYgp/0cLho4CIK/2hRnn5bG9R28t8Drr7WQkR+x3HV7XypsOLmr34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QuztIaIc; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so113103766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 01:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706778037; x=1707382837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JbeFf5n2Oyv9Yqc3rkPK+DBR6kxdBct8U150vB7knbc=;
        b=QuztIaIc1kDotje2eNKozX5ZjeVeM0s55IBF3V8u0+GENgiQZCeCXmbMtQjJfCOnle
         KKu6uGjQGLSslJDHSUfZsmm6c4E2l8Ul6EqpRdfAakwI4D1eZdnAtGRZnnLtoPJ7l+a0
         oX3p/DXrGiEP8Xq2vHAtbHVBRKuW8Tqx/SnwxZz19qtcOdfTy9Xi0YP+KZbuPoozOIke
         k4daAbWIHLN9ROI+Ilz4ja9E8/nWyTeZHIF23nzQB9IyBttL7tF8gpwTx5mwvCUHZ08z
         /UPmb5DFmsHXWzWGpi4g8iMIpdxR8lo1dRUwIVEHGuNHGpraRB4/Qjz8B+FXE4ANR3oO
         pWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706778037; x=1707382837;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JbeFf5n2Oyv9Yqc3rkPK+DBR6kxdBct8U150vB7knbc=;
        b=EdwqCH69sbjpKHoFq57kLh/QYAgJ4cWkt4EyQ3ZeLXKvWL5R6ymHK1hpMwhQ/ay4VK
         M0k2Ham5dKvjvErLtOoa+5OzG0PAKw2v5hUkMb8grWdA/TMRit9zvJSdC2btZ9PdUguJ
         k+IoeFftRTZ/2zoSz2FX6fUKiEFLv0VWw14GPGZ1ZnFMg8OpziPd7kxPIOtGFG539fo2
         VfShA7YYwQ8zG3R2XBfGrnkM5PAqwdtArKEKZgnv7kz8k9nHL5Eg2RtY3tS7ZeTV09lF
         z5MBPwsTfZLYopWKJLiKn1tjxbpdWvEqA6av86ybJzz/eBOHwW0lsmKHpGI149zI89qg
         KPsQ==
X-Gm-Message-State: AOJu0YyRPYjdb9E35iN0vgUbuxbsJsXXTOXoAprjCj4Mw0eMURUlGM/d
	F0W0FogQQuP4S9J5P2UR1rYjBL9QnL4UPgN5nnNauoAx5EPoy0UvAEUDE9yLvPM=
X-Google-Smtp-Source: AGHT+IHM9bitjU2UVL+U8Qg98wReY19D/d1IuXu1QELo9AS+RhhOUSkkAOgZLgtmjdOE44weSPgXkA==
X-Received: by 2002:a17:906:aed5:b0:a35:b59c:fc04 with SMTP id me21-20020a170906aed500b00a35b59cfc04mr3531407ejb.25.1706778037170;
        Thu, 01 Feb 2024 01:00:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX+arCeiGMY8xcF2rXGmCus2dHtPctRqDhLx0Z91DmKkB0UpV/FDrOUo7+LMK8NIy42JURi0MxX086MmXTphpOBiiunl7e2rOKzLw4s3SDZaCbDoBcX8mbSLUQ1sRpfKZ3vZPmEFZBDVLqOohtDKJYAGQNPQTimsjdwCSeL1uuwPJjoQIrGBDkQwSSyRxjH58WkuXs4C2BbpWQB+X2bOubCE03r/vBd5KJ25eVtro9yQa/uA0sLfSnYOs+vQndKW/CBlG9k8P3So2WOqgoDWJcn0hWhQxTxTiUAyjcpbCX9S3PH2qDdonMB5rmrwqgq28ipPbPqVrAbHOA5+lfzse/hZdPkk/2MDPjv55HugdVHk6gOUSz2GcWlwQkcRd3H9t0gXqH5AcC4PIk3zEGww3tG0aihf2i/iq2zUPaFCVvXZdmbxcDaWZf2j94Yj3X847XxaBC7LQbJKq83zSP8aTLWaHhutPQwTUliwA+p1GFM7ZTZRDbzuv7rPI2lGcLOLaPoMZ5sMyYQOTn5DRAl/gxOsl2TTqcS6IT7rMAyvKcd54lRR7vdQitoGS077Q/ckRgDa1OxXsNzHnJrudD5WQ0Tx659Uc712RmCye+0sloRAHcOJlJ2jODkpDkFB32TmMby/zHzlDIxtw==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id 20-20020a170906329400b00a3527dba974sm6110367ejw.35.2024.02.01.01.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 01:00:36 -0800 (PST)
Message-ID: <0558d9c9-106a-4061-9db2-3776104030d0@linaro.org>
Date: Thu, 1 Feb 2024 10:00:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/18] dt-bindings: reset: mobileye,eyeq5-reset: add
 bindings
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
References: <20240131-mbly-clk-v4-0-bcd00510d6a0@bootlin.com>
 <20240131-mbly-clk-v4-5-bcd00510d6a0@bootlin.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240131-mbly-clk-v4-5-bcd00510d6a0@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 31/01/2024 17:26, Théo Lebrun wrote:
> Add DT-Schema bindings for the EyeQ5 reset controller.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  .../bindings/reset/mobileye,eyeq5-reset.yaml       | 44 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +

Where is explanation what changed and why the tag was not applied?

Best regards,
Krzysztof


