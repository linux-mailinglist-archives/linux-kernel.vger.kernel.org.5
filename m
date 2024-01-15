Return-Path: <linux-kernel+bounces-25873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B47282D71B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C90BB20F88
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61412FC11;
	Mon, 15 Jan 2024 10:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t2YFl3Xl"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E5EF9C7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2dd05e02ffso69661666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 02:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705314004; x=1705918804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xijCf/YDkwOnmDTQnERUbZpzUNopwzB6kEA36dUyy38=;
        b=t2YFl3XlRm7Qh8Qc6NfB+Lk9rat+W85d/GyHbogv6+G4BD+cXO1Jg+pf9ovJl1zu3l
         VmYD25tEu2B8+o1csN49KfwFw5NkMdbOQTEaP6lpeb3p5pfW8PNmggcv6VmPttl0ahzI
         DP6DFfBpTCnO/krRp9okzOm5CiEQ0Q7L1+ds4YlPsfUBitOYSziGYkzCx+Fl+6kUGJUV
         5cYUGUnqnliFKx3DGrVgxWmtpPWMMuXwXSXh2Drw5BBuQnrkxmfgWsLzlFy+mRP3rrnw
         OFNOTU64OjvXalp4er78fgcpjBAKiidLQJTCUTWmDoI9e3f9RUxYT+NJ3ucDxeUqF39b
         aGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705314004; x=1705918804;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xijCf/YDkwOnmDTQnERUbZpzUNopwzB6kEA36dUyy38=;
        b=X+pLRNfuzmUG+d7Bad9qxZqVYhdawbO4BgGYWTwrcqrZR5mRqFH1H3pu1cRQxgs1uS
         dlS4/ARf9iTSrxFMYAwlphwttbKfpIJc/8HCcH8FBLTM6oPA6Ph9FxCRhWVY2kJ9+BLx
         /dRD1Vnn7ufpjCwgij9WcM3FRPF20RgHBBcjvOGis//MbfLBcEYEL+73dlcvYmHE+rZ7
         LUblWmm9rM37k1Sbrv3oZChQjwBe6d8fIO2WdkhrmcK2oO4k/IRMr21dKgco1/5iO8gR
         rOycKP1oe2OWWxn265XvypmiXi6SOwc5JXuk1tIBHWx2JwEXfsIrFKIYTEtOa4QynK6a
         rMPg==
X-Gm-Message-State: AOJu0YypjXsfuuP4Q7cJY/q0DSWCvVJHnzRgHo0U0QBMhTX4GsQg2ZAc
	OEI2irLgzJx+yxbV6yLt0WJfiOHMebZpsA==
X-Google-Smtp-Source: AGHT+IGuM9d29ZiXgLbaH3iUCnRdKd5I5vbOPK/u1QYJKu5bhpwoXgbFqFWriA3kRhAOxxPlvqPv0w==
X-Received: by 2002:a17:907:918a:b0:a27:4221:6156 with SMTP id bp10-20020a170907918a00b00a2742216156mr1376218ejb.24.1705314004375;
        Mon, 15 Jan 2024 02:20:04 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id qk28-20020a170906d9dc00b00a28d1d73654sm5090256ejb.207.2024.01.15.02.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 02:20:03 -0800 (PST)
Message-ID: <bb912aeb-15ad-4410-a1c4-3d895d81d30b@linaro.org>
Date: Mon, 15 Jan 2024 11:20:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] dt-bindings: rtc: abx80x: convert to yaml
Content-Language: en-US
To: Josua Mayer <josua@solid-run.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
References: <20240112-add-am64-som-v2-0-1385246c428c@solid-run.com>
 <20240112-add-am64-som-v2-2-1385246c428c@solid-run.com>
 <7f45aaea-6520-41c7-8788-f6dd14c5fcb2@linaro.org>
 <fa954f30-22dc-4914-b037-c0ebb311637b@solid-run.com>
 <9cbc3ab1-0621-450c-b9f5-ecb1f401d326@solid-run.com>
 <c8c41aec-1a53-4b5f-82a3-e9b786c5325b@linaro.org>
 <d702f384-7c0f-443b-84bc-4333933cee7b@solid-run.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <d702f384-7c0f-443b-84bc-4333933cee7b@solid-run.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/01/2024 11:17, Josua Mayer wrote:
> Am 15.01.24 um 08:29 schrieb Krzysztof Kozlowski:
> 
>> On 14/01/2024 17:26, Josua Mayer wrote:
>>>>>> +maintainers: []
>>>>> You need a name here. If there is no driver maintainer or anyone
>>>>> interested, put devicetree list.
>>>> Ack.
>>>>>> +
>>>>>> +allOf:
>>>>>> +  - $ref: rtc.yaml#
>>> + $ref: /schemas/interrupts.yaml#
>>>
>>> Is it acceptable to reference generic interrupts schema?:
>> Why? No.
>>
>>> I see no rtc yaml doing that, and only some describe interrupts property explicitly. But Importing the schema would also cover -parent and -names.
>> No, it wouldn't. It does not matter. I don't understand what are you
>> trying to solve.
> dtbs_check is complaining about interrupt-parent property,
> because I added both interrrupts and interrupt-parent to my rtc node.

Difficult to say. You did not include example in your schema which
prevents parts of tests.

> 
> Also wondering whether interrupts property should be included in
> the example.

Yes, your example should be complete... but there is no example in the
first place :/



Best regards,
Krzysztof


