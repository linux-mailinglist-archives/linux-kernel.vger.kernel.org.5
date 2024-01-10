Return-Path: <linux-kernel+bounces-22278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE3F829BC6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CDE11F226F2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3926495E9;
	Wed, 10 Jan 2024 13:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="r8yTPC0A"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6465D48CCC;
	Wed, 10 Jan 2024 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GX5bG0xRiBvxCnOZ5F88dbP2mNg6pTI/ZRvFLly5pvQ=; b=r8yTPC0A90DSc89HoQvul1RYFX
	Qy+qlIYTv+35x/SIpf5fa+UjJI34h41d9f/hnGFBuo1/GJJghpkcxdj/drTH/WKuI3/ZabKKBfSbq
	Wy3HD6CpcznTipMn+k62r8UdwNrFJhG0bB0ZnOBjnfDK+TMuFBNSp1vGIE6xu1SgrDzaZjyU2GrV/
	ZP5h+8tD6yjpFmAKXkvrtc+WnNyB15e0FUsPmX9P1Go+unuZteyt9QIS9s0BoB9yRd1svxZyCWp/P
	hwV0KqN7pMdj5H4nLOOpauQ+7XUeDRnz3maAv/a+fdGpyNEjVpGqZ5tKqcNz1umvIsVQhxhv0tyk7
	Lh5nGCIg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47362)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rNYyW-0005Th-2k;
	Wed, 10 Jan 2024 13:50:32 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rNYyZ-0005Mc-J9; Wed, 10 Jan 2024 13:50:35 +0000
Date: Wed, 10 Jan 2024 13:50:35 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Subject: Re: [0/2] ARM: Adjustments for init_atags_procfs()
Message-ID: <ZZ6gq5sOFf33GhM7@shell.armlinux.org.uk>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <562a6f99-3f8e-9a77-e519-b668e24dced2@web.de>
 <b3c42397-c879-4381-aa96-c7887e81c068@web.de>
 <7dd19987-6590-4756-a929-1ff01503ad1c@web.de>
 <ZZ6MZl14bcIaCaQn@shell.armlinux.org.uk>
 <1c38e495-5c9c-4ff8-b453-93b882dd2c4c@web.de>
 <ZZ6R6KSQo9ph3ARZ@shell.armlinux.org.uk>
 <09c4cb2e-967b-4d0e-b5c6-f959e80290d9@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09c4cb2e-967b-4d0e-b5c6-f959e80290d9@web.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 10, 2024 at 01:52:34PM +0100, Markus Elfring wrote:
> >>>>> Is this patch series still in review queues?
> >>>>
> >>>> See also:
> >>>> https://lore.kernel.org/cocci/562a6f99-3f8e-9a77-e519-b668e24dced2@web.de/
> >>>> https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00098.html
> >>>
> >>> I suspect no one looked at it, sorry.
> >>
> >> Special mailing list settings probably influenced this situation.
> 
> Did any communication filters hinder the clarification of further development ideas?

How about doing the research yourself? Using lore, it's possible to
work it out. Find the message id. Then visit

https://lore.kernel.org/r/<message-id>

and study the result. It will give you the answer you want.

> >>>                                       I don't catch everything that is
> >>> on the mailing list. Looks fine to me but it needs to end up in the
> >>> patch system to be applied.
> >>
> >> Can you collaborate also with mentioned mailing list archive interfaces?
> >
> > Err what? Sorry, I don't understand your comment.
> 
> Are you going to pick any patches up from linked information sources?

No. Did you read my first reply which told you how patches get applied
to arch/arm? If you didn't, your patch won't get applied.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

