Return-Path: <linux-kernel+bounces-79538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4CA8623CB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 10:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308481C21636
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 09:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6455C1AAD7;
	Sat, 24 Feb 2024 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UyDIdvUq"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF841862A
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 09:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708766120; cv=none; b=osChQpQ6cel75VrfCIM9RFsrS74C/fKC44t1r1nYHaBKosy2ddkpENhTJCR2OvzSCxnG5QGpcP5bwbo3tk/bfik8TtiDTLepMtLXvX1C5mQYN7GEMUW9RLK64Z4ZiMqK6de6PATIV7mZFdchVYXzi/ksCsPpcRNukqKAt65mohA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708766120; c=relaxed/simple;
	bh=dtqxodcmJ9SBC6Rj+Mp5ZONU2KSQy+STXTzwUWZtTyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dSSG4og3Mp8ZVMWwBXLwUGllfA5UYV/6b957jIhnCO7GLlXfYTukEqnOjwGepynLNVEjYF4M/1AtVnRw59G3qRaKKa53JeM4BUfIka8urmAMxwn+e37DL/Hxd7OOgDQOEgPzYmyZrzWdOWTWjOFwOmEDMHZyt+oA/m49NsnC07k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UyDIdvUq; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so187334066b.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 01:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708766117; x=1709370917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/yXuN0xYqKzIX5pSCX1Kp3woa7Po0PztF79u6wq9Z0k=;
        b=UyDIdvUqTYayinWKrbvoB5ixcUWM0+a0hrTT0ep1kFBLE0/9lfhbwizzd5FzO61sHJ
         8vV1QH0W+f4c/FG/W9Rm6O5D4tuQm9hefDYdZhDxxkHI5JLJfByah3+3J69ayZlki7Z9
         kFTL1mde04sd/uG2qleyl3U0vzZSqGsNza2F7W9ZUSWLMuJT3CBughbu5UOiB0H7iGnY
         ugSs8MnuXoXc1M9yPGC8M0hK0j6cEOYCJc+50zOgT/x1KoABeTNgadQUD3YScx5bw9jy
         LM7iLlrKZzfw8XDOmd7N6/LHzoJhmaNewagQvdhCAITAFi2n8kCOTMpdibkHNO3NYhoQ
         VvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708766117; x=1709370917;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/yXuN0xYqKzIX5pSCX1Kp3woa7Po0PztF79u6wq9Z0k=;
        b=ms6pjMKSPA+ezvNzI9TzSelUShg+yO1iFplRjT4RCsgrvr3vAAYxOsNhEgAN54HaPK
         MCC1Bx2Rsf39wviB3hF7IKRbVvioO5Zxx7gKkBLpdq4CCVcy6kdnsi13Zq/5bfcn7oZH
         XaP5hnQcNJmbQqGMpZyuou+mO4OmIr87LsMofD2gRMrcyzQY4AFN3jf2s5UbyYQLnJ6j
         6xXV/5RENkU87mofxT1W8FtUNzywih2/hSzsMXMepxtx5xypOozSdzX3BicknOUZmffk
         OWHTcL5fLox+dfyfMxukMsxvNvAaQMhjZCuIihhI8escbONt0vpoAe7Q9ncj0ceHGq3o
         P3Lg==
X-Forwarded-Encrypted: i=1; AJvYcCW6Kzbg5ZhZ8uyamqbzz9KxwdaGjFdLsLKDpic7vsldnRsk1+WC/FOeGcSjKhN8gmgudjgTXT46DnB458xlAuDFC9LZdzidBbkgtbG+
X-Gm-Message-State: AOJu0YypqcMDreSNvXPJX/WWr6NIssKNrgDJLqPpnvQ1fYtmWJsSuxGx
	yFwZY8Yw7iBMd/Uf8ZZ7oqFxUq7Mg1cud8d6AUQ8afYyFGZKthX0pU3C9vTxGquYMfZKE4X9rPd
	uaPA=
X-Google-Smtp-Source: AGHT+IEAv583RjbPCjqo8rCRP363mV19Vvbw2dN4DNVCngN6jVHMtXOxp2IpGr6bO6h5BvQRj+H2sQ==
X-Received: by 2002:a17:906:2844:b0:a3f:adad:9ce1 with SMTP id s4-20020a170906284400b00a3fadad9ce1mr1745152ejc.18.1708766117121;
        Sat, 24 Feb 2024 01:15:17 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id s1-20020a170906060100b00a3d9e6e9983sm410710ejb.174.2024.02.24.01.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 01:15:16 -0800 (PST)
Message-ID: <c9d65615-166b-4612-98a2-3837a90e646d@linaro.org>
Date: Sat, 24 Feb 2024 10:15:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: usb: typec-tcpci: add tcpci fallback
 binding
Content-Language: en-US
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, linux@roeck-us.net,
 heikki.krogerus@linux.intel.com, jun.li@nxp.com, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de
References: <20240215212852.1202339-1-m.felsch@pengutronix.de>
 <20240215212852.1202339-2-m.felsch@pengutronix.de>
 <4e464a7a-6a38-461a-b03e-442cc43d1719@linaro.org>
 <20240222202357.2etmuoy6i6qr6bnq@pengutronix.de>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240222202357.2etmuoy6i6qr6bnq@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/02/2024 21:23, Marco Felsch wrote:
> On 24-02-22, Krzysztof Kozlowski wrote:
>> On 15/02/2024 22:28, Marco Felsch wrote:
>>> The NXP PTN5110 [1] is an TCPCI [2] compatible chip, so add the fallback
>>> binding.
>>>
>>> [1] https://www.nxp.com/docs/en/data-sheet/PTN5110.pdf
>>> [2] https://www.usb.org/sites/default/files/documents/usb-port_controller_specification_rev2.0_v1.0_0.pdf
>>>
>>> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
>>> ---
>>> v2:
>>> - rephrase commit message
>>>
>>>  Documentation/devicetree/bindings/usb/nxp,ptn5110.yaml | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/nxp,ptn5110.yaml b/Documentation/devicetree/bindings/usb/nxp,ptn5110.yaml
>>> index eaedb4cc6b6c..7bd7bbbac9e0 100644
>>> --- a/Documentation/devicetree/bindings/usb/nxp,ptn5110.yaml
>>> +++ b/Documentation/devicetree/bindings/usb/nxp,ptn5110.yaml
>>> @@ -11,7 +11,9 @@ maintainers:
>>>  
>>>  properties:
>>>    compatible:
>>> -    const: nxp,ptn5110
>>> +    enum:
>>> +      - nxp,ptn5110
>>> +      - tcpci
>>
>> That's not a fallback, but enum. Fallback is "items" and then you could
> 
> Damn, you're right. Sorry.
> 
>> also send a follow-up patchset (separate, so Greg won't take it) fixing
>> DTS (if not, let me know, so I will fix it).
> 
> Sry. but I don't get this. Why do I need to send a follow-up? Greg did
> not apply anything, at least I didn't received an e-mail, that this
> patchset was picked.

If you change existing ptn5110 to a list of ptn5110+fallback, then all
existing will DTS start report warnings. Someone needs to fix this.

Best regards,
Krzysztof


