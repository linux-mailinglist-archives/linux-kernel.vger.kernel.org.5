Return-Path: <linux-kernel+bounces-61179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70910850E6B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4737E1C2028E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A94A12B7E;
	Mon, 12 Feb 2024 07:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JllIGDov"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE7710A3E
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 07:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707724790; cv=none; b=S5ZLmarzvlSI3mdNNBsatpz9/YRYIbRejbapkL3dsEZ848ZeKNpExMzfyg4seHXOdXLUYFAyhK+gNmaf/Q/jRutuUShDjkvjRQgq2WoVgoctzRqtYGtTXdDRJEhNCkOXZhGp//EP9R8e09e1rTk/Mj+kPIwTKzUBoeXsx3P/Rb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707724790; c=relaxed/simple;
	bh=S2Uqhyu2AZbHS9NIPD1aKC5+EfAw/ekjc23uBrJPgiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpG4+UmL2qcfFQfpSoZZ3fMgZAGNYhmD/rM1LGKnqAR/NoRwV1L4bNKh5VFVBz86wjWZ/MrUuFHOfOKGyZP4zl6rOeNrxfrWAiqzblSEdkCl70KnRNcqKuwrt3HR+bRWTIQmfWEpEt2LLl0gwsZub0wA1770U/mYfSVKvVAyWAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JllIGDov; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-410e8412b54so2346225e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 23:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707724787; x=1708329587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rFvdRy8kkXcwjev+NaWwc97EXhX6CAgZBmzJo32Ct9A=;
        b=JllIGDovvRNoispunlVlvPvkiN+hnrDGkuRl1L104oclNXQSclLpkDSdFLFaluRdL7
         /KnjKtuUqb4Hviy+OFwH5AcoMVWZ5rzuDPk/lQ9iMBib0tIIoMONAk0qwskqiRL2BzTu
         6vQVDiA49XVaieUhcNGld1XLMFibF5GjIzOycOVlWW0dNmqsbPEu+Hv1NLGoAYmdkjax
         cDhmaX3tcsds3JPgGI/KPcovGsm3W6qj9hiVJVdJFzSriYMwmykN0ht/d0lyx7izdZM0
         FLln6x5LTz/dH/n1YLcn5QuH/r62Rt4nDQUrMIOTDBdeJRS6JWsUfbkSGgrzrFk71NWj
         gEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707724787; x=1708329587;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rFvdRy8kkXcwjev+NaWwc97EXhX6CAgZBmzJo32Ct9A=;
        b=nmZVZoO1aIVyKkimTSq5oqeElxqVevrHSxHaCqlMN9jSkFP4fB4EaCD4IOYHJQxNww
         OKe799d9aPDR/E0gOdkOmX34IqFnDZASENiroJ+O9L0sK72MsHVavX18D2Och7uFhTHc
         zAXfysZo37lkSglEDG9jwa0jqQymc/W9X+sTWUIOGXJyMsVtqn81bvXski63axNvjS+E
         YobYgKqAw/ip1e5ZvPN6n5o7/0rLFXboS4MYrfsWCPwIfh1uhQSOTaGTRwG6jDvUu3++
         UMjY3OKZVxUjY4CjVh4tIb49w9EJKiksSunJ0Mf20M9sDUoPnTGo5uNfvojLX5QL3I7F
         uNaw==
X-Gm-Message-State: AOJu0YxxqxJU4fpXOnW6Yz02mcHM2W+bm5AZM8S+pfwpS+0RiIBIyfdo
	PXijMcF8qaLMSQLtNwhzmAj4cFs0aFxcaoHLQM7nACPkHywkiojfoIdtTFzCrBc=
X-Google-Smtp-Source: AGHT+IHkBmADWXy0XjDn8+WWf5skCrskTR6akY4ui31c/2B8oAzXzgBlezeFaFPBQq3X9EgwrytmcQ==
X-Received: by 2002:a05:600c:474d:b0:40f:e40:b53d with SMTP id w13-20020a05600c474d00b0040f0e40b53dmr4354424wmo.1.1707724787175;
        Sun, 11 Feb 2024 23:59:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXQeLKOtb4h7CMVYe55f+p3T0oAu5nPFqhmpU+MBCr2NfxZfKC5pyAYalum/4wPJO/+KKYitfIK3zrMBeJlv7jCPfNyrT6L7cEALowOMAPAPWkLzycYmZyUKRoW5LdVMGCYBYfd7W8n4JcPKWAq6V+orwy00lBtP1VMi1xekfLz5SKSLzSkMiraefqtp3I/0dYfKGmy0U0THjU7f5fwZRQr2bq0fjV3HBWf4TE2aHCvCaTCDjucJpmT/5VRU48DnOY/VU94K1fOcMIY65lPWhnF9ifDu/jt+nDqWFEhjD/Nr+CGZ+y13znGc+ggZWrYeXaXo6U7Bv5GaSCKZo0EgcQg/AG/yWmvGoJCSN7FUxg=
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id jp25-20020a05600c559900b00410c7912c6esm2886372wmb.14.2024.02.11.23.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 23:59:46 -0800 (PST)
Message-ID: <954c5cd6-e254-4c81-bfbd-417c6e0a0c24@linaro.org>
Date: Mon, 12 Feb 2024 08:59:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] MAINTAINERS: Add an entry for AF8133J driver
Content-Language: en-US
To: =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Icenowy Zheng <icenowy@aosc.io>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240211205211.2890931-1-megi@xff.cz>
 <20240211205211.2890931-4-megi@xff.cz>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240211205211.2890931-4-megi@xff.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/02/2024 21:51, Ondřej Jirman wrote:
> From: Ondrej Jirman <megi@xff.cz>
> 
> As I am submitting the driver and have the device to test. I'll maintain
> the driver.
> 
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dc5ca7a042b5..cc691f61a77e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -579,6 +579,12 @@ F:	drivers/iio/accel/adxl372.c
>  F:	drivers/iio/accel/adxl372_i2c.c
>  F:	drivers/iio/accel/adxl372_spi.c
>  
> +AF8133J THREE-AXIS MAGNETOMETER DRIVER
> +M:	Ondřej Jirman <megi@xff.cz>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml
> +F:	drivers/iio/magnetometer/af8133j.c

Your patchset is not correctly ordered. There is no such file here.

Best regards,
Krzysztof


