Return-Path: <linux-kernel+bounces-118951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E02AB88C1CE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 100391C36139
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39AC76405;
	Tue, 26 Mar 2024 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rVIwGuZZ"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C547640B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711455258; cv=none; b=DBNI542C5YYqigTYgT203THyZmb5j4F2pom802liVDkpiH0leGt5gpMgrCPRb9cPVF9bhc2UiByEM39y5KQ4r4CfQKpUTaRkoyYXBjQ6SR891oDMHPCIzW07RrxFGuvYG8eXM4GvBtOcS0AaEGsIfjCOUyvwAfhcut9P7COqYm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711455258; c=relaxed/simple;
	bh=gKKUxmCVZjFEkwlPvcbsAq5Ff6I3CzB+4CfPRqco8w0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YF61zLkgGaLsHZ4Dom7v7yPoSmfAl4v8YZRZjTyyDYzuBF5p6O6ZOBB3oyM0PMLdsJtcizztPASB3ZL2qcP4q7H+lOaURqwFnuPfSQWXX+il5u/JMUUI6d6YQJh5eJn1cVOZE1lzRgh7bfyrRzVVWxRddG7d3zY9fAvLG84N2Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rVIwGuZZ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56890b533aaso6404694a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 05:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711455254; x=1712060054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n+xRraxP+bzgIPI3MdZw8Y3QkcTMlVCI6ec/G9jP36k=;
        b=rVIwGuZZRfYHLT5oDOJeys19zsYwY/unvvfd/lMwvLuk0mBODt4/vZ05HZl1gCv8O6
         jSpMdBymzu6/d/ZTRLnIygGc+/In38toANVtlWCzdzb3riLO5UzEAcu4vsh5StQlXfee
         Bne2f63NDfQB0H0pqA7BpLL0OkcP7f2pSfdf/PMUaaUeXjCAb0du1NL0VAIGX06Q6pnO
         44lFgFdPtCsoRvwoNDHfdlqt/5jzddipp2qHiDlTLV1oiaJK0hF2U6H2M9SLID/nxTAT
         O0yXcRPGCnBr0Ome76pwsBkHJIb+CR7hEWHxb+HVOsu1kurVXXxeUbiZdB/mOENvW4Sb
         qqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711455254; x=1712060054;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+xRraxP+bzgIPI3MdZw8Y3QkcTMlVCI6ec/G9jP36k=;
        b=fttEMYeJh9BORcFm5R61iDASNiYl55OYsbFTKC4YOMmx9tB8vA6230q/yX1O47NZRE
         aAAWi/OTO2DAzcJtUv37ImEp3mvQUVIbyoZuk49yCDEC1VGS6dVJzUO+05UTLnZ7FvwN
         8FHGoTMyNImyrTyllaj+v7pG8tsiPUwfSG+ZsqYCOMC/f3zEHTekmSurCOShUYK4n3yK
         FZXkXzHdxT0bLABKtavyRwVgQU3W4jO4IzG5/Y7QljNCqUcieDJMJPUeeR/FlszXhX6j
         0nCWaBqLpkOCb2mRKNzjlvpwJLCXtqgYj3+ROuuM/0Eb/IFjbY5B7dWSxkmSyOWZG0ML
         IqDw==
X-Forwarded-Encrypted: i=1; AJvYcCUL+kOQWHMiFDekJysfIBs903d0ru0W5oBF+45dPTR0CzSDCTT4tifwf3Gnvbq/7ryTZ3h6gaucHHi01Evg5/eCOXv690A6x6fOMdA0
X-Gm-Message-State: AOJu0Yy2QPDzoiHNMQNQyALofJa9ADqgEbiWAISwuFegLsrppgkHtjkt
	1hX4wX1I1BtgkEEG1eY0zVFKF4VU05i2QlgO2Sf2xJI7HSiT5q0AOqVuaNYZ+qo=
X-Google-Smtp-Source: AGHT+IH/MgInk+k3u49jHeevl2UiL4GVMPUggit2XjgmfeFWoEWXGOl904XBCuiLR4twfUC4QHm9oA==
X-Received: by 2002:a17:906:ad0:b0:a47:3b7b:e7a1 with SMTP id z16-20020a1709060ad000b00a473b7be7a1mr6054945ejf.49.1711455254479;
        Tue, 26 Mar 2024 05:14:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id i10-20020a170906264a00b00a46a27794f6sm4158924ejc.123.2024.03.26.05.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 05:14:13 -0700 (PDT)
Message-ID: <f7f6fcd8-5f49-4685-8488-9d51bb1210f5@linaro.org>
Date: Tue, 26 Mar 2024 13:14:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] dt-bindings: dmaengine: Add dmamux for
 CV18XX/SG200X series SoC
To: Inochi Amaoto <inochiama@outlook.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>,
 Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <IA1PR20MB4953B500D7451964EE37DA4CBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953E2937788D9D92C91ABBBBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <57398ee0-212c-4c82-bfed-bf38f4faa111@linaro.org>
 <IA1PR20MB4953EDEEFC3128741F8E152EBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <473528ac-dce2-41e3-a6d7-28f8c53a89ef@linaro.org>
 <IA1PR20MB4953517450F0E622A66E9A7DBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <cf42e020-9a5b-48bb-bc14-c0cc9498627b@linaro.org>
 <IA1PR20MB4953EA589A0FF36DC6FCF0E8BB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <1525c377-af73-4204-8a2b-983c6d99316c@linaro.org>
 <IA1PR20MB4953D3A70237A5395E61C170BB352@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <IA1PR20MB4953D3A70237A5395E61C170BB352@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2024 13:06, Inochi Amaoto wrote:
e.
>>>> +	regmap_set_bits(dmamux->regmap,
>>>> +			DMAMUX_CH_REG(chid),
>>>> +			DMAMUX_CH_SET(chid, devid));
>>>> +
>>>> +	regmap_update_bits(dmamux->regmap, CV1800_SDMA_DMA_INT_MUX,
>>>> +			   DMAMUX_INT_CH_MASK(chid, cpuid),
>>>> +			   DMAMUX_INT_CH_BIT(chid, cpuid));
>>>
>>> I think this is.
>>
>> So where exactly? I don't see any define being used here.
>> CV1800_SDMA_DMA_INT_MUX is not in your header. DMAMUX_ is not in your
>> header. So what are you pointing?
>>
>> I don't understand this communication. Are you mocking me here or what?
>> It's waste of my time.
>>
> 
> I apologize for my misunderstanding and your wasted time. I had 
> previously thought that hardware constants is also binding. This 
> leads to a weird communication between us. Since I agree and 
> understand this file is not a binding, I will remove this file in
> the next version. Anyway, thanks for your kindly explanation.

OK, no problem. When I asked where do you use header, it should make you
think... remove the #include from the driver and everything still
compiles, so obviously header is not being used.

Best regards,
Krzysztof


