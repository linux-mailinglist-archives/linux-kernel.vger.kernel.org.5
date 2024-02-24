Return-Path: <linux-kernel+bounces-79543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1FA8623D8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 10:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10ADB1F2385D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 09:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46CD199A2;
	Sat, 24 Feb 2024 09:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E2+EpNMg"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADD718E3F
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 09:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708766654; cv=none; b=rvaU0dwUwXfR0Ph396HkoBzF/d+LVRE4SF8gVmnvNM+OpmnywYnYQ0o4ORR9T5m36sFz+E5b3yBjsEtzb8QTS+hvZTFsGqy6CyCb/0L307YeT64mq2/XDnojstf789bSq00ernzvJKcLmj4DOramX4gQEfkGxjuOA+6E4nxR/4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708766654; c=relaxed/simple;
	bh=p8tciHfgWI8nhnU1lwpxUjsCzl9vy0edvMrke59zFOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ptp1D6/lGWDZzvziP92lGOWbuWRgmeZtuyaSpj0NgXSFCu7HzKSiOOOQcxNx2T/ZBR6QjQbPk0m3X4P7P59+xmFBuqBJHEj/zrhuxH9oBHhhxbiAi+fbNmv5+u4lfRBOFEJrkKaviJB1zhfPJjtwfJ2YIl1ahdXaNUJPwM7MROk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E2+EpNMg; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3122b70439so159249966b.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 01:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708766651; x=1709371451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e2rBHahbd3VJ7pBf4lVqIiyU3jm+URRIYusfSN2waHY=;
        b=E2+EpNMgIyBeon2ESGqtHYoHiR/LY8wQYWIcIdQbV3Vrhicjsbnl2x98QKu/Lc7+r5
         r5LaTA0MT5EFw231l+v2VkbvOUdfkN3ihC93U4Yz1KNYjn6F/f+5hS1xkMt9jhh8fk3z
         onp9ao3RdYsf9fypuG0jMGYzE8oYnsl6KBeNUYZTuO86Qd5BBz2DlbEAupNZV9vcmlIo
         5/UOBv53+pQcJk1iuN64i8jPzLxVL8HH0kkDnK4P9e5XQziiU7gWjBzT9rejKfYN2cUO
         bDu+0nH+wCA5CAIadhDW6arBZZVqNk7LleJBoJxk5G8rMSf+rRRSsm4aYiMbzM5Yv0QW
         wmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708766651; x=1709371451;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e2rBHahbd3VJ7pBf4lVqIiyU3jm+URRIYusfSN2waHY=;
        b=i51TXPTv6cotZMAIrwY6P96ArwbEeKBrfucORwRZ2VnsSWzm67GjravRQ24+RMBgUQ
         6QEtyFKP4BURn7M2lJjpBi7HtiD1YsK0QIJ62izVb/wK3c0Ygc12u3wChUl2lXG13Zij
         hnfVcLfgGwsKHTN0vENwYlprTEY6qskiayn7ndtzFF9XwVr1PTqTrODX6mfUggbMEzJC
         V6goNjTW2Yj1nH9Ipb+87xtYVAG/mhWiN9FBMsUfBppK2I2bUHhO/fkQ7QEZgIJfuEc7
         br00Wy68+CaTT8EDCM9XqYn6V1gIwdKYfeK+or0VwI7y9VEg/k3Hprzc4sFs7dF+vkMd
         2Fow==
X-Forwarded-Encrypted: i=1; AJvYcCVbsEaxEmpDDlWRFt7gQ6dGMUEWq+QSwLryb20KKNdcrqb7cxn0OSZ/+jaSQrtzU7+MRaTxFW1lcqzBTbEsjHJ5EpM+wuEo+ZPL/jbl
X-Gm-Message-State: AOJu0YwKfq3rOvPFj9TfddDpPeSit3oQIAgH8yvB/bDnX7LY4PLOT1JG
	99QvEgxLoOTIKP0JF7wUfttMRFxFT8Q7aB7lhWludImbFguza+0F6OUN0X5UqSI=
X-Google-Smtp-Source: AGHT+IFhWD4eyHrDcXBM8xZtbKLKp84FHlSWIhJzgk9tATj/ZtjCxVEzNU52cpKc1B8JFcnTeBH/yA==
X-Received: by 2002:a17:906:dfcf:b0:a41:3e28:5db0 with SMTP id jt15-20020a170906dfcf00b00a413e285db0mr1375688ejc.26.1708766651228;
        Sat, 24 Feb 2024 01:24:11 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id z21-20020a1709060ad500b00a3e4d2d99adsm407499ejf.219.2024.02.24.01.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 01:24:10 -0800 (PST)
Message-ID: <2c01f334-d061-44f4-a77d-8714226ff11a@linaro.org>
Date: Sat, 24 Feb 2024 10:24:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: add common properties with label
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <20240216-dt-bindings-hwmon-common-v1-0-3c2c24ff1260@linaro.org>
 <20240216-dt-bindings-hwmon-common-v1-1-3c2c24ff1260@linaro.org>
 <f0f523c3-7b1c-404a-89c3-0c7345001676@roeck-us.net>
 <b21d351f-68be-4bca-a327-c35591c55610@linaro.org>
 <20240222195005.GA3735196-robh@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240222195005.GA3735196-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/02/2024 20:50, Rob Herring wrote:
> On Sat, Feb 17, 2024 at 09:21:46AM +0100, Krzysztof Kozlowski wrote:
>> On 16/02/2024 18:11, Guenter Roeck wrote:
>>> On 2/15/24 23:55, Krzysztof Kozlowski wrote:
>>>> Linux hwmon core code parses "label" property for each device, so add a
>>>> common schema for that.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>>  From hwmon perspective:
>>>
>>> Acked-by: Guenter Roeck <linux@roeck-us.net>
>>>
>>>> ---
>>>>   .../devicetree/bindings/hwmon/hwmon-common.yaml          | 16 ++++++++++++++++
>>>>   1 file changed, 16 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/hwmon/hwmon-common.yaml b/Documentation/devicetree/bindings/hwmon/hwmon-common.yaml
>>>> new file mode 100644
>>>> index 000000000000..d83f4180f622
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/hwmon/hwmon-common.yaml
>>>> @@ -0,0 +1,16 @@
>>>> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/hwmon/hwmon-common.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Hardware Monitoring Devices Common Properties
>>>> +
>>>> +maintainers:
>>>> +  - Guenter Roeck <linux@roeck-us.net>
>>>> +
>>>> +properties:
>>>> +  label:
>>>> +    description: A descriptive name for this device.
>>>> +
>>>
>>> Would it make sense to also add shunt-resistor-micro-ohms ?
>>
>> It's not present on many devices, I think, so it is also not parsed by
>> hwmon core. I plan to add above $ref to hwmon-common to each hwmon
>> binding, so this would mean all of them will get shunt-resistor. I would
>> not add it, but I also don't mind if I am overruled.
> 
> I count 11 users. That's enough for me to add it here.
> 
> I care less if a device uses a defined property it doesn't need. I'm 
> more worried about having any undefined property allowed.

Ack, I'll send a v2.

Best regards,
Krzysztof


