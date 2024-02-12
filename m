Return-Path: <linux-kernel+bounces-61194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044F2850EBC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57418B219F5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D17DF41;
	Mon, 12 Feb 2024 08:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qDgajK3+"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199E4F9D7
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 08:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707725837; cv=none; b=YpHWuX7FW5IZZ2a8FN2bihpID/NxXAW8cDDAoJc2WFifUdW7fJcoPVRrPtrgtusB9bIE9mdIzfN/c2gQIsDtzvgXQjXqaUeI37FscY6tp0uDCbZt37IBrW61QA4a0wdcy0t0PVHMqy/5eQz0+kJils3l6muJlHrzJObe2TqLG2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707725837; c=relaxed/simple;
	bh=4kTSLaDdlHPeR+U57RbfmqKWpzumXl0eifglmJ1WH90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RAsC7VufnNfmJM1iQ8zve1/yhaLus7LwseCD0HI8z19eE3jMd/aVhAaNxrpNQ5vSJjR4doszFwc3vG/Byz3YWK2st5K3p+V+/ZasUCU5Q3FxS09WGkYvalkFjKnIZpbdXCA+nrQtM3JtcLffBIn4MdtBcM/DSCUPxt5u+dbsddE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qDgajK3+; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5114b1e8819so4064364e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 00:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707725833; x=1708330633; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YW8Dhg+yK/DngpEH8RpGUqCOqo8Ac9qPxv8/OIyK8ZY=;
        b=qDgajK3+dF3z4pSt0vq7MsQmfTkO1gYpZ9Yd4mQhsgvLNcFM3KH/7QKzszD7DUtV6Z
         3rHkxGCZDcI5wv8wQQLBXXykQ7Pm2KR6OcU3SeFCmmhv7+YS0ku3ofRVg//pIZ0yc6+E
         Z4F4yQ6JSwZJexs2PWMeEWkRcv0d4wCoLbJCONbVAnluSLZJepsf5Js8nm2BDHFkwnQX
         2q+JaWRb7Mv7/m9UzOwQy6LjIlQJANQ7iEdVENoHY+x1Aa+18RW3bXfM/e77rsc+pOK1
         +Hbu5BWpTNWGcdUw8h2saskmoMM6sYECG20mpBJzRTDpyrFaDvc+bWHKAWU+GF6mp+NB
         IgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707725833; x=1708330633;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YW8Dhg+yK/DngpEH8RpGUqCOqo8Ac9qPxv8/OIyK8ZY=;
        b=SETPVq3tOciU47ihJeJg9excckYoNfqYazQIGxvaiMUJAFInLQvODNeDlf8LRmtPe6
         qhpqYVzvEeuGXeVgS9rHdvLNgKf4ghLJuRysLJ1Sz0GwJCZI008ouoGli55cRHBo5yzu
         oItt4pasHXI7CyL4VlOIrOi+1ATG8YMIlE8nd3m2rmMmWzaRCw8sStrFGj51RIL2tPaO
         FLLRza/rvn7KoQqZQmm0EqEIx2LB/aS4TjZ825aynujXZkdEgP+4mWmS+8CZsyw0ta2H
         o6SsxwMMzLmE5R3hfnMY6tWYXnES+HCk/VzV9RGfjrhSyyhg7y2/q7KiskhyxPrDR6K2
         gNSg==
X-Forwarded-Encrypted: i=1; AJvYcCWft/3kc61rwAATnMcxBWJic/NWuUXPY7oEAHnLybFDJBVL+OIe3wzaZ2tHePrJ2qdKQr1NCMVkqoDksAa7qIdzYHMfKVzxTRU4NI9Q
X-Gm-Message-State: AOJu0YxamW8cmUHJYDIE9CZ5fgmY2Ez0T+w13trUYWPnlYfaFHGKaleZ
	meWgvYWc35nyvqg1F58WaFpT7w0AkIUT7JjDMEWflsn2XCtlOZuVVYgehWuCgXw=
X-Google-Smtp-Source: AGHT+IGPLAX7/75ezP+vKv6LdYu0nYmUzlx2euhFhuZeLCgWRXoEz2lU00NsVtGkuPdx++E6J4VPhA==
X-Received: by 2002:a05:6512:5c9:b0:511:628b:e892 with SMTP id o9-20020a05651205c900b00511628be892mr3566363lfo.18.1707725833207;
        Mon, 12 Feb 2024 00:17:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUs7XEs8KeS393ekavX+e0qY6zf8PdKzadsaOo9BIU9T6etRtf1Puw2b5kGzS6rQkjt+SiT6G1S+Y+HVuwfHofLKHQHHu2opqLxQz5yS5HQVPHdk40uoSK4SgcWHVttNZ+AVwPukvVHfLgyeW/Noa+0icNmxhrdF7ewlLzEhoaVDxDsT2DKRXQ5uTHtAMN9TgEZ9LlYbf54JmQi39oOj64jMcl19U3yn8RJmUrYqk5dVYKYL+5y9P9B2CBrIAcbFeC8UwC1Xncr6hkRjgz6/ONRrnXVIOOxFxUB/zs/9gtZMSl4zSqT4HLfhXpxzk+g4w2aCLEqa5dneqiGD/K2tOHwm/ndelIM4b5OicJImrg7RqVsaQ1sk8Da6hQjH6sXlcc4lzfbO8awhHIwl2CBnXohHZxYu63hAbVnR2oJa3CCQBIWqJnGfa5Qxjz6IeJdPH/n+e7IHhSqnSL/hinECFZhbgdh80M0NwSvE1m4D7Vn8drKlIEdgkwwOggdOe941QKfhEK69/usupRvkavvzeRZIukkw6w2p3gr8VDeYEKgY6hAanOusMFtH+FZButx/mqyPKgM5fWgRDepHyJOT7BYb8OQpjw7MQh4c2eTnWYA+tYGaza2Vwkg1qR6/+rxAX0vuC6kScjOaA==
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id c8-20020adfef48000000b0033b47ee01f1sm6010609wrp.49.2024.02.12.00.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 00:17:12 -0800 (PST)
Message-ID: <4e61a26c-3670-42f8-bd51-1e44578f1308@linaro.org>
Date: Mon, 12 Feb 2024 09:17:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/13] dt-bindings: reset: mobileye,eyeq5-reset: add
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
References: <20240209-mbly-clk-v5-0-f094ee5e918a@bootlin.com>
 <20240209-mbly-clk-v5-4-f094ee5e918a@bootlin.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240209-mbly-clk-v5-4-f094ee5e918a@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/02/2024 15:31, Théo Lebrun wrote:
> Add DT-Schema bindings for the EyeQ5 reset controller.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>


> +description:
> +  The EyeQ5 reset driver handles three reset domains. Its registers live in a
> +  shared region called OLB.
> +
> +maintainers:
> +  - Grégory Clement <gregory.clement@bootlin.com>
> +  - Théo Lebrun <theo.lebrun@bootlin.com>
> +  - Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
> +
> +properties:
> +  compatible:
> +    const: mobileye,eyeq5-reset
> +
> +  reg:
> +    minItems: 3

Drop minItems.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof


