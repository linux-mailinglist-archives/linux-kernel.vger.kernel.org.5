Return-Path: <linux-kernel+bounces-4849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2986A8182D2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A381F27C4B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5D7D533;
	Tue, 19 Dec 2023 07:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wk3uN6J6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBD918626
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 07:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5522ba3f94aso4952973a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 23:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702972753; x=1703577553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CVhHV60PigEjCnDK8L7hqXTWRo72YmQILb8Sn08yTPk=;
        b=Wk3uN6J6wBxD06aO7eOegyTQy7YJgCSAtfCT5gci0QlOoiYIlVQJxU9NrJTIh26ijZ
         jEHX/XCOj1LIsehKG322wx4yKKks8QzBXVeK+lGT99zESt/91pTeePNBbxn9AwSyMVO7
         pZ90CntstUc3qt7xadK99aLa6//HFIkmIikmdOMZZ8jwiIDNKZtga/BgTJZMGDlvm6tk
         JW6jx98i0AJ+zNg53tpFe7ak05x+uGmABFV9N46RH6nnTVj6CwxZhRVAmu8a8xGegKNZ
         G0SE1JOZqg9y7MAMsiIlXhrA7pLg4hbOTaFIuNI2ExRuaXm2Niw5/Q0wuB2NDVEI6t4T
         dIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702972753; x=1703577553;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CVhHV60PigEjCnDK8L7hqXTWRo72YmQILb8Sn08yTPk=;
        b=F3JCo4reK9dSaACzFC2Luf1XkTJW3GnjPzQXaT10xJj+5thcsS6Jm47KtbCNpfg5Dr
         JxCVX6Uwap6uwAmxhgKzRlHUSEx4hzg/LOIgs2q7NwAh+y7tUp9ST18a+qaHh6Omm14S
         ggAFm/euMmVtzpeQKllWjlKBA5Ahb40Q7i5EBmns6cus2ZJoo0xV45c78yUPiz3rhPXA
         s8SZIAdniM1fi+VNIPyyp+rY4yDZMqgdUKfb26jy26RP5xJAbMVRpXkztqT8vkjiE8PL
         HPSkXL741oNR8V7P3bZPdb/wRkFzCDcqNDc1PYotihTgdwXZT6mhhaI/z9Mfu8vqr4IA
         VKfg==
X-Gm-Message-State: AOJu0YweRtrk+9TGoWhSHWhGPa2sgZaD0bLidRXRCEqYYS5UqcI05BKm
	4vFs2Qj0yFjPNqTU2Q79por/qA==
X-Google-Smtp-Source: AGHT+IF0rfrqQrXr4qXNg2bmxw6sC6ayTHxMIj42KxzYzrqZn2bPU5V/FbrO0xoGmw+pF3AD4LLIjg==
X-Received: by 2002:a17:907:bb88:b0:a23:329c:342d with SMTP id xo8-20020a170907bb8800b00a23329c342dmr844507ejc.106.1702972753462;
        Mon, 18 Dec 2023 23:59:13 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id ot17-20020a170906ccd100b00a235b01886dsm1950149ejb.10.2023.12.18.23.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 23:59:12 -0800 (PST)
Message-ID: <f8aaf7b3-fa17-495f-9c1c-9ddf6fb41d8a@linaro.org>
Date: Tue, 19 Dec 2023 08:59:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: add MCP4821
Content-Language: en-US
To: Anshul Dalal <anshulusr@gmail.com>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
 devicetree@vger.kernel.org
Cc: Conor Dooley <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-kernel-mentees@lists.linuxfoundation.org,
 Shuah Khan <skhan@linuxfoundation.org>,
 Conor Dooley <conor.dooley@microchip.com>
References: <20231218164735.787199-1-anshulusr@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231218164735.787199-1-anshulusr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/12/2023 17:47, Anshul Dalal wrote:
> Adds support for MCP48xx series of DACs.
> 
> Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/22244B.pdf #MCP48x1
> Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/20002249B.pdf #MCP48x2
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Drop, you added properties after review! Adding properties after the
review invalidates given review. Especially if you add wrong properties.

> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
> 
> ---
> 
> Changes for v3:
> - Added gpios for ldac and shutdown pins
> - Added spi-cpha and spi-cpol for the SPI mode 0 and 3
> 
> Changes for v2:
> - Changed order in device table to numerical
> - Made vdd_supply required
> - Added 'Reviewed-by: Conor Dooley'
> 
> Previous versions:
> v2: https://lore.kernel.org/lkml/20231217180836.584828-1-anshulusr@gmail.com/
> v1: https://lore.kernel.org/lkml/20231117073040.685860-1-anshulusr@gmail.com/
> ---


> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  ldac-gpios:
> +    description: |
> +      Active Low LDAC (Latch DAC Input) pin used to update the DAC output.
> +    maxItems: 1
> +
> +  shdn-gpios:

Open gpio-consumer-common.yaml and look at entries there.


Best regards,
Krzysztof


