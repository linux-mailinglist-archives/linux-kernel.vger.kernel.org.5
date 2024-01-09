Return-Path: <linux-kernel+bounces-20507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8782B827FEA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01AA1F25844
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239B4C126;
	Tue,  9 Jan 2024 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SteUE6PU"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7DAB67F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 07:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5534dcfdd61so4707279a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 23:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704787117; x=1705391917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Oac+sieW2ORkVnCZNNxb86+tyi15tQxVSaqMw9NNTkg=;
        b=SteUE6PUAm9xbqGOvMKSMIDr/skoJum40w5hFj7ugRNLsDRIvTsI5se0X4a9bj7sfW
         HyDljydAVCzitHB7tbOnguiVMFVBsDVj2DsAB2nQsF5qt4nfoIKe8eT13AR7cisDcpsY
         ah5Xm6bpak13Q/UzqOEDaQ8sKMSMz3On8I7TAKkIXro8DQuFoinjXBslEkvCYM6m5nnh
         i2cmFo4Fm2kJjGJhYwGCRZA5azzYmJXpeATHpt7qJCyKygUUw29qL7Z/wdqRTRa4LQtZ
         MUiDmONvGHtcJgrHROnRc46qFIkcPQHDk3/82lHzWhDZmf+LALlQQGk0ArM4CfVIVyh6
         i9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704787117; x=1705391917;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oac+sieW2ORkVnCZNNxb86+tyi15tQxVSaqMw9NNTkg=;
        b=Q2kVYLOcCh3mtkkFDzgrzhih3zsWeplCsHHMs0SxnDOXgpbXiBcqjUCTNwDs633xHG
         NRxNQJ+4c4a94ofUN/Oy1ZtJ5gmAcwI61uGm4h6otLIBtB22PsWZOyv/ItiX8DUOwDTe
         T+K17ANv/pWMHLInhFjdryBH1dcshJCOnz9Cf5pmgFV8LLUyNdS3KQTdsIono3KMs9Zv
         k0JECSFO2I7e4EYkndWBApBC/yOLOcc/QLfkHTlqGwwXRxbgq6CJykpbUZUNaJhaYXbQ
         DHFouS0NiCLJ/4xweCN9KFq5a7UPgZi6osXR2BLEwviUHEXU5HcRPJiDfTd16AiueXw9
         ChyQ==
X-Gm-Message-State: AOJu0YymYfs+JEnpR/kLo13BRe8xVQQuT7k0wpw1W0wTE4WikhS5mdtP
	PF13buKA+nSHnIeZdQg94DncmCg0IrU5ZA==
X-Google-Smtp-Source: AGHT+IEumJJnbr7FIbHZhb44H9i/du6BYO9ldfF/Vgy2gAzFWs/DlPJk7gsHP1cnWCH2iQVr5X0otA==
X-Received: by 2002:a50:ef07:0:b0:557:1654:d705 with SMTP id m7-20020a50ef07000000b005571654d705mr351754eds.5.1704787116782;
        Mon, 08 Jan 2024 23:58:36 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id dn1-20020a05640222e100b00557e0e24abbsm657444edb.59.2024.01.08.23.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 23:58:36 -0800 (PST)
Message-ID: <557a2dc7-d1e3-48f8-8eea-4792211849b3@linaro.org>
Date: Tue, 9 Jan 2024 08:58:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: stmmac: Add StarFive JH8100 dwmac support
To: ChunHau Tan <chunhau.tan@starfivetech.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Simon Horman <horms@kernel.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Andrew Halaney <ahalaney@redhat.com>, Jisheng Zhang <jszhang@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Russell King <rmk+kernel@armlinux.org.uk>
Cc: Leyfoon Tan <leyfoon.tan@starfivetech.com>,
 JeeHeng Sia <jeeheng.sia@starfivetech.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20240108075810.14161-1-chunhau.tan@starfivetech.com>
 <20240108075810.14161-3-chunhau.tan@starfivetech.com>
 <1c0474d3-e182-48c8-8ec2-12847c84164b@linaro.org>
 <BJSPR01MB05950484841C3D104EC91DEC9E6AA@BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <BJSPR01MB05950484841C3D104EC91DEC9E6AA@BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/01/2024 08:25, ChunHau Tan wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Monday, 8 January, 2024 5:07 PM
>> To: ChunHau Tan <chunhau.tan@starfivetech.com>; David S . Miller
>> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
>> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Rob Herring
>> <robh+dt@kernel.org>; Emil Renner Berthing <kernel@esmil.dk>; Rob Herring
>> <robh@kernel.org>; Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>;
>> Conor Dooley <conor+dt@kernel.org>; Maxime Coquelin
>> <mcoquelin.stm32@gmail.com>; Alexandre Torgue
>> <alexandre.torgue@foss.st.com>; Simon Horman <horms@kernel.org>;
>> Bartosz Golaszewski <bartosz.golaszewski@linaro.org>; Andrew Halaney
>> <ahalaney@redhat.com>; Jisheng Zhang <jszhang@kernel.org>; Uwe
>> Kleine-König <u.kleine-koenig@pengutronix.de>; Russell King
>> <rmk+kernel@armlinux.org.uk>
>> Cc: Leyfoon Tan <leyfoon.tan@starfivetech.com>; JeeHeng Sia
>> <jeeheng.sia@starfivetech.com>; netdev@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
>> linux-stm32@st-md-mailman.stormreply.com;
>> linux-arm-kernel@lists.infradead.org
>> Subject: Re: [PATCH 2/2] net: stmmac: Add StarFive JH8100 dwmac support
>>
>> On 08/01/2024 08:58, Tan Chun Hau wrote:
>>> Add JH8100 dwmac support.
>>>
>>> Signed-off-by: Tan Chun Hau <chunhau.tan@starfivetech.com>
>>> ---
>>>  drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
>> b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
>>> index 5d630affb4d1..373714f6e382 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
>>> @@ -146,6 +146,7 @@ static int starfive_dwmac_probe(struct
>> platform_device *pdev)
>>>
>>>  static const struct of_device_id starfive_dwmac_match[] = {
>>>  	{ .compatible = "starfive,jh7110-dwmac"	},
>>> +	{ .compatible = "starfive,jh8100-dwmac"	},
>>
>> No differences? Then why aren't the devices made compatible with each
>> other?
> There is a difference between JH7110 & JH8110,
> JH7110 has two reset signals (ahb, stmmaceth),
> while JH8110 has only one reset signal (stmmaceth),
> this will be shown in device tree file.

So if you are so picky then again: No differences in the driver? Then
use compatibility or provide real arguments. NAK.

Best regards,
Krzysztof


