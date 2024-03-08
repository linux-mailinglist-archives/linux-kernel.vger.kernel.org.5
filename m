Return-Path: <linux-kernel+bounces-96664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FFB875FAD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B193D28211D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5135C29CFB;
	Fri,  8 Mar 2024 08:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xxCXoDdo"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA09D20DD0
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 08:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887088; cv=none; b=FgQV46gqhAKRizL2wEBO6Eo9Boxu5JCR2SJTMKyxnesEkmc3kixHjOnPqyw4YMPkOb1vBSpRw47Y4LKXkuKXrYtUU/eyktiiWxpi80u3Wq37b1dJtIz2DaNZFA9hLWD1Er7OXiTZkhSWDcquUnOI2rdR2MIDj3AYT7ck5aZkrr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887088; c=relaxed/simple;
	bh=2DM2XFPeE7oub6IJBfxj18hAPcIc5fiHnb9Jd9/gPzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DulyMlCQBO8iwntXOz5E16pgseSnN1mzCXM0QN4Gq+vFQMzt0nZ+1Dl5oC/3ERfBQ07nJZnL+Q8nmoctQs+cPX78FERvXElsmzU4pN4fPlL2IOZ8kLS/fIjIXw6ioMWH4erkHWvrHi988GP9SmcVByyniCpO8BpTy2r279RuE4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xxCXoDdo; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so711603a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 00:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709887085; x=1710491885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i6vxHZPB4zpBzdUjhJMH4fzBC9Gurda3mQPwl1tLAhA=;
        b=xxCXoDdoPwz1VG5VxzLry6wiO5LR6dUoLUffNU71UocWVFDWUMu92GiewebvfelKEg
         ESKJu2SxvmeEtx2Vibe1bcmzqKSH2v5kONhIIhNAyDCGfwj+veYBLInxu4qCPZg0YTZg
         w7bmW8P4yJboQMsT/WOD3ELe6OMnxhuQkVGorUwwD9ZP95QPUbtDe5uy+7CTtZT1a8Ke
         gG9T6pua/z8wYrfT6tKOv2fgcXPaYaaCGH5YjHFr/yslbhmJo845FloKhoS9jcJgDrOa
         ZVGQYT6D0gKOZ/pZ1w66yx1559f00MACc8WofizeSFKnxvATifnaChCZ/DhGuZzjPlBH
         RX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709887085; x=1710491885;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i6vxHZPB4zpBzdUjhJMH4fzBC9Gurda3mQPwl1tLAhA=;
        b=dWIGhsTtz4e1CjjYy/PoXfMFjOCniM//VSspb7Tq7fC8cPjIxtruGr4p71DIbrmA1G
         z0s6kqmvLug7MWBejk8BuRfTz+1vQRdqcYIqSWloA2oW0UkeO99viQNnY2Na3//fLneK
         7aD5dFS1otwgJaS4kkBntaTK7FmVtxvRT+qtp2RrddryVqfpsnxvjqxkv008ZFK4YT+f
         8wo81C/e9U9c1in9wkIm+wiO3K1kBOaxdad9YiFv5O6n+HYrG2uwEYVLVihgE3hI+OXM
         uCwsh/9nIBd460dVf+I5dLm1aKAFH8hR95vAWPbASm7sb3TeTeaxac9biGmjo8NdmFcR
         WGrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXofdP982qe3/yDda8fchSoHViaj90ah3ueeC4klpYPZL3DM4V2vVsi9KlBEioDYTUbrUXWELTcgJ5x4QVpi6MDZNVj3UeypGpgjYBu
X-Gm-Message-State: AOJu0YwuptDeOCZ1aUyQ+KdlZvZIx4W4biH3Qk6wBXqJwIGgIv/UbvJJ
	MkXPJ6ewG72JP+sJsQshet+PEFBBDV1BYmadoeRCuZOr21CuIahcy/m4cq/KjdA=
X-Google-Smtp-Source: AGHT+IFnEWrB31qf578TWQF6oGx7/t8dJ4O+oen/PVMuoSr1+2xOIlyN/A9VSMYRlkoM20YMzaAR3g==
X-Received: by 2002:a50:d603:0:b0:566:2f24:b063 with SMTP id x3-20020a50d603000000b005662f24b063mr1506955edi.23.1709887085106;
        Fri, 08 Mar 2024 00:38:05 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id er15-20020a056402448f00b005681486cafesm1706407edb.0.2024.03.08.00.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 00:38:04 -0800 (PST)
Message-ID: <79b33edb-2474-461b-b848-6c526bd3bdbe@linaro.org>
Date: Fri, 8 Mar 2024 09:38:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH v7 04/11] dt-bindings: usb: ci-hdrc-usb2-imx:
 move imx parts to dedicated schema
Content-Language: en-US
To: Xu Yang <xu.yang_2@nxp.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>
Cc: "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
 "peter.chen@kernel.org" <peter.chen@kernel.org>, Jun Li <jun.li@nxp.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240228113004.918205-1-xu.yang_2@nxp.com>
 <20240228113004.918205-4-xu.yang_2@nxp.com>
 <1a626f74-4559-4403-9d88-6a9a462b54c1@linaro.org>
 <DU2PR04MB88227686B367CAA509EB8D7D8C272@DU2PR04MB8822.eurprd04.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <DU2PR04MB88227686B367CAA509EB8D7D8C272@DU2PR04MB8822.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/03/2024 09:30, Xu Yang wrote:
>>> +          - enum:
>>> +              - fsl,imx8mm-usb
>>> +              - fsl,imx8mn-usb
>>> +          - const: fsl,imx7d-usb
>>> +          - const: fsl,imx27-usb
>>> +      - items:
>>> +          - enum:
>>> +              - fsl,imx6sll-usb
>>> +              - fsl,imx7ulp-usb
>>> +          - const: fsl,imx6ul-usb
>>> +          - const: fsl,imx27-usb
>>> +
>>> +  clocks:
>>> +    minItems: 1
>>> +    maxItems: 3
>>
>>
>> No need to, it's already in common. Drop clocks.
> 
> No. I cannot remove clocks property in this yaml since the usb node may use assigned-clocks
> and assigned-clock-parents. Then dtschema will have warning like below patch:
> https://lore.kernel.org/all/20230508071837.68552-1-krzysztof.kozlowski@linaro.org/

This was a year ago, so please check if it is still the case. With
latest dtschema. If it is still the case, then indeed keep clocks here.

Best regards,
Krzysztof


