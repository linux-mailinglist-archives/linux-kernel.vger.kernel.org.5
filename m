Return-Path: <linux-kernel+bounces-107075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3163F87F73D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559A81C21A35
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6C17C081;
	Tue, 19 Mar 2024 06:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jufOFVkf"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF25557885
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 06:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829415; cv=none; b=WXu/KyBAn//YaPsv+XrbVdOTx+dzXo/JnNfJcgW7i21MdsjcQ+TZ3mTDbrsLmBTOpYgH50auB3GY9Z1uGZvjeN8f58rlNDBa+JeNDPQwob+ugMwYNC+AoAzS8b7ZFwOe7WGj769KG+jE9CCJUbdsekpaOBG5/xafdxRWnL93XEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829415; c=relaxed/simple;
	bh=scEcEIEzZ0aWaiYpHzhB264dKydY3VU30p8I2kOBawU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3vGkfYpjwSaf2WpAGNA1p30MlEiSIFszO2am666lhfFEUIqBaKixXbhNERDxlk1ep79MBpgt1wcnr/4ROb4yrmcC+wdC5jnZHGAXeBIc40aDyMSt5RDyEYAsRLKG2JUJCuXAGHfy4AK4s72054VD4h12wnJ/7lI9F8D6Qz7u50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jufOFVkf; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-568d323e7fbso2616233a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710829412; x=1711434212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oRDwYwdIaGbhs9kf+z2mnHg3QHKmO5pIvmImbZULt4I=;
        b=jufOFVkfNXVhTgdbfW8m7j5WeDS8DfDrca4Uks9WoLWIzp3AFAwHZA1YnnOUUFqQs9
         PxFzJvMj7yARTShsNAjbHlPurNQdRYorp3ReqDK7SaaMYFp0oIXyTPSNcIoQZS9W3r9+
         gz61I99zDm0/LB3na2SV+tR0IW75aVAUTE68vr8/nK8RWAeipeQ6+UbnQby60BjvHOZr
         Lfhs75Xez3srp8S7A8uIiE7Fpm9u9kVmzgyHwJKVHD5EbfoRSbS33rS03IJmozZHQSo8
         SSKt7e4FqqzEsCqHZBqzsBXygwWS8ggM6XO4GDnOCeMCPMwI8x9YUwkOHDf6c8HCZeu7
         jYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710829412; x=1711434212;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oRDwYwdIaGbhs9kf+z2mnHg3QHKmO5pIvmImbZULt4I=;
        b=DpMLNEbyCxPIjW7TbQbnBGYwbOitP1mqCZZKdDPCFk3MfBM4D7PPFvNpM0wbPwU43B
         sbGYX7a5yBiw1rr0Ayq6B2qFVNaJQp5H8tAiB/Bh8AcQ3LPLntBgR58vYzXtnJuLe+ut
         eSRgtZIMUOZS8Y/sDI6vjxSeqw+3LPriJF7+pbN4rZglZrNzlc29PcpxgEpRUnp8PJlw
         ijS41a0h0zhldiIuuFCHQU1N885CZ4XHoegknLmnSqOIQ2HRGlvK95xNgzGrpiErp892
         94zTPYidR38wM+ByyNWDhgZqiqCqf1rWhH8NXMSIu+Q7pxnEwatzti1QHj2j2sz6KMAi
         nlHA==
X-Forwarded-Encrypted: i=1; AJvYcCVHPzE/8aIq5Mn5j8UH60ObAzE0fj6Tat0QTM+zFfNB3VVLj4iIeJAzLwxm7atKoo3mHiZs9xxhnjkfY7uQa9lkLl5RJVkikVl0nZai
X-Gm-Message-State: AOJu0YzyGjHPkwiwz+KgzjqjhXSbE+jZFrHTGvjq32yXdX7YYV0CEyVD
	YqTiZx2ubUgdsf2HmPXafQUVDPxR5as3c9CKnKvcqYp1GH08xHCEheFEAq7DOdo=
X-Google-Smtp-Source: AGHT+IEposXk9KOXdDGmLySMXySBXtk5WMymxUzb8uB0ShwVCi5mJQqB0ZTcFFPSLExwhSrrtHldcQ==
X-Received: by 2002:a17:906:b109:b0:a46:cea5:5e7e with SMTP id u9-20020a170906b10900b00a46cea55e7emr2091061ejy.52.1710829412303;
        Mon, 18 Mar 2024 23:23:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id l8-20020a17090612c800b00a46aab70226sm3302072ejb.180.2024.03.18.23.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 23:23:31 -0700 (PDT)
Message-ID: <0c1820fb-fbc0-4aae-b0d4-b5bb5c996377@linaro.org>
Date: Tue, 19 Mar 2024 07:23:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] media: raspberrypi: Support RPi5's CFE
Content-Language: en-US
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Naushir Patuck
 <naush@raspberrypi.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
References: <20240318-rp1-cfe-v1-0-ac6d960ff22d@ideasonboard.com>
 <28754b32-35c7-4285-a610-3e101da41047@linaro.org>
 <c6526c63-3e8d-46f3-abc2-3cc513617161@ideasonboard.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <c6526c63-3e8d-46f3-abc2-3cc513617161@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2024 07:21, Tomi Valkeinen wrote:
> Hi,
> 
> On 19/03/2024 08:05, Krzysztof Kozlowski wrote:
>> On 18/03/2024 16:49, Tomi Valkeinen wrote:
>>> This series adds support to the CFE hardware block on RaspberryPi 5. The
>>> CFE (Camera Front End) contains a CSI-2 receiver and Front End, a small
>>> ISP.
>>>
>>> This series is currently based on multiple other serieses:
>>>
>>> - Sakari's "[PATCH v8 00/38] Generic line based metadata support, internal
>>>    pads" for metadata support
>>> - Laurent's "[PATCH 00/15] media: Add driver for the Raspberry Pi <5
>>>    CSI-2 receiver" for a few new pixel formats and imx219 (for testing).
>>> - Jacopo's "[PATCH v5 0/9] media: raspberrypi: Add support for PiSP Back
>>>    End" for some shared uapi headers.
>>>
>>> And to run this, one of course needs the basic RPi5 kernel support plus
>>> relevant dts changes to enable the cfe and camera.
>>
>> Which makes it impossible to merge. Please work on decoupling.
> 
> Yes, it's not for merging as I wrote: "So at the moment we cannot merge 
> this driver, but hopefully the dependencies will get merged before the 
> reviews on this one are done."
> 
> I believe Sakari's and Jacopo's serieses should be very close to 
> merging, and those should satisfy the needs of the driver itself.
> 
> The DT bindings example uses a header from RPi5 base support series, and 
> if merging the base support seems to take a long time, I guess I could 
> drop the include and just use numbers instead for RP1_INT_MIPI0 and 
> RP1_CLK_MIPI0_CFG. And change those back later when the base support is 
> merged.

The problem is that your patches cannot be tested by automated tools.

Best regards,
Krzysztof


