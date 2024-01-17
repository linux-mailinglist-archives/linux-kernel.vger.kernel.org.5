Return-Path: <linux-kernel+bounces-28580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2273A830048
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C31F1F24BF0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8674D30B;
	Wed, 17 Jan 2024 06:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kErOzRcw"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE7FBE6F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 06:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705474222; cv=none; b=Ckv29p0ccsDKzw50j0VdDcseyIgQDaY93ULuInUFR71mvsuVbtXfFpe83p/U1EZ4d+tz0H9oXA7EcxTuNTSb25y8SOb3ezAR7vYKn7oC4NmNUmLdERV22DyG2nZ6+UKON0UVn/ANj+C+sUxCmWaWo4DTMx14/c3KH4HZ0QsHzbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705474222; c=relaxed/simple;
	bh=bpVpyv7HOoT+GHCUFJlRKMOgkADv3ENViGIc4vsVohM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=p5ScTcajIw1/ztaM5aDW5Wj9IDwezfZG3vfQPNpSmmjvrhn2AViAw6UGtTuGrvIBQROEk0NRbqGPc+o2kfuO0xkCA2EGLDbpFWeDKio4W8Vstrt2ryrGAkCGI1QfaBWlY8yWIHbdOaZmKNcopKtwDrbsHtwTxrimjwCRbFDlSlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kErOzRcw; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e7f58c5fbso14396140e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 22:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705474219; x=1706079019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tu84ILjbpo9tG7iSVT4BwNUWd2Sw5ljf8qmxMbShI6c=;
        b=kErOzRcwkWtz5S7xNH2aznccC60c5yoMw0B13+tCCyTgwX1XT4YR6T7adbt9M8goki
         RU6ImGw/zmZh6v/xfcw2w9VW/BUPP60foyDMjQ/equaQwEUF9ultPUto+gYCDEVxNvQQ
         uID0OaHngL5nqrgAxtRgQuGtQUVPUwv06NwDkA5+BlT3v7/wd7PXLN0X9geIuC3K4LA8
         22b3ZbqHEZdI7VJt/9wWZ9fq6rVqRxDRjhuiVXy5EyksHAsu/PuPCUmptCsMUsDOxQwa
         XiFIzj1LJv4x2UWoOGNhy5eFBp7CcBlDQVd7uUTnoMgHeE/UrNudtkirSAmrdxqoNYnq
         SpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705474219; x=1706079019;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tu84ILjbpo9tG7iSVT4BwNUWd2Sw5ljf8qmxMbShI6c=;
        b=m6JmRqdyYTGzVvHCYTSZpzsqE6sDJO/G070eeU3FGk+P+qsJPA6xCS90PaRqsQn7DR
         69amsdNQfJhXm+KLrQ/TOvof6yvIwTGlxqtjO166eCTEbm2dUv/TEgQiyI982dSnoHPI
         2TvKVkbwV2KG8daoq9Lgwehj4J06KOouVUTTb2p6nV/vQkHHGIVyPK3yKhmnkjTwsPjV
         Qrf338LzO3kXmZgDCElYh1Ts+02+Q98RLVkpSLVHeh/QD7gQE8EC79sZqhnfQOTmpZ83
         ggg3PknMM/ijLoOix/yINWCMI0P6QqVnHmVgzBEtYXWHzDjEu2507h9qcdPusjZkQmuG
         pttw==
X-Gm-Message-State: AOJu0YxBZetQX/O42B57z+AV59LwJA8tFlZiQBJuI5pbm1P/aCprm1oA
	05Js+8DZ2YuBfOnuX7bfUmS1m5K1VwZIXA==
X-Google-Smtp-Source: AGHT+IH/3qGTuhGoQGoznooCvQtF/oY6Lfl2JyQ9mkHXargKkkpnjkIwhx7xUmcD9+iPRR20G7f3xw==
X-Received: by 2002:a05:6512:234a:b0:50e:76eb:ba14 with SMTP id p10-20020a056512234a00b0050e76ebba14mr5968598lfu.32.1705474218779;
        Tue, 16 Jan 2024 22:50:18 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id s23-20020a170906455700b00a2c70ec1533sm7199279ejq.66.2024.01.16.22.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 22:50:18 -0800 (PST)
Message-ID: <ad44d51a-ba64-4a4b-bba9-205faa760c78@linaro.org>
Date: Wed, 17 Jan 2024 07:50:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] dt-bindings: i3c: svc: add compatible string i3c:
 silvaco,i3c-target-v1
Content-Language: en-US
To: Frank Li <Frank.li@nxp.com>
Cc: Conor Dooley <conor@kernel.org>, Conor Dooley
 <conor.dooley@microchip.com>, robh@kernel.org,
 alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
 gregkh@linuxfoundation.org, imx@lists.linux.dev, jirislaby@kernel.org,
 joe@perches.com, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 miquel.raynal@bootlin.com, zbigniew.lukwinski@linux.intel.com,
 devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
References: <20240116-bleach-herbicide-48d636967134@wendy>
 <3199c245-3d2d-49e8-951e-2b059de4d683@linaro.org>
 <20240116-achiness-thievish-10a12b3c08cd@wendy>
 <Zaa+cLGVVDSB5MYr@lizhi-Precision-Tower-5810>
 <20240116-retract-conclude-c47a7fc8cb21@spud>
 <ZabVSYgq1Mz3LPpC@lizhi-Precision-Tower-5810>
 <4a9ed1ca-cd13-4b61-af06-a3d7935aeeee@linaro.org>
 <ZabqxHD4wtiPn6ep@lizhi-Precision-Tower-5810>
 <c760b89c-efec-489e-8333-c60b38fb5a47@linaro.org>
 <e54e2b30-03e7-40e3-bb33-dc71de8511a4@linaro.org>
 <ZacCQ1Eysqq5FnA4@lizhi-Precision-Tower-5810>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZacCQ1Eysqq5FnA4@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/01/2024 23:25, Frank Li wrote:
> On Tue, Jan 16, 2024 at 10:01:42PM +0100, Krzysztof Kozlowski wrote:
>> On 16/01/2024 21:56, Krzysztof Kozlowski wrote:
>>> On 16/01/2024 21:44, Frank Li wrote:
>>>> On Tue, Jan 16, 2024 at 09:30:24PM +0100, Krzysztof Kozlowski wrote:
>>>>> On 16/01/2024 20:13, Frank Li wrote:
>>>>>> On Tue, Jan 16, 2024 at 06:23:09PM +0000, Conor Dooley wrote:
>>>>>>> On Tue, Jan 16, 2024 at 12:35:44PM -0500, Frank Li wrote:
>>>>>>>> On Tue, Jan 16, 2024 at 09:48:08AM +0000, Conor Dooley wrote:
>>>>>>>>> On Tue, Jan 16, 2024 at 10:33:48AM +0100, Krzysztof Kozlowski wrote:
>>>>>>>>>> On 16/01/2024 10:30, Conor Dooley wrote:
>>>>>>>>>>> On Tue, Jan 16, 2024 at 08:24:20AM +0100, Krzysztof Kozlowski wrote:
>>>>>>>>>>>> On 16/01/2024 03:29, Frank Li wrote:
>>>>>>>>>>>>>>> 	Patches were accepted after discussion, what you ponit to. So I
>>>>>>>>>>>>>>> think everyone agree on the name 'silvaco,i3c-master-v1'.
>>>>>>>>>>>>>>> 	I plan send next version to fix auto build error. Any additional
>>>>>>>>>>>>>>> comments about this?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I still do not see how did you address Rob's comment and his point is
>>>>>>>>>>>>>> valid. You just did not reply to it.
>>>>>>>>>>>>>
>>>>>>>>>>>>> See https://lore.kernel.org/imx/ZXCiaKfMYYShoiXK@lizhi-Precision-Tower-5810/
>>>>>>>>>>>>
>>>>>>>>>>>> First of all, that's not the answer to Rob's email, but some other
>>>>>>>>>>>> thread which is 99% ignored by Rob (unless he has filters for
>>>>>>>>>>>> "@Rob"...). Therefore no, it does not count as valid answer.
>>>>>>>>>>>>
>>>>>>>>>>>> Second, explanation does not make sense. There is no argument granting
>>>>>>>>>>>> you exception from SoC specific compatibles.
>>>>>>>>>>>
>>>>>>>>>>> The patch could have been applied two months ago had Frank done as
>>>>>>>>>>> was requested (multiple times). I don't understand the resistance
>>>>>>>>>>> towards doing so given the process has taken way way longer as a result.
>>>>>>>>>>
>>>>>>>>>> I think that Rob's comment was just skipped and original master binding
>>>>>>>>>> was merged without addressing it. I don't want to repeat the same
>>>>>>>>>> process for the "target". Indeed I could point this earlier... if I only
>>>>>>>>>> knew that Rob pointed out that issue.
>>>>>>>>>
>>>>>>>>> Oh I think I got confused here. The context for this mail led me to
>>>>>>>>> think that this was still trying to push the i3c-master-v1 stuff through
>>>>>>>>> and I was commenting on my frustration with the resistance to applying
>>>>>>>>> the feedback received. I didn't realise that this was for another
>>>>>>>>> patch adding a target.
>>>>>>>>>
>>>>>>>>> I think you already said it, but NAK to adding any more compatibles here
>>>>>>>>> until the soc-specific compatible that was asked for for the imx93 is
>>>>>>>>> added.
>>>>>>>>
>>>>>>>> Is it okay for 'silvaco,i3c-target-imx93'?
>>>>>
>>>>> No, because imx93 is product of NXP, not Silvaco.
>>>>>
>>>>> You need regular SoC-block compatibles, just like we have for all other
>>>>> snps, dwc and cdns.
>>>>
>>>> "nxp,imx93-svc-i3c-target" ? 
>>>
>>> Could be, now please point me to patch adding such code to DTS. I would
>>> like to see the real use case for it.
>>
>> Probably I was not clear enough, so let's be more precise: I think you
>> might have troubles pointing to such code, because it just does not
>> exist. It is a bit contradicting to single hardware description, because
>> you want to describe one hardware in two different ways, with two
>> different compatibles.
>>
>> Your commit msg is here empty - it says what  patch is does, which is
>> obvious. Tells nothing about the hardware being described here, which
>> does not help this discussion. This would need solving as well, but main
>> point stays - don't add new compatibles for the same hardware, at least
>> not without valid reason/explanation.
> 
> I can improve commt msg. It was similar PCI case (There are two work mode:
> root complex and endpoint). So there are two kind compatible string for it.
> 
> If you think it is good for using two compatible string for two work mode
> of the same hardware.

Not really, because compatible describes hardware and it is the same
hardware here. We do not have two different compatibles for GPIOs being
input or output.  Or two different compatibles for serial engines (ones
providing UART, SPI or I2C).

> 
> I can write git commit message like:
> 
> dt-bindings: i3c: svc: add compatible string nxp,imx93-svc-i3c-target
> 
> silvaco i3c controller is dual mode controller, which can work as master
> and target mode. All clock, reg, irq are the same for both mode. Add
> compatible string "nxp,imx93-svc-i3c-target" to let silivaco i3c
> controller work as target mode.
> 
> Of course, alternate method to added a property "mode" to distingiush
> master and target mode. but old "silvaco,i3c-master-v1" will actually work
> as dual mode support. Driver structure will become complex.

Please send full DTS of user for this, which works for 100%, so we can
see how it differs from controller mode. If your code snippet from other
thread is correct, then it would suggest "mode" property or lack of
children. Maybe lack of children is not enough, if user-space could
control I3C bus.

Best regards,
Krzysztof


