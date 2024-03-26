Return-Path: <linux-kernel+bounces-118451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A50A88BB0E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D251F35963
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A03C130A65;
	Tue, 26 Mar 2024 07:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wTmiXm2x"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55CF13048D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 07:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711437524; cv=none; b=MS9lA0kXIDlCkAbWi7II5I1x/5WimzdG3DauEpFLNSzUokRI0Rstd4qrDfGPlmilKuGcggtESI3jTI61Go/p3mxa5aum0nO5CDfbvhwK0+2XAZCUAkTWjLKLYFk2zLq6cjioh2+uicdIC/AjxPXs88jAhiQYRqD2UvnoZ3S8EGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711437524; c=relaxed/simple;
	bh=xk5ngh//0etSjxXuZueYUupdxIwqf5DD2o/enmtnOgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UW4U6Qc8MURMsRReGzK1kcny1J6BoHrzoWy+cDZL8XUOurIl4hHU/EPS3uIkYuK4NR7kupoIY1sFTlmjuCGFZxxSRJ8OKq+cCMYy6xc+JicwNjX7tEd2ch9hJy/iis8vFPP3ZUywZFGHtrBzwPaQb5I1QSY90OclB7qBw7ey1WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wTmiXm2x; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a46ba938de0so693091666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 00:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711437521; x=1712042321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wst34g7aDI1Y1qIgvRqvSl8QmnnNWUgzQivFPN5vxdg=;
        b=wTmiXm2xHD2qtb245xRrSjN7976iGaxZkFtIYjk0s+M7OqadnHxbtEhEUvfm26uAHF
         ol5x0xL3cmbdys0TT7DXLneyZBwnVlSVEJLrdnLP9Kg+qYxMWRp+u4XBQKL7IfqeKXZy
         SieKGuSR1dH+j8GwDE6FQKlWmkI9MUyU1/CCx3gMsk0EIbP4F9OFK6/4WPrvr6nnc3Cw
         guxlGNhNcJV+ru64q5KlPbYjIWb/vBlzX+3fUSPhlFuy1uTA79CTHrOnGJSb9qL43XrK
         jaDro/lGKTh5dAY+y5Z8ZwBcfqWo5nY+u3S5kd7JMZhOGEhhFvUiC2+iQDeJS39N1s2w
         u5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711437521; x=1712042321;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wst34g7aDI1Y1qIgvRqvSl8QmnnNWUgzQivFPN5vxdg=;
        b=j/6KAjeGAnpYloffcjmaxDfsRrx5SyJm0suj18D2wt5bGp5Wgf0snqx3haMOSwkSr0
         Vbe9suBv2o+xnyFmVmtHn5u2Srh7/rLQdmYpHzqKqd2ehPJm96mLE+8MU/S7GazY1Shp
         dWLyYBi65DwkOFmSshtXCHwu24df/TAETInx0wz0Rm7bCd6udDpqyPvcbV5roddZQM/J
         G/u8KL7giSqIT9bL/eXpzBW6iBHgCPEYCzvKSlpYyhXeP26dDua6lFF/K1yyhskQHzEf
         yyNPB/KQA2AL3h5eWSDOi7lpGyq43K04L+iQxrwoCsTndEQW4AgXOZTbn9teK7ZPO17c
         SPBA==
X-Forwarded-Encrypted: i=1; AJvYcCWD30/wv8CfUnMs4T6jjR/FbPS2388AJnsvEU8miAuRMSJSWOUItazxIYs8up41/St9A9jvildGUdrnKuaF9IjJUy/wwc1pFy27T0EN
X-Gm-Message-State: AOJu0Yxw6ltawHtyB0mzFMz+YOMONFMJRYVrMFYuhtH+IabNX0bP4W88
	GiktxApQWAt+KOeSmiDTMIifPT6Z+OJyrdhkMW0govGfSkwYm0EUCe7xu1pdn48=
X-Google-Smtp-Source: AGHT+IGuNZrgtLgZJe/8sFakjyicwMckbQoYVPx05H4Gt/Ul9Ig3HIOt4+4rCkA4fdzE4qed436cvg==
X-Received: by 2002:a17:906:3e53:b0:a47:4896:c4a1 with SMTP id t19-20020a1709063e5300b00a474896c4a1mr1178590eji.42.1711437521041;
        Tue, 26 Mar 2024 00:18:41 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id ka17-20020a170907991100b00a472c4b9486sm3883901ejc.84.2024.03.26.00.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 00:18:40 -0700 (PDT)
Message-ID: <2905247d-03b0-45c1-add5-d3c2a986d87c@linaro.org>
Date: Tue, 26 Mar 2024 08:18:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: hsi: hsi-client: convert to YAML
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240325-hsi-dt-binding-v1-0-88e8e97c3aae@collabora.com>
 <20240325-hsi-dt-binding-v1-1-88e8e97c3aae@collabora.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240325-hsi-dt-binding-v1-1-88e8e97c3aae@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/03/2024 22:45, Sebastian Reichel wrote:
> Convert the legacy txt binding to modern YAML and rename from
> client-devices to hsi-client. No semantic change.

There is semantic change: missing example (which is reasonable for
shared schema) but more importantly: some properties are now excluding
each other.

> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

..

> diff --git a/Documentation/devicetree/bindings/hsi/hsi-client.yaml b/Documentation/devicetree/bindings/hsi/hsi-client.yaml
> new file mode 100644
> index 000000000000..df6e1fdd2702
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hsi/hsi-client.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hsi/hsi-client.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HSI bus peripheral
> +
> +description:
> +  Each HSI port is supposed to have one child node, which
> +  symbols the remote device connected to the HSI port.
> +
> +maintainers:
> +  - Sebastian Reichel <sre@kernel.org>
> +
> +properties:
> +  $nodename:
> +    const: hsi-client

Why? Does anything depend on this? It breaks generic-node-name rule. It
seems you need it only to match the schema, but this just point to main
problem - missing bus schema.

> +
> +  hsi-channel-ids:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 8
> +
> +  hsi-channel-names:
> +    minItems: 1
> +    maxItems: 8
> +
> +  hsi-rx-mode:
> +    enum: [stream, frame]
> +    description: Receiver Bit transmission mode
> +
> +  hsi-tx-mode:
> +    enum: [stream, frame]
> +    description: Transmitter Bit transmission mode
> +
> +  hsi-mode:
> +    enum: [stream, frame]
> +    description:
> +      May be used instead hsi-rx-mode and hsi-tx-mode if the
> +      transmission mode is the same for receiver and transmitter.
> +
> +  hsi-speed-kbps:
> +    description: Max bit transmission speed in kbit/s
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  hsi-flow:
> +    enum: [synchronized, pipeline]
> +    description: RX flow type
> +
> +  hsi-arb-mode:
> +    enum: [round-robin, priority]
> +    description: Arbitration mode for TX frame
> +
> +additionalProperties: true
> +
> +required:
> +  - compatible
> +  - hsi-channel-ids
> +  - hsi-speed-kbps
> +  - hsi-flow
> +  - hsi-arb-mode
> +
> +anyOf:
> +  - required:
> +      - hsi-mode
> +  - required:
> +      - hsi-rx-mode
> +      - hsi-tx-mode
> +
> +allOf:
> +  - if:
> +      required:
> +        - hsi-mode
> +    then:
> +      properties:
> +        hsi-rx-mode: false
> +        hsi-tx-mode: false

I don't understand what you are trying to achieve here and with anyOf.
It looks like just oneOf. OTOH, old binding did not exclude these
properties.


> +  - if:
> +      required:
> +        - hsi-rx-mode
> +    then:
> +      properties:
> +        hsi-mode: false
> 



Best regards,
Krzysztof


