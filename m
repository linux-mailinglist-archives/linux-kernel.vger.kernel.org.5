Return-Path: <linux-kernel+bounces-110671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3026788621B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA1DA1F2179A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE47135A41;
	Thu, 21 Mar 2024 20:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S62aIT41"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A012DF84;
	Thu, 21 Mar 2024 20:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711054471; cv=none; b=dg353gR1nR222Tkc5KbhF5DJmDU/BwVUfEL7BOUkAGoQXWIJ/JoUbwkfyRuhpmgpKP7aRLj0MWaueD8DFL6tkH3mu6wiyth13ThX30ANsJtbIstCqeaLy9pLJx71rkk9HLVhEDXnfX0BSMFCxAwx7Q7kOPciCD+q8j0GQDOAVjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711054471; c=relaxed/simple;
	bh=mjDg7wzzBQCmz5jgRMm1V55TPwPVl9hYFeFJAZQ5Fhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PVgqGQtYv44fowJtikN7CYVCoZotDx+FzNcW0HFMb4Aru7VgEPQ0JH6RZsZGD0lvw5Rj7iAPMatPXecn4OkXhMsks9DZssoGLGaBUsWOkn6xCcglkppAZhPLvr/gPQW6TdiipzAi/uRwSgyuUlyW5A4DZa4eZiIJLbxRABxFDw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S62aIT41; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-513e89d0816so1853446e87.0;
        Thu, 21 Mar 2024 13:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711054468; x=1711659268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4dpqtSWJGyTeUnxqugJzMO94Z9iV/f5bgYjvchhbNxE=;
        b=S62aIT41CKMejP4Jx1oxEyKBWGx6K88G0mabjcf/8nRtsOflE9Pv381ZO6LK2o6O2V
         FtQP6HncXJjpIO4N6o4kUkYEtUH20ZhX+Q3n22b/m1kuZNouamMFBmetN6BigwJAWVVZ
         pn3ez2uOBHmT5sOXeQUem43AgRVGfKQG8io9xkn16wFi43PPWdXd/G9cBOVChcsVIfT2
         b6ZXhAnVv0+yhtnTEz0/1VQ6ozw5bDDQglQ1tSwF6VtNHq4Fc+JoS5B3W1Qokkk99SFQ
         rOncIby5jc4P2htZboWDUsW4zT9SLw0MsWhyCKODK2NdEFGBMsFNV0ybfCaZNXbc5p81
         qgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711054468; x=1711659268;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4dpqtSWJGyTeUnxqugJzMO94Z9iV/f5bgYjvchhbNxE=;
        b=jvWI6kfOXgWNFtP/+pL1WclsnhXebqAZohOtIiQGKUhv6a7T4R9v6SPUXzlSCJ1aCt
         7cw22Md/wuZNwBkHaLms9D1VcewHklNlnPOKm7Seuj8UUpCD2Q810/D7J/72kLv/7ijJ
         Kz0XjQEQJaJIZF9JSnttbJtujYileMzMHiwTwivBVtNeLiKGUBVW3A8yG8WLnU1wE8tJ
         vJbQF0Y0KMWi6Qcl8t9R0Pw2+R1DaIHE5jheSMTxBN8pegw/PHL/o+nduHg4RFfzyLO2
         8MZz818RWOptcpwaJ04I+qSx13vlutKc7KbUDJnMfN2XWc/kcKQ202jfL0etbtFzFKC5
         9oCA==
X-Forwarded-Encrypted: i=1; AJvYcCWeI8ERfbTYvDQjrJEip/ogbCDY+OJAY5ajEUcncmvov5pbQGKJDw6IBKBZLMtzt6c/45nS7FLj+kl1e2WrYbvz6fiq80L6pMHa0N672PUOB5KqL/nMVnAFhko1ihShmdJxbV+RL36uMbT9h3sAW8oOe6Bhsy1ApPk6M/JltBl0jCuSMGOt
X-Gm-Message-State: AOJu0Yz37n4k3D/RM2R6lb5Y+DgjGPaWSZPH8pRPeu+7kpCYpUnRTIQG
	2P3Te+NvE18TO4vrvd4M7VYBJo0MqSH1zmC5dT5SmfDIRO2sEtLe
X-Google-Smtp-Source: AGHT+IF00jvltcjrS4QawwDsCnX+RLKRo6CEUXlNmaAZkEy6czLuI6rU56WPSUMOFR9qHZGoD99mGg==
X-Received: by 2002:a05:6512:3051:b0:513:9e13:6403 with SMTP id b17-20020a056512305100b005139e136403mr390726lfb.21.1711054467418;
        Thu, 21 Mar 2024 13:54:27 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:9fd4:5a72:5943:9800? (2a02-8389-41cf-e200-9fd4-5a72-5943-9800.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:9fd4:5a72:5943:9800])
        by smtp.gmail.com with ESMTPSA id gt32-20020a1709072da000b00a46ee5b9aa1sm302555ejc.90.2024.03.21.13.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 13:54:27 -0700 (PDT)
Message-ID: <469068f9-b219-4d80-bab4-cbffaa04a67d@gmail.com>
Date: Thu, 21 Mar 2024 21:54:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] dt-bindings: hwmon: ibmpowernv: convert to dtschema
To: Rob Herring <robh@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-hwmon@vger.kernel.org, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Jean Delvare <jdelvare@suse.com>,
 Conor Dooley <conor+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20240321-hwmon_dtschema-v1-0-96c3810c3930@gmail.com>
 <20240321-hwmon_dtschema-v1-2-96c3810c3930@gmail.com>
 <171105391076.2619280.17497439995032037227.robh@kernel.org>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <171105391076.2619280.17497439995032037227.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/21/24 21:45, Rob Herring wrote:
> 
> On Thu, 21 Mar 2024 19:43:43 +0100, Javier Carrasco wrote:
>> Convert existing binding to support validation.
>>
>> This is a straightforward conversion with now new properties.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>>  .../devicetree/bindings/hwmon/ibm,powernv.yaml     | 37 ++++++++++++++++++++++
>>  .../devicetree/bindings/hwmon/ibmpowernv.txt       | 23 --------------
>>  2 files changed, 37 insertions(+), 23 deletions(-)
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/hwmon/ibm,powernv.example.dtb: /example-0/sensor: failed to match any schema with compatible: ['st,stts751']
> 

Obvious mistake, this compatible belongs to another patch of the series.

Will be fixed for v2.

> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240321-hwmon_dtschema-v1-2-96c3810c3930@gmail.com
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

Best regards,
Javier Carrasco

