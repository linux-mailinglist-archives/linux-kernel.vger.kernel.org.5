Return-Path: <linux-kernel+bounces-102616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA2387B499
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D3B285E1C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EEA5D729;
	Wed, 13 Mar 2024 22:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sk+VCr55"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2435B698;
	Wed, 13 Mar 2024 22:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710370168; cv=none; b=NGvEnXEU/kXMjJsuTlRZUYmab5tGpL8Xz8S8pr/S4BRfFS/XlqhA6jg/FFlzsVJcRjC9twTNl/Scq89WCZFne6A09gPgPdkcczu0GafVieitHVeZR1hJIrmqwDzecsDkAADmjEN4XApCcbuYiVSr7Ji6kt560JpUuxXlW9YyNyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710370168; c=relaxed/simple;
	bh=nek76MaUd8CRieyJYFUDcAswrStRcG9fu+1l2HVMdP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYfnfs00KJh2WyRGwC2bava4K30lFzap4N33Z4+hPi66AB4fHUUhh+aw3D9IAHpFNaRTEiQtDqlx3+ldBADAGEdUBvQQcDkpY6c1vhg8krI5QE3Tzb+cawnc0RSZNjNuxBzqTCE3vD7VfFiXR4m0xP2bLp3mSTKIhC+rOXfeHxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sk+VCr55; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kYJ36KwNuXIC2GGEAAYTQQ0oqxpqcrzztRKyJVrIE0Q=; b=sk+VCr555q40ixk8RZjak6MGdB
	xNSbxmXeiNdfD4M9K81A5l7erbg5g8sowpdIf9UuYLa9YNiqDslHqEDwHEwd0bCfMmb9zGgM9psBZ
	VCWcxKuney282w/+oPe0NP8r+p7VTHEiWzLu7Y4NMtrviQ7O/UqIHx6+c8WxnU1PHYf45AcfRm4X/
	NHnh/1feE4w2U1waB2Ccsj3esWPg+jJJLAm+qz7rTgmJK7aKNczFfDH3L3Ctqh9FsiMctSXehBVxB
	JsSr3LJXt9gXVIkom7RJ8/awSlLnjP6BUs8Vqz8XZqcLl0CqxJwJiFoEmjyETiuHsUAB3N+K0YdOy
	RKQhzI1g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34448)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rkXPQ-0008G0-12;
	Wed, 13 Mar 2024 22:49:16 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rkXPK-0004rD-PW; Wed, 13 Mar 2024 22:49:10 +0000
Date: Wed, 13 Mar 2024 22:49:10 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	paulmck@kernel.org, mingo@kernel.org, tglx@linutronix.de,
	rcu@vger.kernel.org, neeraj.upadhyay@amd.com, urezki@gmail.com,
	qiang.zhang1211@gmail.com, frederic@kernel.org,
	bigeasy@linutronix.de, chenzhongjin@huawei.com,
	yangjihong1@huawei.com, rostedt@goodmis.org,
	Justin Chen <justin.chen@broadcom.com>
Subject: Re: Unexplained long boot delays [Was Re: [GIT PULL] RCU changes for
 v6.9]
Message-ID: <ZfItZs756Bps2pFa@shell.armlinux.org.uk>
References: <ZetHwrCb0KXE0xFI@tardis>
 <4274be61-60bd-4e1e-9c16-26e6e5e06f65@gmail.com>
 <ZfDEIs63EBIYBJIC@boqun-archlinux>
 <c5f9c640-4c06-495e-9c7e-0c208b914fa7@gmail.com>
 <CAHk-=wgP=9JxdOJ5oYtVO5yM6pFi5+3FPxfCQa4ezpagJuXq3g@mail.gmail.com>
 <ZfDptafiK0jns050@boqun-archlinux>
 <CAEXW_YRvz8xf-6hpwpYqS=YNa-xkn4CsuJzELJxOH_2FP+6ptQ@mail.gmail.com>
 <2fb110ed-ba04-4320-9ef0-8766c9df5578@gmail.com>
 <ZfIh33YAYkLaDeAS@shell.armlinux.org.uk>
 <533151c9-afb5-453b-8014-9fbe7c3b26c2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <533151c9-afb5-453b-8014-9fbe7c3b26c2@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 13, 2024 at 03:04:26PM -0700, Florian Fainelli wrote:
> On 3/13/24 14:59, Russell King (Oracle) wrote:
> > On Wed, Mar 13, 2024 at 02:30:43PM -0700, Florian Fainelli wrote:
> > > I will try to provide multiple answers for the sake of everyone having the
> > > same context. Responding to Linus' specifically and his suggestion to use
> > > "initcall_debug", this is what it gave me:
> > > 
> > > [    6.970669] ata1: SATA link down (SStatus 0 SControl 300)
> > > [  166.136366] probe of unimac-mdio-0:01 returned 0 after 159216218 usecs
> > > [  166.142931] unimac-mdio unimac-mdio.0: Broadcom UniMAC MDIO bus
> > > [  166.148900] probe of unimac-mdio.0 returned 0 after 159243553 usecs
> > > [  166.155820] probe of f0480000.ethernet returned 0 after 159258794 usecs
> > > [  166.166427] ehci-brcm f0b00300.ehci_v2: EHCI Host Controller
> > > 
> > > Also got another occurrence happening resuming from suspend to DRAM with:
> > > 
> > > [   22.570667] brcmstb-dpfe 9932000.dpfe-cpu: PM: calling
> > > platform_pm_resume+0x0/0x54 @ 1574, parent: rdb
> > > [  181.643809] brcmstb-dpfe 9932000.dpfe-cpu: PM:
> > > platform_pm_resume+0x0/0x54 returned 0 after 159073134 usecs
> > > 
> > > and also with the PCIe root complex driver:
> > > 
> > > [   18.266279] brcm-pcie f0460000.pcie: PM: calling
> > > brcm_pcie_resume_noirq+0x0/0x164 @ 1597, parent: platform
> > > [  177.457219] brcm-pcie f0460000.pcie: clkreq-mode set to default
> > > [  177.457225] brcm-pcie f0460000.pcie: link up, 2.5 GT/s PCIe x1 (!SSC)
> > > [  177.457231] brcm-pcie f0460000.pcie: PM: brcm_pcie_resume_noirq+0x0/0x164
> > > returned 0 after 159190939 usecs
> > > [  177.457257] pcieport 0000:00:00.0: PM: calling
> > > pci_pm_resume_noirq+0x0/0x160 @ 33, parent: pci0000:00
> > > 
> > > Surprisingly those drivers are consistently reproducing the failures I am
> > > seeing so at least this gave me a clue as to where the problem is.
> > > 
> > > There were no changes to drivers/net/ethernet/broadcom/genet/, the two
> > > changes done to drivers/net/mdio/mdio-bcm-unimac.c are correct, especially
> > > the read_poll_timeout() conversion is correct, we properly break out of the
> > > loop. The initial delay looked like a good culprit for a little while, but
> > > it is not used on the affected platforms because instead we provide a
> > > callback and we have an interrupt to signal the completion of a MDIO
> > > operation, therefore unimac_mdio_poll() is not used at all. Finally
> > > drivers/memory/brcmstb_dpfe.c also received a single change which is not
> > > functional here (.remove function change do return void).
> > > 
> > > I went back to a manual bisection and this time I believe that I have a more
> > > plausible candidate with:
> > > 
> > > 7ee988770326fca440472200c3eb58935fe712f6 ("timers: Implement the
> > > hierarchical pull model")
> > 
> > I haven't understood the code there yet, and how it would interact with
> > arch code, but one thing that immediately jumps out to me is this:
> > 
> > "    As long as a CPU is busy it expires both local and global timers. When a
> >      CPU goes idle it arms for the first expiring local timer."
> > 
> > So are local timers "armed" when they are enqueued while the cpu is
> > "busy" during initialisation, and will they expire, and will that
> > expiry be delivered in a timely manner?
> > 
> > If not, this commit is basically broken, and would be the cause of the
> > issue you are seeing. For the mdio case, we're talking about 2ms
> > polling. For the dpfe case, it looks like we're talking about 1ms
> > sleeps. I'm guessing that these end up being local timers.
> > 
> > Looking at pcie-brcmstb, there's a 100ms msleep(), and then a polling
> > for link up every 5ms - if the link was down and we msleep(5) I wonder
> > if that's triggering the same issue.
> > 
> > Why that would manifest itself on 32-bit but not 64-bit Arm, I can't
> > say. I would imagine that the same hardware timer driver is being used
> > (may be worth checking DT.) The same should be true for the interrupt
> > driver as well. There's been no changes in that code.
> 
> I just had it happen with ARM64 I was plagued by:
> 
> https://lore.kernel.org/lkml/87wmqrjg8n.fsf@somnus/T/
> 
> and my earlier bisections somehow did not have ARM64 fail, so I thought it
> was immune but it fails with about the same failure rate as ARM 32-bit.

Okay, so if that's two architectures failing, it's probably not an
architecture specific issue. It could still be a timer/interrupt driver
issue though. It would be nice to have a reproducer on x86 which would
confirm it.

Do you know the frequency that the failure happens?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

