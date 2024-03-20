Return-Path: <linux-kernel+bounces-109379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B90881844
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30C85B217E2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F3D85937;
	Wed, 20 Mar 2024 20:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTcnpGiR"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BEB8592B;
	Wed, 20 Mar 2024 20:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710965162; cv=none; b=ACgletDBjdd89W/vpWI+vXB2onEVQDrr86w0Ydc+C1OzOdC0osuMK+BrukyOWzan4srAA5DRAcct2iaMxU2Lqt4lXxVPtbv0bIwwacj1hcAJ7pRJZ5iSowTjC/2RFNx9N6MaHwAOebwsOoeheNeYhtrtQdBJNjEquXIOkt+9JdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710965162; c=relaxed/simple;
	bh=XPLYZCzSFf0t6yZ/0SxEIeG4AB/bcA2XHYuZVAsKjBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=itwsKPe+bkN4lMcqE7CfvnKF4vSbL4yBog8kwFvhNv4CqvtKi6QCsS+j0AyDtRHJBC9wlLkSirZ/OfYQBBUnh4eDoQt9Y+Ti5T+kufXKAu70pm29dCY3O1wetrx0uIeMtmMRToxBE+UxpvAbvCn5kFdt3fZocsqLJ0yLvoGtrJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTcnpGiR; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7cf25c1ee7aso7515439f.2;
        Wed, 20 Mar 2024 13:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710965159; x=1711569959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=mq9ESJC3fyCYMk10qgz1yahhrfxVx2rHNgbEzwMj/Ak=;
        b=jTcnpGiRp8Zy9D32GyEKVAHdY0L9bcMeoSdVNWzDPUhP3O9rJinVgcvJf4Wtvnr6KO
         9CGsZvhhf2kYZTXYKVVvxShsjA46rlFtlTAtxclt+HMfk6MfBZGRaXGncDdRJfAORsVw
         jTq06Vfmy8HasK/ArRzKXqRi26CDCmByh6LWNHmKMIYwurO/GKnPSTIkZGL3GVxbP1/z
         JWrS12RF+y8LhrlxntjBOgCeYNIQYwztlzUqvPn+KrJwG6Aho30znZzHguuBTic+z8ii
         ecMsLDyMk3lA4E0vL737eSxk1V6Tv9txWeIZoflAsVJWK9RYvh+ngIl2aM3ePvmqMZt2
         Z7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710965159; x=1711569959;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mq9ESJC3fyCYMk10qgz1yahhrfxVx2rHNgbEzwMj/Ak=;
        b=DdCga/XKrly21Z0Gzwy9Ak8L7gUR4p+Y369lP8XnOns+1XdVvVg7nYoGJ9pPy22lDA
         Uc6I9fedb4avb1eG6Z2hDca8ZPINa3qSu3DN6O5Wrtpc1k1+puMIAg5Naik/PmqLMNST
         0QpTrK8hh27i7LGg53mf9I7Yd//PFD2HUi14+esQPuzavhrKBsY/ZzVIaQeyrDnehKlC
         Ah3AzbhyTDoJuF7mPeKKujz3sJxHgGdHLZb+GgAGxImP32DlJMl7I0xAAmb8jvqKOeL2
         x2BziMoDdxLv64iSeFyrv6b5C/sB8XftL3zvYR8hsMlFwZmHrY6r+xwVVmiSTkPffDRp
         +tvw==
X-Forwarded-Encrypted: i=1; AJvYcCWTfXNpusGPWuu5f3sA79Dl8r4n3xSuqg2eujS0p/PGGPxs0Ia1RMngzSJf244qI2zkPdtf8kHA0P2TxXadNK3Kx5U8E/r6CIzhTt+Y/AayGCYD3FISRljfRJ6S8d/78bYA8tNtT8542Q==
X-Gm-Message-State: AOJu0YyX4AnBr6hbwFnXYaVmdRF2vbbZSCierQ4bF32HMtCAWj+24jSq
	vtUDvmKeeSBIzFksYaZGjqwUErMweURsG9T7SI+V0NcU22OYRSb8gwS4CsR7
X-Google-Smtp-Source: AGHT+IEb+EAgNc8Se4L2RIZ6+xnzWsuM/sAiI8clA2WhDD2Hh5VBPI8Wfwor4JXFh/r3abjXc1Zbdw==
X-Received: by 2002:a05:6602:8cc:b0:7cb:e510:c289 with SMTP id h12-20020a05660208cc00b007cbe510c289mr17388640ioz.9.1710965159645;
        Wed, 20 Mar 2024 13:05:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c36-20020a634e24000000b005db034d1514sm11215955pgb.82.2024.03.20.13.05.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 13:05:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <23ed5bbb-7616-424b-96ee-3fe1c6d8ca89@roeck-us.net>
Date: Wed, 20 Mar 2024 13:05:57 -0700
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
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAL_Jsq+0JHTDmBPr94ZZF_5rtQg14q8OmWH6WpRspjHMX-MZmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/20/24 12:14, Rob Herring wrote:
> On Mon, Mar 18, 2024 at 4:31 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 3/18/24 12:26, Rob Herring wrote:
>>> +Stephen
>>>
>>> On Mon, Mar 18, 2024 at 12:09 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On Fri, Mar 17, 2023 at 12:34:14AM -0500, Frank Rowand wrote:
>>>>> When enabling CONFIG_OF on a platform where of_root is not populated by
>>>>> firmware, we end up without a root node. In order to apply overlays and
>>>>> create subnodes of the root node, we need one. Create this root node
>>>>> by unflattening an empty builtin dtb.
>>>>>
>>>>> If firmware provides a flattened device tree (FDT) then the FDT is
>>>>> unflattened via setup_arch().  Otherwise setup_of(), which is called
>>>>> immediately after setup_arch(), will create the default root node
>>>>> if it does not exist.
>>>>>
>>>>> Signed-off-by: Frank Rowand <frowand.list@gmail.com>
>>>>
>>>> This patch results in a crash on nios2.
>>>
>>> This patch was never applied. I assume you meant a later version of it
>>> that did get applied.
>>>
>>>>
>>>> Building nios2:10m50-ghrd:10m50_defconfig:10m50_devboard.dts ... running ...R failed (crashed)
>>>
>>> Booting with DT?
>>>
>>>> ------------
>>>> qemu log:
>>>> earlycon: uart8250 at MMIO32 0x18001600 (options '')
>>>> printk: legacy bootconsole [uart8250] enabled
>>>> Linux version 6.8.0-11409-gf6cef5f8c37f (groeck@desktop) (nios2-linux-gcc (GCC) 11.4.0, GNU ld (GNU Binutils) 2.40) #1 Sun Mar 17 23:38:59 PDT 2024
>>>> Kernel panic - not syncing: early_init_dt_alloc_memory_arch: Failed to allocate 72 bytes align=0x40
>>>> ---[ end Kernel panic - not syncing: early_init_dt_alloc_memory_arch: Failed to allocate 72 bytes align=0x40 ]---
>>>
>>> nios2 looks utterly broken to me. This change should be a nop unless
>>> initial_boot_params is NULL. It looks like it is possible for r6 (dtb
>>> address) to be 0 depending on kconfig options, but that would have
>>> skipped copying and unflattening which would then panic in
>>> setup_cpuinfo(). If initial_boot_params is not NULL, then the same
>>> early_init_dt_alloc_memory_arch() calls should fail when copying the
>>> DT. So I don't see how nios2 booting with DT ever worked.
>>>
>>
>> For nios2, in early_init_devtree():
>>
>> void __init early_init_devtree(void *params)
>> {
>>           __be32 *dtb = (u32 *)__dtb_start;
>>          ...
>>           if (be32_to_cpu((__be32) *dtb) == OF_DT_HEADER)
>>                   params = (void *)__dtb_start;
>>
>> That worked fine until this patch. Starting with this patch, __dtb_start
>> always points to a valid empty devicetree blob, which overrides the
>> devicetree blob passed to early_init_devtree(). This causes the problem.
> 
> With an external DTB, it doesn't boot with or without this patch. It
> just dies in different spots. Before it just skipped any memory

No, that is incorrect. Up to this patch it booted just fine with an
external dtb using the "-initrd" command line argument, and I explained
to you above why this is the case.

I guess you are saying I should stop boot testing nios2. I'll do just that.
Saves me resources and avoids discussions like this.

Guenter


