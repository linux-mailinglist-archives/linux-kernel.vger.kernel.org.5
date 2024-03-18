Return-Path: <linux-kernel+bounces-105932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D7C87E693
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77500280F00
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8602D04A;
	Mon, 18 Mar 2024 10:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A1Mj8GX5"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66732DF92
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756045; cv=none; b=igiUaae9hGX9ZAE+0CrbB4jp5k4ZqCboyWDaaW4zET9K7qXD2dFtRFvEwqTzddv+8B5QIDBbWL7dKzYx8nnqKLKugjK658Dc4LdemmjvicBu+8YpzWysskf5+GxTnRDqXqtA/fmp0oko9iAkX+TLsBT4jvFWKyYGUltrysUTwi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756045; c=relaxed/simple;
	bh=Y3KPjryeBk6WAZvX4AF/DKF7icODeEyu5eeTcBvHdYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TAsFFJhEVrr1UcvBRcAhEE8JCoazFrPECI0MGsj2dJF0QBf2S+/1XrOCsldeecnvpBJ5F+nFtbqb5l5QzBmqPOr7lWUg/7p2YcJWaoJR6owJKK9WDiRFbw5qBV8s7pUKDsP1tSNVR82dyZwkU+wM4GeC3RSVaeUE5OPO5M508oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A1Mj8GX5; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a46ba1a05e0so108836466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 03:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710756042; x=1711360842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nOpVJMHZinNvbP1S4eRDyzZwVy4BvWSLo+7riRjQi6Y=;
        b=A1Mj8GX5OMJJFuZyvq85dhWGYORsXWwLF+CJLYUwpwUbRFnYzyxvuXg4iJoVbRweI3
         KIyyY+4mJO3igUaECeztD5K+LDWHi2v4KKyAp1FH0CwGm+aSch6Lec6zpzU5cg91ymrB
         Ep8Z6tf74eKQEOIgkvWRPj1qMwr6YCTi/H3sBg0kuLbw654fTz6brLat3n1ia6YSPFXV
         zgdRIKxwr5YgO595vCM2rI4h7JT+U0CASvZG5VQkcmZztiqmoWjTBb/ZVWfTyt3dYO9L
         JhypenwJ3pDV/7bF8etn6qzMSIIKo3wk/02qG09uAOtonfJG1zgKLth7Vh0GeLyl6I7+
         mHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710756042; x=1711360842;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nOpVJMHZinNvbP1S4eRDyzZwVy4BvWSLo+7riRjQi6Y=;
        b=AQANE3QwBJJ6G6WvsrtuP4WNFZ4gL4K2TEk6F4MkCMAsdEinFGSRbn/yO28tDSLeTl
         oygzGLPgVYKgADJa3HDInWWNHT4kApVULNgFEvsHrFTGw/ytLhzxIW2ORFybl4JJgXj4
         AULgv3rijVeCIy0xWEnufj1gvlyBXFWlqK3Spw4DMDQ4aPRIjvBAbNI3nNQ+xFYSfq/q
         xhB87+2kfB4rDVi7XJSlC1LjneecbdfwJuy/LQgBL762DOucNnbkkM4E51sSDpFB1iS+
         N+KYbxQrMROnlU6APc0vTFEW/nJtfrtNVlHwb3c2ltAIXS64BecQXxShWnL+yK+azLQX
         1p+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvSAzCsrcluWkvdMdkDbnXflz8SxjzQdRABPHQGxGOrgbnmUw2Px2TWOImedNAXKIof11eY9JaZfMYSfQHbLXw5JQjG4hEWtssyEAL
X-Gm-Message-State: AOJu0Yz5abHX8P83yluPWyorp163NBM4TQm85v+kHZjBB33aQYQpjL4+
	pG1/awg60VLmBC6IHJk99uPWJcZVzZ1GdkMfaYizfPNaAZm1FmABvYNVcjWzWLw=
X-Google-Smtp-Source: AGHT+IFNSsbnlgNB4ccb54kO8I+YBeQgxLGEB38rT+5118DAl6YF6HVXQRJYq8D8/zj+uJJ1X1jUmg==
X-Received: by 2002:a17:907:1ca4:b0:a46:9e3c:9e62 with SMTP id nb36-20020a1709071ca400b00a469e3c9e62mr5312174ejc.13.1710756042103;
        Mon, 18 Mar 2024 03:00:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id dl5-20020a170907944500b00a46ada81f1bsm1971486ejc.124.2024.03.18.03.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 03:00:41 -0700 (PDT)
Message-ID: <a224e752-d99b-45d3-b5db-761a698c347e@linaro.org>
Date: Mon, 18 Mar 2024 11:00:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: hwmon: Add maxim max31790 driver
 bindings
Content-Language: en-US
To: Chanh Nguyen <chanh@amperemail.onmicrosoft.com>,
 Chanh Nguyen <chanh@os.amperecomputing.com>, Jean Delvare
 <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Justin Ledford
 <justinledford@google.com>, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 Open Source Submission <patches@amperecomputing.com>
Cc: Phong Vo <phong@os.amperecomputing.com>,
 Thang Nguyen <thang@os.amperecomputing.com>,
 Quan Nguyen <quan@os.amperecomputing.com>
References: <20240311111347.23067-1-chanh@os.amperecomputing.com>
 <20240311111347.23067-2-chanh@os.amperecomputing.com>
 <6fb70adb-aa85-4b9c-b093-afa4ec7ed056@linaro.org>
 <ab8b45c5-2ef0-4a87-87bf-f797954b4574@amperemail.onmicrosoft.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ab8b45c5-2ef0-4a87-87bf-f797954b4574@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/03/2024 10:51, Chanh Nguyen wrote:
> 
>> It does not look like you tested the bindings, at least after quick
>> look. Please run `make dt_binding_check` (see
>> Documentation/devicetree/bindings/writing-schema.rst for instructions).
>> Maybe you need to update your dtschema and yamllint.
>>
> 
> 
> I tested the binding, I didn't see any warning/error log. Please review 
> my logs as below

Hm, I don't remember what brought my attention to possible error. Maybe
I mistyped my template.

> 
> => make dt_binding_check DT_SCHEMA_FILES=/hwmon/max31790.yaml
> make[1]: Entering directory '/DISK4T/work/community/linux/out'
>    DTEX    Documentation/devicetree/bindings/hwmon/max31790.example.dts
>    DTC_CHK Documentation/devicetree/bindings/hwmon/max31790.example.dtb
> make[1]: Leaving directory '/DISK4T/work/community/linux/out'
> 
>>>
>>> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
>>> ---
>>>   .../devicetree/bindings/hwmon/max31790.yaml   | 44 +++++++++++++++++++
>>>   1 file changed, 44 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/hwmon/max31790.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/hwmon/max31790.yaml b/Documentation/devicetree/bindings/hwmon/max31790.yaml
>>> new file mode 100644
>>> index 000000000000..5a93e6bdebda
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/hwmon/max31790.yaml
>>
>> Filename like compatible.
> 
> Yes, I'll update that in v2
> 
>>
>>> @@ -0,0 +1,44 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/hwmon/max31790.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: The Maxim MAX31790 Fan Controller
>>> +
>>> +maintainers:
>>> +  - Jean Delvare <jdelvare@suse.com>
>>> +  - Guenter Roeck <linux@roeck-us.net>
>>
>> You should have here someone responsible for hardware, not subsystem
>> maintainers.
>>
> 
> Hi Krzysztof,
> I checked the history of the drivers/hwmon/max31790.c and see Guenter 
> Roeck <linux@roeck-us.net> as an important maintainer. I saw many 
> commits from him. So, I add him to maintainer list.

OK

> 
>>> +
>>> +description: >
>>> +  The MAX31790 controls the speeds of up to six fans using six
>>> +  independent PWM outputs. The desired fan speeds (or PWM duty cycles)
>>> +  are written through the I2C interface.
>>> +
>>> +  Datasheets:
>>> +    https://datasheets.maximintegrated.com/en/ds/MAX31790.pdf
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: maxim,max31790
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>
>> That's weirdly empty.
>>
> 
> Hi Krzysztof,
> I have not yet understood your comment here. Please help give more 
> details for my missing! Thank Krzysztof!

I expect many more properties of a fan controller. Resources (clocks,
PWMs, supplies) and FAN specific properties.


>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +
>>
>> You miss allOf: with $ref to fan controller schema.
>>
> 
> Thank Krzysztof,
> I'll add the allOf at v2.
> 
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    i2c {
>>> +      #address-cells = <1>;
>>> +      #size-cells = <0>;
>>> +
>>> +      max31790@20 {
>>
>> Node names should be generic. See also an explanation and list of
>> examples (not exhaustive) in DT specification:
>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>>
> 
> I suggest some node names, such as "i2c-fan" or "fan-controller" . Can 
> you please share your ideas with me!

Look at recent commits and patches for similar type of a device.

Best regards,
Krzysztof


