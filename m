Return-Path: <linux-kernel+bounces-55341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFBF84BB72
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E000B1C25175
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE73453A6;
	Tue,  6 Feb 2024 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ivaiwYQU"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB20523C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707238436; cv=none; b=aTHqaSaGrTrtK4zngQE4p84uTzW3ConZ74sWhFwL9MPtdYmuO4Fuq+DiuOeG05PSbnf5O9kh+Hdt3GMSaV0xRjb+PetAkQeBdXQtGtwDHuIukT77C0HXOI0vCGu4RLprjC/I1iC0KQQ4Hu1SuOrh3rWQXW6n55X5Z8Ief7r3CdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707238436; c=relaxed/simple;
	bh=2qZnHwSnkGIxaungMlSw9/HzXWRZUhGIlX+8c+0jXTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=njGlu1f36FqM6JiqnRCakd5fHpkstnHZ9+WcnJQwVBcsXdXl+JRejsBffXd3JRKCq7iwZpY6cPMC76atwydIHE8NEHJW2Y3ofCirYmQda8ZgM5P+4DvPY/FmhSklb8T7AvTw0VpKVdvCoR5Ga1MacyWcah0U8KRtV1dJGih/6dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ivaiwYQU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40fc549ab9bso39898705e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 08:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707238433; x=1707843233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u7UReqy2jOx23nkroOrTDiBv9PdSIS8SWjVnJJdMQDI=;
        b=ivaiwYQU2DN2aKT0oVoOFpytMuitbbLgYevhB7rRhLd5iHEkXcvis/yG1/OBS8y/no
         TPUpTvOYlWaa+wQkoP5G7Zd2cxeugLWBTDVp47alUNC/8OQr+xekJ5OqW2k2O+YNv4BA
         gn92WcVN/4flnUwn/wn6Odl/YHPAs74wGqP4lBK9Sjmq+uncfEZlxqOGYfR5igryPzvO
         +ZCyicz94rpYi+ohyFPwVxT79VsRNl21g2pQCappG/lKKQ1Ww1ByuE3C391KbUfcqHBw
         oHMbuMtf5VxMxREzxep7ZnsUBbBlYOHAbfTxhH1As3aXRyXcn3x8W5wwt6uwQ/hdB+Ma
         pdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707238433; x=1707843233;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u7UReqy2jOx23nkroOrTDiBv9PdSIS8SWjVnJJdMQDI=;
        b=ZUfDTT41p+3rlxHt7TurgarAlzIswzhKPSht5RZe/OpexKdWa4FwAYMli7KW/XM7VN
         AFmWDiOdNG2QhEHmY7BWV3jSH3sKaUZS3jBJCc8rMDr3Fnp7nuZ8oCt0/FEqOsS6oFmI
         rr2s2icolMK9KRSU0bd1yZ0ghDF5LOBbyQ0gjkFWtMQxiMBcYEaTc/HemTV+W+C3lg4A
         kez09x8q40N3XcQu7pkxuNPBLlyIfIx4wGzfoKzWUe9NY2LFSDpiP48BSrcYXUjc80g1
         PTTNb92hFXCg5AGb7FsFLhq+iDVWyIoZSfHzrmw+nClt9XRZMouY+cUXmFNvtnEXk428
         bcVg==
X-Gm-Message-State: AOJu0YyCN7PVPWJE06ULpYz6A+gDa3c7fmV+Y6k7dw/7F/JqUYO/kBKU
	7Y1RDYOpUbK7ycyPozZcrIrz0MEv2gJ4tlmOAIYaevePM0IGZ2fhz+9v4NIDrQk=
X-Google-Smtp-Source: AGHT+IH4QPHMSE4NahkIAlT2rf1rpH9wqv42oApmFpUmfyOnmpFbMo3IKpOMiMUdL4ni4bcxp0P6wg==
X-Received: by 2002:a05:600c:4fcc:b0:40f:b0c9:dbc with SMTP id o12-20020a05600c4fcc00b0040fb0c90dbcmr2406883wmq.37.1707238433527;
        Tue, 06 Feb 2024 08:53:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUO5jVSlMRmO0FgJllGwe7JOEaVioN8ZLypoARqgL/0iOZ60FvoKSuGUZWDZPKoQueQeZ2PdzUCrQ3RSgPP+zeLKUF2jPNhKWifrjFUEPu7ZFc0M8WDgVU2AaxMhsro24bzJfcMBNsZEtaJcTjIdDPcqBJstE+Sb3CpBlRRZa74moKep/47cAl+aqOpt6xTZA7LqPaxhglLgr+wZDJ+jZE1Y7+oF2ISKRmlObxwSdoV7wuPWFRJHxHG+IILSadqqfUywFP8SM2JtFwwP74RkaM0b6wcDvTbAru+aXiuQu6OdFn/PXh9MHKUw1nKiK0FtFQIwqaBreWEBuW73p1MTNjgClbvQizjW94q9Lw0VNKV3ET3rigq4NbyygqMIFRgA9sWgF7wlG1MiSelBEY56tNscl6bhSFprc6G0YOYzuQg0VJ5fGeYSfTgCtP+xt56AmPx7zpQKBfs11uVg2LiR3mwmLQE/yGWXR41HxkasOspHynGVDJY8lWZ6ahjeq3xjA96ilW4ETLi7AbMH1PiyP5NkA==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id q29-20020adfab1d000000b0033b46111d7csm2159503wrc.6.2024.02.06.08.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 08:53:53 -0800 (PST)
Message-ID: <70cdc60e-2f6c-49ca-914a-e28be4ac3714@linaro.org>
Date: Tue, 6 Feb 2024 17:53:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: trivial-devices: Add qca,spidev
Content-Language: en-US
To: frut3k7 <frut3k7@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 Naresh Solanki <Naresh.Solanki@9elements.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Yin <peteryin.openbmc@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Michal Simek <michal.simek@amd.com>, Lakshmi Yadlapati
 <lakshmiy@us.ibm.com>, Lukas Wunner <lukas@wunner.de>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Fabio Estevam <festevam@denx.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240205191828.998783-1-frut3k7@gmail.com>
 <fb9767e0-c5a8-448f-b3f7-e6f81ef008e6@linaro.org>
 <CAKEyCaAXqhzMbTQL8WhLze39cey_DuE-LYOrK+oitD=NiZMuTQ@mail.gmail.com>
 <7e2d927b-ce84-4939-8d0f-adfad2a3ef70@linaro.org>
 <CAKEyCaBADYxbU3XkJYv3WkZpJZ93nvfg+Zg2bvaViHCg47=9zw@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAKEyCaBADYxbU3XkJYv3WkZpJZ93nvfg+Zg2bvaViHCg47=9zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/02/2024 17:34, frut3k7 wrote:
>>>>> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
>>>>> index 79dcd92c4a43..50efbdf2a735 100644
>>>>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
>>>>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
>>>>> @@ -309,6 +309,8 @@ properties:
>>>>>            - plx,pex8648
>>>>>              # Pulsedlight LIDAR range-finding sensor
>>>>>            - pulsedlight,lidar-lite-v2
>>>>> +            # Qualcomm QCA4024 Multi-mode Bluetooth and 802.15.4 SoC
>>>>> +          - qca,spidev
>>>>
>>>> There is no such hardware as spidev and you even mentioned it is called
>>>> QCA4024, not spidev. Please don't use that name but a real name.
>>>>
>>> The compatibility will be changed to "qca4024" and a new patch version
>>> will be prepared.
>>
>> That would be ok except:
>>
>>>
>>>> Also, I have doubts that Bluetooth is a trivial device. Such devices
>>>> need supplies, have reset/powerdown GPIOs.
>>
>> this is not resolved. Bluetooth chips are not trivial devices. This one
>> particular exposes several interfaces to the host, needs a clock and
>> power supply.
>>
> Device is used over QUP4 SPI controller inside of IPQ8074:
> https://lore.kernel.org/all/20231123121324.1046164-1-robimarko@gmail.com/
> I'm not sure if these pin settings should be upstreamed as they are
> specific to this platform:
> https://github.com/openwrt/openwrt/pull/14051/files#diff-ed3fbf0226fbdc76c9c160f2f2b9e988120df472480b9861abe7a46796558115R81-R111

Why do you think qca4024 is specific to this platform? Judging by
Qualcomm website: it is not.

Best regards,
Krzysztof


