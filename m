Return-Path: <linux-kernel+bounces-61193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07336850EB3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC092819DD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5F8DF41;
	Mon, 12 Feb 2024 08:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GzmgUWUB"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE6379FE
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707725796; cv=none; b=EUOM5GzFTIgsSN+c0kpVeM9XPXhQoz6CLhCmjmt0G1jzEaACiQajaVicV8qqXOud5H+r4Ndk1dZzjnbIcEXmEh1+mx0Yw+LmxArbvCe8Jc22iKJIcbThkBOC+K5kQa5F62nRFPWTgIu1e3oQ3gbbzgyK+vTtlP2A6e76xxVT/i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707725796; c=relaxed/simple;
	bh=lnA7AQg4OQYcbyoT10jeMAb8/Kg1cBRUWjd8y9wSY60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UU8MBylcGfp7DiNV6mWnvAyHTD5HDVnFOc9K5RZ+LOWCwtHi6vzqop0bUgesO3dTW+CRxV4nYby7J1DF/zFUKgmPRAXUUtYVNbk4tnYtC3Yb54nd753veFCHE8/ScJfqyhguroB18OqxLNLBtmpjeGArUVha2GnkfwN0NEXWwbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GzmgUWUB; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33b4e6972f6so1468634f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 00:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707725793; x=1708330593; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VQ/0N05enNbIDJTHhmIznkmaqRFnkKX0wYQUBqTz1WE=;
        b=GzmgUWUBHkCCU0gfW2z3WhFRJimwiaH4p00pIMhDmJWa8kOg6/UN7hRdZTNrQEveZB
         c81kuYmjDjJKb1vFJQjXGWSARTAPYTOc5bFab1KJtCxsUC27+lo1pQjon2wBoID3AjE/
         L+6hLktn0jkaXWfwr723r8UmGuEdbd2LnRREjuOwc5adpiU3sPYLOC4tQbNEgrsuWFca
         1B1J4HHp81P+jf3Z3Kzo6u3qrLuyVFCUe9hDuRy/f80Q7EY5DCaOym2T+RUmqPwX0iIY
         uKi4IxrPus40EtSildda/utGlQdiRa2Q0bRWGJs4W0+1BDHaiXhcr9Khde90QDVIzUrP
         Bydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707725793; x=1708330593;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQ/0N05enNbIDJTHhmIznkmaqRFnkKX0wYQUBqTz1WE=;
        b=sxEnj42bW8nf7JU9+NdKWwsrnkoMN/4gPRtyQqU00dKcycrUF4tILkzbsvGFX11nNe
         ICf7zoDup8cBfOAv8wDNYkFpegJ3ilHJJbcFmEJ19u5V51C754RFtgKTuDrwKRqTPX7c
         DJ+chfDa0HBshLbfw4Si+rIqt6Dh2gX/kuXgVWfOu8Ehzvn3fOwFYkzeDEcOAtOsgCMY
         92ssDrJlenD5R4PQNULomV09GW+KfLvZMBdMBmRZgf6g2PzC0Rh3Vms7cZOfbPKBnENM
         Y63gvaGAGNS1lR0vPeSYTfDj+ZkLDS8rZ0hD5x1Hi9f865Eq4CKpCVr/Qg5XRrHg3P3A
         PoUg==
X-Forwarded-Encrypted: i=1; AJvYcCX8fYKAmrfwv5LOTMD/4CKkXQOppYyhWRjq8eixVGBbJGKcobI+5swqMBhgCTrp0CVtUr5PnurMCCTx1Narn+k7CKGBzLKE4Xl2Q9Mu
X-Gm-Message-State: AOJu0YwGTWhUMxMGg4+L6x6Om4XDT+pGnS8e6bcCh+V414ACxT6BckKZ
	b6noKsyFUH2hJo0hRL5CJfAxN0w7koA4gT+IfvNN7EP7J2RPM8H/MBNOuZT5cok=
X-Google-Smtp-Source: AGHT+IGAWzhtaQE8utUbDczKJPQ4A0A3SOqB0BrY0YcUYSweRYY+KPEtBmu2OPju2MoRt672IZzS+g==
X-Received: by 2002:a5d:668e:0:b0:33b:86b2:4753 with SMTP id l14-20020a5d668e000000b0033b86b24753mr540297wru.60.1707725792842;
        Mon, 12 Feb 2024 00:16:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXCeDwONPIbNNPgjZmGFoB5O6rldbb8pu47pIBlv1KymtjGOZTclwq5T9mwZo+QXo4fTz8QnYTw7GdKonbNef3PiWtkZZPC7E98rYgybfjsKBTDSFDHtHdrtvbnc4q6zaI6eczoOesEFsjtKDoSXKxjCOFVeVplDfHPrxJxMcDgfPN6wxWFtEDTmEW1PtwuMHjHX+erMYBfHMPTQBXjA/vDs5w7wE5Xhnhbcf0pa38ljeHR2JSRBRYjlLZK25VTS+RY/7SMjlBPnyIql8P7I+6DIs/7GDE5aMC2bKn70qU4eX8YiCY8CtHgz8rjleVn7YWV67ug2zx7bf6S5RZJz7jUzSx5pwIxdkdvby/4ZlrEhM7pFwujPbCM0Q9Rb49a95omhNnokWcAoE0kDhnbRSZIO9YGaTrlLMzPEE5S8g3EDihBL0UtP6ed7PXmLMg+G3uuD+5u0+gIO+F8bU/ODKJqhSiYbJ9z3/0h6x6SxbDTL2Gi1KB8nKXVdSPNaHK/6N+J2zjG23zJQOKwTQBLiYGAzPSnk/6CsHI8L/zNMOuAK/c1/UV+qTyzayp82x88sg6V9ifrMFG/CgIgfGJRZX23gGqxsljjD6wk2orpFHG6O1sMOhIiDnx9X8kox0WoUBgQkzr/wSu5nw==
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id c8-20020adfef48000000b0033b47ee01f1sm6010609wrp.49.2024.02.12.00.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 00:16:32 -0800 (PST)
Message-ID: <888b0972-0c57-45c1-acc1-cb851d201a51@linaro.org>
Date: Mon, 12 Feb 2024 09:16:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/13] dt-bindings: clock: mobileye,eyeq5-clk: add
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
 <20240209-mbly-clk-v5-3-f094ee5e918a@bootlin.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240209-mbly-clk-v5-3-f094ee5e918a@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/02/2024 15:31, Théo Lebrun wrote:
> Add DT schema bindings for the EyeQ5 clock controller driver.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---


> +
> +maintainers:
> +  - Grégory Clement <gregory.clement@bootlin.com>
> +  - Théo Lebrun <theo.lebrun@bootlin.com>
> +  - Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
> +
> +properties:
> +  compatible:
> +    const: mobileye,eyeq5-clk
> +
> +  reg:
> +    minItems: 2

You can drop minItems.

With that:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof


