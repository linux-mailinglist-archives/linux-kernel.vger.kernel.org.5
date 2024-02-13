Return-Path: <linux-kernel+bounces-63047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418428529F1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB882283B61
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2621775C;
	Tue, 13 Feb 2024 07:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vYW8JcDd"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C16A17583
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 07:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707809554; cv=none; b=pjhAdjiU6ZVf/C8EtfcegxkIELdrjt9K5ay2U2CvJ6OmpoQv3PuEVFUJ2yWn0Z2lArh7RxBYr1GRkPms4kz/JOVobBg/GIH/xtBt7t9OUlWn1KnqF/UK5E2hFR7GDG7lmhjh9GAirzsPeGG5OXH7I/01MnrvOGMo5M6062PT/nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707809554; c=relaxed/simple;
	bh=egWUH1uiBpqU9NPw0kO+DB/TZsZdLAGY6A9byNiZEKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mKyXaML1Imf9drGOFp5rGkCc6SKy9bxu+Xj8TfdO062X3h20tQjyK71kwEybJPwL9CZriuTmaAOEroBIA0sLxEgncDKyTqBJBHWQyheqeBOl7B8ix/3g4A9ufeueo1OxDu/qvZxLDChHzOL5WEIN2vMZ7GRuw/wBUmGSAYSBc1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vYW8JcDd; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-411c3b299caso1186175e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 23:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707809550; x=1708414350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vW2m+VEGI/GL+PlpW04VatVIySi+IdTDX+rOzYR1mss=;
        b=vYW8JcDdXfh7+IiS2CRo2jzeOiUb9IXdyv7tXq/8zbycca3X564TI4KTOB2HmukcPk
         kvTyYqOjLe+/fhQrOLP+OA62+sXor//YMBQqkAIqg8ENQkQ8vvsV1pYsU+RXIDSKStwo
         dhdMzh0N7I8Tt9TG0CakHMswva2cljt2d5A11AvKkk72pJLRcKKflbrxqaaBbZgDDIuJ
         OZeDfXLt7go5iqEECxR9Zf3F/Xg9Zt0TfRWnAIpHFnzRXiXNonVNvVj24qaH8gIbSGPY
         bjHiyY1h8LJOnKAU/W4I+Lnl9Ep4V7aAGCvIyiH4smNMhbbBp0aZFFE17ojNKEN3fQwK
         FMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707809550; x=1708414350;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vW2m+VEGI/GL+PlpW04VatVIySi+IdTDX+rOzYR1mss=;
        b=Q97YC2iCoGKbluxYJjZ1MwOJ8dDp7yskrxjwgHRWElPoOJQ53awtuyBxpQLUXCMSTj
         pdb1xh2TRnSJ+RU4IEfzVtvJIrIjd5N0pMC/EAswNDXxWai1J88LxjSHiOPR32zMmUxR
         Gmx8rXZ5eN+D7+S9DkO1HJOaE6GnMjPfNwtiPh9ZDXUCEbEsBkfo1xOhWXm+vX6WNKn1
         BFqvNEyjqZKtL+EKgrfW1eRzVrKCqinM3RZLs9XCcBBWK9xtpbz89Xf5V+0Wc1WNyTKK
         xQNr5ywWtt9nwHXgMEDI0J7dQNt5bKLqrdnhUerEmWp8FKuo85BT5woppqrP3gecQEwx
         LHSA==
X-Forwarded-Encrypted: i=1; AJvYcCVfJYT80F22v3GhvPswTEpbkl22Np7B2HD4mpVciNIIpYMTzDkey6me1PsxtxtZEnZ09uNxhiN+4RdT2tnPWNqc7i1LpDAdUuV5tUF9
X-Gm-Message-State: AOJu0Yzg621GysqhbRTNkKmQ4kRjFH56mrFPhab/VRi9rK11M04sb2Bj
	/L6MF/Y3w2cnIxoNLTeT6XswZcCft003nLJV9KJLEJvqiYjtv7s2WGq2DTMgSw0=
X-Google-Smtp-Source: AGHT+IGE9381K5a0/HVdWMFOMHxU49Odu6x/whCHfPJvBfO90qRN2uF+RlxvT1mQb5ZRWXTdeeMqPA==
X-Received: by 2002:a05:600c:138f:b0:410:7f97:4825 with SMTP id u15-20020a05600c138f00b004107f974825mr7072279wmf.12.1707809550506;
        Mon, 12 Feb 2024 23:32:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVWGf+BPnSl7ohKfJ5aEhYyMP2eiK/Ml8SPkj6SD0t6y5wMjvEN7YF2hzLnZtpKuFn2PsJAanYqZ1qRRNQUUt45a2cQbFmBBeX/HWiYr+z2xrNW5d9fcXNN6cCFx6QjGQxm5X11EkrqTP8M0sVVD3pwOBn9M0etasnfZQIbi4ASnMt+8wEMBY1plEHCvG+S+SI/7IU0FeSj09mhkAFMl8ZdtzwbiveQ+2qMIgt1CVViXiVxvo/LgGNCDjWYpw4o+xg+0cbyakOtrbz3Fx5ZnKs9auH0gbcqdXo1rhV5hlqj+DKFMw3cA4qDfd9qwdtaUQ4ZSv0oTaeSC5rXxcgBT9YAlkg2qniV30D4hFI1FenD4e4v39TL+yIIla6Yl1NgyN8QbvXO9lAcguGWlI7QGpRfBy0XuJvuI4X7IoQNdwJyOcMZ6uY=
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id k9-20020a05600c1c8900b00410d7e55e5asm4980204wms.3.2024.02.12.23.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 23:32:30 -0800 (PST)
Message-ID: <ab453a46-84da-4ac7-82e0-41e2349abcf4@linaro.org>
Date: Tue, 13 Feb 2024 08:32:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: net: qca,ar9331: convert to DT schema
To: Conor Dooley <conor@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240212182911.233819-1-krzysztof.kozlowski@linaro.org>
 <20240212-macaw-dispense-e073f5d73fe3@spud>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240212-macaw-dispense-e073f5d73fe3@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/02/2024 20:25, Conor Dooley wrote:
> On Mon, Feb 12, 2024 at 07:29:11PM +0100, Krzysztof Kozlowski wrote:
>> diff --git a/Documentation/devicetree/bindings/net/dsa/qca,ar9331.yaml b/Documentation/devicetree/bindings/net/dsa/qca,ar9331.yaml
>> new file mode 100644
>> index 000000000000..fd9ddc59d38c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/dsa/qca,ar9331.yaml
>> @@ -0,0 +1,161 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> 
> I don't recall whether or not Pengutronix are on the carte blache list
> for relicensing bindings under the dual license.
> 
> Otherwise,
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Only two sentences from description were copied, which do not carry
substantial information, so we could argue that there is not much to
copyright.

Best regards,
Krzysztof


