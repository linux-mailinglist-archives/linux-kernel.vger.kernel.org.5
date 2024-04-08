Return-Path: <linux-kernel+bounces-135263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA0B89BE15
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C41B1F221B3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06511657BF;
	Mon,  8 Apr 2024 11:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I7qamzri"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C1269E07
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 11:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712575449; cv=none; b=i86CaHbz3iqYGbA/mtGFaNz6J+J8wGgKR5sVOp7MfxQXt05G4hESN+CNZMqOEJ2rUOeQQAiG45GW4WOE1gRa1GrXnkX/Pb0siTacP5Wp5MSoGcEO+lJjktBNd4Gfy2lmRlGvVe06LqsvALbVpmTZFWxm/jXbW+scSGQzytFIoek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712575449; c=relaxed/simple;
	bh=Ic/7/DM23Rd/kWbEg3juZHfkWoQX0PYQWWsl86MtFBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z74BwzrbsEq6DtGng2C2Q7gkWSk+oKc4J3TvLyPIjVth3exXtXdSLHEx5jk++ljiLr0tuYLyiFQaVjjFjcweBCYe8qPryFo0mPdhbFjROr6h935e8yYswXQc3JmMyLxnYcOBLvLf/hLccpEOZLttVFA9et11LmVnybuEwdNOdAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I7qamzri; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e69a51a33so355846a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 04:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712575446; x=1713180246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sK7OHqfwRvH573O9S1+R+RNgS/5sB7rQeFWZyzeqabc=;
        b=I7qamzris+mZFnqoMnb7gTny74JuMReY7mKalvoQVN9lwRd8aERlqAYdlNlKA3dwcG
         bRR7nrnU/HkHP7+vkE+CsPxsM8I+Ex2XDZznKN9nG2vkYq2me2qI2Td6ANQLP3kbPWBR
         ZblVt7UNjtazGjr/pJzylg4dxwecYAoTJ5wW/x7rtLk8ynmRJX/OTJnNJ8eHmp9pYwTE
         SZgep1eV/t4Cyl4DXbFDbYn2GYFboQQxYjQyNIc7nNqD7Lyr+9pZjQlo5SImsVRrnemP
         FEfPP4pciDz10OEqZ3/s3fJnAtSRqJIykTq1Bkh68XYMLOGXMlEFf+QvYSpaPsgF1cjA
         4+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712575446; x=1713180246;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sK7OHqfwRvH573O9S1+R+RNgS/5sB7rQeFWZyzeqabc=;
        b=m0g6BgiC24GSaTtbDhCHmoCfM0GbXTG9JOsuNhQmwNOmUEb1VZSHZTqhJqVvPr7txK
         QXBVKpteWYD7xdgZE07C1M9RgPevBXRla0TIEa21xYgZ/vKg7BnojHD4O62zk0qMIS5f
         ozSdeZt0kOac/P4NQZF2c5wxltjLp9ztMAIeGeJ1u3RXxz0el2Pt5caSRD+wx87o0YRR
         Z5GElJdN3l22xpNtiE4XZyCSIcJhyuQfNPsWhiucqqO5T+JDlemte4k5oJzdNdioEoC/
         TVs8ftJO7Q2J/xOvQ6DNFy+ElflMPJ1fqdnu0epK2ssVPxUvB4VmepjeOgeFfjBQvsnH
         yaXw==
X-Forwarded-Encrypted: i=1; AJvYcCWJH+9vFXLAim2v2QC/CDZYn20YF4To3w09pECdDjhA43YPjYmTeeAzv3eCyFMBC2Q1Df5ktdjf7JPP1qifJFySfm/eh4ZaS5EFi8bF
X-Gm-Message-State: AOJu0Yyintt+vYCnKdL6M+bLObkwesTsqw6A8d98/bIjs/h9OrbQlzfn
	FVFXyfqlQrG1IGY3exVPIqAeMRnUOrPqgv/sVZ8sgTa7WRf1igqYMv9Xd2/Z8tc=
X-Google-Smtp-Source: AGHT+IEeKXecy9FBfEYIurT1LLn0jCqJ644egnjv3VLQSzY9r4KCUf57C4bR4nP6/D3H8uvjz7cdbw==
X-Received: by 2002:a17:906:7949:b0:a51:d522:13dd with SMTP id l9-20020a170906794900b00a51d52213ddmr2076960ejo.47.1712575445681;
        Mon, 08 Apr 2024 04:24:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id gl2-20020a170906e0c200b00a4df5e48d11sm4340486ejb.72.2024.04.08.04.24.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 04:24:05 -0700 (PDT)
Message-ID: <e7841ad2-fa3d-442d-804d-51f12e05c234@linaro.org>
Date: Mon, 8 Apr 2024 13:24:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 1/2] dt-bindings: usb: typec: anx7688: start a binding
 document
To: Pavel Machek <pavel@ucw.cz>
Cc: phone-devel@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>,
 fiona.klute@gmx.de, martijn@brixit.nl, samuel@sholland.org,
 heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org, megi@xff.cz
References: <ZhPMHdt6r/4D99Zg@duo.ucw.cz>
 <ab9affc8-de68-4ec9-bdfc-02131191bc3a@linaro.org>
 <ZhPTTxI4oTF3pgrk@duo.ucw.cz>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZhPTTxI4oTF3pgrk@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/04/2024 13:21, Pavel Machek wrote:
> Hi!
> 
>>> Add binding for anx7688 usb type-c bridge. I don't have a datasheet,
>>> but I did best I could.
>>>
>>> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>>
>> ...
>>
>>> +  cabledet-gpios:
>>> +    maxItems: 1
>>> +    description: GPIO controlling CABLE_DET (C3) pin.
>>> +
>>> +  avdd10-supply:
>>> +    description: 1.0V power supply going to AVDD10 (A4, ...) pins
>>> +
>>> +  dvdd10-supply:
>>> +    description: 1.0V power supply going to DVDD10 (D6, ...) pins
>>> +
>>> +  avdd18-supply:
>>> +    description: 1.8V power supply going to AVDD18 (E3, ...) pins
>>> +
>>> +  dvdd18-supply:
>>> +    description: 1.8V power supply going to DVDD18 (G4, ...) pins
>>> +
>>> +  avdd33-supply:
>>> +    description: 3.3V power supply going to AVDD33 (C4, ...) pins
>>> +
>>> +  i2c-supply: true
>>> +  vconn-supply: true
>>
>> There are no such supplies like i2c and vconn on the schematics.
>>
>> I think this represents some other part of component which was added
>> here only for convenience.
> 
> Can you give me pointer to documentation you are looking at?

The schematics you linked in the document at the beginning. Page 13. Do
you see these pins there? I saw only VCONN1_EN, but that's not a supply.

Best regards,
Krzysztof


