Return-Path: <linux-kernel+bounces-19273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB69826AAF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0578928244F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5A011C88;
	Mon,  8 Jan 2024 09:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wx7pend7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878DF11711
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-557535489d0so1733819a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 01:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704706115; x=1705310915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K8+yIEtHZ0QUryEj2uRDfKghYbencYpwk0jvKzor3RY=;
        b=wx7pend7JWwSISqi45dRWrdGSBYtmnR7KoejbCddDnrGoibeEtm6hbFFyGS1EiXDAl
         63otvXfhrTlqSavJRf2rPprQ5k7mLrUYbP62V3+fdzXJj16wRrt9epxzDJkwnr0ewLJN
         dO1TYrF+AXuRQs2+CJKLxjutngqumQFmZ7XdWtMb2chfi6OooUNgM72QBtQcvPHG4q/U
         oD3ADdnI9swaqeDO36NynU5Kab/dEL7XqV2h9XckgYcpNAu5iA0gn7tupkgJDpCXA0J0
         EV1RnScJTD1W086CQE8q1S1tB0Xhosl/JoQ1gA1ZxMLRKR1i6UhIDQ+b4rR4M0cqflVU
         kSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704706115; x=1705310915;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K8+yIEtHZ0QUryEj2uRDfKghYbencYpwk0jvKzor3RY=;
        b=QAFphhF+eAHictqFFbqOl9NwW5cFN9yLwlisIQkaNh/NWrCQaCoFSSCbfjE2eOXHv7
         tQI6oTFEj5dtqEt32x/SdrOGGxxYFQELvfCFE3WHCsoO60Jpv6Z5L7y6dcPwhjD++uji
         AGEjbLMzFJuPrYEWclNT+CoWv2ee4+KxcBW1i3xZVzBoQa9ZYnuxu0OjrJdZGEsm1pzX
         RnyH1zZc6ZNI9oml/4/HIbnfxxKrq/52MTw78f1CdoqAJTzK7ZGzwJATX44cf8VnbFMm
         qffDB27d2aLBXAAafGxR4xmjfTQGEPdpnj1XIGdWsIUynyjNDxHoJFj6ae9BP/Tshr9y
         55Sg==
X-Gm-Message-State: AOJu0YyHKOzfN+5GZxzAjMAIDzuzAHV792ulcY9zHjXkPhW4Ir/jGqoR
	AIj58quB6pF57DvmA/z3+UnBvxB1KDA9NA==
X-Google-Smtp-Source: AGHT+IGgU4f0eSG5EIK/Si7xdcnt6OVkF+l5W3vFRfHK5W62ol2rnZlgtBLYYLh21Al1X36K+lrz8Q==
X-Received: by 2002:a17:906:7c3:b0:a28:9620:de08 with SMTP id m3-20020a17090607c300b00a289620de08mr1104625ejc.108.1704706114681;
        Mon, 08 Jan 2024 01:28:34 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id q22-20020a170906771600b00a26ac1363c8sm3776671ejm.94.2024.01.08.01.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 01:28:34 -0800 (PST)
Message-ID: <7ceb8f61-6929-4ca0-83e0-c6534241ca5a@linaro.org>
Date: Mon, 8 Jan 2024 10:28:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] dt-bindings: rtc: sophgo: add RTC support for
 Sophgo CV1800 series SoC
Content-Language: en-US
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240108072253.30183-1-qiujingbao.dlmu@gmail.com>
 <20240108072253.30183-2-qiujingbao.dlmu@gmail.com>
 <cd4c5c26-fef9-44d8-a2fe-1cff0fc6fd03@linaro.org>
 <CAJRtX8TcXrP8aqr3ejvtDGR5Y-ogbLkvJvJkLh_MzpnK7wgLGw@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAJRtX8TcXrP8aqr3ejvtDGR5Y-ogbLkvJvJkLh_MzpnK7wgLGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/01/2024 10:10, Jingbao Qiu wrote:
> On Mon, Jan 8, 2024 at 4:04 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 08/01/2024 08:22, Jingbao Qiu wrote:
>>> Add RTC devicetree binding for Sophgo CV1800 SoC.
>>>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
>>> ---
>>>  .../bindings/rtc/sophgo,cv1800-rtc.yaml       | 56 +++++++++++++++++++
>>>  1 file changed, 56 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml b/Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml
>>> new file mode 100644
>>> index 000000000000..01a926cb5c81
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml
>>> @@ -0,0 +1,56 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/rtc/sophgo,cv1800-rtc.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Real Time Clock of the Sophgo CV1800 SoC
>>> +
>>> +allOf:
>>> +  - $ref: rtc.yaml#
>>
>> Why the allOf has moved?
> 
> Hi,
> Do you mean allof should be under maintainers? Or other meanings.

Yes and the patch which got my review had it correctly placed.

> 
>>
>>> +
>>> +maintainers:
>>> +  - Jingbao Qiu <qiujingbao.dlmu@gmail.com>
>>> +
>>> +description:
>>> +  Real Time Clock (RTC) is an independently powered module
>>> +  within the chip, which includes a 32KHz oscillator and a
>>> +  Power On Reset/POR submodule. It can be used for time display
>>> +  and timed alarm generation. In addition, the hardware state
>>> +  machine provides triggering and timing control for chip
>>> +  power on, off, and reset.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - const: sophgo,cv1800-rtc
>>> +      - const: syscon
>>
>> Why is this syscon? Description does not explain this.
> 
> Because the driver of the submodule POR in RTC only requires register
> address and range to work, according to what you said, it is only a compatible
> attribute and does not need to be a child node.

What child node has anything to do with syscon? Anyway I don't
understand that.

> 
> So I wrote the following in the changelog.
> 
> - add syscon attribute to share registers
>   with POR

Where is this syscon attribute? Please point me to specific line in DTS
and in the driver.

Best regards,
Krzysztof


