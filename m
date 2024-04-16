Return-Path: <linux-kernel+bounces-146605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691098A67E9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A32E1C203A3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F73126F02;
	Tue, 16 Apr 2024 10:12:05 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1745985280
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262325; cv=none; b=Nbvhe1JD2cjIROVp/dwMAyIy8ls6rI+gpvrQNtyU4ndFF9JkQdMLRs6mZPhLYoEQhHkB7xbYRqV6e8DWYyetUMTXdNqyXqC3VAhtMTxL8+xU/6cyPgcnxe4PIt4Ie7WyGPGdwXrmF5H9jbIwBxRTbivf6MEvJKkVcXaqrt+/KPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262325; c=relaxed/simple;
	bh=uciQa9NlLIukC8sJKCILTRFZbXwk4eeGjKahnO5Dh7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwynjrT7mqD4REO+PSv0E/s8YANdKKT0XTkwlIHoq4hOZ07bmkGmxeMxdp1GfvG0zW4mI9yrXYItqrC7P06WQUU8JvkcD+YjqTAhxx1mpi+M+FhxwmOBs96YYgKNQ7hCeu/wkos5T+3He5lsCfIpRdPJsOrWm1R4QP9QbUYmqG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B9E6740E02A5;
	Tue, 16 Apr 2024 10:12:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xok-7l0TsIx3; Tue, 16 Apr 2024 10:11:57 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AD59140E0177;
	Tue, 16 Apr 2024 10:11:48 +0000 (UTC)
Date: Tue, 16 Apr 2024 12:11:47 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com
Subject: Re: [PATCH v1 1/1] x86/fred: Fix int80 emulation for FRED
Message-ID: <20240416101147.GDZh5O473e4X_ZG1lZ@fat_crate.local>
References: <20240412234058.1106744-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240412234058.1106744-1-xin@zytor.com>

On Fri, Apr 12, 2024 at 04:40:58PM -0700, Xin Li (Intel) wrote:
> Commit 55617fb991df

Use the full commit abbreviation when mentioning commits:

"Commit

  55617fb991df ("x86/entry: Do not allow external 0x80 interrupts")

.."

> added a bunch of tests to the int $0x80 path,

Added a bunch of tests?

What does that even mean?

> however they are unnecessary and event wrong in fact under FRED.

Are the bunch of tests wrong or is do_int80_emulation() simply the wrong
handler to use on a FRED?

> First FRED distinguishes external interrupts from software interrupts,
> thus int80_emulation() should NEVER be called for handling an external
> interrupt, and then int80_is_external() should be skipped under FRED.
> 
> Second, the FRED kernel entry handler NEVER dispatches INTx, which is
> of event type EVENT_TYPE_SWINT, so the user mode checking in
> do_int80_emulation() is redundant, and should be skipped.
> 
> It might be even better to strip down do_int80_emulation() to a lean
> fred_int80_emulation(), not to mention int80_emulation() does a
> CLEAR_BRANCH_HISTORY.

Yah, how about you do a FRED-specific INT80 handler instead of
sprinkling moar tests around? fred_intx() looks like the right place to
stuff it in...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

