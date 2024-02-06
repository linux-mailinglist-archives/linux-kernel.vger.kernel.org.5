Return-Path: <linux-kernel+bounces-54608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6690E84B178
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1AFD280C02
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C8312D154;
	Tue,  6 Feb 2024 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dKXLtGPR"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7FE12D148;
	Tue,  6 Feb 2024 09:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707212327; cv=none; b=GgoN7f/HqddlxvYCgnxbf6LNeqtJr8ge6zXSul483yItAA81zgMXECvZb600LtFFhhr9HHxsigLmHUi0kgdB5FEPYNn5bhq5xhE1X5exuWx1+ijy2sKNGhm7bJNR98jTiND8qfopzNK5t00thHi5t2JlojlnrcAyv8OL/dQwLoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707212327; c=relaxed/simple;
	bh=R1JkbkHYZjBJccdGuVGW2VQafUHeELVUbK2T3y/y9DU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NmeyYu621HewxSKlRSi80Ey6KEvpAplVjFC7o+eRQNxeJGY3gnqaNOF3L7sEs6joXb0et4+x93IKSnYj/QN3F1NsGeyA9E+I8I4aDrX7HhRFIbyTT58RPbX6IDhhhX6/F/9y+yS4KIKiDN+lPDw7C48gcIZPGELn3MgJse2sD5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dKXLtGPR; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 26B2E1C0004;
	Tue,  6 Feb 2024 09:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707212323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R1JkbkHYZjBJccdGuVGW2VQafUHeELVUbK2T3y/y9DU=;
	b=dKXLtGPRXyrAMOrPTXbdEyI20UREUIhUzE+Mf1Z5vpipNPJdGYMVPkrsUQeoigC1hwWnkb
	+sM/Si7s/HdqTv9NJGKDnsV0uLZobsBHMzgjmbD4K2wnudQJXaLBCBra8zBnv8j0xNA7kC
	8vGEoiOuRG5cnA6VA9PtfySl3RUAvBpgybPSqe+1fsUeivB74y2RiRnOcRwyMSPcRb032N
	hOtgA17p2NVRic19T0+WnJSj06W4R2W6/zdYQQ1bcLS98kh3PkmcXJdgUjfn03M3Zfql6B
	Kb1Rtjq5ghJdvaH+4DpXNXzP2XvEKZl5yXAe4j3mW0eXFWOMNUP9ZRiKbIWvbg==
Date: Tue, 6 Feb 2024 10:38:42 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Ariel Elior <aelior@marvell.com>, Manish Chopra
 <manishc@marvell.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony
 Nguyen <anthony.l.nguyen@intel.com>, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH 0/8] drivers: net: Convert EEE handling to use linkmode
 bitmaps
Message-ID: <20240206103842.0a72ed27@device-28.home>
In-Reply-To: <20240204-keee-u32-cleanup-v1-0-fb6e08329d9a@lunn.ch>
References: <20240204-keee-u32-cleanup-v1-0-fb6e08329d9a@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Andrew,

On Sun, 04 Feb 2024 17:40:17 -0600
Andrew Lunn <andrew@lunn.ch> wrote:

> EEE has until recently been limited to lower speeds due to the use of
> the legacy u32 for link speeds. This restriction has been lifted, with
> the use of linkmode bitmaps. This patchset convert some MAC drivers
> still using the old _u32 to link modes, with the aim of soon being
> able to remove the legacy _u32 members in the keee structure.

Although I don't have proper hardware to test all these, I've read
the patches and I didn't find any obvious issues besides the typo in
patch 7.

Regards,

Maxime

