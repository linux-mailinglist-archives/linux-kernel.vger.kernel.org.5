Return-Path: <linux-kernel+bounces-106649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DF687F186
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8811F2175D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3966152F98;
	Mon, 18 Mar 2024 20:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8wFHt2h"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851DA2374C;
	Mon, 18 Mar 2024 20:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710794837; cv=none; b=puy7xqyr80RSUrhLHTneO9TStL/Wu1XzesKVU592mJSs/Wg4yxqNFNiSh9mg5tSjar99UBCUPqlWfBu0gf1LVA1c6HLLtzo/3p/nP003sBhnAYVe6zGSzSfL9h8AsFycHihXfBFLP+N2o+iZGLcdMS7VdqJKfGTsz1Yl7a1eyzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710794837; c=relaxed/simple;
	bh=propEZiaTFPfb98S1/if7kHudI0IPUijlSrOPK+6Eg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RwGjD2Uqz8FU87CLKHCa6y2hPwKJsQpaivShWsVVIP0ljjm+9FPY3WlwmdSN+2P2DrQ+z2agzaqRtdz4uGMH8CZx5FxzSus9h8UDO03RD7GoQ374YC0kjJ9QDM1MNfp1460XMD45MkQ/QL6SnmfduJUhGqGZdvomLFmzkvB7BMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8wFHt2h; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a1bd83d55dso1855378eaf.2;
        Mon, 18 Mar 2024 13:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710794834; x=1711399634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Bc+UKdozhBzHVHSFyFyGz25vJz3UJoLR5quhN0tZVyU=;
        b=T8wFHt2h4ac92AVEfN0Hvw3bkKVB8m2KzGd0H9FoWN6+5VEXwqFSQnouvjCGykEiMj
         CNcGhKNF2mnXqq03kX26CqsBR+aYb0qajdH/5+dtdNGmGp9V1IbOZzM0V/H9KONJXiBq
         hBOJA98xZDPhLsYb7M9yu9NRzcZbSA2qwuaIvSbpdQU8hVkPqxGZ/hDyYJ7grhAlXbcp
         RkoCVo7vAAEvzryw6RjQk/Zq6nk9tdxN/+XVkOIn186OnhXa6ZAbp1xjqPCT3amkg3EY
         qhy3+B/mDwc7bRFIopisnJG+ZmaLp4HIL4n37IyaoXx6uvuUREWVNnMxfX0X9D33jBXk
         7KOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710794834; x=1711399634;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bc+UKdozhBzHVHSFyFyGz25vJz3UJoLR5quhN0tZVyU=;
        b=AcDPCj65p7ICrvmfzssF2TKl90CAU/Akmj45Qddc3o48INSANlnERNPbx4w5DYxYar
         qW+uO3KNN7Q3hprnXPxGs+ro9L4MZ+n954BcNW3NSXTLEly+YoqwyhrkW7X3naOECGjD
         67t/gmTcuGVXS8Uvx+IcECcYCqtNCExdfOMN5ZucEZLIR2mtDfBmx7QDoCi18VA+fF6c
         6q6OrzsFIk3kfoEQ9NwbfNFUniCiGsPhCB8/VCRzDVmZSOfWWDckNHD5CNFyTSWOKLRq
         mOy5QdSjzEOsdwzvsWCLpLl7rtmVHNNFPjVmlh2bjkHqatEqhdH0fNuBa01dUTU0o3fN
         HbgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZlpkfUOPj/bjpwfaniO1B/kwIuNH+zrTMkxx/Ud5HjTPFBd+O+WHQZp5NKIH3KClQp/zivVQcUCEq1AIUUjC5uoLyg6N3egFBnzDF/bnxzvn5xZGEe9LWYWMI2a3F0uOOcu1X6/quCQ==
X-Gm-Message-State: AOJu0YxtQn0K9Yg4HCU31Zf33id7Z265QZTx7VTDZK771SV1ooSk0hfr
	i1YPpZUA/U9sgTjKI0dDf+PfOG6Hu9ggDr0UTmi0Wgl2EQbdTJUz
X-Google-Smtp-Source: AGHT+IE0ymGgtO4x+xkYqfk4U10ppkOio8I2ZH26Wj8PUeHYtk6oGX3JHoevr+p1KcKIg3If2y3S6w==
X-Received: by 2002:a05:6358:5605:b0:17e:f422:5e48 with SMTP id b5-20020a056358560500b0017ef4225e48mr3794718rwf.13.1710794834596;
        Mon, 18 Mar 2024 13:47:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q20-20020a62ae14000000b006e6c38cbe96sm8352379pff.29.2024.03.18.13.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 13:47:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d259663b-8713-4c7a-8872-ea775882891d@roeck-us.net>
Date: Mon, 18 Mar 2024 13:47:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] of: create of_root if no dtb provided
Content-Language: en-US
To: Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>,
 =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lizhi Hou <lizhi.hou@xilinx.com>, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230317053415.2254616-1-frowand.list@gmail.com>
 <20230317053415.2254616-2-frowand.list@gmail.com>
 <886049ed-4f5f-4e17-86f4-1245024ade3a@roeck-us.net>
 <CAL_JsqKsF53v7d7uZ3XT4kPFy-2FBWHfvKNSFdTx2oZhmSZkDA@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAL_JsqKsF53v7d7uZ3XT4kPFy-2FBWHfvKNSFdTx2oZhmSZkDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/18/24 12:26, Rob Herring wrote:
> +Stephen
> 
> On Mon, Mar 18, 2024 at 12:09 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Hi,
>>
>> On Fri, Mar 17, 2023 at 12:34:14AM -0500, Frank Rowand wrote:
>>> When enabling CONFIG_OF on a platform where of_root is not populated by
>>> firmware, we end up without a root node. In order to apply overlays and
>>> create subnodes of the root node, we need one. Create this root node
>>> by unflattening an empty builtin dtb.
>>>
>>> If firmware provides a flattened device tree (FDT) then the FDT is
>>> unflattened via setup_arch().  Otherwise setup_of(), which is called
>>> immediately after setup_arch(), will create the default root node
>>> if it does not exist.
>>>
>>> Signed-off-by: Frank Rowand <frowand.list@gmail.com>
>>
>> This patch results in a crash on nios2.
> 
> This patch was never applied. I assume you meant a later version of it
> that did get applied.
> 

It is the patch in the link that was provided with the patch. What else
should we use as reference ? FWIW, I did look for a more recent version,
but I must have missed it. My bad.

>>
>> Building nios2:10m50-ghrd:10m50_defconfig:10m50_devboard.dts ... running ...R failed (crashed)
> 
> Booting with DT?
> 

Yes, with arch/nios2/boot/dts/10m50_devboard.dtb.

>> ------------
>> qemu log: >> earlycon: uart8250 at MMIO32 0x18001600 (options '')
>> printk: legacy bootconsole [uart8250] enabled
>> Linux version 6.8.0-11409-gf6cef5f8c37f (groeck@desktop) (nios2-linux-gcc (GCC) 11.4.0, GNU ld (GNU Binutils) 2.40) #1 Sun Mar 17 23:38:59 PDT 2024
>> Kernel panic - not syncing: early_init_dt_alloc_memory_arch: Failed to allocate 72 bytes align=0x40
>> ---[ end Kernel panic - not syncing: early_init_dt_alloc_memory_arch: Failed to allocate 72 bytes align=0x40 ]---
> 
> nios2 looks utterly broken to me. This change should be a nop unless
> initial_boot_params is NULL. It looks like it is possible for r6 (dtb
> address) to be 0 depending on kconfig options, but that would have
> skipped copying and unflattening which would then panic in
> setup_cpuinfo(). If initial_boot_params is not NULL, then the same
> early_init_dt_alloc_memory_arch() calls should fail when copying the
> DT. So I don't see how nios2 booting with DT ever worked.
> 

All I can say that it did work with devicetree until this patch was
applied. It doesn't boot without it. I tried without devicetree file
after reverting this patch. That results in

Kernel panic - not syncing: setup_cpuinfo: No CPU found in devicetree!

Guenter


