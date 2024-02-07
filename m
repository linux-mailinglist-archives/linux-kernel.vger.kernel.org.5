Return-Path: <linux-kernel+bounces-56701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDF684CDCA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D83D4B23001
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4287E77F;
	Wed,  7 Feb 2024 15:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y3uwWVhG"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433765A10E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707318927; cv=none; b=Jbt/hCqeGrLKObu34ius8xy2iV1Jm8PK7rTj8D/smb6zZ8zpaQDPkNdBKvNGxTExe0xYakQoTAYE8RQ9fLefvFPYFuDh+I70rXt3IzLCMdiFTqvrxZA9O/8/2n58tReQs+D4rKJvz9aoQmVGJFKPnM75577ZuFjyVrGxZTq43VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707318927; c=relaxed/simple;
	bh=Ee6zdJvXpiG5HuRLWseEQDAdHe8kVEf++zpV/vNVZWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mikS8RX+pn5bsabJaL4NLC6lKOM29My25rleOTZ0fX3YniRETCUI+bcK9ROgDHlpqwXZZdyLzjw/9oR9Pz9nFSzCv0EiNFGpnXwrBBj4ES76wEdF7ffRhQr5IQJqPlhD9dg9w2pnKxxLFEkhCefdMT9N4c4KPMf0BTYeXZco4xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y3uwWVhG; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-339289fead2so588424f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 07:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707318924; x=1707923724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yVx0j6ksy+fPFmDjr9TzqWFPvcyfqzshrjkQRum4aQA=;
        b=y3uwWVhGV1Kji5SNiMiQV60FUIIBMT3TyC7y4yf+Aw1UTVtr0FeAShYG3S6neQ5g79
         wu22tNA6Dyk7u0QngaSaCfFfwwOnr6lNZMLunbhXV/9PAl01lsDKORMF+5a+s07U/JuG
         4/OvVvjrUULAcyNkFpzQBWW7ZOuNi5jfRo9rwHuSWl6XvhpGu/CQTdfI4GCmTZJ/RJ1K
         jLY01NzQd7ZqGjRulRwgpK/BRUTSaP9rWQGL4B3icqg0CritMGey6EdeGql4FV7KCWwL
         yc2AILwo0FtiHFEsS0068PRhagHc3JZ3bI45GqM2nNJzUl2TeXa+5+ZD4ZlNp7Goshbh
         tKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707318924; x=1707923724;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yVx0j6ksy+fPFmDjr9TzqWFPvcyfqzshrjkQRum4aQA=;
        b=v8FkywXWz2F+txlVbZbqeU8jsVxxgiZyaebRMoiMMJaQmLiFnKI5EtzQYvTnr727+A
         2LNUl+a+4sLc+2bHeqDAlUHYL2o9RPOTGjoUm8dqitAJq9tN7eD9PNztzs148Gb4Coor
         87/ICkewPuWkbw4b4fsGWh42xYEEfidH8ZIoY2KYioN72qiwrKx97x4lzJquCsiWgxnU
         T9/q5s76bd0j/duig705KVBau/glx3y+OGqOYejOmgOg7pqcv5Y4mqfeBhqCJRSwfisy
         sZPczn4KeWv8DxcuqsDNn1sb0ZaP/40toX52Fxx2OYPCDkmBl6XHUPFEF+eEC9SOEVs4
         ldGw==
X-Gm-Message-State: AOJu0Ywva2A+vZbE7FU5+p2iDLTBhW5AHIdWbJEcH2BRb/jTw9b2DQoy
	5d5IMKOGImzlEmk2B0Hx+qyqlAmcoinAxkwGYOILir8v+t+3sgheUV14f0YVukg=
X-Google-Smtp-Source: AGHT+IHaxhBSKFF6bw/jMltRFvFdiYojKtEFlEkPjBte5M9Xxs5ibAsnQ5yOevTKDwqaID6Fc53OqQ==
X-Received: by 2002:adf:ec88:0:b0:33a:e6e4:945d with SMTP id z8-20020adfec88000000b0033ae6e4945dmr4160304wrn.2.1707318924540;
        Wed, 07 Feb 2024 07:15:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWfiru0AQpeYhUI8vqrCoCLBLFe906Q4pjagcdMdTvfZP8cWIOreupvs9ep37jtkEe9KR7dvZE9oMUfT7mTPmecqF4TMnKFP+34F/5VsNn+omOvVcjxuEQW+IjuvY/yulut0dU1dkWKlkRG4z6lTWdz9x5xH2haZD5zWOCrWPGxZyAj01AbX6+LD6XP6mzHhBdGTVvlV1ZEfLK0zP+F8hPYMOePrCP2X0MdbsdG2zLwd8cJ05Hh81FDb6Dm7xINv9S+ON1+Dun7TcObVCG/3BVENQRXBlWc5k58EhgihF6xTIKd62+gImZyvnuGxOw5iRT16807Iax10PeY1BwBW3NSHeHmpUKyb7ci0qPfh8SvFSIlDHtgpWShpAzcUBdfgn/pMEk09p8AjJ2YZDRWYfNDHb8FFlXHk380SYVhdlzfo1wkk8RM0FL6zV9JuBjtYQM6RLctNRPkGMFSlyk8rRkNvtO/fe6g9UU=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id k23-20020adfb357000000b0033b5008b5a1sm1292176wrd.94.2024.02.07.07.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 07:15:23 -0800 (PST)
Message-ID: <982e81db-3bf9-49e9-b57f-a91612d62f5c@linaro.org>
Date: Wed, 7 Feb 2024 16:15:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: input: atmel,captouch: convert bindings to
 YAML
Content-Language: en-US
To: Dharma Balasubiramani <dharma.b@microchip.com>,
 dmitry.torokhov@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240207090853.188400-1-dharma.b@microchip.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240207090853.188400-1-dharma.b@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/02/2024 10:08, Dharma Balasubiramani wrote:
> Convert the Atmel capacitive touchscreen bindings to YAML format.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.co

Thank you for your patch. There is something to discuss/improve.

> +
> +properties:
> +  compatible:
> +    const: atmel,captouch
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  linux,keycodes:
> +    minItems: 1
> +    maxItems: 8
> +
> +  autorepeat:
> +    type: boolean

You can drop entire property, coming from input.yaml.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - linux,keycodes
> +
> +additionalProperties: false

Instead:
unevaluatedProperties: false

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/input/linux-event-codes.h>
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      atmel-captouch@51 {

Instead:
touchscreen? touchpad? if none of these, then just "touch@51"

> +        compatible = "atmel,captouch";
> +        reg = <0x51>;


Best regards,
Krzysztof


