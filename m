Return-Path: <linux-kernel+bounces-55311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7626484BABF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02571287C9A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA672132C38;
	Tue,  6 Feb 2024 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jwrOv4gP"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6444134CDB
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 16:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707236344; cv=none; b=kuLjRgjKtcj4rkeCIu/Ahl0F3TQQPNDpHHsKT41vzdxuv6zN4d1twPJXlGd904Cjs2dudkpayeazHVqAKjU+He+tiLaqwGMCWRZMhgN4l58NWTvC9/VLNk5sL94+Prh9vNn4oEAFp5st2z9iR0Ldz5LiUCNAUhErC/ywFiO6ar0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707236344; c=relaxed/simple;
	bh=JX+5BDZlyXZOQOXKTtO5gdKSe/z+cv4+Jszarc+n3JM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tyyPwkn1ZB1bCsy24YP+63iEYvZunaneLSBmkS6QT/71jAVI/5VEoNffe6oOOL2NlNDfB8EfQ98dlW6ueW+mWsTjI6iY/BDqyofP6Q4/5SwZZaAYYcg/WGu4clIeckD+hSA6MUFOBqmXY5SJtu4E9N6J+ZzUSSZDOUrrCMTezn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jwrOv4gP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33b0e5d1e89so4631929f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 08:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707236340; x=1707841140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EZSqvCtxWFKM7fHq/y0p/ocx1ozCahvvBIGwNNRl0c8=;
        b=jwrOv4gPBg17iqs7hH3PPDEyCTx+0T/wga5Zq7Tz0+/oKvYzI5+H2BjizQmlGQn0tz
         YFiFcX9w6aoKPrvXmmj+8ekd4SBDqlR854rC8b5vWfwSHqF0xOWzfiXP5XcBqmp9edPu
         A52a/O4cYuN3mPhQNGRyi75mbByTCFchLqmmfXgAUOnFnv7JRy85Nh7f9Z4ZeIu94Whw
         xNwn8tap3DPcA0exxy0CAb2RU0xnN83y7azEI0CtSz0HLkX4rSM5tfRlzHQHDbuIiT3b
         JUFNYQTELFJPLe9wExrZrQcKx9TFwgFj5OAI7GO8pTQ4/QZUoJ08dnAQ8xOGapICIxqD
         XtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707236340; x=1707841140;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EZSqvCtxWFKM7fHq/y0p/ocx1ozCahvvBIGwNNRl0c8=;
        b=adFBqBEs6FsS5Jju8O7NSNu9guI5RFjhbnRcnc7pvHYK1yYTaB6khGMY8DaFb/ReDz
         HnYVxFeaMuGFF/u/jFwbLNhlcrUkS3gmCy/UACHXrTZkw4XhkDhoKBh1C3oaRcHvpFHt
         Q/EJS0YZ7bdROtqgS9tOV3oynaTgNhlXbC9pCMuiR36KH0aPTg+DVoIJzgGQxI5fA6TS
         Ydf+SfllVnG/IsEINChhJpcA3mY8vJX+qNmHc2zsdXS1LU6Nxihw24whWagsXa76cTmM
         NxeBfOKVbQ1uxU/TR5ysy1bBKgpQcMb58yXjeEJrQqQSm3KtsOiqQeKNWvC3zfZMFX83
         Sukg==
X-Gm-Message-State: AOJu0YyWy3ps6gGmspGEp6ncdFRXsVtikS8oiIN2jYQwhDX5hsj9UHMv
	+lvu4Muwg9/JyVSIlq3Jf1aIcYX6RAqk4EOJLMZvZlLkh2NNvHFCsvGBo7zF8wo=
X-Google-Smtp-Source: AGHT+IHYkB8trYsPSSvipnqkBjJrQYDOOc0Mdxzr8Yc392AIXr1QARmWPIYifGQdxwPByQvk3F9wWw==
X-Received: by 2002:adf:ee0b:0:b0:33a:df1f:c18d with SMTP id y11-20020adfee0b000000b0033adf1fc18dmr1707160wrn.50.1707236340070;
        Tue, 06 Feb 2024 08:19:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV9pvTMZ56iMBAwWtqOHcXbXTXqGsp1qxd3oLm3D7k5+KSAJ5J/paTETUViNm5t17lsQhf7OMTn2bUP/ZuqsV7PGS6CWwpXpv2WHQofEnzr2YynXIRLGhgt6/Sml165JVxdAltLWqVFj2BvrSwGdmDkjcHLugfnKP+vzk9lclWO1IY0SG4CKhElELaBnAYh0YVTt9eLT4P5vX7CJyjNG4MOcs2MR4kJhuAUdwwrXYGGooateDqns8auEJ0jLVvrLrNFYyWxbvraXnmmm1njtINz4MPwOTdUQA7/nOmPD8imKGPOp+TyqFFD/+e7+mzX9aiZz3YwTvU0QomJ+fI/DHfJwiyynbDV5MnQ9BumFmlKOu/rZqnQPo7wPnGRQrMkQIZtUP/swjt6mns/9GjqsO9EyvVMmmfnyxef7Ha8xPDdBEV6u27sOGvgNDxQEzbVSPJx83W49VgMw/AipiMtwNzVBKyLwM4ye0tX7hf9O60iEnP0uioMQBh4H3wXYlAXwLOmz1cQ/mM+AhS+wkICwUIkYA==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id e8-20020a5d5948000000b0033b47cf3221sm1697101wri.35.2024.02.06.08.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 08:18:59 -0800 (PST)
Message-ID: <7e2d927b-ce84-4939-8d0f-adfad2a3ef70@linaro.org>
Date: Tue, 6 Feb 2024 17:18:58 +0100
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
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAKEyCaAXqhzMbTQL8WhLze39cey_DuE-LYOrK+oitD=NiZMuTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/02/2024 17:11, frut3k7 wrote:
> On Tue, Feb 6, 2024 at 8:44 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 05/02/2024 20:18, Paweł Owoc wrote:
>>> Add Qualcomm QCA4024 to trivial devices.
>>>
>>> Signed-off-by: Paweł Owoc <frut3k7@gmail.com>
>>> ---
>>>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
>>> index 79dcd92c4a43..50efbdf2a735 100644
>>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
>>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
>>> @@ -309,6 +309,8 @@ properties:
>>>            - plx,pex8648
>>>              # Pulsedlight LIDAR range-finding sensor
>>>            - pulsedlight,lidar-lite-v2
>>> +            # Qualcomm QCA4024 Multi-mode Bluetooth and 802.15.4 SoC
>>> +          - qca,spidev
>>
>> There is no such hardware as spidev and you even mentioned it is called
>> QCA4024, not spidev. Please don't use that name but a real name.
>>
> The compatibility will be changed to "qca4024" and a new patch version
> will be prepared.

That would be ok except:

> 
>> Also, I have doubts that Bluetooth is a trivial device. Such devices
>> need supplies, have reset/powerdown GPIOs.

this is not resolved. Bluetooth chips are not trivial devices. This one
particular exposes several interfaces to the host, needs a clock and
power supply.

Best regards,
Krzysztof


