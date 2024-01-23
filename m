Return-Path: <linux-kernel+bounces-35747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC73839621
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB273B2971F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E5181ACB;
	Tue, 23 Jan 2024 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kbHw1rxN"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B6A612EA;
	Tue, 23 Jan 2024 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706029414; cv=none; b=fpiIF5NJ02VNM4axULYwR/HF011k9AMc+3ia+OpVUOAEkaG0K24hrcTHQtfZmIhN02hIwaHFZhBegQOBLH2M8eY+FySS+IBfNuNn82wpnWq4kiSp+dRti1A4RpLvQ1w2TB0MDk2okJRodKLwLdKnYY29f73MIssU7bWFH5+i0Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706029414; c=relaxed/simple;
	bh=dhaOXh2GARZDksXJshb21yrfg6+IcvSAugnOcnHVtsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+uykh5dg0yslRK1Rgeg6vTqc5G81UhfqqPS77WtHRmfDz++U75B8OHFcZIgRJJpamu+KZa4izOaZeJg4Yb/6moM7J22QMiA+GtIBclLy2ylOxwSpOeZr2HtdgjPuc82UgwZ+x6qDRUridLR1QqzJfbzhP2B/WKk/5jnB694j3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=kbHw1rxN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1SkQg56/BLG4/1gwWBP97+wWCTrDFDMYyBkjnUU6eAM=; b=kbHw1rxNwZD0RUbN1KLduWBFOH
	QfRT+1+QLjl7qiXmjE8EWQV5U9//1aT5fTd9Aeun5lKEXRhLzIZkukxJwfrLtdzRG2YNbQxqGbbnc
	OL9e74QhywozebmNd60jF7+iTMRHoFtyX+/kCaHSF/cZFTQRDdroBVVWRk6uAKusvT0giAvYdc3ZK
	2piRoSVSWzZuJTZINc7kHjc9Y5QWceDBVinR9YITIXvQltSJ72k+oRPUeyDvSXdYmtofsZG0LAoDM
	1JE8d6NhZwEKAepZVlf5393+S90bWL1P1Z0FyKmM/fwB7PKPtZRbed8/wnTHR3Tvv0TmVdSb3HUXK
	2fBz7clw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53244)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rSKBD-0002nw-0t;
	Tue, 23 Jan 2024 17:03:19 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rSKBA-00026M-Ao; Tue, 23 Jan 2024 17:03:16 +0000
Date: Tue, 23 Jan 2024 17:03:16 +0000
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
Subject: Re: [RFC PATCH net-next 1/9] ethtool: Add ethtool operation to write
 to a transceiver module EEPROM
Message-ID: <Za/xVHkfF0fV84ax@shell.armlinux.org.uk>
References: <20240122084530.32451-1-danieller@nvidia.com>
 <20240122084530.32451-2-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122084530.32451-2-danieller@nvidia.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 22, 2024 at 10:45:22AM +0200, Danielle Ratson wrote:
>  /**
> - * struct ethtool_module_eeprom - EEPROM dump from specified page
> - * @offset: Offset within the specified EEPROM page to begin read, in bytes.
> - * @length: Number of bytes to read.
> - * @page: Page number to read from.
> - * @bank: Page bank number to read from, if applicable by EEPROM spec.
> + * struct ethtool_module_eeprom - plug-in module EEPROM read / write parameters
> + * @offset: Offset within the specified page, in bytes.
> + * @length: Number of bytes to read / write.
> + * @page: Page number.
> + * @bank: Bank number, if supported by EEPROM spec.

I suppose I should have reviewed the addition of this (I can't recall
whether I got the original or not.)

If one looks at SFF-8472, then the first 128 bytes of the EEPROM at
0x50 (0xA0 on the wire) are not paged. Whereas bytes 128..255 are the
paged bytes. Therefore, "offset within the specified page" can sensibly
be interpreted as referring to the EEPROM at 0x50, at an offset of
128 + offset.

Meanwhile, the actual implementation doesn't do that - the offset is
the offset from the beginning of the EEPROM, and offsets >= 128 access
the paged area.

What this means is that the parameter description here is basically
wrong, both before and after your change.

This really ought to be fixed so that we describe things correctly
rather than misleading people who read documentation. Otherwise, it's
a recipe for broken implementations... and it's also completely
pointless documenting it if the documentation is wrong.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

