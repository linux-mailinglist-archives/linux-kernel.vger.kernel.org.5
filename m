Return-Path: <linux-kernel+bounces-88214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 004DC86DEB9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9422F1F23CDE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A67E6A8CB;
	Fri,  1 Mar 2024 10:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFKxcvA2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17F01E4BD
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 10:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709287307; cv=none; b=s+R1bGwIr/MeSl4icWnfaEFG4FfnryNhQtrOW03PcnxVPoBCUwbovkJ/n1g5Fkha0sfNTUNFlYYBjP6PH8ZzMdH8jhikguaQzEHlIaCzSghc42/EzmY55NpQDq1vz3YjHMwCd01GOxjavhAcU/5YqZastc4StFAKKIyX+LMdIPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709287307; c=relaxed/simple;
	bh=4fXJidtJ1viRWoLejQDAlo2yu6HUvAkBioeflUHtadY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zb26HLQ1+3DrmIMDAw1VW7pwCPVWHerMQhpOmxPUQwP5cL5e+oL1cslLrBAdNlolnsfORTx0pC0/h4BtdPMK+bZvehMotauFMxiiOMq8UZu6RPX27NedlmnOmSnAobbcj38wjfXxsGkl9EG+6lPajdzOCn4w/gNnsob3vW7x7bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFKxcvA2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23575C433F1
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 10:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709287307;
	bh=4fXJidtJ1viRWoLejQDAlo2yu6HUvAkBioeflUHtadY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NFKxcvA2kUGAKEa9DifNiPR6f+oqD2LxH+75c+UHCD23crQ2KwA/kXLyP7qukrxDO
	 uxap0Wbxrbf/CHqc1E9g35WmxflGc0ofE/3OBtYMVIQyJarqovYvYFSz1HiP/HAlFJ
	 sxQPVAt6B+PoPWQr+U9PhkKn1blUrDXJHry9BnIo48J53/d10LHXZKGtAE2EpX0JxQ
	 PCz/4pgelp0IPgedMe5XHqLOsQAtwXvQ/iXEQLqFHQK/RnSuZiUDk2brIvMFCYEggb
	 uTv7Yc2Fl9FlaJ9uULXSQPBJbj0zeItmpvdoWaWFJZJue9v5qot6k3QTAyBRqHoFCp
	 YEqTmeomoHUcg==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d208be133bso22014191fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 02:01:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXQJIq8UrNABXgKostvrnDXvoDS0Drt8rwdqCMVkRhGErbWVGwtqMKgaQ1+JABq4irJXWmJzTOEc96y68mj4vLHfmLGgxYGAet/sxhh
X-Gm-Message-State: AOJu0YxD0vmPxUkd4eIgzm6QxzLX71u4GaQXWqayHH9Ppj5ZUtSsVYdo
	3CKBDU51EN5KSEWowkVVce/hMZpgWtrj/oCxJeLQL9DU7mXni83/BBDn5hbwGCpwrQJ1M/w790p
	BusvDqpzOrU4LnClbSfYTe3Pnzhc=
X-Google-Smtp-Source: AGHT+IEsBk8htxOcNqJsInE7tNCxlgQwMT4i5o2BSdWpOD1AtPH5FaWENSZOXCfpTufUffsL1eq+dBmE3r23bH3bQzA=
X-Received: by 2002:a2e:a365:0:b0:2d2:39b2:90e2 with SMTP id
 i5-20020a2ea365000000b002d239b290e2mr800907ljn.14.1709287305357; Fri, 01 Mar
 2024 02:01:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227151907.387873-11-ardb+git@google.com> <20240227151907.387873-13-ardb+git@google.com>
 <20240228205540.GIZd-dzFYIBbtfIAo3@fat_crate.local>
In-Reply-To: <20240228205540.GIZd-dzFYIBbtfIAo3@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 1 Mar 2024 11:01:33 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGhZU+FE2gE262Q8_vZEFHicsRtVPzXT-dhhCvBuiMjUA@mail.gmail.com>
Message-ID: <CAMj1kXGhZU+FE2gE262Q8_vZEFHicsRtVPzXT-dhhCvBuiMjUA@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] x86/startup_64: Defer assignment of 5-level paging
 global variables
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Glaze <dionnaglaze@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 21:56, Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Feb 27, 2024 at 04:19:10PM +0100, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Assigning the 5-level paging related global variables from the earliest
> > C code using explicit references that use the 1:1 translation of memory
> > is unnecessary, as the startup code itself does not rely on them to
> > create the initial page tables, and this is all it should be doing. So
> > defer these assignments to the primary C entry code that executes via
> > the ordinary kernel virtual mapping.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/include/asm/pgtable_64_types.h |  2 +-
> >  arch/x86/kernel/head64.c                | 44 +++++++-------------
> >  2 files changed, 15 insertions(+), 31 deletions(-)
>
> Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
>
> Those should probably be tested on a 5level machine, just in case.
>

I have tested this myself on QEMU with -cpu qemu64,+la57 and -cpu host+kvm using
- EFI boot (OVMF)
- legacy BIOS boot (SeaBIOS)
- with and without no5lvl on the command line
- with and without CONFIG_X86_5LEVEL

The scenario that I have not managed to test is entering from EFI with
5 levels of paging enabled, and switching back to 4 levels (which
should work regardless of CONFIG_X86_5LEVEL). However, no firmware in
existence actually supports that today, and I am pretty sure that this
code has never been tested under those conditions to begin with. (OVMF
patches are under review atm to allow 5-level paging to be enabled in
the firmware)

I currently don't have access to real hardware with LA57 support so
any additional coverage there is highly appreciated (same for the last
patch in this series)

