Return-Path: <linux-kernel+bounces-32113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBBA8356A9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 17:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0971F220C6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C89381A0;
	Sun, 21 Jan 2024 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2p9mswx+"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2DF22069;
	Sun, 21 Jan 2024 16:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705854523; cv=none; b=txEslbdU2hH+e7yABuvkRXB0By4fGwZAe6+/Yf5A1kV6fpnsd1a9F44lBp74DlDpSHld73BOGPCqNXpMyOhjV/EAwDkBQXRw6UdZDkAUeHNod2uBFPOaf/mA20gxNF8ZyjZmayAW/nfYgAm+6/bqiKc8N7gNEOk9rnBAbiriG8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705854523; c=relaxed/simple;
	bh=e2ONesh2O8YofmMzm7yuXkwsLO1HkkWCLnN6d0brPCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7vexFNAleEjnmLJdtZgV5E5Ryp2PZZ3SWpdKUha0h/71QcCh34CkmtUkQBWmgrved7b2UJFH3AWz8fC1g7iVtR94QPpf4hG30b1h9YD1ZulXf/v2GN2ItMHP/P5s/3Q7ATsPFnfzYYfa9tyBPw8LeksdXu4mizr16TTCHJqCL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2p9mswx+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=b8VBdnI6NY92PMdeoxReDdK2LAjdaJ+l1Yht1Nmj5Z4=; b=2p9mswx+7FNaQYQFZ0hfI2ryxk
	0WBSo0i81zSkim2FOh27p0moMciEiC0XH865dQabv4d5HlswA3Pl7I52vw/S+wsTR4OklAqKHQmLD
	2crOrMiAZ2CnzMhQuNlG3Uog8xsGaaEh90OSkHiT0LJGN2ztpMoH4sUyWMS5lRH4ELAY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rRagS-005f2l-Se; Sun, 21 Jan 2024 17:28:32 +0100
Date: Sun, 21 Jan 2024 17:28:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ziyang Huang <hzyitc@outlook.com>
Cc: mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	richardcochran@gmail.com, p.zabel@pengutronix.de,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 4/8] clk: qcom: gcc-ipq5018: correct gcc_gmac0_sys_clk reg
Message-ID: <b616c6aa-9241-4eb0-a9cc-a7bc2e706d72@lunn.ch>
References: <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <TYZPR01MB555644D4AF2C3C528BC6E6C0C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYZPR01MB555644D4AF2C3C528BC6E6C0C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>

On Sun, Jan 21, 2024 at 08:42:33PM +0800, Ziyang Huang wrote:

This, and all your patches need a Commit message.

What is the effect of this typo? What is broken because of it? Should
this be backported to stable? Does it need a Fixed: tag?

> Signed-off-by: Ziyang Huang <hzyitc@outlook.com>


    Andrew

---
pw-bot: cr

