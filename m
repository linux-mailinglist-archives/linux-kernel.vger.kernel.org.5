Return-Path: <linux-kernel+bounces-66267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E4A855983
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 04:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D4DDB22E36
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 03:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCEA6FAF;
	Thu, 15 Feb 2024 03:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nmlAqTfy"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6207D8F54
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 03:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707968131; cv=none; b=pz59XkOrF8ahcgBQUE0ZfOm7NR7OKKebOIwZziGROy/uylKmZwS5yjkEyTQgu/kakE3RX4O79Kdnp40uO5t+/peh0LUH7wiY6rdb+YVIMP4Zs/CMSzX1q9tV6wIeLVxwnHg+tkEcKy/vCRjJRluePfIbQ4fCeFDfC0dK+cHpz3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707968131; c=relaxed/simple;
	bh=2VRfDeGj9QX+p60IGHUb2WepMUIsAHtB/NN6H6PdFCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcAuYjzMGoFzn2jJmh8NuiwCiaDLpdhWDeIiWa/tqcEvGQHQRW5kkhFrAZ9F2mqUKnTHW8FyUTQN7zK2fszTiPBhwQ2KProtiKeRciOOaKVthfo3rE/pngxUKDQXqyZ89Ra2fLeGZo2LZxoSFtF46sL3fESReh5wPj1vEBUivrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nmlAqTfy; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-607a84acf6aso4227597b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 19:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707968128; x=1708572928; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m8wQXJAM9XnTHVeo8Rqcy8iOf7NhZOYjhSVUmkxrvms=;
        b=nmlAqTfy3Glk04dAMnXmVIwnmRKoOX7n/IfRjJlXT8o/lEI1PgZ9pGXvaNxYCtOgR0
         9t6W4JhCX346P2zsDQ2mB9GaI3WO9APDzDUO7nohHMBAY496/kgFgz7c+ZTVI8WLz2z0
         hxbxSbl/FzPnChqle+cMbUZu7vEFN8+o7bqGCkpbEKw7ckpBBmtv2PH4zpxa3qZnwsUJ
         UimkDPhf8qieV7heIWOGV5gAlOlKvKvPGMrvuHvP7W+W//JL1hPEzHdgTe9Ej7p6bNHP
         0I5Jrm2NZLdTU+WWGAJuLaH6CTqYg58+rph4FMWfT/CGtz/Rn2xbYe6Es/eJbtacCgLP
         0SRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707968128; x=1708572928;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m8wQXJAM9XnTHVeo8Rqcy8iOf7NhZOYjhSVUmkxrvms=;
        b=qeHDdG434F/buxPgt9t1dS0/hT1D6dRy3nsGoFFgiIb30yCtZcBWBgIMJYLp95C48M
         Mj2i7v+2GP5OU5VoXRtnOGDcn/wFX4RNW9MgGtKpP8qVr82PkJjX79Q9MDxspLXqDtTC
         OCRNhA2PndHMIKsrUsstXLUzTdasNJdqi7r7CVsH0UcD7XUY6z5/hlt614F/9tAohvWK
         pD2Q0Ta9YucvlnNaSDNwOiAGRpkkQi8Y5zk4DY2vmug/ovMmWIBKcFwo1za34QN7F6GC
         ARBe3h7aABmEpcL3E8NNpaV/VJFCPLcwUUv4flISfmzFD43/q1pDEIfB3db0W1JjrLhv
         nbUw==
X-Forwarded-Encrypted: i=1; AJvYcCWznm9AyMMJ1Ts3LigGqjaHFwnthMgrgoWcUnZ8YEV/7Np1kJlsMk0oCy1VFgHxTZ7hSj8UwrBhoCA8Amqdze1BspZIXcAB5x8RRxwP
X-Gm-Message-State: AOJu0YwHq0UoCzccoDgfBwjszwapuy3UufI2CFu3tHttqc+uAv68yngp
	dXjwNYPzXa97LbXpRIu5fbtnFBB3dCao2iFAU5l+ljZZe/RkLqrH87ve+fRd7ew=
X-Google-Smtp-Source: AGHT+IHjbNDOLp0PXlZ38bHzp15ncPSnBtpypLDcWOkud78J5qjwbRqC3yOh+JxdNSqLZEnkSX0dvA==
X-Received: by 2002:a0d:d711:0:b0:607:ad1a:bc63 with SMTP id z17-20020a0dd711000000b00607ad1abc63mr557742ywd.49.1707968128208;
        Wed, 14 Feb 2024 19:35:28 -0800 (PST)
Received: from ghost ([50.146.0.2])
        by smtp.gmail.com with ESMTPSA id m4-20020a819e04000000b006040e81906bsm83187ywj.132.2024.02.14.19.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 19:35:27 -0800 (PST)
Date: Wed, 14 Feb 2024 22:35:26 -0500
From: Charlie Jenkins <charlie@rivosinc.com>
To: John David Anglin <dave.anglin@bell.net>
Cc: Guenter Roeck <linux@roeck-us.net>,
	David Laight <David.Laight@aculab.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Helge Deller <deller@gmx.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Parisc List <linux-parisc@vger.kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Message-ID: <Zc2GfgiCpevtKTtS@ghost>
References: <20240214-fix_sparse_errors_checksum_tests-v8-0-36b60e673593@rivosinc.com>
 <20240214-fix_sparse_errors_checksum_tests-v8-2-36b60e673593@rivosinc.com>
 <2ec91b11-23c7-4beb-8cef-c68367c8f029@roeck-us.net>
 <Zc1pSi59aDOnqz++@ghost>
 <cb4e358b-3fd0-4ca4-bf53-9cc379087304@roeck-us.net>
 <1d5e059e-5b31-415d-ae41-593415812e94@bell.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d5e059e-5b31-415d-ae41-593415812e94@bell.net>

On Wed, Feb 14, 2024 at 10:00:37PM -0500, John David Anglin wrote:
> On 2024-02-14 8:58 p.m., Guenter Roeck wrote:
> > Specifically: Yes, the carry/borrow bits should be restored. Question is
> > if the Linux kernel's interrupt handler doesn't restore the carry bits
> > or if the problem is on the qemu side.
> The carry/borrow bits in the PSW should be saved and restored by the save_specials
> and rest_specials macros.  They are defined in arch/parisc/include/asm/assembly.h.

Why would they be needed to be restored in linux? The manual says "The
PSW is set to the contents of the IPSW by the RETURN FROM INTERRUPTION
instruction". This means that the PSW must be restored by the hardware.

We can see the QEMU implementation in:

rfi:
https://github.com/qemu/qemu/blob/v8.2.1/target/hppa/sys_helper.c#L93

handling interrupt:
https://github.com/qemu/qemu/blob/v8.2.1/target/hppa/int_helper.c#L109

However the implementation appears to be faulty. During an RFI, the PSW
is always set to 0x804000e (regardless of what the PSW was before the
interrupt).

- Charlie


> 
> However, it appears the tophys macro might clobber the carry bits before they
> are saved in intr_save.
> 
> Dave
> 
> -- 
> John David Anglin  dave.anglin@bell.net
> 

