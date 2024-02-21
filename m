Return-Path: <linux-kernel+bounces-74325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE4085D2D2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DEA4285E70
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB2B3CF45;
	Wed, 21 Feb 2024 08:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kmu0AQNn"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FDC3C48A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 08:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708505364; cv=none; b=sDLwAHhtsePMXvlWCvrqgcs1+VKIQtlkELbJzMGfRKz6RRBuIsQzPBFpher5dT3n9nkIFw8vnuGvm9IfrNpahPjMVU8dob0s3swUv4fCUUT4izEzZpjNLnroRPWP5ftLBy4XMm9wHuVJBIUT0nDmzwcyEqf1WodIMCIY+zQPRaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708505364; c=relaxed/simple;
	bh=XkuaRxJkQSF/7nCet1D50bgwrru3r4Ru5QgZ3T7rMRk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=h6XlgSaTCuhHk9bFD/b9rgAYqD7NriDdYuYRNDnZ7keSHQ2Mij+Ti3a9CicCeUMivgrYd0x+SowRKmQ0MGFu9AmnCj7DdjAqjWuct4HY95nuZsMaCz4OvoScde5IZ3gcGI7wr6cwBfWjPYfrr7ZH5/PsLuEZTEWgKRCRfLnXatM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kmu0AQNn; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33d6cc6d2fcso270707f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 00:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708505360; x=1709110160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YoxlnSr09FiTnNUULYo8MqJGBOYUjcsnJwXawkN7t8I=;
        b=Kmu0AQNnPrxTB1P2eFKjhq2RVz6r19AYR9ToSkU8QYdkGcxB7o+Z2RSLau+n1NF7Ur
         8qGvdwvwB0ezE0aFuX0BZW3sw5rH/Mr1wV8kPofVF5OHv546PaPQxc7U+vTn2R+G7Ukh
         kODLmJvdMhys6SxQjtxRh/jaUeBIhfpOHZztUbjpJvHSV/zhchnTF5eR+0ISPZF/ilkX
         9akv3lI7ihpByOONLcc1eTQOtHHOT2vdTtdSeoGSTgfmiYVQGu9B6j6xUrjHQHb8vtkP
         etSDrqWj1N9neS3RjnkpZQjaUVMEyPhdYFhB9Vc/o4dlTfIoKJXRMOdhSYDAMXPhZyRa
         T30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708505360; x=1709110160;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YoxlnSr09FiTnNUULYo8MqJGBOYUjcsnJwXawkN7t8I=;
        b=m+pg0wSskb6UgCdpQTtsEjWBRd3S4pG6AfDse1lO2XPv78HKGZdz7PI3aAUruwjulk
         bC0DFrYCojXRzDSd4jLa+s/4A0h6MQn+/5+yPe/jMX+7BmusTf++1daxkfILyyxq2wSC
         j7W2UNOE6EHzd29hMLFRwRwYeIwkNatbuTeWXIESOyFMkxEzRrEd538YOgNPR8HzjM5F
         e4ye5oDo/evUAhJuVxAjZeahBFY096o48FN5YLXY8KbxvOlnqhKBFBoVUZsIZWXt73X5
         DZlovHqvN41VJMYiysmwzfk1fz+0BZaSdojvzuDqPflsiYPaTAeBub23Np1LV/elvw+X
         BbsA==
X-Gm-Message-State: AOJu0Yz25moy+E9hHkkAjdFdq4+XtVFd6mo93qi9UoUlVh82NaYH2ZxO
	+8pUs/2jDbHjID6hjxXG3pkeJnCDKH+uLipX+c2b3n+ph1FMS00iIhyz2Hu9z20=
X-Google-Smtp-Source: AGHT+IEYXaFsyWPoCNiRz2bRIoyKm0rY4vIfEIf3/J0g3R3wtKXdfDmy+z1iSFxfi1joiLdRoyM12A==
X-Received: by 2002:a5d:584f:0:b0:33d:7afa:fb0b with SMTP id i15-20020a5d584f000000b0033d7afafb0bmr1114431wrf.15.1708505359939;
        Wed, 21 Feb 2024 00:49:19 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ci3-20020a5d5d83000000b0033cf2063052sm16119296wrb.111.2024.02.21.00.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 00:49:19 -0800 (PST)
Message-ID: <ce571a9f-fe6c-4131-ab3b-cba39f537ab7@linaro.org>
Date: Wed, 21 Feb 2024 09:49:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] clocksource: imx-sysctr: support i.MX95
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bai Ping <ping.bai@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
References: <20240126-imx-sysctr-v3-0-33fe801d5f31@nxp.com>
 <225c8489-0b81-402b-987a-09a46349c10d@linaro.org>
In-Reply-To: <225c8489-0b81-402b-987a-09a46349c10d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/02/2024 09:47, Daniel Lezcano wrote:
> On 26/01/2024 08:09, Peng Fan (OSS) wrote:
>> i.MX95 System Counter module control register space is blocked
>> by SCMI firmware, so we use Read Register space to get the counter.
>>
>> V2:
>>    - imx95 is not compatible with the existing hardware, so add a
>>      seperate entry for i.MX95 in dt-binding.
>>    - Per Marco's comments, the global variables was removed except
>>      to_sysctr. And add a new TIMER_OF_DECLARE entry for i.MX95
>>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
> 
> Applied, thanks

Never mind, I did a confusion with another series. V4 is actually applied.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


