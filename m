Return-Path: <linux-kernel+bounces-121452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4689488E814
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B65711F2D648
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B646113A41E;
	Wed, 27 Mar 2024 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjrZ+p0J"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74AA12F596;
	Wed, 27 Mar 2024 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711550444; cv=none; b=oQ/6o9LWw3ehnaHOmbIA7t5Qu7r/zn54vSTGvKfD7cArrnv9Xb3HqeOKJn7o+sw/wuUoaqmyeKZT+L50k1Hea03ZhLBg3pykPISDIEh05bmi2rrBUJPM67CLN2iBZs6iUUqQ/w6emm3PMLlbZBD4y3cMX3EcGGikvOdmoQZOXQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711550444; c=relaxed/simple;
	bh=9iw0cPN/El4SUXng6MpPy8w5F3G25ZzYXhGRVh+Geto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OnlmbmlQTT0mYcpRi1rwDgSyuRSXoaXYM7eMlpVE6AWtuDRD1FlJMm/okopj0SVWldZeXRzTsHC+GX1/sDJKMYoiyVf0HO/iWaPpLXTzb6yRod8FAeX0Kn8GoHrzjKiB8SNyL73j4UeRKMntMI5mjYy+L9YIhnj9FoVRsfqjBU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjrZ+p0J; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e740fff1d8so4945312b3a.1;
        Wed, 27 Mar 2024 07:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711550442; x=1712155242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fh0br4u9nmO8bhUaqt830r/M0VgT6+D4/0SekceSnZg=;
        b=TjrZ+p0JNhYoomZdvLFBLvtTogFpk2NLVIGVGNpP9/EounG+kGLMKThC4D/QK+bXF2
         eBSibATPt6vCdeGVOX/RyilHU1gl0fYGwX6Oqqfp7h5kPCBsRmghhWHRkhwSqP23Fvzg
         IKTz5kj/k1xGfqPpQYh3mk84mWjZYLFsw4PDuIwCzSI/q8hKTYEZlIuzJH5AdM8BmQC4
         uka/rcWxfaCezEnkd159NQFJiFh4PP7JyNjylmUMFiHCzMbRtUfBkgbnRKhX/dSAZZH5
         kJeFnLPTZYfpHOeKGyJGY99GwAC0smqBctNa8sQPH97kKDa0IG9oPRmeyJdRskjzANFN
         1VnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711550442; x=1712155242;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fh0br4u9nmO8bhUaqt830r/M0VgT6+D4/0SekceSnZg=;
        b=TSZ+Tc4qUGtgO5Iwz+aJ5++y6VnOqh7Dv6K5VIubOOGqo8IcXCg8dTI/6l/MjG8iSW
         vl41E+STKKDExi5ytfZNs1RcNf5y7TM7YpKO1fE2dmqrJwVSHoOb9+X3EFadSOqm/40t
         sgz/WYQdWScQI+wEytSdA7C9MQVBrxsAUE0IcTZeveXfpzEGmkYFSAxp6SGtCdFpdUgy
         qU0HwoLaGq6Y0Gpxbq6TvnCDMaDfSUXkoPFaLFNADfN+Xbu5OufPPFcQrP/jvOB4WzT+
         g8HIN4g5uX3+LvyDfxzX2u49smhcEyMYd/xlbWrg0pnNNm1klJ6tjhziqj9vM/CMX3tv
         +m+A==
X-Forwarded-Encrypted: i=1; AJvYcCWYBGjEHkqGnporYjFt73x9KQTQYr1ELR3OLyDO7qJ7UO8eQuB4tDe1EwIAIUF88ByqREWzMGwYbz9pVA+uzTpQsQuS1/g4ZWUIRFJeb/H1L9Mu6EFsv3SHifKJ9ttAc7uH4aRCNsbYzQ==
X-Gm-Message-State: AOJu0YxVnCY11IVQHuje0lQ/meaEshcmvkty5Mh8uvG4zrcjKSgf8Wi5
	pfAIVijSK5GAFS0mW8TszdfFWsxSS07xTnyCtKbnea3yC67nBql8
X-Google-Smtp-Source: AGHT+IHzceyQO7nGVYYKgySDI0olHdr0pYd8vChGGsGyufQkL8zEaApCwJme5730z/qh2J+yezKAOw==
X-Received: by 2002:a05:6a21:3385:b0:1a3:68ff:5805 with SMTP id yy5-20020a056a21338500b001a368ff5805mr118301pzb.44.1711550442032;
        Wed, 27 Mar 2024 07:40:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z4-20020a626504000000b006eaad01817esm5512780pfb.105.2024.03.27.07.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 07:40:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <407867d2-2e32-4df4-96ac-f9ae84b44375@roeck-us.net>
Date: Wed, 27 Mar 2024 07:40:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] of: create of_root if no dtb provided
Content-Language: en-US
To: Rob Herring <robh+dt@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
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
 <66409df9-6f5f-4fbe-ae7f-47b86665c113@roeck-us.net>
 <CAL_Jsq+0JHTDmBPr94ZZF_5rtQg14q8OmWH6WpRspjHMX-MZmg@mail.gmail.com>
 <23ed5bbb-7616-424b-96ee-3fe1c6d8ca89@roeck-us.net>
 <CAL_JsqJd-upC4TgOwP5-DMXKL+x=X7sGC7qqiy2PTjD6pnSV7Q@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAL_JsqJd-upC4TgOwP5-DMXKL+x=X7sGC7qqiy2PTjD6pnSV7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/27/24 06:11, Rob Herring wrote:
> On Wed, Mar 20, 2024 at 3:06 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 3/20/24 12:14, Rob Herring wrote:
>>> On Mon, Mar 18, 2024 at 4:31 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> On 3/18/24 12:26, Rob Herring wrote:
>>>>> +Stephen
>>>>>
>>>>> On Mon, Mar 18, 2024 at 12:09 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On Fri, Mar 17, 2023 at 12:34:14AM -0500, Frank Rowand wrote:
>>>>>>> When enabling CONFIG_OF on a platform where of_root is not populated by
>>>>>>> firmware, we end up without a root node. In order to apply overlays and
>>>>>>> create subnodes of the root node, we need one. Create this root node
>>>>>>> by unflattening an empty builtin dtb.
>>>>>>>
>>>>>>> If firmware provides a flattened device tree (FDT) then the FDT is
>>>>>>> unflattened via setup_arch().  Otherwise setup_of(), which is called
>>>>>>> immediately after setup_arch(), will create the default root node
>>>>>>> if it does not exist.
>>>>>>>
>>>>>>> Signed-off-by: Frank Rowand <frowand.list@gmail.com>
>>>>>>
>>>>>> This patch results in a crash on nios2.
>>>>>
>>>>> This patch was never applied. I assume you meant a later version of it
>>>>> that did get applied.
>>>>>
>>>>>>
>>>>>> Building nios2:10m50-ghrd:10m50_defconfig:10m50_devboard.dts ... running ...R failed (crashed)
>>>>>
>>>>> Booting with DT?
>>>>>
>>>>>> ------------
>>>>>> qemu log:
>>>>>> earlycon: uart8250 at MMIO32 0x18001600 (options '')
>>>>>> printk: legacy bootconsole [uart8250] enabled
>>>>>> Linux version 6.8.0-11409-gf6cef5f8c37f (groeck@desktop) (nios2-linux-gcc (GCC) 11.4.0, GNU ld (GNU Binutils) 2.40) #1 Sun Mar 17 23:38:59 PDT 2024
>>>>>> Kernel panic - not syncing: early_init_dt_alloc_memory_arch: Failed to allocate 72 bytes align=0x40
>>>>>> ---[ end Kernel panic - not syncing: early_init_dt_alloc_memory_arch: Failed to allocate 72 bytes align=0x40 ]---
>>>>>
>>>>> nios2 looks utterly broken to me. This change should be a nop unless
>>>>> initial_boot_params is NULL. It looks like it is possible for r6 (dtb
>>>>> address) to be 0 depending on kconfig options, but that would have
>>>>> skipped copying and unflattening which would then panic in
>>>>> setup_cpuinfo(). If initial_boot_params is not NULL, then the same
>>>>> early_init_dt_alloc_memory_arch() calls should fail when copying the
>>>>> DT. So I don't see how nios2 booting with DT ever worked.
>>>>>
>>>>
>>>> For nios2, in early_init_devtree():
>>>>
>>>> void __init early_init_devtree(void *params)
>>>> {
>>>>            __be32 *dtb = (u32 *)__dtb_start;
>>>>           ...
>>>>            if (be32_to_cpu((__be32) *dtb) == OF_DT_HEADER)
>>>>                    params = (void *)__dtb_start;
>>>>
>>>> That worked fine until this patch. Starting with this patch, __dtb_start
>>>> always points to a valid empty devicetree blob, which overrides the
>>>> devicetree blob passed to early_init_devtree(). This causes the problem.
>>>
>>> With an external DTB, it doesn't boot with or without this patch. It
>>> just dies in different spots. Before it just skipped any memory
>>
>> No, that is incorrect.
> 
> Well, I can tell you it doesn't boot for me. So I must be doing
> something different from your setup.
> 

Maybe you have OF_UNITTEST enabled and it indeed results in the
problem you mention below. I don't have it enabled because it produces
various backtraces which would hide real problems.

>> Up to this patch it booted just fine with an
>> external dtb using the "-initrd" command line argument, and I explained
>> to you above why this is the case.
> 
> What does -initrd have to do with anything? Does that shift where the
> external dtb is placed or something?
> 

Nothing. I meant to say -dtb.

> I think I see the issue. __dtb_start points to the start of *all*
> built-in DTBs, not a specific one. In this case, arc, csky, loongarch,
> mips, openrisc, riscv, sh, and xtensa may all be broken too (if one
> picks the magic combination of booting modes and kconfig options). I

No.

- arc only picks the internal dtb if use_embedded_dtb is true. This flag
   is only set if there is no external dtb, or if the external dtb does
   not provide a valid machine description.
- openrisc only picks the internal dtb if no external dtb is provided.
- riscv only picks the internal dtb if CONFIG_BUILTIN_DTB is enabled.
- sh only used the internal dtb if CONFIG_USE_BUILTIN_DTB is enabled.
- xtensa only picks the internal dtb if there is no external dtb.

However, nios2 picks the internal dtb _even if_ an external dtb
is provided if there is an internal dtb. In other words, it prefers
the internal dtb over the external dtb. All other architectures
prefer the external dtb over the internal dtb.

> would expect all these cases have been broken forever if the DT
> unittest is enabled as it too adds a built-in dtb. But I would also

Even if that is correct for nios2, that hardly seems to be an argument
to break nios2 boot with external dtb unconditionally.

Thanks,
Guenter


