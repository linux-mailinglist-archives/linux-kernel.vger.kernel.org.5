Return-Path: <linux-kernel+bounces-161188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4910A8B4823
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 22:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5FE1C20C4E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 20:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D63145B29;
	Sat, 27 Apr 2024 20:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="l6MH/6rX"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28F83BB47;
	Sat, 27 Apr 2024 20:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714251504; cv=none; b=EvILNKLym4Ic67WGOMGwlLI4gdgbNsQDeZ+vDM8qdba+cABOb+X/57XcfJyp+fzB+/NuOb1YHHQNjJGyOS+VoQ8x1PfEwk+TGWxaN2h63hKfkpr6rT3KKgdzWnGOibYgQcw5lXaO0jpyLhObX/j4fiD6dsjgFKX5BsJFk7MQF8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714251504; c=relaxed/simple;
	bh=12E5+m8WVS7UFjCvrrWn7Mcwu6k2ZqsOWomh6iStPTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmFcb36gvqw2h3N0XJxrXqa33fgzICuQuua0jYrCj9Xvoi//DkHSCfrn0XfevI2tPp26EZhc3h8s/KuzM+uQ8Hi4rTFuJc6gijFzHepZJDKxoEh7QbOv5bsJ6bp4hNXi9nQfyT2C158h6W81STza549viNfPAWv9L1HKOeUpBF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=l6MH/6rX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=O/bTlpjmn7jvv06zXkXwL7+2GnLGg8WPp/qSEgcnySE=; b=l6
	MH/6rX/78seSbNTNrk2jUqdjFOLStFuJIIeupkVy4LvoA6VsFf0E3QsBkGCw72GAT+CkaxZe6nHPO
	BvFx0PPphMg0J90YCYePpgzULbvASU3EDrHfMjAc9sUOXEdZ/lpR1TWOZE/Aw2BtdNJjnfKLCWzsh
	4vjXDOUvDyZcHLw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s0p7X-00E9zz-Q3; Sat, 27 Apr 2024 22:58:07 +0200
Date: Sat, 27 Apr 2024 22:58:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
Cc: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 11/12] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
Message-ID: <50b7cb69-61c0-45a2-9a48-4160b2d1e24c@lunn.ch>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-12-Parthiban.Veerasooran@microchip.com>
 <Zi1Tang5RQMmEFdx@builder>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zi1Tang5RQMmEFdx@builder>

On Sat, Apr 27, 2024 at 09:35:06PM +0200, Ramón Nordin Rodriguez wrote:
> I'm running a dual lan8650 setup, neither IC passed the sw reset in the
> oa_tc.c module, I need to pull the reset pin low to reset the pin before
> the rest of the init stuff happens.
> 
> The datasheet recommends not doing a sw reset, excerpt from section
> 4.1.1.3 Software Reset
> "Note: The SW_RESET bit of the Clause 22 Basic Control register will reset only the internal PHY, not
> the entire device. This PHY only reset is not recommended for use. If such a reset is detected, by
> reading the RESETC bit of the STS2 register, reset the entire device."

That is not so good. The PHY driver does not know the PHY is embedded
within another device. It has no idea of RESETC bit in STS2. Looking
at the phy driver, i don't actually seeing it using
genphy_soft_reset(). Do you see a code path where this could actually
be an issue?

Supporting a hardware reset does however make sense. It would be best
if you submitted a proper clean patch. It can be added to the end of
this series, keeping you as author.

     Andrew

