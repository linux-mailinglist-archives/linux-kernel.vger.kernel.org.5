Return-Path: <linux-kernel+bounces-140020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EE08A0A6D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8451F221FA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0268213E888;
	Thu, 11 Apr 2024 07:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IEbRw7Ps"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799AB13E049
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821623; cv=none; b=OOCJ2zV6EEJIXvvOyu/Hq08CgXH1ya9LvgKqG+uddJuL2SEPV2YzaxAyOXSfYG2Edndu6dLqTzSykR2fPW6YwSEzJhW+IK6CtH6B1ROL+em8Hwqlu6w3twb/FF55gk6oNKotnftYLN2zA+8zjVmFMLiK9rMbr7SDdRDE+51Cdwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821623; c=relaxed/simple;
	bh=EZbpZVzDol2ochxhhoQafG44mGv61bdI5h13F/TClzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MLg9CNRd8hkyZw9bKfN8wlaZAgc4341EgtRpqnrF9IT4vREZyp+v4HN5IxQUA0hCq0WTwupQvqQJffINM2tmdiwhibPrIQxMPrgEbM7EpWWR4FVS2L0gZE2mPm4JgJxE8w9aTCVN1wS4ge+rzaiNqTDGX6qy2Qxgvbp42w+GnB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IEbRw7Ps; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-343bccc0b2cso5354932f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712821620; x=1713426420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yzFgY9cLt511CDM/+jSri25GZnUmXDOO2qPwZ1Xf87s=;
        b=IEbRw7Ps3uKDPiJEnHl9ZNPezNl7DEKgj6CWzGqrMGZuo1PM9JEzQ2rEs1exInufyS
         jcah2PJdpxuXnWHOOi7NRaabI9c5RUV7eggvfhi8anvxf+0rypWRSln1/z6kRfYq3MQ+
         CKjjY0FjmGevZC8m/sAKZRO6J0zHQlGckeYLUwoJGqmR/tLZHROYx2yLVTxzGlEyQYfd
         Oygtw3cuP3/mtUnHJA6xMCDjCuY8Nqv2lPiFhnV4q6EJyxmV8kNKd7/tB9EoUvKiFtgW
         8iM4/X3r0/tM0lhWkeqDhkUWwwbPxi3DjI14ygoDN82ydo1jTsUHuziILCKqR7ksQq8z
         gOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712821620; x=1713426420;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yzFgY9cLt511CDM/+jSri25GZnUmXDOO2qPwZ1Xf87s=;
        b=k1jxeaoxXhgHVYpTbIwwqzbIV9qiR38HcJyJahZUxIIi/BVuO8n1schKsuH2jCXosP
         bA7wiBnYH/N1z/syb86bjqdz4xLltQ0MC+2IUYHbt8T1/9CqPa0jp8jJbSjyue3s6Dc4
         7xwDAu7wV3+ufX1aDY3dSbWJHmxo+7NH4IXSnHzrRsdArMvEVMpKt6QTis7iW2OZQS26
         xZGBjjz709dDqWGe3spO9GDZJAKU+SD7qXOdzkMWGc7sLkQQ6MMt9Xl3qavK5TWOOyEc
         dbO/Tu70VogUDT/rZi3jbJgi6tHAxoFc9jKs367xSdMlMq9kAHqOu9Lp/1o5UeGxHzj3
         gkMA==
X-Forwarded-Encrypted: i=1; AJvYcCU2Rezime5bUlMFQbcs1vNre6n+KoMLHHqjXQI+cRhBN8ZVKp6Zq6bqQd8yAk5ryWtAjVKULN2cVNHvl5m1x7GHOsVg1RNlGz2P9dDN
X-Gm-Message-State: AOJu0Yy7+UrAPM2kHs9V1eMX228sOOb901HhBr5KXK4B6dkmrkpdcF9T
	AlBOGMUBESME70WGXS6HbfDadYz+8ADeqtzM0hRLzhPPJxS+foz1evzLlJl5PNY=
X-Google-Smtp-Source: AGHT+IHN/1LW8cTEnJPn0noxnO3sVJdRgmSbkmIRqc9hO3tczHztPyZsmfT2drvV2a7Y8LezMCNm/Q==
X-Received: by 2002:adf:fece:0:b0:345:223:2dd8 with SMTP id q14-20020adffece000000b0034502232dd8mr2833997wrs.23.1712821619774;
        Thu, 11 Apr 2024 00:46:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id b13-20020a5d4d8d000000b003432d61d6b7sm1121448wru.51.2024.04.11.00.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 00:46:59 -0700 (PDT)
Message-ID: <3249d5dd-bbce-4dfb-b3b0-11f180602714@linaro.org>
Date: Thu, 11 Apr 2024 09:46:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] Remove the empty lines from sama5 and sama7 DT
 files
To: Mihai Sain <mihai.sain@microchip.com>, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240411073353.3831-1-mihai.sain@microchip.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240411073353.3831-1-mihai.sain@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/04/2024 09:33, Mihai Sain wrote:
> This patch series removes the empty lines from sama5 and sama7 DT files.
> 
> Mihai Sain (13):
>   ARM: dts: microchip: sama7g5ek: Remove the empty line 50
>   ARM: dts: microchip: sama7g5: Remove the empty line 139
>   ARM: dts: microchip: sama5d2: Remove the empty lines 47 and 63
>   ARM: dts: microchip: sama5d27_som1_ek: Remove the empty lines
>   ARM: dts: microchip: sama5d27_wlsom1_ek: Remove the empty line 31
>   ARM: dts: microchip: sama5d29_curiosity: Remove the empty line 48
>   ARM: dts: microchip: sama5d2_icp: Remove the empty line 47
>   ARM: dts: microchip: sama5d2_ptc_ek: Remove the empty line 401
>   ARM: dts: microchip: sama5d2_xplained: Remove the empty line 710
>   ARM: dts: microchip: sama5d3_eds: Remove the empty line 24
>   ARM: dts: microchip: sama5d3_xplained: Remove the empty line 377
>   ARM: dts: microchip: sama5d4_xplained: Remove the empty line 247
>   ARM: dts: microchip: sama5d4ek: Remove the empty line 274

NAK for entire patchset.

Best regards,
Krzysztof


