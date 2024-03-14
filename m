Return-Path: <linux-kernel+bounces-103519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BEE87C086
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0901C21500
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4637350D;
	Thu, 14 Mar 2024 15:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzVrGnt/"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0900371B3C;
	Thu, 14 Mar 2024 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710430764; cv=none; b=jnPPrpQncOAhLn135ujHW89c0r9lUAwiJBeIxWhjYfgezmGfYDgtapAteX9tPejP7GWvp90VoIoeJn2Y/qgAYDmeGFDn3lnB1sjn2OWS8QLYic3mJf7IwI0TL+n6jhVNK+Iq2p44cWusXEQvndvmtUPgOgbb0nn/DU5ZQ58/Ous=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710430764; c=relaxed/simple;
	bh=xCDgpHSzPYN7+5RfPDIivMyRKjRh1fwlgoWqlwjvqjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OsepYIpLY9DWv10YoCIRaJC6riw+47rfQDtSdxIOVp/5k/X16yIrnmzVqPZ9Kt7GO3MjGC8bfOWDifB4YiN1VMyMdL/l20YFUgSxVla3yKFHZORXcP7TrQwlm3Jqf5/2aX6joLhX+LPPuCi+liNrkxT2TS36HeonYmj1V9KXWT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzVrGnt/; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e6ca3fc613so952464b3a.3;
        Thu, 14 Mar 2024 08:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710430762; x=1711035562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=IckUjOzGVOoR8xI7X+V33fEjGofxi6Lw3ExKVi2nyOg=;
        b=WzVrGnt/clIsvA4KCD9k+otrzI6B+13ok813u/PUSyaPZyvysM8T2vy8lKEI8Voe/S
         JEaYDa3XRf+T3ixp2i+sUT3iHw724e3ap7/QVv86oHVPlCwJ6tLKi7DIwuEayKO5Uw1L
         Cn8mDoQCnRRQROUzBQIQTNIhK7hxGSJrTsECp1jwztYvhvohKPCTYBqhVxwRY+TMzrUa
         4yiMjxH6bIU40LtbzbMYjMzceA9f5ba7qMBHkwDwai/+pofLbFOUlnyZbVZRuaVYOtZn
         hz0zt3dHDtZ66EJ8Xv4fSaDSP4Dtrs7d8NicEQWDbnHNvGYHZ1pckN2uegZnjQzNALOi
         VlDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710430762; x=1711035562;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IckUjOzGVOoR8xI7X+V33fEjGofxi6Lw3ExKVi2nyOg=;
        b=ZSaFeQKvad5xuep+9UQrO9dnciwcrJfPjZVegEabIMhmsm4QWcA0UsYUybcpi/6bms
         i5hR5Ad/HmtPGgtc1YGpp2ZdOxJtad6ylNczZLz2SeQ4UanxpANWehzMkTvyAyrN5SrV
         AwTa619FiVom6lMdLDpa0XaRv5gBM7MLZAlbXgKjj98t8EbGrzqZ4IAjWti7YdWoNcRH
         FmYPCDVFmmMwUDvV3b+8z4kyhArEGst7llTXOllqghcoV1c+Sel5lwNXxGerSUxXASvF
         9rM2prgVZ2Y4a+5vRsMMWPQ4ydwc/O2w8KIaWVQxXnFnDv6SiSR3ArYB2cTT9O3m8H3E
         ViUw==
X-Forwarded-Encrypted: i=1; AJvYcCXMgBEFx1PHkECO4fQqWFqg6N6lbjwhjPg1o+cjRxQpYW8YnICGfpPxbYcmjDAb9Rfcnf6egnW14wwd5YPS1XNnCGvIqN59ZYVG8yB0Xv6+iyStswlOS2NDeRjT0VHnaQd57PH6LQAajO1Mm4u7pqGhVpqVfHwbE24hmVTDTQSj3Himwcnsb/QayfLbEbcIBm2wBBE7vqlAUcBTz8s=
X-Gm-Message-State: AOJu0Yw/+T6xpVIsgWDkGAqlFANmz9am+mxM+buwZ66hrwuDUiKuaDKl
	s/Tbo9h/Vdn3UDdfnon+hUsjKdFzO8+EYLn2y0h/vFgRqqOZ6Jf/
X-Google-Smtp-Source: AGHT+IG+cFMIJ0mwrAnNQeQ19dYICYv5jzaC6OD8PkldbqMNOwnoigR+C+nVKrxCtIdHGl6KSmULKQ==
X-Received: by 2002:a05:6a21:9998:b0:1a3:48c8:6858 with SMTP id ve24-20020a056a21999800b001a348c86858mr556664pzb.2.1710430762185;
        Thu, 14 Mar 2024 08:39:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fn15-20020a056a002fcf00b006e091a254adsm1620884pfb.30.2024.03.14.08.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 08:39:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <68c86ed9-e0db-4c90-be4c-8d1c5f102a51@roeck-us.net>
Date: Thu, 14 Mar 2024 08:39:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 07/27] net: wan: Add support for QMC HDLC
Content-Language: en-US
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Shengjiu Wang <shengjiu.wang@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Simon Horman <horms@kernel.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20231115144007.478111-1-herve.codina@bootlin.com>
 <20231115144007.478111-8-herve.codina@bootlin.com>
 <bd7b7714-1e73-444a-a175-675039d4f6e4@roeck-us.net>
 <42504939-e423-4128-bb86-a40e7b7ae845@csgroup.eu>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <42504939-e423-4128-bb86-a40e7b7ae845@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/14/24 08:31, Christophe Leroy wrote:
> 
> 
> Le 14/03/2024 à 16:21, Guenter Roeck a écrit :
>> On Wed, Nov 15, 2023 at 03:39:43PM +0100, Herve Codina wrote:
>>> The QMC HDLC driver provides support for HDLC using the QMC (QUICC
>>> Multichannel Controller) to transfer the HDLC data.
>>>
>>> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
>>> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>> Acked-by: Jakub Kicinski <kuba@kernel.org>
>>> ---
>> [ ... ]
>>
>>> +
>>> +static const struct of_device_id qmc_hdlc_id_table[] = {
>>> +	{ .compatible = "fsl,qmc-hdlc" },
>>> +	{} /* sentinel */
>>> +};
>>> +MODULE_DEVICE_TABLE(of, qmc_hdlc_driver);
>>
>> I am a bit puzzled. How does this even compile ?
> 
> Because
> 
> #else  /* !MODULE */
> #define MODULE_DEVICE_TABLE(type, name)
> #endif
> 

Ah, makes sense. We live and learn.

> 
> We should probably try to catch those errors when CONFIG_MODULE is not set.
> 
> By the way, a fix is available at
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20240314123346.461350-1-herve.codina@bootlin.com/
> 

Great, I'll add that to my testing branch for the time being.

Thanks!
Guenter


