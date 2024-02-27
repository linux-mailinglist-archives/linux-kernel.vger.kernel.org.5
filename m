Return-Path: <linux-kernel+bounces-83027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F525868D7C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FDA21F26B09
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC28913849D;
	Tue, 27 Feb 2024 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="X3o4ZMum"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902FF137C42;
	Tue, 27 Feb 2024 10:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709029499; cv=none; b=jNE7IP8vw6XoYG9pOJFU1YUBIo87YAp6emEiIMtzj6tydS2OVG7zjzoRPUl5tHL9w3WvFAv7NSYU+YaEMTja+8hwH1m9HXSmEeMlWaMSPhOGJ0Nm5yukiJ6JQA7K1Qu0hHUzFYhNKCdRbPTscd88Lq9E0/p5vno5aKWpdn7vRz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709029499; c=relaxed/simple;
	bh=Nnpde2MjTfV728iSxOzMQcbJzt7c4u2O0FM7Rw5PJgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRSWtc9PXT+GYYiEzKldkpmdDjllIzR1EvzsAZQ20HpxRQXkkT97SHCSzOrSc0kuaKBBmunUExsGT8weKVXYZfLio9r9tLsKQZNCYWgNaNrKDLUpBhc36GcKAwb0LzgwdOy3HoLHIx+jc44JKnxDrLvJgImJwNhNGLGMsRIu69M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=X3o4ZMum; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JCdHzu2wkDIMV3N9KhEnaZn7nt+SUq/lt3fcc9JJLCM=; b=X3o4ZMumh+WSsbya++ZFhtGQtB
	3jMjGFRyAKDrQ6bMJQKbd5y2qsY7D3/VmDpfzHkMH6PakulAFqF4HNgsDc+owbvCfZ25CP4XYfCH8
	UI1Bniqs7Jl4UNl7QATUXCDQ4jt5ilvkda3mO8VTmuqAWYPbOZo1ZNyepxPTNnIe0Hn8zYSQ1TKht
	bIHEJ2YbLwz0NAk4PA2pJ8O6+fUsmTVV+IlhQK6S+xBqMUsrvHTTA032uvVTQJ9WktNmcvAj3bs18
	X05XBlfCFGcbmJCi8KFVH92pbunbs7dz9v//Po5GYryvsw2rE6JPZ2AUOoV+6jgR8tKVzoKMDTHe2
	k+PD2pug==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36722)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1reudi-0007kH-1R;
	Tue, 27 Feb 2024 10:24:46 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1reudc-0007J2-Nc; Tue, 27 Feb 2024 10:24:40 +0000
Date: Tue, 27 Feb 2024 10:24:40 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Zev Weiss <zev@bewilderbeest.net>
Cc: linux-parisc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Helge Deller <deller@gmx.de>, Florent Revest <revest@chromium.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Yin Fengwei <fengwei.yin@intel.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Yang Shi <yang@os.amperecomputing.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Oleg Nesterov <oleg@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Stefan Roesch <shr@devkernel.io>,
	Josh Triplett <josh@joshtriplett.org>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org, Sam James <sam@gentoo.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND 1/2] prctl: Generalize PR_SET_MDWE support check
 to be per-arch
Message-ID: <Zd24aCps4xD28c74@shell.armlinux.org.uk>
References: <20240227013546.15769-4-zev@bewilderbeest.net>
 <20240227013546.15769-5-zev@bewilderbeest.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227013546.15769-5-zev@bewilderbeest.net>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 26, 2024 at 05:35:41PM -0800, Zev Weiss wrote:
> There exist systems other than PARISC where MDWE may not be feasible
> to support; rather than cluttering up the generic code with additional
> arch-specific logic let's add a generic function for checking MDWE
> support and allow each arch to override it as needed.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> Cc: <stable@vger.kernel.org> # v6.3+

PA-RISC folk need to ack/review-by this patch. Alternatively, it needs
to be restructured to add the arch_memory_deny_write_exec_supported()
override without touching the PA-RISC code, which then makes the Arm
patch independent of the status of the PA-RISC patch. That will allow
the Arm issue to be solved even if an ack is not forthcoming for the
PA-RISC parts.

Alternatively, I wonder whether akpm would be willing to pick up this
patch set as-is.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

