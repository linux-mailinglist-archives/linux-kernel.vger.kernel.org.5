Return-Path: <linux-kernel+bounces-35756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E810839605
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D2D91C283A2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88BE8003F;
	Tue, 23 Jan 2024 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wgYAY9fY"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315A27FBDE;
	Tue, 23 Jan 2024 17:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706029785; cv=none; b=W/DxjJEPu8x58FE9b7Qp300bMdhWKyN2hMPS5htjTL7hYpl2aPIuMgXX6TOqkQAOQ/aX8q8npaZfdQ0/DgOxaQC2TsAuhQcZQlc0TA/O4mlOImAk5ud3egWEqF6G1EyZannBrc1Z3X+uFtpPE+neJm3oWMnWvaRBswBGWYwvKKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706029785; c=relaxed/simple;
	bh=f9UIkkGmIWiROu5ZoBTFMAujbrRQ5tAje4pYEsO7wuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7FN0Wp7BlDsPbE0TPKQfuwryEEJug//8ODLdPugJHZz49bbi34vVutiSlYprQ5JsDxN/aJCad+5rswxTvmuULhxR2tJKbfsl/igJjH+GULjZZwjBvvqtotN0+/84rYcfg8k7X0WBj1F3T7n1TiWsVhhfKGH6y2YqkgvDRoHRHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wgYAY9fY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KxYGaRQ9BTEt7m6CX0rx1QWJ078+bbqv0JtUBpFz0ig=; b=wgYAY9fYZRzWZTuR5+OGw7/HWR
	ikAmCEJlHMmc0SOXFTJFa9IS8b8kxgOf3yVf8xu/9wkqqKX+tBWhx6i2SK7tSBqgZL68TC21N3KC4
	8Hp6L2orv96i+AAzQhuiZ87ayTkvpNGWhnUBt7R/uxbYSNIUUy/XI3P0zDeUyDx5cyjOhzQaKh4v1
	rpMUIxWG1CsvUH62fWfoU8/E19SaNa9ra2R5NtcueELM28nGsA2W306KCpCMPPrHhFF4ErfNPfGN6
	fHlpjSJZV58KpbVB4tAEBltD4oc8bP3o0u83nSXl/E/Gyn0W3gwap5FPdCmTiKxLIInnPAoZj9URf
	fFjqdeqw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55506)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rSKHJ-0002op-1F;
	Tue, 23 Jan 2024 17:09:37 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rSKHI-00027L-2P; Tue, 23 Jan 2024 17:09:36 +0000
Date: Tue, 23 Jan 2024 17:09:35 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, sdf@google.com,
	kory.maincent@bootlin.com, maxime.chevallier@bootlin.com,
	vladimir.oltean@nxp.com, przemyslaw.kitszel@intel.com,
	ahmed.zaki@intel.com, richardcochran@gmail.com, shayagr@amazon.com,
	paul.greenwalt@intel.com, jiri@resnulli.us,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	mlxsw@nvidia.com, petrm@nvidia.com, idosch@nvidia.com
Subject: Re: [RFC PATCH net-next 6/9] net: sfp: Add more extended compliance
 codes
Message-ID: <Za/yz7xcZORpZnuY@shell.armlinux.org.uk>
References: <20240122084530.32451-1-danieller@nvidia.com>
 <20240122084530.32451-7-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122084530.32451-7-danieller@nvidia.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 22, 2024 at 10:45:27AM +0200, Danielle Ratson wrote:
> SFF-8024 is used to define various constants re-used in several SFF
> SFP-related specifications.
> 
> Add SFF-8024 extended compliance code definitions for CMIS compliant
> modules and use them in the next patch to determine the firmware flashing
> work.
> 
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

