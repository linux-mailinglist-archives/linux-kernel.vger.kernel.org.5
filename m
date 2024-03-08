Return-Path: <linux-kernel+bounces-96789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4F187617C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2B31F232CE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC4A53E04;
	Fri,  8 Mar 2024 10:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FJBkVXlm"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D716537FE
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709892329; cv=none; b=pQ0BkrzgkynLX34F0ndY51q85iUeS46R7U50k+qCxYYMPUV1irGZB82WZYXbXFBXw3JL9BvzOfbEyd36/bS0NOZrSpOdvJmq+711eVwX0HrHakI9144UgU1juRUok+k8gQaE/yvrOYUODNObHYEe7vvVSeXvwugj721l++ERT0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709892329; c=relaxed/simple;
	bh=0tfAeMQUlpQDr82AXFcKijJXEjPu7V2loQY52vpD+wE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FBzC8Mbtu4HaEJgnGTTNQf3rscxP55cUys0GOogNf6V3gxbPr8y/bsvKwTyC8/QdII7w+Ijdb6S858g3hTrb19TIhR63JDmktpBgMdNxNgOeFUg7JQ/H30Tp5lbEchcLSMARTATtmAknAvvob89TW98d6OJG7KXY06hmtGjrgm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FJBkVXlm; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a45bb2a9c20so242041066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 02:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709892326; x=1710497126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K+4qt/ePIU4s+QXb1RnCcwmRfkb/Bqx14xM83vPg++U=;
        b=FJBkVXlmoxg6rbMmuHGGqm/Z/xL/nlQJyrFAttwqQwgVC6k3QBg0KgKdJV/Dzz20+e
         7T6qZOcygCnilIf5bMpL0Y3qcQCAHpPX/KjSXWKEKTPpunXzQO1eoP9jNwKqiNrodIpl
         OTa8KzgDChoj59s3sefQ7zP/UxrT8c0D8hte9Pu9ls/bexbnxU6nRFURjngXigZj7RA9
         zQvHriCnAfQ5l0wWLWP5Bp4YvwwKJsOPIqvBYGkZKGSReIDpQYowkRSp04M4hie35N4f
         uIdASaTsolxJUk/EmDy+lA/9SiL1JeYOCKwGBzuqIgorwDErIbsashL2CKzCrUXeByhB
         0zkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709892326; x=1710497126;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+4qt/ePIU4s+QXb1RnCcwmRfkb/Bqx14xM83vPg++U=;
        b=Bf0yOXejVie++0VaXtLTa5435+/6Msr8XAAqzw/JlmDy85eH4gvVE4nrDM7wZxFSaq
         mkMD8y2BoZjXqESGjA7TP8Y1Xsj+tIxrqSbn3ea9KHJFu/T3BIFcRKNlktdoQfi5BFZY
         141u4F+L2WlO+Jt6aHNcLT62nF0Nyw5USKG//keYfMaFr1wD1y+A2YHsLYITlcA6JyiD
         fa5IAmSQdO5pxhasBAL9HiU21RkUZkvcp3CThGgbLum6uLsIIdAfHTjo321zSeBNUgny
         Q7jAw2LPo0karQqOi2P0SSdi/YW0ohi8wtODZEm5quBcl8RsxPN3EtaHthzB0L80gbVY
         f/Iw==
X-Forwarded-Encrypted: i=1; AJvYcCXagOxn74+TKkiqeBolOF6nBq4/zFP+kFAAUX0SDFY1h3fNHCEMAXPjsCPNiuR21CxaMiTX7oCt9Tt4r7oKAkMWrXjYe0yLIoBFlL5A
X-Gm-Message-State: AOJu0YxnLbaZ2gHdCFnDRaM0Bm4kWCPsx0tXpoZj0jUyHDyh2VCrJLPw
	aMfP/ExzJRK39lUJSjntZ/41PqjJBV7OGmdJq5X0nLu5Vrfd/dEXo9hAojynk5g=
X-Google-Smtp-Source: AGHT+IEYCnSGtfhIa3FWIcWjIyqFpO9DM77/UrSvtyrpBRz8JUn+xIULHlgqe0hqZ7alF+udXAUNFw==
X-Received: by 2002:a17:906:3d4:b0:a44:8c1b:8877 with SMTP id c20-20020a17090603d400b00a448c1b8877mr14778671eja.50.1709892325559;
        Fri, 08 Mar 2024 02:05:25 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id n15-20020a170906088f00b00a44fa8ec421sm6575682eje.205.2024.03.08.02.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 02:05:25 -0800 (PST)
Message-ID: <9307ba55-834a-4aa9-b993-a54e5ab4b3be@linaro.org>
Date: Fri, 8 Mar 2024 11:05:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTog5Zue5aSNOiBbUEFUQ0ggdjEgMS8yXSBkdC1iaW5k?=
 =?UTF-8?Q?ings=3A_ASoC=3A_Add_PDM_controller_for_the_StarFive_JH8100_SoC?=
To: Xingyu Wu <xingyu.wu@starfivetech.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor.dooley@microchip.com>
Cc: Walker Chen <walker.chen@starfivetech.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
References: <20240307033708.139535-1-xingyu.wu@starfivetech.com>
 <20240307033708.139535-2-xingyu.wu@starfivetech.com>
 <0b92700a-cf79-4f1c-986a-d18fe0151bb8@linaro.org>
 <NTZPR01MB095618FAFF22BDC301F69A0C9F27A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <740b1f29-ab80-488b-b40d-3b8d95bc6c23@linaro.org>
 <NTZPR01MB0956A8DCFEF13E4905D97B479F27A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <NTZPR01MB0956A8DCFEF13E4905D97B479F27A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/03/2024 10:19, Xingyu Wu wrote:
>> On 08/03/2024 08:49, Xingyu Wu wrote:
>>>>> +
>>>>> +  starfive,pdm-modulex:
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>> +    enum: [0, 1]
>>>>> +    description:
>>>>> +      The module x will be using in PDM controller. Default use module 0.
>>>>
>>>> This is an index of the block instance? If so, then it's not allowed.
>>>> Otherwise I don't understand the description.
>>>>
>>>
>>> No, this is just one instance. The PDM have two internal and independent
>> modules or called channels.
>>> They can be configured and used separately, and the user can choose which
>> channel to use.
>>>
>>
>> Do the modulex differ? Why different boards would choose one over another?
>>
> 
> They are same. The choice between them is base on the match with I2S.
> The DMA data channel of hardware between them is fixed linked:
> PDM module 0 --> I2S channel 0,
> PDM module 1 --> I2S channel 1
> I2S uses higher-number channels first for capture (like channel 1), so PDM should skips module 0 and uses module 1.
> Oh, I just thought of a way to fix them that change the priority of I2S channel to use lower-number channels first and PDM need not skip module0.
> 

Hm, then maybe this should be somehow linked with choice of I2C channel?
Do you have anywhere a link to complete DTS with sound card?

Best regards,
Krzysztof


