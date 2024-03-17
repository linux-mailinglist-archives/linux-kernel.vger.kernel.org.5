Return-Path: <linux-kernel+bounces-105430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE7987DDC5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AF10B20C4C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7221C69D;
	Sun, 17 Mar 2024 15:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vMEWi3Zo"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1731C693
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710688209; cv=none; b=VtD7VmgB/kOmonUK6DJacPJbyhiiKbuLDRdvcKLJ/2Pt5kbs3OE4I9sDUzP/VnRa7lWPzRdpzNV5OXGGirXr0PZwh1qnFAlQxdrkjO0b6UrwpXzyw64PsOOheAiBiTApnjaro3rX4Zgz16niUSZqV0YVVpCzABciiqTbypFqw6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710688209; c=relaxed/simple;
	bh=K9vt4fpPcRMmo8/ZtcWt8DxqyTLCJlsdN+NriAeO4MM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n98oZFCuxnVh6Y09CeSxQhlQKYqFC2nd2/Yg7ZVIspwreuw++klWaoDZ3ituD3NxW2mKOt28cz+xK8wpNQoxwQNPfuvCcdTP4TkDAPGz5xzFr3E8l36PrNzbUJq49z7YUxienKE6oSwDQ5ICEVapO2MRgKZxucm1Fd4EeBB/2Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vMEWi3Zo; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a44ad785a44so403559266b.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 08:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710688206; x=1711293006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=52LFxewU+lJnUU/UkYouuSQjkj5zFMWyV+Agj/X5Res=;
        b=vMEWi3Zo3gACNgkWhCsV3NZ+tVzeT8FMExg7Lwl2sB+cTyECwCM3kSjx52s9XJef9j
         t0cg0X59zLsiPd8uYD+5xKpHmcvb3WnYtsWt2n0XtoZ4DmagahW5t/iOE57vQl0SQ8gh
         DhhrXw6Ge39CK5vvibV4dncgPuJLBF3z/c3zbshZSHi6ll69uYuXa8vgppAxD4nh+DLa
         tYALzZo5Tsyr7maN7YA8FlvG2qvgS0XfhhZZNrVaFI8DORckaMe/jWcMOBqWHf2gfTz7
         Gj8FftyGB/F6sdhchc+8nGVQ2XVGgwx2PwOPV/OQnk3DoP4BV1zmdKs4H001ecmsSj4/
         zl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710688206; x=1711293006;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=52LFxewU+lJnUU/UkYouuSQjkj5zFMWyV+Agj/X5Res=;
        b=kZFWuQG/GklJHI7NQuTBfz/THeH9vLsRnf1HQJAPinjztVx5ubPQLI5XzIzv1kMmcW
         eqG0qdbCouCKBoupFtzAJri3gKquCPYgKLMAhMDX/Wm6PXpgTELFq1GPJLp+4b4L0z1J
         ZA325NyQByohEqhPHShp6loxQTGLQwb6oBA26zOfID7Bqs0WXEuko993FZRxqCktEkat
         XKpMbj+m3nI8PenBknW4JmxJWBmDhPtwMCzLVmaZZ0WnGqB7LOwVcwHkbiwGGjDxbKGg
         Y0Rmd4+GlY7+73rMnzJSLN1xSHoQXhXtpkAL64sQLDszDoRF3tMZMKxNZbdprAPU4zi3
         GTfA==
X-Forwarded-Encrypted: i=1; AJvYcCUs+9b/5pOKjHnecgAeU18ZntzxaAARQdvAFkp+hecsouNTOVTjSExMrV8MqjyR3ZlSg+juUh4HoJn0b3U1QFk2nAbH+NntzbLGtY3a
X-Gm-Message-State: AOJu0YzqMWUeK18fzs9Dss72gkNCLiDZNLRK5tuQSugkYywgrDchH7Yl
	FOYdDcUlQ/43jOSgPBD9414zzFaiHfsJmNgczxs2VxnUJKg/ArU/H2GlB+fIagU=
X-Google-Smtp-Source: AGHT+IHXTfMCScXM1mkWeoif93ohDO1yjqtnmmUV/LOWvpVMz4oAN4Nji+UifEYxoUMrCTVuc9CW9A==
X-Received: by 2002:a17:907:868f:b0:a46:a9a7:fbec with SMTP id qa15-20020a170907868f00b00a46a9a7fbecmr2806408ejc.76.1710688206136;
        Sun, 17 Mar 2024 08:10:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id f23-20020a170906049700b00a3efa4e033asm3853301eja.151.2024.03.17.08.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 08:10:05 -0700 (PDT)
Message-ID: <60512ae2-dd73-4cb6-9514-145f946300fc@linaro.org>
Date: Sun, 17 Mar 2024 16:10:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] mips: dts: ralink: mt7621: improve DTS style
Content-Language: en-US
To: Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>
Cc: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
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
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAMhs-H9ZO-sitsrASuvsEd+ddwVyHH35gj7yAABTqFNfOCGYYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/03/2024 16:49, Sergio Paracuellos wrote:
> On Sat, Mar 16, 2024 at 5:54 AM Justin Swartz
> <justin.swartz@risingedge.co.za> wrote:
>>
>> This set of patches was created with the intention of cleaning up
>> arch/mips/boot/dts/ralink/mt7621.dtsi so that it is aligned with
>> the Devicetree Sources (DTS) Coding Style [1] [2] guide.
>>
>> [1] Documentation/devicetree/bindings/dts-coding-style.rst
>>
>> [2] https://docs.kernel.org/devicetree/bindings/dts-coding-style.html
>>
>> Justin Swartz (14):
>>   mips: dts: ralink: mt7621: reorder cpu node attributes
>>   mips: dts: ralink: mt7621: reorder cpuintc node attributes
>>   mips: dts: ralink: mt7621: reorder mmc regulator attributes
>>   mips: dts: ralink: mt7621: reorder sysc node attributes
>>   mips: dts: ralink: mt7621: reorder gpio node attributes
>>   mips: dts: ralink: mt7621: reorder i2c node attributes
>>   mips: dts: ralink: mt7621: reorder spi0 node attributes
>>   mips: dts: ralink: mt7621: move pinctrl and sort its children
>>   mips: dts: ralink: mt7621: reorder mmc node attributes
>>   mips: dts: ralink: mt7621: reorder gic node attributes
>>   mips: dts: ralink: mt7621: reorder ethernet node attributes and kids
>>   mips: dts: ralink: mt7621: reorder pcie node attributes and children
>>   mips: dts: ralink: mt7621: reorder pci?_phy attributes

These are all simple cleanups for the same file. It's one patch, not 15.

Best regards,
Krzysztof


