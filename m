Return-Path: <linux-kernel+bounces-77112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD1086015A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E0111C21D44
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E283D14DFE9;
	Thu, 22 Feb 2024 18:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tLJVan84"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1AD14CADD
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625761; cv=none; b=Z18XBj5vEHLEfpkZzRCw/obkEg20fj9Ylu9mO2rquOhoutPyReEwmlKMhEx/dx0vjMV7OVr5FP8ca5i5mnLmUh3D44clQTqYjknQyo7uPGYt56VIOk1CZ0/esIFKjyx0KdbeUMz7GqoJ13uH3pmnOdO8AcG6fY05JoiK4gu1Z/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625761; c=relaxed/simple;
	bh=nidAHpTLCFluFSzOd2Un+/NJklcEHVtV4Y59kw7EDPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+XrskEHXLVeKLl1gh74EABFNbfEtlEwnMJvJB5yfL59B4B1CywZmXDjfIwh/9xxv8OzmEaVdJUD02Zy2i/6zJZTDaE8U9GicWxReVYRttX1P6+Cy4HnGU+wxHu8BCtUHOtiF9gWRGFdKLA5xXXvaOZ5FJlmR31cVJEgKAmrOCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tLJVan84; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3f1bf03722so2878566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708625757; x=1709230557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1WhusjzVdfYQ4ZWgXhFcfd9BJCjtU5eHYsInagp5fds=;
        b=tLJVan846vnAN7Oi3LiTKjWfQFhBk3zTuJe7S8nPsHmU2l6ldczMNqFfVX+/3UFG+L
         S1NGFlDt6+yKhBAUv4NfLJ0rPvUBlYapbnJpEsE7i0Id7AhaV6urMOFAp5Lhf5hM3aG3
         L4MiMWlhMaI55XMF1YbJXtqyo7V5+9smx4puESrBX1hhxTt6og+65Oog5HpK7NMte30y
         Ezv+uWu/lxI/kgAbvm39Mty2VJvRw8+cLKfkcSafYRB532Odb+UTlHTsLiuZqrfqzsxz
         grwoa9/iwxnH9IWfkzTsEOwTI5g7MEdG5B3fuh+6ejo2ORVzujaU37WODrh5HHMPKEBh
         gtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708625757; x=1709230557;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1WhusjzVdfYQ4ZWgXhFcfd9BJCjtU5eHYsInagp5fds=;
        b=lIEvBuo99B/NYHgMl7vnh31sqFbbAbOF8UUKkq6F2JW1y/Kkqzu3IMOdyhN1JW4MNh
         W+X9bwS8QRexN4S8QHOPCvMsJA9jxbsjHEscq227GaUHHD/ShaopBtmxHiFySH6NMA2t
         fR0hBUcG5SW1pZx3zSQiq9dv89IofI5v5Q8uqdXLLr/X52J1gSlWxvYw6mF/dE3x8l1Z
         E0Bfii8JSZqmm8G8HWC/qDU6wc9rUjbqQCeRUdK7WjfliUCCki5eQ+e+LWEkRzQiH6jT
         QjHc4Ai4T7+oFUWmpGcXoE/qqJiJ9lTcJZ/+ZKnGF9WZ5J1XeMYHRZ6iB2z3vRJ/xl7L
         A76w==
X-Forwarded-Encrypted: i=1; AJvYcCVZtN0xSgX5RXY+FSKGkxEnxmOpaMQWqiq8VMXlYrjEcSonwCBgUeUWAMArilKwbcWS29zrRxeR9WQ/xn7rqFW+uyTR6aNIqhfySysI
X-Gm-Message-State: AOJu0Yxfn0+kyuPSatbcNGLAYFAPju++lvKqMa+aQu8VaU8nvVtkrpiv
	Jr5Mrxjaxx29BpaWJayFQM/jn2FshsqRa7ynNnFEGpVW5YMZfecF0p93m4uDt54=
X-Google-Smtp-Source: AGHT+IGmi4bJq/XE3zLMdllGkAlfctdaXnTsW36rdgjSPC1niyHKTQpV8I8NT7ExWyrxYp4oVMbhnw==
X-Received: by 2002:a17:906:6bc5:b0:a3f:baa:b52b with SMTP id t5-20020a1709066bc500b00a3f0baab52bmr6445882ejs.26.1708625757607;
        Thu, 22 Feb 2024 10:15:57 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id ps7-20020a170906bf4700b00a3f1cb81dcesm2266058ejb.116.2024.02.22.10.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 10:15:57 -0800 (PST)
Message-ID: <c1931bd6-1a9f-4de5-ab0a-d940e2cd062b@linaro.org>
Date: Thu, 22 Feb 2024 19:15:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/6] dt-bindings: net: hisilicon-femac-mdio:
 convert to YAML
Content-Language: en-US
To: Yang Xiwen <forbidden405@outlook.com>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240220-net-v3-0-b68e5b75e765@outlook.com>
 <20240220-net-v3-2-b68e5b75e765@outlook.com>
 <174b9bf7-fcdb-48e3-a6d6-5d2ea96fce58@linaro.org>
 <SEZPR06MB69593804E2F62586EF6841B096572@SEZPR06MB6959.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <SEZPR06MB69593804E2F62586EF6841B096572@SEZPR06MB6959.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/02/2024 12:24, Yang Xiwen wrote:
> On 2/21/2024 4:12 PM, Krzysztof Kozlowski wrote:
>> On 19/02/2024 20:57, Yang Xiwen via B4 Relay wrote:
>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>
>>> Also mark the clock optional
>> Why? Your commit msg must provide rationale. Clocks are rarely optional
>> signals, so this looks wrong.
> 
> 
> Well. I don't know too much about the hardware either. I think the clock 
> can be either shared with MAC controller or completely non-existent in 
> hardware.
> 
> 
> But from the driver side, the clock must be stripped from MDIO bus node. 
> The clocks must be controlled entirely within MAC controller driver. Do 
> I need to mention it in this commit too?
> 
> 
> Actually I've never seen anything like "MDIO bus clock" in the 
> datasheet. The MDIO bus and MAC controller are activated simultaneously. 
> So I think removing this clock entirely is also acceptable.

None of these are arguments to make the clock optional. The last one is
an argument to drop clock entirely.

Best regards,
Krzysztof


