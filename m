Return-Path: <linux-kernel+bounces-107058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF31B87F70F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5067FB21E17
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468804654B;
	Tue, 19 Mar 2024 06:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SSh/Aj9t"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE6245946
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 06:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710828206; cv=none; b=sF2r6j1lI6Cl2LfjWbN12ygKWqwCBEhBQ5wwEIhDjg/kxQlE7c+Z6VGM5fD6BdIi5vBsrK1fI1QuCvyLjS+aPdmmxRjsLbEks44Agw+W8a5HniAAS4GQM7Xsbbd3fqFDdtM69n+yLHpUkcIWfhYW2bJgbAxxNa+PV/zSM6FdnXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710828206; c=relaxed/simple;
	bh=DQC3+VXKo3aW8ptggLOUgo/JumZxKk2Vmn/5t4lQ9Eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jmSQCBtpAL1XDtd/pHxBRTIQ+YRTg2mV673a+Ddd6NoSyH/PRXIUlExenojfLtD9TJocvih+zTzYPFlXFX9mOBMB+VU9FX1JMG5ioHJ8TUjMmfLXbF65+KfBmDHgFI5uOMfNvxPTSzmQHKbrSe6LR9TtNC4lpxcp37LChPXE6/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SSh/Aj9t; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d476d7972aso75209791fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710828203; x=1711433003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vi3INY5RtHvjWqI9t0Ke3Y4oNyiWfwmYoj+HZm4JYcM=;
        b=SSh/Aj9tXS+vT4rA+DUv3D/D10JcBJ6fJdqibFQiI0igBH2My8OQqhrZYrgkcEzsc0
         UENS3KhGq78Cezpw2lanF792OrVUMy3mwCg2dUtSaBExI1aejGZyvD3FpmNxUKiJz6vF
         GvvGRH2MrNkgg/MmLc94rf9NKsD0kg0fY4Jn6jBXHFW6rP5xibwXQYH1L7JjELPEPYZs
         8gZVPN4H2JMD+hQcPMN5XETlSrg8KqDvtzytvlt/rlyw9BhfK59ynDn6Zz3Bhdo53/Ql
         cHTf1bujznnoKDzL04+NzMOxjf3tx5f9bj8KanLZQpiF+7NCfDD+6lNdJBk7kTMWQSvD
         kkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710828203; x=1711433003;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vi3INY5RtHvjWqI9t0Ke3Y4oNyiWfwmYoj+HZm4JYcM=;
        b=e1cu4du/HT5VfjLengDORmKZbTqzNkMwUDA+AJZSZ/+N7XL2Jr+lE8ItsDmr8PplPS
         tZs/zIyTl7lzmVwxEgRnvLOEsdRHRhwX+EbezdPgVbGbmJQurNtlSLaeFRsMJ6Wq8pdr
         PKHQ0fpiLEcQHqaZSVYN1Jq2LYeoo3cJGQeduGPmMH74weps9Ubsmoz5NXTDCsVRApgr
         wXoWsuEI7Byn81u2P4eoPxZzgJWz5c3P9/4aXZ3XxZ30wa7zduAnRBkdMffcHKaG8LGE
         aigBOShlrBi1MAiPSsaAjZsfBEknsYCst9VcYY4JsjlhfuPhlpiBrobQU/pkvVsJUj0v
         ZLbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfiNacQNW3WWshi91XkLQRXr51XiGfO+HrOWH9c2nZMcM1b5q3MmLOe59jBM8boowGWL5jKfyWpniMXDTIoZt0cZqF+7L0pmNPBMmU
X-Gm-Message-State: AOJu0Yz4f0SQQjcnhLDOG3s4pQQnFDz6L5tf+htcEKLworyRQnjNj3JM
	FHdUclXBWZfbTr49zcak7A1hDfqrO1JEu6c0WM3VDoU3eKilxi4qBjBDWikbDKU=
X-Google-Smtp-Source: AGHT+IFg2ZaQvk0LmqIATwbus+yUJhHbwfmvSIiTWVjU28ygIGGlxOIUKCVknHjFhDQ50NFtsA8Nng==
X-Received: by 2002:a2e:7217:0:b0:2d2:7702:cb74 with SMTP id n23-20020a2e7217000000b002d27702cb74mr1138571ljc.20.1710828202674;
        Mon, 18 Mar 2024 23:03:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id a89-20020a509ee2000000b00568c299eaedsm3347638edf.81.2024.03.18.23.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 23:03:22 -0700 (PDT)
Message-ID: <1be08004-fe29-4e0b-b0c9-7cc7af15d0b0@linaro.org>
Date: Tue, 19 Mar 2024 07:03:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] dt-bindings: misc: Add mikrobus-connector
Content-Language: en-US
To: Ayush Singh <ayushdevel1325@gmail.com>,
 open list <linux-kernel@vger.kernel.org>
Cc: jkridner@beagleboard.org, robertcnelson@beagleboard.org,
 lorforlinux@beagleboard.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vaishnav M A <vaishnav.a@ti.com>, Mark Brown <broonie@kernel.org>,
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/TEXAS INSTRUMENTS K3 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
 "moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
 Vaishnav M A <vaishnav@beagleboard.org>
References: <20240317193714.403132-1-ayushdevel1325@gmail.com>
 <20240317193714.403132-2-ayushdevel1325@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240317193714.403132-2-ayushdevel1325@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/03/2024 20:37, Ayush Singh wrote:
> Add DT bindings for mikroBUS interface. MikroBUS is an open standard
> developed by MikroElektronika for connecting add-on boards to
> microcontrollers or microprocessors.
> 

..

> +title: mikroBUS add-on board socket
> +
> +maintainers:
> +  - Ayush Singh <ayushdevel1325@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: mikrobus-connector
> +
> +  pinctrl-0: true
> +  pinctrl-1: true
> +  pinctrl-2: true
> +  pinctrl-3: true
> +  pinctrl-4: true
> +  pinctrl-5: true
> +  pinctrl-6: true
> +  pinctrl-7: true
> +  pinctrl-8: true
> +
> +  pinctrl-names:
> +    items:
> +      - const: default
> +      - const: pwm_default
> +      - const: pwm_gpio
> +      - const: uart_default
> +      - const: uart_gpio
> +      - const: i2c_default
> +      - const: i2c_gpio
> +      - const: spi_default
> +      - const: spi_gpio
> +
> +  mikrobus-gpios:
> +    minItems: 11
> +    maxItems: 12

I don't see any of the issues resolved which I raised at v3. I think
Russell pointed that you do not have EEPROM and that some pins are
optional. You do not allow that.

Plus I don't see him being Cced but he had quite detailed look and
comments at your patchset, so *you are supposed to Cc* him.

I also do not see Rob's comments fully addressed.

Do not send next versions before resolving previous discusssion.

> +
> +  i2c-adapter:
> +    description: i2c adapter attached to the mikrobus socket.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  spi-controller:
> +    description: spi bus number of the spi-master attached to the mikrobus socket.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  uart:
> +    description: uart port attached to the mikrobus socket
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  pwms:
> +    description: the pwm-controller corresponding to the mikroBUS PWM pin.
> +    maxItems: 1
> +
> +  spi-cs:
> +    description: spi chip-select numbers corresponding to the chip-selects on the mikrobus socket.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    items:
> +      - description: chip select corresponding to CS pin
> +      - description: chip select corresponding to RST pin
> +
> +required:
> +  - compatible
> +  - pinctrl-0
> +  - pinctrl-1
> +  - pinctrl-2
> +  - pinctrl-3
> +  - pinctrl-4
> +  - pinctrl-5
> +  - pinctrl-6
> +  - pinctrl-7
> +  - pinctrl-8
> +  - i2c-adapter
> +  - spi-controller
> +  - spi-cs
> +  - uart
> +  - pwms
> +  - mikrobus-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    mikrobus {
> +      compatible = "mikrobus-connector";
> +      pinctrl-names = "default", "pwm_default", "pwm_gpio","uart_default", "uart_gpio", "i2c_default",

Please properly wrap your code according to Linux and DTS coding style
documents.


Best regards,
Krzysztof


