Return-Path: <linux-kernel+bounces-84267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5306786A45A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F7A1F22D62
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564511865;
	Wed, 28 Feb 2024 00:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RidsK9Gr"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C064CEDD
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 00:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709079699; cv=none; b=J9+C3oUgXG0zpm6yV/kD4Dp3KIgyqv/mvxhQbh0n7xV0hp8OmmXyZg2NDj/8jQud4DJgHJCW8EN5SirAfsGqycgpNCVJVrFZfpb5xx4loiquoeJlqWOZXhER9SEpqZbGckZ5foS8+yW7rcxJTzvux4PcnWFLFs3VuT0rZZoKFCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709079699; c=relaxed/simple;
	bh=2tx+CAAZ+8knFbLNc9ih2ERZytV3LC46oIUWIK/tEYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYCjKolTrO4Z/0eLgrkc/dfyryoY5a2MRaYo4ZrN+hHeIEVpdJWv5d4yhX8kkq/o9/831ZmldY3F++q5A2RKMJWuS183+Aw6rjtTdQ1lvh7+2aiG7yGqS/1qsWQUugkH9mGK07OYBRwx/9WSYrC+GGC3k3t0Nx6v2n+o1JckzfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RidsK9Gr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d94b222a3aso50157925ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 16:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709079697; x=1709684497; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PeW62lD1HbXZTDjdIl3PrIGd38WT41hWRPPZB4yHjx4=;
        b=RidsK9GrTuaDW8feFqrc09o+Gch8LMrp4I1Wx2yjgBKVaoDzWrF4B4L/uZiGtCU1y2
         zh5adqaJBPMAy1e1I8+MpZkvrAeywU+NfaxYUuVimPshmlRS94602PWIEPr6i8kX/Yya
         2d3a1J+cSkG+vzSiA1ckV/Oo0libks+sMbsF+kPp61FtpH0hKLeHPmrFx8B8AJdO0VX4
         ibnwp8vScfy8Vz9DDpItCnf9/eZjYDOJZLW65iH9dxoIVNhMGFVhJ5nqrEigXC2XpTE4
         Uzxu80VviJbPsFTnVbnYWdvNUP7c/UMFAj1CVf+VZkG3fiejBlD3mdsD8Bszi99ZzP3k
         6Nmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709079697; x=1709684497;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PeW62lD1HbXZTDjdIl3PrIGd38WT41hWRPPZB4yHjx4=;
        b=YpISrSY+K3nwvCW0SFNXCrttQDDXbddj86VB1/WYYuBdaLVpcO69TzU5pVDOxRlA3D
         vNYjFBiasUs7cEyi1XFDTFE+IuMRRy6t8M2KvlSfL4MxGYw2CLwaPwrO3eKKu4hFIl6h
         D9X5nbL6ermNCDI0gfbyvi8xYby7o0qtFeI1XkE3JgdWa5Z5yblsb9nHj+7KBH1sTT24
         f32+HcXI+hoKwX3Hl0vIp/vGSJ1f3ugrPVBn2XG77hl4UIFBv5Da7zUlo9ZDv2OdiB8z
         GKo+PZn5UknfHAZucGOFyQi64Xnmr1COaXlmoMZVJRADqDSzogQcWiFb3Sb2aC2hZkUg
         nl/g==
X-Forwarded-Encrypted: i=1; AJvYcCVA6VHMoxDmp9orEoVkOFqZ0WdZjJi4iRbbWqGjSSLYg0yXPQhqNjkpwk9t9GtGpOhWL+/QlNpI7I+Kx6sBb/b8mM6c1eqQT7zli9jd
X-Gm-Message-State: AOJu0YzfZLMqaRFnyBbCIYXHBGNSSK3I1iFyj+0+76Q7pyWmTBS0kTHY
	spKGD6BKA7nPauoZ4DQiptNqluVpkFeyXePmmx20TJr+gH40DcoAieHvfdd2Zdeq4BAu+3UgkkB
	diFQ=
X-Google-Smtp-Source: AGHT+IE8o9Rp+lbcfhjYaSP1dtgN80cS98Hloq7Zy1IPFODlR1CtDAZKxgLbRePODf9CvxcoTuoJbQ==
X-Received: by 2002:a17:903:1106:b0:1db:930e:e755 with SMTP id n6-20020a170903110600b001db930ee755mr16779201plh.35.1709079697022;
        Tue, 27 Feb 2024 16:21:37 -0800 (PST)
Received: from ghost ([50.213.54.97])
        by smtp.gmail.com with ESMTPSA id mm3-20020a1709030a0300b001db8145a1a2sm2102634plb.274.2024.02.27.16.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 16:21:36 -0800 (PST)
Date: Tue, 27 Feb 2024 16:21:34 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
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
Message-ID: <Zd58jvN3PjQSe+yt@ghost>
References: <7ae930a7-3b10-4470-94ee-89cb650b3349@csgroup.eu>
 <e11fea7a-e99e-4539-a489-0aa145ee65f0@roeck-us.net>
 <ZdzPgSCTntY7JD5i@shell.armlinux.org.uk>
 <ZdzZ5tk459bgUrgz@ghost>
 <ZdzhRntTHApp0doV@shell.armlinux.org.uk>
 <b13b8847977d4cfa99b6a0c9a0fcbbcf@AcuMS.aculab.com>
 <Zd0b8SDT8hrG/0yW@ghost>
 <cdd09f7a-83b2-41ba-a32c-9886dd79c43e@roeck-us.net>
 <9b4ce664-3ddb-4789-9d5d-8824f9089c48@csgroup.eu>
 <Zd25XWTkDPuIjpF8@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zd25XWTkDPuIjpF8@shell.armlinux.org.uk>

On Tue, Feb 27, 2024 at 10:28:45AM +0000, Russell King (Oracle) wrote:
> On Tue, Feb 27, 2024 at 06:47:38AM +0000, Christophe Leroy wrote:
> > 
> > 
> > Le 27/02/2024 à 00:48, Guenter Roeck a écrit :
> > > On 2/26/24 15:17, Charlie Jenkins wrote:
> > >> On Mon, Feb 26, 2024 at 10:33:56PM +0000, David Laight wrote:
> > >>> ...
> > >>>> I think you misunderstand. "NET_IP_ALIGN offset is what the kernel
> > >>>> defines to be supported" is a gross misinterpretation. It is not
> > >>>> "defined to be supported" at all. It is the _preferred_ alignment
> > >>>> nothing more, nothing less.
> > >>
> > >> This distinction is arbitrary in practice, but I am open to being proven
> > >> wrong if you have data to back up this statement. If the driver chooses
> > >> to not follow this, then the driver might not work. ARM defines the
> > >> NET_IP_ALIGN to be 2 to pad out the header to be on the supported
> > >> alignment. If the driver chooses to pad with one byte instead of 2
> > >> bytes, the driver may fail to work as the CPU may stall after the
> > >> misaligned access.
> > >>
> > >>>
> > >>> I'm sure I've seen code that would realign IP headers to a 4 byte
> > >>> boundary before processing them - but that might not have been in
> > >>> Linux.
> > >>>
> > >>> I'm also sure there are cpu which will fault double length misaligned
> > >>> memory transfers - which might be used to marginally speed up code.
> > >>> Assuming more than 4 byte alignment for the IP header is likely
> > >>> 'wishful thinking'.
> > >>>
> > >>> There is plenty of ethernet hardware that can only write frames
> > >>> to even boundaries and plenty of cpu that fault misaligned accesses.
> > >>> There are even cases of both on the same silicon die.
> > >>>
> > >>> You also pretty much never want a fault handler to fixup misaligned
> > >>> ethernet frames (or really anything else for that matter).
> > >>> It is always going to be better to check in the code itself.
> > >>>
> > >>> x86 has just made people 'sloppy' :-)
> > >>>
> > >>>     David
> > >>>
> > >>> -
> > >>> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, 
> > >>> MK1 1PT, UK
> > >>> Registration No: 1397386 (Wales)
> > >>>
> > >>
> > >> If somebody has a solution they deem to be better, I am happy to change
> > >> this test case. Otherwise, I would appreciate a maintainer resolving
> > >> this discussion and apply this fix.
> > >>
> > > Agreed.
> > > 
> > > I do have a couple of patches which add explicit unaligned tests as well as
> > > corner case tests (which are intended to trigger as many carry overflows
> > > as possible). Once I get those working reliably, I'll be happy to submit
> > > them as additional tests.
> > > 
> > 
> > The functions definitely have to work at least with and without VLAN, 
> > which means the alignment cannot be greater than 4 bytes. That's also 
> > the outcome of the discussion.
> 
> Thanks for completely ignoring what I've said. No. The alignment ends up
> being commonly 2 bytes.
> 
> As I've said several times, network drivers do _not_ have to respect
> NET_IP_ALIGN. There are 32-bit ARM drivers which have a DMA engine in
> them which can only DMA to a 32-bit aligned address. This means that
> the start of the ethernet header is placed at a 32-bit aligned address
> making the IP header misaligned to 32-bit.
> 
> I don't see what is so difficult to understand about this... but it
> seems that my comments on this are being ignored time and time again,
> and I can only think that those who are ignoring my comments have
> some alterior motive here.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

I don't understand how the capabilities of some ARM drivers factor in
here. It appears that a common case for calling this function is to pass
in an IP header that is aligned along an ethernet header + NET_IP_ALIGN.
It is perfectly acceptable that some drivers don't align along
NET_IP_ALIGN, but that does not seem relevant here.

This test case is supposed to be as true to the "general case" as
possible, so I have aligned the data along 14 + NET_IP_ALIGN. On ARM
this will be a 16-byte boundary since NET_IP_ALIGN is 2. A driver that
does not follow this may not be appropriately tested by this test case,
but anyone is welcome to submit additional test cases that address this
additional alignment concern.

- Charlie


