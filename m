Return-Path: <linux-kernel+bounces-76437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA3285F758
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 157D9B217B1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDD645010;
	Thu, 22 Feb 2024 11:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5blD3Xn"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9652405D4;
	Thu, 22 Feb 2024 11:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601894; cv=none; b=Alob+qW5OqlUrAQazicF3CEvnz2jjdIVuesV4++1UMkVUuzE5KLj39YMKOfx0t8U2koXf7RzTplYKoCPnW3XYyw5D8mcyWnGh52eeUW1vL81atODfzKFL0qm4EeQbYKITMhVZ3R14TZXkgX4RaLqyX8/MlXxgslGO56K7dhnHDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601894; c=relaxed/simple;
	bh=uLn85H6BfgHQmu6Lkpo3kyKem1I/giGYKE2Jvsin2kE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L/+mylnlzxMiwq3ZAoUHMX5EYJKDHuyH0CMWCYIt7OxF8uEZsVYS38ar54j1TeBpbUn+4hEfuUfWGbJvTLBRHSwCQgNVbyPw39f/jJZa8MD8tABbCAUyGgM/H68aa9ZNlCZH7uc3meW9By90wjG/X7py4GmOPxoLdA05FiJlOGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5blD3Xn; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3f1bf03722so312542866b.1;
        Thu, 22 Feb 2024 03:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708601891; x=1709206691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4j+GQLy+4UDOE+jrUoWuh2+LJUqbegRz7zLOxtcxl8=;
        b=X5blD3Xn2I+EZIPUm6KESusfJPhoSxmPmKxPUeD7theFuaH5rTWm/LIimtMUhh1Kph
         ZNpxxoTvisdMXhRRsJ3B+IFFnc+irQyn5BJzQebNXEclRoKIueR5Bu/uU83mf0TP+ACH
         EGtLigphJE+ohIitf5Zzio22QLDsZevD+W6LBwWRbO/kAMwSjkxLysEWPgPAbcl4pzz8
         gKx1CUvvkhc/e03THjrzS4UdnxSsELW2OvfmUEGoouxd6UoVOsUZ7H76pWXwgaji6FAL
         G2B1Wc+oDqfpseFmSY1h8moBB4zIGDAU8OApd4BRm2473ykSYIRA16Ep/VaJylcyHG6I
         8D+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708601891; x=1709206691;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4j+GQLy+4UDOE+jrUoWuh2+LJUqbegRz7zLOxtcxl8=;
        b=W6U6QxJaTkRBV5NZ2sasbwabw9DGm7sdDakpT7lX9YQtqjLJa3N4USHbA/SzjsDWgg
         IU1HSemqumJ7Uly6Ua2+o7uDROun1R10TNMyeMCft1ZPy8oRd26ipfs92D3UI9vyK/E/
         NNshiA+VLCe+EQn8APN5vjIWt30OrePRac/lbVcUPTKrG+l3B6O3FfXbCJroGnOApYXV
         ZU3gjcH7CRv+CN8XkUoV0bIWUdwrN8IDc8qharcFGFFHD0npopsWxKVrIDFeVlTJLBWN
         U+tDQDqCz0RlhPIg71AVKMUtdLVm1hPnfx2lf2B0rTObSjRSdTY6jr3LtYZEmKFNvnOu
         Q3ZA==
X-Forwarded-Encrypted: i=1; AJvYcCV0gMoHJ6Q4ZP8kuXUTKLeY+UZnKKmoe1BBKKsdJ9H2NJ/iKV/gy6UoQnTZbUJDaqajc6NgfZ73jXhvRWUFqEV+ItIUOSd0BVC4CbLP0SIR9OGkpP8W/WDqJN0+jaeM6vrK8jUZ8jyvESfo4dcgEbnBel0LPQBjZC+2N2wxab4bw8/mAvJd
X-Gm-Message-State: AOJu0YxozFAs+jJ6rjBR8MNJsWFHVQHA6GnkiCChS8iWvyJq+ffJqgrm
	aEcyk0vMnKiywNq8carwRt2eb8EZY+VBXxuGlNJQfv4uJu2z7CSR
X-Google-Smtp-Source: AGHT+IGCbUbNF+tds+NYR3EhGNyKrbLXM2++L+ZotTeZEEO+/PmKKaikbMzR162S8tSZ1WWrGUPaIA==
X-Received: by 2002:a17:906:3559:b0:a3f:a562:ded2 with SMTP id s25-20020a170906355900b00a3fa562ded2mr96896eja.73.1708601890657;
        Thu, 22 Feb 2024 03:38:10 -0800 (PST)
Received: from [100.125.116.68] ([213.55.188.37])
        by smtp.googlemail.com with ESMTPSA id wb1-20020a170907d50100b00a3ec215f130sm3435903ejc.103.2024.02.22.03.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 03:38:09 -0800 (PST)
Message-ID: <a21f6c49-2c05-4496-965c-a7524ed38634@gmail.com>
Date: Thu, 22 Feb 2024 12:38:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Future handling of complex RGB devices on Linux v2
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Lee Jones <lee@kernel.org>, jikos@kernel.org,
 linux-kernel@vger.kernel.org, Jelle van der Waa <jelle@vdwaa.nl>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 linux-input@vger.kernel.org, ojeda@kernel.org, linux-leds@vger.kernel.org,
 Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>
References: <0cdb78b1-7763-4bb6-9582-d70577781e61@tuxedocomputers.com>
 <7228f2c6-fbdd-4e19-b703-103b8535d77d@redhat.com>
 <730bead8-6e1d-4d21-90d2-4ee73155887a@tuxedocomputers.com>
 <952409e1-2f0e-4d7a-a7a9-3b78f2eafec7@redhat.com>
 <9851a06d-956e-4b57-be63-e10ff1fce8b4@tuxedocomputers.com>
 <1bc6d6f0-a13d-4148-80cb-9c13dec7ed32@redhat.com>
 <b70b2ea8-abfd-4d41-b336-3e34e5bdb8c6@tuxedocomputers.com>
 <477d30ee-247e-47e6-bc74-515fd87fdc13@redhat.com>
 <e21a7d87-3059-4a51-af04-1062dac977d2@tuxedocomputers.com>
 <247b5dcd-fda8-45a7-9896-eabc46568281@tuxedocomputers.com>
 <ZdZ2kMASawJ9wdZj@duo.ucw.cz>
 <b6d79727-ae94-44b1-aa88-069416435c14@redhat.com>
Content-Language: en-US, de-CH, fr-CH
From: Gregor Riepl <onitake@gmail.com>
Autocrypt: addr=onitake@gmail.com; keydata=
 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
 DMcsQA==
In-Reply-To: <b6d79727-ae94-44b1-aa88-069416435c14@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> This certainly is the most KISS approach. This proposal
> in essence is just an arbitrary command multiplexer /
> demultiplexer and ioctls already are exactly that.
> 
> With the added advantage of being able to directly use
> pass the vendor-cmd-specific struct to the ioctl instead
> of having to first embed it in some other struct.

There's also the question of how much complexity needs to remain in the 
kernel, if vendor-specific ioctls are made available.

Does every vendor driver implement a complex mapping to hardware 
registers? What about drivers that basically implement no mapping at all 
and simply forward all data to the hardware without any checking? The 
latter case would match Pavel's concerns, although I don't see how this 
is any different from the situation today, where userspace talks 
directly to the hardware via libusb etc.

To be honest, I think the kernel shouldn't include too much high-level 
complexity. If there is a desire to implement a generic display device 
on top of the RGB device, this should be a configurable service running 
in user space. The kernel should provide an interface to expose this 
emulated display as a "real" display to applications - unless this can 
also be done entirely in user space in a generic way.

