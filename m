Return-Path: <linux-kernel+bounces-108687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E38F880E7B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D659B221EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5853A1DD;
	Wed, 20 Mar 2024 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DdyUyue0"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1747239FEF
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710926659; cv=none; b=WAgi610ednqVA0Xy2CUYAfpORi8gZ1Fvqv6wZCCT/HqZ1jEW1dEY75cPtl6i7D35crjbPnzC8DTAvPHVwFNa/6tBQKzSBYNYLWdpD5L0qK6BQ6lzFXtWZUATYkmcc5xEqw7+wH0H7Z1d4w8fU0NnfZsbirHmDDP9LtnT1Ny0B3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710926659; c=relaxed/simple;
	bh=+igU+6dI0dNH8oWVQzD11cFNcaUNm31ZLdGo9Y2O9VI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQwo84zBYcmbhkrS0BB2Tk9gqqHe3Kt26XFOoZtea1ABCLwmlgxP1UFuZ2tLqHI+IzBVw8Z/mwkQ+4OsiXKA3xnTCGBnuupxPmSc+3SD40YI35EKcEbpY9GsAkNNOkv+y14Eu6+HUaTw7I/GLQ+Z0mO56AN5DBtOgMqL9Pr2bDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DdyUyue0; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-563c595f968so8157541a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710926656; x=1711531456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VAFr8wbXy6NQ4Iu6FgvZQ1njUKht2mIknb8qM/1X3aw=;
        b=DdyUyue0XCe+JmmQZaJRkLHOpMt3LzroVXf3/wrEebFgUIDjztV07QWqY6hzFlboSL
         wfAHe12h/ek/ic4dCRZdmTVrbQs8FLW2z9reuH7qUjvmQilze83KziI4JmT4j9csxOuq
         3KSC4lRf7M/G3rmLjIf//5c2lMh2M13Vv3mo6urKZ2961UC/JwgNByBoB5j6gBaiIuoL
         wPOjgPXD1gBBLAQQ/58ysW00xDARs66TLCOI//JK69nnwYu9a8SVM4d4ZYPntd1QWdcF
         pqOZ4FxbR10MS6wmEcAXwLAckqGs0ScgNEbNDKNtiZTrNFdMwoTA22dtzyIvG0zEY2vT
         kgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710926656; x=1711531456;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAFr8wbXy6NQ4Iu6FgvZQ1njUKht2mIknb8qM/1X3aw=;
        b=qi3u7wcbqs3uBaMMNbqee2+gVMrTf0aFnQjmfTHoiw0uwTutPWLl6OQnqdzmdW0+z3
         LGHxJ2ni6WhPZbXYlbrOqXzPyIC3z7qzA1QOukgEKEjG0YsDg35jbzUDsArcmgZPiwdE
         060zaP8KqDQf0sC5UmXjvEmGxJP31Y9odrfwMwl8NJJCipeIzqeAAOV1JRlqUQW9FS4W
         tT5fwmwOQ1Nxd/vFX6SA9BXgPI776Q/pi2jjA3d2ajMk9fcj5SZK0gFQU+++aoW3mdfE
         JBH0THTFohR/XIIWxySzb4uQXwvK3P+6o7zWO6Wg0huIWVmwwAFyl/MqndfqRJsyhawN
         ppdA==
X-Forwarded-Encrypted: i=1; AJvYcCUX7rdaJux4n/ZqnuoXiryI5UaF3BZop0CUsGdj1CwIEczgKJAYVcvkKaNsIWh+KwEAvN0aNzaBkuSzDR2CCkaGgwjoeLRJB6HcFp4j
X-Gm-Message-State: AOJu0YzYHXyd+Uz0n1zx4ii6IZXfybkGb0RgnQAkHZ2CnJPIkPEcyepY
	pGdL9FB5wNLMs/Zh/p2vDbc4RUGwb9gfA3rXv8LU+AgBJESxo/yOZTWID85FcDE=
X-Google-Smtp-Source: AGHT+IG1wkMXgCHtI0CeuvdQka+gfmqoNMv2X0/WgV8qEvyK5YKY0Mc10OMvoyj9Y9+OBFuqrFRpHA==
X-Received: by 2002:aa7:d3c8:0:b0:56b:b7f1:8077 with SMTP id o8-20020aa7d3c8000000b0056bb7f18077mr91036edr.32.1710926656411;
        Wed, 20 Mar 2024 02:24:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id b70-20020a509f4c000000b00567c34d8a82sm7036077edf.85.2024.03.20.02.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 02:24:15 -0700 (PDT)
Message-ID: <f4f23f46-7821-4e71-9b9d-1466bd92efc6@linaro.org>
Date: Wed, 20 Mar 2024 10:24:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: S32G3: Introduce device tree for
 S32G-VNP-RDB3
To: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
 Wadim Mueller <wafgo01@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Chester Lin <chester62515@gmail.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>, Matthias Brugger <mbrugger@suse.com>,
 NXP S32 Linux Team <s32@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Marek Vasut <marex@denx.de>,
 Gregor Herburger <gregor.herburger@ew.tq-group.com>,
 Marco Felsch <m.felsch@pengutronix.de>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Matthias Schiffer <matthias.schiffer@tq-group.com>,
 Stefan Wahren <stefan.wahren@chargebyte.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Josua Mayer <josua@solid-run.com>,
 Yannic Moog <y.moog@phytec.de>, Li Yang <leoyang.li@nxp.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240319221614.56652-1-wafgo01@gmail.com>
 <20240319221614.56652-2-wafgo01@gmail.com>
 <a5268bcc-144b-4e86-a13a-33d976368f06@oss.nxp.com>
 <018d1b9d-7957-4efb-903b-2e510db1ff80@linaro.org>
 <6830dee9-2378-4742-8ec4-aada9b5aba17@oss.nxp.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <6830dee9-2378-4742-8ec4-aada9b5aba17@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/03/2024 09:24, Ghennadi Procopciuc wrote:
> On 3/20/24 09:49, Krzysztof Kozlowski wrote:
>> On 20/03/2024 08:00, Ghennadi Procopciuc wrote:
>>> On 3/20/24 00:16, Wadim Mueller wrote:
>>> [...]
>>>> +++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
>>>> @@ -0,0 +1,236 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>>> +/*
>>>> + * Copyright 2021-2023 NXP
>>>> + *
>>>> + * Authors: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
>>>> + *          Ciprian Costea <ciprianmarian.costea@nxp.com>
>>>> + *          Andra-Teodora Ilie <andra.ilie@nxp.com>
>>>
>>> This pollutes the content of the file. Please make them part of the
>>> commit description using 'Signed-off-by' tags.
>>>
>>
>> No, that's not how process works. SoB are part of DCO and Ghennadi is
>> allowed to skip them. Just read the DCO. Don't add fake SoB tags just
>> because someone wants...
>>
>> Nothing is polluted in the file. That's what this section you have (if
>> someone wants).
>>
> 
> I apologize for not getting it right earlier. After reviewing the
> information available at [0], I noticed that it suggests using
> Co-developed-by and Signed-off-by when a patch has multiple
> contributors. However, I could not find any mention of the 'Authors'
> section in the file although it seems to be a common practice.

submitting-patches describes the process, thus also patches, but not the
Linux code. Whatever is in the C/H/DTS/SH/COCCI code, is independent.

Best regards,
Krzysztof


