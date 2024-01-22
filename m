Return-Path: <linux-kernel+bounces-33838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EBB836F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17CB2294305
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D48966B56;
	Mon, 22 Jan 2024 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GxcCDIxd"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A66B66B50;
	Mon, 22 Jan 2024 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945056; cv=none; b=InSuGj+sut7AB6e3+oqh7dHsAVJtIco/4MeUg/7HmLS2IPgyFYRBtcTrlZLrfp3LVSqhcS6Oxn+xAIUVQWBWIE+m7pjU0jRe/HBRAsAJHwiuy1GE1QPMzGf+qEo1XRI0RCIjyQyO8xJLoooNNObEwayx0/amNCxk6Lr/jkNjd40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945056; c=relaxed/simple;
	bh=8WYz4IV5sJnk5aen6jbAq+q3NiEqFAzxRle76P/6Bcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHEUgjEpNrcwO2M4nSU0PXdsHvawUl8PF2rt599eW0kBLAmpmp/EB6JbKdoUzf+vdGyCBNXFc+MeLNgssLZCy89vN88LncP5E0AvxVRFtOfC8ZcJw+xgTOxyO9nm5E7I2XEJ3qXwcXWXsdJeNDJ3hV8CAASyi7YsGmbUvY7D7rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=GxcCDIxd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Tpq99Xn3oyUQ1UeFUe2J523sJUHds2quY0PBRgIFX08=; b=GxcCDIxdcwixCbMs9SgULyWG0E
	wCMQM9VlMDAwLQxTgpHTEnRfE7msH3WejKCDAHDyw87vHsUC+aNXNRD5jNUUHo0qapTZA38hZrvJZ
	53K0QFJlwd5MNlRh0P8e6SnP37AmP2XpUWXxNWqzhwcI/X3UQ95Ykmav1x5+PGmO4et3HnLPPxJ0m
	Ovo2XLa+Jaq5M5MgSObj3Z+PHWiB4+DorhpvG0pA59gH/tQGUs3xQUfmp57dswHCfYH54aZiBnGwQ
	aGo7q/CvW8kcAt7Ga7nDj7uHEPQQsZl1YGmuv0vUAqKgOCyJXWhLwIOjPfq76ejYFSQo4GqGevKVU
	rqsU1+RQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56168)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rRyEA-0001Ho-0p;
	Mon, 22 Jan 2024 17:36:54 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rRyE0-0001CD-Mi; Mon, 22 Jan 2024 17:36:44 +0000
Date: Mon, 22 Jan 2024 17:36:44 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Lei Wei <quic_leiwei@quicinc.com>
Cc: Luo Jie <quic_luoj@quicinc.com>, agross@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, corbet@lwn.net, catalin.marinas@arm.com,
	will@kernel.org, p.zabel@pengutronix.de, shannon.nelson@amd.com,
	anthony.l.nguyen@intel.com, jasowang@redhat.com,
	brett.creeley@amd.com, rrameshbabu@nvidia.com,
	joshua.a.hay@intel.com, arnd@arndb.de, geert+renesas@glider.be,
	neil.armstrong@linaro.org, dmitry.baryshkov@linaro.org,
	nfraprado@collabora.com, m.szyprowski@samsung.com, u-kumar1@ti.com,
	jacob.e.keller@intel.com, andrew@lunn.ch, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ryazanov.s.a@gmail.com,
	ansuelsmth@gmail.com, quic_kkumarcs@quicinc.com,
	quic_suruchia@quicinc.com, quic_soni@quicinc.com,
	quic_pavir@quicinc.com, quic_souravp@quicinc.com,
	quic_linchen@quicinc.com
Subject: Re: [PATCH net-next 18/20] net: ethernet: qualcomm: Add PPE MAC
 support for phylink
Message-ID: <Za6nrICG8gjwTsJ9@shell.armlinux.org.uk>
References: <20240110114033.32575-1-quic_luoj@quicinc.com>
 <20240110114033.32575-19-quic_luoj@quicinc.com>
 <ZZ6LGiSde4hHM+6j@shell.armlinux.org.uk>
 <fc9c3e08-a83c-4748-89e4-8b7b0c62da7f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc9c3e08-a83c-4748-89e4-8b7b0c62da7f@quicinc.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 22, 2024 at 11:01:26PM +0800, Lei Wei wrote:
> 
> 
> On 1/10/2024 8:18 PM, Russell King (Oracle) wrote:
> > On Wed, Jan 10, 2024 at 07:40:30PM +0800, Luo Jie wrote:
> > > @@ -352,6 +1230,12 @@ static int ppe_port_maxframe_set(struct ppe_device *ppe_dev,
> > >   }
> > >   static struct ppe_device_ops qcom_ppe_ops = {
> > > +	.phylink_setup = ppe_phylink_setup,
> > > +	.phylink_destroy = ppe_phylink_destroy,
> > > +	.phylink_mac_config = ppe_phylink_mac_config,
> > > +	.phylink_mac_link_up = ppe_phylink_mac_link_up,
> > > +	.phylink_mac_link_down = ppe_phylink_mac_link_down,
> > > +	.phylink_mac_select_pcs = ppe_phylink_mac_select_pcs,
> > >   	.set_maxframe = ppe_port_maxframe_set,
> > >   };
> > 
> > Why this extra layer of abstraction? If you need separate phylink
> > operations, why not implement separate phylink_mac_ops structures?
> > 
> 
> This PPE driver will serve as the base driver for higher level drivers
> such as the ethernet DMA (EDMA) driver and the DSA switch driver.

Why not have the higher level drivers provide a pointer to the
appropriate phylink_mac_ops structure? Having extra levels of
indirection makes my future maintenance of phylink harder (I'm already
bugged by DSA doing this, and it's a right pain.)

For example, if one of your higher level drivers needs the mac_prepare
or mac_finish functionality, you have to add a shim, extra function
pointers and so on.

If I need to add an extra parameter to a method, then I have to fix
up your shim layer _as well_ as all the called methods - in other
words, it adds extra maintenance burden.

It also makes detecting whether an implementation provides something
or not harder - see the problems when mac_select_pcs() was introduced
and rather than testing to see whether the method is populated, we
have to call the method with a dummy value to discover whether the
sub-driver implements it or not. Honestly, I would really like to get
rid of DSA's phylink_mac_ops shim layer.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

