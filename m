Return-Path: <linux-kernel+bounces-153314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 007608ACC5E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83CCA1F247E5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A62146D44;
	Mon, 22 Apr 2024 11:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xE4YAHnw"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F0D146A6A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 11:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713786991; cv=none; b=fbD38zMlAJtd7WL6MlDUezsPYOpmKVaS2dTuk3xUiO43nod473K6tQffV78nHnrxcA8pdLkph1B+GNVzlxxlEfJ246MPthvIBLdNj9WRJcjdIA5jL8AfypxFnznrv3oP7qbGKTTs6KbSOZ6VHm0GOFJA4oy23PoJU10AYicKGM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713786991; c=relaxed/simple;
	bh=eOGcIFG5AL3KYS7txR41D0DrhKGFKf6mBmKuVSlv8g8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rSAtap9PysuwlugA8b21pwuskjsqT37pWjZle6Qk9ZmqhX5SENt9mHwuBE/3jPlOuTptGjH6qqK3MOqiPEnZ4L38H94kCuivhFIybdHGTR9Xmk6zoanLht4o239NdSD34eoCDGffkGZ5MfjQ/Voq+l2eOUzl4QQSRZTDUWBqQhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xE4YAHnw; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-418e4cd2196so31710695e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 04:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713786988; x=1714391788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nX/bMWfXLXDn6zEUT9fHT9j4a6f6t+9m1elQSx8/+lQ=;
        b=xE4YAHnw0NQigLOw6Lvwuwh5wIcHXZdJZcN70BQUSSsux1aL2sEwdfpbXf4ILvYQ4m
         AoWKFJXQxAu3FOuoA8BmMMUWECDvnigD1+Ik11UQULOXeYi0km/eGaNecF6QfU1f5H5k
         EQ02JK3zR1uJKu35SmdWGSvGsZ+nTlX4jjmQTpA9FQIQEJL0JetCK2uOxz2ivW9AP+6q
         RGpSvgBhtXcSG3v1PPEGZ6Slm+6BgMjGJerBAw7leob+BGZgVbsYO1+RTyXEUejC+roP
         4I7lOcBBskmigWDPX5kqgZlrqzG9eCjVkFX7sxXdg7Kphf9yq3Q+dGo9NhKeHwSn2qHl
         pMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713786988; x=1714391788;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nX/bMWfXLXDn6zEUT9fHT9j4a6f6t+9m1elQSx8/+lQ=;
        b=Vsyc7UuCXfz8+j0YbHJjTsNjrq0EgKJh/AGfhvNfR0QaV+odQcEi3UPpf0ti93pWlP
         pA1g1wuxYu1LGf6LCNm94mC5ZzYW1yRmJ3vta2tXXxpgL+dTfh5b/hnPViwLIHLucUjK
         godcj0dpT/QjI5D5Vnpl4eNfYn8GBmHG5fP1eimsCaToIDJ5f9aTU16woj3vDmYYyHKM
         1+EnF6TT8dV0ve5EIOHYUarGpUQjsBOM1yeSN0GPbIp7+DtUg5XDmSD98iIzfgYHhtWG
         NqntAyxftm4dqGVVsP/IqTJ5T78NGI8TiYOXswwykRU8ApC1EAE5CRKgNXI/Yt5GaeOF
         zUgw==
X-Forwarded-Encrypted: i=1; AJvYcCXE9QuFwQaDDwPKoC8iEl7JCXHJiIHHiLhDjAYcSdwgKxuOHoqvoULaLu+R2UQojmuN5iOHPs1mbp45zTJRQ04CuLKwOgxGzCSMnhvP
X-Gm-Message-State: AOJu0Yw0u2FSCvFnotWzDdMefU1cJdC32m1fU+QQRj5oUbg1nT60me4k
	UZAZA5eZZRdg8vsHfGVEryo3aoGrr1vODGyGeeX/7JiBcxZvMjH3puDQQz/Y8OI=
X-Google-Smtp-Source: AGHT+IGVXgMIXd3YHlwOCTD3Vi0s0IjqBet7mPIGRlkGEfrfiJzXlInqlZH69CmrU10ID0Wv9BeUtw==
X-Received: by 2002:a05:600c:4591:b0:419:400:de88 with SMTP id r17-20020a05600c459100b004190400de88mr7113299wmo.27.1713786988025;
        Mon, 22 Apr 2024 04:56:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id m5-20020a7bca45000000b0041a68d4fe76sm1761348wml.0.2024.04.22.04.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 04:56:27 -0700 (PDT)
Message-ID: <eab45cdd-a0b5-4766-b62c-00c1a92a3618@linaro.org>
Date: Mon, 22 Apr 2024 13:56:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] dt-bindings: power: Extend battery chemistry with
 capacitor
To: Mike Looijmans <mike.looijmans@topic.nl>, linux-pm@vger.kernel.org
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.b2a893bc-f00b-47cf-ae07-b37ec1bace22@emailsignatures365.codetwo.com>
 <20240415081305.316107-1-mike.looijmans@topic.nl>
 <1f94ee56-7f8e-453b-ab86-f640b298d81c@linaro.org>
 <16ff3a55-3d04-46e6-b78c-c1964c062329@topic.nl>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <16ff3a55-3d04-46e6-b78c-c1964c062329@topic.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/04/2024 09:50, Mike Looijmans wrote:
> On 15-04-2024 17:24, Krzysztof Kozlowski wrote:
>> On 15/04/2024 10:13, Mike Looijmans wrote:
>>> Another technology to store energy is a (super)capacitor.
>>>
>>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>> ---
>>>
>>> (no changes since v1)
>>>
>>>   Documentation/devicetree/bindings/power/supply/battery.yaml | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/power/supply/battery.yaml b/Documentation/devicetree/bindings/power/supply/battery.yaml
>>> index 491488e7b970..a22c97dfad88 100644
>>> --- a/Documentation/devicetree/bindings/power/supply/battery.yaml
>>> +++ b/Documentation/devicetree/bindings/power/supply/battery.yaml
>>> @@ -44,6 +44,7 @@ properties:
>>>         - const: lithium-ion-polymer
>>>         - const: lithium-ion-iron-phosphate
>>>         - const: lithium-ion-manganese-oxide
>>> +      - const: capacitor
>> Please keep some sort of order... everyone insists on adding to the end
>> of the lists...
> 
> Could make it alphabetical, but that requires re-ordering the existing 
> ones so "lithium" sorts before "nickel".

So just put it at beginning, less sorting later.

> 
> I think the intention here was that the order is the same as the 
> matching defines in power-supply.h

There is no such binding as power-supply.h. And other headers do not
matter, they are not bindings.

Best regards,
Krzysztof


