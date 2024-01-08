Return-Path: <linux-kernel+bounces-19274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 257B1826AB3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3ED61F22078
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C205011C88;
	Mon,  8 Jan 2024 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RVSRE+mY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8580411711
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 09:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2ac304e526so42672666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 01:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704706135; x=1705310935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sCxoHVc7VrLS7iLBgNF0OKw6HEkkczHSNLMUxP93tw8=;
        b=RVSRE+mYp4ukNrxK7jlgK/+0nycCm8hwvbCGJbKRDAmK252mFo1LP0pg+j+QrvMhE4
         79kv/RjNgsqVU45t2IaO1B/EwOHvTQ27GVxSeVqD1EVoliQV7SwI9FQdZMa+W1SpDJKJ
         f30WcBCdGWgck5qthwdvydHK+O8slDxnwO+toeadJk2FDEsve+afMXiA9tbvuOXlwcc5
         9JWpUaeknnDqUhcETdtaKukgWUz5KxIC6c8EnzvcEbRVGhtgnzuShERYPUVftMU1h3Lj
         QIBqUnEFab0Q1Pqt4bp0NMy548CHqhJEu9WO77VHQPzQ9G90V9w8Q0h3QA0dLGCdZX2f
         u7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704706135; x=1705310935;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sCxoHVc7VrLS7iLBgNF0OKw6HEkkczHSNLMUxP93tw8=;
        b=DCtu+4Xw6QH1GnhrvFEbtuOiVqqkHP3DaH9g6SZQH8zCL5r/ZVknV9MOIHwBuCw+oq
         3X86Xt28AaQMxiUSyom5RYPfpAgYAC5f8JTOO5xUUCYbkSI/HwT2GFi6jb6auIa1x6fT
         hsbaUDScKiwqQrcgNhBoUpqpmpEIGvZlSbGAgM1BXT70XNZr6YxGMD4urW5k2R8qu3Iv
         tLJfB3Zsm8jpzm2Hg7nAuYICy/0/w9cHs76YZCJnaRK4VDRksuNw8XznAG5WfFcuCdjZ
         6RmgeMUU3bchTSVuywu17/t4VNUOhdsPitR/UDoyKv4AjNFRkvdRgOuJxm6xx4eYmiMa
         Dc5w==
X-Gm-Message-State: AOJu0YxfPr7UXdim+i+ULZxd5zPFW5kNd5191SVHhy0zvdtC5PoJ1+Ns
	Vi1ahOb5a3EvUiwtocSryeBSWXQifc/tRQ==
X-Google-Smtp-Source: AGHT+IHwU4S4I1heV19Z0QLdMhVFwEJq+K03YVn+huzWZ1vJ3GGhaqP/5IbvyM48ym4ZkAx7ZYH7uw==
X-Received: by 2002:a17:907:9449:b0:a28:ddb2:1fb5 with SMTP id dl9-20020a170907944900b00a28ddb21fb5mr1859548ejc.35.1704706134662;
        Mon, 08 Jan 2024 01:28:54 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id q22-20020a170906771600b00a26ac1363c8sm3776671ejm.94.2024.01.08.01.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 01:28:54 -0800 (PST)
Message-ID: <c4d1a68a-815f-4585-b600-9b2e049791c9@linaro.org>
Date: Mon, 8 Jan 2024 10:28:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/1] dt-bindings: riscv: sophgo: add RTC for CV1800
Content-Language: en-US
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240108072253.30183-1-qiujingbao.dlmu@gmail.com>
 <93695e92-233d-460c-a6bd-882b30f1dea8@linaro.org>
 <CAJRtX8T-88x=AeRhOVJP=1ccvOZa-nS4cDEjpSykTxFMRupKZg@mail.gmail.com>
 <7af6c688-3d3e-4cd5-bbd6-4ca323d7edde@linaro.org>
 <CAJRtX8QzDQjMCqXw9BnWPFt5FT3qr9=95F1rpwz_795AF9oSAA@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAJRtX8QzDQjMCqXw9BnWPFt5FT3qr9=95F1rpwz_795AF9oSAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/01/2024 10:11, Jingbao Qiu wrote:
> On Mon, Jan 8, 2024 at 5:06 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 08/01/2024 10:00, Jingbao Qiu wrote:
>>> On Mon, Jan 8, 2024 at 4:02 PM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 08/01/2024 08:22, Jingbao Qiu wrote:
>>>>> Real Time Clock (RTC) is an independently powered module
>>>>> within the chip, which includes a 32KHz oscillator and
>>>>> a Power On Reset/POR submodule. It can be used for time
>>>>> display and timed alarm generation.
>>>>>
>>>>> Power On Reset/POR submodule only using register resources
>>>>> so it should be empty. The 32KHz oscillator only provides
>>>>> pulses for RTC in hardware.
>>>>>
>>>>>
>>>>> Changes since v4:
>>>>> - remove POR dt-bindings because it empty
>>>>> - remove MFD dt-bindings because SoC does
>>>>>   not have MFDs
>>>>> - add syscon attribute to share registers
>>>>>   with POR
>>>>>
>>>>> v4: https://lore.kernel.org/all/20231229090643.116575-1-qiujingbao.dlmu@gmail.com/
>>>>>
>>>>> Changes since v3:
>>>>> - temporarily not submitting RTC driver code
>>>>>   waiting for communication with IC designer
>>>>
>>>> Hm, why?
>>>>
>>>> We do not need bindings if nothing matches to them. If this binding is
>>>> for other upstream open-source project, please provide references.
>>>>
>>>> See also:
>>>> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L61
>>>>
>>>
>>> Hi!
>>>
>>> There is a function in the RTC driver code used to calibrate the
>>> clock, which is define in the datasheet.
>>> However, Alexandre Belloni raised concerns that clock calibration
>>> should be done using GPS or similar
>>> methods, rather than using other clock sources. I think what he said
>>> makes sense. So it is necessary
>>> to communicate with IC designers.
>>>
>>> link: https://lore.kernel.org/all/202312271350242a208426@mail.local/
>>
>> Sure, this I get, but why sending bindings alone? There is no user of them.
>>
> 
> Thank you for your patient reply.
> May I ask if this user refers to driver code or DTS?

Anything. Any user.

Best regards,
Krzysztof


