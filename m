Return-Path: <linux-kernel+bounces-1247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03573814C65
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8680B1F24F3F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDD939FD3;
	Fri, 15 Dec 2023 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQkKN+gc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2E039FC7;
	Fri, 15 Dec 2023 16:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5ca0b968d8dso365601a12.1;
        Fri, 15 Dec 2023 08:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702656187; x=1703260987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0VcnCj2g0CTMbP7kCr30p3xsaqF30bpbC2Z0SG00ebA=;
        b=BQkKN+gcNNp9IivBuRKuTG9PWURhUMrakOyUAKEc2tcRr6d8cDKNti4k916DGfce10
         fSSVhFV4gyOETxBlxeQjA36o84IHgv6I8YRZadoDVerPrUCCnniqR50IL4a4DPNahFnT
         lXiceZfTSWjiXgpDxz4ngr1ceP0880/8GR64GVDY2O9nE7Kfo17VhbfvBP7qaqV/7e/l
         pyQS5WY/OWYwmwfrjKels0rgJQi0JRIP9lMjuGGl7DfdVWqgFmnkVde5tpkjhnQd0hCj
         gjHcwbnDldLJdi/CMk6MRDzIiD0qDHeerdQUCx51/DWkCAgAaYSaW5hPlaOCTpHcgIq+
         xVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702656187; x=1703260987;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0VcnCj2g0CTMbP7kCr30p3xsaqF30bpbC2Z0SG00ebA=;
        b=Cb+FRXuACh5Bnpgp0RC4zF9sdr1U3e1YIY2QltFjQKTvl6+e82FYajTpgrns+j9YW7
         VIlFVUqywNVTVvZmfIpkXA2ppIK1aEzG5aIdSpuaRfeM049GF502vnkVR8BBnBD6XrWj
         6uhVCzq16e9aT1Uk9CIqBPlSVjiKaKyCvDGasjgnRmiOuAY0vY53R8eDAxO4aKW5v6Y6
         j/WUzyk/IR5jRJvArE1mAOsG9dAW6kyJ2YIHKHWHcwM+nzK1u2mRhp54s5iToVF5KLiH
         qoQIAK5vDjyMpnXoOp/NJqa47Ggo4pAlyeyH72tNNGvZh2RHSP92Cz7WOfhjpnMVedYW
         Sbqg==
X-Gm-Message-State: AOJu0YxV/xXVxHIIQ8/xrHVpxF9H2g5e+W40nAgaCNZ6+FHotyCe31Ak
	X1V7MLC8DfcabujLfMimm4eJGrtPY+8=
X-Google-Smtp-Source: AGHT+IFSH1D8sIyMyxDwxEymOQOtS3bUo+07nj6vzkeNM5nieaJ3mjQM/onoPIRqUw2gSN4WVlKpTQ==
X-Received: by 2002:a17:902:e789:b0:1d0:5567:5c75 with SMTP id cp9-20020a170902e78900b001d055675c75mr6544213plb.66.1702656186690;
        Fri, 15 Dec 2023 08:03:06 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902e74c00b001d077da4ac4sm14280162plf.212.2023.12.15.08.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 08:03:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a5bc25d5-f59c-43ce-a44a-3eabc4b2d06c@roeck-us.net>
Date: Fri, 15 Dec 2023 08:03:04 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] bindings: hwmon: Add adi,adaq4224_temp as compatible
 string
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Daniel Matyas <daniel.matyas@analog.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20231214143648.175336-1-daniel.matyas@analog.com>
 <20231214143648.175336-2-daniel.matyas@analog.com>
 <43c3f6cb-aeb2-40c8-a79d-c2222414b49c@linaro.org>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <43c3f6cb-aeb2-40c8-a79d-c2222414b49c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/15/23 00:49, Krzysztof Kozlowski wrote:
> On 14/12/2023 15:36, Daniel Matyas wrote:
>> In the device ada4224 the max31827 temperature sensor will be used, so
>> the default values corresponding to adaq4224_temp are the same for
>> max31827.
>>
>> Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching.
> 
>> ---
>>   Documentation/devicetree/bindings/hwmon/adi,max31827.yaml | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
>> index f60e06ab7d0a..9f3b0839aa46 100644
>> --- a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
>> +++ b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
>> @@ -20,6 +20,7 @@ properties:
>>         - const: adi,max31827
>>         - items:
>>             - enum:
>> +              - adi,adaq4224_temp
> 
> Underscores are not allowed
> 

That isn't the main problem with this patch.
https://github.com/analogdevicesinc/linux/tree/dev_adaq4224_dts
suggests that it may be a development system which utilizes the max31827.
 From there, we can see that there is a devicetree description of a board
with that name which uses

                 temperature1: temperature@5f {
                         compatible = "adi,adaq4224_temp";
                         reg = <0x5f>;
                         vref-supply = <&vio>;

                         adi,comp-int;
                         adi,alarm-pol = <0>;
                         adi,fault-q = <1>;
                         adi,timeout-enable;
                 };

That doesn't make sense to me. I don't know why they don't just reference max31827.
I am most definitely not going to accept a driver change just to map adi,adaq4224_temp
(or adi,adaq4224-temp) to the actually used temperature sensor chip. If we start
accepting that, we'd end up with no end of
"<vendor>,<board_name>-{temp,voltage,current,power,...}"
compatibles.

Looking more into the above mentioned repository/branch, an earlier version
of the dts file did reference adi,max31827 for that chip. It also looks like
there may be an adaq4224 ADC (per drivers/iio/adc/ad4630.c), but that would be
a SPI chip. It seems highly unlikely that a SPI ADC would have a separate I2C
interface connected to a temperature sensor. Confusing.

There is also some indication that this may some IP to be loaded into an FPGA.
which utilizes an FPGA implementation of max31827 (or maybe connects to one).
If that is the case, it should still be referenced as max31827.

All that wasted time because of "let's provide as little as possible information
about what we are actually doing" :-(.

Guenter


