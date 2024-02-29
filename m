Return-Path: <linux-kernel+bounces-87202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A1886D107
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B7921C210C9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C76870AFD;
	Thu, 29 Feb 2024 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CIObHfdw"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3B470AEE
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709228618; cv=none; b=qDqqizWLh2u+Y0oXacf2fMMOL3U8GnzbCTg8mXPIZCWPBR9tJ1YMXA9D12E299FsWoj6eCE5RaFi9pmQLbMrwbg0HW0oKOX5igpNcn/uX9TeylhHqSJV3wQY5QHfjdAUY7v80zuWUIsedWUFZVeduTPqP/DLYNmoiJRnoyUFa3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709228618; c=relaxed/simple;
	bh=IA7WIBsWopO0bTAcjK6tZFMHJB3vGqdbyrYnHgFSrt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IGktv14CdhEFb5QHZmFAzfSFx668p6gUmyVHViTfuRkuR0YgW1bL/Xg6/CqBgrMSmUFZl9wSkkwLxlvmEN7FPMpIXbUCjnz8jBCAw74z6kH+gVdW0Hv2x3hBvQqJnXWFN5hzWM869Viel56hHTKZYb/MvvV5+aQhPhNnQUX6ksA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CIObHfdw; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3d484a58f6so201611066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709228615; x=1709833415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QflVlc0dU41Xz+jvDjUpE/rCGsaEEg8jxGJoUeKeatM=;
        b=CIObHfdwRKqJ+HKuPCqB/LXXhjZng0qMqm5DyFSdg3b0VuCDw+roUyacCNbappfbp+
         9SLZ2CFYp8SMGTMoP0taGSeysI9k2bbcri9tmDsA2RiGnrEMD0Ua1tahZO2QjhAUrNWW
         O1AHWlYZ0qlaOhoHsBpNgPLrAcYke1hpPpHmgjrik3Lo8zMDSy4UUxdXGcaTcCu3GON2
         TetdA3diXcRn9PSWmUktjCKALuLEqc8zomzc9AtJMfBzylCfAsirCqiu28LEOBReFIG5
         wPfhhEtkgRhli/nRXts3aLMa1v2oEgSqBML99hQHMqYyHijQL4tobqY1FFJHpi/HzNl6
         qYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709228615; x=1709833415;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QflVlc0dU41Xz+jvDjUpE/rCGsaEEg8jxGJoUeKeatM=;
        b=sWImyOmHfjR/qm6ybw0vPs4+ks3FaqQIeaJZPAIkvzxHauGVFr/MNLqSxOIXngHpZz
         1GDcex80S1+S1neaHMup+rZplFkuw9F5x08WjS7t6zIklyACRx72KPOx686i0pzDKkBM
         6n60RcWMhe6gWIC4foubzZOVemI8joUNb1BQ/eGI45c1x5vniehON/sMVddrYgV49Ynp
         OBWf3J/0hjr7FoD/Bg8ku89utrFN/RU0Az45aERWhnHoOwti3ayvph2xTB6GZLYQsfxW
         FvLQjmm/755eBxMB32ve0WVMd5ZhS8Y0ofQ1aSTOLCIXRkDtlkDHQ9LpsckLmAf1HQKX
         0APg==
X-Forwarded-Encrypted: i=1; AJvYcCVDHWqwD9hlvMhEOB2GoDwpgo5rTh8OiRZKcQBmGjk8hSEYo/ecOdaNQqOwgn6k/oI6oxxnR3b28GztiJg8HwZdusRWGcpEPaoVGzzy
X-Gm-Message-State: AOJu0YyP5XYdqz+Xlleqf6KBhrB1UILvPVy4Y7073RsYkeurRJlZeBak
	VLtxPcRuHOttYhKPUO0Z2DRkt8W98JW8jeK7eetQ4gcFPDJh2SatVPgzm3lzTYo=
X-Google-Smtp-Source: AGHT+IH8TclhfzAYOVPJl1M8hMQr/xyEXHvah/7qumhsG9GDzqB9Bq+UdrM6RJHKm7j4x060McfQxg==
X-Received: by 2002:a17:906:4e88:b0:a3e:b439:6c8d with SMTP id v8-20020a1709064e8800b00a3eb4396c8dmr2112924eju.25.1709228615313;
        Thu, 29 Feb 2024 09:43:35 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id cu5-20020a170906ba8500b00a440ec600e3sm880825ejd.121.2024.02.29.09.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 09:43:34 -0800 (PST)
Message-ID: <60020f66-b803-4dd8-805f-8ffb902811c2@linaro.org>
Date: Thu, 29 Feb 2024 18:43:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] ARM: dts: microchip: sama7g5: Move pinfunc.h headers
Content-Language: en-US
To: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20240229-pio4-pinctrl-yaml-v1-0-c4d8279c083f@microchip.com>
 <20240229-pio4-pinctrl-yaml-v1-2-c4d8279c083f@microchip.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240229-pio4-pinctrl-yaml-v1-2-c4d8279c083f@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/02/2024 12:39, Balakrishnan Sambath wrote:
> Move sama7g5-pinfunc.h into include/dt-bindings/pinctrl so that we can
> include it in yaml dt-binding examples.
> 

Nope, that's not a reason to make a binding. Provide rationale why this
is supposed to be a binding.

Best regards,
Krzysztof


