Return-Path: <linux-kernel+bounces-76760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B72885FC21
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE321C24688
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654D4148FE3;
	Thu, 22 Feb 2024 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IzUMBQZ2"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0261353E2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615006; cv=none; b=d/5OycsVMfuEM8fHShb45iYcol+MVKKCIFZlwZdeln3oYwOKI6q8w1A4c5o8Gd0jVzEugOzr2783ayfrcQjhKfdBd/VbdiBsVBMWpseaPiz+U0uqDzX4xfjgdrN7fr8fli6Nl76ZIqRkEqI67AMntwZsiGY5s7FUDBtcQOC3lF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615006; c=relaxed/simple;
	bh=Z7eHFAuV9/liYOewnC++92wvjtNjwnFCobhJ2FxKxgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJCEMFFWMqcXge3sXp4DW70L1MsrxOp6MM+w7MsMN0xGcnOYyRLazjS7PV1nYMlr1Nqs5y+sLdqnxrvJaj+OxdLXsL7IQmzUBlH5Z6Ba+PXHEOITZ8nO9I+2LRupc0MfWBdw2fF6RJY/HwmNIEXYBjl6uPuV/0T/ok2FwdkWFmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IzUMBQZ2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9086E40E01FE;
	Thu, 22 Feb 2024 15:16:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ngw_AycNeCpI; Thu, 22 Feb 2024 15:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1708614992; bh=YrFzjKJrLxYvDyljetwJXFQTVG5nskDDTXZiFS2lmn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IzUMBQZ2ZkHHUyrjboMj9yCQQLBc93GeAwZM2aYlecDuziAPAY6bTwWWWkLQu2Pqq
	 k7vHE9U98MgOCH6lDCuh3IbZv52KzOR3QEddlkUYmPFfLmMxyH6XLjY8LeC6bhW7Ps
	 MJvPJqxO53O0RV9g1a7fGAuwVTSiYhyXLSzvgxLkzGhZbCNEKCyhud54bGhC9Mo1mT
	 r2BbhcO1LpTgGf4zMGMC6vq2i3CVywjzEXiWvfx+XdnGWAAVUsV7H0X5aKUjGTsiDW
	 R15Tlr5UFKRe7o201aplaQRrjoR2MX5TL34I4VsYBzjx1lJWHIVIQog9V1YmOBkReF
	 E0lheWbctP4EyLD17JXXcBXx6q6ntZK6pEaV53w+/zkpcyFU+ruws+c/+Ancy427xv
	 RhQAMV7nmuKjJ+fLC1lvoMvdXubOp9cMAwT5kSYRaREn04nuBd2koOJPFwFjTQYC3u
	 wAGJABIrmzMSo/tFJLgJPxi3jfci7c4ao3sro+lI/h4o2kj2w9rRYpTq2AplFqAWrX
	 78peKrpqwy+xNqcWKkWMfNq5VbQ2ukspsw/CopZ3qJvuVUPeMy+IDo6/QSqMPfaaa4
	 MAIDA8gk/HQ9jOxBcMi2tDdxL3BIVhzWbx8Mo0jlxXR8u54y2JvuwD97nOmkIhCxRq
	 4W5RqmkasJzldR38emNmHi/M=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3B9C340E01A0;
	Thu, 22 Feb 2024 15:16:23 +0000 (UTC)
Date: Thu, 22 Feb 2024 16:16:18 +0100
From: Borislav Petkov <bp@alien8.de>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: James Morse <james.morse@arm.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
	Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] x86/resctrl: Remove lockdep annotation that triggers
 false positive
Message-ID: <20240222151618.GEZddlQglVrHN9-n4q@fat_crate.local>
References: <20240221122306.633273-1-james.morse@arm.com>
 <67600176-d299-434f-94d1-d6e4f1a5b2b0@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67600176-d299-434f-94d1-d6e4f1a5b2b0@intel.com>

On Wed, Feb 21, 2024 at 08:48:24AM -0800, Reinette Chatre wrote:
> I agree with this change. Could you please base it on x86/cache
> branch of tip?

No need - whacked it into submission.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

