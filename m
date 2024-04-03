Return-Path: <linux-kernel+bounces-129219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DA5896735
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C54F282FB0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAE460267;
	Wed,  3 Apr 2024 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCw8xAj+"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9B95BAD7;
	Wed,  3 Apr 2024 07:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130655; cv=none; b=WACdERSSyh6pi095Jv139G+EzAwIpdcsA2A5VhZpSDSNwE9mi0D/JGY6khthXGcP0v01zDBjpR8kFIlx1oz79F+hz5TeR3XxB3H1/KLOIXeBqivL4JB2XrfGASEWi0rkJ4UCIVlEg2YjEmKvWeDp4us0OLem1fTWkvBkcLc0KEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130655; c=relaxed/simple;
	bh=ywE5qXTnpN8Rz79lOfQlyDcGWljbTKBwTCw6SI9c6J8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AX93US5AMsg0uSScSUK96XjkOpD8Z60Uh3+BRFPOeTE63h/CDQDd7/1DPRJJOrwMd/cIQPIPjvADnaMuKx1eP5mWbWjjgkg0QN7PajSmXCIihh06kpZWT0SrlI3gbRfZ1yY/wtAwSJ8OITvTchITZtnFwIyQq7z0A9o68eBsSIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCw8xAj+; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6151d79db7bso18555637b3.1;
        Wed, 03 Apr 2024 00:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712130652; x=1712735452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lK1PTLoQ7GWXD/BsL4tn6gD7zAkcDBc9/sDahHls59o=;
        b=mCw8xAj+vN8eWePg2NLbB9YhNxydNs7leiUa7b4H7c3bpTXor2yd91i+5Dhs7qhZko
         VydGn5z0QIT2nlsgOwIwWVyx2SwcavyTMBvgzz6ucqK0QOkv0AV8MrZTQ7la3Wreg6Av
         l6pTYLpE4YHyFuQW4r1vx5ghVw0i2bMnO1VFr7W8o09MVMrX7qb56XFAwT7O5T85pnlw
         bsZu4ltv9VROCUWuwHSqLMU7PxS3BSA0vvyBGeZNDp0xcxMSQ0aLyJzSDQZB8Uqnmn5l
         ojLOtcNnHCYCsk37ymHuGuYFKlMHCwJ3FxDaw4+tZsT13P6h6aCoF2O7tRpwTo4sz3Ag
         tjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712130652; x=1712735452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lK1PTLoQ7GWXD/BsL4tn6gD7zAkcDBc9/sDahHls59o=;
        b=h3D/TtRiO6atU4LsW2DFFsRoUUklJ72wTT2d8EFZ0ipvCW8iR3HAN/e4gMZlmwR1Pu
         qEj55fi/9573Wn8Hlu+/uZGfbGpG6+hOnY28jQLYzdfkKtURT81pYlsigr5l8MaE/H+4
         LzHPaivm/DAVuHuZ08nWqko63HXWMGJ52FecOw2WXlFK7Lnns24F9uJV3M2dWaXOerHF
         Om8QnbQtwHC420C6NhwaKz982auK9aowNuF3fG8j3GSz0OoQ1zpkynT/Dj6+wJW/Y3yP
         NFvFWNf4cukvWBvb5FDFXnAVI32GSUUzRA2R22LOjWRl+Zbf5mX/l88wDEZrvbVoT1Og
         CJ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXk0B+I6flzrM5NzEtasyW9ypkwRkuS4bZwvLOtJz8llR3Wl3OS7AkRegpPcP67fesTibyXKMosKmp8fsWm1m2vhW1/1v9bnRUkTGj3hvYihaca4xOnOupXX/3KkLx70C2x9FqlaUwIeFFWUMFqsRwbNzT1ufKscOYePv3BEwA7YNI+dQ==
X-Gm-Message-State: AOJu0Yy4tEmi76DTR5WbdlYQFaGGUNv6YZ0cQHtandL5jKcoXzOqvE+i
	LZkW221dhwQWJFqNDhct0tEMpbFU6WW7b+xdeUQHnfEime8FTltj
X-Google-Smtp-Source: AGHT+IHbal7o+sY0f692AFbkIvRC2YW9I8e84IO963Mqw6JI1jtvy0DC+7fdPtUYQhCh4UZX9THu/A==
X-Received: by 2002:a5b:1c1:0:b0:dda:a9f7:4ec2 with SMTP id f1-20020a5b01c1000000b00ddaa9f74ec2mr13547111ybp.56.1712130652434;
        Wed, 03 Apr 2024 00:50:52 -0700 (PDT)
Received: from [10.76.84.174] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id bl39-20020a05620a1aa700b0078d3b2511d5sm5031qkb.5.2024.04.03.00.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 00:50:52 -0700 (PDT)
Message-ID: <0a72de29-6d25-4d2d-9824-ca407af69153@gmail.com>
Date: Wed, 3 Apr 2024 10:50:49 +0300
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
 <CAMknhBGVuMSg+OpS5QTLWi9vA=Xa33AJ+cVS8ZCDyKsAVEe-ww@mail.gmail.com>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <CAMknhBGVuMSg+OpS5QTLWi9vA=Xa33AJ+cVS8ZCDyKsAVEe-ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02/04/2024 00:16, David Lechner wrote:
> On Mon, Apr 1, 2024 at 2:37 PM David Lechner <dlechner@baylibre.com> wrote:
>>
>> On Mon, Apr 1, 2024 at 10:10 AM Dumitru Ceclan via B4 Relay
>> <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
>>>
>>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>>>

..

>>>
>>>      properties:
>>>        reg:
>>> +        description:
>>> +          Reg values 16-19 are only permitted for ad4111/ad4112 current channels.
>>>          minimum: 0
>>> -        maximum: 15
>>> +        maximum: 19
>>
>> This looks wrong. Isn't reg describing the number of logical channels
>> (# of channel config registers)?
>>
>> After reviewing the driver, I see that > 16 is used as a way of
>> flagging current inputs, but still seems like the wrong way to do it.
>> See suggestion below.
>>
>>>
>>>        diff-channels:
>>> +        description:
>>> +          For using current channels specify only the positive channel.
>>> +            (IIN2+, IIN2−) -> diff-channels = <2 0>
>>
>> I find this a bit confusing since 2 is already VIN2 and 0 is already
>> VIN0. I think it would make more sense to assign unique channel
>> numbers individually to the negative and positive current inputs.
>> Also, I think it makes sense to use the same numbers that the
>> registers in the datasheet use (8 - 11 for negative and 12 to 15 for
>> positive).
>>
>> So: (IIN2+, IIN2−) -> diff-channels = <13 10>
> 
> Thinking about this a bit more...
> 
> Since the current inputs have dedicated pins and aren't mix-and-match
> with multiple valid wiring configurations like the voltage inputs, do
> we even need to describe them in the devicetree?
> 
> In the driver, the current channels would just be hard-coded like the
> temperature channel since there isn't any application-specific
> variation.

 Sure, but we still need to offer the user a way to configure which
current inputs he wants and if they should use bipolar or unipolar coding.

 One other issue that arises is the fact that we will reserve 5
(including temp) channels out of the 15 that the user has the option to
configure. While the binding will configure only 11 channels for
example, the driver probe will error out with the message "Too many
channels specified".


