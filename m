Return-Path: <linux-kernel+bounces-144553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D81A8A47B2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C89BD1F21D6A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 05:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E4263CF;
	Mon, 15 Apr 2024 05:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSdrAQ/d"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77C463A5;
	Mon, 15 Apr 2024 05:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713160210; cv=none; b=ABl7221tmlRFfUHqdDrJGOKCucW0nyIpr/DvR7Gsjqsa9E7GpftAduEAPDU8SJNEsd79/F2eAJmPXblXN4o0N/LEZZ+7z5mu+ThCwQF/ZCguxTGUcn75s+oYwD0WfmjiMFPwFcTrt73IeXspoKNdLxXvWU/j1dbixAwo/XHK+KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713160210; c=relaxed/simple;
	bh=pKvbKUaHAMes2QG7XgOsRZ1u0RDB6CQVQg/r1585r5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4aMUjNs2c2z+iygEf4IeTmc4xQwnDkaXaSFkvRtnWJKmE1Mm3G9ykAcuvHOynVO8F6q+2itKULKqjyIT6pYc3zZtd4a3RGLWosE/LCkLBShCS/EVhZoi8AaD4F1kZ9zjQdSqFxPwUEhZnWA41fuzo7ggz3SxzA+ODvT68SMU0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSdrAQ/d; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-518a56cdbceso1744318e87.0;
        Sun, 14 Apr 2024 22:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713160207; x=1713765007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hhge6ldXd4uNBh2q7E8muCHyp1IdQgnzbXqJxMF1SWA=;
        b=XSdrAQ/dS5mq2N76cOp0DJwtkAzp4q9tmAY+V22Q+tjAFFUdVBbFg3EbFV93RFYHaf
         agUWApFnd7gtPFy7nMIXChn7AAFZqHIgmIpNNtd2YUn2RmWzwevXMu1NVYzWMX+w9YUn
         OjbCZ1EjvXh95qkGKIzWzhFN0c8xjjS3kN1NzExYLsdqoJCH51K4I3jxyPB46Z9lliVx
         Ky68j8qQeyRe7FckqjxEJBPzETDZxg/7MamfcEcr9i61hYIOHO08hQLlWm+Q0Hh18iqZ
         L2EUn+bCN7pM9ux24W1hI0nnN6+hwE8OCIPuPS9wLTO2rimXmw6kOedU3kaNpPHxw8YB
         HZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713160207; x=1713765007;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hhge6ldXd4uNBh2q7E8muCHyp1IdQgnzbXqJxMF1SWA=;
        b=AyUVI5bpSfmxiEeTBU0BopeSpyZSOLt/AO+/1o8h9Zj/ersE44fmo2EaMRvUzvVPzI
         WKeunva6wHVYiM/LGHhbe/TDHyAXOgZxb/GALXHb1FFW1KunkA0bXhF6a+TkImv1EEim
         h3IntII/YGK843YYV5bWq7xEW5dS8qrQCFUxBbtx/3gXvUQafF6wLoEeCG2pZYStKltm
         skfc5erAyOQzKrfiRtO0wX+y5I56t+/ITKi3Vx5zgx1cvqWEsvMzBrY+CjiujgLIYLuW
         Gt8/YCx7WHyLXkzxuVNxfoh/BvocebXziBv9JNM5k8pTX/QyAIqPFN4V/8lP/Er3CWNJ
         FWhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ8q9lkLhrisqZhmmB8zOTftx6Yer8RJC42i78O8u4Nl/ugs//S+/txal25LvuNooixbNivQZKJcYDEKw1I4kRIAsX7kP+9OWV5VOdKim2hz7iuxQenDydRIcCocHxqT6wZAJu4W9xR2QXeZaXxhH0nNq+pvQVh49L2HbJ8a8JPDu20Sihzng3
X-Gm-Message-State: AOJu0Yyi1mO8uJwb3G8psR0ZGLZ15GRKH52uVpNFmp9RhWvSF+F0L5ky
	BrOQRLtTRLzikv1A3VUwkDaEo+vE/qp8J0RxFLa/3AWUy9r334oc
X-Google-Smtp-Source: AGHT+IFrjmHsLQTNbMprEYNHTpIYPuiDb4tXllTV5X7b8Y1tKYnQve4QfqiDMUgJEBAHnJ7NNCIDcQ==
X-Received: by 2002:a05:6512:2158:b0:518:c9bb:ee96 with SMTP id s24-20020a056512215800b00518c9bbee96mr1855898lfr.53.1713160206607;
        Sun, 14 Apr 2024 22:50:06 -0700 (PDT)
Received: from ?IPV6:2001:14ba:7426:df00::2? (drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:7426:df00::2])
        by smtp.gmail.com with ESMTPSA id h16-20020a056512055000b00516d0933256sm1169909lfl.131.2024.04.14.22.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Apr 2024 22:50:06 -0700 (PDT)
Message-ID: <d3e555c2-e740-4aff-aac7-661877166399@gmail.com>
Date: Mon, 15 Apr 2024 08:50:05 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/6] dt-bindings: mfd: bd96801 PMIC core
Content-Language: en-US, en-GB
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
 Fabio Aiuto <fabio.aiuto@engicam.com>
References: <cover.1712920132.git.mazziesaccount@gmail.com>
 <ea49494429528cf8e60fa984ae1f523ddacd850c.1712920132.git.mazziesaccount@gmail.com>
 <b5eeaf10-e011-452b-840a-176c4f62cac4@linaro.org>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <b5eeaf10-e011-452b-840a-176c4f62cac4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Morning Krzysztof,

Thanks again for the review/help!

On 4/14/24 00:33, Krzysztof Kozlowski wrote:
> On 12/04/2024 13:21, Matti Vaittinen wrote
>> +
>> +  rohm,hw-timeout-ms:
>> +    description:
>> +      Watchdog timeout value(s). First walue is timeout limit. Second value is
>> +      optional value for 'too early' watchdog ping if window timeout mode is
>> +      to be used.
> 
> Standard property timeout-sec does not work for you? It should allow two
> items as well.

I don't think so. We need sub-second units. Furthermore, the timeout-sec 
(if I understand it correctly) updates the "timeout policy", which tells 
the expected ping-interval. This can be different from the "HW 
heart-beat" which tells the HW's ping expectation. Hence the "hw-" prefix.

> Missing allOf 

This just about summarizes my feelings when I try write the bindings. XD 
I do feel completely lost. Hence I do really appreciate someone like you 
taking the time to help me through ^^;

Enjoy the Seattle!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


