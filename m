Return-Path: <linux-kernel+bounces-80044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D41BB862A15
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 12:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1E1E1C20A29
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 11:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E323411CBD;
	Sun, 25 Feb 2024 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="l+2cG0eC"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C23111A5
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708860626; cv=none; b=LW+Of0xwdjABB9lsaLpwZQFdvy1wLVnc7O/1Zpa5EBj/f5yGiD+MJ+DpX9zUjmtCBhn74OJH/iIMozUyGs4MpJnheDIG3ZrfFqF0DMmZTgYCy/0MtA0/10Rd8iNq6F9wFur8RGS0SOluON1Rc6qvcyAfaCRv7qsyLmlK2P3oUTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708860626; c=relaxed/simple;
	bh=/xhhzunZeW2E/b9YwIG08hTdPnhqX7PSbgEphPPhxRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQ5EUt0NwB+zeQPEvh5ErT4nmQ4sJOn6YIlbtoSgBuoraweQrKOtkwJWH2BL4UJPySS5gOREBkAvM46ykcRdEu0hqd7T4PooLHTEdoUa1NEdFka8hGUDuaDUKshku9MROGLy5YR7jg5lyLvp4oIaD4dYVc/BXyHz691cKb+QGU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=l+2cG0eC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bYxMMiE4FxpR5QIfmjWAFYNoP9WedyUYCLwwFOmpEME=; b=l+2cG0eCh6zUb//f9bSuB7XWKp
	FMtEOZDvDMUn5afSp6ZYOHIk87le8gqqe9t0aZLyka2iq9uaiN5/b0cNzQVOZsZQVJdWsPRvFgsOr
	CUt1byhq3c4c8fvxEwQr/jojnkJSUl0tRmowfhYeozrh08ahy17NLC/ZNdHYjrLcDaPPLVd12H84N
	VfkcLDnJdF7HP6kLOrvgzwLQ2Bf2O0EZg3lzmWd28pJNeIydFDVjc5VOluvTX+scjwIuTxJIpeRbP
	4rigVFnJCJVvfLInVQEkSHs3D56cAty8t2aRLkATGD+bhRN5JSOU4aMOznP3tHb+wNJFUFhDt2wBQ
	cQ0jtPjg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57072)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1reCi4-0007N0-1y;
	Sun, 25 Feb 2024 11:30:20 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1reCi3-0005TI-9L; Sun, 25 Feb 2024 11:30:19 +0000
Date: Sun, 25 Feb 2024 11:30:19 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com
Subject: Re: [PATCH] ARM: mvebu: Add check in coherency.c to prevent null
 pointer dereference
Message-ID: <Zdsky9nVdwP6Ry0E@shell.armlinux.org.uk>
References: <20240225060450.53044-1-duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225060450.53044-1-duoming@zju.edu.cn>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Feb 25, 2024 at 02:04:50PM +0800, Duoming Zhou wrote:
> The kzalloc() in armada_375_380_coherency_init() will return
> null if the physical memory has run out. As a result, if we
> dereference the property pointer, the null pointer dereference
> bug will happen.
> 
> This patch adds a check to avoid null pointer dereference.

Again, what if kstrdup() fails?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

