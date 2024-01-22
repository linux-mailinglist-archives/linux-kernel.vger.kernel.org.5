Return-Path: <linux-kernel+bounces-32704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A93835F20
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DA581C245EE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A2F39FFA;
	Mon, 22 Jan 2024 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="OfRjt8QW"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED78A3A1DC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705918063; cv=none; b=fXSM2M4fXR/ykcK1J3w9Y1U7aD1yRtlROjvKuuC2dqNkSYwy8bGZJth7KLpBQVm6IbGau8itEMAY5UDG2CrAcB09pNXwjWlJfDomvzVXare8g7J8P44YhcIZH+7SMqjmH06bfmfxUSjqdwpLP1ME6gdw1mpwpUnVNvomEfR5Yvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705918063; c=relaxed/simple;
	bh=7hfseNti4KOg7rK9baauGbMNt7pApk4b65kBVK61lRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XiEPnuFpRFnoUJSfddO579KsjRRGvziFZuL8of250LRfBIyHMCqYnAyl9FS1UaInC7m4Qpu0oyOa5mdZqty6J432VSxEbbmUnAkyLdg+9/oF/fYGcFuvKOScc85rKirQFWM8G9OWK+etw0N7wqliH/CClciGW4ye54V0f6Q44sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=OfRjt8QW; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6dbe3fc1421so227543b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1705918060; x=1706522860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7SZ6TVtvqO7xS+FN5Shbzs8pDYcUTB61xRBtZe0By+M=;
        b=OfRjt8QWrGSQCDS9EbbbtG+FrNaVTL6vPTnUtshkgbUB19HjnZEumH4sKuKYnaN1Zx
         FsLKoKGueE/+xeL9S0a/cGimMfbRuPbC/wnRry43IaV1n9NxGSfhnyJkMLEueO1q+z59
         CmNev0L+hFeNv9F3GW+7LBImF9OY5yVBZmshcXSecGloHjovUvtrAzyKomeEDinJ6h3n
         HrEK9glHVQLoQsZd4JJzoq6nr5uiOsY9rar0li+QnkYMILC/v82Rp/9XkqKuIftvIu13
         6QY6vADYa8GXc9M5LKyNY8fDS21KwImF6NozidqSiSf5LdtGiPilsBELp8DcUMFNHtIS
         Tekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705918060; x=1706522860;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7SZ6TVtvqO7xS+FN5Shbzs8pDYcUTB61xRBtZe0By+M=;
        b=CLVKSOlD9dDYAcUsgKA+6HH25Vmo/qM80Igsw92tT131KPSr5a6DikGiNa42qFlDEp
         OFQkOk/BajJMHvNKV1OMmB1RX98gsBIdvI/ZsGnaCmnOYahf7woTN16FvSTwQrFNBgUC
         kY6vqmBe14kQgpUVxS0cgCrGQvd5HTrlKF19KhCk3CZAM1HARI8r70QY/gWkGwUJzvg5
         vDVfHg+e6nqQjJA7rYcbmyLQTRzemSTHDn/hGV+v3n/h6pRynj6ygkmC9cO6Pe5j56CS
         W+V6EtikOucTuPCMdtZiAmMt2mJrXWRsw30cqFDG79vEkcWteoQgedpjCmSXArNquilT
         Nibw==
X-Gm-Message-State: AOJu0YzN8glCA8PqhOGZybcImEQUQP7hFxxiBNZqNdD38Ck0YogHPrfm
	7Zh+bY2OK5p69pDgHYmwi16LD1/l2lRZjz8mzFljaLkOPFO4p5ByCNcGN1D7RXY=
X-Google-Smtp-Source: AGHT+IFOmDwDqyifPwJRFILel0xXFOZg55zuqJ0ufInqRPYJxdwGgQjTGWuazVH1pqkRIehl9L8Msw==
X-Received: by 2002:a17:903:1251:b0:1d7:657:8ab1 with SMTP id u17-20020a170903125100b001d706578ab1mr1864860plh.76.1705918060314;
        Mon, 22 Jan 2024 02:07:40 -0800 (PST)
Received: from [192.168.20.11] ([180.150.112.156])
        by smtp.gmail.com with ESMTPSA id w14-20020a170902a70e00b001d75c26e857sm811322plq.288.2024.01.22.02.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 02:07:39 -0800 (PST)
Message-ID: <478fc1b0-aba4-4f36-bdb6-bf5fc7eb8609@tweaklogic.com>
Date: Mon, 22 Jan 2024 20:37:32 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] dt-bindings: iio: light: Avago APDS9306
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Marek Vasut <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Matt Ranostay <matt@ranostay.sg>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240121051735.32246-1-subhajit.ghosh@tweaklogic.com>
 <20240121051735.32246-3-subhajit.ghosh@tweaklogic.com>
 <a317aeaf-6b4c-43c9-b5d6-78d93ba6f9af@linaro.org>
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <a317aeaf-6b4c-43c9-b5d6-78d93ba6f9af@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/1/24 20:21, Krzysztof Kozlowski wrote:
> On 21/01/2024 06:17, Subhajit Ghosh wrote:
>> Adding device tree support for APDS9306 Ambient Light Sensor.
>> Updating datasheet hyperlinks.
>> Adding interrupt definition macro and header file.
>> Adding vdd-supply property.
> 
> Why? Do other devices have it?
Are you referring to vdd-supply? No, I guess, haven't checked actually.
If other devices don't have, can you suggest the best way to handle that?
> 
> 
>>   required:
>> @@ -33,6 +37,8 @@ required:
>>   
>>   examples:
>>     - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>>       i2c {
>>           #address-cells = <1>;
>>           #size-cells = <0>;
>> @@ -41,7 +47,8 @@ examples:
>>               compatible = "avago,apds9300";
>>               reg = <0x39>;
>>               interrupt-parent = <&gpio2>;
>> -            interrupts = <29 8>;
>> +            interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
> 
> Separate change.
Understood.
> 
> Best regards,
> Krzysztof
> 
Regards,
Subhajit Ghosh


