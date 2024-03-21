Return-Path: <linux-kernel+bounces-110518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C01C886005
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5700287620
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B694C13174F;
	Thu, 21 Mar 2024 17:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BxqWj9Nd"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC27712CD8A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711043236; cv=none; b=T99lVya4YedhOLFDDnAzzv9INeYAty2BQR/mC4e0VJ0QoZBJLqrO9zP2pM8i3rtBUI/aDzA22sCLShWjaThZmrg2o7dZJTN16M7201jZc+wbb/CyZx6TKzk6s4aNRv7yIfFX65j9/AThrPiy6s02ptL2BadhaKfhH/qFRgk+3os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711043236; c=relaxed/simple;
	bh=S9oSym/qSZ42XkAV0+GSoGw4x6SeoXYbiySQVABwUDs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZPfkNmJlozEu6JlRHfXhbUQ5NJ/KNcVdtmrNVPeMIwvkJIqvrs5Q7CBVnN5NQWta5GPXOV7ZSqF9nl4Oit5MFfIcUNPnR0Rh7PcSZNOy6Q0cgb104hFMFMNKymy6DHn4DP5pWWFV9DyVfoeXHi/BuP+0Ko4u1vGCxwV4OVaWCIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BxqWj9Nd; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a471f86dcd3so47577666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 10:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711043232; x=1711648032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TyD8ByCmfhEfH4mEsnzkOHa6CwjzR6nJy3ZoFzpC1YY=;
        b=BxqWj9NdFo4IBjTZKyqBkAX2cDMJmgx5UMNOnCUqO27b1cEhNW22choHpYgNr/8+xI
         09ZhK6xaG7pcnoAuUFhyQvwfmi9J35E7U07OpiH6yvgnlmPnGZH1swVHJj084GxcZ//r
         QIj/H2shmuUSh1RIGDJcOLpOom5sTfOwWrL/Qkicyqf5CXTl3463Q6L3ynvdBvYBy4VR
         y+6ttu2QWvxqyfpeccMHn+ESQuUcFFMa0n6xPM0GQsZ1EwRomQXq4ehefrhSS5j3I+Yg
         hEQrbRRiw9PCR11bs7RUxsQwXbAgWmTQDitYe8ZhkzO75nMDOnfLFSmNaG1bMhK/UA3S
         l47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711043232; x=1711648032;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TyD8ByCmfhEfH4mEsnzkOHa6CwjzR6nJy3ZoFzpC1YY=;
        b=XUfxC72kVHH3LiceXuVFyBZqQgeBW6H1uvuj7LE9wi2naVr1GShHtAdxMeVNr0G8Xd
         IatGoQPdSmLv3Yu0MKaOIyVXPn4gWxEc935wdBUhAPVbU5ApItImEanbehgpeKScKyBL
         s2GfrbMmm3vxV/EHIXEltQuWsr1vfuRHt/aqftHEwbtDPn7tsJfAGODCx/q0GkMz3Es5
         ceTBfp4wabaBM0Qi/WLfB6xICLnA8F4Jf6Cg5xoKgryaz7GtefXtzGM0xpYremyL7B4p
         ki3t6btU4sNH0mHtFxGv4eSP7kIMFIZWy64XhPhEzo7Q4V27jbxmjppmhaf9Meiv89kL
         bc4A==
X-Forwarded-Encrypted: i=1; AJvYcCWj0QfxS5iuvRIGol31v2mITKM5zaNo73sHmuZpBzaC6XUJaNOJMDKf4DVTqARArhnwfeo1CaZAM2XYbClYzREesc3dywIEZZQlv0Ed
X-Gm-Message-State: AOJu0YzPH3JTQ1KBU/J6TjNAZiCxF/pQreU57QKhVO2vQAg8VW7Je+M/
	EAmb/U/PG/vaEWEGcedatbdCUUXbKLSK391oIMFyNXDOCzz28DUOVVYxifh3J4Q=
X-Google-Smtp-Source: AGHT+IHyR11DZj5mOqLK2mDqet5maMSyJzcCWSbfeYEeNKGt+wrpg+t463EoLItJsPHwZqA5LXPHxA==
X-Received: by 2002:a17:906:d0d8:b0:a46:cee9:e412 with SMTP id bq24-20020a170906d0d800b00a46cee9e412mr106518ejb.15.1711043232190;
        Thu, 21 Mar 2024 10:47:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id a17-20020a1709065f9100b00a46478fbbbesm143207eju.153.2024.03.21.10.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 10:47:11 -0700 (PDT)
Message-ID: <babe2744-5a7f-4e51-a313-039be5110600@linaro.org>
Date: Thu, 21 Mar 2024 18:47:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: lm87: convert to dtschema
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, peiyu li <579lpy@gmail.com>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240321-hwmon_yaml-v2-0-74fa8eb60ec9@gmail.com>
 <20240321-hwmon_yaml-v2-1-74fa8eb60ec9@gmail.com>
 <0f180f62-8782-456f-b05e-5bc0a2cb7ef2@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <0f180f62-8782-456f-b05e-5bc0a2cb7ef2@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/03/2024 18:46, Krzysztof Kozlowski wrote:
> On 21/03/2024 17:33, Javier Carrasco wrote:
>> Convert existing bindings to dtschema to support validation.
>>
>> This is a straightforward conversion with no new properties.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
> 
> Please keep original Co-developed-by with SoB.

Ah, sorry, I missed remark in cover letter. Ignore my comment.

Best regards,
Krzysztof


