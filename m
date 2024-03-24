Return-Path: <linux-kernel+bounces-112525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D34ED887B25
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 01:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4387B2133E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 00:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1AB81E;
	Sun, 24 Mar 2024 00:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mblCrbov"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EF7EC4;
	Sun, 24 Mar 2024 00:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711238557; cv=none; b=qhB7mRDX39+5rzoejonqIoRZa5Aqz+7wEeFGyEKuc1fqWlr9sGPll/xvl6ri8XmiYdxY5O6YF+sCSuZ1x3KPoJjGBysTdzHFtPH+BwKEqoOFl4dzXdCqpNZ4l94suJtwpNj+IV95yBn46eS8GCEtzm6OSVxHbEN+dI3/Tq021iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711238557; c=relaxed/simple;
	bh=Fi9jn9xhea3Eqr2Fwon3wNGvHYW3Esicm6biLdBkR+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F/YMGBftXXpyOtkUWtTiVW4NfIXQ4IpzbMsZsIPKuPP2LrYFEdo0qM2mKHOKeTAxAQ/3l5DY7t9/oRIL/5Jsn/B348QPN5bf0G6YjKodhE9lslxbhzm3WKRxa43y6mRIs6lbWqJpRkY8x097AUuz/0eIHxysdaWJtK6XHeI2C2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mblCrbov; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a46cd9e7fcaso382602766b.1;
        Sat, 23 Mar 2024 17:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711238554; x=1711843354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NrERVl7fRobrwC10yk2s2onot9WRsDJnDzX1zxJyjwk=;
        b=mblCrbov0d6HgLCOGECkakEzlVJ8vN4+W+ARF6SfS0LMBt+fKxvKY+7P9scexEK0mH
         6LI8RLLB3Bvf2405PiocW9sqz6UQizgSBfDCwMV4qISpOngNW3gufXmPW9ysOPoxx6gz
         aGAoRjtLGs8v5Vl8KODFOIveIBGsfntlPf+XoL/ms5N5ZH+8PY70fnvZlB/j4ppBz+39
         1Q2vyjOucuGjHfrUxrlw7a1OsMX2JJwfYkQw2c1YZwIhEJbf0/uskfaZdwlyQfCRCcn8
         CRjy8M+CG7M5LBNKsEiQEstIiIwwmAIAM15o3d9/pcnfkK12BTH1+zR4OBUSq68wkCN0
         3Ftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711238554; x=1711843354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NrERVl7fRobrwC10yk2s2onot9WRsDJnDzX1zxJyjwk=;
        b=Hbz/3f13jYTJDjE3e2CxOWdIe37/zz1GMraQIuIFwy7GwkP995aXIRbqPUx4bWs6ZL
         uUWc4HTe9Heot7KgJ2p6gw+u/d3jDYPt2M9k+Hxeme9pUgjV3g7UU2AR0LReeG4cGjk5
         A4AHOaeg3PTt99Ofq4kH73t5Iw5UQvX1mdsmoQvFmTAgep6Ui9YvCzbW6M18KUhaR2vi
         TLxdRNnIwZfS1CF6c2OebtrqzEgQ8MjJKx7wexwZFAytq0Sabq8thmIbZfzY91b5SDe5
         5PwzbWmJxDgQ8H3h5Izpj5t6WNcToHTkv2sB8rOhdQgtnRzarYHYLUE8/6awgqClgrv4
         MtQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEEvVSQ7Kh6MbYG1b+3laeS6xNw7pCfR3N2GM/ivRASmAriKqqGiaZVwW+Mz7fIbODO6PqXViY87VoG/uckJQsyBaaUy4Ms0ZVbn2BuFx52iqUN+j35HG9PddREGwiyUlgKd2LsD69ouFTnd8tOJAXT5CIkUUde20tL9n1TCUHACn4Xg==
X-Gm-Message-State: AOJu0Yz4DNjmUqwGPerYpeFahTxlKKH/vAcnLK4dV3tk9ePE1TtCuuH0
	6tuZxcGf7SNu/bqTp9pUjrOVtNb9QR3ynP0of68S5gvdZPyEOL/s
X-Google-Smtp-Source: AGHT+IFhO6YVTUasRqpMP/iFm84HriWglmNUAWmJyzycChzZD235X9oPbIcfDaXRaGTIhzAhvr36qw==
X-Received: by 2002:a17:906:240c:b0:a46:bd1d:d9c9 with SMTP id z12-20020a170906240c00b00a46bd1dd9c9mr2383059eja.31.1711238554112;
        Sat, 23 Mar 2024 17:02:34 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:5b00:ff22:8933:f27e? (2a02-8389-41cf-e200-5b00-ff22-8933-f27e.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:5b00:ff22:8933:f27e])
        by smtp.gmail.com with ESMTPSA id bh9-20020a170906a0c900b00a461b1e814asm1401032ejb.130.2024.03.23.17.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 17:02:33 -0700 (PDT)
Message-ID: <6e68e0ca-2f3e-41a7-bb96-00fbdadc4436@gmail.com>
Date: Sun, 24 Mar 2024 01:02:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: rtc: armada-380-rtc: convert to dtschema
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
 linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240323-rtc-yaml-v1-0-0c5d12b1b89d@gmail.com>
 <20240323-rtc-yaml-v1-1-0c5d12b1b89d@gmail.com>
 <20240323233742bfb9ba4a@mail.local>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240323233742bfb9ba4a@mail.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/24 00:37, Alexandre Belloni wrote:
> On 23/03/2024 23:46:13+0100, Javier Carrasco wrote:
>> Convert existing binding to dtschema to support validation.
>>
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - interrupts
>> +
>> +additionalProperties: false
> 
> This is not correct because at least start-year is supported. Please
> check for all your other submissions too.
> 

allOf:
  - $ref: rtc.yaml#

is missing, and then

unvealuatedProperties: false

to account for that.

"start-year" is read in the RTC base class, so I wonder why so many RTC
bindings add a reference to rtc.yaml, but then use

additionalProperties: false

>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    rtc@a3800 {
>> +        compatible = "marvell,armada-380-rtc";
>> +        reg = <0xa3800 0x20>, <0x184a0 0x0c>;
>> +        reg-names = "rtc", "rtc-soc";
>> +        interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
>> +    };
>>
>> -- 
>> 2.40.1
>>
> 

Thanks and best regards,
Javier Carrasco

