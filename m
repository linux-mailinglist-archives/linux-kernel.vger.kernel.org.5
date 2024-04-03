Return-Path: <linux-kernel+bounces-129205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C22E48966EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DBE2B276B2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0840B58AAC;
	Wed,  3 Apr 2024 07:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYM3mDUv"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B155BAD7;
	Wed,  3 Apr 2024 07:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130314; cv=none; b=Q1VwAY+Zq3vATCW+310sZnkGmvhLM+2sa2fmG9fuZkPKkoKvHDtCIPpFi+/v1Y+vxrspRFxu7GfiErcLnWUkg5uvHFJ2V3WNvCOxzuJtPyTgdyKMSFyF99PujfDGkc8F5JPgaMTnhTeHSOUIjsOIkYFYxBbZ0arBPQfhizET1pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130314; c=relaxed/simple;
	bh=yQ9j5697fujP7br6avVnORJNRKx7dOB/FgXzi8BqGxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sXqVVMzOVONxm4H0aXtEaqjBkaUgQVt1sLY+W2vQ+GDucBrCI8CI3cuUtHyD0a3eMMijR++dzzqpgIHJ14HurxtpB9yIRcderHIk9YZgdXFad+bgd6NsdasHPZpmiCppBw3MUIDi2Nj1houYMB04owp2bT+y8EEJLSzxvAjRy1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYM3mDUv; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-615038fc5baso23994117b3.3;
        Wed, 03 Apr 2024 00:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712130312; x=1712735112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FRechHCR05RNB+9I0mJA+sFff4tTP4QzQvaYkV3R8fI=;
        b=MYM3mDUvWSdp52+BSPHQYgtzqaBSv8q3gvTSutXsGECJKNOyLdcHSucanokKukVwFq
         a6L1G/NJ+73/5a4Y1ojMNFaTpa8rfFF2BtC6QgkoUuz28VjiR1jZNu4jkxl8C9niVZ9h
         CeND4VhVMgCin+qwPp56JFtPiJW+e6syC3pJOQfo4QdvkUtMb56/WrG3ttY14TcJomqL
         X+NrKYGs6Pin44Kj3BPAa3qHR+4SBlzaoj047WyM/wCFNjFedp45f8dcQ2+5OiychqYs
         TZv82SxUgUY5HPyD94GUzqWqcSNTuCNTOWdsmqB5I9lf6u4SaWjTxALaF9G0oon+MV6x
         wJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712130312; x=1712735112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRechHCR05RNB+9I0mJA+sFff4tTP4QzQvaYkV3R8fI=;
        b=QE6t9HkWS0HaExcG8nATEqtV9wsf9CWZIJQ4Zac9IeY2WLENiYtx25tom+WXTGK3IX
         y6X9nR54r7Jz33q8QOwh/qVjMfAEO2lAQ4+NUgi4c/g5wbHxDhvFGj9uEEFSOS2eRAc+
         VhrAT2jpgHL9ocgXm3T8tNZ7JbBu241GpBXmt7wDmxOLpIxQ4+e19SoO9YPxP2oprMyi
         08mnbsd79L4ypQSEh8sAmHccc5TfDi3mHFnvMZbndlqqq2UgBqH9Ar8mDDPIwNJ5rqoX
         VtruOhKnCt2UnuzB1qmcPsLmwTzRxuz0HpBcp1wLj/Xr4ObDzWEfcrJR/HAKzKYOXQzc
         x+gA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ+9X3cURcuqBioPA+XPVs3eQ85kwetBXEAH64aRb9CQFOxTfohxRtCWsaA1XMiqOJoqk1t4RSHyaaqakMKBd6Vl81zJJEJ9Q14dddKQ4pafQUCVkfbuF0xa6rqX9IJ74puD9eMEDHXwuzl0/RmYB+IC+lKGrM9tp5jvDrqPY2iHX5RA==
X-Gm-Message-State: AOJu0YxAAVwOVsyfY5OtOGQUTkMmfWAePY/u1bAsx1LZiVJuXxUV/ipx
	BKQbuRQjsbjQr5r+SApqQGgDCNdZEx5NROyp0Um0b/neGj6kvm++
X-Google-Smtp-Source: AGHT+IE/QkhgF2Px1HEyjKDBosB+4pzg1hyTDH5nbAg4XuIFgRT1cmMNoupSRWgzTb+xdgud/XXlLQ==
X-Received: by 2002:a25:3307:0:b0:dd1:64e6:2c80 with SMTP id z7-20020a253307000000b00dd164e62c80mr12216913ybz.46.1712130311909;
        Wed, 03 Apr 2024 00:45:11 -0700 (PDT)
Received: from [10.76.84.174] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id gc12-20020a05622a59cc00b0043437f34491sm1263349qtb.36.2024.04.03.00.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 00:45:11 -0700 (PDT)
Message-ID: <0db40597-0d66-4d5b-8165-d9a4c068a42e@gmail.com>
Date: Wed, 3 Apr 2024 10:45:08 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: adc: ad7173: add support for ad411x
To: David Lechner <dlechner@baylibre.com>, dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com>
 <20240401-ad4111-v1-1-34618a9cc502@analog.com>
 <CAMknhBHeKAQ45=5-dL1T1tv-mZcPN+bNo3vxWJYgWpEPE+8p3Q@mail.gmail.com>
 <CAMknhBGJt1TG0-UXMqqCT6nxJKAX7ZbsPF19eeWqwKsXbKOQoQ@mail.gmail.com>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <CAMknhBGJt1TG0-UXMqqCT6nxJKAX7ZbsPF19eeWqwKsXbKOQoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/04/2024 23:22, David Lechner wrote:
> On Mon, Apr 1, 2024 at 2:37 PM David Lechner <dlechner@baylibre.com> wrote:
>>
>> On Mon, Apr 1, 2024 at 10:10 AM Dumitru Ceclan via B4 Relay
>> <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:

..

> 
> Also, I just noticed that AD411x have only one AVDD input instead of
> AVDD1 and AVDD2. So we need an if statement that says if properties:
> compatible: enum: - adi,ad411x, then properties: avdd2-supply: false.

Already addressed by this:
"
  # Only ad7172-4, ad7173-8 and ad7175-8 support vref2
  - if:
      properties:
        compatible:
          not:
            contains:
              enum:
                - adi,ad7172-4
                - adi,ad7173-8
                - adi,ad7175-8
    then:
      properties:
        vref2-supply: false
      patternProperties:
        "^channel@[0-9a-f]$":
          properties:
            adi,reference-select:
              enum:
                - vref
                - refout-avss
                - avdd
"

