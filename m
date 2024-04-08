Return-Path: <linux-kernel+bounces-135574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1D889C7C8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131AB283A75
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE4213F44D;
	Mon,  8 Apr 2024 15:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vCRYj0Zo"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E22313F440
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712588788; cv=none; b=PezYfkz9QN7+jxO/DSUoPsHHHeW5QwckCZlwQBBws2UZS/i4SZMYu/7gqXCEWNro2yC5uoQzmXkwL3ZV3Oo57aJnML6FwPYzJtQvyRpfHygX1X2GZKt018lB09TzA7G14unqlZeoTzju9FH8Eabk6YccrVaJmjxma4Ww1oD7NPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712588788; c=relaxed/simple;
	bh=MsNpVO9pB/7MMcibh2I88NHwGOLe1uSWzf4L7HJ0tE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b7on60fzrxgTqvC6zTc+u86/9y5M8N1nZh5OsqNJJGoQ5fBSSONrS7z2HJ6pwK/pdA1ST/JKhCdGZOQ4uFPZC1jETevS+BYQ+R82pWF/RCvYb3epQBIkvsMGuS8F1tgW0404qmyukMOYIDUJtb+IsIv7wDtOiaQSwr38dRaG4Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vCRYj0Zo; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4165805e158so10399725e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 08:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712588784; x=1713193584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Dxs6cIQGM15UBhBDso3tA3kUyIdNuLINVbFD4GzTI/Q=;
        b=vCRYj0Zo/VI9J8iHKRgyZJeNxW+CL7ZduogXCThyoMGKjHS0zyapKDeJ/mnZ9w5RLM
         EITe3YeyXDofQ9m3U+4b8VBeGqGA4lAmD9B5RVNqD9Um8dwWgcT3PDg92UCKFeN9Mppn
         JvSZCBZzYplhqELjw+kjDCFPYMlUFsCWAtiIt/ZdG705IiGTLf/LuePAv+y8LvirQlJI
         VOHxNq9Z+eQlk+2rUZXeyZswzn6yAynjc5VYKCfU5/uUFfen2NRL3ccxMV3pyrKMm/s3
         gHFFl77qyeMQpskKZrtBej35SeNW3UDNp5wOPwyMn5jWCrwmOJ8smHrY7OLlXuPwA4nA
         WpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712588784; x=1713193584;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dxs6cIQGM15UBhBDso3tA3kUyIdNuLINVbFD4GzTI/Q=;
        b=AbVMkO0uTFw7QX3wCaE4hdKNmYV4AWNo8tUt/idxxxR+atyTAJ9HFVzby+4+LJ23oR
         7LEjHDqlBCnH49yofi1cIQR2Jp02oiQtg0sCIKA/yArYCbcyEqxe0OesJuBhJOm9uYqy
         bJWkBFxA+Du0+fWXScTyD3LdI2LdfLFqkdZoN2a6cC1C1Y5PQc6j9cTsHsksncxDhuJl
         lpJp7x/EYTyVei7ER6j35JKv+kbdQnQPOflcnQScim3eQHzDR+L+R3Opef3lN3qGCpxt
         GJMnbsOQVNXwlM7OdhNGOIsVUmKgPCpLMdh3hIOekupcwP4gaq4vyoUX2iwO8tQZHxHz
         Q20Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTo5GMdJm85wjUXxdC/pBenJDgAEL1+xax8EuqTzeKJGPjmm0lkdQmLSiOEHD0VoBOy9oARUy5Z7tWe/W3/NaIGzZcIpoUz3kP/2SW
X-Gm-Message-State: AOJu0YzHbM8GD1rX6UhHPfqgDT+Q4XxUMVX12K2UUGAdA0nNIurmdql/
	Ne13RrE/qfjtmFmBJH3K2X/ThfDAgRqb26pTubm1ZwAsOfBzKPzBh/2foNCyy0U=
X-Google-Smtp-Source: AGHT+IFnASuk0b7wQuK6k5VWyqkLb542+HkDjKIZIid0oTGMKzSJn6440x/462PKUtK4PX7NzyAtfA==
X-Received: by 2002:a5d:6086:0:b0:343:d06e:51fe with SMTP id w6-20020a5d6086000000b00343d06e51femr6955094wrt.20.1712588784285;
        Mon, 08 Apr 2024 08:06:24 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id n6-20020a5d6606000000b0033e745b8bcfsm9165815wru.88.2024.04.08.08.06.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 08:06:23 -0700 (PDT)
Message-ID: <69ab2bd9-401a-42ff-90fa-6600dd071722@linaro.org>
Date: Mon, 8 Apr 2024 17:06:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: dt-bindings: imx-audio-spdif: convert to YAML
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com,
 broonie@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <1712561233-27250-1-git-send-email-shengjiu.wang@nxp.com>
 <01734d96-bed2-4f7e-bbba-7068f14c822b@linaro.org>
 <CAA+D8ANiKH7Oc+KAjD_BMp9P2EVeM8Q6dLGFCC8a83bJXUpPEA@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAA+D8ANiKH7Oc+KAjD_BMp9P2EVeM8Q6dLGFCC8a83bJXUpPEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/04/2024 10:01, Shengjiu Wang wrote:
>>> +
>>> +anyOf:
>>> +  - required:
>>> +      - spdif-in
>>> +  - required:
>>> +      - spdif-out
>>> +  - required:
>>> +      - spdif-out
>>> +      - spdif-in
>>
>> Do you need the last required block?
> 
> Yes,  one of them or both are required.

And? It's already there: that's the meaning of any. It is not oneOf...
Before answering please test your changes and ideas. I pointed issue
here and you responded just to close my comment. That does not make me
happy, just wastes my time.

> 
>>
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    sound {
>>
>> That's a random change...
>>
>> Instead of sending two patches per day, please carefully address the
>> feedback.
> 
> In v1 you suggest to change it to spdif?  but spdif may conflict
> with the fsl,spdif.yaml.   so which name I should use?

I don't understand where is the conflict. That's a different binding.

Best regards,
Krzysztof


