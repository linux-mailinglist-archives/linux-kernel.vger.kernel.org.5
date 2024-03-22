Return-Path: <linux-kernel+bounces-112003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 127DE887401
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DAFDB228FB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6F57EF0C;
	Fri, 22 Mar 2024 19:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ckpGz2m1"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3805C745C0;
	Fri, 22 Mar 2024 19:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711136849; cv=none; b=DtwwojI1uD4v8f3DKgrr35s76zJC/Ao2HXP0Cs+dAw634ASWSEIan2EUpaserULDf8TabkWWjhGzdfqBo5hPelr4esiMfReMjdreumWdnVk9dBajeICEiA3AZs8pgUZyZU9tc5l8edKdfnO9ePMIwsDQmUDDHHwGvnTPxfr8feg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711136849; c=relaxed/simple;
	bh=nxEGXVhNhN4RVfE3d1n+2+C+HEvgFuhkK+1tNpRSEbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoBldVl8oLJHSJy8zzlgj89x/5P1TibY5V2be6nfn4P8RmTt2dcUTd8orsDAygizjO3ZB6rkikbbUSgjDIfnfbel8+R8PZnouSWamnu9veFcPrcvErjFmjLxqzlO5TxLR0dzXvnv5sjGlUQP1wCcrsY6NDqB4D1Bi4fW4lsdk+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ckpGz2m1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9257640E01B5;
	Fri, 22 Mar 2024 19:47:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kApiESXmhvFM; Fri, 22 Mar 2024 19:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711136839; bh=DmmHov9qZK91tSR+f8HXIJGfm9hhKvVNviRTerX3QXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ckpGz2m1aGeUUEDfnOnKk9xVdwdmhnREG+tzE5h8RE7AfMrFLNlH8UrsEgn3tJsWw
	 fwHwEDhhLhMClv7vG/qKyFfIkAj9ywkLmCo9EtW74crm+v/Su7Q2aiVOdTLki0e13J
	 rD37/jrKQKcQhccrjftN3UaozrDvndrCkf1MVmHmBtsuVtTcZjKSTopfG8m59coe/8
	 fviSpb614HLGADaxdL8UNAfMQGeZ4Us5XO30RnkrH5mRO4Fbpnhg3leKvlVQCynmBq
	 PBWjsyv0yQ3U49VWA/KoD1Xm9nInT6eYoCLpeY3HhpgOniBH8thYfd537GpzefKz9P
	 ritHXTamlK42Zj4g3JB5gnuGA0oyKwKSORrQ7ZR0jSjERcD1ABzTT3jTYlCB5tFn7v
	 oz/Mm1eSu511R0eO3TA4qAQjevxtDXIQAA9S0lzt153p9Le8SEmua6MDsP/Jx0Xtc0
	 HBhEkxAuiYoywM446zI2Aimu6lYj2x92lrfm3Lyxn71emU55NuVvOaaEK08GltA1cN
	 zNrHbN/oDiKz6PE8/KsWr0f34JXlgW2lRyVd19krBGdUDBrGGIY435NPP84Lv/pOmv
	 wWa0MXIsFqi/ELXTRXAFXCDF2KL2umRKCi45DGWJlSmf1cZtYqsR64HI6DG22ULa/a
	 wAxDiyGY+fVZpW/FlVazaCcs=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1637840E00B2;
	Fri, 22 Mar 2024 19:47:05 +0000 (UTC)
Date: Fri, 22 Mar 2024 20:46:58 +0100
From: Borislav Petkov <bp@alien8.de>
To: Kees Cook <keescook@chromium.org>
Cc: tglx@linutronix.de, Guixiong Wei <weiguixiong@bytedance.com>,
	jgross@suse.com, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, peterz@infradead.org,
	gregkh@linuxfoundation.org, tony.luck@intel.com,
	adobriyan@gmail.com, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86, relocs: Ignore relocations in .notes section on
 walk_relocs
Message-ID: <20240322194658.GCZf3gMphnWeR9upN6@fat_crate.local>
References: <20240317150547.24910-1-weiguixiong@bytedance.com>
 <171079804927.224083.15609364452504732018.b4-ty@chromium.org>
 <20240318215612.GDZfi4fG52DTgra51p@fat_crate.local>
 <202403181644.690285D3@keescook>
 <20240319081640.GAZflJ6IBQ7TEKD2Ll@fat_crate.local>
 <202403190955.25E5E03E6@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202403190955.25E5E03E6@keescook>

On Tue, Mar 19, 2024 at 09:56:29AM -0700, Kees Cook wrote:
> > Yes, please. Just send a Reviewed-by and it'll get picked up.
> 
> Okay, thanks!

Dammit, how did this commit land upstream and in stable?!

Forgot to zap it from your tree and sent the branch to Linus anyway?

Kees, please refrain from taking tip patches in the future. You know how
this works - get_maintainers.pl.

Thx.

Date: Fri, 22 Mar 2024 14:47:05 -0400
From: Sasha Levin <sashal@kernel.org>
To: stable-commits@vger.kernel.org, keescook@chromium.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Patch "x86, relocs: Ignore relocations in .notes section" has been
 added to the 5.4-stable tree
X-Mailer: git-send-email 2.43.0
Message-ID: <20240322184705.144463-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8

This is a note to let you know that I've just added the patch titled

    x86, relocs: Ignore relocations in .notes section

to the 5.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     x86-relocs-ignore-relocations-in-.notes-section.patch
and it can be found in the queue-5.4 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.



commit 91aa857ccbd1212a23cd80bb45f71715f2db7144
Author: Kees Cook <keescook@chromium.org>
Date:   Tue Feb 27 09:51:12 2024 -0800

    x86, relocs: Ignore relocations in .notes section
    
    [ Upstream commit aaa8736370db1a78f0e8434344a484f9fd20be3b ]
    
    When building with CONFIG_XEN_PV=y, .text symbols are emitted into
    the .notes section so that Xen can find the "startup_xen" entry point.
    This information is used prior to booting the kernel, so relocations
    are not useful. In fact, performing relocations against the .notes
    section means that the KASLR base is exposed since /sys/kernel/notes
    is world-readable.
    
    To avoid leaking the KASLR base without breaking unprivileged tools that
    are expecting to read /sys/kernel/notes, skip performing relocations in
    the .notes section. The values readable in .notes are then identical to
    those found in System.map.
    
    Reported-by: Guixiong Wei <guixiongwei@gmail.com>
    Closes: https://lore.kernel.org/all/20240218073501.54555-1-guixiongwei@gmail.com/
    Fixes: 5ead97c84fa7 ("xen: Core Xen implementation")
    Fixes: da1a679cde9b ("Add /sys/kernel/notes")
    Reviewed-by: Juergen Gross <jgross@suse.com>
    Signed-off-by: Kees Cook <keescook@chromium.org>
    Signed-off-by: Sasha Levin <sashal@kernel.org>

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 1c3a1962cade6..0043fd374a62f 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -596,6 +596,14 @@ static void print_absolute_relocs(void)
 		if (!(sec_applies->shdr.sh_flags & SHF_ALLOC)) {
 			continue;
 		}
+		/*
+		 * Do not perform relocations in .notes section; any
+		 * values there are meant for pre-boot consumption (e.g.
+		 * startup_xen).
+		 */
+		if (sec_applies->shdr.sh_type == SHT_NOTE) {
+			continue;
+		}
 		sh_symtab  = sec_symtab->symtab;
 		sym_strtab = sec_symtab->link->strtab;
 		for (j = 0; j < sec->shdr.sh_size/sizeof(Elf_Rel); j++) {

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

