Return-Path: <linux-kernel+bounces-108546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEED880C1C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0651C213D1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF429224F2;
	Wed, 20 Mar 2024 07:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vhTlB/8+"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6294D17C77
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 07:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710920017; cv=none; b=WoewsRMg0gn18ySrPbOys9fdy7XO6u8N89wJ+omBi7E2Tewa3mFt1aeM36nsrQ/fBKpvvYn6na29yAAPu9xecq47CQmG/WvI99CtsiDALmsIcA+qIgbrAlFqMn7dlHb/SBygnKlLuoGQ3cLPJOCMECjj0rJftfTiNo3QAK+Xs4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710920017; c=relaxed/simple;
	bh=wFioiaP7LDy+dT6NxFkl3CBgr9cdAkmr/LcVM46x67M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=skzH9F1c/6FjHXpgZNbKWOM+vVjYxMHg1twUc1wlWbUZyT3TlLcHGPKvLbD2T6ne9n1yTKwuNUilbIsGRBBJvNoxdmEfAra9Zf6be1q7N8HU3Xa+8NJmznm20lr0fAKTBg6HHfCKE2lbWCT3ypIXF3hxXVVsVTGSxape4nozIZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vhTlB/8+; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5684db9147dso8184893a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 00:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710920014; x=1711524814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p5deiIMhYCfrkmCItarATpsEyhZm2ffcwU7JWYPBd+k=;
        b=vhTlB/8+U/+n8Potx+xuoeIX5QAdNNNS7yvmZTjGfGQgZRO9RqLCI9r4xM9peC5eGJ
         KSK6rCKcHBwW2ui5dlMtWsNGKd7kIHlDv9wZvDruzVS+F/KIgtwWksFxGb/RkIa0P4pB
         y8THn5lqf92npOcjn2EERisk638qBxgM+jnCvFJEnvKjFSvSMugcRKz1ofsvSUOIZkl2
         SBJkxGYML1SGCXvPr0Q7JSsB0vSaAAB2V1sNihGkS1uCzUe/+CUySzR3G2zOlryLQmhX
         uwfqUtDNj6AMoqSBSE3fjtOymLKqTGpA1WN+ZljdQFLL8sVoMwzmFgF2otLAL8zaScKQ
         rXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710920014; x=1711524814;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5deiIMhYCfrkmCItarATpsEyhZm2ffcwU7JWYPBd+k=;
        b=R7D4zCQzEXTOMhS3hDVmJ/W+r4MUN4mTsb3dgT3We4dXAkRUV83+8eCjRfsjTj2Oxb
         jrmc1pHc6vea9Zf1hvTPBnMCZQ2pGu0y/wKplL1jcgS3BHx+Xtddfufvfr1jRNQ7lyP6
         XIcM+UR/YK2Zm1AGkWOoKNuBfhNPKCRpK0JLLzNYIxhAzLlISHH9MjQokouWd/SMZa4z
         1mQu8L3BuI2PRLn4TRhG4Quir8ph/PGzpy3XMXH1j9W7I2LcmmkMd48fwUProT8vigCk
         yhrs7bQXP7oEqiFRdhZ/pDHmZseghft5R8VhCp5d1boc6B5UEW5KfsWrHN1RXoZ99rtF
         Uz0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWksw80VF/c3xhrK4XFYZL3T88ml5QaM+r6kpJ7ueU6bjZePxXS60s8pCKKZuiJbALFJfyx/p1lEkcGMSee3hsBZCpDOFzukJvBeh0f
X-Gm-Message-State: AOJu0YyxQzWmRG0DSQgam3s2J+8xOyL7oMRjbEqHIfnyTX3lv3FKpGnp
	kgBx15ub5ggWmhTQLiplHhs0wN5nrz5RDtfQVuAY9jCzldMKjfJPUVgnN69qdto=
X-Google-Smtp-Source: AGHT+IG5PK316ydqUZrM+igAyTxLuf1UHhhNQNREpQwKusgWBDUQ5CKnQWx4fkq80uMKNNpToynGFQ==
X-Received: by 2002:a05:6402:1586:b0:567:de59:e93e with SMTP id ij6-20020a056402158600b00567de59e93emr10687215edb.25.1710920013695;
        Wed, 20 Mar 2024 00:33:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id u11-20020a056402110b00b00568d60cfbccsm3475110edv.42.2024.03.20.00.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 00:33:33 -0700 (PDT)
Message-ID: <9a029a22-93dc-452a-8746-e9b598d295cf@linaro.org>
Date: Wed, 20 Mar 2024 08:33:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] mikrobus: Add mikroBUS driver
To: Ayush Singh <ayushdevel1325@gmail.com>,
 open list <linux-kernel@vger.kernel.org>
Cc: jkridner@beagleboard.org, robertcnelson@beagleboard.org,
 lorforlinux@beagleboard.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vaishnav M A <vaishnav.a@ti.com>, Mark Brown <broonie@kernel.org>,
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/TEXAS INSTRUMENTS K3 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
 "moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
 Vaishnav M A <vaishnav@beagleboard.org>
References: <20240317193714.403132-1-ayushdevel1325@gmail.com>
 <20240317193714.403132-5-ayushdevel1325@gmail.com>
 <06009676-6189-40b9-a6d6-66a112e4f387@linaro.org>
 <89ec1649-5231-422e-9760-6e04b2a514fd@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <89ec1649-5231-422e-9760-6e04b2a514fd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2024 07:47, Ayush Singh wrote:
> On 3/19/24 11:34, Krzysztof Kozlowski wrote:
> 
>> On 17/03/2024 20:37, Ayush Singh wrote:
>>> DONOTMERGE
>>>
>>> this patch depends on Patch 1, 2, 3
>> So none of your work should be reviewed? I don't understand this, but in
>> such case I am not going to review it.
>>
>> Best regards,
>> Krzysztof
>>
> I am a bit lost here. It was mentioned in the patch v3 that I should 
> specify the interdependence of patches in v3. And now you are saying I 
> should not?
> 
> Here is the rationale for the dependence:
> 
> 1. Any changes to the property names in dt-bindings patch 1 will need an 
> appropriate change here.
> 
> 2. This patch will fail to build without patch 2.
> 
> 3. This patch will fail to build without patch 3.

This is a natural ordering of patches... but the point is that it makes
ZERO sense once applied to Git repo. Your commit *MUST* make sense in
the Git. Now it does not.

Explain in cover letter what is the merging strategy. You can also
mention in patch changelog (---) that one patch must be applied
toogether with another.

Best regards,
Krzysztof


