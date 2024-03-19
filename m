Return-Path: <linux-kernel+bounces-108185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312C8880737
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 910EB2819A2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A25A5FBA4;
	Tue, 19 Mar 2024 22:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="gFiTuutF";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="sGyI9Shg"
Received: from mailrelay2-1.pub.mailoutpod2-cph3.one.com (mailrelay2-1.pub.mailoutpod2-cph3.one.com [46.30.211.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5830059B77
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 22:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710886651; cv=none; b=AGUNuHroKh17HL7R1XM8GeBFV7nzKrRcwEK2+oL4zj8LnzmbkNyVEHQaJahaal+SlxMs/igTrTJaWsJd6JcAf8UGqULUJnVbnqbPq9jigs8YaJQGk8MJloLyzp8zCpslNjD9jPf22lQlV7iJfj1KW8KfoiA27zEoZvjgMZuTWk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710886651; c=relaxed/simple;
	bh=Cu6YYeq/2XeoSQ689tlnEMX24gA8Vo52A8XVPrbfWew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhmayOFEukV4cK5Rs8szUO3ruUn/X8++kvideKbAc6BOMfBXKoOuVTT/XPo0ajg4IQmA8t3vRCjccy3OZ7R18FfEmY3j5awICB1zNVQmaFspiLX7IUimNN8QT8aZTOuFJylwJMVe+aVF428HLnxOIb4rTGn3/55zNH3YS4jiPZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=gFiTuutF; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=sGyI9Shg; arc=none smtp.client-ip=46.30.211.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=2FvB7B4OmmOJN0vg9gCAXa7QKYXongHRRCXDXkAKEOQ=;
	b=gFiTuutFnmDe76dVyDDi9Ov4M9j/iuGhawez/R4SqW9SxATUbf5z0yk3MJNAXWmuzMVaQBlOTZNSR
	 WDlEcv3rsmPD12q7Rg6jeSe6HOH1zvpMxuiR2OHPm5kwnbBZHrnXoddQ+zpsjYJQsKnT3lGBUNSN9Z
	 QAJa46ykhtWMez/vETZ2eniB6aApdGMwepB7lhx5mJBR6dOBaFXP/PiZZSynR3rMxvkq6JXBfPLck8
	 iKF/RK4aLytUxIl/zgWFWviiSi4YjqNYUmWOhBmvc8Mgg2I/U5VRsyZIVzw48yCMsHlQ70Hi8aYDgY
	 01ag0khMWi+htjuyTmAAsVvbzV6EkTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=2FvB7B4OmmOJN0vg9gCAXa7QKYXongHRRCXDXkAKEOQ=;
	b=sGyI9ShgAdpuzllQOIi+YqSHtlQIhem6BUJEe9VZYbZ2nt7whROncfJovtB+DTsNQA/TrmweoNEsG
	 Rs6oViyDg==
X-HalOne-ID: 4d1aed18-e63e-11ee-b023-b520e3c7e1da
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay2.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 4d1aed18-e63e-11ee-b023-b520e3c7e1da;
	Tue, 19 Mar 2024 22:16:16 +0000 (UTC)
Date: Tue, 19 Mar 2024 23:16:15 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Koakuma <koachan@protonmail.com>
Cc: "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"ndesaulniers@google.com" <ndesaulniers@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [sparc] Use of -fcall-used-* flags in Makefile?
Message-ID: <20240319221615.GA379167@ravnborg.org>
References: <JAYB7uS-EdLABTR4iWZdtFOVa5MvlKosIrD_cKTzgeozCOGRM7lhxeLigFB1g3exX445I_W5VKB-tAzl2_G1zCVJRQjp67ODfsSqiZWOZ9o=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <JAYB7uS-EdLABTR4iWZdtFOVa5MvlKosIrD_cKTzgeozCOGRM7lhxeLigFB1g3exX445I_W5VKB-tAzl2_G1zCVJRQjp67ODfsSqiZWOZ9o=@protonmail.com>

Hi Koakuma,

On Sat, Mar 16, 2024 at 02:59:42PM +0000, Koakuma wrote:
> Hello, first time poster so apologies if I posted to the wrong list.
> 
> Anyone knows why the SPARC makefiles (arch/sparc/Makefile and
> arch/sparc/vdso/Makefile) set `-fcall-used-g5` and  `-fcall-used-g7`
> in their CFLAGS?

sparc32 uses:
-fcall-used-g5 -fcall-used-g7


sparc64 uses:
-ffixed-g4 -ffixed-g5 -fcall-used-g7


For sparc64:

-ffixed-g4 is added because sparc64 uses the g4 register to hold the
pointer to the current task. See:

    arch/sparc/include/asm/current.h line 18.


g2, g5, g7 all have their specific use or assumptions.

From arch/sparc/include/asm/ttable.h: 

 * Further note that we cannot use the g2, g4, g5, and g7 alternate
 * globals in the spill routines, check out the save instruction in
 * arch/sparc64/kernel/etrap.S to see what I mean about g2, and
 * g4/g5 are the globals which are preserved by etrap processing
 * for the caller of it.  The g7 register is the return pc for
 * etrap.  Finally, g6 is the current thread register so we cannot
 * us it in the spill handlers either.  Most of these rules do not
 * apply to fill processing, only g6 is not usable.
 */


Looking at https://github.com/gcc-mirror/gcc/blob/master/gcc/config/sparc/sparc.h
I read that:

   On v9 systems:
   g1,g5 are free to use as temporaries, and are free to use between calls
   ...
   g6-g7 are reserved for the operating system (or application in
   embedded case).

Based on the above I would assume gcc do not change behaviour with or
without -fcall-used-g7.

I do not have a sparc64 system at my hands - and for this qemu may not
cut it. But it would be super if someone with a working sparc64 target
could verify if the kernel could be built and works without
-fcall-used-g7.


For sparc32 the above file says:

    g5 through g7 are reserved for the operating system.

So again - it looks like -fcall-used-g5 -fcall-used-g7 should have no
effect here and verification on a real target would be nice.

	Sam

