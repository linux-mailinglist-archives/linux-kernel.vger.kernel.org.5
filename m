Return-Path: <linux-kernel+bounces-126360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 083918935A3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 21:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70EAD1F22166
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69931474CE;
	Sun, 31 Mar 2024 19:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KADc3Rq9"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700F5146D7D
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 19:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711914153; cv=none; b=e29gV5uO+vIvq30n1n/oXBPVL0WBuhS9Wep7cIGSOcIdTxtASXco7MxTx1IGoiqBoSkOPIVBUYxun87bVaBkke4ArjyNDyQyoIpXY1fNckeoN5UphHqGzZDzxPmmTdYmTH7/CpJ7GsjCIH8ggpVCCeNQZgeLPjxorBuyk5O2E/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711914153; c=relaxed/simple;
	bh=4O449uDER9hGB7jNnSl8M++gFxwsOoKdZ44vmu91USg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XW6ua+9/2ua0R6lEpv31EqE/sYVzIBYxsfAheSnjypqj9dShTJAafvpmRO6dDsWItFrEN+eaRQM7xuWO4NJ9oD3hTqtfnxYXW4+g3QK0vjMDhcyNyaEfw8FwkY3Y4jI8XfkFnDViqZXqx7B1NaYRaRc8QDjc/y2FylNxBTHhyuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KADc3Rq9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41567ce7d3fso214495e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 12:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711914149; x=1712518949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fgvq99cXWyahdPEeRKbwLZ856Z/nFUREvqBsKFF2cmM=;
        b=KADc3Rq9UV+RO7D8mWm+yhiGj4GvQ5qGGhbrecKklaFccATa3kMc7IQfb7ki7cdpux
         9iPz3qgQw9d364yU3e0F9uXgjJCm9qZJeWvbWCg+kCZZRmHrCVvNbJ6FMNeMoKVvTT10
         3m+x/QlCoDH3j0OmB3LbyBTINWH8TWp1ZimndNe6ImsOS3LbnCq6P/b70VkHCLOvVT+M
         xt7l1UURIEiE+/s36hAD7z5LD75RBbqBDrOS4jr1p0nVIIKiVxSZg9a+d2/ZSE/djDQG
         i4Yo5pWWhVK173fAwB/Ev/yYnTo2g4iIILrNoFAxllqnkNnsq6cG5ypEfj1/qrYFXgdZ
         Uw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711914149; x=1712518949;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgvq99cXWyahdPEeRKbwLZ856Z/nFUREvqBsKFF2cmM=;
        b=TORgPBQPIZ2x7VaVuHIGCxLQKcCnuZOcWNnthW0gQFuMHi4N8etmiRBOW26qGeo5H1
         5EXTezVfgDly1q6zToZWGkCS4OIexA1UJLeeZHMyKCLqyNw27EQkqHWovyu0KEQ+jO5W
         uKKajQJtzHB5K3YrMWYDhPcejybqP00iMMxegXkcEuUdUMfJJOsOi+VWEUjq6bchrCVf
         VySjlvvShB0yOSqlTfoiD4U5HVUadzXan5G8K02oVX7J6rkm8KoOc1MuqREFs0TIaz1B
         dyHBRmAMiBV3X9KvsdUD+/tuCNLFin8GsFAjLjb4agph+LxvZ9siyKUcSeCYcAyB1ErC
         9EQA==
X-Forwarded-Encrypted: i=1; AJvYcCVhxewX0jygdceU2aWI9Xn2U0E04zu67wngPQl9ZF2ay3SsuWVjaDF4IgYrzyoSQ43I/LpO8nK0omSTepvnZngIaozDIxRbJHjbdL3Z
X-Gm-Message-State: AOJu0YzWz/oVXsNJOzl0D1um+ooDOXpewM14Ef+7TeOWxDs7EzdERiEV
	LZGYNZM+6B2eV4Mb4ll2aVAIrKWo5ttiLy1QiDsYAgsyaN1BGMG50pJLKwMmeN8=
X-Google-Smtp-Source: AGHT+IHMVRY4AMMDLr8mhs443QG4RDXTDC48pOBBpX6fpAmTnJdu5OwIkBcdfJjYnRG5qvNENBO7Og==
X-Received: by 2002:a05:600c:1907:b0:414:8aaa:acb5 with SMTP id j7-20020a05600c190700b004148aaaacb5mr5360354wmq.16.1711914148801;
        Sun, 31 Mar 2024 12:42:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id u8-20020a05600c19c800b0041478393b8fsm15444996wmq.42.2024.03.31.12.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Mar 2024 12:42:28 -0700 (PDT)
Message-ID: <b26314d1-a059-4fd8-b52a-1234606bb7e5@linaro.org>
Date: Sun, 31 Mar 2024 21:42:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v7 4/4] ASoc: dt-bindings: PCM6240: Add
 initial DT binding
To: "Ding, Shenghao" <shenghao-ding@ti.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
 "13916275206@139.com" <13916275206@139.com>,
 "Chawla, Mohit" <mohit.chawla@ti.com>, "soyer@irl.hu" <soyer@irl.hu>,
 "Huang, Jonathan" <jkhuang3@ti.com>, "tiwai@suse.de" <tiwai@suse.de>,
 "Djuandi, Peter" <pdjuandi@ti.com>, "Agrawal, Manisha"
 <manisha.agrawal@ti.com>, "Hari, Raj" <s-hari@ti.com>,
 "Yashar, Avi" <aviel@ti.com>, "Nagalla, Hari" <hnagalla@ti.com>,
 "Bajjuri, Praneeth" <praneeth@ti.com>, "Baojun.Xu@fpt.com"
 <Baojun.Xu@fpt.com>, Rob Herring <robh@kernel.org>
References: <20240331021835.1470-1-shenghao-ding@ti.com>
 <20240331021835.1470-5-shenghao-ding@ti.com>
 <cc7a60c3-4a1e-4f32-b6ef-4a41d5c48eaf@linaro.org>
 <41797fe7d5bb41b4bdea4ee7f4957291@ti.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <41797fe7d5bb41b4bdea4ee7f4957291@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/03/2024 15:20, Ding, Shenghao wrote:
> Hi Krzysztof
> Answer inline
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Sunday, March 31, 2024 4:15 PM
>> To: Ding, Shenghao <shenghao-ding@ti.com>; linux-kernel@vger.kernel.org
>> Cc: lgirdwood@gmail.com; broonie@kernel.org; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org; linux-
>> sound@vger.kernel.org; devicetree@vger.kernel.org; perex@perex.cz;
>> tiwai@suse.com; 13916275206@139.com; Chawla, Mohit
>> <mohit.chawla@ti.com>; soyer@irl.hu; Huang, Jonathan
>> <jkhuang3@ti.com>; tiwai@suse.de; Djuandi, Peter <pdjuandi@ti.com>;
>> Agrawal, Manisha <manisha.agrawal@ti.com>; Hari, Raj <s-hari@ti.com>;
>> Yashar, Avi <aviel@ti.com>; Nagalla, Hari <hnagalla@ti.com>; Bajjuri,
>> Praneeth <praneeth@ti.com>; Baojun.Xu@fpt.com; Rob Herring
>> <robh@kernel.org>
>> Subject: [EXTERNAL] Re: [PATCH v7 4/4] ASoc: dt-bindings: PCM6240: Add
>> initial DT binding
>>
> .............................
>>>  - remove unneeded items and if branches.
>>>  - Add missing compatible devices, such as adc6120, etc.
>>>  - Add necessary people into the list for DTS review
>>>  - correct misaligned.
>>>  - simplify the compatibility
>>>  - remove sound-name-prefix and revert back
>>>  - Add review information
>>
>> All these changes in v7 and you still kept Rob's review? I think either review
>> was not given or your changelog is just incorrect.
> Since Rob's review, nothing changed in yaml. Even in this patch, only removed kcontrol interfaces
> in the code and added the mixer-test report in cover-letter as Mark suggested, which is no effect
> on yaml file.

Then for the future, please use some reasonable format of changelog, e.g.:
https://lore.kernel.org/all/20240210-topic-8280_pcie-v3-0-ee7af6f892a0@linaro.org/

Best regards,
Krzysztof


