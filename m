Return-Path: <linux-kernel+bounces-9049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0924A81BF9B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D5411C22EB8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F264D768EC;
	Thu, 21 Dec 2023 20:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r5LCBAZt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E35328D5
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5542106d393so1151670a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 12:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703190858; x=1703795658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=weIpIdWwjVmiz/xcLJ6YWeltfk+PtaKRQRUN8dbLvcE=;
        b=r5LCBAZteDp1OjfLPPjmTAUdh1FfB8BbDAqwS67/gSXY5ZudLOw0NA5uaKBIE8HKDw
         0VsFfglXwMOtWXoXFCvmW0bJQ7Z0suaLYp0qsrwZO0hxG2zOTcRDEJtehf907Ypkn7XE
         aig8pnkXCqLutX4VOV6dTY0saOckY44dQRCH78qtwWMXh7NZyo79tFHEVpDElb5928WJ
         vXHvNpROrLwL4o9q6boeho4F83+oK5VhqGOOW7W1lhDxNOkpDhkwsL2uzH1ls0M/8+AP
         AIVHKfKNGqvgWWkHj+a89hWIwu7kTx5dQwkYDplzU5bHZ9wzBy3/9ftjZRFucf5zyt6X
         RF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703190858; x=1703795658;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=weIpIdWwjVmiz/xcLJ6YWeltfk+PtaKRQRUN8dbLvcE=;
        b=A27qmlLVwofTIyRjH4M2uxXi8VZbzLLmQYcNsy8V/XN18138P86vSr+Ow/8xmcID6v
         +FsCxqHzL51tfynizMCKNH2OkoAs37sKRC0Bga2znKIJA7UpV8TuKZxBUiEh98eOrZX/
         qwD/BIlFQTen+LWg5OGmFGxACdydZFlZ4B9yh2iv1R4sz4V4A3HpBzlbbiqhZ+WplJ/M
         d1JB062W9oVvdCYeCqS6IVDD4TUGh8y5TT8acFK8ZqlyTOhuAZijYcrwfUVjBg2huGo1
         01l1BSonN58V8FKQOxBvNbAi+Bx7p4nMWVUQ2hNwgX2YZguCILRp7GPooNk5mAIY5Bw0
         GEJw==
X-Gm-Message-State: AOJu0Yzh7kq3YRlEuWrBlyMk5WpNr8OMC8L4WFbpsi0vbrdnc7ZLKbN5
	VcQBBbvEmxW0Ydey9ZFN93FwRwVVxQahCQ==
X-Google-Smtp-Source: AGHT+IEAPP5msLU/SnZSHq+csfDEzzQC6cRhk8gRFRGfTQ81D8iwcMYyqMJpjlUL6dTJuKZx42bkZg==
X-Received: by 2002:a05:6402:b10:b0:553:76c9:f4fa with SMTP id bm16-20020a0564020b1000b0055376c9f4famr117053edb.12.1703190858013;
        Thu, 21 Dec 2023 12:34:18 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id bf25-20020a0564021a5900b0055286b1bfc2sm1620741edb.25.2023.12.21.12.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 12:34:17 -0800 (PST)
Message-ID: <b9f146ee-ac25-425e-bd56-3339fee53223@linaro.org>
Date: Thu, 21 Dec 2023 21:34:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/22] ARM: dts: samsung: exynos5420: Enable
 cros-ec-spi as wake source
Content-Language: en-US
To: Mark Hasemeyer <markhas@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Tzung-Bi Shih <tzungbi@kernel.org>, Raul Rangel <rrangel@chromium.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>, Rob Herring
 <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Alim Akhtar <alim.akhtar@samsung.com>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
References: <20231220235459.2965548-1-markhas@chromium.org>
 <20231220165423.v2.6.I06b059021de1bf6103e60a73211f078f2af75d17@changeid>
 <7199b7b7-238e-45de-96f1-0f04d0fa718d@linaro.org>
 <CANg-bXD+TVHO3o6f66fJXQ7AtXxPY00TQqjvX2vwk9PyTd1ZaA@mail.gmail.com>
 <50dceec0-3a43-4363-8404-d701f726acc0@linaro.org>
 <CANg-bXAY5AGTu_jwtO8syCi8XVh5ti1V6ZFMzyCSBjzCUKUn1Q@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CANg-bXAY5AGTu_jwtO8syCi8XVh5ti1V6ZFMzyCSBjzCUKUn1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/12/2023 20:24, Mark Hasemeyer wrote:
>>>> You do not need this property, if driver assumes that. Just enable it
>>>> unconditionally.
>>>
>>> The goal of this patch series is to change exactly that: to prevent
>>> the driver from unconditionally enabling the irq for wake.
>>
>> But why? What is the problem being solved? Is unconditional wakeup in
>> the driver incorrect? If so, mention it shortly in the commit msg, what
>> is rationale because existing one does not justify this change.
> 
> The cover letter talks about it:
> "Currently the cros_ec driver assumes that its associated interrupt is
> wake capable. This is an incorrect assumption as some Chromebooks use
> a separate wake pin, while others overload the interrupt for wake and
> IO."
> With the current assumption, spurious wakes can occur on systems that
> use a separate wake pin.

This sentence would be enough.

> I can add wording to the dts patches to help clarify.
> 
>>> The driver works across numerous buses (spi, uart, i2c, lpc) and
>>> supports DT and ACPI.
>>> SPI+DT systems all happen to need irq wake enabled.
>>>
>>>> I don't think anything from previous discussion was
>>>> resolved.
>>>
>>> Which previous discussion do you mean? In v1 it was suggested to split
>>
>> https://lore.kernel.org/all/20231213221124.GB2115075-robh@kernel.org/
> 
> Hmm, I thought that was addressed [2]. I was referencing the existing
> binding documentation. From there, there was discussion about updating
> the docs to clarify what was actually intended (patch 3 in this
> series). I also addressed the ABI break concern in the thread and
> mentioned it in patch 22.
> "For device tree base systems, it is not an issue as the relevant
> device tree entries have been updated and DTS is built from source for
> each ChromeOS update."
> 
> Is there a specific concern you feel is not resolved? Or can I make
> something more clear?
> 
Seems fine, thanks.

Best regards,
Krzysztof


