Return-Path: <linux-kernel+bounces-32748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DCB835FA4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8DCE1C25948
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD503A28B;
	Mon, 22 Jan 2024 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wapznbKh"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EB53A278
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705919235; cv=none; b=r0fbrvF67r3dtCCOucLCbR+ChM4EUxvLf5IXwVjrxo+VpOk8lYknEfZUkz+jXQxObmklHqO8V3huCf1yBES2lxKbfYJ2z72xtJ5i1KizBVXAQTwgcHNUm0D7fWYYZv1X27ky6GHEi2cs6PCfjiz4mRRFKOVyh6j1w9asZFVKnAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705919235; c=relaxed/simple;
	bh=mrUHy4smwQZ2a6SuapZ0Z4G7hpB6AWKYvF4yDVQ6gyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kKgvFiRJ/kQ+Xc6hcZiw79aJ/tYdSIXYK6QGNU831L7X+UvYEcOjQcvFAMAWswIhs7gYO768xb6gNPveqPObJurhC+hpc9K+qyZ/Q9tOIX4vjiy4nyIOkPOaOUnVKpYVfvH6O6ugf3AYz+Z4aJ8xIPEsz0wqSsWbSh2dpwlB8Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wapznbKh; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55a349cf29cso3312069a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705919231; x=1706524031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xswNyoPTx9kg9SARAx0XALvTM7whm+/HbTxHad1ULag=;
        b=wapznbKhrJGbYwM5jRFQ1e64KrLt7qkh1z7Gj/xJPfjOe9moR1ni5NFw8zhCZj+neT
         Fe+CgHDVR4G4o4PZ67aP61o1/x3Q+pgzme5Y85Dn8SbmC3BWXZoayzVyzXKUlNwM5odR
         YRD0O3r8ANsTceqcqgU+zOd0WOdj7hMROUZ2pZa7O15gmbqjwCj2asAkD4LeBkKhsB99
         rR0ZL5EY8QH5G3seC5l0rtLTaEL/3M49VSpeDumDhMSFtyMfShAQrbj2tnJpGtncqaVH
         sQo1bp0duchLxqcZvq8L6dmjwS4/XHl183kpUvuGmb/YiJ6+dT7Gjim8CshYoBJCf44G
         2XbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705919231; x=1706524031;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xswNyoPTx9kg9SARAx0XALvTM7whm+/HbTxHad1ULag=;
        b=GuIYtVrfIZ+daeOy96hucrB9HYUwFN9PJ0LrAU2z17+YPClL8JCsdXoRsDG/57x5TH
         3kCANMdaO2I1emTxT6o7I49ZwXYuZIVyYiQIhkdk+je+cF39lyIrh0yXiV2bGrZc0feU
         qTn44gfGqhRd5oyoipjlUyB9OaPSYUpgElreWYlpTyRMCT3aTcxgyip9Jeh/1Qp6ymTE
         vErVC92kiwgoyu4gs5V3GiSa0ixmf73EsDG49a5hNYL0vUVHbBpBxTfto8dCMXS8QT7C
         5bHfFaEKfeBBKh24pIc/0P0sAgGQScPj62ZhY/L9bni3a1AXNVjkG83XzVC7W3shSdbf
         VuHg==
X-Gm-Message-State: AOJu0YztGcjvjsnEGNp1JUgkCp/Eo78iq55PG6ezAqeDq2LoxUDIOl/J
	89+LI5H0soXEAiPrRqQTxvQbWr1J7Awei4IoM7GfJFQrylVeLSzZp0boI7Lln/M=
X-Google-Smtp-Source: AGHT+IFEEL5I2v97pbpEot1HvLfLgC9RFx8FCiDd/TRtDZKoFfifF/gYFXoi4OjcMT/bct5+jQmh/w==
X-Received: by 2002:a17:906:f593:b0:a2d:d8df:49fb with SMTP id cm19-20020a170906f59300b00a2dd8df49fbmr2464050ejd.82.1705919231575;
        Mon, 22 Jan 2024 02:27:11 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id i3-20020a1709064fc300b00a2e33a6cbecsm8198701ejw.18.2024.01.22.02.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 02:27:11 -0800 (PST)
Message-ID: <acd64ed2-c36b-45e5-a71e-98c98ff1cb74@linaro.org>
Date: Mon, 22 Jan 2024 11:27:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dt-bindings: input: imagis: Document touch keys
Content-Language: en-US
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Markuss Broks <markuss.broks@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240120-b4-imagis-keys-v2-0-d7fc16f2e106@skole.hr>
 <20240120-b4-imagis-keys-v2-2-d7fc16f2e106@skole.hr>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240120-b4-imagis-keys-v2-2-d7fc16f2e106@skole.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/01/2024 22:16, Duje Mihanović wrote:
> IST3032C (and possibly some other models) has touch keys. Document this.
> 
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
> ---

Please provide changelog describing what changed against v1. Cover
letter has something but it is not accurate. It says nothing about this
patch.


>  .../bindings/input/touchscreen/imagis,ist3038c.yaml           | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
> index 2af71cbcc97d..960e5436642f 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
> @@ -42,6 +42,17 @@ properties:
>    touchscreen-inverted-y: true
>    touchscreen-swapped-x-y: true
>  
> +if:

Move allOf here and keep it under allOf.

> +  properties:
> +    compatible:
> +      contains:
> +        const: imagis,ist3032c
> +then:
> +  properties:
> +    linux,keycodes:

No, this property is not allowed by your binding. I doubt this was
really tested.

Anyway, even if it works, it's not what we expect. Where is the property
defined?

Best regards,
Krzysztof


