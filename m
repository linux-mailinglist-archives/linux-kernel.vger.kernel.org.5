Return-Path: <linux-kernel+bounces-931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71676814830
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7C5CB2236A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE8F2AD2D;
	Fri, 15 Dec 2023 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7K9SAhs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D57F2420B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40c236624edso6502645e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 04:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702643859; x=1703248659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DyIY/skl5L74MJSv/9NoU/GlPAZnZXPoIEkSa4htCY4=;
        b=O7K9SAhsROdrwQaTqnjAtQrdp8glf8tAOfbZ9CC+yrczIPdGX3zc2bC16iucBFVjpX
         ybHLJr4TZu0OROlIXMnZFqrRrX0qNxrq/oycKJQsSLYyvDsWkFqS1bUZrYiiFzF5ztCa
         iKI/l8u+48zdnvYl97RmXteY7aH5pgWXY70HXzTTEAI/Yi5jR34vr7bkiIZ3iQRfyN9l
         PGfyYEXR42So57QHKm++JXAYJ97prWnq5Eqz1m5/zf2wW5alj7F4FWTShzOcCNYDOX8K
         JJBdaVy9DHB0hvVAXbFz+A5VQGZOE+jcpAO4TOYIGx62+jgxRpLfd3TYWiH4+9zpKEv4
         ljBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702643859; x=1703248659;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DyIY/skl5L74MJSv/9NoU/GlPAZnZXPoIEkSa4htCY4=;
        b=oMuYFBfqCrlwdC7d5W5cxyKEPizHfNDm1QJPMOLdw3seGgfsxzAzSjLn1AKwxodlD/
         NyFTU4PN+zGiIThUsUJCk0PoP5iNTSvmtvOAAgqsuhcn77rL988gSgtGaQBOOmWFUmJh
         oTYvds/q28w7WhCTkL/0jPqQbfBhCZZCPkFoNzJ4fNFc41GKfzKYBO4p/Wcx6oR/EJfA
         LoR62il0RXMZUmnxh56lt9iDvq9lZ+QKSVb1gW7csdOIBdrMT0crFps0leNjCH01ddSn
         Iyh15EXHUdNoQbGorsfXJHVeMd+xQkUdiUMG6GzjwYZNabMn2ehdsyZswKDDiWtszYzI
         u5rQ==
X-Gm-Message-State: AOJu0YwodTA718796oZUvYxSAZZ9Aq0IgsZbvpB5SNnvRPOtwuIBNUqQ
	a+ZjG/N2/n188ngzgYg44E8=
X-Google-Smtp-Source: AGHT+IH87EURDXSKMIhGySXqX6m5crZIeykn31q4PU8YH8W46jLvy2nFavcb6YFwsDI0e4r8NCKvwQ==
X-Received: by 2002:a05:600c:45c9:b0:40b:369b:2c53 with SMTP id s9-20020a05600c45c900b0040b369b2c53mr5583664wmo.22.1702643859316;
        Fri, 15 Dec 2023 04:37:39 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id gw18-20020a05600c851200b004053e9276easm31092704wmb.32.2023.12.15.04.37.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 04:37:37 -0800 (PST)
Message-ID: <8bce512e-abb6-495d-85a4-63648229859e@gmail.com>
Date: Fri, 15 Dec 2023 13:37:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: amdgpu didn't start with pci=nocrs parameter, get error "Fatal
 error during GPU init"
Content-Language: en-US
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <CABXGCsMbqw2qzWSCDfp3cNrYVJ1oxLv8Aixfm_Dt91x1cvFX4w@mail.gmail.com>
 <a99e6def-68be-3f2b-4e01-ac26cdb80f49@gmail.com>
 <CABXGCsM7JPxtQm6B7vk+ZcXfphgQm=ArJZKiDUdbk9hujyRtmg@mail.gmail.com>
 <43016018-4d0a-94dc-ce93-b4bff2dce71c@gmail.com>
 <90b1c9f8-1674-e9ec-e6d8-2fa1967439b3@gmail.com>
 <CABXGCsN2NutEmi==JBDD5G2Bj=DJ6vm87_Cbubycz-WowUOh5w@mail.gmail.com>
 <e2975d53-840c-a104-8b2d-c302f502c894@gmail.com>
 <CABXGCsOJkF=c4B+oQm7cuEO7Fr_oknmH2iB6e6OCzmFy=KYtAw@mail.gmail.com>
 <5cbba992-c4ce-01c1-2691-ed65ce66aad5@gmail.com>
 <CABXGCsMBWwRFRA+EJKF0v6BwZ+uTQHr4Yn9E9_iYgZ6KRbwsJQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CABXGCsMBWwRFRA+EJKF0v6BwZ+uTQHr4Yn9E9_iYgZ6KRbwsJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 15.12.23 um 12:45 schrieb Mikhail Gavrilov:
> On Tue, Feb 28, 2023 at 5:43 PM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> The point is it doesn't need to talk to the amdgpu hardware. What it
>> does is that it talks to the good old VGA/VESA emulation and that just
>> happens to be still enabled by the BIOS/GRUB.
>>
>> And that VGA/VESA emulation doesn't need any BAR or whatever to keep the
>> hw running in the state where it was initialized before the kernel
>> started. The kernel just grabs the addresses where it needs to write the
>> display data and keeps going with that.
>>
>> But when a hw specific driver wants to load this is the first thing
>> which gets disabled because we need to load new firmware. And with the
>> BARs disabled this can't be re-enabled without rebooting the system.
>>
>>> My suggestion is that if
>>> amdgpu fails to talk to the hardware, then let another suitable driver
>>> do it. I attached a system log when I apply "pci=nocrs" with
>>> "modprobe.blacklist=amdgpu" for showing that graphics work right in
>>> this case.
>>> To do this, does the Linux module loading mechanism need to be refined?
>> That's actually working as expected. The real problem is that the BIOS
>> on that system is so broken that we can't access the hw correctly.
>>
>> What we could to do is to check the BARs very early on and refuse to
>> load when they are disable. The problem with this approach is that there
>> are systems where it is normal that the BARs are disable until the
>> driver loads and get enabled during the hardware initialization process.
>>
>> What you might want to look into is to find a quirk for the BIOS to
>> properly enable the nvme controller.
>>
> That's interesting. I noticed that now amdgpu could work even with
> parameter [pci=nocrs] on 6.7.0-0.rc4 and higher kernels.
> It means BARs became available?
> I attached here the kerner log and lspci. What's changed?

I have no idea :)

 From the logs I can see that the AMDGPU now has the proper BARs assigned:

[    5.722015] pci 0000:03:00.0: [1002:73df] type 00 class 0x038000
[    5.722051] pci 0000:03:00.0: reg 0x10: [mem 
0xf800000000-0xfbffffffff 64bit pref]
[    5.722081] pci 0000:03:00.0: reg 0x18: [mem 
0xfc00000000-0xfc0fffffff 64bit pref]
[    5.722112] pci 0000:03:00.0: reg 0x24: [mem 0xfca00000-0xfcafffff]
[    5.722134] pci 0000:03:00.0: reg 0x30: [mem 0xfcb00000-0xfcb1ffff pref]
[    5.722368] pci 0000:03:00.0: PME# supported from D1 D2 D3hot D3cold
[    5.722484] pci 0000:03:00.0: 63.008 Gb/s available PCIe bandwidth, 
limited by 8.0 GT/s PCIe x8 link at 0000:00:01.1 (capable of 252.048 
Gb/s with 16.0 GT/s PCIe x16 link)

And with that the driver can work perfectly fine.

Have you updated the BIOS or added/removed some other hardware? Maybe 
somebody added a quirk for your BIOS into the PCIe code or something 
like that.

Regards,
Christian.




