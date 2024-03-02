Return-Path: <linux-kernel+bounces-89478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1469686F0DE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C98AB23B5D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 15:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B4C1863E;
	Sat,  2 Mar 2024 15:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnb8cyaa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872A217BD3
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 15:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709393553; cv=none; b=QuzqhfCVIGtqhvblOfH3LGDRmESEW4/QjuYNTlumnzdrkafhAG2lSxMh4SADZBwlnhWPn9s6dxAblbXqQ6MriqtNwAFzQ1QL3uFd+xJYEAcoEwNFd6hVkXb9hoSZ1jOv/hGJVH8vRPvv1+liyh3c/WlENFdj1AfZDjtvhUm0EkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709393553; c=relaxed/simple;
	bh=cN/+QDYO2RX6svKDaYXJ3Vkrd/R9i92cwxx87LeLBNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JoikXaoPTECdIn76hePKhA9gji7ioppt2/honlAc48OX85mA/+YjbDgrPj1mVy6lXtdmvsa+k+mJuj5fmUMd0wPN3vR1PBHzOgZ9txrTOhobMRTo0eRcZtbmsXONZXQSvANmesjrOyfBIoA6/AzV0RantK9on2pxpqYVaE71WvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnb8cyaa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB54C433C7
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 15:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709393553;
	bh=cN/+QDYO2RX6svKDaYXJ3Vkrd/R9i92cwxx87LeLBNc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cnb8cyaaxMvRjW0rDSRo8fldkUNUZKFtXFkKSJhDJ8TztCwUm+wrGTOPuzvsohDQL
	 wSukTiKjexVhuZ95f8ImFxG9DNsWn1bq5PIs2xUgjzek4lGfybMhdcAimnESD1zimC
	 yzyNTGIp87npJDyh/SgDpDVVPkUdPHnMSMCSJzWsnlFMsrIrGYTQF4XU75R41Jwde9
	 LHq6ovTap3ZIBN6XQ8SzNjDjmk0Qhw8P2kG0QcAYzmFE/MPzm95sPmXfdZA/UVjtio
	 Vxlh7X9oVH6KmFfQeHNpg/khVNxOa/yvFKm956m7/qwboNZX+qx/EoY5PZeoh+y0kc
	 6CYTgW1UQXwRA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5131c48055cso3062891e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 07:32:32 -0800 (PST)
X-Gm-Message-State: AOJu0YxXXh45xT1h2vV2r9fOcKorkqqQzbSnF3fNC72+ysDefnJv1oaa
	uvYELZ2M1DgbQYsoE/C9CfhcRwu5jIdkM8EHyJ3SeKDAcZ9odaBzljYSqoK+/rZ0pG+GXY9KDiN
	tHJmdHVuwkBXeQ+4db+4g6KcH4Ug=
X-Google-Smtp-Source: AGHT+IEwaU1FCfSkxst4Qeq+VE7wkmS1ABSJBKggm6YVw/nNDKupf1SyLME7YQB/w0Gyhge81mwJJzpTSgNX7bgxRr0=
X-Received: by 2002:a19:2d4f:0:b0:513:2b35:2520 with SMTP id
 t15-20020a192d4f000000b005132b352520mr3037593lft.58.1709393551183; Sat, 02
 Mar 2024 07:32:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227151907.387873-11-ardb+git@google.com> <20240227151907.387873-20-ardb+git@google.com>
 <20240301192017.GOZeIqcbI9S69zdBYW@fat_crate.local> <CAMj1kXFoYR6rD6GZ6NFLuCXE-q8G4HV0htEcx1omjymbfxVyAg@mail.gmail.com>
 <20240302151720.GCZeNDAGBUuv2Pemf6@fat_crate.local>
In-Reply-To: <20240302151720.GCZeNDAGBUuv2Pemf6@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 2 Mar 2024 16:32:19 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFGiSXMw4APCDUbuFdh7pvwOgcpWnVpiwYkVgixvmEzBg@mail.gmail.com>
Message-ID: <CAMj1kXFGiSXMw4APCDUbuFdh7pvwOgcpWnVpiwYkVgixvmEzBg@mail.gmail.com>
Subject: Re: [PATCH v7 9/9] x86/startup_64: Drop global variables keeping
 track of LA57 state
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 2 Mar 2024 at 16:17, Borislav Petkov <bp@alien8.de> wrote:
>
> On Sat, Mar 02, 2024 at 12:55:14AM +0100, Ard Biesheuvel wrote:
> > Today, pgtable_l5_enabled() is used in many places, most of which
> > resolve to cpu_feature_enabled(), and I don't think you are suggesting
> > to replace all of those with a variable load, right?
>
> pgtable_l5_enabled() is the odd one out, special thing which should
> have been cpu_feature_enabled() as latter is the default interface we
> use to query what features the CPU supports. But 5level got done long
> ago and we hadn't decided upon cpu_feature_enabled() back then.
>
> So should we replace it with it?
>
> Yap, eventually.
>

That is not the issue here. The issue is that cpu_feature_enabled()
will produce the wrong value if you call it too early.

The 'late' version of pgtable_l5_enabled() already uses
cpu_feature_enabled(), and I don't think that needs to change. Or are
you saying that pgtable_l5_enabled() should not exist at all, and all
ordinary users should use cpu_feature_enabled() directly? I suspect
that would cause problems where pgtable_l5_enabled() is used in static
inlines in header files, and it is left up to the .c file to set the
#define to convert all #include'd occurrences of pgtable_l5_enabled()
into the 'early' variant.

> > So that means we'll have to stick with early and late variants of
> > pgtable_l5_enabled() like we have today,
>
> I don't mind at all if we had a
>
>         early_pgtable_l5_enabled()
>

That wouldn't work with the static inline users of pgtable_l5_enabled().

> which does the RIP_REL_REF() thing and it should be used only in 1:1
> mapping code and the late stuff should start to get replaced with
> cpu_feature_enabled() until pgtable_l5_enabled() is completely gone.
>

All the references to pgtable_l5_enabled() are already gone from the
code that executes from a 1:1 mapping. That is why this patch is
optional: it is just cleanup that goes on top of the earlier patch
that gets rid of potentially problematic uses of fixup_pointer().

The issue being solved here is that we duplicate the value of CR4.LA57
into a global variable, in a way that requires us to reason about
whether routines in a certain compilation unit might be called before
cpu_feature_enabled() may be used. LA57 is an example of a feature
where we cannot just assume that it is missing until the point where
we figure out whether it is there or not, like in most other cases
with CPU features that are truly optional.

But I am not aware of any issues around this, although the early
accessors are probably used more widely than necessary at this point.

So an alternative approach might be to not use cpu_feature_enabled()
at all, and always rely on the global variables. But that might tickle
a hot path in the wrong way and cause a noticeable slowdown on some
benchmark.

> And then we even see whether we can opencode the handful places.
>
> > and we should just drop this patch instead - I put it at the end of
> > the series for a reason.
>
> Yeah, we can leave that one aside for now but use it to start a cleanup
> series.
>
> If you're bored and feel like doing it, be my guest but for the next
> cycle. Or I'll put it on my evergrowing TODO and get to it eventually.
>

I don't mind revisiting this next cycle.

> For now, lemme test your set without this one and see whether we can
> queue them even now.
>

Cheers.

