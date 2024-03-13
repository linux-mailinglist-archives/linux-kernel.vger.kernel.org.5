Return-Path: <linux-kernel+bounces-101692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BBA87AA9B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F240AB21D80
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C53047F46;
	Wed, 13 Mar 2024 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCJlhXp4"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D997C46542;
	Wed, 13 Mar 2024 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710344700; cv=none; b=a0dZafWK6d8yyHyRjjVkZarLjvFTj5JO0vY2yT/fE4+5xWov7OruFjUyVepOAvZq9vmUtHXof6Bd01XWJf7tkYdmAkstNWhToUrqJ7nsaQ+QISAmon97XE1Zbb/AP/CmQtPa+E8lQyZV3gBq9G9ihTQyyQEC0r9u6yAiZk7vjMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710344700; c=relaxed/simple;
	bh=LH7ZEG59+iIy7RtL0sW3+enVljanvZQhTqpxoXUooT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qdb9WeDI65kY8Z2brxSJiZONIFBeMUANotYFwGYr8QFI2bQUryXwYju0bBizAZwC67HxgRQT/gnofQg8qfGwZefNk57rUORFiNKLW0ebZk1MfxDZBuiqTeh89BdikqxoRgQwpYQUb5ldf+aDzLjLne2l/tnG09k+rzExHpaem6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCJlhXp4; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-568307fe62eso7396364a12.1;
        Wed, 13 Mar 2024 08:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710344697; x=1710949497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZZbw7L5uSD+BOeh64uEzemiVW3Z6bMdu9+1+cxN8JvI=;
        b=VCJlhXp4oDQzaEJ5va1xUVFmh6TqJU2rd0b/fzyR4PkVt6ryVxJW/TvBFafUnSPOib
         wzew3rfvW5xwIqa34L1UNF59Vq5V3Mb7ug5z2r1h4d164H8gXM3QC1ojN9ILk4t6dh1i
         9as0bpfnaNV6Jfh9xVhsdejCC03eHqQ1i4IXCSjGz45psH475cd3wGUtnzmtfvPWW/by
         QoyGK2vHuRAcs8IqWYET05KGgf/ZhyhK70v5FlLKT7Jd6fIhltA4oShbPtwED03IL2PA
         Ja9jbezrCklZsT3r4zFZP8OY9r64Spikozg2304nUAGyXVgimkNQzk77wr8ZT7Lh/uub
         ziRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710344697; x=1710949497;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZbw7L5uSD+BOeh64uEzemiVW3Z6bMdu9+1+cxN8JvI=;
        b=nT/3zM0ry2uYuBLscvUY2YO+k7bFygu2NSvlcIZKhvGRzOC+rHphu0dklVO8eLzOt2
         2a2VZ6B0g3Qru+fcCboux00KSD0apen+JYNICu/x3m48OLxVh0JIadpLs2Xd94xIGCzK
         RTGkeqxuLvHto8Vtv0Oa7tLwxfyncLEMtcVNKJJtSLjpw/BYBandsFxGkXFbsWKule9O
         2tD8h5qHZ4qSLkuGGXgjIOfdw5Z+XiO2VkVf7/y8wArKYg9VgE+oR5ohICKep2mMcegU
         wugQz/nUqP9ftKYhoAGxTZSCY2p9nwNtv0B7bxODOAroX6JLyxxmFxppdKqCULPT6yYV
         bjsA==
X-Forwarded-Encrypted: i=1; AJvYcCXjHqVm58kMn4Vzj0zOFglTkhtWqdfIJDflWu8et+cX6/3hwVz4BZhy7tStWG0l8fW6AilB6djQcp4IFjDRnaRor577n4EbCzh1X7drJ8BtjxDCCVISX6/2aH0CBbWBXSjl58HGCRJDBA==
X-Gm-Message-State: AOJu0Yyx/IX7xRjRRSJxlLdAVODXNBVFu4wGNMOKh5fVyCN65sKNVfxk
	9SQpifmdKxZTU8WOVV0x7S7wTYy4LdbkAgxF76Y794viPFyq3WTnPGPwmPjs
X-Google-Smtp-Source: AGHT+IFaKBZnOcyfCzW7+Hn/dVGI5KPw2JKlgWj5gNIo3GYyYysV3HpM7FFGsmZf4mfBhNVrdG5Yrg==
X-Received: by 2002:a50:d794:0:b0:566:4adc:45ac with SMTP id w20-20020a50d794000000b005664adc45acmr8668585edi.8.1710344696974;
        Wed, 13 Mar 2024 08:44:56 -0700 (PDT)
Received: from [192.168.20.170] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.gmail.com with ESMTPSA id e12-20020a056402104c00b005686037bc12sm2988096edu.29.2024.03.13.08.44.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 08:44:54 -0700 (PDT)
Message-ID: <fe8a758d-b417-4c37-9520-3b44e243bde7@gmail.com>
Date: Wed, 13 Mar 2024 16:44:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: add TP-Link Archer AX55 v1
Content-Language: hu
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240226-archer-ax55-v1-v2-0-3776eb61f432@gmail.com>
 <20240226-archer-ax55-v1-v2-2-3776eb61f432@gmail.com>
 <6cbc2741-db0f-4acb-a9e1-45b3df1292d5@linaro.org>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <6cbc2741-db0f-4acb-a9e1-45b3df1292d5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Konrad,

2024. 03. 12. 21:37 keltezéssel, Konrad Dybcio írta:
> 
> 
> On 2/26/24 18:12, Gabor Juhos wrote:
>> Add device tree source for the TP-Link Archer AX55 v1 [1]
>> which is a dual-band WiFi router based on the IPQ5018 SoC.
>>
>> At the moment, only the UART, the GPIO LEDs and buttons
>> are usable, but it makes it possible to boot an initramfs
>> image on the device.
>>
>> The device tree can be extended in the future, once support
>> for other periherals will be available for the platform.
>>
>> 1. https://www.tp-link.com/en/home-networking/wifi-router/archer-ax55/v1/
>>
>> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
>> ---
> 
> [...]
> 
>> +
>> +&uart1_pins {
>> +    /*
>> +     * Remove "gpio31" from the default pins in order to be able
>> +     * to use that for the WPS button.
>> +     */
>> +    pins = "gpio32", "gpio33", "gpio34";
> 
> I believe you can even shorten it down to gpio32/33, 4pin uart
> screams flow control, and I'm not sure if it's there only one-way

Thank you for the tip!

The board only uses the TX and RX lines so I have removed "gpio34" and the
console works without that.

But since I have no documentation about which GPIOs are assigned to TX and RX, I
did not stop here and checked the other two gpios as well.

The interesting thing is that the console works even if "gpio32" or "gpio33"
gets removed instead of "gpio34". It also works after the function of all three
pins being set to "gpio" instead of the current "blsp1_uart1".

This indicates that the pins are not related to UART TX/RX on this board at all.
It seems that "gpio20" and "gpio21" are used instead, and the function of those
must be set to "blsp0_uart0" even if the "blsp1_uart1" device is used.

It is quite confusing. :(

Nevertheless, I will send a new version.

Regards,
Gabor


