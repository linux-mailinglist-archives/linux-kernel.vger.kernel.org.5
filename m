Return-Path: <linux-kernel+bounces-31917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD69B833656
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 22:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8480528237C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 21:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045DF14007;
	Sat, 20 Jan 2024 21:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NchmfWpK"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B2011727;
	Sat, 20 Jan 2024 21:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705785357; cv=none; b=oIVw+UWZJBWP7GYm1BECPsOcY4MCtLiKT1idrN2Icg1Kj0vqPQVTNzYf7VsnrjJashWpNUgR/6ojh0qG6aKQDGF2So5ChzbizIcxb0AHSaUPUamtKkGUOOvAllqLwZVDc79ywXK4sxiqOlHabU6YhUd45bS0dm0Js33Ad4SYR5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705785357; c=relaxed/simple;
	bh=1g9bksCDLYBlnBEy5X9csgQBfOXwcWCj0kAH011US04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkhCMr2oiJ8gjr3qtCIT9z3PBKkfESR+Z0Owo63NlE0XaJRxjo2wKSIuBgsUvcKCFSnXTk5lTgHLNxWfEbsnTwotCW7ymc/dOjZk6YjnuCKGb8k/NPBzQwADf5REA5qkB4gyDgaWv+foglacvY2J/aPKwkhbRsqVWrWu9nKnmmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NchmfWpK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1aBK0Gktyu8z+XAOtZwM9ibKmLTWPXmi9JXFn46Moag=; b=NchmfWpKV8qW4oGh0F1Qvj2C/6
	/9LiX34B1wlpHtipYkfPNQ+3G4sxN+nN75vc36dqQqjNMWNyQa5wFbXiDuuJCw81FAOfCSys3cLbS
	IooU5FuZdHsgy/cCTasUw23eGZLHi8rqM87NA8xNGA8TZZ5t8ap1so2ig5rH24oATjRzXeNBH9G8b
	ES6a95oRMX+OMy2zD9vQRKPlkHHSsMPeqUmu5H/RRAiTRt7YRBqjFrwcrblJ1oMA3AphMu0iwndBx
	qYPvgpL249fguGP08RS7rSdcLn8m1HFKMQRGIg7MzbGLKydZ2bOvJvLHRY4wKgtirPXoSsCPXUNrl
	VswDM4wg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40226)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rRIgD-0007pB-1l;
	Sat, 20 Jan 2024 21:15:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rRIg9-0007ya-3x; Sat, 20 Jan 2024 21:15:01 +0000
Date: Sat, 20 Jan 2024 21:15:01 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: patchwork-bot+linux-riscv@kernel.org
Cc: Suren Baghdasaryan <surenb@google.com>, linux-riscv@lists.infradead.org,
	akpm@linux-foundation.org, willy@infradead.org, will@kernel.org,
	catalin.marinas@arm.com, palmer@dabbelt.com, mpe@ellerman.id.au,
	christophe.leroy@csgroup.eu, agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com, dave.hansen@linux.intel.com,
	luto@kernel.org, peterz@infradead.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arch/mm/fault: fix major fault accounting when
 retrying under per-VMA lock
Message-ID: <Zaw31DVa9q3JZASo@shell.armlinux.org.uk>
References: <20231226214610.109282-1-surenb@google.com>
 <170578498755.24348.16166096320323933297.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170578498755.24348.16166096320323933297.git-patchwork-notify@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Jan 20, 2024 at 09:09:47PM +0000, patchwork-bot+linux-riscv@kernel.org wrote:
> Hello:
> 
> This patch was applied to riscv/linux.git (fixes)
> by Andrew Morton <akpm@linux-foundation.org>:
> 
> On Tue, 26 Dec 2023 13:46:10 -0800 you wrote:
> > A test [1] in Android test suite started failing after [2] was merged.
> > It turns out that after handling a major fault under per-VMA lock, the
> > process major fault counter does not register that fault as major.
> > Before [2] read faults would be done under mmap_lock, in which case
> > FAULT_FLAG_TRIED flag is set before retrying. That in turn causes
> > mm_account_fault() to account the fault as major once retry completes.
> > With per-VMA locks we often retry because a fault can't be handled
> > without locking the whole mm using mmap_lock. Therefore such retries
> > do not set FAULT_FLAG_TRIED flag. This logic does not work after [2]
> > because we can now handle read major faults under per-VMA lock and
> > upon retry the fact there was a major fault gets lost. Fix this by
> > setting FAULT_FLAG_TRIED after retrying under per-VMA lock if
> > VM_FAULT_MAJOR was returned. Ideally we would use an additional
> > VM_FAULT bit to indicate the reason for the retry (could not handle
> > under per-VMA lock vs other reason) but this simpler solution seems
> > to work, so keeping it simple.
> > 
> > [...]
> 
> Here is the summary with links:
>   - [1/1] arch/mm/fault: fix major fault accounting when retrying under per-VMA lock
>     https://git.kernel.org/riscv/c/46e714c729c8
> 
> You are awesome, thank you!

Now that 32-bit ARM has support for the per-VMA lock, does that also
need to be patched?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

