Return-Path: <linux-kernel+bounces-77983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D82860DB1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E642A28543B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75A02E418;
	Fri, 23 Feb 2024 09:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FT3wVYc1"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8296018E1F;
	Fri, 23 Feb 2024 09:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708679548; cv=none; b=pPm+8tsVbd7WSAJG+03MZik9cgVz7CbwLZpPlXy+uwZp4j1zfhOfPwAXlGHhJ4fHE6zNbBC+0tB5npSIaZJkkn/9H7y5eNJxtGSzynnViO1jF/EyGyO2Z8rAqwz01B1ER2QtFFj+HV80uRofI3s9/SNhapfp7jYcA3gz58LknEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708679548; c=relaxed/simple;
	bh=G4e0DwZgzfEkvQtXCdqpbPfV2e/HB+U7McCZKqkKS5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ypt7NozE4Q0pLs6pM9vd2yG0OqgklCNouLfQOc4fj1PoNdnwPqjT+sCfRVmA/3Hox38woXLaiOMDIMpPOCWKFEY290NeZK018HSh4Nd5gLPHA6u0hdX3CSbKD2/C4ZBdy3nQAeorkzcipZcCRDoCZrRJwMwUGCZBLill6LzPP4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FT3wVYc1; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3ee69976c9so23834266b.0;
        Fri, 23 Feb 2024 01:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708679545; x=1709284345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B7TTRKcaKxSX56nYxUFwNeziE4nWg4mzChK8nIy4zQA=;
        b=FT3wVYc1rfYO/pv/LIS8SohVPQ0qYpub9/x6f2R5Ffw1QGs4ql0BACjqEjaNVkYDm5
         mQh04xXpJHjqBpqKJhNmsAYc9NZA4T7WcJ408RiP6sksvsSOV7JKdTaDkhsXSXUsjq1g
         gbHxAjKYhsxqOSsFJCXVFcTU5LInikUZIrfW7P2Tjnab/fOkW3OoMn5Lsl4K0nSDuckY
         xm310U7JGTKzSWC3Avg7iRiTeliw+3+4owAmASVrhMaRD/5Q280p+zzgf7Vw1YjoF7y/
         CxWcPCaruIzgUcm0Y9cgdbXAVivH3/opNio2E2wr7zfT4ygYO8B0jTGlpNgsbw3rRSQA
         XJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708679545; x=1709284345;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B7TTRKcaKxSX56nYxUFwNeziE4nWg4mzChK8nIy4zQA=;
        b=unLQnmrq+rNGHVShnHq8JfF2/mE2uQyv9j+CbJjqrUekVXEEFfwInM45GTWyoq1H43
         vAFOdx353r4laHnRR75LklAjl9YTrMypfqwvwInD5k1djYantctesXEp1a7LPGvz/3sS
         0aMGtYeQ+E2MVw1Px8JbB0sX1VIOxbLOKGen2U32R7ZUiGK7T0A+xjehLF7bZy2LGWKG
         vhIhkgNUnuJIyHK6+poHjI5BHIF42XENlBpplOJYJ8yzi997oWnX/v4zOPhGNMBbkDX8
         5T/L/2LU+IdZwFMSwQ4Z4i+bLEig92IGQOO2bOlL4fjBPHrIaQXXSt+AW6K45OCe396T
         OY7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfDomhN4uCAbVsuDF+aLEAl5FRpU8SNzLHZWPVbvtEBmox8CuC1ZRtCc9uOMRUBHutZrT4uS06SY/MFFBV+N9Ms5B0mR1gaSKDcE0jJdPU77ZZJwbXimVNOVqkX6UOIkoSyKUGKHdwbAAGCNMXlRni1xYDLgpoPvgPqlNPdNJ4NBVw9JKx308CEsYt1LHM4VmZImj2aF0dk7Yjd9wa9mE=
X-Gm-Message-State: AOJu0Yz/stYdTFITH5SuL8VpEkbRTf+1BkfbPJvOZAHnPNOWn1iQlrqj
	QGzPym4OZk+tYyKNXz4Cl1XyVx0xFaAPpI56QSmgROmtu9yM/9wIADabn9a6H+LEGQ==
X-Google-Smtp-Source: AGHT+IGLGCCbkeGXPu88yxO4amYonNfCEP1GxwLzLHGQ9mmrYrc9Jeqmgw1NVCE80CotOUAUFYjZkA==
X-Received: by 2002:a17:906:b2d5:b0:a3f:c6f1:24c with SMTP id cf21-20020a170906b2d500b00a3fc6f1024cmr749600ejb.63.1708679544379;
        Fri, 23 Feb 2024 01:12:24 -0800 (PST)
Received: from [192.168.0.221] ([83.103.132.21])
        by smtp.gmail.com with ESMTPSA id jw15-20020a170906e94f00b00a3e86a9c55asm5116054ejb.146.2024.02.23.01.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 01:12:23 -0800 (PST)
Message-ID: <f2fe30fb-3dd6-4190-8ca1-fc579a06f452@gmail.com>
Date: Fri, 23 Feb 2024 11:12:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 1/3] dt-bindings: adc: add AD7173
To: Conor Dooley <conor@kernel.org>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
 linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Walle <michael@walle.cc>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 ChiaEn Wu <chiaen_wu@richtek.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
 Mike Looijmans <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 David Lechner <dlechner@baylibre.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240222110817.29670-1-mitrutzceclan@gmail.com>
 <20240222-defeat-nearly-f83f8b920f51@spud>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <20240222-defeat-nearly-f83f8b920f51@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/02/2024 17:50, Conor Dooley wrote:
> On Thu, Feb 22, 2024 at 01:07:41PM +0200, Dumitru Ceclan wrote:


>> V13->V14
> 
> I gave you an R-b tag on v13, conditional on the descriptions.
> Why didn't you take it? The only other relevant change is the added
> restriction on channel reg. Is that the reason you didn't take or was
> there smething else.
> 

Just that change. Should I consider that change minor enough to include
a previous R-b tag?


