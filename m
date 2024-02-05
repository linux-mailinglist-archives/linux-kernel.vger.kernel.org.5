Return-Path: <linux-kernel+bounces-52367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 916A0849732
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D8C728A5DD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF8E13FF2;
	Mon,  5 Feb 2024 10:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lNdwvt5O"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2423134AF;
	Mon,  5 Feb 2024 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127230; cv=none; b=OjeHRQWzrLl4MvCiZlrKz04ZUxBfLuJ0xXw9OflwdZSzRQVZzt3ZId0or1Q1ECavkP+mLmxFFfJdPaBHw3YqgcbBUsz/9f9UAqFpVRmYfw4ir9vC5prlttLVieKt1z/x6cZmsFcFENyDGuzh40bOc6eybjqWKBSr8ciBui5q6hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127230; c=relaxed/simple;
	bh=Cr/yrTL+3LqkmxZ8T5EnNgADnSMoayQdEMynTCrmG7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIr39YDiM3wvtF8CBjTddD372FMez42k8SDl2Rpx+uqi9qNB0r1LQgtj0KmyqxshNbrRrhbfIbWRsEO90tN4ORsC0qf7D2mJtoulWC//qrvrun9Uh91lyOHjVTHoYwu55HodyQyqA9J3xls2fKz8a4ujiHl0HNAHG3ourpW/UFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=lNdwvt5O; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=s0hoRfGIvTGHgneayWfi5kk6Ut6Vdy9Hd25mPOPqEXY=; b=lNdwvt5ORnapXlLrXwXC0cEbRx
	CuQXfZ+LW7Wq3MUBwK/NIWomquSJLeE1DWdh2k3dmdzcSXLJO3lRSTnmqxv9BPu/gvEPOrO7Fh9Es
	cPrVBA5Di2KOsNdls+mVh/hY+2AkiEhgwWGPJMvhdG2TPEwNv/vLAaFvxIVwYT3mHfSNOW7uHY2Yh
	gW0uq2TH/pub2i9bkSAz/3343ee7xbT7JwTsjcxipTNrEfEG49w7NDd+243vavX0Zr3K7Ec8BqKMO
	CFldWJYDOu8Ter0RTZDU9bEgKvjktPFWZ5nHX5xLp7QldaudUoGGNNr3uShcwFupLagZ+a7iKVtj2
	7TMF6z4Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54440)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rWvlh-0000LB-0T;
	Mon, 05 Feb 2024 10:00:01 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rWvlZ-0002bl-QE; Mon, 05 Feb 2024 09:59:53 +0000
Date: Mon, 5 Feb 2024 09:59:53 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: arinc.unal@arinc9.com
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v4 2/7] net: dsa: mt7530: move XTAL check to
 mt7530_setup()
Message-ID: <ZcCxmUwxfmKIXh/U@shell.armlinux.org.uk>
References: <20240204-for-netnext-mt7530-improvements-2-v4-0-02bf0abaadb8@arinc9.com>
 <20240204-for-netnext-mt7530-improvements-2-v4-2-02bf0abaadb8@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240204-for-netnext-mt7530-improvements-2-v4-2-02bf0abaadb8@arinc9.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Feb 04, 2024 at 07:34:20PM +0300, Arınç ÜNAL via B4 Relay wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> The crystal frequency concerns the switch core. The frequency should be
> checked when the switch is being set up so the driver can reject the
> unsupported hardware earlier and without requiring port 6 to be used.
> 
> Move it to mt7530_setup(). Drop the unnecessary function printing.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

