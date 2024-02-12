Return-Path: <linux-kernel+bounces-61504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B60348512FA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4EE1F244E9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCBB3BB3F;
	Mon, 12 Feb 2024 12:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TUKuyoTm"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E323BB22
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739321; cv=none; b=tI4PXtGwSkHIcfgfxYOomExpwJAZ0wSqbKm/m66R8UckSwSwx6U9gQNuFlUJDEckhU8UMjHv6GhX2cGXMqB/GZCHehWp4/MHrtXGU/QR+W6usyWCphnt3Q98j4FdOMIH1RJQAPitTQoJgMef5MzXuORCVBc6ITNDbE6NuNSb4Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739321; c=relaxed/simple;
	bh=6jOThHeHLJcV7xo9OpIo5+QWwr5tWK5FlUO10NVx9Iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XAT5lc/j395fXBUoekr/C6S1dyGixnsAvRSi/nEjYQlm+RWeGRKfHAi1P5k3uTbWsr8HRsPVAFI1rT+FTxlvFKxADtv82MGETW26Rr+tP0VgtzlJluJAeGtnXEEiu7Qn6FG3Azmh5c7ww2P2qac4FzHRlQ7R4D3uQNxfZ4HnrKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TUKuyoTm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-410c1ebf5e4so8223165e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 04:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707739318; x=1708344118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2RfW1yKu6VnzD6W1R22Wk491SAkADnMhexZ9bi5hjB4=;
        b=TUKuyoTm97uvp9AKQF6SFjw3obviG9XkjE01cAyYtTIvK3z4C/SAeBoUkjI8eRnHfw
         +qVDCTnMGpaA/AljD0ZJ/z3Va05RhAIkhZ7fTY/xILR25iZBMxbGAOz3KpWP+HaFfN+x
         xone2qVamYYPaUGQrmjPoijMHn1lzU0HpAb4kkpnUt8fPKNY3CEhR35ssf4yTuWF6zql
         qdkO340+oD4CYRoexr1XOkQsm1vSrWP154Ofe9anvyFGSwvUGfHuzW5oJG0W1WtsLSY2
         VqJZOARN62oLqjbnaDSGzeMBPqyFrro2lQyrFKGI2k2YoNmCEDd36sQaJ0YbZ7uIV6lw
         raSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707739318; x=1708344118;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2RfW1yKu6VnzD6W1R22Wk491SAkADnMhexZ9bi5hjB4=;
        b=LUpuPUObhAq42GO0DOzYFreTapxnfAsK8xAKAfveRCxUJUiIFdR3OQ2WBXP4QSm9yQ
         ZIABMLpjIdQOn+AuUykEt/ScYwtuJQ/We5YozTK6qct+O5w6hY7Jnc/U7OFe72qbcz0b
         r9yOc/gW4c7JIYPo6rsSheMQX6j0IKoRup8njss3UddHpazNer19KmhXSX3r2YnasSLN
         V4IzAVPXWPQD+QptSPdox6ctEd9bkwvavYSEWzdTEri2UKpER0AAGnaMmD6ryGloAe72
         cv3kN2eTvE6gvmgYixIdV3+JNuqA6TBmwtOGdGD2QWEIBim2blgKmL/OnWp6B3FP/fHu
         P5OA==
X-Gm-Message-State: AOJu0Yxv69810JwgjiohcKSbxoal38CVDCh0Va3waZqfl4uj8cgsEYXM
	/LCHtbgFkl7L0Yx3ZrMhR6KfFZT/Bqeh7Ksa4k7GDEQ2P/+vUW11JdQkflzk/z4=
X-Google-Smtp-Source: AGHT+IEFctiL0oXp51EPgUWe8Fnt/DqYywvQmm4QP+S5XyApNLGmpHMXsexg4n8EThYzpEZzhKOBjA==
X-Received: by 2002:a5d:55cc:0:b0:33b:60cb:c3ad with SMTP id i12-20020a5d55cc000000b0033b60cbc3admr5740831wrw.41.1707739317996;
        Mon, 12 Feb 2024 04:01:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVl8AaJjjM+8NdAfmzeYbuNmlVemAz2z+06wOIVJbkD+bj1sxVNF/sLtMO30dKeBFYuVydqVE4it6e4wFtU7FJVvenMwolV7md9o00r/A1Bu59Xb55Ti4qN0U+ccT3otk4QwKcdX/D/PKFo3hh8LVsk6g7KCZgZWoE/Sz8PpHveL4pnVTx2m+qamA4BYn4AUCgHIxQ7b0YznjQYfK359EPlRA3ObLqqyomvDNH8tTohNZWS3KclTmaQt8v3e5HIeusMB4oNKYOBbNyBHSn08RPgf/bG3TbfCO4wXo4cwiFWMAqiNty2nb7k+SvqEhObTGHxWSbHx7sLTITH3FMQhBgK7t8XZefO3sk7NfEs+UxPnsHpGmJTiqNDU5hPnDgYiAuOVZ/IDr24I9PF+Uz4zoIzt2HLgy32TY4EVoXWpkhaTS4mJ7UjmUXH5qmrn7NrEbqm036wWwfnykB9XIJ6nlupm7mlC07Tz6tNJlJSWiLLM0+NjwH81MRKTzuGEmMln2szRuodsi+RyCsqUOIlg6cV0/YvUyic8+nkyykiCea+hCq46ICecidpTcMC24ufCqIHavzEp0M2QDN2SRo11lJAfL4J3luLfy0sEW0D4oCYeJku
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id n14-20020a056000170e00b0033b5b5033b9sm6709452wrc.18.2024.02.12.04.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 04:01:55 -0800 (PST)
Message-ID: <b7051bea-8197-4338-a089-5e5fff540ac5@linaro.org>
Date: Mon, 12 Feb 2024 12:01:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] spi: dt-bindings: introduce the ``fifo-depth``
 property
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Conor Dooley <conor@kernel.org>, broonie@kernel.org, robh@kernel.org,
 andi.shyti@kernel.org, semen.protsenko@linaro.org,
 krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
 linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com,
 willmcvicker@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
 arnd@arndb.de
References: <20240208135045.3728927-1-tudor.ambarus@linaro.org>
 <20240208135045.3728927-2-tudor.ambarus@linaro.org>
 <20240208-grating-legwarmer-0a04cfb04d61@spud>
 <c2b08463-cb13-4e9b-8797-8ebcf1047f66@linaro.org>
 <20240209-chest-sleet-a119fc3d4243@spud>
 <0ac8d573-6486-458d-afb9-090b5f8d4a21@linaro.org>
 <CAMuHMdXEKecx-wQCSzqmRr6af2AUOnoFhfD2JLx28n8OYnvzGw@mail.gmail.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAMuHMdXEKecx-wQCSzqmRr6af2AUOnoFhfD2JLx28n8OYnvzGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/12/24 10:38, Geert Uytterhoeven wrote:
> Hi Tudor,

Hi, Geert!

> 
> On Fri, Feb 9, 2024 at 5:55 PM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>> On 2/9/24 16:21, Conor Dooley wrote:
>>> On Fri, Feb 09, 2024 at 01:56:56PM +0000, Tudor Ambarus wrote:
>>>> On 2/8/24 18:24, Conor Dooley wrote:
>>>>> On Thu, Feb 08, 2024 at 01:50:34PM +0000, Tudor Ambarus wrote:
>>>>>> There are instances of the same IP that are configured by the integrator
>>>>>> with different FIFO depths. Introduce the fifo-depth property to allow
>>>>>> such nodes to specify their FIFO depth.
>>>>>>
>>>>>> We haven't seen SPI IPs with different FIFO depths for RX and TX, thus
>>>>>> introduce a single property.
>>>>>
>>>>> Some citation attached to this would be nice. "We haven't seen" offers
>>>>> no detail as to what IPs that allow this sort of configuration of FIFO
>>>>> size that you have actually checked.
>>>>>
>>>>> I went and checked our IP that we use in FPGA fabric, which has a
>>>>> configurable fifo depth. It only has a single knob for both RX and TX
>>>>> FIFOs. The Xilinx xps spi core also has configurable FIFOs, but again RX
>>>>> and TX sizes are tied there. At least that's a sample size of three.
>>>>>
>>>>> One of our guys is working on support for the IP I just mentioned and
>>>>> would be defining a vendor property for this, so
>>>>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>>>>
>>>>
>>>> Thanks, Conor. I had in mind that SPI has a shift register and it's
>>>> improbable to have different FIFO depths for RX and TX.
>>>
>>> IDK, but I've learned to expect the unexpectable, especially when it
>>> comes to the IPs intended for use in FPGAs.
>>>
>>>> At least I don't
>>>> see how it would work, I guess it will use the minimum depth between the
>>>> two?
>>>
>>> I'm not really sure how it would work other than that in the general
>>> case, but some use case specific configuration could work, but I do
>>> agree that it is
>>>
>>>> I grepped by "fifo" in the spi bindings and I now see that renesas is
>>>> using dedicated properties for RX and TX, but I think that there too the
>>>> FIFOs have the same depths. Looking into drivers/spi/spi-sh-msiof.c I
>>>> see that the of_device_id.data contains 64 bytes FIFOs for RX and TX,
>>>> regardless of the compatible.
>>>>
>>>> Geert, any idea if the FIFO depths can differ for RX and TX in
>>>> spi-sh-msiof.c?
> 
> See my other email
> https://lore.kernel.org/all/CAMuHMdU_Hx9PLmHf2Xm1KKTy_OF-TeCv7SzmA5CZWz+PLkbAGA@mail.gmail.com
> 

I saw the response, thanks again!

> Note that at one point we did have 64/256 in the driver, but that was
> changed in commit fe78d0b7691c0274 ("spi: sh-msiof: Fix FIFO size to
> 64 word from 256 word").  Diving into the discussion around that patch,
> there seem to be two factors at play:
>   1. Actual FIFO size,
>   2. Maximum transfer size per block
>      (up to 2 blocks on R-Car, up to 4 blocks on SH(-Mobile)).
> As the driver supports only a single block, it should be limited to
> 64 on R-Car Gen2/3.  R-Car Gen4 claims to have widened the register
> bit field for the maximum transfer size per block, so 256 might be
> possible there...

Got it.

> 
>>>> Anyway, even if there are such imbalanced architectures, I guess we can
>>>> consider them when/if they appear? (add rx/tx-fifo-depth dt properties)
>>>
>>> I think so.
>>>
>>>> Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml:
>>>> Override the default TX fifo size.  Unit is words.  Ignored if 0.
>>>> Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml:
>>>> renesas,rx-fifo-size:
>>>> Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml:
>>>> Override the default RX fifo size.  Unit is words.  Ignored if 0.
>>>
>>> These renesas ones seemed interesting at first glance due to these
>>> comments, but what's missed by grep the is "deprecated" marking on
>>> these. They seem to have been replaced by soc-specific compatibles.
>>
>> In the driver the renesas,{rx,tx}-fifo-size properties still have the
>> highest priority:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/tree/drivers/spi/spi-sh-msiof.c#n1350
>>
>> Maybe something for Geert, as I see he was the one marking these
>> properties as deprecated. I guess he forgot to update the driver.
>>
>> Anyway, I think we shall be fine, even if we don't hear from Geert.
> 
> The renesas,{rx,tx}-fifo-size properties date back to the early days
> of DT an ARM, when it was assumed that slightly different versions of
> IP cores could be handled well using a single common compatible value,
> and properties describing the (few) differences.  The pitfall here
> is the "few differences": too many times people discovered later that
> there were more differences, needing more properties, and complicating
> backwards-compatibility.
> 
> Hence the handling of different FIFO sizes was moved to the driver based
> on compatible values, and the renesas,{rx,tx}-fifo-size properties were
> deprecated.  See commit beb74bb0875579c4 ("spi: sh-msiof: Add support
> for R-Car H2 and M2"), which shows that there were more changes
> needed than the anticipated FIFO sizes.  And more were added later,
> see later additions to sh_msiof_chipdata.
> 
> So unless it is meant for a configurable synthesizable IP core, where
> this is a documented parameter of the IP core, I advise against
> specifying the FIFO size(s) in DT.
> 

I guess I get it now. You marked those properties as deprecated so that
users stop using them and rely on the driver based compatible values,
but at the same time you allowed the devicetree properties to have a
higher priority than the driver based compatible values in case one
really wants/needs to use the dt properties. I don't have a preference
here, I guess it's fine.

Thanks for the explanations!
ta

