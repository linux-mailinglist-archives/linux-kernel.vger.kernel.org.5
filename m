Return-Path: <linux-kernel+bounces-14487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D79F821DC9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D8D283887
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76DE11CB8;
	Tue,  2 Jan 2024 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lfgaEX2s"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5EE11718;
	Tue,  2 Jan 2024 14:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=48D5ez891FudRMbUkCpyIcvWPCkUK4OLFoyn+5uchAY=; b=lfgaEX2seQe9mVXAoSTI4GKqlq
	MRrU9EAevBhXJQpQoP7OaiygAKM0NvD9dpIY843iS9DOMA3cu5eYpt7DRJp6E2c2LUnB240Gnsq4F
	JR0bJB8PqfeiUzHohSMhoWgK2x46EdK9TRKAWSZLAXmnHeRYg/9vg+9DDvtG/5BZg0XM7S5etDhuv
	TCDqERzbmrNv70uHW63W2wuxMN3zxskRF499ZgPC0sfEjWskKdAf6DsQVAR3JDVsZxUXRMNR2AVDE
	pztgBmJtZv7Eke3AapFRbq5ZfpTrIlk2M9kUqLMFyq4OMQAteDbOMeeoXMb+dxwiP6eRSVqM4s1oQ
	d3tSNxzQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46986)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKftK-0006co-0x;
	Tue, 02 Jan 2024 14:37:14 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKftL-0005NH-O5; Tue, 02 Jan 2024 14:37:15 +0000
Date: Tue, 2 Jan 2024 14:37:15 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Jie Luo <quic_luoj@quicinc.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>, andrew@lunn.ch,
	hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] net: phy: at803x: add QCA8084 ethernet phy support
Message-ID: <ZZQfm98HrjRdXJEq@shell.armlinux.org.uk>
References: <20231109101618.009efb45@fedora>
 <0898312d-4796-c142-6401-c9d802d19ff4@quicinc.com>
 <46d61a29-96bf-868b-22b9-a31e48576803@quicinc.com>
 <20231110103328.0bc3d28f@fedora>
 <3dd470a9-257e-e2c7-c71a-0c216cf7db88@quicinc.com>
 <20231111225441.vpcosrowzcudb5jg@skbuf>
 <39a8341f-04df-4eba-9cc2-433e9e6a798e@quicinc.com>
 <20231112235852.k36lpxw66nt7wh2e@skbuf>
 <ZVInvOqh6QAvNJtw@shell.armlinux.org.uk>
 <20231113195120.44k6hhth7y53df53@skbuf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113195120.44k6hhth7y53df53@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Nov 13, 2023 at 09:51:20PM +0200, Vladimir Oltean wrote:
> On Mon, Nov 13, 2023 at 01:42:20PM +0000, Russell King (Oracle) wrote:
> > On Mon, Nov 13, 2023 at 01:58:52AM +0200, Vladimir Oltean wrote:
> > > From 17fd68123d78f39a971f800de6da66522f71dc71 Mon Sep 17 00:00:00 2001
> > > From: Vladimir Oltean <vladimir.oltean@nxp.com>
> > > Date: Tue, 3 Oct 2023 22:16:25 +0300
> > > Subject: [PATCH 1/2] net: phylink: move phylink_pcs_neg_mode() to phylink.c
> > > 
> > > Russell points out that there is no user of phylink_pcs_neg_mode()
> > > outside of phylink.c, nor is there planned to be any, so we can just
> > > move it there.
> > 
> > Looks familiar...
> > 
> > http://git.armlinux.org.uk/cgit/linux-arm.git/commit/?h=net-queue&id=c2aa9d3846c218d28a8a3457b0447998b0d84c5d
> 
> Well, yeah, I did mention that the patch was written at your suggestion,
> and there aren't that many options in which that patch can be written.
> I didn't look at your trees, and I made that change as part of a much
> larger effort which involves phylink, which I will email you separately
> about.
> 
> I will gladly drop my ownership on the first patch and ask Luo Jie to
> pick your version instead, if this is what you're implying from the 2
> word reply.

The reason that I hadn't submitted it was because I didn't want to move
the function out of the header file until the next LTS was released.

It seems 6.6 was announced as a LTS on the 17th November, so I'm happier
to now proceed with moving this into phylink.c.

as phylink_pcs_neg_mode() was merged in 6.5-rc1, it will have had three
kernel cycles - including one each side of the LTS release which I think
is reasonable.

I will send my patch hopefully sometime this week so it's in 6.8
depending on pressures.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

