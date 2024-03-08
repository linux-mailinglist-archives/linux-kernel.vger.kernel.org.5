Return-Path: <linux-kernel+bounces-96631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D68ED875F21
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 057491C2212E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B312951036;
	Fri,  8 Mar 2024 08:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e9XJY2rx"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B40E4F1FB
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 08:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709885405; cv=none; b=SR1SXiRYmfO6m+abw9BF+yezeSYPSMVS6Djh7ofPwJaog7wUAM4UOkiUdjBVSH9A91XV2Onc+mLUKB8yV1JgYO0eH2g6wBG4tKPkbxaTHcbD3+n+8NvIPv6cyvRebMOPRumUryp15eSWLsfY3sjjuRN/ke6+b6oI5jLg4VXCppg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709885405; c=relaxed/simple;
	bh=9mjnKLHYyXFjuLf5DtKrapUwViHfXrN+glwIBsdYD5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aidhLE1YmJ0mmRtPaHvNTl5XBhTfqqZP1qj7AqxaJwEhaKG6cNlYyMauviQ4z0dtTBNzKu5Yl9aHw2Wm3OI4xoGW7soE5bngIDLDxDnrpfh9uF3Kd/aXT61xP/8rtL55B2kNezgQJgCeo+b8H7V9J2qxGsyDUOSJo61VX4MIeh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e9XJY2rx; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a458eb7db13so260197766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 00:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709885402; x=1710490202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ieOl+nO/4ShX81O2rZIqhD66gRry0XDM/crFPDhd5iQ=;
        b=e9XJY2rxgY065NteYVIGSc5QToWf0IzOZSE2rF/ppxlk+U5rMhOsUjgQRsYb+xl9F8
         U6yZV1B7qut7daLqQWeCG07+LiF1w7QbWXFFcXnzKG7eMFnvrA6DZ8nUFWUMEz+OQ3WM
         zmVUnS/RGKcOSfK8Qmn7QHSEPZo5M47IHdi2O+KKKC01F4i7bP2vMgwy3Mn1H+YHjf//
         s4GwnBFei0Dgx+rxhkoiv81UCCRjnihfSNY+aAjUlqq1y0BmS/uOZGRmgzdzKehCGdQh
         NsM5Wf2swt52TxaCQw3e3vPRsg6CHEWtV24ugSc3pJN3TDtusJ85uKty2KJWXkulZ5P7
         t0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709885402; x=1710490202;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ieOl+nO/4ShX81O2rZIqhD66gRry0XDM/crFPDhd5iQ=;
        b=kUnvhw/ZJBO+u3JAYGe7KzRFJO4hcb0O2SAPuBN4OMzRALWCPVhH1A7GMDbUwY2E+u
         x1EXq5XKwR+FcIuhHZx4cDCJGLaS7PpmvlRX1FZkiNDOrmvJUFUX0EAoBH6qYwn5XBDt
         0gnbcxVn4wusQK8yiPE38bvqTjJNv5s2WBbSI3ZTW9742yqrLQjUF9HQ1iLFDB4HqjQP
         zVd8lZUdSR+09OI5zC64X73vRxOEQKyJkpAFtCmXFN7ZVy2+0pKzAOZr5nEVRaB16yAg
         TfblshYmUfbeegXTWtaVGqW2X2rwFyBCs+wBu9o0ISMXBKcrjUFS988mrvl027dvj/C5
         cyUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLBzmLpbAIR52yfiRuEXvOVirrhmjH326QrrIXWEqdLmItOOxHDke+72Ww61MOiK6X2SmxWEZhpb1uxsbBeftOFXxJxVutxKGr00rq
X-Gm-Message-State: AOJu0Yy0MZWPsRC/oT/03Z92/vJmewI8Nu97vdajXeZ9swMTRFvea1UI
	cjMPktO9PepPA63XnOKNz5sYptfq0ccP7YOyQwR+EtQyqPJ+VZzla0pXRwfE49M=
X-Google-Smtp-Source: AGHT+IHGpXto4nWrzNuAL5hJWGeHiaklD7rmRsAzuU9U2d7GJmxIazfEPKA//Y/bvWhAr6PmbwdAUQ==
X-Received: by 2002:a17:907:d301:b0:a45:f4d9:d911 with SMTP id vg1-20020a170907d30100b00a45f4d9d911mr191393ejc.34.1709885402548;
        Fri, 08 Mar 2024 00:10:02 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id wk15-20020a170907054f00b00a4519304f8bsm6090542ejb.14.2024.03.08.00.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 00:10:02 -0800 (PST)
Message-ID: <1cdbe5b8-ed3a-46a6-bc73-6bf35e3305f2@linaro.org>
Date: Fri, 8 Mar 2024 09:09:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 8/9] net: hisi_femac: add support for
 hisi_femac core on Hi3798MV200
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
References: <20240307-net-v9-0-6e0cf3e6584d@outlook.com>
 <20240307-net-v9-8-6e0cf3e6584d@outlook.com>
 <37ebeeca-e53b-445b-9fa7-53a1b7a4dcd3@linaro.org>
 <SEZPR06MB695921BD3235F62E5D37E61F96272@SEZPR06MB6959.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <SEZPR06MB695921BD3235F62E5D37E61F96272@SEZPR06MB6959.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/03/2024 09:07, Yang Xiwen wrote:
> On 3/8/2024 4:02 PM, Krzysztof Kozlowski wrote:
>> On 07/03/2024 12:34, Yang Xiwen via B4 Relay wrote:
>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>
>>> Register the sub MDIO bus if it is found. Also implement the internal
>>> PHY reset procedure as needed.
>> ...
>>
>>>   
>>> @@ -946,6 +991,7 @@ static int hisi_femac_drv_resume(struct platform_device *pdev)
>>>   
>>>   static const struct of_device_id hisi_femac_match[] = {
>>>   	{.compatible = "hisilicon,hi3516cv300-femac",},
>>> +	{.compatible = "hisilicon,hi3798mv200-femac",},
>>
>> Why do you keep growing this table?
> 
> 
> I'm completely confused. Don't I need to keep binding and driver 
> compatible ids sync?
> 
> 
> The FEMAC cores on 2 SoCs are compatible afaik. That's why i want to add 
> a generic "hisilicon,hisi-femac" compatible. Though i know nothing about 
> the mysterious version numbers (v1, v2 etc..) documented in the old 
> binding, so i want them to be removed. Instead only keep one generic 
> fallback compatible.
> 
> 
> Do you mean that i broke the backward compatibility for 
> "hisilicon,hi3516cv300-femac"?

No. I meant, use one as fallback and only fallback needs to be in the
device ID table. There are dozens if not hundreds of such examples in
the tree.

Best regards,
Krzysztof


