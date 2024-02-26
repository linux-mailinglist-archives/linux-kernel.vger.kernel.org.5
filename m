Return-Path: <linux-kernel+bounces-82227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BF28680CA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5701F2B96A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C0712F5A0;
	Mon, 26 Feb 2024 19:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="E9Rmwynv"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF14812EBE8
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708975162; cv=none; b=GcXh1gZBtKSmHwr7TVYUJIExxeOh5Q8Ckilw5MY6J57KELo0gv/eM6K6nSm/LSJgm1eAEpb6+vw2xa7OLsnHawSEByR2xoBYA++udsP1CeIqN65ejAS+LtpGw0IEQBvUft2UbF7IYs12Gq6vvidKtfc5LRHcMrXZBuKPqCalrdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708975162; c=relaxed/simple;
	bh=aCwn4f9diVs04DfSW6dmXRb+FQ9OsFRJQJiGQjLSN8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVKQmxnTS2Y9vKUrxXdS4f2rpsJHMM/m8y2BC1JiFTeRMQqpl1scGurLTbKTDyvLQBcbKaLmF96cd1iV3/GDFZ8Y7C39ejYM4SNXfpcGEOhR+GNAzLFWUb8TlyyPl2jvp9uWIc0WBn497oCJc/AYO+sJFmkUr9WkioOyScS8pjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=E9Rmwynv; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-29ad8ef1384so526422a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708975160; x=1709579960; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LP96tCONgQZzLKOt6HJu425nt0R69w5f62QxpSwr1Ws=;
        b=E9Rmwynv8F0Gx6gJVgh1FoHMoDnlJ7YA/6ITN3GSNpeMdgiHydYwwUS/41Id8jsiH0
         6V3LOz98SmXKDwkSL3MFYWfFoqkbuVM0jBjxibkn8tRgTt1WUnhc2PnYhxLi9aL7D8m6
         bAPgU8PFhl8lPZdsQjWHIRyih46gcbOUwuXXPE24msvHPaSlxZxVf/q2mgxMzEAiZtY5
         kozZ+pamTip8jKNyCcwkosxlscXedqso4qu4nVE6Tq8LvaW8SuppGO9sOP4oRaDxM0v+
         sNs3rHv7PF1eOBFUekRVomOTKTgy8ifPjqzfhakxpdH4MDQKwGUj94VGCVH7YWF+ZVII
         53EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708975160; x=1709579960;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LP96tCONgQZzLKOt6HJu425nt0R69w5f62QxpSwr1Ws=;
        b=F+JbmbFRAK2hzmWD7gm96uqZr+zMEhJAYXcbU/yhl87pw9hdF3jKSxOg8kGqWqM1IX
         Km6GUByZYMz4VnPVisG26VBGP0zXrOHv+6MpjPH8UOlnGS9e27u27WQ07R4Nmrc7veBm
         lBSgUXpN8ueas91yOtnQeMDiei86+EpnjkrTbkBWMjA8rwwW1S1muZnB6UcGm06aQvfb
         9VRYWiw3T8bM1WLX38eTjb4/ZlHGxR19p/cjk1n41cJm6GpOu79FJCxyXu5222HAoApW
         Odi8tfQapHI316xorlIj8ZELXvkDYIyQyHaP+w/SS0W/T/GLMF2orZiwcpA7phpvQCzK
         Ok+A==
X-Forwarded-Encrypted: i=1; AJvYcCX1rC25/TZPZLY3kh0BtguxRr7rQ8PE2XpFUrKNDRvl+sarnhaVNg1eeNWXDi1Gsu15llE+OEw3+1JPVtcvbDth+BsvFW/X9drEVGpF
X-Gm-Message-State: AOJu0YwKGQ11OVWhimPF5Bae52iJqPVnNF7SG2fUheVouW9K7x5EJfZO
	1oTQ2ie7GpDFGveVIdS8soztZR9rUKmarSX3yZ0i8iy6sSmATmgyQebfS2Duc9o=
X-Google-Smtp-Source: AGHT+IGqrOoB2svzJRunxD6HlWQbtvuz8cc1bx8/K5x6DzRWLxfXhdCGOVrRmpAHwF2Zg1GTs1ZMPg==
X-Received: by 2002:a17:90a:ee8a:b0:299:4d91:c8f6 with SMTP id i10-20020a17090aee8a00b002994d91c8f6mr5552927pjz.35.1708975159886;
        Mon, 26 Feb 2024 11:19:19 -0800 (PST)
Received: from ghost ([50.213.54.97])
        by smtp.gmail.com with ESMTPSA id se13-20020a17090b518d00b00299b31de43esm6883869pjb.45.2024.02.26.11.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 11:19:19 -0800 (PST)
Date: Mon, 26 Feb 2024 11:19:16 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
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
Message-ID: <ZdzkNBIm00xG4Bu2@ghost>
References: <20240223-fix_sparse_errors_checksum_tests-v10-1-b6a45914b7d8@rivosinc.com>
 <7ae930a7-3b10-4470-94ee-89cb650b3349@csgroup.eu>
 <e11fea7a-e99e-4539-a489-0aa145ee65f0@roeck-us.net>
 <ZdzPgSCTntY7JD5i@shell.armlinux.org.uk>
 <ZdzZ5tk459bgUrgz@ghost>
 <ZdzhRntTHApp0doV@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZdzhRntTHApp0doV@shell.armlinux.org.uk>

On Mon, Feb 26, 2024 at 07:06:46PM +0000, Russell King (Oracle) wrote:
> On Mon, Feb 26, 2024 at 10:35:18AM -0800, Charlie Jenkins wrote:
> > On Mon, Feb 26, 2024 at 05:50:57PM +0000, Russell King (Oracle) wrote:
> > > On Mon, Feb 26, 2024 at 08:44:29AM -0800, Guenter Roeck wrote:
> > > > On 2/26/24 03:34, Christophe Leroy wrote:
> > > > > 
> > > > > 
> > > > > Le 23/02/2024 à 23:11, Charlie Jenkins a écrit :
> > > > > > The test cases for ip_fast_csum and csum_ipv6_magic were not properly
> > > > > > aligning the IP header, which were causing failures on architectures
> > > > > > that do not support misaligned accesses like some ARM platforms. To
> > > > > > solve this, align the data along (14 + NET_IP_ALIGN) bytes which is the
> > > > > > standard alignment of an IP header and must be supported by the
> > > > > > architecture.
> > > > > 
> > > > > I'm still wondering what we are really trying to fix here.
> > > > > 
> > > > > All other tests are explicitely testing that it works with any alignment.
> > > > > 
> > > > > Shouldn't ip_fast_csum() and csum_ipv6_magic() work for any alignment as
> > > > > well ? I would expect it, I see no comment in arm code which explicits
> > > > > that assumption around those functions.
> > > > > 
> > > > > Isn't the problem only the following line, because csum_offset is
> > > > > unaligned ?
> > > > > 
> > > > > csum = *(__wsum *)(random_buf + i + csum_offset);
> > > > > 
> > > > > Otherwise, if there really is an alignment issue for the IPv6 source or
> > > > > destination address, isn't it enough to perform a 32 bits alignment ?
> > > > > 
> > > > 
> > > > It isn't just arm.
> > > > 
> > > > Question should be what alignments the functions are supposed to be able
> > > > to handle, not what they are optimized for. If byte and/or half word alignments
> > > > are expected to be supported, there is still architecture code which would
> > > > have to be fixed. Unaligned accesses are known to fail on hppa64/parisc64
> > > > and on sh4, for example. If unaligned accesses are expected to be handled,
> > > > it would probably make sense to add a separate test case, though, to clarify
> > > > that the test fails due to alignment issues, not due to input parameters.
> > > 
> > > It's network driver dependent. Most network drivers receive packets
> > > to the offset defined by NET_IP_ALIGN (which is normally 2) which
> > > has the effect of "mis-aligning" the ethernet header, but aligning
> > > the IP header.
> > > 
> > > Whether drivers do that is up to drivers (and their capabilities).
> > > Some network drivers can not do this kind of alignment, so there are
> > > cases where the received packets aren't offset by two bytes, leading
> > > to the IP header being aligned to an odd 16-bit word rather than an
> > > even 16-bit word (and thus 32-bit aligned.)
> > > 
> > > Then you have the possibility of other headers between the ethernet
> > > and IP header - not only things like VLANs, but also possibly DSA
> > > headers (for switches) and how big those are.
> > 
> > Those additional combinations can be supported by future test cases,
> > but the goal of this patch was simply to have basic testing for these
> > functions. The NET_IP_ALIGN offset is what the kernel defines to be
> > supported, so that is the test case I went for.
> 
> I think you misunderstand. "NET_IP_ALIGN offset is what the kernel
> defines to be supported" is a gross misinterpretation. It is not
> "defined to be supported" at all. It is the _preferred_ alignment
> nothing more, nothing less.

What alignment can be relied on by a test case?

- Charlie

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

