Return-Path: <linux-kernel+bounces-33827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A378A836F11
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59511C22770
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3D056B92;
	Mon, 22 Jan 2024 17:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eWTa4QXy"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71AB56B77;
	Mon, 22 Jan 2024 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944863; cv=none; b=ZYLfQdQ3xNdmh1sUpokiaESjzG1TjmgXrlgmM4AkdCUjPXuAbjIeW0Jc1DaDEBqeKKX1YJ1EZYUDVYx9GJbrMp3hiXrhngNUYE4rUpd9LbNwGO9t71ggMAcpPgjO8FODyfNZZ7ENtCziaBtTXx8LlP2r4vXuOlN5Q0+NUjNrIsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944863; c=relaxed/simple;
	bh=8hedJBX60cSPOSwd7qtDOvB0MY2R5+r1VTQuSWCC+GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EM72NKFEKVRQ+Eytw90R0ZYKoNfhwVqGk5814ivgHvQAS0KkT56FWS/jhAcLkTqx2luyV323wPjui/avoLFMzkU7ummp24WZVMnQ8MSqgNfAziPCY/vAndSNC3KUUJanouLcfb/ZdpX0XZbYZv+oA/OsfFGTFb4KRT/Kw8xa1O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eWTa4QXy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GWnT5S4Q6XzDJBRpEknqgOW0ZyLDPeI6kyNoprab2vM=; b=eWTa4QXyrVBO656lSz5cMMLRyy
	R6pDqNNQj8yI9pfktmlDM2dJvaXnLVSst2pNMmm5eqxhxxmJB6x0wkoNQ+gbkAv7EUL0MdozU8Qee
	H1SFbw/Y7JnA/iHu0f0//49u9J+NQqQBDQ1snFjFX75fyr78iZfOqRF5I7QNEGvK19So=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rRyBY-005kSZ-AZ; Mon, 22 Jan 2024 18:34:12 +0100
Date: Mon, 22 Jan 2024 18:34:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ziyang Huang <hzyitc@outlook.com>
Cc: mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	richardcochran@gmail.com, p.zabel@pengutronix.de,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Praveenkumar I <ipkumar@codeaurora.org>,
	Abhishek Sahu <absahu@codeaurora.org>
Subject: Re: [PATCH 5/8] clk: qcom: support for duplicate freq in RCG2 freq
 table
Message-ID: <b84df52a-f144-4ec3-b81b-20d1a0176aff@lunn.ch>
References: <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <TYZPR01MB5556DEA3D4740441EC561414C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <28cca132-d5bb-4cff-ba2f-9be241a5ce83@lunn.ch>
 <TYZPR01MB55565998F43009AD351AC07EC9752@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYZPR01MB55565998F43009AD351AC07EC9752@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>

> > > Change-Id: I97d9e1b55d8f3ee095f6f01729af527ba90e50e5
> > > Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> > > (cherry picked from commit 775e7d3b69ffc97afb5bd5a6c9c423f2f4d8a0b2)
> > > Signed-off-by: Praveenkumar I <ipkumar@codeaurora.org>
> > > 
> > > Change-Id: If10193fc79a3c1375ab73597813745ff1f4df0ad
> > > 
> > > Pick from https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/commit/6dfb368bae130bee58e00ddf8330b55066e1c8c5
> > > 
> > > Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
> > 
> > Please clean up these tags. These Change-ID tags are meaningless in
> > mainline. 775e7d3b69ffc97afb5bd5a6c9c423f2f4d8a0b2 is not in mainline
> > either. The picked from might be interesting, but please put it into
> > the body of the commit message, not mixed in with the tags.
> > 
> > Who actually wrote this patch? The first Signed-off-by: is from
> > Abhishek Sahu. But you have a From of Praveenkumar I ?
> 
> I have no idea about this. This patch is from Qualcomm vendor linux code.

O.K. Since this is direct from the vendor, who probably does not track
code authorship correctly, i would say the author in git is probably
wrong. I would set the author: to Abhishek Sahu <absahu@codeaurora.org>.

> What's more, I don't known how to deal with these commit message since I'm
> not the author and I'm not sure do I have right to edit them even though
> this is GPL code.

You should keep all the Signed-off-by, in the order they are. But the
Change-Id is meaningless, so there is no problem removing them.

	  Andrew

