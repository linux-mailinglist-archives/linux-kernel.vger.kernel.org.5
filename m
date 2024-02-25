Return-Path: <linux-kernel+bounces-80043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C02B862A14
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 12:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2571F2160F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 11:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4067B1078B;
	Sun, 25 Feb 2024 11:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cDHw84OK"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137D9EED5
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 11:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708860612; cv=none; b=GHPLhZwaKbFgomAmfyi8na0qaQfVti0LOF3TTMwlXLVqpHt/02lcc3lmtYKzM8G15R9PzkujPhOuMG53S6iGZOGhsw+2VxEi8VCbi45ZccII9y6CFdINu5VrIM4fwIoVNKpkY0lBw5qNg442TN6KFxW3CFpjdbsl67Xi8ilQ3RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708860612; c=relaxed/simple;
	bh=UVhXejR51p5Xsll/zCIUXGrfGXiTqG5GKQQs5cTWIqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyt/GlDmxoDDWHN23aboIaVHynrp0GzYRao7+8y+dw6+iagqbBxfR1G5psWoFiSv5ByLowiN1tVCTYaGL9rUcBcsfCtidDeYUYLvFNh6q6McIjH3y+O0idvS865g60QuUWCPJOMEkqeDiUi0N4b1RDqErRseQvYcyGtBKWNyx2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=cDHw84OK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Qt7H2ZIh3v/Vcrg3evn+aruHV87xiNC9x1F3o9juqsA=; b=cDHw84OKV28nQBC6K8olsExeJA
	VSrWnBpyRHxPC5ZjzqX5aXz4lrpdcrGSEd3WmYoWDeSTKrkxpJWcdjHm8U/VRZOboPIkdNJPPBSg8
	kctsmTYCGW/UQ9DWoAKu9rI6K1KZDA5gh9VcDLNNuR0o4rmCbcKgpujj7bNLGwI2UhQhiZu0zaTuE
	sNAJVDqhiW6rFNZ6RPYp/2eceULS3mA9ZE6C8a3iaq4T/wAzEN+9qnmFCAh9TF2tzC/D9X8Njw0gf
	r+UykDIQsUlc8LIjJ/HQdYuLRsD1qmOnzo18mqhgx7+Q11ke63Mcvvf1iI182yJd87vHjaiZ710Mn
	nYbZqd8w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54804)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1reChh-0007Mq-23;
	Sun, 25 Feb 2024 11:29:57 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1reChe-0005TB-3y; Sun, 25 Feb 2024 11:29:54 +0000
Date: Sun, 25 Feb 2024 11:29:53 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com
Subject: Re: [PATCH] ARM: mvebu: Prevent null pointer dereference caused by
 kzalloc failure
Message-ID: <ZdsksQG/vMS0lWGq@shell.armlinux.org.uk>
References: <20240225060401.52768-1-duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225060401.52768-1-duoming@zju.edu.cn>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Feb 25, 2024 at 02:04:01PM +0800, Duoming Zhou wrote:
> The kzalloc() in i2c_quirk() will return null if the physical
> memory has run out. As a result, if we dereference the new_compat
> pointer, the null pointer dereference bug will happen.
> 
> This patch adds a check to avoid null pointer dereference.

Yet again another janitorial patch that is Way too focused on a single
issue, rather than analysing the code and proposing the best fix. :(

What if the two kstrdup() fail?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

