Return-Path: <linux-kernel+bounces-143700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 401768A3C66
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 13:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608C21C2166E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 11:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBA73DB91;
	Sat, 13 Apr 2024 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mUBxHPx5"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF7A376E2
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713006102; cv=none; b=u7J3tPkiPEb+UJUViKxRhS15/4NFadrQKgCMta5ADbSpVpzOPYRcbh6GrgV7JeWxQnU3jMK8n9ZVQ9NHCMUXq4J6VwcSNgYfwJf5X5soiSBytNyufct3acLZ2IfZFwNAqIeB9Uqy+Kbdm5UIVhF3lKFtgsteeDUsj2XtK8Ney3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713006102; c=relaxed/simple;
	bh=1JwtCwhi8iAE3mRKQLKMNkgmJmfQWWdXd/p2h7As/JY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BHsOttUqbCa71gEv+OIWg+YIH3RItW+wCB9aW9QKnVbjvJnIIuF0ybEn4UpvXj9THFjZWlJIriO2lxnUQ/qcAoVb5nBOuUQm8AB9imJJ9poVXthhO6r19qxHPjHrV+joITG8+SQB+vLhSjC5+9748drJYg1cPvF0BwZnDqhFOyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mUBxHPx5; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a523e1372b2so131447466b.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 04:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713006099; x=1713610899; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cXDU16Ou8ZyDMO2AM+8sVodEeRZtWf6krx3rzx7SIrM=;
        b=mUBxHPx5uFlOuRQjjHhKSDOZhQ/B77FQbikOUSzZDSO9ok1GIQFW8VsPaLTJy5Mj45
         GPyA8l+Q1lXwgfY6/JDZuUwBLdjdlxgIpukasPknzMycljIfJDc87BZPt3iVMAfIDKbx
         SZDtkvpDApdKbTZiFutJmQl06JVwKz84CxAvkTAH9ytr8PEH+v4HrqWce9J4aIekAa3e
         wVM9PdShEOaayoWdxBoJ6YwiQKXAQEfvEHFY+fMYId3RDNIPZGwfEiQ1vz/J9CIIToAK
         9Yh+tRRLlZaFqMUXbaQRCMCj1DbO9s4pmQykfeWtu63q4oEcKozc6SfCCtdb/gNUw2gg
         eaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713006099; x=1713610899;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXDU16Ou8ZyDMO2AM+8sVodEeRZtWf6krx3rzx7SIrM=;
        b=an7kBO2tiFbD9S1D5sl+MGrydqbuWDWO0B2MOZSsNvj/cPQRBgereOhpgrY4+90+4a
         9WQ/bRG77jbBgLlNKMukXaFtRySoyPCzGk0WgoJI0yiItUmi/ZF1CVAF4pyjil0HmRhe
         xDUCnNyHMpioYzCi6LMSPKr/I4pZRhpxcDoOLJ5LDD9lkVsWQD7ZbAmbSu+yoFiO54Dk
         fAPLE4zsKf01G1Qm/Wru8V2PEmg3XrxgURFCUq8BprK2ZGV3oXoId7M7wnSeDhpiLM81
         K5EINf714LScPzv+/BoKAAUwdPwGH0czGvyhRckPAHl4UpdlV7Zb0jqEsBzd3SyWUXwQ
         XkCA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ9lCbWBRBrrldXi1pWeIes5DiQHLARya4Sc2wjLCpXCfVPseoh2MpT5cCKnaNDvnmQqNDDPNk7imlf4FcRb2zxdoeoOqdl31v5X1a
X-Gm-Message-State: AOJu0Yz8BMCBFd3OECDIchT7M/4WdBb9Vhb//lsFGSApGkqO3ZBcdtjH
	X7koXyVagUj0rE6jd+HrzOnNzSI7SQF2oYgLqV493f1tJTj5XUr+Jx8YVqZYiOQ=
X-Google-Smtp-Source: AGHT+IEqqYA/tIZOlLrM4zVw+nGExQNL1qTKcKaxQR0VGl33NI6olV/6zQW40Rg1NOHSFhmZGqIOAg==
X-Received: by 2002:a17:906:507:b0:a52:3d5e:a81 with SMTP id j7-20020a170906050700b00a523d5e0a81mr2035696eja.43.1713006098854;
        Sat, 13 Apr 2024 04:01:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id bv13-20020a170906b1cd00b00a51a9d87570sm2904606ejb.17.2024.04.13.04.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 04:01:38 -0700 (PDT)
Message-ID: <548b7a66-9a56-4971-89eb-1a147d658f0f@linaro.org>
Date: Sat, 13 Apr 2024 13:01:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: tpm: Add st,st33ktpm2xi2c to TCG TIS
 binding
To: Lukas Wunner <lukas@wunner.de>
Cc: "M. Haener" <michael.haener@siemens.com>,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>
References: <20240413071621.12509-1-michael.haener@siemens.com>
 <20240413071621.12509-3-michael.haener@siemens.com>
 <8c13a349-a721-44d3-9e23-2e01f4c2ca4d@linaro.org>
 <Zhpb2URMxuoilKAZ@wunner.de>
 <3d08cf54-f58f-446f-977e-21ba65986924@linaro.org>
 <ZhpfwaIUc0HpfZP1@wunner.de>
 <889ca65c-c9c7-4658-9c34-5d89774218cc@linaro.org>
 <ZhpjozjbeWrb0OTl@wunner.de>
 <bbe365cd-698e-4507-b5e6-d7dd4dcc7a75@linaro.org>
 <ZhpkzWhOdW3OaJfn@wunner.de>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZhpkzWhOdW3OaJfn@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/04/2024 12:56, Lukas Wunner wrote:
> On Sat, Apr 13, 2024 at 12:53:25PM +0200, Krzysztof Kozlowski wrote:
>> On 13/04/2024 12:51, Lukas Wunner wrote:
>>> The binding requires two entries in the compatible string used in the DT,
>>> the chip name followed by the generic string:
>>>
>>>         items:
>>>           - enum:
>>>               - infineon,slb9673
>>>               - nuvoton,npct75x
>>>           - const: tcg,tpm-tis-i2c
>>>
>>> This allows us to deal with device-specific quirks, should they pop up
>>> (e.g. special timing requirements, hardware bugs).  We don't know in
>>> advance if they will be discovered, but if they are, it's cumbersome
>>> to determine after the fact which products (and thus DTs) are affected.
>>> So having the name of the actual chip used on the board has value.
>>
>> So you say devices are compatible. Then the second patch is wrong.
>>
>> I cannot respond to it, though... so NAK-here-for-second-patch.
> 
> I disagree.  It's ugly to have inconsistencies between the DT bindings
> and the driver.  So I think patch [1/2] in this series is fine.

You are mixing different things. This patchset creates inconsistency.
You even refer here to bindings while we discuss the driver...

Why this one driver is different than all other Linux drivers? Why do
you keep pushing here entirely different behavior?

The devices are compatible, so growing match table is both redundant and
confusing. That's everywhere. TPM is not different.

Best regards,
Krzysztof


