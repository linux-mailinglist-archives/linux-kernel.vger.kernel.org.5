Return-Path: <linux-kernel+bounces-139338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1958A0190
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE2471C2247D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD33181CEC;
	Wed, 10 Apr 2024 20:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5mz7Hi1"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5670A181CE4;
	Wed, 10 Apr 2024 20:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712782596; cv=none; b=HwE33K2730IChBQZ4khaIjKDP5sg27g5sKkAsLA83A0gxSPkEMii1wUHQur5boRTAwwxMwkKAbpTAtias6zIxxtXNiNsIgpyVa8m0B6aERnrzlJIb5qXppXZmrkHm0LOGbxqKQ9sFQmpBpRSEOUZMwcucVKxfSP1dP+fEwTO53o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712782596; c=relaxed/simple;
	bh=HttKY0qnnuIp1B46BCkW9CViIzey5yRdx3Ik+SH7UQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ujMcv5QEd5WoylBC65Bc5WChqzYAzapojQuQsFj7+9P7DrfdiPu9mCUNpt27FWAO20WkVjKx/FOGICOMtxZpAjtVRExEsRn7xeMQn6zHDRaHAhYj6X0zUyzrG8Os01XYsu8kE8i1m1jTLdTdK1gCtdTcQEFyRFkI8X4geGABqjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5mz7Hi1; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516d0162fa1so8631655e87.3;
        Wed, 10 Apr 2024 13:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712782592; x=1713387392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=velTxyDyUhfVt0WKozw2xszoAn3uVnpWZ/SVMLGjm+c=;
        b=h5mz7Hi1CoxCWnSgGWEs2vGpzB7cvT7AaoS6eFLSbcjFwx9YSuFM3l+XIT5rqK/l2u
         b6jxUu7LEWj5lcDLWt0UVwVLJXHYCiuJNGzIaNTxqr88RWkSUUUd/xkViDkMsH6iug0H
         DJoSAH95HB5C+E9cFfvGfmgJh6hKJ9cRgiNWnnBmHfGPW8Pp1sY7UYHdwSzjBUJ4iRpj
         gojW1kP+hADH9jTbYGs2vRqw+DmDvoX2NwzKG76JHRk3sdpTtRqCOkgT1cseKCcBlSXT
         zVWEHGRQC2lTwf6A4eWMQWp1B3vFPSYze4JziIk0IdP424sXUz3a6O7e4qVCJzKAzRtr
         WMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712782592; x=1713387392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=velTxyDyUhfVt0WKozw2xszoAn3uVnpWZ/SVMLGjm+c=;
        b=Ys/dctz4cnCCpR8kNtLsjVYQKFibRdlQHRB4KTL44+JcKRlmRUoGBEgSZRksC6IbN9
         rdi7IJPEvToPE1yi9tpy6vjSI1XtRZfeIIl9Gk3oFm0THv3L1GKSFPOAczTmdJAUbwTr
         VvYRW4Udt44nAIqTseZm7SuxaRiTXGX+cBN+ZqvqUkCWYzJUUd6vDT9NYSWtCaxNMVPA
         3vt3VIIzyenVin7V+YDenzECLfqJDvClp9+NpCinccnP6zmmF5Iq5+uJVqhosFL10Ugg
         4gfr+LvVRLOqV2yFcmgi/4CUWmz11NPK+RkeghdprNG//LWbFzK99dID4t5iO4X5c2cx
         yhFg==
X-Forwarded-Encrypted: i=1; AJvYcCW8QgohPzECOa7wD+1x/XbH+4ycA0pt+jv4Cg9mOoyMVAcsMuEFhvDX4kmwKO7skZHbZfvbPfLtSYevHxw68ZWmeCyvSXRxGiCwdiaTfolIPw1ZDuBMMdu7Gl4mUDVu0/0Yf/KrfXq1mWCl7wuQfu/mLUSpc4HlxC7Xw85oI2YVuA1qxg==
X-Gm-Message-State: AOJu0YxdZyMhKhowjLiL7BBbha3xHFsPBPWPuyu7EiHx1z4/E3HRMnQf
	xcjCuMDIxZ9DhpssIoumPytVel5ixxLdT9l2ZVjOM0xtJE5Y6Ndx
X-Google-Smtp-Source: AGHT+IHU+2lp+CqY9Y0dbETJpEetgTV/6YxYcG7h5rkJpRV4Z3ndf35dDAQDagEP9Qz4ZQNHrtFv9w==
X-Received: by 2002:a19:f50b:0:b0:513:aef9:7159 with SMTP id j11-20020a19f50b000000b00513aef97159mr2555020lfb.39.1712782592156;
        Wed, 10 Apr 2024 13:56:32 -0700 (PDT)
Received: from [192.168.0.31] (84-115-213-64.cable.dynamic.surfer.at. [84.115.213.64])
        by smtp.gmail.com with ESMTPSA id gv15-20020a170906f10f00b00a517995c070sm51166ejb.33.2024.04.10.13.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 13:56:31 -0700 (PDT)
Message-ID: <6d1f0fbf-ea53-47e2-92e5-131da010be0b@gmail.com>
Date: Wed, 10 Apr 2024 22:56:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] dt-bindings: rtc: lpc32xx-rtc: convert to dtschema
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vladimir Zapolskiy <vz@mleia.com>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-rtc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20240410-rtc_dtschema-v2-0-d32a11ab0745@gmail.com>
 <20240410-rtc_dtschema-v2-2-d32a11ab0745@gmail.com>
 <202404102043571b7450b5@mail.local>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <202404102043571b7450b5@mail.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/24 22:43, Alexandre Belloni wrote:
> On 10/04/2024 17:55:34+0200, Javier Carrasco wrote:
>> Convert existing binding to dtschema to support validation.
>>
>> Add the undocumented 'clocks' property.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>>  .../devicetree/bindings/rtc/lpc32xx-rtc.txt        | 15 --------
>>  .../devicetree/bindings/rtc/nxp,lpc32xx-rtc.yaml   | 41 ++++++++++++++++++++++
>>  2 files changed, 41 insertions(+), 15 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt b/Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt
>> deleted file mode 100644
>> index a87a1e9bc060..000000000000
>> --- a/Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt
>> +++ /dev/null
>> @@ -1,15 +0,0 @@
>> -* NXP LPC32xx SoC Real Time Clock controller
>> -
>> -Required properties:
>> -- compatible: must be "nxp,lpc3220-rtc"
>> -- reg: physical base address of the controller and length of memory mapped
>> -  region.
>> -- interrupts: The RTC interrupt
>> -
>> -Example:
>> -
>> -	rtc@40024000 {
>> -		compatible = "nxp,lpc3220-rtc";
>> -		reg = <0x40024000 0x1000>;
>> -		interrupts = <52 0>;
>> -	};
>> diff --git a/Documentation/devicetree/bindings/rtc/nxp,lpc32xx-rtc.yaml b/Documentation/devicetree/bindings/rtc/nxp,lpc32xx-rtc.yaml
>> new file mode 100644
>> index 000000000000..62ddeef961e9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/rtc/nxp,lpc32xx-rtc.yaml
>> @@ -0,0 +1,41 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/rtc/nxp,lpc32xx-rtc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: NXP LPC32xx SoC Real Time Clock
>> +
>> +maintainers:
>> +  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> +
>> +allOf:
>> +  - $ref: rtc.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: nxp,lpc3220-rtc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
> 
> As I explained the clock doesn't really exist, there is no control over
> it, it is a fixed 32768 Hz crystal, there is no point in describing it
> as this is already the input clock of the SoC.
> 
> 

In that case the first approach was right, and it should be moved to
trivial-rtc.
I made the mistake of mentioning the driver and what it does not
support, but strictly talking about the device description, the 'clocks'
property was pointless in the dts where it was added.

If we leave it undocumented, the error I discussed with Krzysztof will
have to stay unless the 'clocks' property gets removed from the dts.

Best regards,
Javier Carrasco



