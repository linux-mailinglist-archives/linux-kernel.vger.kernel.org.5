Return-Path: <linux-kernel+bounces-69878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2D0858FC6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0F01C210F6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737527AE61;
	Sat, 17 Feb 2024 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m+6ZdeJN"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143E97AE42
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708177464; cv=none; b=avfcJGLR2sENx+qTAZjExt3FzJkXxthRHXqWMGPHwS8v+eCiUNwaUSLdhcFPW3NFr+ca9lyUYF7vFthS7W0kSnLDl+PAQXwoJkIzBdrRW/qzgFC7h3zLbN9L7CntQ6NhU/T86D1fQrSupm9/Dl2hN6k2lEg+M/zU/O1qhrzCGs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708177464; c=relaxed/simple;
	bh=jqDBJqgKlvag1KhWO6peFd9V0Cferkn6Oel+Js3DJQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJGfub7nsYHR0hbX5PKgf84zUepwxHTafkKgFLvdEgHW3W043ZXj48wv73sBCWmnLZutC7aWz6YWTUg/m/DK3EhdpD7aD87b/vGIAigyarYgnbA+5lXVkdkTl/URcqxafum5f/zR8JOCFaCnmHGaB6BlXwJSawsbZ/LN1sBAzX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m+6ZdeJN; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3cf64f33b3so379618766b.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 05:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708177461; x=1708782261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pKMUwZ7/j4BggB/hg0ZgqRI1UXva3FsZRxnGnKNk5+g=;
        b=m+6ZdeJNsDkpoiWNJhB6D6iHY/YbMr83bp3Tqi6aPmPtnjHMPH0Q+6XYcQnUHPTSG3
         1R9c3AxIV5lyRIizV2yiVHlWhIzep5bsUi7PvwtxVO8BmpiHw8G8uzo9vkCGN2VCz8pg
         LMQ3CouVVVC9Lib8mfIXB1aB+RRZKJh6+QeYbFCMKzewSVLF1obkxIsnccK3X0XJVWfx
         FGV7tl70OjedcwrVOqxMo/RnD8cqo/WKMYBY9FevxvtMy+wEMPiSOfaoHMfBabQyGZZg
         DDADUcu3LN7ftQUxnJA/+QnEhwPLruaCUfLX3wmOQ+YXRmPItauIk+OgdJ46k25yRglW
         SGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708177461; x=1708782261;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pKMUwZ7/j4BggB/hg0ZgqRI1UXva3FsZRxnGnKNk5+g=;
        b=Uzys6OiKChgpoIAI06yqWi+1n9r2+xKKWPbB5R5YegZ5DeGY2KxBGkKqBeV4TnDda1
         vEZjQVyfU7Eu0GkNVfCDPO7FVpOyRxykI/ZoW2EjP3CndAg87NQfUrLlbDbnYEhtdZu+
         32pS7pBlTQQTyXEz3aF9Hxteqc4w1Z+uLLgtcyB/IqPXs1Tf/vWbF7/PkfzNKVRFAhYT
         IOe8Tfx4nimNue/tUSwYnYJ9sB68uJgY36o/ljG+N6r0aM5VQU3kwK4rlpyfv8KwlL43
         b3PP/RMpcZVtYzsifbKaTaq1Yhrj4mTxya8tasGcIKDYDTvynMk3vxhGSdPSnJAClePt
         6UsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIlqmv8DXKoGOjuK9lxQOGFQGywATY0H4wYeb2613x6S4j31h0/ZWYRKzWxSuHW/cA3Cri09CP7e9dgToAGKpCwEJjOCTiTrTbDK5z
X-Gm-Message-State: AOJu0YwdWC7hxPgEU5BUCnMpGd8YbWf1WJkBKbQLlFpgEjJssCnMfDlX
	G9gG5I9OBF/5IVc+f4F7FgH74K+6theykCCCU6jiOfN4htt8HjJ/U3+VfTd7yhE=
X-Google-Smtp-Source: AGHT+IHkR9orOiR/p6P7/0XcclVvFME+BPGbtLnnOa6oXQXqImlP3p/720B+Ib13p4oTpT/jBo1uKg==
X-Received: by 2002:a17:906:cf90:b0:a3e:51f3:e0f6 with SMTP id um16-20020a170906cf9000b00a3e51f3e0f6mr44899ejb.61.1708177461533;
        Sat, 17 Feb 2024 05:44:21 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id ck12-20020a170906c44c00b00a3d59080aeasm1013669ejb.10.2024.02.17.05.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 05:44:21 -0800 (PST)
Message-ID: <b98e2b3c-3b55-40bf-8f5f-974147921656@linaro.org>
Date: Sat, 17 Feb 2024 14:44:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: trivial-devices: Add qca,qca4024
Content-Language: en-US
To: =?UTF-8?Q?Pawe=C5=82_Owoc?= <frut3k7@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Robert Marko <robimarko@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>, Peter Yin <peteryin.openbmc@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marex@denx.de>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 Fabio Estevam <festevam@denx.de>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
References: <ZcH9u7Vo2sFERIHJ@finisterre.sirena.org.uk>
 <20240207224546.44030-1-frut3k7@gmail.com>
 <20240207224546.44030-2-frut3k7@gmail.com>
 <cd8c2f79-2307-4ad8-90c7-747d40f14ede@linaro.org>
 <CAKEyCaAy9U_qQ=pXPYaGetEuuuVuoejxjKPrG92fBFauy1wwuw@mail.gmail.com>
 <263bb77f-b91d-4139-91a5-0ddeda0ece17@linaro.org>
 <CAKEyCaD=2Md8f=K0pfAFmSCQjL0PkBvAzG_g5Me-wpd5iv2rVw@mail.gmail.com>
 <18583e61-bc7e-47ef-ab2c-c669785dfd08@linaro.org>
 <ae0827d9-416c-4547-8882-44dbb46931fe@linaro.org>
 <CAKEyCaCteCG+B0H4DTRtZ3JcU1_-Qimc4iR6UJDCokvvkwPydQ@mail.gmail.com>
 <3a4658ed-1418-4197-8d1d-f35975d8cd25@linaro.org>
 <CAKEyCaBELLgLG3YjqKmDR=NgeBuL1UeL2MEjaVPT0riQANvt3w@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAKEyCaBELLgLG3YjqKmDR=NgeBuL1UeL2MEjaVPT0riQANvt3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/02/2024 11:55, Paweł Owoc wrote:
> On Sat, Feb 17, 2024 at 11:31 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 17/02/2024 11:29, Paweł Owoc wrote:
>>> Can you point me to some example?
>>
>> Please stop top-posting. I really have no clue what you want here and
>> what you are referring to.
>>
>> Best regards,
>> Krzysztof
>>
> 
> Is any bluetooth device connected via spi already supported?

No clue, we have thousands (~5k) of independent schema files. If you ask
about SPI devices, there are plenty as an examples. git grep for
spi-peripheral-props.

Best regards,
Krzysztof


