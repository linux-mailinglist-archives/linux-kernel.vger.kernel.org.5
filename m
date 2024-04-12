Return-Path: <linux-kernel+bounces-143315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D38068A371D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6E0DB2292D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FB627442;
	Fri, 12 Apr 2024 20:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="z1LGY7lp"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B28E199B8
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 20:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712954088; cv=none; b=Uj+L+FiuNbCTtC6nRy3ku9NxHIBAX3k7eBEWKhg5gdZ6LNzkY+TpWEGi6LvMnEeyAUz/4Mwr9Tbmc3O0C8Gwxt2yVkXkK/a+Y+d5DKlmMRg5R307FE5+C9hpCCkfaEx4VqcMQhRKqKw2p4zjLtHqyXN74ZDCEqxAap4SKm1bvpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712954088; c=relaxed/simple;
	bh=loMKYNw/xhh/jyJ4cuKkExEImeaqTLizZBny4wQOvD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwKBs/2phLVphQ9SuheAcJq1o/PPcwhA5yifB1ScWUhzopHl03VmjABp+rGz1otnmQrBronTsUxPCZ4LIA2DZIQiI+PoFckiXMzpz8saZLvsP6i1gAy7IVSYtXwgQczsV5M5aJ+ITypm5K1EEFkxv/DKeCZrz+34msQsmdK8zT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=z1LGY7lp; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ed627829e6so1259689b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712954086; x=1713558886; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oY4nkb56vAnwFBrxRJwfi/83hDDE+J6pWJ1yps5//Zc=;
        b=z1LGY7lp1lbNBLEzz7oXJ3ZpZyDXj8VQ0I3GJzP7h2hSXL8cFq8K999IA2ec5nljXj
         NskTa8/nX8VsHoGcp0S1JYHLna7ekm83puNHIYXaz9uEr/htPu9K5qgFFP5Y0CHXqU64
         1aZvBUcaw/Ip+mnRU6sDHc8nFllZWspamvLUrvEgwwEFwXhnt6NYlQrpPqaS/M9D8dCG
         k9tawtJiIwrSxVDHZ69DyzWvkdhW8RTCO4ocIgVJL9szwx1IHD/jf5ffXTVll5aHGjsf
         IfZWez4lPRM900RZhzHyn6ZeizsXDXJUOfxK+4c4UZfdhuNI9kBAztpkRCylwhFtEcDk
         eCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712954086; x=1713558886;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oY4nkb56vAnwFBrxRJwfi/83hDDE+J6pWJ1yps5//Zc=;
        b=Q+3LUxcwqR4XZkOZwWc4MH4Sf8MHFOm+1HMPSrYJvFDQtZHQsXtsgsX7QetClTHbOP
         iUt9u+z9bCaUhDSiAZvd5iCsIXpCOXOBAycZdCGu2/1XPXTPcpWUIZe0oYthakvL7fir
         FmEnDzi9EZosWzSEgg+qhgPnnrlIBIvW8Q+cLAJ0pAE7eA5iHqiYo2eGMGq8GcctbxRJ
         wHdnJ418FJL9T/RjNs0ONIt2HahFB0jAqPJnYWPpEtkXm2xohn/rviTfVbQjk5NsZQuT
         fB0wnFVj4YMpI0Bn8OnNLI/87qkyjGs1iVU2fMz8kxpl20+eDQvtz/Qw7G/cqPKOxrRL
         s4SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg8aexM/jc6Q2zJ2zMaE/4uxq6fkHpa7v2lxo+owFMRAGKL7zSEbl4nthnUUP235rb+CX49GcWyAZkIqDiDZwYVpesZsukHHlyKAsj
X-Gm-Message-State: AOJu0YzKPwPBooWxSyBjCpTR+z/ZDoke7w7JRTVhZqiknrGge5CJ0Zat
	oSI3cxQCe+moGA1LkPtKYgeH3mC/Y5ueRkJSZTUphDCKLu80CT0pJ/92hxvwBpo=
X-Google-Smtp-Source: AGHT+IGaQmX55JTPMh7eewAl1uYqQxasuC3IownyYJh3ikhM4PX0keclRrzWoXOYcfZeNLyTHp36qA==
X-Received: by 2002:a05:6a00:9aa:b0:6ed:435f:ec9b with SMTP id u42-20020a056a0009aa00b006ed435fec9bmr4550403pfg.20.1712954086437;
        Fri, 12 Apr 2024 13:34:46 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id lr48-20020a056a0073b000b006e724ccdc3esm3270068pfb.55.2024.04.12.13.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 13:34:45 -0700 (PDT)
Date: Fri, 12 Apr 2024 13:34:43 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Evan Green <evan@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 02/19] riscv: cpufeature: Fix thead vector hwcap removal
Message-ID: <Zhma45a2I7DgD8Ni@ghost>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-2-4af9815ec746@rivosinc.com>
 <20240412-tuesday-resident-d9d07e75463c@wendy>
 <CALs-HsuMZOMpDh8kwQx6FE2mawzt+qTD-WZ6Mvhrt+hUhkZimg@mail.gmail.com>
 <20240412-employer-crier-c201704d22e3@spud>
 <ZhmBfaKXMMtolwSr@ghost>
 <20240412-earmark-sanction-810b7222cae5@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240412-earmark-sanction-810b7222cae5@spud>

On Fri, Apr 12, 2024 at 08:26:12PM +0100, Conor Dooley wrote:
> On Fri, Apr 12, 2024 at 11:46:21AM -0700, Charlie Jenkins wrote:
> > On Fri, Apr 12, 2024 at 07:38:04PM +0100, Conor Dooley wrote:
> > > On Fri, Apr 12, 2024 at 10:04:17AM -0700, Evan Green wrote:
> > > > On Fri, Apr 12, 2024 at 3:26 AM Conor Dooley <conor.dooley@microchip.com> wrote:
> > > > >
> > > > > On Thu, Apr 11, 2024 at 09:11:08PM -0700, Charlie Jenkins wrote:
> > > > > > The riscv_cpuinfo struct that contains mvendorid and marchid is not
> > > > > > populated until all harts are booted which happens after the DT parsing.
> > > > > > Use the vendorid/archid values from the DT if available or assume all
> > > > > > harts have the same values as the boot hart as a fallback.
> > > > > >
> > > > > > Fixes: d82f32202e0d ("RISC-V: Ignore V from the riscv,isa DT property on older T-Head CPUs")
> > > > >
> > > > > If this is our only use case for getting the mvendorid/marchid stuff
> > > > > from dt, then I don't think we should add it. None of the devicetrees
> > > > > that the commit you're fixing here addresses will have these properties
> > > > > and if they did have them, they'd then also be new enough to hopefully
> > > > > not have "v" either - the issue is they're using whatever crap the
> > > > > vendor shipped.
> > > > > If we're gonna get the information from DT, we already have something
> > > > > that we can look at to perform the disable as the cpu compatibles give
> > > > > us enough information to make the decision.
> > > > >
> > > > > I also think that we could just cache the boot CPU's marchid/mvendorid,
> > > > > since we already have to look at it in riscv_fill_cpu_mfr_info(), avoid
> > > > > repeating these ecalls on all systems.
> > > > >
> > > > > Perhaps for now we could just look at the boot CPU alone? To my
> > > > > knowledge the systems that this targets all have homogeneous
> > > > > marchid/mvendorid values of 0x0.
> > > > 
> > > > It's possible I'm misinterpreting, but is the suggestion to apply the
> > > > marchid/mvendorid we find on the boot CPU and assume it's the same on
> > > > all other CPUs? Since we're reporting the marchid/mvendorid/mimpid to
> > > > usermode in a per-hart way, it would be better IMO if we really do
> > > > query marchid/mvendorid/mimpid on each hart. The problem with applying
> > > > the boot CPU's value everywhere is if we're ever wrong in the future
> > > > (ie that assumption doesn't hold on some machine), we'll only find out
> > > > about it after the fact. Since we reported the wrong information to
> > > > usermode via hwprobe, it'll be an ugly userspace ABI issue to clean
> > > > up.
> > > 
> > > You're misinterpreting, we do get the values on all individually as
> > > they're brought online. This is only used by the code that throws a bone
> > > to people with crappy vendor dtbs that put "v" in riscv,isa when they
> > > support the unratified version.
> > 
> > Not quite,
> 
> Remember that this patch stands in isolation and the justification given
> in your commit message does not mention anything other than fixing my
> broken patch.

Fixing the patch in the simplest sense would be to eagerly get the
mvendorid/marchid without using the cached version. But this assumes
that all harts have the same mvendorid/marchid. This is not something
that I am strongly attached to. If it truly is detrimental to Linux to
allow a user a way to specify different vendorids for different harts
then I will remove that code.

- Charlie

> 
> > the alternatives are patched before the other cpus are
> > booted, so the alternatives will have false positives resulting in
> > broken kernels.
> 
> Over-eagerly disabling vector isn't going to break any kernels and
> really should not break a behaving userspace either.
> Under-eagerly disabling it (in a way that this approach could solve) is
> only going to happen on a system where the boot hart has non-zero values
> and claims support for v but a non-boot hart has zero values and
> claims support for v but actually doesn't implement the ratified version.
> If the boot hart doesn't support v, then we currently disable the
> extension as only homogeneous stuff is supported by Linux. If the boot
> hart claims support for "v" but doesn't actually implement the ratified
> version neither the intent of my original patch nor this fix for it are
> going to help avoid a broken kernel.
> 
> I think we do have a problem if the boot cpu having some erratum leads
> to the kernel being patched in a way that does not work for the other
> CPUs on the system, but I don't think this series addresses that sort of
> issue at all as you'd be adding code to the pi section if you were fixing
> it. I also don't think we should be making pre-emptive changes to the
> errata patching code either to solve that sort of problem, until an SoC
> shows up where things don't work.
> Cheers,
> Conor.



