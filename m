Return-Path: <linux-kernel+bounces-134068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F9689ACCB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 22:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A80EAB21CC4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 20:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B174DA19;
	Sat,  6 Apr 2024 20:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cr0RneQ7"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51CA4D121
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 20:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712434164; cv=none; b=Fug7LCCZFqBg6VnAhSZQkco0Ryf1iksbmucaTlp9+b4tYPihXUkICMEGGRZlOnkGnTM4bE5nNBHYhuigijNbylcXI0RapY4LsxKI3xmbrY0YIsqQROy23hQ7fb3kD3kHpLPCWMLOSow42l+XX+jDbLLVhXMQaf8Arzg6kEzED5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712434164; c=relaxed/simple;
	bh=+eGhAmVNjYP+BGhmn9LtXGn9mgFA5mVodVgsHDOQ9qE=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=bbDP40w88NYoapEHDFwowx4GPHENdqxaXFLlKGCmg/kcw0BL/eLDWvglUCfSntTzWaIc8WBaedz6QOd5a83ruS6DwedH70Pt6QEHwYdYBKWgOd0qJhemSDCQ8g+pMGrxsonSqeA35vQkmGkNGRMh9kTwVRXz4BBIbQx9iUazGWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cr0RneQ7; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ecff9df447so1931192b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 13:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712434161; x=1713038961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zNZdTVHx+rO/cm3/LvLdMZLR8N5IsbOvytmrwfgnTI=;
        b=Cr0RneQ7bbfHOdAgH6iT0qHLlNZiIXkL+I9SXian+ffLTQsz8Q+RLWbJf8cJB2zyBV
         D3vbiSK+2sBid5wKqQU/BNKNa8wnUF7JBhgo8uc50bsXXgMUMGgAL5c4bpidHTDlCYp0
         k39PqpaDU4wjwbKqjpNmgZE0NwpuGrKm7OJ5sTzKa6SQevPhLxOgwaNxMu0qkh9QwGq0
         frpTiPXonEZOo0Vfg5PGS1+RVZkS1/y7J6JxJiRlMl4fDAHqbzU2tYc9ZFXcW2wrGKT5
         EsGPSlqMdksQrk2b4w7kyxaCUAW3/T5aKFn8Dn3mtxWbO1XAPX1tW006k8mqMDVBIpIv
         aCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712434161; x=1713038961;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4zNZdTVHx+rO/cm3/LvLdMZLR8N5IsbOvytmrwfgnTI=;
        b=AZij4narMd0fhb7uNlIr25OyE8G3oAQAxVA4apV2Y/O7Q2WXDBSYJCEsV5NkMz0pfc
         1meFTmEvaKAy3f6V2k09ypTQdJr/2Lph0PnEhPdMcbd2ub9o/MvsvbXMSLGDGaUvd4WT
         WOaLJnb18ahA3ebA3O9IFv42xIcZQb5sfhMXYt9NPPeVB8Y7rPdULpOkQoatqpOi39Em
         Z/sD8KMs0PInbREEWdfO8OwTHz7dX/yzOraBVOAeCs+z6yCr4zoXdSVUhdPqgnOAuHy3
         u0kArh5A9PM1Rb/63+klwPjlcU8+aM4UECSIy1z90lEPiZwG/J/GIkNjTmUXhjQLh8/T
         6sTw==
X-Forwarded-Encrypted: i=1; AJvYcCX3D/JCsouxJSB53XmuZuY/ot/+sU+uGWrMLacSK042UVBvUMtTse7fGYeZzUXtB5GiOQVZ4ssKAd7Q8zLce515kOsxRDubwjKxWwih
X-Gm-Message-State: AOJu0YyyiXJiLGx4KRR8WvR1zNoii/0u4TFzcOysH/CqaOwKGlyOtOGB
	JhblEqTQTqmxhxSgyZ58gkT46pcDJXmYATj52YV/Vzu+d2NysXkj3M/LLsVe
X-Google-Smtp-Source: AGHT+IFJI2VDI5QZhUxvvKZLvGwLobeiB9lZx/HTxFp1occQr+BSt8D+Vk9BY00fr/GREsjQDaR+9w==
X-Received: by 2002:a05:6a20:12d4:b0:1a3:645a:129 with SMTP id v20-20020a056a2012d400b001a3645a0129mr6378023pzg.7.1712434161298;
        Sat, 06 Apr 2024 13:09:21 -0700 (PDT)
Received: from [10.1.1.24] (222-152-175-63-fibre.sparkbb.co.nz. [222.152.175.63])
        by smtp.gmail.com with ESMTPSA id d23-20020aa78697000000b006ecec1f4b08sm3582203pfo.118.2024.04.06.13.09.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2024 13:09:20 -0700 (PDT)
Subject: Re: [PATCH 0/1] m68k: Handle HAS_IOPORT dependencies
To: Arnd Bergmann <arnd@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
References: <20240403122851.38808-1-schnelle@linux.ibm.com>
 <dd55afa6-8cb6-4e25-b720-d2df62dbb5e6@gmail.com>
 <bf276f98-2712-4fcf-a119-f984a1aedbf2@app.fastmail.com>
 <CAMuHMdX+M1VuhDVnC9n4hCBDjHywwsByNK1w8ibazc+-8_C53A@mail.gmail.com>
 <d9bdfa48-572a-caa1-229b-44565690d9e6@gmail.com>
 <6b308ab0-dda7-4052-98b3-cb03e17e3e12@app.fastmail.com>
 <ff54515f-3fc1-8f5f-8a15-d4ebbeb2035b@gmail.com>
 <a5bca6fc-1720-45cf-8cf3-3f129e699d79@app.fastmail.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
 linux-m68k@lists.linux-m68k.org, Heiko Carstens <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <d70568b7-121b-886f-f6d7-ef6e5db2ca50@gmail.com>
Date: Sun, 7 Apr 2024 08:09:10 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a5bca6fc-1720-45cf-8cf3-3f129e699d79@app.fastmail.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Arnd,

Am 07.04.2024 um 03:27 schrieb Arnd Bergmann:
> On Sat, Apr 6, 2024, at 03:14, Michael Schmitz wrote:
>> Am 06.04.2024 um 09:13 schrieb Arnd Bergmann:
>>> On Fri, Apr 5, 2024, at 20:36, Michael Schmitz wrote:
>>>> Am 05.04.2024 um 23:16 schrieb Geert Uytterhoeven:
>>>> The last time I tried to add support for a different PCMCIA ethernet
>>>> adapter to apne.c _without_ adding to the hacks in io_mm.h, I wasn't
>>>> getting anywhere with the netdev crowd. That was ages ago, and I doubt
>>>> their enthusiasm for a rewrite of the 8390 code base to avoid using
>>>> inb() on MMIO architectures will be any better now.
>>>
>>> From what I can see, there is already an abstraction layer in
>>> these drivers that is used by all m68k drivers except apne:
>>
>> As well as ne ... which uses the 8390p.c helper.
>
> Is there any machine using ne.c that doesn't set HAS_IOPORT though?
> Q40 and ATARI_ETHERNEC both have custom inb()/outb(), so
> those are not affected by the change.

Thanks for clarifying - I had been left with the impression that 
inb()/outb() would only be retained for architectures that have not only 
the ISA bus but inb/outb processor instructions.

>> ne.c needs the same treatment as far as I can see, and I could actually
>> test that one (on Atari, not actually on a PC ISA card). I'll see what I
>> can come up with.
>
> ATARI_ROM_ISA turns on HAS_IOPORT, so this one doesn't need any
> immediate changes as a result of Niklas's series. I see now that
> the apne driver doesn't actually need changes either since
> AMIGA_PCMCIA turns on ISA.

Your patch would not actually be too hard to get right as apne only 
needs unconditional address translation (unless we want to take this 
opportunity to introduce 100 Mbit support; I need to dig out my old 
patches for that). But perhaps leave that for later

> I don't think there is an easy way to rework ne.c to avoid
> inb()/outb(), but you could consider splitting the atari
> support out into a separate module the same way as apne.c
> to make it use the atari operations directly.

We used to have atari_ethernec.c for that. AFAIR the netdev maintainers 
asked for us to use ne.c instead. They had suggestions around making IO 
abstractions more flexible for apne.c a while back. I need to revisit that.

>> I might well be missing something else here - as I said, it's been a few
>> years since I worked on the apne driver, and experimented with IO
>> abstractions in that context. The problem has always been making sure
>> drivers shared by different m68k platforms need only be built once and
>> still work on e.g. Q40 and Atari.
>
> Do you know of any other ISA style drivers that are used with the
> amiga pcmcia or the atari rom I/O operations, aside from the 8390
> family? If this is the only one using it, it does sound like this
> could be simplified a lot by just making those two not share the
> object code with the ISA-style ne.c.

No network drivers that I can remember, but the same ROM I/O is used by 
the isp116x-hcd USB driver. That one uses the defines from asm/raw_io.h 
directly though, not inb()/outb().

I don't think any other PCMCIA cards were ever supported on Amiga.

Cheers,

	Michael

>
>       Arnd
>

