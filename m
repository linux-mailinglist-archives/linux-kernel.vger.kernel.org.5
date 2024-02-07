Return-Path: <linux-kernel+bounces-56684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 012F784CD8E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD4A8293494
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF73A7FBAC;
	Wed,  7 Feb 2024 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/tmqBGO"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591C97E77B;
	Wed,  7 Feb 2024 15:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707318059; cv=none; b=Jxc8ogO+AlTH1078j83ta+RpYQgE/mJtJaCMVbOxNXO+IyQcZJZHI6I7ZZ0030WOofNVmU7R2kc8PbNqcmeTFXNyXyaxKuXVmJIbgZNgswMnV3zgKho5ox4KNjkMPiWoPCqfFT/DNJ1KTuVKC4bIKMWD8zhZaPcmKCJ/ZSGNQDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707318059; c=relaxed/simple;
	bh=ARoNHjLL7llqpYFs5KYureGvLa2fiWcX06FJCHdRk3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H/msx4r9BRtT2/vRc839ZSBNrO+t1uQ1ra8VcsiIG/4Dcw5EGBuXW6XkiU/IeK7NSa2VXEaHi4SPzYbjEZQTLDdSUMWjB/q7BjIJS/YjlYhMxy0wXaMgyrVMB1jt2BHnqhaArwxo/CG2EsAPOu3SXV4hhlH00lsTq2G9P4KAUt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/tmqBGO; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-363dd27c082so1984755ab.0;
        Wed, 07 Feb 2024 07:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707318056; x=1707922856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Bf5IEcCL1X+M2EY5Ge7f4EYwZR9SnAQHYVr+IK+58ik=;
        b=l/tmqBGOEzHtfoKLLBhZGNsXL3BsDY38V9KlXYIPR9eXGamTM8QDkgtnE0In7bSG1W
         KunZXKUnKR7NGo27Vh9FfvQIL/cVELSX9t+6hAyJI+L7DeTGf7A72L5pavNecqvNgwsr
         nK51UBXZpM1QO93+ul9p5RX6O75ZvYnP8dKLpAvMrxC+acY+NpeuQSGEyDLqdONm9Wd7
         OlG0xRpL2XjcIaPwQmO82xiNmo5SQDkApSbP+QIWtv8bQ5jrvPFFM9s8xHIDRDglE9kN
         210Iq6RsU+/beK6x1gNR0dFBp3eYarTdQfy988ZGj+7NgPRjiHFW6R8mUV7o5Je+yhu6
         Fenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707318056; x=1707922856;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bf5IEcCL1X+M2EY5Ge7f4EYwZR9SnAQHYVr+IK+58ik=;
        b=Xxg1iksbIbH0hbQqPDQHnasealX+bLqI40gYWmk0AcC4Kao8WJTcl7bPcMfse6YhzH
         lSvQxmm3Jm4kPiXz9jDXAA+/WPuIFGvCTbcsvy7Ss8TgO9BvZ14thPWTI+45ctiU3C2p
         MyaOfJg2Llqknf22vlN5NFaIZ5fAf62ZMZ7T3P5nPVt+Hd3mAVFkTPp73LnhML0xEAqp
         3POL2g8jPDKtzD+0Q5sk/gWy49DL7BsMuxYq29aC3ZDFXDuqvpCMjqPX+vHhVdb76ZcM
         yT4ilFal75owf+1gGFMLbwxoPEemx/WLHIPI3ysjXXnlDZgv9hYfIhfhQdBpgGN/QRcG
         rtnA==
X-Gm-Message-State: AOJu0YxKOq6q1GAvWyS6V3G3wHKPT8MxF4pyWHLW+CicwVeBo1TY4hvN
	lbleerh4L0S4CqOKgPA47Yoa0cH4PA27ovuDjBk7FlVzXKJ8I4ke
X-Google-Smtp-Source: AGHT+IHLjJaPoB+Qy8JIVvVtGD/IMwQBIt0g39Hr6E+SiQT9JpiOsT7w6Hubday1EjHCq3GVdm9CuA==
X-Received: by 2002:a92:d20b:0:b0:363:c386:194a with SMTP id y11-20020a92d20b000000b00363c386194amr5260318ily.25.1707318056245;
        Wed, 07 Feb 2024 07:00:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUuYuz7mtxjg/My1BjbrP08UrSgsebotpAJIEZxwvxsyRVGv3SYYq151kXn6yzdUoFIqWfI2R5lhtigxf4hw+oC7zJu1+UrJCJfj/XpQ5vlJbatKzRXy/ZbKCkVeJUXpDUTYwRU5cihFzDXqplKC1jajvotYKWBWUnbQ+9u5kYLlh5PYZK2onPa7otfjJCNoZkAL6eqEVr7jtLKVyrgwwR09kBMtlk+Ow0/jSCTbLZmTXAQub2YTLx7kiZlB9am860BBBQmUfx9vMSlLymeOV0BF0pepaIggEgBw12SjFSuFmVgByfmvp0wHODbK0hgWDiFEAuCz0q2zF9YDZeIiX5MWc3eiQBWRxNE4xrgvkdwDGo9oIIzk/a5ojPwHkxRLi0vA+Eb+GTrJcaS66DR2OcZCIndZ2t/AUFPnXfpXr3SUTZ+fU0gu5SDSbKU7+n1pajnBVk+uHMolgLWZLxtsU8ta9BY9Ct8FZ7I1xQE/KqS
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c126-20020a633584000000b005dc1edf7371sm1654074pga.9.2024.02.07.07.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 07:00:55 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <392dbedc-6b5b-48f6-a7f2-94a2aa6bbc33@roeck-us.net>
Date: Wed, 7 Feb 2024 07:00:53 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] dt-bindings: rtc: add max313xx RTCs
Content-Language: en-US
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "jdelvare@suse.com" <jdelvare@suse.com>,
 "noname.nuno@gmail.com" <noname.nuno@gmail.com>,
 "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
 "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
References: <20240202025241.834283-1-chris.packham@alliedtelesis.co.nz>
 <20240202025241.834283-3-chris.packham@alliedtelesis.co.nz>
 <aecd80a3-a017-405f-b77d-6deda67ef704@linaro.org>
 <5d4b7fa1-5cc2-4a4a-8fa4-d2c7a8d070b7@alliedtelesis.co.nz>
 <20240206211237d9192660@mail.local>
 <e7a21789-9253-4185-98ed-e335d0167df4@alliedtelesis.co.nz>
 <20240206221644f524816e@mail.local>
 <CY4PR03MB3399844E78F84B6CFA18280A9B452@CY4PR03MB3399.namprd03.prod.outlook.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CY4PR03MB3399844E78F84B6CFA18280A9B452@CY4PR03MB3399.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/7/24 01:54, Miclaus, Antoniu wrote:
[ ... ]
>>
>> The max31335 is not available
>>
>   
> Indeed, the max31355 datasheet is not available yet. This is also stated in the
> cover letter of the patch series for max31335.
> 
> It was an urgent request from a customer to have it mainline as soon as possible.
> 
> If there are questions about the part functionality, I can definitely help.
> 

It seems to be quite common for automotive chips, though, that they are held
tightly under wrap, making it all but impossible to properly review their drivers.
I have observed several times now that information not available to reviewers
resulted in bad or buggy drivers. This isn't about willingness to help, it is
about the ability to understand chip capabilities and requirements.

Guenter


