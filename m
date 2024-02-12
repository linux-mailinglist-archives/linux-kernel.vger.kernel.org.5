Return-Path: <linux-kernel+bounces-61715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 594168515B0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2F84B28ECC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB2F41236;
	Mon, 12 Feb 2024 13:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OoBF05pR"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7D63AC1A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745114; cv=none; b=pPbb/JSmnQpE/AhkWOf9hwnBCOv4Dl3Mb8Tbocb3eGUXdkdIuFsrGSW9aeIst686hZddnsLHUrrxouerBeSv9hauS1cMWFrSG4MQvtvP0xOgeOomZGMm05va091ksCoUlCe54BGFbggWNDacN8srhYIOs5D9Z6CI61kUZVDVVvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745114; c=relaxed/simple;
	bh=rpYBhk/j66DzDV7bNRB5U+65POh6Vdzj3V9ZWf2Nqbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TGruHxGdZ324Ld9SV8Wb/hozGyPuNGvUdy6f5Q+oVwsAWLdvPYkysqQNO2bVz6G1D+RYZjBhCFDVIH2hrZ5eSvid/i0a0gx3NyRLWxYfDHr09rqnhfpKgr9uO5EWdf02wtUxkToVH3WwXVKtP4Q+M63tlXzjOaCOdqziWc0kScg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OoBF05pR; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-411a5a8653aso1265275e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707745110; x=1708349910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rmPpV0dbXNGFsKuaAh8muDLcTwV0TSgvzQsRILaROZ4=;
        b=OoBF05pRReKMw+1txUf5Qj51pOre7hll+/dr2mixydTdN/jLQw8/SZpPr8pqJQMFZz
         rC8EphFCOVn3pgkY5SKVtaZRKEtZRP3BsHIIfl23g4qXZb5/DAcThro7emMyt+9dE1tI
         l09lDYb3YrowWgtFmf7/GknB1uzc5hdTxC1uZf+HFEZXkeIqUZLzTOEKu07npQJN9Gvv
         ycJIWDcRBU0BRvrXYTmZXtTf0/grqXzOrze5MYQX3pQz6SH5wSzVGcDrgR4GIh5xeKMl
         DrKyGBRuqRSKDik33jRggsKxznp9GSO+FuN2ITzXTz4+FJaV0OPgU1bOYRPFZEBshxLi
         ZEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707745110; x=1708349910;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rmPpV0dbXNGFsKuaAh8muDLcTwV0TSgvzQsRILaROZ4=;
        b=Q79vP8kk1RYeji/ktv2ZW1gRQ+FvfzSNrcnvfcj3y1+hJEjeWoQAzpYdP25NrghVXZ
         /CrlERiafZvjqlzsg7H0vj6VjoUBO3S03JUNQKn9DOjz1GJF/R6EMF3dlQPCsU0rwQ/e
         4hztokMNUfFmA52Im3sMPwv8TsmNkjm3Q9ZH6hwv9+2c5P6nsItoJiaKUQ7bEjyefWkG
         HaQp80dobvMsD1nLFt7bQKSPclYnk2yMkSNP/QQHU36kEi9rkdCwxnjtgcPqxZERl3Bc
         WFIW/TlZqLntkyfWYoOreYYKn6Cu7laBc5h3C8JvpJ/QZAzFjAHE3FCXvRwMfYrGTVJc
         r4kg==
X-Forwarded-Encrypted: i=1; AJvYcCU7NaNAC9dAJrSOWsds8y6pkjSqU7WTvUnubDW0rJzoGXvkRD00bQ6xHK/oyPxFBkOWOiT91PljS1ptxVZVOWdfZKAzGUjX1DgH9MJ+
X-Gm-Message-State: AOJu0YyaVEVxjP+UP9d8tKg3AK3Z2Chkcy8CEi3icr/xOtPrVY5m7n58
	YOkQkGE6JKif2l9w6Xkgl8zOhs6AbNFHfwTptOl74mCd9Pkxgfjdolh3DfesFN8=
X-Google-Smtp-Source: AGHT+IGcjwLg1xyizj1mAIEHP94GkcjepOz9jSGdnZTTv8G4JTLFbNblW61xBR4/tdl9r4KYrH3t2Q==
X-Received: by 2002:a05:600c:350a:b0:410:8092:99f7 with SMTP id h10-20020a05600c350a00b00410809299f7mr6159341wmq.31.1707745110558;
        Mon, 12 Feb 2024 05:38:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXx+zZowfI9I7avrYd5tsLA54oTPN1aYREHpcit86Z2ZEFsEZp2555uDzCC46fw54qjqRCgbdzrVnltRwO2v2chYOCtITKJzUKnIeSfyNNN+kErmIdSFC8aDDtzcDIz3tYUjDz6bM/mbAiae7kY6ZUe+WJ4yYXR21hpJGMjQcDK9TP7tA4podBRzPgLuB1tIi0+XVTPKxYRvpQv18uTcLcbUO/PE6jMVMO140n+K5IncjAg1wg9YXkp3xRxkRPUKKne830d6orJ4YDsI/hyVejxD5XefkTAd1FurPyFlUhvng3wuWSj2yzueoMDvOq2pLqTqwcTYazwVKKUaTCNJuD2NB5qp/3gTDpkWCh/zs1R/oVoa6bZIaBnAA0JB0xD9oC1c2jhIG15kAP3rGVW/7ZytdT/KnSbWYUtrlPyk+xWPWBubx3kIrLS8V9ZV/72i5RtGD4=
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id az23-20020a05600c601700b00410dd87bf33sm2494684wmb.7.2024.02.12.05.38.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 05:38:29 -0800 (PST)
Message-ID: <e2a5b005-7916-4296-b072-c24efd4b3357@linaro.org>
Date: Mon, 12 Feb 2024 14:38:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: auxdisplay: hit, hd44780: drop redundant
 GPIO node
Content-Language: en-US
To: Ralf Schlatterbeck <rsc@runtux.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Linus Walleij <linus.walleij@linaro.org>, Miguel Ojeda <ojeda@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Robin van der Gracht
 <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20240212083426.26757-1-krzysztof.kozlowski@linaro.org>
 <CAMuHMdU-c5_Z2AMNtNH4Cc4JUrn+oKU-1CumEOAP6=5Zomcj_A@mail.gmail.com>
 <2922eece-5486-4eff-af99-f7060cb61d17@linaro.org>
 <20240212115837.efz73yxinkysdmgh@runtux.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240212115837.efz73yxinkysdmgh@runtux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/02/2024 12:58, Ralf Schlatterbeck wrote:
> On Mon, Feb 12, 2024 at 12:25:48PM +0100, Krzysztof Kozlowski wrote:
>>
>> Hm, I don't understand how exactly it helps. The GPIO expander has its
>> own example and as you pointed below, this is basically the same code,
>> except rw and backlight GPIOs.
> 
> The hd44780 is a display that is very often used.
> By people (like me some time ago) not familiar with the nice io expander
> implementation in Linux. The consequence of that is that you'll find
> several out-of-tree implementations for this display with i2c out in the
> wild. So my thought of documenting this (again) at that location is to
> make it easier for people with a hd44780 with the standard i2c interface
> to see how it is done in Linux.

GPIO expanders and their usage is nothing specific to this device -
other devices also might benefit of them. Or the SoCs which have enough
of GPIOs... I really do not understand why do we need expander here and
how does it help

Anyway, binding examples should not be collection of unrelated
solutions, because then we should accept for each device schema several
other variations and combinations.

Best regards,
Krzysztof


