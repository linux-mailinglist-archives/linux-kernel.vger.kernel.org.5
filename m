Return-Path: <linux-kernel+bounces-47833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 218E684537A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 813FEB270A7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B9F15AAD5;
	Thu,  1 Feb 2024 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nZCNtzy7"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B4015AAB5
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706778733; cv=none; b=Pru43ozKRtnOkTnro+EPQHJ9mzTd3u2icQFR60YMJJdVHwJmCDK8vu40cKE5AXIm1YzkwzteLfcxugh0yIt0hBURn8WD+KPeStkEwgf7THKOauN0Zj+l8uakWV3mKZJBYUtlZELGpubRBYjgKrbKNhuGe0EnSdW1B3cSlAnvnr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706778733; c=relaxed/simple;
	bh=XrKHkQsf8o7y9caGwC3YqoY39O3rggaBogE3ylAQhwc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CyVJlydga4bvvYOeW8msULi5clICZQL+RmNwzYperutNmv317gsLXzRzw+QLZ7Q0xkXRf6A1UZLs+QBFShDchsNW81ZzDOqPFv8j5NgfMkJqU+ydahVG85d3p7zTkA0LotyzUg3FUnIcSVEc/eVnGcnkB03Fw21EuJf5fEiZda8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nZCNtzy7; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so83587766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 01:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706778730; x=1707383530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8aXQZ+aZsCtLKNGY2aGDmbkl7zL4ZKif3nE1ZXAbVEA=;
        b=nZCNtzy7rhDmcpVmprJQeEQU5Vdgc+ScLEdonTdfDqqM+BtQMjqV19f0s2NM2xUGAk
         l/Qh2n/D371EIk9nSKfeltjwwbmO6sTCWeav8yF6ATppeRftLIDeNHic811dcr14TF8A
         1pSvhMzzQaS3tTSzWse8uKLqhIGTo4lch9uvQOvDphkhvel2/s1VT98vxAj+MrUTVCO6
         qn7K12giBd8aBQELueCNLL4J6dwg2Nr5bbwugTCMenb8uEQv7fGS9lEI7j13sEmcA0cc
         mz0uU3XqBL+oBzx1j+l9nHCyv/xa3g5YtieIlPGDorZNIDa3IExELEFCdRNvH4PEyv5a
         KhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706778730; x=1707383530;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8aXQZ+aZsCtLKNGY2aGDmbkl7zL4ZKif3nE1ZXAbVEA=;
        b=aD4quKGUpg4iHL4iGylvsYdt74Gs62PzwiHdiUP1l86U3kqUjU2roxpXdbc1Rwabrj
         X2x//dQUW6XiCjCdZ90TX0Udg75cMvXm2PWiE1+vMXPfp092w6g5H9DiCAd+yH+clm2M
         kO5M/EF5heWkcQsNjMnCIOhsjYsJP6t6k9zq6mVgO/Y7dlq59rPwIqJWC8IqLhS1j9zO
         Ie2s1LVSMRunJ33PDjncRjY4pfMJmJ7PTjv5PPbBRL/5AwHIwlzuA+7qwkXWy7B7883F
         4YqkjcINLiufmxTiXEZ4aBmwTmpFpWlAQdpf6zYcWPh3dvhfOBN+E7bkTZGnyccUh9iX
         UE7g==
X-Gm-Message-State: AOJu0YyEMUApCLAtBiGGq3o9Bc9rYrfeWNJUtZXcBCJzdR+fzcZPQ2sG
	6t4m2bgUKlRQqRM7S978Wdn7NVl5/7jub9yyqKttZP2S8Gg2wX4OgM2ZOICg9OU=
X-Google-Smtp-Source: AGHT+IGx5+cS5T3SVDK81p61GDSJA08ToBorhWZhWI8OHOpr6ljWBcIMBek96/Y+09F64DKPHTlfew==
X-Received: by 2002:a17:906:7c48:b0:a35:6667:b3f1 with SMTP id g8-20020a1709067c4800b00a356667b3f1mr3129739ejp.66.1706778729758;
        Thu, 01 Feb 2024 01:12:09 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWOpPd+dkzAhF9GgbGnlKMP93PqYDr2l2LeTbCbh3qOhDWeT9lfrjX3r0e0f1e4RzIWoAyV9fp9mVZyKinyE9kwSTshGYZ1/l3mlH03nQNt4nIc1uO0O0qT0XFwxQcdfPjbZ+BVugrIwjQ9e2/EjL7ptvXAHzkZeKjHdFW6lEyCdLh6bK9X4Js8svFeslO6GWLHo6ZiPHhiP3EhfE7R5ib7pgySMFxUeCyJhGHvYwXOiajprUCXY9mgJZpY1kjxnbMtojR4UOrLYQsGbOmP7dv2vHYwbLmKzVUZ6G8F2aZSH9u+nfUPFM0L56BhG+V5vk+HMSQjUO9XanvcgYadk6H+NyZYPdh+dAWOGN0XoClzLNS5ByMaLS6SrCjODor24+HP5u4QapTulYJ0vn3cPk0pyy0DS1VAvysLuWnEMVVU/crFEssZnA7iy2Vuc0vbxE2FDVnApjtBilJwlaZGUwTeJXQRsHpmotQW03GUrmwrl3YEoumytV5eibrg91yvdJwA8NpZp6DWSbRkwiYS782O7HuBf6zTtk1GmEsFeRQgIB+/TYbtZgMgbQeiqgYW4SagHdt/y0jz92nhlicnYaFlJUX0CdH+XPWQRdu0ELkCBWCr++rOesyaRGxBo6Gv608mJqKXFOU/fA==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id cu3-20020a170906ba8300b00a368903fc98sm1165092ejd.136.2024.02.01.01.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 01:12:09 -0800 (PST)
Message-ID: <42bf2184-80b0-4ea5-93de-9ccbeab82509@linaro.org>
Date: Thu, 1 Feb 2024 10:12:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/18] MIPS: mobileye: eyeq5: rename olb@e00000 to
 system-controller@e00000
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
 <20240131-mbly-clk-v4-11-bcd00510d6a0@bootlin.com>
 <ddc31ec4-09d5-45bc-83d7-c4aed4c4ec65@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ddc31ec4-09d5-45bc-83d7-c4aed4c4ec65@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/02/2024 10:10, Krzysztof Kozlowski wrote:
> On 31/01/2024 17:26, Théo Lebrun wrote:
>> Node names should be generic. OLB, meaning "Other Logic Block", is a
>> name specific to this platform. Change the node name to the generic and
>> often-used "system-controller".
>>
>> See §2.2.2. "Generic Names Recommendation" in the devicetree
>> specification.
>>
>> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
>> ---
>>  arch/mips/boot/dts/mobileye/eyeq5.dtsi | 2 +-
> 
> There is no such file in next-20240201 and your cover letter does not
> link to any dependency. Something is not right.

Ah, I found it now.

Best regards,
Krzysztof


