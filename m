Return-Path: <linux-kernel+bounces-49930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 643BA8471B3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4891F26E87
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CAE77654;
	Fri,  2 Feb 2024 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSbWDl4/"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C4417C77;
	Fri,  2 Feb 2024 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706883274; cv=none; b=sMcq6tqkJbcYBrZlb31uP4D8bJET9L4M+26HvdG4GxF5/3HaYZjUJDMMq0H9gcV2OGO3WeDgASh+2FGVUE8dVsgFKK9kCXtOG7zYUbP3oGRKuR36ZrNR03m8P0RJVGOK4NS4Zfm/N9Kf9fH3jp4K9/m5GYyFj+3z4ECgqQa/dns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706883274; c=relaxed/simple;
	bh=C5tLL27iIQxX+amUfUB+Z1EmnJFC/bDDHpDbQN19W2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RzZn9UQoAjh7RfzKQg0/m2lIGV49wFpJr7o8/G6wyYZvVcBnp7fIem29/nnLIWib5Ick0xlA8RfjquIGi3HVL3ktH14iWHIuDrrWq56I8TS4YQLw4EN9fzPVj6ajR+EFIHCGSyTTVmTiPRLAJuO1hrgEIHWOXDyL294X2s27xwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSbWDl4/; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a35e9161b8cso297949166b.3;
        Fri, 02 Feb 2024 06:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706883271; x=1707488071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=irCw3zpBrNbMdCCI+5/zv7b6mFMiTslqVJwC0x/tloU=;
        b=kSbWDl4/qWUZbYqnYE1E1jLcpEN4lVJaeCjYx7/cwoMXWxh+Cf5ClS//i0zdrbaicX
         UuUh/J1bcol2i2Rj/Z2xgB8h5+bkiOkCsWttCtwW/LfjMctWKipA7UyUuDI3orgTvnHz
         9xQ4lfRMKAmt3Pw8DLsSgL9jacFig1AzZeV5i2PSkC2tdbGKn/YFGsL+9C+p7JPsIy15
         PGXMHbi6DTd+nWf79NwvOeM4kQ4mpiR9z1UNsikunerlYzDLxtl8EpYsgiM9gpsP32iY
         DbDTuwBBeq/BGs897OGTUmFHr1jdG4xA5tXLdNjQ956sXnMbWe4ELrwLucrUP5Nd/io0
         b54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706883271; x=1707488071;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=irCw3zpBrNbMdCCI+5/zv7b6mFMiTslqVJwC0x/tloU=;
        b=CRq28bQHN8FEJvaOha3EWuFCwm6rkXbEvM7tzu9EoMCVzrYq9wjTr3HyH4uOKzQpZH
         UFhrIhEbFARF2/h/uMSzcA/7fvuLx8/cZEe9A8OE0DD4+pgtiBgMbGXgJey6Qjo4grY5
         mGfcBHeJHRu0ptogL0QvjVGFODocOhtA/vcjM9H9docGdRx7tGNY+FrAUJmtBYb/kVXp
         kgeSdAqmzf/aMYjZ9TFPYXDuxBBWZeHQj+uoOfst9UJnvaAH5CaZhldmcOzAAOtyL9BZ
         zHhjVuD59rhAOl4N48EpgHY2p30Hs4rzyYJIUyd5ai6JHO1lDfvCH8RH8g4dg/QfSfKt
         uwyQ==
X-Gm-Message-State: AOJu0YzMt9zh8qJ24xZNOUDpJfW+JQl+yc2sYRcasC/nC2SOKFqySsfb
	+1hYbBH2opl+2+1w9M/Kqo0irZI1JtMmqdATEeOJkS/m2OFlaD+s
X-Google-Smtp-Source: AGHT+IGXu5yuShbHAAlbDv3gd8502iOHA/BULQnnb8k33KOkCXPoYueFh482YFzfe2tcLMeq5EV1FA==
X-Received: by 2002:a17:907:6d0b:b0:a36:7327:410a with SMTP id sa11-20020a1709076d0b00b00a367327410amr2038816ejc.58.1706883270537;
        Fri, 02 Feb 2024 06:14:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX2zZL9rtqrSy3klM25W0DZ6fxR0WNci2tOV/obUHwd2ByRz/E1kIpWviCrT0TfFEbMOXneXeAO72ZIqsbnZtM5vGSUvIgGhJtXrvDPA/ecC1j40IBloIj3RsWU7sRBijY2gJI6VboY0jYgB3kNm2otC1F4MvtbzzV8RuvMo5obiq2FEBQsGpoetOqc0GMUeopYRxVHG4yLDTMsUwHmbv9AmEcwL84l2nM6ph1H0j5v7/OGCgsSWqKKpFsaLbygv81RVhcvxCmfDTrmHEW/0ISOIdqraBgc0WecydQGVyszyQuSglTKM+Pi0Gowp3saEcvAuzBQx2W6MjJ14boOkbZfoPnwS8dikMs=
Received: from [10.76.84.182] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id st1-20020a170907c08100b00a35aaa70875sm925219ejc.42.2024.02.02.06.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 06:14:30 -0800 (PST)
Message-ID: <09cc2ecb-b73f-495a-9196-dbb4899f4c85@gmail.com>
Date: Fri, 2 Feb 2024 16:14:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: adc: ad7192: Add properties
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Alisa-Dariana Roman <alisa.roman@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Alexandru Tachici <alexandru.tachici@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20231114200533.137995-1-alisa.roman@analog.com>
 <20231114200533.137995-2-alisa.roman@analog.com>
 <c6ca5a25-2d41-4a46-95a5-eb994c4cf529@linaro.org>
From: Alisa-Dariana Roman <alisadariana@gmail.com>
In-Reply-To: <c6ca5a25-2d41-4a46-95a5-eb994c4cf529@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.11.2023 22:29, Krzysztof Kozlowski wrote:
> On 14/11/2023 21:05, Alisa-Dariana Roman wrote:
>> Document properties used for clock configuration.
> 
> Some background here is missing - otherwise it looks like you are adding
> new properties...
> 
>>
>> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
>> ---
>>   .../devicetree/bindings/iio/adc/adi,ad7192.yaml        | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
>> index 16def2985ab4..9b59d6eea368 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
>> @@ -80,6 +80,16 @@ properties:
>>         and when chop is disabled.
>>       type: boolean
>>   
>> +  adi,clock-xtal:
>> +    description: |
>> +      External crystal connected from MCLK1 to MCLK2.
> 
> And this should be input clock.
> 
>> +    type: boolean
>> +
>> +  adi,int-clock-output-enable:
>> +    description: |
>> +      Internal 4.92 MHz clock available on MCLK2 pin.
>> +    type: boolean
> 
> This should be clock-cells and clock provider.
> 
> Unless you are just documenting already used interface which you do not
> want to break...
> 
>> +
>>     bipolar:
>>       description: see Documentation/devicetree/bindings/iio/adc/adc.yaml
>>       type: boolean
> 
> Best regards,
> Krzysztof
> 

Thank you very much for the feedback!

If I understand correctly, there is already an input clock in the bindings:
```
   clocks:
     maxItems: 1
     description: phandle to the master clock (mclk)

   clock-names:
     items:
       - const: mclk
```

What I wanted to accomplish with this patch is to document these boolean 
properties (from the ad7192 driver code):
```
	/* use internal clock */
	if (!st->mclk) {
		if (device_property_read_bool(dev, "adi,int-clock-output-enable"))
			clock_sel = AD7192_CLK_INT_CO;
	} else {
		if (device_property_read_bool(dev, "adi,clock-xtal"))
			clock_sel = AD7192_CLK_EXT_MCLK1_2;
		else
			clock_sel = AD7192_CLK_EXT_MCLK2;
	}
```

Please let me know how to proceed further!

Kind regards,
Alisa-Dariana Roman

