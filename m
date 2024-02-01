Return-Path: <linux-kernel+bounces-48230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E398458DC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2FDE1F23D92
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF07753370;
	Thu,  1 Feb 2024 13:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yf5YCI+q"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3624286621
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793954; cv=none; b=VBdro13rvNvPwJbAvKUXtPVehaK8OtuGxZqa7XCH9RDWmNn8Ga0JhpL1x/q9iFmYAvtb3GJeGyyp+GtazLkFgTCgqFA0WafMSFNdwuVzmL/J/a6llQsPru69zOL0AWd63//qLj/Ffy6UY6Nym+a1ja8r4eeuMypXJuGzWaob7bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793954; c=relaxed/simple;
	bh=oQjRzK2plHqhTt+Chgslw8wHs1sZ8/+vslBzoxSXcw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utBXUtWaZmicBOIaPvel3aJgaSl6Y37pRT9G+RGVV9TCzcrKXt/l9aQ7IOMxssb/FoPIrJ/TuKZUe90iJx7+tl0IIM0jQ3L6xR+nhVsTkXo00FvHdlsBL6EXwPBC0vnPV7hpTqZZn3H9dQWerS/Szs/pGlaujM8il03qROlqCtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=yf5YCI+q; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2gMbDmm684tBY5OyDAXTn0bRzW55WFT0smq6dzUb1vg=; b=yf5YCI+q0lUEQdT/EOZhEqJ9ZI
	xIwEEbJ3Rhj8ayiB9mjOyplXozQOSmm92hNNQOrBt+krAD/Ubly1Fo049WSTnSe/gZQQjo3BCiwaM
	afoIrAnCRgtDYuCCNxeEOT1EC0XKZlSqtbEXaDuPPXnUBeVK0l83BR+CKm3StOE2ygxgW0Gd7OP1Y
	24C57Suv09U/QP+AmO54+mXusCzJLhkKlcZlWdw5SvnyVyyskLhN7aNU3y7uKuOg918nVgCmB3BaW
	1VvLImejcbolEsgo1/1/hrT8/TMOvQ7OWhBkSCkWhgcX8mE/DzdlTXXZnNLgyGuyaWF9fYNJUptLw
	nwamv4gw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41894)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rVWvJ-0004ax-11;
	Thu, 01 Feb 2024 13:16:09 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rVWvH-0007PU-0R; Thu, 01 Feb 2024 13:16:07 +0000
Date: Thu, 1 Feb 2024 13:16:06 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] arm: topology: Fix missing clock-frequency
 property warning
Message-ID: <ZbuZlok+8ZkxGBq7@shell.armlinux.org.uk>
References: <20240201123605.3037829-2-stefan.wiehler@nokia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201123605.3037829-2-stefan.wiehler@nokia.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Sorry, I was going to reply to this, but having composed the reply,
and attempting to add the DT maintainers, mutt decided to completely
obliterate the To: line.

Please check with the DT maintainers what the expected behaviour is
supposed to be.

On Thu, Feb 01, 2024 at 01:36:06PM +0100, Stefan Wiehler wrote:
> The devicetree specification in section 3.8 however specifies that
> "properties that have identical values across cpu nodes may be placed in
> the /cpus node instead.

Does this mean the /cpus property is like a default for when a CPU node
doesn't specify the clock frequency, or does it mean that the /cpus
property should only exist when all the values for each CPU are
identical and thus the individual CPU node clock frequency should
not be specified.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

