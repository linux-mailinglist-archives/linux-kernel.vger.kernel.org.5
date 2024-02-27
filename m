Return-Path: <linux-kernel+bounces-83830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F32869F00
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C55D31C27D1C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA4C1487D8;
	Tue, 27 Feb 2024 18:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="inzql21T"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E144EB44
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058102; cv=none; b=kl+1BbgGZpBsX+AgzCM7MBApZLL3otEnS9VC2D1Xd9FVbAd+GBivqpjcWijCyX8hyBx84HaN4kbpX/bPkVzpVegg2WYqVkKV9ynULFMovgjp43LtDHqd/00oScGaG7gpNweUt/F5RVPk5oi53RX5xPUGWAKdU3CERURiJNrBDJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058102; c=relaxed/simple;
	bh=biLxMTdT9OJgOskFJf33PboO4Sbv7ilah8MrEyqbJto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8sMEi4IpMTCIKZLlGhZxROhoKVMP8JIwiwNrxFfPKeC86iuK9PrfcVpqBOt0/oxK5bpZVJ8umX8a0wOEt42e2IjugUb0LeJ2iViUKiiM4ACqcZnPITbLBnF85W2FteaFLhYiXOMeW8E9UZ+tPrh4IZzXIqGSybon3JlCHc04jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=inzql21T; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e49812ba77so1449906a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709058100; x=1709662900; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g+hXgGvfIukYiuX7oT5dD0w+P1l7ILZfgg3s4jt5+V8=;
        b=inzql21TxHDE+FCgNV3/hT+U+Bd9OZ5RHjB4p51BDRxF9PmAw2Riuf3oX81R3bcVG4
         LJn6gr9PbfmUXyw3E4z8gT8uZXVbeWBCy8HVIX0020YKZSCuhFF2ZexxvyyQ9tMiFUOf
         mpTeLW/JnxNn4iejZvJ8p0lSTZPI5360ElcF7S9nHhEesuG8O+KZdSg3a1rbiFcmBOHO
         DdjDQI4J3vtsEGbxJuyudWqre1opJNZjJiy+nZNCXAoQIwBBKdkZetd4dBB1uc4v9EZ3
         iYT+/5l2e9R4qrk0rkpro6EEpnL3FBuj9BSyGYwe2+5VR6PoXs7vADLiHC1iCBHP6r6Q
         fegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709058100; x=1709662900;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+hXgGvfIukYiuX7oT5dD0w+P1l7ILZfgg3s4jt5+V8=;
        b=p7dMrkxPw6Hl0QSquzpAuUIfSOpMoNLskOvw3lu2XMdyUhZbViKZCppUyikjsYwe6o
         8h0z5Ar9WOmmZapXScjsjGEBri53tl62Xkoh1w4xe18XA+mAmjzk7zr4hlJkRTziDKqp
         xiQImaOdKNjd65Rqi1oM1dWJJfMzJyosW4BRUbDQBePmOEhHE4Ee8Vxug1CGQNzKTcwM
         zp2j4ovgYUzThAgsPZt/2ziW7TNEhI1+a8EQCuT4veVJh1BHswVq9oNcjXddk3Wid7FJ
         s/6iJ6ZqIOLydUn+EGGi7JSVfMFBXLRhc4tPYJu8nubjScDzuxdBcv8FGpAcgASCjkmu
         V85g==
X-Forwarded-Encrypted: i=1; AJvYcCWPhh8d3EcIjJfA3XYMeh98+YLQs6Tav55CijcjjHNx6E8/J/DsRvqjYDA1j6THm8oFDBcU2oKyBa+OYzZEIvZMC382jl38CSO+15kQ
X-Gm-Message-State: AOJu0YxUgLrY+h1CGhLtUsvIClNZb3ZrluD3kWrGQFJLStiVSwDFQgM0
	nsB8iFgUd3OwraTk7hUvs9+odsnNa6PpMHtzNzEwJfKipKR5Fr+5LHNWtSlvKgc=
X-Google-Smtp-Source: AGHT+IHy19BdiOqGtWa+05trywiGWkBCZLJJtn9eoBSJIKrRk807vnyKQQxY04Gjxamk5BorZ1zOVA==
X-Received: by 2002:a05:6830:11c5:b0:6e4:909a:9848 with SMTP id v5-20020a05683011c500b006e4909a9848mr11283491otq.2.1709058099747;
        Tue, 27 Feb 2024 10:21:39 -0800 (PST)
Received: from ghost ([2600:1010:b010:c64b:16cb:453c:679d:bee6])
        by smtp.gmail.com with ESMTPSA id i23-20020a631317000000b005ce472f2d0fsm6072238pgl.66.2024.02.27.10.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 10:21:39 -0800 (PST)
Date: Tue, 27 Feb 2024 10:21:34 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Guenter Roeck <linux@roeck-us.net>,
	David Laight <David.Laight@aculab.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Helge Deller <deller@gmx.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Parisc List <linux-parisc@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v10] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Message-ID: <Zd4oLnVFJw6Qq0FA@ghost>
References: <ZdzZ5tk459bgUrgz@ghost>
 <ZdzhRntTHApp0doV@shell.armlinux.org.uk>
 <b13b8847977d4cfa99b6a0c9a0fcbbcf@AcuMS.aculab.com>
 <Zd0b8SDT8hrG/0yW@ghost>
 <cdd09f7a-83b2-41ba-a32c-9886dd79c43e@roeck-us.net>
 <9b4ce664-3ddb-4789-9d5d-8824f9089c48@csgroup.eu>
 <Zd25XWTkDPuIjpF8@shell.armlinux.org.uk>
 <c8ddcc98-acb0-4d2d-828a-8dd12e771b5f@csgroup.eu>
 <Zd4h6ZhvLSWfWJG/@ghost>
 <9f756413-806c-4cd0-a6cf-8dd82af14e88@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f756413-806c-4cd0-a6cf-8dd82af14e88@csgroup.eu>

On Tue, Feb 27, 2024 at 06:11:24PM +0000, Christophe Leroy wrote:
> 
> 
> Le 27/02/2024 à 18:54, Charlie Jenkins a écrit :
> > On Tue, Feb 27, 2024 at 11:32:19AM +0000, Christophe Leroy wrote:
> >>
> >>
> >> Le 27/02/2024 à 11:28, Russell King (Oracle) a écrit :
> >>> On Tue, Feb 27, 2024 at 06:47:38AM +0000, Christophe Leroy wrote:
> >>>>
> >>>>
> >>>> Le 27/02/2024 à 00:48, Guenter Roeck a écrit :
> >>>>> On 2/26/24 15:17, Charlie Jenkins wrote:
> >>>>>> On Mon, Feb 26, 2024 at 10:33:56PM +0000, David Laight wrote:
> >>>>>>> ...
> >>>>>>>> I think you misunderstand. "NET_IP_ALIGN offset is what the kernel
> >>>>>>>> defines to be supported" is a gross misinterpretation. It is not
> >>>>>>>> "defined to be supported" at all. It is the _preferred_ alignment
> >>>>>>>> nothing more, nothing less.
> >>>>>>
> >>>>>> This distinction is arbitrary in practice, but I am open to being proven
> >>>>>> wrong if you have data to back up this statement. If the driver chooses
> >>>>>> to not follow this, then the driver might not work. ARM defines the
> >>>>>> NET_IP_ALIGN to be 2 to pad out the header to be on the supported
> >>>>>> alignment. If the driver chooses to pad with one byte instead of 2
> >>>>>> bytes, the driver may fail to work as the CPU may stall after the
> >>>>>> misaligned access.
> >>>>>>
> >>>>>>>
> >>>>>>> I'm sure I've seen code that would realign IP headers to a 4 byte
> >>>>>>> boundary before processing them - but that might not have been in
> >>>>>>> Linux.
> >>>>>>>
> >>>>>>> I'm also sure there are cpu which will fault double length misaligned
> >>>>>>> memory transfers - which might be used to marginally speed up code.
> >>>>>>> Assuming more than 4 byte alignment for the IP header is likely
> >>>>>>> 'wishful thinking'.
> >>>>>>>
> >>>>>>> There is plenty of ethernet hardware that can only write frames
> >>>>>>> to even boundaries and plenty of cpu that fault misaligned accesses.
> >>>>>>> There are even cases of both on the same silicon die.
> >>>>>>>
> >>>>>>> You also pretty much never want a fault handler to fixup misaligned
> >>>>>>> ethernet frames (or really anything else for that matter).
> >>>>>>> It is always going to be better to check in the code itself.
> >>>>>>>
> >>>>>>> x86 has just made people 'sloppy' :-)
> >>>>>>>
> >>>>>>>       David
> >>>>>>>
> >>>>>>> -
> >>>>>>> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes,
> >>>>>>> MK1 1PT, UK
> >>>>>>> Registration No: 1397386 (Wales)
> >>>>>>>
> >>>>>>
> >>>>>> If somebody has a solution they deem to be better, I am happy to change
> >>>>>> this test case. Otherwise, I would appreciate a maintainer resolving
> >>>>>> this discussion and apply this fix.
> >>>>>>
> >>>>> Agreed.
> >>>>>
> >>>>> I do have a couple of patches which add explicit unaligned tests as well as
> >>>>> corner case tests (which are intended to trigger as many carry overflows
> >>>>> as possible). Once I get those working reliably, I'll be happy to submit
> >>>>> them as additional tests.
> >>>>>
> >>>>
> >>>> The functions definitely have to work at least with and without VLAN,
> >>>> which means the alignment cannot be greater than 4 bytes. That's also
> >>>> the outcome of the discussion.
> >>>
> >>> Thanks for completely ignoring what I've said. No. The alignment ends up
> >>> being commonly 2 bytes.
> >>>
> >>> As I've said several times, network drivers do _not_ have to respect
> >>> NET_IP_ALIGN. There are 32-bit ARM drivers which have a DMA engine in
> >>> them which can only DMA to a 32-bit aligned address. This means that
> >>> the start of the ethernet header is placed at a 32-bit aligned address
> >>> making the IP header misaligned to 32-bit.
> >>>
> >>> I don't see what is so difficult to understand about this... but it
> >>> seems that my comments on this are being ignored time and time again,
> >>> and I can only think that those who are ignoring my comments have
> >>> some alterior motive here.
> >>>
> >>
> >> I'm sorry for this misunderstanding. I'm not ignoring what you said at
> >> all. I understood that ARM is able to handle unaligned accesses with
> >> some exception handlers at worst case and that DMA constraints may lead
> >> to the IP header beeing on a 2 bytes alignment only.
> >>
> >> However I also understood from others that some architectures can't
> >> handle such a 2 bytes only alignments.
> >>
> >> It's been suggested during the discussion that alignment tests should be
> >> added later in a follow-up patch. So for the time being I'm trying to
> >> find a compromise and get the existing tests working on all platforms
> >> but with a smaller alignment than the 16-bytes alignment brought by
> >> Charlie's v10 patch. And a 4 bytes alignment seemed to me to be a good
> >> compromise for this fix. The idea is also to make the fix as minimal as
> >> possible, unlike Charlie's patch that is churning up the tests quite
> >> heavily.
> > 
> > Do you have a list of platforms this is failing on? I haven't seen any
> > reports that haven't been fixed.
> 
> I don't have such a list, but I guess you do ? If all platforms have 
> already been fixed, why are you sending this patch at all ?

This patch is what is doing the "fixing". Over the course of 10 versions
I have "fixed" the test cases to work on platforms that have various
alignment and endianness constraints. The endianness changes were picked
off of these patches and spun out into a different patch by you. 

I originally introduced these two new test cases since I wrote the riscv
checksum function implementations and these tests were helpful for me
and I figured they may be helpful for somebody else too.

- Charlie

> 
> Christophe

