Return-Path: <linux-kernel+bounces-112575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E56F1887B9C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 05:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B246B214CC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 04:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648439470;
	Sun, 24 Mar 2024 04:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hbkm/aPR"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E739579DE
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 04:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711253141; cv=none; b=JBYuWz0uBXd/lXEB5fMptCKc8MgPPRju+uCHRt/TAqDPjywdmpWg3JSNw6aycT68VeEue3wlgZgjzUisVzl3A+ZkdZwkb7f9yFTUr33orR2+P4y/+ezyCOoyoiF3DrxeIP36nwx6KHxIRtvPDUWBTMMSR5s2COUfRjZIv/iBGqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711253141; c=relaxed/simple;
	bh=QH35gDBMZtnTvvWX3rTkzNhmcoQ63p84MVoOOvGJSnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajqTdgNpQi1/rEsGPBAoTRFo/Yjzdi1nSABbFhRV65RYY3r9YHodUdVDKPZJT2E/hP0WZ62UOF6MCIZKXJNHsIgxgjNv/laysW/Ak7yUQ+fiVoJvPJwmiNMxx4KVnVwH/+jXeoP58yRLbbNyj9Bj/QEVtuhGGOyyVKvwCwzjVY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hbkm/aPR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41482aa8237so5827625e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 21:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711253138; x=1711857938; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O67S5c+5kQCdv3vWEeYVd9AEBpFpCVIGSuLeo9AkMuo=;
        b=Hbkm/aPR8W9rvCT+7OnosqcUvMOM2WI0ofABOwtMOfa8uE9kzZ2iOq+75vSJh2PzSx
         Te4U4Ah3u5HvgOo05FTGJ7JN8OEtPVNWzQPBt20uuwNAqPUYO3adXYBuJhR/C4Fv1zPA
         mb/rju/T7i1CQf8V7Gs6UC2l76DtWxDIs+BdHDdVnwzm28EFHkLih3PzFSGX52jMu/9n
         4yb/StYbmohYVfrJGoSIoUcAVGfiN89h8QBx7n9lOqV+e9TORVUlFQAFFHntno8fNeKR
         tG0D50AuRxHqIPctjAWraRB3ytM076ERapdlVVjf6zj0BRYUpg7K67X1lyRfyGJQ/3gQ
         hkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711253138; x=1711857938;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O67S5c+5kQCdv3vWEeYVd9AEBpFpCVIGSuLeo9AkMuo=;
        b=aHtqah2sXkAqitHGaPFpfRiW93LvcRAToI0Msu7tyteI4pGi/bB1Z+joTmZQVB0rvi
         VDzq7WKzuO0fTELHz7D/w52U43yAuzziMVnuF85mJXxUloQtxW5pRQdn9qXxT1cTZad+
         iqxXdVXsvJv/D8lcGfPquQ0F2XQsJH0gSUpyI00QTNxJf3YUIHHf32HzMhg4Y9P3rdff
         dFVqHEtniwPQiLdnkt5aC1xUgnOYdmbGDjLhy2pI3Bvj/NE5DiA24YRBhp470/mWAIEq
         kGv+Rd6bzdV1TKrbwcqFiWYssqEI0jixsPxKswNULuPHayttv69WWJAhhW5A8N3F9ItP
         p8qA==
X-Forwarded-Encrypted: i=1; AJvYcCXNnPpMs6c/9R8yBsiFZArm0RsMBKvnp4WDZfstuAYyjabwvARLzX545fDJpiW7ml30bNn8z5VSYymKs+LT4Az3PE47cJPs01h1ltAI
X-Gm-Message-State: AOJu0YzTakqGgP6j1KxIVmCSvX7GOz2wfG/7ZKoCNZzLzkuVQH/iK3NJ
	WPgFaJooUSEKjlOmWq1NOpS4aPcRIOuXYNkj87I4dFiDbamfC/vr
X-Google-Smtp-Source: AGHT+IFgoqOltmEARJI9oBvfTlu2fs5sdVtr8xdjr2+VU5hMHPKOq5ZnbojywBAsOadydqNb6glHnw==
X-Received: by 2002:a7b:c055:0:b0:414:5cec:a9dd with SMTP id u21-20020a7bc055000000b004145ceca9ddmr3028807wmc.38.1711253137917;
        Sat, 23 Mar 2024 21:05:37 -0700 (PDT)
Received: from gmail.com (195-38-112-2.pool.digikabel.hu. [195.38.112.2])
        by smtp.gmail.com with ESMTPSA id ay34-20020a05600c1e2200b0041480c36bc6sm3494995wmb.27.2024.03.23.21.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 21:05:37 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 24 Mar 2024 05:05:35 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Brian Gerst <brgerst@gmail.com>
Cc: Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
	David.Laight@aculab.com,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 00/16] x86-64: Stack protector and percpu improvements
Message-ID: <Zf+mjy49dG5ly9ka@gmail.com>
References: <20240322165233.71698-1-brgerst@gmail.com>
 <CAFULd4bCufzKjaUyOcJ5MfsPBcVTj1zQiP3+FFCGo6SbxTpK2A@mail.gmail.com>
 <Zf+PIYP4TyF6ZRVy@gmail.com>
 <CAMzpN2htOit94c-M+zHqEcLcGPOU2zTS6wM-r7xWwd9Ku8h3-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMzpN2htOit94c-M+zHqEcLcGPOU2zTS6wM-r7xWwd9Ku8h3-Q@mail.gmail.com>


* Brian Gerst <brgerst@gmail.com> wrote:

> On Sat, Mar 23, 2024 at 10:25 PM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > > On Fri, Mar 22, 2024 at 5:52 PM Brian Gerst <brgerst@gmail.com> wrote:
> > > >
> > > > Currently, x86-64 uses an unusual percpu layout, where the percpu section
> > > > is linked at absolute address 0.  The reason behind this is that older GCC
> > > > versions placed the stack protector (if enabled) at a fixed offset from the
> > > > GS segment base.  Since the GS segement is also used for percpu variables,
> > > > this forced the current layout.
> > > >
> > > > GCC since version 8.1 supports a configurable location for the stack
> > > > protector value, which allows removal of the restriction on how the percpu
> > > > section is linked.  This allows the percpu section to be linked normally,
> > > > like other architectures.  In turn, this allows removal of code that was
> > > > needed to support the zero-based percpu section.
> > >
> > > The number of simplifications throughout the code, enabled by this
> > > patch set, is really impressive, and it reflects the number of
> > > workarounds to enable the feature that was originally not designed for
> > > the kernel usage. As noted above, this issue was recognized in the GCC
> > > compiler and the stack protector support was generalized by adding
> > > configurable location for the stack protector value [1,2].
> > >
> > > The improved stack protector support was implemented in gcc-8.1,
> > > released on May 2, 2018, when linux 4.17 was in development. In light
> > > of this fact, and 5 (soon 6) GCC major releases later, I'd like to ask
> > > if the objtool support to fixup earlier compilers is really necessary.
> > > Please note that years ago x86_32 simply dropped stack protector
> > > support with earlier compilers and IMO, we should follow this example
> > > also with x86_64, because:
> >
> > Ack on raising the minimum version requirement for x86-64
> > stackprotector to 8.1 or so - this causes no real pain on the distro
> > side: when *this* new kernel of ours is picked by a distro, it almost
> > always goes hand in hand with a compiler version upgrade.
> >
> > We should be careful with fixes marked for -stable backport, but other
> > than that, new improvements like Brian's series are a fair game to
> > tweak compiler version requirements.
> >
> > But please emit a (single) prominent build-time warning if a feature is
> > disabled though, even if there are no functional side-effects, such as
> > for hardening features.
> 
> Disabled for any reason or only if the compiler lacks support?

Only if the user desires to have it enabled, but it's not possible due 
to compiler (or other build environment) reasons. Ie. if something 
unexpected happens from the user's perspective.

The .config option is preserved even if the compiler doesn't support 
it, right?

I suspect this should also cover features that get select-ed by a 
feature that the user enables. (Not sure about architecture level 
select-ed options.)

Thanks,

	Ingo

