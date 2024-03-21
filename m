Return-Path: <linux-kernel+bounces-110150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31351885AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3F5D1F22A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C756A86649;
	Thu, 21 Mar 2024 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPm2ZRNE"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E7586271;
	Thu, 21 Mar 2024 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711031305; cv=none; b=VmOENcByQMeACbjwHR+8jJtee0xryeTZjoEy4lxjR79iEk9fI5a51fn8IvvNHQk0y6lrDWGWx9blgbJUyZTwLKXdrKbKr9k7J6fr/iFVBczlXtLroN/mjF4pteyhxeahpUUolMZe7w5+JddYm2LnCfnDvyAPlO++NWRQCIEp1ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711031305; c=relaxed/simple;
	bh=5VyWOKfJHQTAoUhC9rpC9wpC7eFj1iKEu+Ew4sWv8oU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jN0sUnD1DHSgl83MTbjfPap+l82yLdKfs4Ni6O1DL75g71i7qL8tnXEUOD/b6ICDvM9REuoAlpsUV4QC+WeOV8ec8AsWSEB/MIEBzI+zgqus7E8INLhEqaKCvpctyFsiVTso+YI0fNvS1Yd85/d3CiTPO2VxYTKnY6WoiytieuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPm2ZRNE; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dee27acf7aso7012615ad.2;
        Thu, 21 Mar 2024 07:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711031303; x=1711636103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tOVIBrP7Nnxh24kd1RxWEpJ2f4kYqrQ9QS83PJ/qVZI=;
        b=CPm2ZRNEj+N7sq3wWnFdo7Ny+t5owq+LViy+BI3OreDDGDFqa2jF4cqisQi6Lcadhn
         ej7ltNbBIvgdwAuL55+0rPQAxqfQiMcrypIhYXdpAcye1c8cyCTBVB13JHwx28TGF5xP
         SPmwBCdgLUl1+kXSe3z/ky1XO+fDU5MMsoNe34iMsG12zo7drYbJr9Xwxi0ZqFCaJHrx
         YXfbKjF6VVhBveg4uerNkfTHWTTjdMT7nRwfekPOHmAMYxXcqVgc2kCPlVakNfV9nRSZ
         HocLuoOcd46P6cCBdl1IYMjpvSf3EsVesPcZMvMxBJcSNsyWEGkES1vl4MatbBVgXqY4
         yq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711031303; x=1711636103;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tOVIBrP7Nnxh24kd1RxWEpJ2f4kYqrQ9QS83PJ/qVZI=;
        b=wklVn4xzpI4uEGi5s1cpBSU6Y6jq0IbQV8j5TtYCBfrBqikeO/q1cWPbSTAE5jrswQ
         SDETHhYLAn54+8n0A3i68v497fZkkpxp0Fz8hLc+zcCH67W/HQAb/VRxdjAtudFYccxI
         1Y+OcsSeCkbxFewRXcbMV0Ukwp8dGKX2LakBAtcjTtn4SO49PIVd4+lXeua7jZSAX5Jo
         80UXfxIV5sAIQGIYTZOU7R8Jv/4pI+YsxghqrOEIMUaRlJ8iNzfT+JXkHNrpsO39JSHK
         FuPNVq0UyIJFxbi0pOfV3M6HxPiWBNeEFqWlufmClKkuSr8bhDNd6JEs4XZmUlQcHHZp
         NyjA==
X-Forwarded-Encrypted: i=1; AJvYcCVSVF5xlvjGXYHIcwysT9uS6Po3+p7mq19wprvDAeQcwDSNcK4pM144+v4EI6fz+JJ9Yl5uK14Z16viDpX76qLR00VbeofzJFFMdSvEH7KsFvBOV3ibCTfupTbFWsn8yR08JQXkgbGCT0DzXXzV5X/eINVZgM+ZGuGTJg2/mzJWUneTXKM=
X-Gm-Message-State: AOJu0Yxn4ltgAXayary1x67RP6BU2ndLJ7CWfqSn8Mbm90u0C4TcllmM
	5+6lHlxiBI7xPliEwLhq08Ty8dt1Y43aTf56/WWnGVvk4QE3MZ+Z
X-Google-Smtp-Source: AGHT+IE3aRl7Ql8sashV4+BVUVpj5etL4QZu6RNYH+g19G/nmvwlGBqgxPJcdddb/P20lL11Oo+ARw==
X-Received: by 2002:a17:902:e5c6:b0:1e0:2a5f:5e21 with SMTP id u6-20020a170902e5c600b001e02a5f5e21mr6694303plf.26.1711031302716;
        Thu, 21 Mar 2024 07:28:22 -0700 (PDT)
Received: from [192.168.50.232] (FL1-125-193-23-126.chb.mesh.ad.jp. [125.193.23.126])
        by smtp.gmail.com with ESMTPSA id s3-20020a170902b18300b001e06cc3c3e9sm2214417plr.234.2024.03.21.07.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 07:28:22 -0700 (PDT)
Message-ID: <067fd40e-e3f2-4929-ab74-36d8e863d23a@gmail.com>
Date: Thu, 21 Mar 2024 23:28:18 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: leds: add LED_FUNCTION_MOBILE for mobile
 network
To: Rob Herring <robh@kernel.org>
Cc: pavel@ucw.cz, lee@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
References: <20240320124431.221-1-musashino.open@gmail.com>
 <20240320124431.221-2-musashino.open@gmail.com>
 <20240321135502.GA1637678-robh@kernel.org>
Content-Language: en-US
From: INAGAKI Hiroshi <musashino.open@gmail.com>
In-Reply-To: <20240321135502.GA1637678-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Rob Herring,

thank you for your review.

On 2024/03/21 22:55, Rob Herring wrote:
> On Wed, Mar 20, 2024 at 09:43:16PM +0900, INAGAKI Hiroshi wrote:
>> Add LED_FUNCTION_MOBILE for LEDs that indicate status of mobile network
>> connection.
>> As an example, "Mobile" LEDs on IIJ SA-W2 indicate status (no signal,
>> too low, low, good) of mobile network connection via dongle connected
>> to USB port.
>>
>> Suggested-by: Hauke Mehrtens <hauke@hauke-m.de>
>> Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>
>> ---
>>   include/dt-bindings/leds/common.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
>> index ecea167930d9..d4b8498bde7f 100644
>> --- a/include/dt-bindings/leds/common.h
>> +++ b/include/dt-bindings/leds/common.h
>> @@ -91,6 +91,7 @@
>>   #define LED_FUNCTION_LAN "lan"
>>   #define LED_FUNCTION_MAIL "mail"
>>   #define LED_FUNCTION_MTD "mtd"
>> +#define LED_FUNCTION_MOBILE "mobile"
> Why doesn't "wan" work?

To distinguish the LEDs of mobile connection from the LEDs of wired 
wan connection.
For example, IIJ SA-W2 also supports wan connection via the ethernet 
port "GE0" (WAN) in addition to mobile network. If "wan" is used, it 
may confuse users as to which connection the LED is for.

BTW: _MOBILE should be placed before _MTD for alphabetical order, I'll 
fix it and send v2 patch series...

>
>>   #define LED_FUNCTION_PANIC "panic"
>>   #define LED_FUNCTION_PROGRAMMING "programming"
>>   #define LED_FUNCTION_RX "rx"
>> -- 
>> 2.25.1
>>

Thanks,
Hiroshi


