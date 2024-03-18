Return-Path: <linux-kernel+bounces-105779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F7087E43C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84A56B20AEE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A724223763;
	Mon, 18 Mar 2024 07:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kN0K0IUS"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE6C22F0C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 07:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710747969; cv=none; b=mu+jqkhSCd4adRmoI2ej6UgOOT4iiCZQOWzyuCYXxeqVPFf4jgDo4pe8cL9VL0hfwiSo2qGS0ALgR4gZVq0Rz4iK3fwsV+BDE67YNLmmI6GF78z1N/xkwuo6HdZmlG/3NhNejc1PISo0UlzhlBxtVPeW6/Hgu+BQdNB5dXS9XLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710747969; c=relaxed/simple;
	bh=y3WZnxaRLumzG6G1ASmxGTs/zWsV4MVpU9WYuiMAELU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZFj7aR85JhWYRrg1L0seLLo/eqnnx3cZaX4p40SYEGPLDHwg5pOmNft20yEf+NvJuafU5nsSac6waILwOgFWeMJGCAPUQk3f/VyxJGZOxaSZwoCfEtRsucgaMRgmnQ6nVKKrhc/tzoCQLUGyJFl+vTr57cfFEWe/EtELlGFSF0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kN0K0IUS; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a467d8efe78so386084766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 00:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710747966; x=1711352766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U6FdA6MCBFgFpfyExPtk5oTZiXP8Z8L3nOt0OhNonkg=;
        b=kN0K0IUS8qIvANB/kfHr11GW6MAO1MXtbbMgLPgMVOkN4gQNTttM+5MtUB+WJNTB9b
         MaJSeW8HkfJb5M9L/Llj3Kb+ALaIv2q9HcB13k4YswpoiKnp9u/tbHZ1quZxo6AK1aaq
         575/GlaSsleecsoqix8ADCNx6riYFE76scAd9Soxd4Txitv/Rw6JdGHiHyIeo7/b6EsU
         awfLo3mzLPoSO3AAWVonvoEUIS8AO4sOcCGvL115lmDSTbvdf7D+Y7lkLvF0MwaVZ33S
         KhEn5a4o7W6wEaDtG9zHbgoPbTbnRJ5imtmSGFG3XtRsL2JaOwEL3CuIP1AmPxPBl6g4
         6Oew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710747966; x=1711352766;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U6FdA6MCBFgFpfyExPtk5oTZiXP8Z8L3nOt0OhNonkg=;
        b=BNq1engRIILi2CpPSgkC6Mt/XI0NF8ulydXVjj8JVPqAfFrDpsAnO59Jm4xgJS5kbB
         pIK4wyxK2WeYQBh5Nzmxm1XvHbHIrDF9WObLdGb0jN698i72ZfPIspzktKiKSd64t/V3
         ty0UQPueA2ArxVRObOS8gek9Y/3Gfqc3npM7R8H91Cw++z/BfiXwkK47oswg+B1XWMZL
         5oNZBKNMsBWEvW4qmVYRfKdO2cyHSAvPVviM0BIZFMlDSrZF+UjK5M8Rc5DbmSmuCNXZ
         jJtG3K0dZrCcUVSmc62dEonW3cgSPmajJmdf0nhqaucpTdVOktHymfGQLB8bAsDQwyKH
         eNuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlz03Rw9EgNENe2FsGgMfnQ7SnfaJFa+EimxMcoz6pRAmlZMSK5BjbkasiT21B34ORlqeBS7QbRDR8q+wZtyDbYz6kcNF87+onKmdM
X-Gm-Message-State: AOJu0Yx2d8YkzGZ8z82mYHpZxCnUk2MCE1kKjqZ0rx4kigzsLoQThOI0
	vMOPvKc5dsO0fkNEjqi1lSMYOCcvb1HfdPqed351LtmPWqWMlj7j5/D2IFWo9HY=
X-Google-Smtp-Source: AGHT+IFLySr29BPlmK1ab29F+3z9XjUhu8TKS1L9V6lJm6vACuiT9TzdJV7XudEk7ySfdgh7lgvVpQ==
X-Received: by 2002:a17:906:3e18:b0:a44:51c1:733c with SMTP id k24-20020a1709063e1800b00a4451c1733cmr7411199eji.39.1710747966456;
        Mon, 18 Mar 2024 00:46:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id k9-20020a1709063e0900b00a469aaad6e6sm2917532eji.206.2024.03.18.00.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 00:46:05 -0700 (PDT)
Message-ID: <a007c2ee-2777-4db0-bdaa-c119bceeefe9@linaro.org>
Date: Mon, 18 Mar 2024 08:46:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/25] ASoC: dt-bindings: meson: t9015: add support for A1
 SoC family
Content-Language: en-US
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>,
 Rob Herring <robh@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-amlogic@lists.infradead.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-gpio@vger.kernel.org, kernel@salutedevices.com
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
 <20240314232201.2102178-12-jan.dakinevich@salutedevices.com>
 <20240317190316.GA2071139-robh@kernel.org>
 <7d61700d-bfb5-46c6-bd45-a18aecf06a5b@salutedevices.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <7d61700d-bfb5-46c6-bd45-a18aecf06a5b@salutedevices.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/03/2024 00:39, Jan Dakinevich wrote:
> 
> 
> On 3/17/24 22:03, Rob Herring wrote:
>> On Fri, Mar 15, 2024 at 02:21:47AM +0300, Jan Dakinevich wrote:
>>> Add "amlogic,t9015-a1" compatible string.
>>
>> That's obvious from the diff. Perhaps what does 'a1' mean? What the 
>> difference from the existing compatible?
>>
> 
> a1 means A1 SoC family. The difference is described in next commit where
> this compatible string is added to driver. Should I duplicate here the
> explanation from that commit?
> 

Bindings, not the driver, describe the hardware.

Best regards,
Krzysztof


