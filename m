Return-Path: <linux-kernel+bounces-74622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049BC85D708
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3593F1C22F08
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA8E44370;
	Wed, 21 Feb 2024 11:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BvhbJ+w6"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DE03FE55;
	Wed, 21 Feb 2024 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515127; cv=none; b=JJU8DmXxXq0nTVQIkNcdqVohfMhAzzjcn+eq5wjjkiwGyMxm4TsM4PkDuDfX+axJobi3RRrs1acLERyh/poYKVTwBYRCpa603jOmIMORqrZPXyIWEfmlEzjPvQhPdTAA3itGvT5xc3F3zO5GoxjdAEkqjxN26Rw4qPbP+zBj65k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515127; c=relaxed/simple;
	bh=2vQ7vlhzmuOpvRxH2q2WDDbEcUnb5ASVR8RfPI4m8cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzAqQMyGp1VbhICJEacrCSFAICbgt4m3UA1zzaaCJR15h8/Q2g4jLWxL1cbArF21RykZozx+ubruGBxh7M4mKINdD81fT5lWx54yMaX9tK523bMqZ+UFOaZgEnB809J0eYi1TM57CW3bC6YpCWzmkRSYGQ91ETnLz/oQGuSBZCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BvhbJ+w6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=d+OFRDIV9Nlg2bppUbu0OXRvhKCsCUZDp0Ctdslt6f8=; b=BvhbJ+w61L06gXoy4EXkFwRqhr
	wyp2o/ldxD6GZ2YqiGezIcDwrWAuDxkWQX5UPANNT1Z0aIACFHyr0JAVm8lUK6kgId01vx9HaIRgt
	X2ItKd4ojLxHUSXYThkxiITklFTNtDAfI7S/sTXCJ7LRtZdAf6SPqArpxBv8I3So2oZOFW8fxNfuG
	oFRWuBIa2/rL0RHvhMBfy61ERWENEwrPkefNtYknrZtqwaHgNeNn/v8APhofsuAgBuXE7/INoj0Uf
	vcOJvnagO7f87hAkw0g+54rBVTFpFIeG3m6QJLyyS4yuCEo2RP9ZaOnfewD1uxm1OvkI3t3BLsPiA
	WAQVgxxg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37210)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rckpU-0006ou-1v;
	Wed, 21 Feb 2024 11:32:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rckpT-0001k0-DN; Wed, 21 Feb 2024 11:31:59 +0000
Date: Wed, 21 Feb 2024 11:31:59 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kees Cook <keescook@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Wang Kefeng <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Hutchings <ben@decadent.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ARM: fault: Implement copy_from_kernel_nofault_allowed()
Message-ID: <ZdXfL8Kp4R/OT/VA@shell.armlinux.org.uk>
References: <20240123011238.work.301-kees@kernel.org>
 <202402202235.A77C9AD@keescook>
 <ZdXeopPukQGXUqoz@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdXeopPukQGXUqoz@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 21, 2024 at 11:29:38AM +0000, Russell King (Oracle) wrote:
> On Tue, Feb 20, 2024 at 10:39:15PM -0800, Kees Cook wrote:
> > On Mon, Jan 22, 2024 at 05:12:38PM -0800, Kees Cook wrote:
> > > Under PAN emulation when dumping backtraces from things like the
> > > LKDTM EXEC_USERSPACE test[1], a double fault (which would hang a CPU)
> > > would happen because of dump_instr() attempting to read a userspace
> > > address. Make sure copy_from_kernel_nofault() does not attempt this
> > > any more.
> > > 
> > > Reported-by: Mark Brown <broonie@kernel.org>
> > > Link: https://lore.kernel.org/all/202401181125.D48DCB4C@keescook/ [1]
> > > Suggested-by: "Russell King (Oracle)" <linux@armlinux.org.uk>
> > > Cc: Russell King <linux@armlinux.org.uk>
> > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > Cc: Wang Kefeng <wangkefeng.wang@huawei.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Ben Hutchings <ben@decadent.org.uk>
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > 
> > Russell, do you mind if I carry in my tree the 3 ARM patches I sent?
> > They're mostly pretty trivial, and they've been in "Incoming"[1] for 2
> > weeks but haven't shown up in -next yet. I'd really like them to get
> > some soak time, and for them to reach the v6.9 merge window in time.
> 
> They can't show up in -next at the moment because the machine that hosts
> my git tree is being moved between data centres. This was originally
> flagged as a same-day (Tuesday) move, then next day, then it'll be back
> online on Saturday. That's the last update that we've had.
> 
> As I don't believe my GPG key has the necessary signatures on, I don't
> believe I can get a kernel.org account. I'm not even sure whether my
> gpg key is even correct for that - and at the moment I just glaze over
> reading the kernel.org gpg documentation.

I'll also point out that over the last two weeks, the first week I was
in Cambridge attending a conference at Arm Ltd, and then I went down
with full blown flu shortly there-after.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

