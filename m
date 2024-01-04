Return-Path: <linux-kernel+bounces-16445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 164B6823EAB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8485128606A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24018208B9;
	Thu,  4 Jan 2024 09:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jr/wUvc+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084F9208A5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 09:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-555bd21f9fdso382093a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 01:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704360665; x=1704965465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y+E7YrBlkhYNDogi7xlUtXlc4iitfTsqQEsfWrTgqeM=;
        b=Jr/wUvc+4E6YkAv19RZysWZWFgw0Y+CyHSueS0SXlVdmuROduSTFrU8/1j+Dj17cld
         thlo2yIytX1eRgooMuDsd3cFPYz1+D+4gXTZXnzETHE4coO5gJYXNCRS0l6/W38w/PwG
         tRdSBXEEW5Df4bn8s0en0SZHYn3ECz9f0QiKpQAYM4Zi9KzjAGEwzFS+XC39UzwYgrdF
         mmEg5xk9MOt+/TOLcopihOxNp+X2te6tgSiUWK7VsZiX2UMYQ8U1++Vh3UY7KlIVp98c
         txRyBKwW2hLge5dMAqI+oHtT+g3ab/CpucU8odNFUA4msBSwnb964blSNaIJxa1b4k/Q
         +0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704360665; x=1704965465;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y+E7YrBlkhYNDogi7xlUtXlc4iitfTsqQEsfWrTgqeM=;
        b=K7vE8WJm5DVc1F58NSz5ZYPkVirALjIb7Ob0Mu9kZrVjUcYIVXtE+Vy3yON9oPSvrW
         t1451g7T57//aTXzOlHDk6WxcjoZnWQRprNNo2kEM6JIJY4+3kjOWCDQgl0OjDJ/5Z6z
         dPt7C+tNRY6aLrcNklNDnZ3FE4/UT+liDP/EoWXgeVud2qiY5QjsesE1U8BYZ7OxXijP
         AyTuHegQQksm3EST8xG52MNuU+U/RxCJzCcUVjz4eJye/v2pX3KvPnSQsU562RGUKEkd
         CTfiUPDUJpe8o0bIkr+MBcCLyI5+kQp/SrDg61Bp5giCpcIGFLKZx0MQRLHZ/72kLCY8
         e/SA==
X-Gm-Message-State: AOJu0YyxOajTOh1zNGiCC0mo4XbX0haYE440E95KDHs8oSoUiECqKexG
	DZTh2v5c8IqFAouhg4BKTbT/2ao1WCQ1kw==
X-Google-Smtp-Source: AGHT+IGaZ00I4iu62g+5yeAUmS84jz3g3vAU1ga1EjhwZdgRSgEqazJbHks6Ja9FHIRKlu3Ut53abg==
X-Received: by 2002:a17:907:c96:b0:a23:71ca:2bb4 with SMTP id gi22-20020a1709070c9600b00a2371ca2bb4mr149904ejc.144.1704360665262;
        Thu, 04 Jan 2024 01:31:05 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id f17-20020a170906495100b00a26b057df46sm9910107ejt.126.2024.01.04.01.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 01:31:04 -0800 (PST)
Message-ID: <1f66cf69-5d2c-4e15-bf44-4b96a4cc2900@linaro.org>
Date: Thu, 4 Jan 2024 10:31:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: clk: sprd: Add UMS9620 support
Content-Language: en-US
To: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Chunyan Zhang <chunyan.zhang@unisoc.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>
References: <20231229085156.1490233-1-chunyan.zhang@unisoc.com>
 <20231229085156.1490233-2-chunyan.zhang@unisoc.com>
 <3a290bf9-928d-4d21-9c93-0d1db59d6fff@linaro.org>
 <CAAfSe-stvoKSVynTnoy87CUK3NM+ZEwfTMazO0tfwcx5BXG0Og@mail.gmail.com>
 <b8fdce9e-50d9-4b43-a018-c35350bcec0f@linaro.org>
 <CAAfSe-vRLaCZca2anp7iBnHDPUr-oVexSVy7PKYhNDUZ8GGgaw@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAAfSe-vRLaCZca2anp7iBnHDPUr-oVexSVy7PKYhNDUZ8GGgaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/01/2024 10:26, Chunyan Zhang wrote:
>>>> Missing names.
>>>
>>> The names are fixed, but the order are not.
>>
>> Order must be fixed.

Did you read this? It must be. If it is not, your patchset has issues
you must fix.


>>
>>>
>>> For example:
>>> clk_a {
>>>     clocks = <&ext_26m>, <&ext_32k>;
>>>     clock-names = "ext-26m", "ext-32k";
>>> };
>>>
>>> clk_b {
>>>     clocks = <&ext_26m>, <&ext_4m>;
>>>     clock-names = "ext-26m", "ext-4m";
>>
>> And here the order is fixed...
> 
> The order is not fixed, 'clk_b' will cause dtb_check error, since it
> skips the second one i.e. ext-32k in the clock-names list.

Then why do you use the same compatible for two different devices?

Best regards,
Krzysztof


