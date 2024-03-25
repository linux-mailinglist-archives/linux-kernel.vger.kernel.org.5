Return-Path: <linux-kernel+bounces-117551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FB588AC87
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CB1B322A27
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2D813C68D;
	Mon, 25 Mar 2024 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B53U9hgr"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638D4131197;
	Mon, 25 Mar 2024 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386600; cv=none; b=nen3fWbmUTkKJ+61WrlJy357m+8mWw4b9UfTP4Gvc5/1KjINz9bsOWqWhGcg6NWoXkFEpjEJ6oT/Ham+xL2vr5PrhkR2iusZ50rbISWEL6I6vXgiR1uKzVwAOt0/1wsThzZwVE6yZf2NXTqaAWhddoRIk2quyG/ZqVQyfFcSI7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386600; c=relaxed/simple;
	bh=YYsUWM/tc5SeUoHr4SM7DaEmyCrtZcmNDHBKWCAyVKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffUm3VXerFfX4Cp96ZK7zpLYYOcM+Sbsp30LAJXneAPZc8J+Y0NhGqCAythPNpN5SFN3VlvWChL52D5gADprPNNEm/yzD6/a94MsWFpUVFlhLsS3Xs7nOSH/A8sYYvRJbTvnTjwVFF/joASVxvt+qLWOU1FWcHjt5D+2PuDdJJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B53U9hgr; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1def3340682so37418155ad.1;
        Mon, 25 Mar 2024 10:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711386598; x=1711991398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=wjUCJkKZuv4QABVruZUXU7AMHix+bUA6P/btPvQspXM=;
        b=B53U9hgrdy65Yw49U73DUH2hIm3taNps8ajYoR2KbZ4KrbtK/6G+19fjYrwRM8Qgrl
         5p3r62qVXqTafxtkHKo8oJxH6OuQLuLwr95mCtX4jHQufZPBgNnH247JChebFADQJKPG
         FruT9S+edf/MaO/m0L29yTggxBVlOKBoXji+qwFH6+FqHcg+ovG3KFIka5U06QaqMCW6
         x0dfPaqsmKO9fwoHVXgycIWZ6ux2q4idfxJU0Ohwb+QY15v/Ctp8LK1+IC2zKSB35hvy
         mpgLJIVY/FrTRGdqMnm3o/ePL8+OvJYcjDacGVvz2baKIoGYNme+VkjCIpzEO/xDYIW6
         EoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711386598; x=1711991398;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wjUCJkKZuv4QABVruZUXU7AMHix+bUA6P/btPvQspXM=;
        b=bu124fMsqEWrGcJ2qgBOaOcwopZNaeybB520YtkAHcXw2MUpz7B/c6OVyC5PjGl+LW
         xO5bllHYX2gpy9tpqcSGaXxQi+X5JVGJmvRpm9b4LNvT6wMJ9tfQyoR9rl5Xgv02ootK
         WewWBRjuCpHsr/40Yrqxl3jOFMWlmOIHKiMh7C4+mzocvAx1Ukhs8nIa4EHhTkBpN8vu
         WKiWfYDCvbnusssv0HqcrQKQlhsy5nXvSytG3eS+xN3zWjcYPZ9FXIkf4/am0vQR3WAY
         JkDbLtYqqb/E8fxgnlyLsOJcBynVza+LrVeggbYarQDz81Up8asxYp1jRa+rDmq6lckV
         zkNw==
X-Forwarded-Encrypted: i=1; AJvYcCU3H81q658CbVNJTnwXkIIUBtS+MGQOuGjXxVY7eLXcqY83yYsYq2BdmUrWcS1ibCDQnebHkYmzuwaVt77Oy07E/OJLeVd8/JHqA2tXl+myKjVz4bP9x1huBFt3DsjwCX0zlY1yWrWYoOfNFwHR50kTuxXRXeRBj9cGTFsJh6V+0Haa1w==
X-Gm-Message-State: AOJu0Yz+1NsK8PeMPIw0Z6lmGToD6a5WHZfl84PN75IVaPy7HMMBPMhg
	pGnQhy4MGbhk9EDBq1/aeQ1NxxPCauzwAWr56ugIBD1fEgd64pF/
X-Google-Smtp-Source: AGHT+IEDaLeDy0kRHXxCSaq6QWBKsSlojalNjSSiXu+JQvzdRSJOsl90GPyDIO89QxgnGaatm41OIw==
X-Received: by 2002:a17:903:50b:b0:1e0:2344:e8fa with SMTP id jn11-20020a170903050b00b001e02344e8famr7768437plb.66.1711386597546;
        Mon, 25 Mar 2024 10:09:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id mo12-20020a1709030a8c00b001db717d2dbbsm4927085plb.210.2024.03.25.10.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 10:09:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <22fcad13-dd9b-4e9a-90aa-d20fb78e6a0d@roeck-us.net>
Date: Mon, 25 Mar 2024 10:09:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] dt-bindings: hwmon: Add NCT7363Y documentation
Content-Language: en-US
To: Rob Herring <robh@kernel.org>, baneric926@gmail.com
Cc: linux-hwmon@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
 robh+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net, jdelvare@suse.com,
 kwliu@nuvoton.com, kcfeng0@nuvoton.com, Paul Menzel <pmenzel@molgen.mpg.de>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Bonnie_Lo@wiwynn.com, linux-doc@vger.kernel.org, DELPHINE_CHIU@wiwynn.com,
 openbmc@lists.ozlabs.org
References: <20240322081158.4106326-1-kcfeng0@nuvoton.com>
 <20240322081158.4106326-2-kcfeng0@nuvoton.com>
 <171109961635.307786.7810067768607811171.robh@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <171109961635.307786.7810067768607811171.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/22/24 02:26, Rob Herring wrote:
> 
> On Fri, 22 Mar 2024 16:11:57 +0800, baneric926@gmail.com wrote:
>> From: Ban Feng <kcfeng0@nuvoton.com>
>>
>> Add bindings for the Nuvoton NCT7363Y Fan Controller
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>> Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
>> ---
>>   .../bindings/hwmon/nuvoton,nct7363.yaml       | 66 +++++++++++++++++++
>>   MAINTAINERS                                   |  6 ++
>>   2 files changed, 72 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml:
> Error in referenced schema matching $id: http://devicetree.org/schemas/hwmon/fan-common.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.example.dtb: hwmon@22: fan-0: False schema does not allow {'pwms': [[1, 0, 50000]], 'tach-ch': ['']}
> 	from schema $id: http://devicetree.org/schemas/hwmon/nuvoton,nct7363.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.example.dtb: hwmon@22: fan-0: Unevaluated properties are not allowed ('pwms', 'tach-ch' were unexpected)
> 	from schema $id: http://devicetree.org/schemas/hwmon/nuvoton,nct7363.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.example.dtb: hwmon@22: fan-1: False schema does not allow {'pwms': [[1, 1, 50000]], 'tach-ch': b'\x01'}
> 	from schema $id: http://devicetree.org/schemas/hwmon/nuvoton,nct7363.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.example.dtb: hwmon@22: fan-1: Unevaluated properties are not allowed ('pwms', 'tach-ch' were unexpected)
> 	from schema $id: http://devicetree.org/schemas/hwmon/nuvoton,nct7363.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.example.dtb: fan-1: tach-ch: b'\x01' is not of type 'object', 'array', 'boolean', 'null'
> 	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240322081158.4106326-2-kcfeng0@nuvoton.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

I am a bit puzzled by this one. The patch has a Reviewed-by: tag from Rob,
but then Rob's bot complains about errors. hat am I missing ?

Thanks,
Guenter


