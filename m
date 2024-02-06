Return-Path: <linux-kernel+bounces-55242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC7C84B99E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151241F24659
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62E0133410;
	Tue,  6 Feb 2024 15:31:47 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24061E521;
	Tue,  6 Feb 2024 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233507; cv=none; b=ceDFXZuhcWoVPodn+jaFA/11BUOGmTGJAuMeRTlsFcJwZVo+uG4SrlI+D28qvOTHBJcWyLu86KDu734f2fTpsFFKNXRSYzTibYd/1QbWlUNPl1mFT0Oknb94LLJbhP3ecQY1es6GtZLLYFqH7sGQUe+d6BXvt9Y4pgA7BlOwio4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233507; c=relaxed/simple;
	bh=eWNNp3S32y7S2BKW74Ia47O4cFZtP2WNZ/NhkNZi0Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6O8hnbsL7cnkkUtQDeNlxGt/igZhBmXIKXS9A5A5ZJNE3B69wj00NvJ+Jf1Ewth/h6FymUcIuOWsDB9t/Ijj67pConkoGYapTD+pMsHr0kL20PD9PfCO7bOrY/7zAdw0e2reiKLNWFGPqzK9wbPOO8smMX0BLxcRK9/Y2bk6rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rXNQ4-0000nG-2R;
	Tue, 06 Feb 2024 15:31:32 +0000
Date: Tue, 6 Feb 2024 15:31:21 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Bc-bocun Chen <bc-bocun.chen@mediatek.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Qingfang Deng <dqfext@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: mediatek,mt7988-xfi-tphy: add
 new bindings
Message-ID: <ZcJQyaTotW_bCWGU@makrotopia.org>
References: <3251ac3db1a739e0c18ded0a824edae981c1e2df.1707153425.git.daniel@makrotopia.org>
 <31d2c56a-5108-4265-a267-6733e1ba328e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31d2c56a-5108-4265-a267-6733e1ba328e@linaro.org>

Hi Krzysztof,

On Tue, Feb 06, 2024 at 11:53:55AM +0100, Krzysztof Kozlowski wrote:
> On 05/02/2024 18:28, Daniel Golle wrote:
> > Add bindings for the MediaTek XFI Ethernet SerDes T-PHY found in the
> > MediaTek MT7988 SoC which can operate at various interfaces modes:
> > 
> > via USXGMII PCS:
> >  * USXGMII
> >  * 10GBase-R
> >  * 5GBase-R
> > 
> > via LynxI SGMII PCS:
> >  * 2500Base-X
> >  * 1000Base-X
> >  * Cisco SGMII (MAC side)
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> > v2: unify filename and compatible as requested
> 
> Several comments, from me and Rob, were ignored. Please respond to them.

I'm sorry if I have missed something. I just checked again on
patchwork, just in case I would have missed an email reply to this or
any of the preceding posts of this patch as part of the old series
going to netdev.

Comments you have made which I have addressed:
 - removed $nodename
 - use compatible as filename

And the only thing I found that I didn't either fix or reply to is this:
> Can you explain what is this issue and errata about (except performance)?

Not overwriting that (undocumented) value in that (undocumented)
register results in 10GBase-R having performance issues according to a
commit in MediaTek's SDK, see here:

https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/a500d94cd%5E%21/#F0

Maybe Bc or SkyLake of MediaTek (added to Cc) can explain this in more
detail?


What I did miss was Rob's comment at the very bottom of this reply:
> What is PEXTP?

I can again only answer by referencing to MediaTek's SDK sources:

https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/refs/heads/master/21.02/files/target/linux/mediatek/files-5.4/drivers/net/ethernet/mediatek/mtk_sgmii.c#96

Here this reset is called XFI_PEXTP0_GRST.

I personally find that name confusing (as this PHY has nothing to do with
_P_ci _EX_press) and have tried to get rid of it where it isn't either part
of official documentation or already merged drivers (like Sam's clock driver).

If there have been any other issues with this patch which I'm not aware
of, please point them out to me.


Thank you


Best regards


Daniel

