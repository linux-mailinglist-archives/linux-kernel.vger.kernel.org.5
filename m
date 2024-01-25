Return-Path: <linux-kernel+bounces-38463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8952383C047
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3962029BB3E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9527D5380A;
	Thu, 25 Jan 2024 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z+MnFA/V"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD193589C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 10:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706180092; cv=none; b=V2y35GDYc/aSW+KntzOCd+sFtNfNnJ75/NvVcbpGXVJs0yaVanTU41RcAJed4Z+gwG6uNPycyMcF25UjHqdoq4imw+ssTWiVEbUeBKm7mQ3ztY+quxRiaX6zAUacN0lANIQ6tPA9vJPcMX8qyvDYbGJEsDHyYIgcT7F0os91J3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706180092; c=relaxed/simple;
	bh=t8AxuzA/9zpfwWK5fZHKjrWuE8goSmnp0i6uLz1/Klc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pUMT6U5lvoOu290qs4M2WCZkHxqwXiK6epaG8/Qt+pLJcNSpxmDa/hhgf5KW/mlBN3ZdwXGGLAVSPu24cwxa/c4z4I3xJq7kYDI2jgu5PzV7JfsqbPRYA+nnxpdZobRytbOIy7T6MZ0gQAwexbm+1Q6uD391TEF8DPbvV5x1N6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z+MnFA/V; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a26fa294e56so667847366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 02:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706180089; x=1706784889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1SnYSeTb0hYzYHHRSf92AKyNcLjElkUvUSwPVeKb6gI=;
        b=Z+MnFA/VfOCBBWbUgxcPrVwZJXLoM+7LxWUi8SU3akYKRjbPiq2LWqr7cESdTnRsmm
         QGGXhb1gm0U6fw1vyiiF3gI0CEokF/Ht8zC383JEUvSXGWvUAAHkn6pnltblgnmBOxzg
         gHqqzUDcqTwu1YNdhjmA9GjY7gMVrz05jTPj604xxebsefV2B+qDt0m2Ju0dIuuDH+K0
         OoEh2qDLwVW/UjaExYhWBrFYXAb5GiNQd4T3LPcvzxzrL2SxyQOK2c/DmtPRdU8F2JZg
         4HszFISmNokXNUgs+rto+Rhr0qqJ0Zg47nDJ2K53c9noLopgPMPFR1BGuI3K2veUGIde
         iDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706180089; x=1706784889;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1SnYSeTb0hYzYHHRSf92AKyNcLjElkUvUSwPVeKb6gI=;
        b=O/NDJ2xQlRcAMy3D0tE5E7IIIe3jiHeNv5xtWaSXlUgiDKLE7//Gop/gmrRheuOzKT
         J+vxNgWG18+pMQJR+UcQU1IY8mVBLs+V4nXvN9irwFW+LU5YuNV2vQ3Rvan2xPM628L8
         56ehOCWLnATQmgIppRzL7b6A7oWp0FC6bET1B81Gk+LN6ZDfHKRZWWoCa1HTutxu04ZZ
         LKt8YJiEJrl3iy97IA481ja2/R0Z+T7cOLnlnf3v6Qi6BflMwQl7hjKbUpSv8MFI5vIF
         wkMyDexx6dt22zE5JSmFgi0bI5dXWXJjW9ce+PTECW7rw479nM7BfEp/s1K3AA8r4+US
         IwmA==
X-Gm-Message-State: AOJu0YxuWIQLzcIzxLVpxD74JK5lUFn7guKmwRJb4YsDZkVfwaO7gaYx
	NsN6HGjPNZtic9MKMEQVOptcSlxyT3wOjZcB4vs0+SUvS6UFZD98gdDiOsSZBgM=
X-Google-Smtp-Source: AGHT+IEdrKzqNwv3GxuZV4kPHbiOvFB7XQGm8daioTpNXYPO7NGJZGkKdWlLDObjIsBipUh4ljtOFQ==
X-Received: by 2002:a17:906:a891:b0:a2a:3101:c9c7 with SMTP id ha17-20020a170906a89100b00a2a3101c9c7mr428051ejb.123.1706180089168;
        Thu, 25 Jan 2024 02:54:49 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id o18-20020a1709061d5200b00a26f1f36708sm887106ejh.78.2024.01.25.02.54.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 02:54:48 -0800 (PST)
Message-ID: <83da19cc-a140-406a-bdac-e6d2bdcc9794@linaro.org>
Date: Thu, 25 Jan 2024 11:54:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] dt-bindings: power: reset: add generic PSCRR
 binding trackers
Content-Language: en-US
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>
References: <20240124122204.730370-1-o.rempel@pengutronix.de>
 <20240124122204.730370-3-o.rempel@pengutronix.de>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240124122204.730370-3-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/01/2024 13:21, Oleksij Rempel wrote:
> Add binding for Power State Change Reason Recording (PSCRR) subsystem
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../bindings/power/reset/pscrr.yaml           | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/pscrr.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/pscrr.yaml b/Documentation/devicetree/bindings/power/reset/pscrr.yaml
> new file mode 100644
> index 000000000000..c8738b4930fe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/pscrr.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/pscrr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Power State Change Reason (PSCR)

Missing final R?

> +
> +maintainers:
> +  - Oleksij Rempel <o.rempel@pengutronix.de>
> +
> +description: Binding for devices responsible to store reasons for power state

Line break after description:

> +  changes such as reboot and power-off. Reasons like unknown, under voltage,
> +  and over temperature are captured for diagnostic or automatic recovery
> +  purposes.
> +
> +properties:
> +  pscr-under-voltage:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Value to indicate an under-voltage condition of a system critical
> +      regulator as the reason for the power state change.

I don't understand how it is supposed to work... unless you wrote
binding for drivers. For drivers it would make sense, but that's another
problem: binding is not for drivers.

You also did not present here DTS with any actual device doing this. You
just added a driver...

Best regards,
Krzysztof


