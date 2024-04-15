Return-Path: <linux-kernel+bounces-147187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F178A70B9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5082F1F263BB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E115713C699;
	Tue, 16 Apr 2024 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zDybleOV"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5CF133404
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282877; cv=none; b=ZL/pvPrGxPFq/KkHzfKTlDmnWjTwUMcek7nf08pn7REtf9ePRe5Zy68fitGwNhu2iW0VYlD3uNdB5bZrTHcOBbxHTqBgMHvaLI0WSDT7q068y4aXEH3i5HJLVcQ09VQSvtq6CH8sT4QnkW0xQ6XdWW0VgyM7YneMDeuyu/2MoMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282877; c=relaxed/simple;
	bh=N4oCRw8PqNjgDDz+t3t8G2SKrBaPDNC+xxUo4ngc3Hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUvQRq79i+qHVBOffTnviOEFJ4FHSyr/3CXQdOt1AU+h4V2CrES5v55vTheHWQq80XIhpm8tq1sThAxExb4YNYAGYzHgcCoY7IhAC9feLMVE/rMgFWohAMIK9c+IFKXK4S3/kpPnoIDvRCY2+uSnknhEsE3t6S8p6Q82Dwi/3MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zDybleOV; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e411e339b8so35983885ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713282874; x=1713887674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5Hotsx+hX1xEukbL8swunTl5n/JV2kOBllqRAES/ODY=;
        b=zDybleOV9i6/gBjZQvFUcmr3qFxrrz+G2h1Mb9+UN8AFOkF06pVzVf9cJVgtyFhZGm
         dKwh7CkTqXaTIok0ro22S11UhnYCW0B6wFomqM1aTvCc7fLXvgGaJbBZrO1pCWJGC4R/
         /h8oMjQxFLIi1xvwbc0Ioi0LsvOVdyUFQwxS8fAiJBR0FX1zlrPrfiJivI3qClTdtfa3
         6OweCw33psAAPKrw6twhKf7zamZAfK7rYgi5LbpByzVxfQwDgPMQcwxk8ypsDJR11ARs
         BOImHRI5QEnw7h9QjbJ/6E/mgFc21dq0hVcYnYsSJ1wq7YwfopjUBvWm9/vAkPz8OBxs
         gwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713282874; x=1713887674;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Hotsx+hX1xEukbL8swunTl5n/JV2kOBllqRAES/ODY=;
        b=u8f9s/Noq7d+25uNmbBkorVYztY+j4kl1KPnpbJcuEfL0Vkf4//PmGfoVE5E6POWLn
         oUZ7KOkAtyFiLgGSFm+0q70KSiqv/BOcW5EtrcKtGlunQm+9+dxQXzzMTB4cBCt0KDwk
         jZvA3b8pXcQ4bORlAsfwRsDOjqC+x7vSXt4rmB8lbvMGrVXuldSJ5hz0g2gxiZ5xZvA4
         Lj7dwBJIcHEI4CmodwoSZs1KfKNA/wh6d2NXxPt8oQSiLJVUTngU5APbRZakpEdc52P0
         UrkGPcwo5DqBSNH3uP1iMmFy6LvN44q3NMJSkYHJ6ph7sUkjVj7tVmPIY5vc5mMJJ0Hl
         ncaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQcugdRVzpuyELUKKq6SOj/aZbq4y+guCmyyrFTdPhLvxwTeD9rSr5Zoqw6I3bIgf0WcWnjALX7ZmtwqHK6a/cCmRXljJGLRjkPFOT
X-Gm-Message-State: AOJu0Yw/+IAQkXXCH6tHVYiQClU763od/IPFsuKMgvJlGsi62O+kMrMS
	Bri4AJ4F74Zvkq1lBduEmRy19r/1HT5V80Tgt2UIQ2JPWU2C2lSJc48j3c1pgyw=
X-Google-Smtp-Source: AGHT+IGlxugXedaluxAQ0Pn06nm424gnEHeqpDEuMt487ox9yVbLFnhD4Iyg8YN/7ZkwrA/1RoCCkw==
X-Received: by 2002:a17:902:d48d:b0:1dd:878d:9dca with SMTP id c13-20020a170902d48d00b001dd878d9dcamr16250516plg.48.1713282874176;
        Tue, 16 Apr 2024 08:54:34 -0700 (PDT)
Received: from [10.36.51.174] ([24.75.208.155])
        by smtp.gmail.com with ESMTPSA id n13-20020a170902e54d00b001dc01efaec2sm9939360plf.168.2024.04.16.08.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 08:54:33 -0700 (PDT)
Message-ID: <fd3dd25d-05fb-48e1-80d9-04b72c8dcb61@linaro.org>
Date: Mon, 15 Apr 2024 17:29:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/6] dt-bindings: ROHM BD96801 PMIC regulators
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <cover.1712920132.git.mazziesaccount@gmail.com>
 <27a1c489f62e46a80643fe86cca101fb5aadb7f4.1712920132.git.mazziesaccount@gmail.com>
 <72cf2a5d-55d2-4117-8b80-b3e517a7a9eb@linaro.org>
 <5994ff29-c916-4b5d-a634-8521e79e2417@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <5994ff29-c916-4b5d-a634-8521e79e2417@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/04/2024 08:51, Matti Vaittinen wrote:
> On 4/14/24 00:27, Krzysztof Kozlowski wrote:
>> On 12/04/2024 13:21, Matti Vaittinen wrote:
>>> ROHM BD96801 is a highly configurable automotive grade PMIC. Introduce
>>> DT bindings for the BD96801 regulators.
>>>
>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>> ---
>>> Revision history:
>>> - No changes since RFCv1
>>
>> Subject: missing "regulator" prefix, as first.
>>
>>>
>>>   .../regulator/rohm,bd96801-regulator.yaml     | 69 +++++++++++++++++++
>>>   1 file changed, 69 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd96801-regulator.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd96801-regulator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd96801-regulator.yaml
>>> new file mode 100644
>>> index 000000000000..4015802a3d84
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/regulator/rohm,bd96801-regulator.yaml
>>> @@ -0,0 +1,69 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/regulator/rohm,bd96801-regulator.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: ROHM BD96801 Power Management Integrated Circuit regulators
>>> +
>>> +maintainers:
>>> +  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
>>> +
>>> +description: |
>>> +  This module is part of the ROHM BD96801 MFD device. For more details
>>> +  see Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml.
>>> +
>>> +  The regulator controller is represented as a sub-node of the PMIC node
>>> +  on the device tree.
>>> +
>>> +  Regulator nodes should be named to BUCK_<number> and LDO_<number>.
>>> +  The valid names for BD96801 regulator nodes are
>>> +  BUCK1, BUCK2, BUCK3, BUCK4, LDO5, LDO6, LDO7
>>> +
>>> +patternProperties:
>>> +  "^LDO[5-7]$":
>>
>> lowercase
>>
>>> +    type: object
>>> +    description:
>>> +      Properties for single LDO regulator.
>>> +    $ref: regulator.yaml#
>>
>> Missing unevaluatedProperties: false
>>
>>> +
>>> +    properties:
>>> +      regulator-name:
>>> +        pattern: "^ldo[5-7]$"
>>> +        description:
>>> +          Name of the regulator. Should be "ldo5", ..., "ldo7"
>>
>> Why do you enforce the name? The name should match board schematics, not
>> regulator datasheet.
> 
> If my memory serves me right, the slightly peculiar thing with the 
> regulator core is it does matching of the regulators based on the names 
> of the nodes. There was the regulator-compatible property, but I think 
> it has been deprecated long ago.
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/regulator/of_regulator.c#L380
> 
> Hence the regulators tend to have fixed names for the nodes. Unless 
> there has been some recent changes I am not aware of...

Yes, names of the nodes, but not "regulator-name" property.

> 
>>> +      rohm,initial-voltage-microvolt:
>>> +        description:
>>> +          Initial voltage for regulator. Voltage can be tuned +/-150 mV from
>>> +          this value. NOTE, This can be modified via I2C only when PMIC is in
>>> +          STBY state.
>>> +        minimum: 300000
>>> +        maximum: 3300000
>>
>> Hm, regulator min/max microvolts properties don't work for you? The
>> initial will be just middle?
> 
> I had not even thought of this!
> 
> I think this is a good idea. The problem I see is if the system where 
> the PMIC is used will need to have 'initial power level' at start-up, 
> which is near the one end of the allowed voltage area. (This because the 
> "tuning"-range is quite narrow after the initial voltage is set). Wide 
> allowed voltage range may be needed if the PMIC is reconfigured using 
> the PMIC STBY state during the runtime.
> 
> Eg, sequence would look like:
> 
> Bootup:
> PMIC STBY:
>   - initial value 'A' from DT
> => PMIC ACTIVE
>   - desired (early) voltages 'A' + 'tune'
> 
> ...
> 
> Voltage state differing more than the 'tune' needed due to some runtime 
> use-case:
> => PMIC STBY
>   - initial value 'B'
> => PMIC ACTIVE
>   - desired voltages 'B' + 'tune'
> 
> Now, if the 'A' can be 'far' from the mid point of the 'allowed 
> voltages' -range.
> 
> I have no idea how valid this use-case is though. Once again, I work for 
> a component vendor and don't get to see the forest from the trees... But 
> sure I would like to enable as many possible use-cases as, well, possible :)

Still I think min/max microvolt solves your case. The property is
board-specific and should match what is really on the board. Therefore
when writing DTS, one must properly set min/max which in this particular
meaning would choose the starting voltage.

I am also fine with this property if somehow min/max create confusion or
aren't solving the problem.


Best regards,
Krzysztof


