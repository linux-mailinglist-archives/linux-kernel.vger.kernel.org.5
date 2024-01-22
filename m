Return-Path: <linux-kernel+bounces-32700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8279B835F0F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C03C285224
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE43F39FFE;
	Mon, 22 Jan 2024 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="I3B1Yr6z"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC72D39FE6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705917848; cv=none; b=Qdp7gHPax5hqK9BzpDIU6Ei8/WOlEshw7V/sPXEWCOz9tAaKs3IWmThUpXiBSEA95A6phoZU6poS+Z09wGJIkLXKe1lTgUn58+R4ve1G1c+kOQgzM+pd07hKvVL7po8YyIVRXoWVOi8uPbcCqcjD2kizSb3DL2o61mfpr0l7OVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705917848; c=relaxed/simple;
	bh=M8pszskSh+59GT3YDDj2kTESCkFAakxa2ZaO1j5Q8Pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GfzMQ43of+BfpTcRuCsVwyAB0JGLPDVzuhxhecR7+1UPNaswzXg/FjoC2cS3RDjq9GfTi5Yp0QIb3Q2WJbOUGWox+w+2QehPuO1GcfMDWXTH3GacLZsQPm0iiHN/ETquG+tV4ff23SHe8dMwROkNnONmtYBknMHrdERAkfVMmDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=I3B1Yr6z; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cf495b46caso1133782a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1705917846; x=1706522646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ni6n5pqeZznTel6GtkjfHQ44EXROGMS+h3Fg1e6uKRc=;
        b=I3B1Yr6znb0vi9wz6wOHqDEKrWZP4rkZCZrZSss4+GiNn+XV4XipHkyIbOIA9Bn3zL
         i8MfXuHCIfKW0DtoovkckjFYvFDsxEf4bOOhPwi6OtcRMSvBtiVp0RibjWkXecDK+Xjz
         OxoeEDryvbw9LfBdgOfJpHG/KJbxfqB/yBUtDLDuGIdTzB1tHziZCB3/EItXa6db5eTW
         5IwA1/HW0HV3Nf0OoZS2f7FRCwdmtuoh1L6/tfGM6tukbf1PueulY867b38NKdADcqR9
         ojkTBqlnbXgSisnPc3blTR0AboVe4fSrISKq38IBosCLr17mRu/XQjun8zPBjXtnNjc1
         gjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705917846; x=1706522646;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ni6n5pqeZznTel6GtkjfHQ44EXROGMS+h3Fg1e6uKRc=;
        b=O3rSAVqQ0PgYBbeSMhtCZAPlwHEmToORtyDE9OOLY6yWVpVLX1aWhQuPRMUKbZ7oet
         lS0CioM9PqjAEZ5VFRN01VUVBF+y0OsRWp2DtbnSmSNHCQGMv6P5MVeM+2SBtXGVUrhm
         Q207ABVjKXENXq1IqxbdLGMvj5J2KwWmm+iBjjfLuYkHaLM4s0Kzu+7I2NCe5lJ4iWUr
         pAKEXb8ZVbajz2FJlfy6+zNj+ERQSLsbwy9CFIUIBbfJ2zhr3hmhA75mkthsM7ClDoiw
         BybKhHmSVV0WjLPJESSL/7jpyOn29svwWziBozKcxna5H4fVIA6DD+KdEwPpQyUZUxH6
         P20Q==
X-Gm-Message-State: AOJu0Yzf2GST1MJsdgABFPTirsBSyocoPRX0b9N5fT5YtcgNkZ1wyk/h
	FftPo98EyPmaA39GqGV+wAQBRTpZ1y3CSIAPXnSogX+NWQ6hoBzvaMCbAYWSFRU=
X-Google-Smtp-Source: AGHT+IFWhdobP+x4boZi7f4u5ncKwhvFSizCjj2v4j7C2QB2eYDiA0ptZEh6KxLq9DgxXVQGvcYSPQ==
X-Received: by 2002:a05:6a20:9388:b0:199:b189:eb93 with SMTP id x8-20020a056a20938800b00199b189eb93mr1581609pzh.100.1705917846321;
        Mon, 22 Jan 2024 02:04:06 -0800 (PST)
Received: from [192.168.20.11] ([180.150.112.156])
        by smtp.gmail.com with ESMTPSA id d11-20020a17090b004b00b0028cef021d45sm9304508pjt.17.2024.01.22.02.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 02:04:05 -0800 (PST)
Message-ID: <4031ee3e-9db5-4e36-8833-2f7fd6fad3ca@tweaklogic.com>
Date: Mon, 22 Jan 2024 20:33:58 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] dt-bindings: iio: light: Avago APDS9306
Content-Language: en-US
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Marek Vasut <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Matt Ranostay <matt@ranostay.sg>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240121051735.32246-1-subhajit.ghosh@tweaklogic.com>
 <20240121051735.32246-3-subhajit.ghosh@tweaklogic.com>
 <20240121153655.5f734180@jic23-huawei>
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20240121153655.5f734180@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/1/24 02:06, Jonathan Cameron wrote:
> On Sun, 21 Jan 2024 15:47:33 +1030
> Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:
> 
>> Adding device tree support for APDS9306 Ambient Light Sensor.
>> Updating datasheet hyperlinks.
>> Adding interrupt definition macro and header file.
> 
> This is an unrelated change, so should probably be in a separate patch.
Understood.
> 
>> Adding vdd-supply property.
> 
> This one is reasonable to have in same patch as the new device addition
> as, whilst I assume it's valid for the existing devices, you are adding it
> to incorporate something that device also has.
> Could also be a separate precursor patch.
> 
>>

>>   
>>   description: |
>> -  Datasheet: https://www.avagotech.com/docs/AV02-1077EN
>> -  Datasheet: https://www.avagotech.com/docs/AV02-4191EN
>> +  Datasheet: https://docs.broadcom.com/doc/AV02-1077EN
>> +  Datasheet: https://docs.broadcom.com/doc/AV02-4191EN
>> +  Datasheet: https://docs.broadcom.com/doc/AV02-4755EN
> 
> Old links seem to still work, so why the change?
My bad. I will revert to keep things simple. No reason, just thought of updating.

Thanks for the review.

Regards,
Subhajit Ghosh


