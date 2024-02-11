Return-Path: <linux-kernel+bounces-60789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AA7850977
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 14:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C38EB21F55
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A685B5C3;
	Sun, 11 Feb 2024 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nUOVKLfe"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44285B5AC
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 13:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707659400; cv=none; b=qNXsKprdWljXE2Wbogt+6hY0M8hGg/pARK/wrlQtaY1qUSFMeanPbAbOIGaslThYC/S0rb0fzsr2q1oylt2mB2aJXjGYQg1Z863cAVnDzT1ZSEVM5+dEZteMCgeyanNxcL935ONN02a/L7Deprw5ihZBxMz3NLbjU3UhskcGoyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707659400; c=relaxed/simple;
	bh=XglN44Cj2ooZyrdTI5DyBdaZNjc7OZcxKklN1/CsZMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jcFyDbqx6DyhvCiVnpbMpThInKusoba22ldQepzGlLkvFDdTYrNzZJlUTCfiE7QimF3tBVgZD3JiH193xzIBtEEyIzG9KO6sAZqOdEthw9Gh5LED3w2kTLxfzaZ6HtGM+47OdSE0iStrOI4ptGygHZ5AsXp235zzqe1UrBx/Mzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nUOVKLfe; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-410c1ebf5e4so2186805e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 05:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707659396; x=1708264196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0imYPIS38kKZEnWaPAclZV8nXR/Nfa1Ot0nhLSCtPdA=;
        b=nUOVKLfeiFM/TaXCepvedZkeheJv/tdwkXqZKPADc/coFDlpVQhIrXeXUKlZuzmev7
         T1QHlBqjZQXKUpp3yKvM5JxoBJk8M1YVGf9wIDVBiJ4tB10FLPi0/Zb9XUFM1t2RugFW
         XbudAuq5Oyd2bZAzmyoksHTTNeEk7enxI/iQ5X60MyNy3P+ynbqkVwauKAzx6vOQw5Rc
         406RBod64H6ierPKf3/RroAhjZhdHGajd4kgAO5hf5FPaqSJgTb8jl5UaxKii/fJR0gR
         BdwK9CTKXeYI+Pp9az+5sT6FLObM5EPbCbmziRa3MTeTzTS3txt2JKV7K8lrjQrOvF09
         X/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707659396; x=1708264196;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0imYPIS38kKZEnWaPAclZV8nXR/Nfa1Ot0nhLSCtPdA=;
        b=ctFhLbtez1ox3wvX1QCjKQoiKkrEwYo0404udoR2+RDIpb4FiAcyWxhomZ+jDUSDF4
         8xl73XERhRRjwOfn4IAsq34GqZjVJMYuJUWezwNRY4Tu+RbKpuOGO3jlyRwq5t5O5jmz
         FhyHgjRFzgTsjS8jT/vKuPayA9RsTt21BMECVfhfFFzcfFnaZ/rac2N0ZABnLPKHWAZb
         9UkcpRI90gf7IpxEAdHhxFnRHA8pLNBslfOoX8jpL1nMf11Mz/Ool47b2qohCJjbo3ql
         cAX8UZ9O2q6zZN2LMyKhBBkuc5nuaQYczOmjsoUsuourTgkbsZ9LCtDHbRFYsrac7nmn
         f7Eg==
X-Forwarded-Encrypted: i=1; AJvYcCU5y6RRJw+38pGxm3Pr980IgQMr0zVHZ9An8wmBXc88SPlDfPX4cKXC7pKU9l8gZEwXfstNoaKywkOIZFyZXIJYQ0yUX3L3iCmog9eT
X-Gm-Message-State: AOJu0YzTYH3gFOisDfig/AZpl+Wskbegv9u/CEYOBj1oHAWkeutEMLnj
	Ga+tIW2NAP651MditbYzeii8d5qS/UVPMQu3kZAp3n8RjkoKk+JGuRcajoonOpQ=
X-Google-Smtp-Source: AGHT+IGgNjixJ7a6Dq+Uti7cy/aISaLp/DXGksERORSKXN5It7AmTARvmRuHh4IFg3mXA+PV5C6eBw==
X-Received: by 2002:a05:600c:3591:b0:40f:de25:f9b4 with SMTP id p17-20020a05600c359100b0040fde25f9b4mr3645319wmq.26.1707659396538;
        Sun, 11 Feb 2024 05:49:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV1bIxMUI3Offr6cvI9+Zhw+m6iDDHdggy9CUAeFU/6yR3uXAm1kmUvscZQj8nqx2gxUJRN2/oljKm04feaTGJb+mk1k+MrIykVodeJLGuyI8jMG71pIFq7uJ1fnrZygNAAxuu6fJAcw1fW93TiO87MRIBQFBLsTmJkr8xk5WflVHZGpiWww96lwZuUrJb8Zav2q7BVtXNWOllcTmN+JEJP20InDMbf4TAfq/m046d1e3pk1TC+WaFbaowI1to2Rn9VuG+1j4xqnOlvBZAhoVw5Eonfrmju8QLeYcH6XijtPu4s1QXdP+dc8ejJpMmW1CA5p+yyvEC+ZBQeytR7CZHXMo0R3YaBOVAAR49idiZfqonHhjRF95kawV5SJ/8geY8KsJaDyJD8nOk45Xvx82ghInsDAphvHudcXtv+tb2HzVhKH3JCv8XUBNewrcrFkQ42Ndt8aubEUv7mOjE+grF306lZ75fOMJY1nCc+npslc/hFQWT2KS7Qgt1qpeiknmzAaKN3hzIah0hFVnPia6+WFRSYoBNevaJWMBPHDm/T3Ult7TC9nsb2c1wo3TzT/ACUH2SiB549apwC9EbP/OYT2GRueqIWtquQuJZWcNnO3SJuIBEzti5rkLKxHMF++sUZgRPAcdbQ6jR5Cr8i70cExFy9k0xztE0A0RaK2Nih/5RGJr7VzxS5XFcD05HfDmdGDQ==
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id q18-20020a7bce92000000b00410c04e5455sm1315753wmj.20.2024.02.11.05.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 05:49:55 -0800 (PST)
Message-ID: <be84e32e-e11d-47fe-ad56-da8b0dec5007@linaro.org>
Date: Sun, 11 Feb 2024 14:49:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] spi: dt-bindings: introduce the ``fifo-depth``
 property
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, robh@kernel.org, andi.shyti@kernel.org,
 semen.protsenko@linaro.org, alim.akhtar@samsung.com,
 linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com,
 willmcvicker@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
 arnd@arndb.de, Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20240208135045.3728927-1-tudor.ambarus@linaro.org>
 <20240208135045.3728927-2-tudor.ambarus@linaro.org>
 <CAMuHMdU_Hx9PLmHf2Xm1KKTy_OF-TeCv7SzmA5CZWz+PLkbAGA@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAMuHMdU_Hx9PLmHf2Xm1KKTy_OF-TeCv7SzmA5CZWz+PLkbAGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/02/2024 18:13, Geert Uytterhoeven wrote:
> Hi Tudor,
> 
> On Thu, Feb 8, 2024 at 2:51 PM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>> There are instances of the same IP that are configured by the integrator
>> with different FIFO depths. Introduce the fifo-depth property to allow
>> such nodes to specify their FIFO depth.
>>
>> We haven't seen SPI IPs with different FIFO depths for RX and TX, thus
>> introduce a single property.
> 
> Ha...
> 
> Current documentation for the Clock-Synchronized Serial Interface with
> FIFO (MSIOF) on e.g. R-Car Gen2 and later states:
> 
>     FIFO capacity: 32 bits × 64 stages for transmission and 32 bits ×
> 256 stages for reception
> 
> Initially (many years ago), there was some doubt about the validity
> of these values (older variants on SH supported 64/64), hence
> drivers/spi/spi-sh-msiof.c still has
> 
>     .tx_fifo_size = 64,
>     .rx_fifo_size = 64,
> 
> Probably we should test and revisit this...
> 
>> --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
>> +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
>> @@ -69,6 +69,11 @@ properties:
>>           Should be generally avoided and be replaced by
>>           spi-cs-high + ACTIVE_HIGH.
>>
>> +  fifo-depth:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      Size of the data FIFO in bytes.
> 
> I think it is prudent to consider the asymmetric case, too.
> Whether that should be just two properties ("rx-fifo-depth" and
> "tx-fifo-depth"), or also a third "fifo-depth", I defer to the DT
> maintainers...

Since most of the cases FIFO depth tx=rx, we could go with three
properties and:

allOf:
 - not:
     required:
       - fifo-depth
       - tx-fifo-depth
 - not:
     required:
       - fifo-depth
       - rx-fifo-depth

and probably dependencies between rx and tx (see example-schema).

Best regards,
Krzysztof


