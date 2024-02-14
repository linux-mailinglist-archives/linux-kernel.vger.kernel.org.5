Return-Path: <linux-kernel+bounces-64951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F059854513
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 846031C26415
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E76912B6A;
	Wed, 14 Feb 2024 09:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URX3IcFo"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF02C125B8;
	Wed, 14 Feb 2024 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902678; cv=none; b=iMoyL9GSYRXGEjci47o5l1UvQ0+KvbPMzbUUxxQJh4iLc/cNaBT3E4Pc/O2FYwKqUl7XqRDGhAIsxEKmRlfqSYAXiTxnBu/1jmuv15NKN5+8uTnqU7Qii0ayEMETrJZEkzJd2bBIzGTcA93hvrXLLu8pA6qU4W1icdlpZAzi/2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902678; c=relaxed/simple;
	bh=41Mh4KpWrduupYGMz0oD5L7b3mxUfFV/Gi6M3Kps/QU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQ/n/khliYvBBpddLxpl82gHV1GyHTeHaBbz8dS5r6wrkgnYSAXcjcTCTDNpCnsufM7guM5gZKxoCgw7yA5FuMLXg1KU4lct5RKdmibr09ZfLRdksv7SkBWEHy4JAV00KaCjn1shsrZVWgEHV3rl7O4NWDzASEpOKEHZmtXE6+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URX3IcFo; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so7123856a12.0;
        Wed, 14 Feb 2024 01:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707902675; x=1708507475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=autbkFLkjIeFP2IoTWAP7V+DqrVLjHlcVKE9Dqcp+7Q=;
        b=URX3IcFoF4Lhtwc7A0uFJA4+3GnOD+ZkyMc3iZ+T/Uwu+qgc+Q5/E9UlacR3bCanq+
         KJ3Vfyxoc+5i7oFJTZu1qNKsm4ekzjwv0hlZRECeeJnQgr6XTvJcdY7sASpDzu70OeIF
         aWpvRu4Z9IR8KeuUIBTqJf5fTMWZma6ERs5aS/ynRERrTE56Zarns1LdWvHsmq+529Yq
         QL9uksyIsmqIB51SXpTLPUWlTxwOQNaFdswpgg27M1wrAwTu0r6bgqnGgTOlabFCoQpH
         c49kGSaommc80kz683luWL70jSb/l9kJngnZUAYIrMnebpoIi5nHVWsfaeEWFE8yzQnK
         zo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707902675; x=1708507475;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=autbkFLkjIeFP2IoTWAP7V+DqrVLjHlcVKE9Dqcp+7Q=;
        b=VSTIMIV66foy1SUVC4j584T8bgzsyl/tFATKQTrL5ALf1I2tArfbV+DHHxOd7uxSmc
         8PFQY7PuOwUbrzau/2E9UE3Biaw2C7epVj47w9ZxRxsgQqRL4VkNW18mFUZLFi68ZVHb
         UO5TGrAWDE+5LxoM2VAKsVlwFdzTb7+74Dj3HC34/JXXYgjc4xaozBi1jOiDNystM0u4
         m5Pc9/g39EjyDmRm9EHm9SnyTYB6PxF2fktYFAI/xPMuIuD0lXLHNbiG9STCLtlumgC6
         1qZfO5FlxUsJRErw7Rs0tv5EBDpBFwGMpP6jfb67qv6HraPkr6wNAHuApoO3W/LMdrd5
         dxCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXt0tr99dDkoamaxoC7o83oRtSUnen8BPpKNhOrtZhEYm1w/Rit3BGz7T+onwLC5vAjXalJWT8Spam+2C76KENHBjusdwDg7rSOwzFxgsvRusFI+2VUsjy+I51p+JplKvYWzyrSizdieO8DNQkcS2CkfxIzgUGZQJY7swgqNtNtX4QZtw==
X-Gm-Message-State: AOJu0Yyzc6KUVakFacHsqnxRt4b+ZG6tLT23dyBGwmuj1THjDDjB5og1
	8VbqaT1VZ6fLfSsUVvh9oYaH5wVUVfSGFZPh8FxIWzHTXI3hveyB
X-Google-Smtp-Source: AGHT+IEIRK0LiG32CesRopAhB5xn0V0/7DWQoZ3+1hg39jN/1KBKrKr4SXdEpoYMVIpPCy2AIxG62A==
X-Received: by 2002:a17:906:4158:b0:a3d:26b2:94f4 with SMTP id l24-20020a170906415800b00a3d26b294f4mr1389226ejk.73.1707902674566;
        Wed, 14 Feb 2024 01:24:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX3CDe8Xc/tATxS7T7yF2GAH4vsL09Wkp69VRwWz7CXelPz+Y3qX6mCVXQoiLVeDQjXN4B2M7OS6GeN2B2a7Crtgov9zLzWIvOlMdSYOjmaTQ1kSeeN9nW1WHcvwX9Jbaokv+jiZs+Yw5lWz7mZ/Y4enHVIoJhrLyjFcwY/vlzeIsQSgTht3lgfkPHwfBjRDdxOI4OSCHDKvPQJIbbVsmJIL/0/UhLWKCv3cVdsb6rwaD+6Cmxy/MiLputfczmnLOTqgffmeaJpCdcTOM5PjBQ87lSHA2nqCQjIwWiGT01w/uU9lPIEcuZxccYhMM6FybU5VvmIf05oXjULJGxcwcN6X66B4rmc/i3NZV5EaiMwsMlqIw1fEUOCQFBSc+y0Y95HOg44oORhyU9fiL0ZF1c+kiJTifxJdOHvGoihDF2Ir7aXXpb8s83kRYLquvlyfVMpoVqfRA+G1UiogrTcCRUO
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id vo2-20020a170907a80200b00a3cf66ec008sm1636224ejc.166.2024.02.14.01.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 01:24:34 -0800 (PST)
Message-ID: <bbacfaad-a182-4df5-8317-640e32a1954a@gmail.com>
Date: Wed, 14 Feb 2024 10:24:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: mt7988: add PWM controller
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240213164633.25447-1-zajec5@gmail.com>
 <20240213164633.25447-2-zajec5@gmail.com>
 <36baacb4-4aa9-421f-bde0-c4be7d7f4aa1@collabora.com>
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <36baacb4-4aa9-421f-bde0-c4be7d7f4aa1@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14.02.2024 10:09, AngeloGioacchino Del Regno wrote:
> Il 13/02/24 17:46, Rafał Miłecki ha scritto:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> Add binding for on-SoC controller that can control up to 8 PWMs.
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 21 ++++++++++++++++++++-
>>   1 file changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
>> index bba97de4fb44..67007626b5cd 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
>> @@ -1,5 +1,6 @@
>>   // SPDX-License-Identifier: GPL-2.0-only OR MIT
>> +#include <dt-bindings/clock/mediatek,mt7988-clk.h>
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   / {
>> @@ -78,7 +79,7 @@ gic: interrupt-controller@c000000 {
>>               #interrupt-cells = <3>;
>>           };
>> -        clock-controller@10001000 {
>> +        infracfg: clock-controller@10001000 {
>>               compatible = "mediatek,mt7988-infracfg", "syscon";
>>               reg = <0 0x10001000 0 0x1000>;
>>               #clock-cells = <1>;
>> @@ -103,6 +104,24 @@ clock-controller@1001e000 {
>>               #clock-cells = <1>;
>>           };
>> +        pwm@10048000 {
>> +            compatible = "mediatek,mt7988-pwm";
> 
> I can't take this unless there's a driver that supports your device.

I'd argue you should rather look for a documented binding rather than a
(Linux?) driver. Otherwise you would refuse changes that are not
strictly Linux related. DTS files are meant to describe hardware in a
generic way and not be driven by Linux drivers / design.

Example:
We have bindings for "brcm,bcm6345-timer" and "bcm63138-timer" (see
commit e112f2de151b) and DTS files with those bindings.
There is no Linux driver for that hardware block as there is no need
for it.


In this context I'm explaining binding thing with Conor in discussion
on PATCH 1/1. So stay tuned :)

