Return-Path: <linux-kernel+bounces-136725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3D689D798
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390031C22BDE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572E08592A;
	Tue,  9 Apr 2024 11:06:07 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73033811E9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 11:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712660766; cv=none; b=IjxtnvuKKccBlCeY7YD31I1ASpsokcySAXhYW6lnDjTOfzKf7iSj8Gk4hbYXaKB+dMEFsgAtLGx2JtWiSODbdWCEYpJQ8jNJJci+m4BsYeWSLpIV7RUuxxSj7im2f6Wx/ygXiR10LEFGKJGuCG4E4ceHsCFT21o2z/69XpMyjcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712660766; c=relaxed/simple;
	bh=jZTLyz5ftwGYuRG1TQpFcWlZU9q3DkyUGs+MjhLTOoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3gpxOdulx59kctwqoSU9qzrus/IRdm+U8DOjSRpZ9/kFA60Kl40ezoC8wKx/DlbKLiTdSFEOCGT79O4kFdHFd79MiJoG7/IdZj4spG4NaQecuLB4FMSqsM8D7e4Pb7gse2b5sSpxADXz5KGwt8tLCdEu9h6fKmhIrYDD63OWms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 53A6840E00B2;
	Tue,  9 Apr 2024 11:06:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pL-2fTvlDty3; Tue,  9 Apr 2024 11:05:58 +0000 (UTC)
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 70D3140E0187;
	Tue,  9 Apr 2024 11:05:53 +0000 (UTC)
Date: Tue, 9 Apr 2024 13:05:48 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mahmoud Younes <m.younesbadr@gmail.com>
Cc: dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
	luto@kernel.org
Subject: Re: [PATCH] kaslr: x86: fixes log message nokaslr
Message-ID: <20240409110548.GBZhUhDGv4qXHGeXUG@fat_crate.local>
References: <20240331200546.869343-1-m.younesbadr@gmail.com>
 <20240331202827.GAZgnHayn794X_Ubs4@fat_crate.local>
 <CAMpxDQmx45VrrdZq6couUg0gU200qYdDiYF3Q=S+Nck6g-50LQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMpxDQmx45VrrdZq6couUg0gU200qYdDiYF3Q=S+Nck6g-50LQ@mail.gmail.com>

On Mon, Apr 01, 2024 at 07:38:17AM +0200, Mahmoud Younes wrote:
> I don't think this gets printed after executing dmesg. This gets
> printed to console if earlyprintks are captured to the console and the
> kernel is configured with printing low level debug info. that is not
> the default behavior and requires manipulating the kernel
> configuration and command line to get this message. Specifically,
> enabling DEBUG_LL and EARLY_PRINTK and adding "earlyprintk=ttyS0" or
> whatever console in use. the message is just not visible in dmesg even
> though it would exist in kernel log buffer, just the console wouldn't
> be initialized at that moment.

If it is in the log buffer, it should come out at some point.

> this is not visible when booting a real hardware.

I don't think so - otherwise earlyprintk is broken.

> Since I am new to the kernel code base, I would appreciate some
> guidance on how to move forward. Thank you!

Since those very early params are a handful and need special treatment,
I'd prefer if they're handled explicitly as every arch does its own
thing.

So print_unknown_bootoptions() is perhaps not the best place as it is
arch-agnostic.

For this particular one:

void choose_random_location(unsigned long input,
                            unsigned long input_size,
                            unsigned long *output,
                            unsigned long output_size,
                            unsigned long *virt_addr)
{
        unsigned long random_addr, min_addr;

        if (cmdline_find_option_bool("nokaslr")) {
                warn("KASLR disabled: 'nokaslr' on cmdline.");
                return;
        }

        boot_params_ptr->hdr.loadflags |= KASLR_FLAG;

So your dummy stub could look at the loader flags and at least warn when
there's a mismatch.

And it should have a big fat comment explaining why this stub is there.

I guess that would be a good compromise between overengineering this for
no good reason and not doing anything at all and confusing users.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

