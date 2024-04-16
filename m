Return-Path: <linux-kernel+bounces-147449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5855D8A745D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B746CB22565
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3DD137C40;
	Tue, 16 Apr 2024 19:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sPIRXzF3"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102F8137777;
	Tue, 16 Apr 2024 19:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713294455; cv=none; b=qc9wGeoJpB1GzqAsT64Bk2fWAnOjQma1uAWB8Ifpws9xVIj/mnYfVcQV6kp7RhkD2gPLeIM3Rx5qGOYhVc7BYKUVKZAB27qfvzpsEFyFQXIcdcdEMuUfRKGxActeW2MaHaiNK6Kx1mxiAcI5+r6zyd8A6gN9LxlWpPKcqEgDSzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713294455; c=relaxed/simple;
	bh=ems9QZLlep2st557YLybFshaQ5FUgwqMXggItWTV6is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIJEtrAk15vApsc5MuidHSn/HNEbxapuLctQ8iONce7bjaNE7LqEXlaP6MuL9XZ6NMVlj2Z7mSjvkVrUfscBAR4QZaEccKACwmRXIn1vLZHD/YMjTB9Voz0rgrqg36WItyz0nrMTH0C+RGHdKBLJFhFeTNnB1CznsHDMd+4iBuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sPIRXzF3; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ygHzA1bpfvI35ZNT4OQebLiK0lyMqaf0iWhJXfIEjKg=; b=sPIRXzF3V4QnwQqu9nU79e9K/9
	MbtR2y7VjYVeIgxOkWQzyRhE1reUVgmiStW3g8gg94IbnclYupV1F0RBrOqT8EQcoRZ/gdb/H/Jed
	tClBKxiVlCxER0jPacFQeAeEftz/FsfTT5+hk3QYj8Z1s7iKDoCBHPpcdzu0moJpsuStTNzamp2p/
	G/6bpjmEtdOPYoNuETGiToWbcRACtCmX0To9cUZ+yDLleMg9HNfEeTIzI4WV81OUWU+xT53gl8w45
	xZKLml/721yizxFRNCvFm9t+MqhKoXxDmWQijwg5TR9JxyG6OSD8woMNn/S/4uvNUv3tGUsFxR1k7
	peC9h2MQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55594)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rwo9O-0000tZ-0k;
	Tue, 16 Apr 2024 20:07:26 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rwo9N-00054M-NX; Tue, 16 Apr 2024 20:07:25 +0100
Date: Tue, 16 Apr 2024 20:07:25 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/5] net: dsa: vsc73xx: convert to PHYLINK
Message-ID: <Zh7MbebgzqbDTQWq@shell.armlinux.org.uk>
References: <20240416190055.3277007-1-paweldembicki@gmail.com>
 <20240416190055.3277007-3-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416190055.3277007-3-paweldembicki@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 16, 2024 at 09:00:52PM +0200, Pawel Dembicki wrote:
> This patch replaces the adjust_link api with the phylink apis that provide
> equivalent functionality.
> 
> The remaining functionality from the adjust_link is now covered in the
> phylink_mac_link_* and phylink_mac_config.

Please consider moving to the newer ds->phylink_mac_ops (you get to
provide the struct phylink_mac_ops structure.)

See the conversions that have recently gone into net-next.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

