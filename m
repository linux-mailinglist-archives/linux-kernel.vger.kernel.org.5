Return-Path: <linux-kernel+bounces-22181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6BE829A92
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D58671C24799
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3105D481A6;
	Wed, 10 Jan 2024 12:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Hiutukme"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E5347F7B;
	Wed, 10 Jan 2024 12:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kTy81ad9pKvtG9ddZ38Ph0EzVsfouY5XMECMPqCF5ZQ=; b=HiutukmeGHcFQXD7yqG1H/8syS
	TscaDe5jgVUGUAcam3tly4Cnmr+g+DfNvWh690STzoXL+eygLzGgoSDUssm+LfAw5zVEKoowUUU0E
	xg917ouaRSv3XyYmGggxggwLCKr5QBVKe0xnUHyOQ3CdAC8CRYJ/UePsEnI7Xfps8x28kCA+kwsXs
	T8WZSCz29kxh3yXb/kOE9KjJ9ZF4sqF5ALi6f/BmQ9RkwcCSecf+cKoF7cwiJbdjahvTGQAM8Aekc
	yxrixBLKL4K5+KC4RKojB7hSxifDQZVpdIvUlXrr0VRokXwymm2naFrNf2S44yV+INcDePolYuSqA
	Y1sZXzAA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46746)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rNXzZ-0005Pc-1Y;
	Wed, 10 Jan 2024 12:47:33 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rNXzc-0005Jz-8s; Wed, 10 Jan 2024 12:47:36 +0000
Date: Wed, 10 Jan 2024 12:47:36 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Subject: Re: [0/2] ARM: Adjustments for init_atags_procfs()
Message-ID: <ZZ6R6KSQo9ph3ARZ@shell.armlinux.org.uk>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <562a6f99-3f8e-9a77-e519-b668e24dced2@web.de>
 <b3c42397-c879-4381-aa96-c7887e81c068@web.de>
 <7dd19987-6590-4756-a929-1ff01503ad1c@web.de>
 <ZZ6MZl14bcIaCaQn@shell.armlinux.org.uk>
 <1c38e495-5c9c-4ff8-b453-93b882dd2c4c@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c38e495-5c9c-4ff8-b453-93b882dd2c4c@web.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 10, 2024 at 01:44:01PM +0100, Markus Elfring wrote:
> >>> Is this patch series still in review queues?
> >>
> >> See also:
> >> https://lore.kernel.org/cocci/562a6f99-3f8e-9a77-e519-b668e24dced2@web.de/
> >> https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00098.html
> >
> > I suspect no one looked at it, sorry.
> 
> Special mailing list settings probably influenced this situation.
> 
> >                                       I don't catch everything that is
> > on the mailing list. Looks fine to me but it needs to end up in the
> > patch system to be applied.
> 
> Can you collaborate also with mentioned mailing list archive interfaces?

Err what? Sorry, I don't understand your comment.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

