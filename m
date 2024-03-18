Return-Path: <linux-kernel+bounces-106136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E576A87E9AC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BDA228280F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D33838387;
	Mon, 18 Mar 2024 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWaRJ2ym"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0C0364C0;
	Mon, 18 Mar 2024 13:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710766932; cv=none; b=A7cjAjdJS0SDJ/HpZWoE6cBojlvP8/3Uz8expVu0zvkgUZpEwF1ziHPA7qu4uKu1dItiTNFjQHXl+virbFgxivERucqpp0MFwSmkrpGv6n5DCQw3p10QHqjYzbRl+Uvpea0wJLMFgvvkQ0PmBXL+LDFIya+i1loIBJb+DBTk2c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710766932; c=relaxed/simple;
	bh=Ne+QD4l2ggE3c/dHZoBUl6FIenRY0F5VSADrmBMn8vU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=giXtx/CZdVR6JADYrZdfZ6FtddnPA4aoJsTZIWJbGav2ehEPCeqUNlIZdlLazJb19hGg38rWFHWcb/6eeyP+vHN5hY+uZpgnADXxVKlheFA2RueRQP2C1hcdcM8TPTV971unzhURwSbTaey9pBqNDNp9C6pmSdoC2s4/9gxEL1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWaRJ2ym; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-789e6f7f748so167382285a.3;
        Mon, 18 Mar 2024 06:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710766930; x=1711371730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bAu2yFQ9XYGhPb6HiB8uMF5Ul/C5kQswWx8qdnbtFXU=;
        b=iWaRJ2ymdnddFONuN5bcZNUc50sTlv8isvzWTS/iHmg6zFak9Sa3HOiGzb/vUANfpd
         rmeIEYLzmNv7/BQq+HnDQ4npJbv/5f1sHDi4DlHyuxct76TylvgZ+QeIyHlUpuJEakf8
         3Tels/mehDTX86eMvNHLuIe6iP6/W+SFEt3rntLOHwGi9HRiiggO2do7IkD36mUHJ/s9
         lyebUNZyXVwo4TDJu27kpyxzrciSZvfkod5gI/7+D2+DIztjXI39W9++k4xZHPu1OMxS
         z4XCQhdJA667gYgPv7xhDHMMtCSTBQ7/VPmknhJzl8M3JIIYMW51BpEsVwQU/Bwi7zLu
         VH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710766930; x=1711371730;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bAu2yFQ9XYGhPb6HiB8uMF5Ul/C5kQswWx8qdnbtFXU=;
        b=iHVqw/S5rrDKwpWzEG3sVTP3FKBk3mex5GdvIgN8nld+S0LINYKLplTVSmtiriEQmY
         F5CT+O/4iWlEpPFoo3odNIhKEW7R18zFS+VEzhRfMs+sKv5WRkBbWRT4G4NIVUjpxdfT
         PU6aDmRGICl9wMJJZd54oUt/Sq8SA233e+nvpM3c2h29rTj81OYymwbrwN53DtQEd/G/
         O2fXTLStR9gljByL8PLDEL26LEPRmh0hX4zQ4jaJZmePCw9ePqUQtxLA/l9+CasLWofh
         /QszgV5bJCAwXnelkLhgU0iUj5jW1i2HcWcRO0zxkq5Mg7AFymr2w6vzBas730ArITQa
         r0yA==
X-Forwarded-Encrypted: i=1; AJvYcCUyYQBrdo28W+PdgfwXlKFAqsDa3dsEdE3Cout4qzTHAiDVxXhTRbWody81DtdB5ob+vYu/DXADOwIV6xDC2VP0voqFMlM8dqIoqfdd17rdudr6LOdy6Rqv1XejE0RzAiYU3cPRwYJtWQ==
X-Gm-Message-State: AOJu0YxE9C85nYtYsWFeQE2zKfSLf4vR92e70FOg7sHMozTwpTv8Pxey
	N1TSOLj89jN4Skgp5UeqBGaNZnHSrnp7NCdIhJJhBAAOPrEk88xF
X-Google-Smtp-Source: AGHT+IHrWlXV9bK21Sik7/qiUxl9oaGP19J0sKYrEwO0Nqr+fk5XL4r39r3fx6ierCbsJFqivBtFmA==
X-Received: by 2002:a0c:e8c6:0:b0:690:f57c:b65c with SMTP id m6-20020a0ce8c6000000b00690f57cb65cmr11723077qvo.23.1710766930033;
        Mon, 18 Mar 2024 06:02:10 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id r1-20020a056214212100b006906adc8aa2sm5248974qvc.102.2024.03.18.06.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 06:02:09 -0700 (PDT)
Message-ID: <71dd200a-0306-4baa-abab-6e6906aeef2a@gmail.com>
Date: Mon, 18 Mar 2024 06:02:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: mediatek: mt7622: set PHY address of
 MT7531 switch to 0x1f
Content-Language: en-US
To: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240314-for-mediatek-mt7531-phy-address-v1-0-52f58db01acd@arinc9.com>
 <20240314-for-mediatek-mt7531-phy-address-v1-1-52f58db01acd@arinc9.com>
 <94e3d09a-e6a4-4808-bc29-3f494b65e170@gmail.com>
 <62d128f1-11ac-4669-90ff-e9cdd0ec5bd9@arinc9.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <62d128f1-11ac-4669-90ff-e9cdd0ec5bd9@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/16/2024 12:43 AM, Arınç ÜNAL wrote:
> On 15.03.2024 20:26, Florian Fainelli wrote:
>> On 3/14/24 05:20, Arınç ÜNAL via B4 Relay wrote:
>>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>>
>>> The MT7531 switch listens on PHY address 0x1f on an MDIO bus. I've 
>>> got two
>>> findings that support this. There's no bootstrapping option to change 
>>> the
>>> PHY address of the switch. The Linux driver hardcodes 0x1f as the PHY
>>> address of the switch. So the reg property on the device tree is 
>>> currently
>>> ignored by the Linux driver.
>>>
>>> Therefore, describe the correct PHY address on boards that have this
>>> switch.
>>
>> Can we call it a pseudo PHY to use a similar terminology as what is 
>> done through drivers/net/dsa/{bcm_sf2,b53}*?
>>
>> This is not a real PHY as in it has no actual transceiver/digital 
>> signal processing logic, this is a piece of logic that snoops for MDIO 
>> transactions at that specific address and lets you access the switch's 
>> internal register as if it was a MDIO device.
> 
> I can get behind calling the switch a psuedo-PHY in the context of MDIO.
> However, as described on "22.2.4.5.5 PHYAD (PHY Address)" of "22.2.4.5
> Management frame structure" of the active standard IEEE Std 802.3™‐2022,
> the field is called "PHY Address". The patch log doesn't give an identifier
> as to what a switch is in the context of MDIO. Only that it listens on a
> certain PHY address which the term complies with IEEE Std 802.3™‐2022.
> 
> So I don't see an improvement to be made on the patch log. Feel free to
> elaborate further.

I would just s/PHY/MDIO bus address/ since that is simply more generic, 
but if it is not written as-is in the spec, then I won't fight it much 
more than I already did.
-- 
Florian

