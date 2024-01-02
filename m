Return-Path: <linux-kernel+bounces-14303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B864E821B19
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C20D3B21E3F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483ECEAEA;
	Tue,  2 Jan 2024 11:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1JKJjvI3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E54EAD3;
	Tue,  2 Jan 2024 11:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=005zFironasLHcBtc+bj7hLY49N3H45GpbKUOXLX/qw=; b=1JKJjvI3SjSAL/bI9J5FteoT9I
	F9sjuXU+WbthqFMfYRnOctc/r9THWJQilY85PBSKZjMsk5K/AG62lwdmt7tHXY2eijEQWzjlG8l3P
	4pivQyLTBjiG78u54pOk2i/DcXO1XhAdozn+cV+pVebk0xgv/zW+4fvJkdalLyJ/HECtPFRqUO0eW
	vajpZ2H/xS+yJUg1trBwthbiP/O8Gd+uMivsckbavb2TeiEgYSzEZRu3mYsZRII6dPEITPXU3909J
	P7PlFYvPLyUNdxKrCCxU3yUR7m5ZwCsMfU0zRLNnaRIfprTSWZ60hIfuZmDgWcP/sE2Ss/j5dvaIN
	iHzgSFRQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37572)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKd6n-0006UK-0p;
	Tue, 02 Jan 2024 11:38:57 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKd6p-0005F7-NS; Tue, 02 Jan 2024 11:38:59 +0000
Date: Tue, 2 Jan 2024 11:38:59 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	wens@csie.org, samuel@sholland.org, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: Re: [PATCH v5 1/3] phy: handle optional regulator for PHY
Message-ID: <ZZP10wqfHFD72e9s@shell.armlinux.org.uk>
References: <20231220203537.83479-1-jernej.skrabec@gmail.com>
 <20231220203537.83479-2-jernej.skrabec@gmail.com>
 <f729baa5-7986-4841-8cd6-fc4bdc652f75@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f729baa5-7986-4841-8cd6-fc4bdc652f75@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 21, 2023 at 10:06:50AM +0100, Andrew Lunn wrote:
> I've not used regulators much, but i think you can combine these two
> into one. Its guaranteed *consumer is NULL if reg_cnt == 0. And
> kfree() is happy with a NULL pointer.

kfree(NULL) is valid (and is a no-op.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

