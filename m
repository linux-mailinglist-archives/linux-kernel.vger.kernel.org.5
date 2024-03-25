Return-Path: <linux-kernel+bounces-117826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A3F88B00F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497312E1457
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A471B977;
	Mon, 25 Mar 2024 19:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P0/U3Mde"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD721773A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711395295; cv=none; b=CEdgH4fErWlNwiaOYoOyRL72FJK+KMbn/eP2JHJcELmHJEYh2JK/syiqIUpBGotIBkvZqqv/L5sS7OEU1dDVu96OHodFZ2YeQBt46VNFksXC8S2lzSM6nGSFLXCSRw6P2l78nmhxKSk1U+DzNx3wjOo6thfHVjyabtzrb2hzgF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711395295; c=relaxed/simple;
	bh=TcaoZfkFDJ0SW2sazAPugT6iTiRkzmVSQnVaA2oU4AA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJgBz6JAzN9knafH/yjXQnNm0iICGSx6fxXMbRnuuSD1AZecw55GN+/Yua9JAG6XvxeZhcafPn4eZ6F0stbFhvoRjA8uz4eGD80J9Y9BFXqh5Xfm9M+UsfQdFECOMEART2yknZMrtUZLWgCAbuvtieu495WpzVhbg73s71F3eVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P0/U3Mde; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5159f9de7fbso2937643e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711395292; x=1712000092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x+gDb2N6PTSkcMItP5di4fY0wfhSgyZf/tI28W/p5zg=;
        b=P0/U3Mdea8BzRqcNVk64KVdpjTOdoekXqST34vArEjdbwDs9pGJgmLrDc1SxvJtG4S
         krWXwvz8QvNXgDjFm2FdmB40OD6fHAPjgZjU2MrYwS10HXM72+9mSaPQiu4bURdQYnDQ
         MLaPK6iMuObhA1EVCM/UwwUmbs25PwJNy4i2dOn5XryK/FYuIVP4ivGVdB8b3liKeWF8
         QjHxhzARWv8IIGLa+Tp9UPPuccmQ2OxKrnq6GMnTRokp+fzBL+yBw5XcBse81+0enAZO
         06+rLw99+9Dbvj+WT5VVEb1M8hGReqlTgD2napSleWEU4obs0H5FV99IimBx02iAq0s9
         zWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711395292; x=1712000092;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+gDb2N6PTSkcMItP5di4fY0wfhSgyZf/tI28W/p5zg=;
        b=NSxsMDd2tVwBYc6RvLF0TsOJUa/bkqbzcEJb0SwUsfWFLRJMXiZdOp2pPdg6dvfJp3
         O129w1poNDdI62tDMkEotpEf/9VPRIaXryf6mybPnfnuBj0/CWeau0wxmihHwSTthl6x
         +5PCzHocc2CyvK78l6Q8SzWaOzKXCZnvha9jlc4BmfMg8y4io5uPxiPutcp4Cmo0o344
         Rj3luPoBro77hxOOhfy4AsPqv7yXhNb9Pmq1yy3uijy2BmJWuRbR5Qbq3bNbnp3sNeNP
         ENd5g6HMlA/Rxt7fEctVt7b2SovncR6nBXJ5XKaUIqQfrPLbYPIHzA64FhRKTWYwmMMY
         8MZA==
X-Forwarded-Encrypted: i=1; AJvYcCWZQKmLuRnFpMl3fxXOch7w3QWg5SUC6HkJCLEh9MeQxW4rkRHkFmh+O2HX1B7MIA3GtjzxGDb+QtimYBCLXmuxOG+qsMSZzNVXpN6w
X-Gm-Message-State: AOJu0YxO1Zmp3OWQQpoZdhAnUBBgmdAlx5ofV6LFKhBoXf1c54+KONiZ
	Q3zdI2YdDSXmF+QccfDWhePDgHmEXA9MbrPUGW3fKjgpRiRPqI5Pk/Wk3DzM6xU=
X-Google-Smtp-Source: AGHT+IHbytwcxVQX8sINOS5f/VeuNB1cnyMyAow8UBiZjk6VQPWInASHXbA2UbZdykG4zG2sOY7wtg==
X-Received: by 2002:ac2:538c:0:b0:513:93dd:9ecd with SMTP id g12-20020ac2538c000000b0051393dd9ecdmr5427715lfh.21.1711395292242;
        Mon, 25 Mar 2024 12:34:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709063b0e00b00a473774b027sm3359364ejf.207.2024.03.25.12.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 12:34:51 -0700 (PDT)
Message-ID: <e1836cb6-64cd-4866-9c0a-f0dda096aa18@linaro.org>
Date: Mon, 25 Mar 2024 20:34:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: arm64: marvell: add solidrun cn9130
 clearfog boards
To: Josua Mayer <josua@solid-run.com>, Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240321-cn9130-som-v1-0-711127a409ae@solid-run.com>
 <20240321-cn9130-som-v1-1-711127a409ae@solid-run.com>
 <0f7ca0ed-a1c1-41d2-a1fa-27431d14c056@solid-run.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <0f7ca0ed-a1c1-41d2-a1fa-27431d14c056@solid-run.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/03/2024 11:08, Josua Mayer wrote:
> Am 21.03.24 um 22:47 schrieb Josua Mayer:
>> Add bindings for SolidRun Clearfog boards, using a new SoM based on
>> CN9130 SoC.
>> The carrier boards are identical to the older Armada 388 based Clearfog
>> boards. For consistency the carrier part of compatible strings are
>> copied, including the established "-a1" suffix.
>>
>> Signed-off-by: Josua Mayer <josua@solid-run.com>
>> ---
>>  .../devicetree/bindings/arm/marvell/armada-7k-8k.yaml        | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
>> index 16d2e132d3d1..36bdfd1bedd9 100644
>> --- a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
>> +++ b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
>> @@ -82,4 +82,16 @@ properties:
>>            - const: marvell,armada-ap807-quad
>>            - const: marvell,armada-ap807
>>  
>> +      - description:
>> +          SolidRun CN9130 clearfog family single-board computers
>> +        items:
>> +          - enum:
>> +              - solidrun,clearfog-base-a1
>> +              - solidrun,clearfog-pro-a1
>> +          - const: solidrun,clearfog-a1
>> +          - const: solidrun,cn9130-sr-som
>> +          - const: marvell,cn9130
>> +          - const: marvell,armada-ap807-quad
>> +          - const: marvell,armada-ap807
>> +
>>  additionalProperties: true
> 
> Before merging I would like some feedback about adding
> another product later, to ensure the compatibles above
> are adequate? In particular:
> - sequence of soc, cp, carrier compatibles
> - name of som compatible
> 
> Draft for future bindings:
>       - description:
>           SolidRun CN9130 SoM based single-board computers
>           with 1 external CP on the Carrier.
>         items:
>           - enum:
>               - solidrun,cn9131-solidwan
>           - const: marvell,cn9131
>           - const: solidrun,cn9130-sr-som

This does not look correct. cn9131 is not compatible with your som.

>           - const: marvell,cn9130

SoCs are compatible only in some cases, e.g. one is a subset of another
like stripped out of modem. Are you sure this is your case?


>           - const: marvell,armada-ap807-quad
>           - const: marvell,armada-ap807

Anyway, 6 compatibles is beyond useful amount. What are you expressing
here? Why is this even armada ap807?

Best regards,
Krzysztof


