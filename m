Return-Path: <linux-kernel+bounces-43253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA88C841175
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D3728E8A8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7183F9E9;
	Mon, 29 Jan 2024 17:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OhJOoi/A"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3FD76C9C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551182; cv=none; b=PHX71xIBA+ymyiTXqVlKw0brkLgjCEoHaHwrj61LSHzzEgxbvbykUKTQzQsc6rftNpSYwtDW4xiEvlwRM6zL+NCDd/1VLL57rVChUJw0qHB69NpikxYJvjf7lI++uOcIOzO62JmRqGwFk9whOmB+3W+7T9T0fAptND2B3EdEZoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551182; c=relaxed/simple;
	bh=WdFE5G28qXw91+L/5jczJ22evdDNgsN+116WMT64VSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sIALmB85yAHvisdqm+DnxdxDFS89hNy9xxUXmrhopr4w0anODWG7RWJAcz3DQDenQHJZ2Pr+EbIjPGo2Ne+jAYbGJiT/1Ep/6YECTOyqQovTwgmjTseHdO37l1iuLHJ0rBy02DWMf896F3DIbrBBMiQcMZhb4yzaoGDxCuLj0Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OhJOoi/A; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3122b70439so409805066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706551179; x=1707155979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EduC/u1ISeMAo6EudIFVFUKWN5Hqy6PJTVRFHHs3oCM=;
        b=OhJOoi/Ase69h8hEUoTLqDqNpscKZC88bdQrjJQqLOfvgWO+cy8Uw+L+DJ3Lj75Xsj
         fNa+NP1pC3H0AGS6lBE1fHCAJYHXQFpPag32pAxJdrslPnh2M5R1MAinrDQKnMPhjm4Y
         m09mQE75SSwNVagJAqYEMeIEHvWCwvBHMPDOCDVV007EIycvPacehgu87q/aHfLH65TN
         jxpFxSNXJIGPVeEEDf7AF2k7WzTc7mjilsAVIqjbVoGCiWpaJKecr9RJcO8A2sjooJBJ
         eHJkYwoTXP/rC7boK0mfcXQrx7gDQK4qRd01jwcEFjYkP2r8CfwSrvmVvGa/4F5YpToh
         8ENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551179; x=1707155979;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EduC/u1ISeMAo6EudIFVFUKWN5Hqy6PJTVRFHHs3oCM=;
        b=LpC2gXeZ79PbndZClb4GOK8WMY2A6da93qtirteN54wDe1WiUFjihn8z2V8b7QVkRA
         itkEwBoEb18sI0jPKUscz7TmB/umMKnFfH/+pQgW9/1ECixO1X/3nQTDZX5DyMCz+WMT
         /hmV874jc1wQfW676atZbqZ2k3mhY7OroLdLRvgQouBE/AESbu/y7dpiISJtdTVGD6U0
         CBacvD5rsJnqDUy/FVl/t+OsHpFiJ6+AXs9QwyVFS4WLE5vtkepIob674cvaMcfFcPjy
         X0vcuonopfaD4VwlnfzXtp2vUQDPxndkYZy9cfagMJneKJahl1v3NgO9bPqFmmYUUn0d
         nR9g==
X-Gm-Message-State: AOJu0Yz/TKD1SmLhPjoHE2j75e5xmxMi4GmTglT6BB7pzZ7+krayhDIg
	tQo3ojjOWalgjmoqNyQCV3pgLemspG3i/Tx/Ls8VaY4iuVfMiQMAxE0AQGGtgZ8=
X-Google-Smtp-Source: AGHT+IEzv8qsRZ10vsBI4VJJ9TZr1g1+ImxJzul/w+UUW58owJdgCXBMoGnQlYGYgpyx/hyrawdszA==
X-Received: by 2002:a17:906:5613:b0:a35:cd14:4147 with SMTP id f19-20020a170906561300b00a35cd144147mr1867189ejq.24.1706551179451;
        Mon, 29 Jan 2024 09:59:39 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id rg9-20020a1709076b8900b00a354e4d3449sm2834896ejc.120.2024.01.29.09.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 09:59:39 -0800 (PST)
Message-ID: <6877683f-6018-4b29-a378-3a04c7b7f838@linaro.org>
Date: Mon, 29 Jan 2024 17:59:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/17] spi: s3c64xx: use bitfield access macros
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: Sam Protsenko <semen.protsenko@linaro.org>, andi.shyti@kernel.org,
 krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
 jassi.brar@samsung.com, linux-spi@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, andre.draszik@linaro.org,
 peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
References: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
 <20240126171546.1233172-18-tudor.ambarus@linaro.org>
 <CAPLW+4nL6D7R88Q_kJjAT-bWTFBk8a=FT0vL+fyRgxaDeSyhNw@mail.gmail.com>
 <b5ecacaa-8ccc-4588-b3be-4b5f85813909@linaro.org>
 <CAPLW+4nN--gG9XsOu6a-mo5vcM-GycRrhPQFOtNidfVTM=KonQ@mail.gmail.com>
 <facbcbf3-7dba-43a1-b4fe-ac77b5bef545@linaro.org>
 <56f81e10-86b7-4bd6-938c-e2e9acd6a755@sirena.org.uk>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <56f81e10-86b7-4bd6-938c-e2e9acd6a755@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/29/24 16:42, Mark Brown wrote:
> On Sat, Jan 27, 2024 at 03:44:24AM +0000, Tudor Ambarus wrote:
>> On 1/27/24 03:38, Sam Protsenko wrote:
> 
>>>>>> -               val |= S3C64XX_SPI_MODE_BUS_TSZ_HALFWORD;
>>>>>> -               val |= S3C64XX_SPI_MODE_CH_TSZ_HALFWORD;
>>>>>> +               val |= FIELD_PREP(S3C64XX_SPI_MODE_BUS_TSZ_MASK,
>>>>>> +                                 S3C64XX_SPI_MODE_BUS_TSZ_HALFWORD) |
>>>>>> +                      FIELD_PREP(S3C64XX_SPI_MODE_CH_TSZ_MASK,
>>>>>> +                                 S3C64XX_SPI_MODE_CH_TSZ_HALFWORD);
> 
>>>>> Two people complained it makes the code harder to read. Yet it's not
>>>>> addressed in v3. Please see my comments for your previous submission
>>>>> explaining what can be done, and also Andi's comment on that matter.
> 
>>>> I kept these intentionally. Please read my reply on that matter or the
>>>> cover letter to this patch set.
> 
>>> I read it. But still don't like it 🙂 I'm sure it's possible to do
>>> this modification, but at the same time keep the code clean an easy to
>>> read. The code above -- I don't like at all, sorry. It was much better
>>> before this patch, IMHO.
> 
>> Yeah, I guess Mark will tip the scale.
> 
> All other things being equal I tend to try not to get too involved with
> minor coding style stuff in drivers.  People do seem to like
> FIELD_PREP() but I have a hard time getting *too* excited.

Ok, I'll remove FIELD_PREP. Would you please consider the other patches,
all are simple. There's another "controversy" on 6/17. You can ignore
that as well maybe, and I'll resend it where I refrain myself to just
removing the cast.

