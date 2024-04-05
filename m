Return-Path: <linux-kernel+bounces-133472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 669C389A43D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 213FA284424
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C9617278F;
	Fri,  5 Apr 2024 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CV2Q/Y5K"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56E3171640
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 18:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712342197; cv=none; b=Px0uK2H6ow3uIppRxXPkvrv6o6CO2ITdYSM2nYH4y93+RJdlt0z1Ly9xKo8H2WUwtnfdIOjySJxdo18UYy2OEIZZiSZ+dNN2DRYK9rd6bQxiA4roseLVSwRFLzIHQRpCTz1weitz6ZmC69SYyLRp5OwzbMwYnwbI0Q+iGZERE5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712342197; c=relaxed/simple;
	bh=8gvjGMkKW7jL8578d1YpBLUgBk6nMTdbMF3USz8QBVs=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=P+nceq2mAiuKQS4liD1BD+vSjWi8qdrqitz3FkJMsTdpeVqZ5z1N9nZqlWMp7YQelsTl0JGvMSfRfLsMe1Y0wA0XpgYbM0t4Fp7NVtFns6XJx0KjPXCRCVZ1huYUDvSPznuzTRZ/kXJ15GJwT0eE2TRfIoVvzUuqXgVFrWuwkVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CV2Q/Y5K; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e3c9300c65so6715575ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 11:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712342194; x=1712946994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYwm+/heEjBobI2C1/8dBjrC19orKej+qKNwaThEwgY=;
        b=CV2Q/Y5KVBW63rTyOO3YRldajY6WgauegLh6kwQRVqjuL4bC2n9wYDtZKo5dn1vdxL
         8Wsf0I9k6KRjDtf1iQLFCtDo/x7SziGcAypuuo+/RPkUCARWZ9Gn4HPw4b5wTh4HRTRL
         u5KB1uTQfy7BA3pQdSqr533suoQcgY659vvdF0w9+Ve81aQsxaB3atNkmurZBks88gTp
         4DPGDiy0g4Vp+eHqhNyW2qsqmYAvDLsd8XftkeUumgFd+k8HUviaf1h682JeD8WoyXVW
         m413kk4v5kMDLv3cGLTinj7rXr1aV0vY5GDRdleoj4dhjQfWM0lEx9W5ak0JJwSl5Zfk
         fMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712342194; x=1712946994;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cYwm+/heEjBobI2C1/8dBjrC19orKej+qKNwaThEwgY=;
        b=LwOEaK4xAVLN1HwPHDlm+lMKPAcxMEJONnpcVnSZaiOhbSGS7hDwjHcXiq/SNX9U8J
         1eIvq9pEB+x7CiLetdrnC++TCOTv1R8WSZlmCoB+ipFcJkuQHPkugabX9vgwhnB28JvX
         TNWagWuKH6gyokmvd/bss3U9kq3MD+NQ/DoUEednfWeidv+c1GcMOciLcIGzrK6xOJW9
         j3CxsCtqzvr60HiWa2nWk81pbHo3QVEazMpoEY3RX2ogvtL7MAz1sHkh1sjyGLc6cV98
         F46cnUH9r91/z5+1v268rxUUN4FI4c72u3WQDCSMCVxmRAWdQE2Ud0/bOECxkUQqJ5Dy
         7BFA==
X-Forwarded-Encrypted: i=1; AJvYcCWc5j/ptUUTeyQQn8MzBr1jqR/3dho2W0YkNnvX7ilp6yqaD+Du4rwEbMrnEx7Ea58YFH6vAtU3hD18kT2aEVWb1ojRJDsrErDmcL8u
X-Gm-Message-State: AOJu0Yw/nPWAGpmFTRJp9ejpD/E/O/P2/8n80NBfMTtJ83J1o7vSS4UZ
	o9rhu/TXFRYZUuS1AD2AzP7pQ0cdneS3+UjpphisWOY6WpyINjxoX6z2g49T
X-Google-Smtp-Source: AGHT+IH1asEwBguA0fEhDIITjnTIlpieh0IXeZVXpZy1/jO0JTKJ2hGsYzLlZIY66T4GAqZK8y0xaw==
X-Received: by 2002:a17:902:da87:b0:1e2:a31e:5e12 with SMTP id j7-20020a170902da8700b001e2a31e5e12mr2431854plx.3.1712342193933;
        Fri, 05 Apr 2024 11:36:33 -0700 (PDT)
Received: from [10.1.1.24] (222-152-175-63-fibre.sparkbb.co.nz. [222.152.175.63])
        by smtp.gmail.com with ESMTPSA id b2-20020a170903228200b001ddd6ba8113sm1907340plh.207.2024.04.05.11.36.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2024 11:36:33 -0700 (PDT)
Subject: Re: [PATCH 0/1] m68k: Handle HAS_IOPORT dependencies
To: Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@kernel.org>
References: <20240403122851.38808-1-schnelle@linux.ibm.com>
 <dd55afa6-8cb6-4e25-b720-d2df62dbb5e6@gmail.com>
 <bf276f98-2712-4fcf-a119-f984a1aedbf2@app.fastmail.com>
 <CAMuHMdX+M1VuhDVnC9n4hCBDjHywwsByNK1w8ibazc+-8_C53A@mail.gmail.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
 linux-m68k@lists.linux-m68k.org, Heiko Carstens <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <d9bdfa48-572a-caa1-229b-44565690d9e6@gmail.com>
Date: Sat, 6 Apr 2024 07:36:26 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMuHMdX+M1VuhDVnC9n4hCBDjHywwsByNK1w8ibazc+-8_C53A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Geert,

Am 05.04.2024 um 23:16 schrieb Geert Uytterhoeven:
> Hi Arnd,
>
> On Wed, Apr 3, 2024 at 8:35 PM Arnd Bergmann <arnd@kernel.org> wrote:
>> On Wed, Apr 3, 2024, at 20:11, Michael Schmitz wrote:
>>> how do you propose we handle legacy drivers that do depend on
>>> inb()/outb() functions (_not_ actual ISA I/O) on architectures that map
>>> inb()/outb() to MMIO functions?
>>>
>>> (In my case, that's at least ne.c - Geert ought to have a better
>>> overview what else does use inb()/outb() on m68k)
>>
>> If a machine provides an inb()/outb() set of operations that
>> is actually used, it should set HAS_IOPORT.
>>
>> For the Q40, it may be better in the long run to change the
>> drivers to just use MMIO directly though.
>
> Q40 uses ISA.
>
> Michael is worried about non-ISA drivers using inb() and friends.
> At some point in time (i.e. eons ago), we were told it was better to
> use in[bwl]()/read[bwl]() instead of directly dereferencing volatile
> pointers...
>
> Anyway, I don't think we have many users of inb() and friends left, and
> I assume the bots should have detected any/most remaining users in Niklas'
> branch...

All the 8390 based ethernet drivers still use inb() and friends.

That is the main reason for the terrible hacks in 
arch/m68k/include/asm/io_mm.h ...

The last time I tried to add support for a different PCMCIA ethernet 
adapter to apne.c _without_ adding to the hacks in io_mm.h, I wasn't 
getting anywhere with the netdev crowd. That was ages ago, and I doubt 
their enthusiasm for a rewrite of the 8390 code base to avoid using 
inb() on MMIO architectures will be any better now.

Just saying ...

	Michael

>
> arch/m68k/include/asm/floppy.h on Sun-3x might be the only offender?
>
> Gr{oetje,eeting}s,
>
>                         Geert
>

