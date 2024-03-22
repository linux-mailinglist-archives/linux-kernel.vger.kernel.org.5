Return-Path: <linux-kernel+bounces-111039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEA0886739
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D131C2383F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF491118A;
	Fri, 22 Mar 2024 07:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ag7GBhke"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA2610A19
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 07:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711090920; cv=none; b=UeHP+BLvegM8V9Ix5yQiGOm+oqCLKldnuqR3pK5J8ng1kUtou4u+vXFMHEYrHNOrfSt2qfKu4wCoz1j7MEfXeH5+Rbiru7+LgNUjdw+nCeL+C7ufiJjUtfe3WRFR8vTDAoTexcqb0OxcREEpkCoe5A09oXNjihcZNSClu6BjS7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711090920; c=relaxed/simple;
	bh=DHdboDDtCJrSx2L+T/NGooFqHH+v5lVIsVRvPx5Adhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q1MghnNoOwPn6uVvf3vuFmvCzwSdUIL2L/+FJV8nAlTrQcNVzIbudErkUFdvfssKIRjw0czdJnvIAgjYqdg4vr6YAFcE9TPshryu7WtwcYob5JRvtYTX7qpm8MhgjmeqIEEw529lqUPL25GQpDF0RPuHy0bRBTi8fvosT8keZkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ag7GBhke; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-513d4559fb4so2243163e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 00:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711090916; x=1711695716; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xt5DFdAiqqJ4FjawcSekvhuik3FwaWDYhDwXluF4Ffg=;
        b=Ag7GBhkeDXUKGPXw39CuyfST5hiq3+5ixrYC/L562Dr+TG0MZySX6LJlFqESiuGVdi
         xWe56LHJ6XnKtTqwmydNjOtxPemVzxbL1PfHRPfuX0C+ZM1IiJ1Zy03yugDDj5cwhimH
         zL4TsAq/DQtExBnE/mPaPA6hcLHSoqjjrizNS26ypDx7sDbfvpiXzdvHiwKZgzp6TLjl
         a/XF67A6QwLrmoh7tTiWbshWsQQjsfTMIolyPeFfcUTy0bqcyn4nu+RGj+ts3rem0+b8
         +T3+RdN42NHea4xf8iiEy8LklteocRFV77nO4dLPgPsKdFWOSIi7Lb3gpe5pPMyzLMr+
         VLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711090916; x=1711695716;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xt5DFdAiqqJ4FjawcSekvhuik3FwaWDYhDwXluF4Ffg=;
        b=kjajf6thGPeDXAMcrkmGePC//igmWOqRumGyp+OcjaGJID4kyxAU0oeBENbicX1LH1
         TJkYUm9Kh5WhMGmYm5cz7bjQKb+IpN1Kk6S7SXCoAeOzg4HWATW2p1tVEfxxPCzvRnJ4
         94UIQYmunoxsAMWprGeFiYk7yd0611+Onp3M3dR6v5vlfQ0ZIKHc5TAFdn6ZGy4rnQdr
         0kGEI/UxRxsCEjqMjQzlGpOxJeqUg1WmqxVjbPCn4p8+RMvAn4VGF4RCZkU9WdnGSebE
         ox+Yg9GEa2MaMUvAeing33J0OzNToplcrB/fzbpFFicA0CR/IRx/IMJmJqblJ8l3rcpP
         fu2w==
X-Forwarded-Encrypted: i=1; AJvYcCWDh3SLboYlD7kSH0RH1K2LRgz5IMbZrcFRbMNJzJ9aEbSp4jfARxx3rSb2OWZyDR3G7o1jdfHMH9CPBQ3WIn7lSffP8IWsFtARoJgy
X-Gm-Message-State: AOJu0YzGCa/eQWOtsyyuDk5t/w+zXqAtC8gi+DgQVx65CrK1TAhaWYhg
	eBkd5mFoPXUD80Z1bNVKl+wAHJ1GQyw9j36S1Zx87QTG3DFh9CrLKzvBTD+cjWk=
X-Google-Smtp-Source: AGHT+IHUiCv4xvWMPJB41KX70x4Hwplv/qe8S//aNnLWfuL5FWjmxJX2k9NJMs5RCbDCV5aPgXVRyw==
X-Received: by 2002:ac2:4d9b:0:b0:515:99e9:712a with SMTP id g27-20020ac24d9b000000b0051599e9712amr781505lfe.19.1711090916398;
        Fri, 22 Mar 2024 00:01:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id cs11-20020a0564020c4b00b0056b0af78d80sm274270edb.34.2024.03.22.00.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 00:01:55 -0700 (PDT)
Message-ID: <024ca6eb-c3d8-4764-946e-1070d1bfb806@linaro.org>
Date: Fri, 22 Mar 2024 08:01:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: Remove fsl,t1023-sfp in favor of
 fsl,layerscape-sfp
To: Sean Anderson <sean.anderson@linux.dev>, Conor Dooley <conor@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Richard Alpe <richard@bit42.se>, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Michael Walle <michael@walle.cc>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <20240316002026.1808336-1-sean.anderson@linux.dev>
 <20240317-starved-pager-7a81c5045cfc@spud>
 <9daf9c8f-6606-4ff6-8065-6a32fa0d152c@linux.dev>
 <20240318-scarf-startup-64088b1d8d35@spud>
 <fa047914-da03-4234-b48f-eebdf350795e@linux.dev>
 <20240319-fondling-implode-322a9cb570b8@spud>
 <d947cb15-aafc-487e-8bbd-54d786683470@linux.dev>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <d947cb15-aafc-487e-8bbd-54d786683470@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/03/2024 17:21, Sean Anderson wrote:
> On 3/19/24 13:55, Conor Dooley wrote:
>> On Mon, Mar 18, 2024 at 11:48:06AM -0400, Sean Anderson wrote:
>>> On 3/18/24 11:40, Conor Dooley wrote:
>>>> On Mon, Mar 18, 2024 at 11:08:00AM -0400, Sean Anderson wrote:
>>>>> On 3/17/24 11:10, Conor Dooley wrote:
>>>>
>>>>>> Additionally, should
>>>>>> they fall back to t1023-sfp? I see that there's already some dts files
>>>>>> with these compatibles in them but seemingly no driver support as there
>>>>>> is for the t1023-sfp.
>>>>>
>>>>> I checked the reference manuals for these processors, and all of them use TA 2.0.
>>>>
>>>> Sounds like a fallback is suitable then, although that will require
>>>> updating the various dts files.
>>>
>>> Yes, a fallback (like what is done for the T-series) would be suitable,
>>> but given that these devicetrees have been in-tree for eight years I
>>> think it would be preferable to support the existing bindings for
>>> compatibility purposes.
>>
>> Just cos stuff snuck into the tree in dts files doesn't make it right
>> though, I'd rather the bindings were done correctly. I don't care if you
>> want to support all of the compatibles in the driver so that it works
>> with the existing devicetrees though, as long as you mention the
>> rationale in the commit message.
> 
> It doesn't really matter what the schema has as long as the driver supports
> existing device trees.

We do not talk about driver now but bindings. You add new compatibles on
a basis that they were already used. This cannot bypass regular review
comments, so if during regular review process we would require
fallbacks, then you are expected to listen to review also when
documenting existing compatibles. Otherwise everyone would prefer to
snuck in incorrect code and later document it "it was there!".

Best regards,
Krzysztof


