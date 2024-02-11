Return-Path: <linux-kernel+bounces-60794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C79F850984
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 14:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69391C20A4D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0DC5B5D3;
	Sun, 11 Feb 2024 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nqq/187p"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73B95B5B8
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707659766; cv=none; b=cqCUitfFg5h9m4EwYsnahfS2UihBCuBoHcA15Hhj8DTz/t+ocpcUUQwuvGfbydAyyKe//kZWJcCuu6KBXeH7DUqPBhU8IMzLW5IsRj8UCvrlyzvhkjr3v2GiU/UqlqRibbckCfMwnmmUG0IDjvYM69/Iyzac0hx0/BieMZhUg1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707659766; c=relaxed/simple;
	bh=pXvsImowq0i/i575K7kHTSMoxVErfBTiVGiGOnNGGyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZzRyDIlqLee+TnqLlYZS0jQt1kZklAux9o4Z8OJAHtUe+mL4O+ymlcB4pN4VzNCm4/vGMwYABL4rdgLcZGaVvayY1YvzPxMPtiQlQt09oqvVxx6ZO/gOO6s45hMJSAO3fohCpXaWQyZRtudQtDp67lv/Cj0fvaQONJeq7tmGqzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nqq/187p; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33b66883de9so1603396f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 05:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707659763; x=1708264563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QQbDMuCf8echH2vXmVfP4WtPzr419Vx4QeYzyXyHPfc=;
        b=Nqq/187pFvUaUG1/jex3/Y0+oToKc491sJ6qDwnxlhcm5WwpnZJsMQnf/qTTUjqA7L
         LhG6+yCVMdMJxXckCGAlana+qACZWDjkJKxlo+YsvW6fX4Yw+amuTDfkUb1E1sy6Owv/
         JcPmnw0QJxLRt6+kKtjVTW2nCkumTykJdjJgQi40gmHb8K9d41WjwgNBlx8xwuH+YjDo
         SzoZ5pfZfUCxrFcWbJOfgJRwh2JkYQB3C6pcAkDa+1myL16JeEw3MuBLzdRG13TzZZA6
         yUEnj5WskH7H+LQPJvNX+xtAe/qE9KaWSYM9rNouW1X7EKXzTgM5piMcf3OpJ4XObfjt
         iVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707659763; x=1708264563;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QQbDMuCf8echH2vXmVfP4WtPzr419Vx4QeYzyXyHPfc=;
        b=NshfrhQvlhmviN1g54CskQNlwDaCEROSVSojN4n7a188s8ikZRDEYSe8aQlL2do1yH
         KfrWUR2XsZpDoDPPSLXKmA9dYnQhJVeSdKo3pr4htIbGOIGYf7l9F2MJn2+B1rLXBfXL
         ALBPEcLFQzbiHqqVaFZ1ovL6X1E+imQZv4CinpK/me6xrtNedR59AviF6aawUtUO2blB
         czF8oBLzEmeXbhKCQgbGkPcH2JnocUpJkN69NzLQCallS99yZWQjzcpKIxCjGG+HrGdy
         z2iuQNAXls32NG+urjmM9oE2kFIi6tvuLTO6z6wEaa8YtB/ZsxhrcUoMa7egEMWG/fwx
         gn2w==
X-Forwarded-Encrypted: i=1; AJvYcCXLD2ZkAN8Db+47P8JKxKxzQUJeRvF+MJU82H/C3xzCBFbO+EXxzQc0iud1nqsv7rZmzRwYM/jKpTFNpwOu3ER37JFmuPwdMVfbkBlS
X-Gm-Message-State: AOJu0YykgxJZvMHc2g9zhHIvl/bG63CmcImmki+ojDObuPksJjF+b39B
	4rkYSeFLgVViwPhYENvdciaZew3p6Mud8V77/EgtYVnHUsbpYD/+0c3xDQmXQR0=
X-Google-Smtp-Source: AGHT+IEcqc+r1s7VzO31zVMQiEdZhbAY1dcw4wyYDP5pGtpMY4RnCkIYujTW1p+Ero6RkbKNTFkCng==
X-Received: by 2002:a5d:58f0:0:b0:33b:279a:5c99 with SMTP id f16-20020a5d58f0000000b0033b279a5c99mr3049176wrd.18.1707659763180;
        Sun, 11 Feb 2024 05:56:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWHIMkAK5n7prPrl8eptYlgnUtosbcSd6JRdRnczhvvfF3dJn6EAwAkw4KVb5DEmbXam5CGGX0f5xPPTb4hvTJXfrEgUSMexnB7V/rYjbracuZxeknQvRMkx3Gqxxecame8dMAmMj5Fo+F3O9fr5ao1zLvba/trgFKkljXv5efpVMLhtrVc2qrQ91xMHxGxWWQ++PJuuzrc87mop3LJCCq1KEhn6/8e7KiulRSmeYhbHq2hrnASRjT1hOUylaUzwMqByJp94VcCBM+So+WPwjp5JdJ5SoD35b0y3KPE3iTV3fcu+kMV+vzhVl/wkw8Ty8wZPTwuxMpGSxGOX6vaEd97QPi+t+HUPHjYCnMEcFtazjjvwGPSGj763TzNDbMGHfuWh1TGfXblRhp5BvGzADqnBROHMBwoj5UY6ZtJA/biEq6BHEqwhJmQYlY8wXg4sajVoWps8e9z205MGQfY
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id dv5-20020a0560000d8500b0033b483d1abcsm4297527wrb.53.2024.02.11.05.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 05:56:02 -0800 (PST)
Message-ID: <3a662ef2-1888-4f24-bebe-3ce32da9d277@linaro.org>
Date: Sun, 11 Feb 2024 14:56:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: usb: typec: anx7688: start a binding
 document
Content-Language: en-US
To: Pavel Machek <pavel@ucw.cz>, phone-devel@vger.kernel.org,
 kernel list <linux-kernel@vger.kernel.org>, fiona.klute@gmx.de,
 martijn@brixit.nl, samuel@sholland.org, heikki.krogerus@linux.intel.com,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org, megi@xff.cz
References: <ZcaCXYOf6o4VNneu@duo.ucw.cz>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZcaCXYOf6o4VNneu@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/02/2024 20:51, Pavel Machek wrote:
> Add binding for anx7688 usb type-c bridge. I don't have a datasheet,
> but I did best I could.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 

You miss proper diffstat which makes reviewing difficult.

Actually entire patch is corrupted and impossible to apply.

Anyway, where is any user of this? Nothing in commit msg explains this.


> diff --git a/Documentation/devicetree/bindings/usb/analogix,anx7688.yaml b/Documentation/devicetree/bindings/usb/analogix,anx7688.yaml
> new file mode 100644
> index 000000000000..b9d60586937f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/analogix,anx7688.yaml
> @@ -0,0 +1,140 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/analogix,anx7688.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analogix ANX7688 Type-C controller
> +
> +maintainers:
> +  - Pavel Machek <pavel@ucw.cz>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - analogix,anx7688
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1

blank line

> +  enable-gpios:
> +    maxItems: 1
> +  cabledet-gpios:
> +    maxItems: 1
> +
> +  avdd10-supply:
> +    description:
> +      1.0V power supply

Keep description in one line and add a blank line. This code is not that
readable.

> +  dvdd10-supply:
> +    description:
> +      1.0V power supply
> +  avdd18-supply:
> +    description:
> +      1.8V power supply
> +  dvdd18-supply:
> +    description:
> +      1.8V power supply
> +  avdd33-supply:
> +    description:
> +      3.3V power supply
> +  i2c-supply:
> +    description:
> +      Power supply

Drop all useless descriptions (so : true)

> +  vconn-supply:
> +    description:
> +      Power supply
> +  hdmi_vt-supply:
> +    description:
> +      Power supply
> +
> +  vbus-supply:
> +    description:
> +      Power supply
> +  vbus_in-supply:

No underscores in property names.

> +    description:
> +      Power supply
> +
> +  connector:
> +    type: object
> +    $ref: ../connector/usb-connector.yaml

Full path, so /schemas/connector/......

> +    unevaluatedProperties: false

Drop

> +
> +    description:
> +      Properties for usb c connector.

> +
> +    properties:
> +      compatible:
> +        const: usb-c-connector
> +
> +      power-role: true
> +
> +      data-role: true
> +
> +      try-power-role: true

I don't understand why do you have here properties. Do you see any
binding like this?

> +
> +    required:
> +      - compatible

Drop, why is it needed?

> +
> +required:
> +  - compatible
> +  - reg
> +  - connector
> +
> +additionalProperti

I don't know what's further but this patch is not a patch... Please read
submitting-patches, organize your patchset correctly into manageable
logical chunks and send them as proper patchset, not one junk.

b4 helps here a lot...

> 

Best regards,
Krzysztof


