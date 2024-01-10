Return-Path: <linux-kernel+bounces-22167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B7F829A60
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E831C2830FE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732A4482DB;
	Wed, 10 Jan 2024 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="h0MMH/Mw"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009A7481D3;
	Wed, 10 Jan 2024 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6zaUbzon+LKBw1mx9bT5De1CYLBfQjxA8lhARZ9YPs4=; b=h0MMH/MwEkxUg/3rCnAhtNdkqr
	VcNyOvjR4v8i1DR7w9SO/kXUrMllbasUTIAUe1nROOMC6bJMxKkLj1nVp2IyHm+IXQ1FixFpPogtw
	rO0H1KUKSWcvJcddvRNtJ40ZdctbCMjsP0UM9ocjsXig0dzi/DIb8yOZIgC4lbJSujgsXYarczSPP
	rWZOTD86C18wCuAAN3b/Xvd54Hc7bO8nPmwW6pF3au2k+jlx8r45fR9+3aVJkxpyMqF5iMtRovb7Y
	xZ7bdS/8C+zHWXbD/wL5FOY0UQe0b8eCz2xO2Spt/ihgoKk8nGkUpLaq/y1UHZGb10EIJU3Ug1WwG
	EIgm9U7g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54672)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rNXcp-0005O9-1o;
	Wed, 10 Jan 2024 12:24:03 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rNXcs-0005Il-6h; Wed, 10 Jan 2024 12:24:06 +0000
Date: Wed, 10 Jan 2024 12:24:06 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [0/2] ARM: Adjustments for init_atags_procfs()
Message-ID: <ZZ6MZl14bcIaCaQn@shell.armlinux.org.uk>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <562a6f99-3f8e-9a77-e519-b668e24dced2@web.de>
 <b3c42397-c879-4381-aa96-c7887e81c068@web.de>
 <7dd19987-6590-4756-a929-1ff01503ad1c@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dd19987-6590-4756-a929-1ff01503ad1c@web.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 10, 2024 at 12:52:10PM +0100, Markus Elfring wrote:
> > Is this patch series still in review queues?
> 
> See also:
> https://lore.kernel.org/cocci/562a6f99-3f8e-9a77-e519-b668e24dced2@web.de/
> https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00098.html

I suspect no one looked at it, sorry. I don't catch everything that is
on the mailing list. Looks fine to me but it needs to end up in the
patch system to be applied. See signature below.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

