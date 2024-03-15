Return-Path: <linux-kernel+bounces-104865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B9887D4BE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61B431F23930
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BF6535AC;
	Fri, 15 Mar 2024 19:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2xO+QGqi"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE74E3FE47;
	Fri, 15 Mar 2024 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532724; cv=none; b=MEH0XXfsTOvOjwyRcpAXPWzGzl1XZVKnt78iBEq4ejEX2Ppcb7OmzyqQQtPjndQSaA2daHLM9DEP+b/vHHrRfgUJWH7w+fupmx7qPIozPt1unask5TcY24mNjchc1FWNVyCT1K7vviUWyrcmTdC1NKF9dbEURfqwyxl1Pg+NIF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532724; c=relaxed/simple;
	bh=TyvTJlrdAAuGmmcuB/EIOle32T69JrYAz10IOCgKsLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=di7AyIa8TjX0KRjEU+/wy0O8Axf+NTMQA/aFb92EZR5WSYpVsoHQ0N7elpYTKmwD/jat8lID1w+JrKuIvjz+pBqCM/sV3e5YO38OLs6gJiBa2T8S8Hi+XD3hQGkTCSxA52ty+GLQA2vg4PtQxqcJhy2RRqs0sOKQ0z0MiWw+Gng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2xO+QGqi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Rqtbjt3fJBNggHowmsiPoGTRmzCIpbMVhefVPjvplDI=; b=2x
	O+QGqiWPztQ7GssezZGIz6Hr7iaqATLbgezBDo6A0rGxqcT23P5Dxenc+dIAjmWGsq4cQmX/PzqwN
	/IGiHvtdqk+K9q6qqiclC7xhRuOkrYV3VSWiSn7eEVQOL6bwptJz4TQLXL4ufFqzaQxk4aRv0iFDX
	2pmcNHm7p6BOVe8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rlDh5-00ARnd-D0; Fri, 15 Mar 2024 20:58:19 +0100
Date: Fri, 15 Mar 2024 20:58:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?UGF3ZcWC?= Owoc <frut3k7@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robimarko@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: aquantia: add support for AQR114C PHY
 ID
Message-ID: <d2135526-6ecc-4dab-9329-412ef2747bcb@lunn.ch>
References: <20240315080657.3460084-1-frut3k7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240315080657.3460084-1-frut3k7@gmail.com>

On Fri, Mar 15, 2024 at 09:06:50AM +0100, Paweł Owoc wrote:
> Add support for AQR114C PHY ID. This PHY advertise 10G speed
> but supports only up to 5G speed.

net-next is closed at the moment. Please repost when it opens.

Additionally, please could you extend the commit message to explain
how this patch actually deals with it advertising 10G when it should
not.

	Andrew

