Return-Path: <linux-kernel+bounces-118453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0569988BB21
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28CF71C2B645
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713B1130A75;
	Tue, 26 Mar 2024 07:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="irltSy6u"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D181612DD8C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 07:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711437670; cv=none; b=OEY3k0mdp10mE89L5aEpmiYIml/NZtQEgd6sPvHSIhVZWX9rZWSCOr7FQg6Qje/jfuLHimdeg5dwrwAuTVpLD+K3wuRgx3jAHamhO0MeDcrG79/1QxWBX+iHhMMxbDjU/7F8PbfcjoqC/zzckE/3FUXIkd9zgCpo+thaJO7V27o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711437670; c=relaxed/simple;
	bh=uOBlgB1p9x3JSrqgROMcDWtycb5ZnSgCUHNKiU3W7xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D3VrBrzv2l9QRISV/PsnXXl9jyvRvpzFi2glhSsEXEUkYrq6kDmseBbaxqQvnmmtR0AISPVpELdUBvFLYp+rpnmLJR3Sd3aaUdgorDO2f9BbP4EQysYKuodw33/GljZXjo4rFP6qF/A30OaVrKdWzQLyjCnBZOBZY0gZUkWAGrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=irltSy6u; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a46f0da1b4fso656747566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 00:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711437667; x=1712042467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gQvyjL1JP7dUtLIsTDE7fRpuoDc199wdAbqg5zYn6Ik=;
        b=irltSy6uJhIHdGcQ5/6QOVc9AwQNO4LxBX2gf/JmXHc4RN4YX+6PcggsiOWogiMR5H
         je7Qbpw1DGA9H/PyE2wNn8SbCtrMqEgr0Vrjk4PqGE53YYGWH0zUUj6UhtWosuaw9e9D
         bz42zmAimXkQR0W3frHsAgyw/E8APG74N3xbLvTHBze5QHHn2C9s6X60+pxan7HXK2H3
         KBqUaeuKwjSRwB19ozg5AxzlaCaBSb1yXEbx4H4d06GVOor3jx37hYsNZvkBSnIOK6Fz
         f44lHPG8yCXsgxu6Vkidmx1pTMOrl4eSqo8qieXeSSKcZoaYJeWLz3oKiTaV+s9gkSnK
         Y2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711437667; x=1712042467;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQvyjL1JP7dUtLIsTDE7fRpuoDc199wdAbqg5zYn6Ik=;
        b=JbhRlQy/jlVDuPjUvcvynQgnOUFo4RXVzxN8HN0Y/G5iSHrMoT0fEuN7cyQDIvv6D3
         kGtqgC5qQzXVTH9hUsyXyep1Ab3x7BDKvlHmjiAowmahEQ0ps1fpKYBZHyb4sk3z/hm/
         EtZE/bP0ynq6AHuiVgzJB/5OfJ8F68b/AqvwlWhWjdzo0jm1gp89xOSXS9peaZvbzkBP
         X4rtdG4K90t0Z5QF/0SczHIPqmDHUszJjwfvbvchWTu+Jy0DCVtx7nsyo7z1nqmF1+Ps
         T/0CCpkluEFq2z3TGlrQIMLSWldUq+6GlbF3Kakf++TgYogGtr47FJwwGs0R53hjOjpU
         sT8w==
X-Forwarded-Encrypted: i=1; AJvYcCWXxcRrOBk29LeNnuw8jEgRoBSGpC4RuxxiZfHN7NJhPYcNzfWlMTIN9UGcxmtriQW2gVl5O2uJJt+SvDVDSqIbn4vmH6E9RYaxyjR9
X-Gm-Message-State: AOJu0YyOp3iAB0UdnA4mYBRljqfyTAlB6Gu+k8lwddGCkymv8Hl9jDyw
	Iu+VD5NFbzmJ975P/0tJ6ib0oe0WR/Nn1cGsm9Wb1pMh6r5DcTlMWBQ09s+AysU=
X-Google-Smtp-Source: AGHT+IEhtVX/jI8OUqRWaBRSZSfUA30w4qKYQxo1re+CTMiluCxWmSEsxrzpWxVNfeEH7B0QJTbfZQ==
X-Received: by 2002:a17:906:3b92:b0:a47:30b2:3af7 with SMTP id u18-20020a1709063b9200b00a4730b23af7mr6241925ejf.45.1711437667166;
        Tue, 26 Mar 2024 00:21:07 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id cb26-20020a170906a45a00b00a4660dc5174sm3909716ejb.51.2024.03.26.00.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 00:21:06 -0700 (PDT)
Message-ID: <58ec79cc-150e-4fef-bb4b-9d29901e9a04@linaro.org>
Date: Tue, 26 Mar 2024 08:21:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: hsi: nokia-modem: convert to YAML
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240325-hsi-dt-binding-v1-0-88e8e97c3aae@collabora.com>
 <20240325-hsi-dt-binding-v1-2-88e8e97c3aae@collabora.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240325-hsi-dt-binding-v1-2-88e8e97c3aae@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/03/2024 22:45, Sebastian Reichel wrote:
> Convert the legacy txt binding to modern YAML.
> No semantic change.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../devicetree/bindings/hsi/nokia-modem.txt        |  59 ------------
>  .../devicetree/bindings/hsi/nokia-modem.yaml       | 101 +++++++++++++++++++++
>  2 files changed, 101 insertions(+), 59 deletions(-)
> 


> -};
> diff --git a/Documentation/devicetree/bindings/hsi/nokia-modem.yaml b/Documentation/devicetree/bindings/hsi/nokia-modem.yaml
> new file mode 100644
> index 000000000000..c57cbcc7b722
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hsi/nokia-modem.yaml

Filename should match compatibles. nokia,n9-modem.yaml or nokia,modem.yaml


> @@ -0,0 +1,101 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hsi/nokia-modem.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nokia modem
> +
> +maintainers:
> +  - Sebastian Reichel <sre@kernel.org>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nokia,n900-modem
> +      - nokia,n950-modem
> +      - nokia,n9-modem
> +

Aren't hsi-channel-ids related to hsi-channel-names? If so, they should
be here with constraints.

> +  hsi-channel-names:
> +    items:
> +      - const: mcsaab-control
> +      - const: speech-control
> +      - const: speech-data
> +      - const: mcsaab-data
> +
> +  interrupts:
> +    items:
> +      - description: modem reset indication
> +
> +  gpios:
> +    minItems: 3
> +    maxItems: 5
> +
> +  gpio-names:
> +    items:
> +      - const: cmt_apeslpx
> +      - const: cmt_rst_rq
> +      - const: cmt_en
> +      - const: cmt_rst
> +      - const: cmt_bsi
> +    minItems: 3
> +
> +required:
> +  - gpios
> +  - gpio-names
> +  - interrupts
> +
> +allOf:
> +  - $ref: hsi-client.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nokia,n950-modem
> +              - nokia,n9-modem
> +    then:
> +      properties:
> +        gpios:
> +          maxItems: 3
> +        gpio-names:
> +          maxItems: 3
> +    else:
> +      properties:
> +        gpios:
> +          minItems: 5
> +        gpio-names:
> +          minItems: 5
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    hsi-client {

This should be "modem".

> +        compatible = "nokia,n900-modem";
> +


Best regards,
Krzysztof


