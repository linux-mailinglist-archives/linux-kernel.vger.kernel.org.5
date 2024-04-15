Return-Path: <linux-kernel+bounces-145306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDB58A5266
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B75283908
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF321E896;
	Mon, 15 Apr 2024 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Vq1M0w/G"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8EC73189
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189324; cv=none; b=GJQ741sQSHBrDxLGEcrmLQ7K6TZsw9vpvMU/JwlO8yW+Z4vTG3+mChBRO123igR3gIoKo246Fw4FQzlGHqADGBZHkPslPY8s6EMSHZUj6pmbj82N1Op6dIah0mfzxb3R0z1KHupiM480xvATC8axg3Y0z5PXcxptMsa/JF4sXL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189324; c=relaxed/simple;
	bh=/KqtpQiX1Bts9vzHpMoMbXJoUvqDULdQ15ObKyQGkQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+85IMiLbfqTk+iWfeqptprI+m2bHqNwElV6oOohmV8ZrAq2/elnMdETc5RDWeNHL4Z0wE8fqJbiKh6NLD7Wt/Mrn5HrnLIDNk5fqaeAcRgBy0RW7UTVFOVFF7KAJSJiQzao/yE+Yf0opm0lPggwyn/FqKpfKW8F6Aqexl4CF3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Vq1M0w/G; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6eb55942409so2027319a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713189322; x=1713794122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FDybaBLDv2wiDu+VluN3PgOq81UE8XZcMt1MU2BUL6M=;
        b=Vq1M0w/GpnnE/tCK6gq04CvjneEpphicmA4ufDVVoOYQ0msR7w9nKFuXTlW6N9oyQB
         uRmXz7zMPt/NIHro5UNULn4pxYoPRAM8WYl01ZEPEBzSUSr5/Cy22/pseUBQ88OPz2SZ
         3/4EeOey5C7CANFfaeUe9HppRtQvRHMuXaYbTNrBfFp+IaRCVZvQNlQ3ZPeJQPXmgOi6
         5RiPxdiPalmZINvbrHqpkF+sq+G91KyRdAormX2Vg6o4VbeJBduUnO6tmNVJ7dH50bu9
         JkqUuNFqxusKVUc9lVf/v6AJRFPd3uU5ZNkIQWHUc9Md0x+sfy+ObSect1zCw0zZA7GI
         Ybdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713189322; x=1713794122;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDybaBLDv2wiDu+VluN3PgOq81UE8XZcMt1MU2BUL6M=;
        b=qOGE64Z4VB/0ItX6ce/+TM8Yb71eHhI07A5p0SgXUH+LDPp7lB840DRBFw/O4rBgya
         2qTtrvbpANiXyZscp8RLjIuT8lyn9Dd/sgM4dLKT0mryQIx0cfVwvllc6P3as8s2aONE
         O3qKRsLJv8sO8dxL2Z1yEYJPVFmy9PG/nE6i11zPqBsKfUf8HkJ71G+Gk9nyhuE7Trl9
         semEAcPGtdPpb3vlH1A0mA7IHQbyqhDmeqM9Jz0QKlpR9r7nXPgFUjtDbXgvGUvW5eiE
         AUnP3S1sfqUkFeOvOGvTobPNcohZ2URB+oxYmXoz16lc/ljlyaE0hmGJNGHvlEpUiuwg
         Dn3w==
X-Forwarded-Encrypted: i=1; AJvYcCV0/bdZlzx2EeYBKiaNbZ0Jh9MIOGvYp4haUsh4iHYza1FvVYE0vRJ8vhYiz1KL15ELUprdKOY1i6RN6iAsciINIu0iXgT5Rl2rI7ci
X-Gm-Message-State: AOJu0YzhpCFXfMLpfdfvESQPNJ6rTUR1wrrpKMdA+rNxlOAK0gdib8OG
	Q8X1HDykBUDYKTd1dYzn70yHQH5FBoyK3GFRe2pFi1R7ubG3kDXNpy19iu/Zz6M=
X-Google-Smtp-Source: AGHT+IFASyl13hC9uptACMxhhHeBMOBOY+sePtjxfpf//vvHEOFGYAvbdA85itseafAEj76cF6dB4Q==
X-Received: by 2002:a05:6830:1619:b0:6eb:7d34:e1d7 with SMTP id g25-20020a056830161900b006eb7d34e1d7mr3280527otr.15.1713189321521;
        Mon, 15 Apr 2024 06:55:21 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id h13-20020a9d600d000000b006ea23d8fcaasm1836074otj.32.2024.04.15.06.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 06:55:20 -0700 (PDT)
Message-ID: <c9c33784-d047-42d1-934e-d9e10cf47a65@baylibre.com>
Date: Mon, 15 Apr 2024 08:55:19 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] dt-bindings: iio: adc: ad7192: Add AD7194 support
To: Alisa-Dariana Roman <alisadariana@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 michael.hennerich@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alexandru.tachici@analog.com, lars@metafoo.de, jic23@kernel.org,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 lgirdwood@gmail.com, broonie@kernel.org, andy@kernel.org,
 nuno.sa@analog.com, marcelo.schmitt@analog.com, bigunclemax@gmail.com,
 okan.sahin@analog.com, fr0st61te@gmail.com, alisa.roman@analog.com,
 marcus.folkesson@gmail.com, schnelle@linux.ibm.com, liambeguin@gmail.com
References: <20240413151152.165682-1-alisa.roman@analog.com>
 <20240413151152.165682-5-alisa.roman@analog.com>
 <2ad06ea8-220f-4d09-bbe7-c4dd12d0d8bd@linaro.org>
 <105bd25b-e5ea-4649-b9b2-2547e94b103e@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <105bd25b-e5ea-4649-b9b2-2547e94b103e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/15/24 8:08 AM, Alisa-Dariana Roman wrote:
> On 14.04.2024 00:19, Krzysztof Kozlowski wrote:
>> On 13/04/2024 17:11, Alisa-Dariana Roman wrote:
>>> Unlike the other AD719Xs, AD7194 has configurable differential
>>> channels. The user can dynamically configure them in the devicetree.
>>>
>>> Also add an example for AD7194 devicetree.
>>>
>>> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
>>> ---
>>>   .../bindings/iio/adc/adi,ad7192.yaml          | 74 +++++++++++++++++++
>>>   1 file changed, 74 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
>>> index ba506af3b73e..855f0a2d7d75 100644
>>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
>>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> 
> ...
> 
>>
>>> +  "^channel@[0-9]+$":
>>
>> Why restricting the pattern? If you have 256 channels, how are you going
>> to encode it?
> 
> Hi Krzysztof,
> 
> Thank you for your feedback! I applied the rest, but as for this one isn't channel@1 -> channel@256 encoding sufficient?
> 
> Kind regards,
> Alisa-Dariana Roman
> 
> 

The number after @ is hexidecimal (without leading 0x), so it should be
[0-9a-f]. channel@0 to channel@ff.

