Return-Path: <linux-kernel+bounces-105446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D252E87DDF5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB0D1F2170A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5F41C6BF;
	Sun, 17 Mar 2024 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aGCEqa+M"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9D41C693
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710689380; cv=none; b=A4NyOVkRB0nb16mSVFrjCV1Cp+fwG2TJ1NP9AO4A8IiXeJUcM9lNwF41kahk6/XedtRcpFF6HKCmf1yc7jr46Xa68zgdHqJyGzqQOSmZUqTggguY4OXNuhcCoWG8v9xc6Fd/2VYLmWv0MsW0xXjMuvY+S/Mp89HzBcMOOgAT5zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710689380; c=relaxed/simple;
	bh=Phu7nPTCfTt91JBs+SuYy6aiueQt1WUZjJAWb+jpCaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DygoicqakVGT4zjhOzy5I9RqKHmVzaSrdDmQg2+3E+5ulb7Rj2hQJ/oWOSqP/ZqxAnoTrArOC9umk0+VqJh0UJ22CjjpcVYovi6VwbqpZyLPB7414rXx73eUtz8sfs9S+KaJocvnxwjCEL9J5EfW7tc6bd+AMQjWWn977qfECkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aGCEqa+M; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-513d599dbabso3640916e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 08:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710689377; x=1711294177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A8WcCyd8vgz263xa9NPZybhQi9kVqK0YmFh146T5x90=;
        b=aGCEqa+M2UHDd2t55lOiupRFgfLoDZl5TFNbjYzdz7Z8gN5rO/nUJ7Jo8Kv3eiJPra
         FWQ2JnoyIVaNCL44z4B/90TE+AGeVe10/0r1LSiu3PUgr02f5ivrIEwCYsnbhuZdAhKt
         itelHuYDSDeTundLtX2L/X2nQQRdki1dwgn4DJFm5f0bh4CosV1sXPWHb3g/wZRkFT/W
         PrDdiWErYKDGTbz5uvvifj5aN2I1puNv/XNFiJKl5RZUIr0kX9xci0eWDxHOM4omALhp
         wk0AJH9ecK5gWTeH1CUe6NWx4LrCZ+qzdyqno07D58uTFiBelp3mUawTKMUIqWuAoSaz
         uR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710689377; x=1711294177;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A8WcCyd8vgz263xa9NPZybhQi9kVqK0YmFh146T5x90=;
        b=J3S4qzJyKWX9+quXq4Z4AiM8XDyNlba/RNx+pLxWFUVmizESx4sfXskIbyJaqJDwrt
         z6PmKb4iKAVuH4K4BraZNSK4UdmQGlKpR2EFE+xq8QoZRZn9b3LPsYshB4DNeJK8w4EX
         D5SJHGgNMFi/CnZnNrZV7sEl1FD1OgSNAQ5cGQPon1dChmKMuQJj7C1PVrx4KYyIVLvA
         VMWC0CuSjygaJReC86/tMUKsOfNLBmAZhenYiu0NMbPqfQrkHV6Zmt3t6QPBPXwYqmG3
         cPhkHBrwtq0TQZGybtBzst0gexvPfGpewE7kPg29isM7/nQwVgK9X3GdNx7Hs0uider3
         1b4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRtgKWBtx0TszitD6Vxg8bSTMqDgSqbMhfusIAyA1eH2hy088ZzWYUwTX3i7tvJFF6awKWXgZkVUKS2NxEkrvVnVk4RrIwEOR4G0t3
X-Gm-Message-State: AOJu0YxTOzBU1JD728JJ6atfJjdmK7rIuC9nAurw67coAmm7iQqpM/h/
	c9Me6ORHmQTV96ab6uFPm2odKbcgHVhGmOhs8N+XGXCSg0cMeChClE0KOBgal+o=
X-Google-Smtp-Source: AGHT+IGgfgH03LvKICjbZS2cDme7K6TcagY32JX5GkRBXMsxFk4N9eETQx3WDI3Zqf+qcERZN+nN1w==
X-Received: by 2002:a05:6512:3a93:b0:513:e7ff:15af with SMTP id q19-20020a0565123a9300b00513e7ff15afmr1090150lfu.64.1710689376859;
        Sun, 17 Mar 2024 08:29:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id sd9-20020a170906ce2900b00a4628cacad4sm3859452ejb.195.2024.03.17.08.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 08:29:36 -0700 (PDT)
Message-ID: <adefc3ff-86a5-4af7-8276-73d0e0108901@linaro.org>
Date: Sun, 17 Mar 2024 16:29:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] mips: dts: ralink: mt7621: improve DTS style
Content-Language: en-US
To: Justin Swartz <justin.swartz@risingedge.co.za>
Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240316045442.31469-1-justin.swartz@risingedge.co.za>
 <CAMhs-H9ZO-sitsrASuvsEd+ddwVyHH35gj7yAABTqFNfOCGYYw@mail.gmail.com>
 <60512ae2-dd73-4cb6-9514-145f946300fc@linaro.org>
 <5d6c36cb9dd9afda1efb69aa34058517@risingedge.co.za>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <5d6c36cb9dd9afda1efb69aa34058517@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/03/2024 16:22, Justin Swartz wrote:
> On 2024-03-17 17:10, Krzysztof Kozlowski wrote:
>> On 16/03/2024 16:49, Sergio Paracuellos wrote:
>>> On Sat, Mar 16, 2024 at 5:54 AM Justin Swartz
>>> <justin.swartz@risingedge.co.za> wrote:
>>>>
>>>> This set of patches was created with the intention of cleaning up
>>>> arch/mips/boot/dts/ralink/mt7621.dtsi so that it is aligned with
>>>> the Devicetree Sources (DTS) Coding Style [1] [2] guide.
>>>>
>>>> [1] Documentation/devicetree/bindings/dts-coding-style.rst
>>>>
>>>> [2] https://docs.kernel.org/devicetree/bindings/dts-coding-style.html
>>>>
>>>> Justin Swartz (14):
>>>>   mips: dts: ralink: mt7621: reorder cpu node attributes
>>>>   mips: dts: ralink: mt7621: reorder cpuintc node attributes
>>>>   mips: dts: ralink: mt7621: reorder mmc regulator attributes
>>>>   mips: dts: ralink: mt7621: reorder sysc node attributes
>>>>   mips: dts: ralink: mt7621: reorder gpio node attributes
>>>>   mips: dts: ralink: mt7621: reorder i2c node attributes
>>>>   mips: dts: ralink: mt7621: reorder spi0 node attributes
>>>>   mips: dts: ralink: mt7621: move pinctrl and sort its children
>>>>   mips: dts: ralink: mt7621: reorder mmc node attributes
>>>>   mips: dts: ralink: mt7621: reorder gic node attributes
>>>>   mips: dts: ralink: mt7621: reorder ethernet node attributes and 
>>>> kids
>>>>   mips: dts: ralink: mt7621: reorder pcie node attributes and 
>>>> children
>>>>   mips: dts: ralink: mt7621: reorder pci?_phy attributes
>>
>> These are all simple cleanups for the same file. It's one patch, not 
>> 15.
> 
> I agree these are all simple cleanups.
> 
> Even though the cleanup pattern was the same, or very similar,
> for each node affected, the intention was to isolate each change
> to a single node (or a grouping of nodes of that seemed logical
> to me) so that if anyone had any objections, the discussion would
> be easier to follow in subthreads identifiable by patch names (and

Objections to what? Coding style? Coding style is defined so you either
implement it or not... and even if someone disagrees with one line swap,
why it cannot be done like for every contribution: inline?

Organize your patches how described in submitting patches: one per
logical change. Logical change is to reorder all properties in one file,
without functional impact.

> thus subject lines) that clearly indicate the context.
> 
> But if there're no objections and it lessens the burden on
> maintainers upstream to have less patches to apply, then I have no
> problem combining them into a single patch.
> 

Yeah, one review response instead of 14 responses... One commit in the
history instead of 14.

Best regards,
Krzysztof


