Return-Path: <linux-kernel+bounces-59076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0304984F0DB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6986A1F2441F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8A665BAC;
	Fri,  9 Feb 2024 07:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KRSi+4NC"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F045657D4
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 07:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707464056; cv=none; b=qRJtCZG18UwElDFYK2ITYxegNnm02OqScGqM+wEKSXOG5Xugb2Ebf6+f2MPyuhDf5xeaBFnaaICcHf7K5GqkxviIVDzxlQct617pruwmx3A4IEKZoGN4ddTI6gaulI//YSkQrO1sK5r6FYdsSkHlTFPPtadlA2AdwFWQwtZpe6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707464056; c=relaxed/simple;
	bh=l155yjqcn6mwLto3+BclXahtNP2bDt+8cJzfGcLLeTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JuLNGERF86LwGdfD7TvQx3oE7eOYBPsM8JDp9bfS8FW29h4jXi8GHrQKHzBadXqCV5O/w9xujOwj/fgqeW6W63iEKHCamJe/idR0EfM+8J78tlXXp1PPw+29dK1f1HC+SMLtS6h1dIDr6wQX76WUom2cEUyZvNE6fT1iDXB7Lb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KRSi+4NC; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51165a488baso792027e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 23:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707464052; x=1708068852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0eEUn01Mr6+gS4j+nxEfJxP9WuUPEMbjF6jYP5SWlvI=;
        b=KRSi+4NCYLQkpfagacytQAy8IKfQzMoraW3ebaxU5kxJP+WAWljejjBLs7Cn2lQenO
         aZbPrg729EGzbPN0NustKVk4tNnORlLVx8pZCOj+Ei7MyBWtQ2pq5wAphdFG9BUJn9Jc
         RmA+dX018dW4LGVb66U8bxbY5Vr8eOHmRBEMRP/JN7boFl0MDeeeR7B6DerLpRqND8x+
         Lhu/Q5TM/cGQU8etIJtzxR8BiS/m8ItsCtcaf+IWPb5YTTnMZ23Z305JTaCTYU7T0Sxj
         Wf7TizyfRtTlw45xUhXWNA2dTICcI1nHLfTx4mt+3kpuOKnCEavR/WO9zKIlCBEB3NyO
         o0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707464052; x=1708068852;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0eEUn01Mr6+gS4j+nxEfJxP9WuUPEMbjF6jYP5SWlvI=;
        b=ekNeedyywUhKJleDVr3h026hIeJ0+pzRF18QbxQA1trqTDEQnjnyJj+yZW0BCcaPT9
         PNDIVT1th3onuTUduKDTj/SSb2R11gOfsPS6FGu+6EOx/2LYWfgMZE8ocRwtauhj1597
         1FHNC8NSM7kWHJwPTyqfQnyPfQ3FNIIVcBlM5Vr0WLuJj2ZheThqx2Sg4azq7AItiTdO
         c8ywhwGmmXoASXQosmWPpgoYAlN1Zd/VTJhHZgeQqbytoda1bEIQy/XjMgpJ4xltayXe
         0kBOCQi2amhz7omeWgjKNHmzdc1/si8GpKfGJyrel+z4FZPdE6viNftrLHKd3dyqGleU
         mvoA==
X-Forwarded-Encrypted: i=1; AJvYcCVE/Depd9Vk989scaH2OiPhGRZMpIm5hvqOE3Hn1CkqL2HxquWOxnxzHyg/F6fP4jwQJiUh+FO/ZeKN4tkcgngus30tjIsRRJnnEZJn
X-Gm-Message-State: AOJu0YzfQxT3WfvlVpnfJFzBDh/SZcQ189KNoNAxlSDRfEj2OH1CU26u
	oMwpA+TQyOK3hPYUioOpa9uK4QiA7mX5p2RDQXP0ttx7btEnr84VvumeCFrD3cw=
X-Google-Smtp-Source: AGHT+IFV8/EETLzjTyITQd5j8C8fK8oZbjZICGMirfjRFUD8+VWA+cMyUmaJxkiXu37tYBIR9inn9w==
X-Received: by 2002:ac2:5551:0:b0:511:3c74:cd1c with SMTP id l17-20020ac25551000000b005113c74cd1cmr416936lfk.23.1707464052580;
        Thu, 08 Feb 2024 23:34:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUktLljRPqV5tGaS/sHJ0oHwk9Htds3BWZnRcc47UTzI4y/2uBviXBuJ3mHLJkOf+uOdAsSi9UmW4XYnpmQKOS7Y0HDsREbRjL57HPF1H0Sx0wJ9ev0apbcLnNPme4M7A3i79r6iN1lyQ2xHLlnPB+esyT3BQII09ry8V28s9cBuI5RpD7BLfPQg6v/vjUulCbwPUs7zr7uZfJcRcpIrfDgPkcZrrUW/Cg4F2vXsqu9x8QJSHInpDJySTueHUF5qPP583pJJxUF4JpmOJHllG0qQgc9RHVrwZ4CbfOfEexORlUOhsGl9r1wjuGxnULWbBERWoMJYyGbdPAUzdtFDmCfsOwdyYNpxUj0bOwF/rPp4h2bgsPYclVyQg5ywphSf3pun8N+K1DvG517DE7xRs6/b3On0enrhvdrr4C831zt98t8k+MURxXIl8ui/m4GvxI4dKjB1bLEr9M5mveuJtrARnHPACJqwIdqv/ghOplIESZfqnsHe1b+0g3EkDTgtZ1dLRpBqJncBZimc7S1roc6xmw2ow==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c154700b0041039d20454sm1664309wmg.41.2024.02.08.23.34.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 23:34:12 -0800 (PST)
Message-ID: <5089c549-505f-4342-b3fe-bed8a29b6ce1@linaro.org>
Date: Fri, 9 Feb 2024 08:34:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] dt-bindings: iio: light: Avago APDS9306
Content-Language: en-US
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Marek Vasut <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Matt Ranostay <matt@ranostay.sg>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240206130017.7839-1-subhajit.ghosh@tweaklogic.com>
 <20240206130017.7839-5-subhajit.ghosh@tweaklogic.com>
 <80e58f2f-b98b-46de-bcd4-fccbab11422a@linaro.org>
 <f7c18fca-2a85-46b2-a671-2409e662520f@tweaklogic.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <f7c18fca-2a85-46b2-a671-2409e662520f@tweaklogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/02/2024 11:51, Subhajit Ghosh wrote:
> Hi Krzysztof,
> 
> On 8/2/24 18:48, Krzysztof Kozlowski wrote:
>> On 06/02/2024 14:00, Subhajit Ghosh wrote:
>>> Driver support for Avago (Broadcom) APDS9306 Ambient Light Sensor.
>>> Extend avago,apds9300.yaml schema file to support apds9306 device.
>>>
>>> this patch depends on patch:
>>> "dt-bindings: iio: light: adps9300: Update interrupt definitions"
>>
>> Drop the paragraph, not helping. There is no dependency here.
> In the submitting patches guide, I read that if one patch depends
> on another, it should be mentioned.

On another patchset! Not on other patch within patchset. Anyway,
submitting patches don't tell to store it in Git forever because it does
not make sense.

Third, there is no dependency.

> If I try to apply this patch with "git am", it fails without
> first applying the patch dependency mentioned above. Is that fine?

It's just context.




Best regards,
Krzysztof


