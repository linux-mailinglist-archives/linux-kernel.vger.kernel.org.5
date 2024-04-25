Return-Path: <linux-kernel+bounces-157952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D5E8B192B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40211B22E9A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711671804A;
	Thu, 25 Apr 2024 03:06:22 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A50111AA;
	Thu, 25 Apr 2024 03:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714014382; cv=none; b=XwCqLTeXhtSrkmCC8D/2ShlmUGEv3Pr7Uj7sIf9nf9sf/mAyIGJ0Q2j7jfV9u7JFeN8vaRUbrnuycAQGsuLwS7aeqAYksoRGpFJNNkP4o1zw261yaVnxo2FyCdOWQMLd+7QAQREDLqsVD+iBKZbvPO/ZX54bsxB6wWJkNL3ebFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714014382; c=relaxed/simple;
	bh=+oi7f7SGjmXMBqcHIf7Ga8+Wqc+wY2R+gJZ+srRQAdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T115c9ckg15t3Cf5ITe2M3ruNdDoEmJ4BRvTRVUDAwOaE8LiAuRyS0RLPaBpG4aOx9hZjjwNFcEt4bW39yhhNmvmKeWOde8qd6917msyOHsR55ZZaAk8Wj1lrHVDOSnDp0yIiNLLN0vG6//mugNxl/ZWsLDbv7KhUQz1KpL+4eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1rzpQt-000000000iK-0fH5;
	Thu, 25 Apr 2024 03:05:59 +0000
Date: Thu, 25 Apr 2024 04:05:55 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH 0/3] net: phy: mediatek: Integrate mtk-phy-lib and add
 2.5Gphy support
Message-ID: <ZinIk7b5jHtJXDJX@makrotopia.org>
References: <20240425023325.15586-1-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425023325.15586-1-SkyLake.Huang@mediatek.com>

Hi SkyLake,

On Thu, Apr 25, 2024 at 10:33:22AM +0800, Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> Re-organize MTK ethernet phy drivers and integrate common manipulations
> into mtk-phy-lib. Also, add support for build-in 2.5Gphy on MT7988.

I assume this should go to net-next. You should mention the target tree
like [PATCH net-next 0/3] and so on, in this case it's pretty obvious
though.

Generally the series looks fine and I'm glad you factored-out common
parts like the LED handling which is a great improvement also for the
older PHYs found in MT7530 and MT7531 as well as MT7621 and MT7623N.

Splitting the the 3rd patch into more atomic changes would make
reviewing a bit easier.

Also note that I've recently submitted some fixes for the LED support
which now have already been accepted to the net tree, see

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=5b5f724b05c550e10693a53a81cadca901aefd16

So it might be the best to wait for the next round of rebase of net-next
before dealing with your suggested changes to spare maintainers from
having to deal with the merge conflicts otherwise.

Generally it'd also be nice to add support for the NO_LINK rule to the
netdev trigger, as it is supported by the hardware, but that can also be
done later obviously.


Cheers


Daniel

> 
> SkyLake.Huang (3):
>   net: phy: mediatek: Re-organize MediaTek ethernet phy drivers
>   net: phy: mediatek: Add mtk phy lib for token ring access & LED/other
>     manipulations
>   net: phy: mediatek: add support for built-in 2.5G ethernet PHY on
>     MT7988
> 
>  MAINTAINERS                                   |   7 +-
>  drivers/net/phy/Kconfig                       |  17 +-
>  drivers/net/phy/Makefile                      |   3 +-
>  drivers/net/phy/mediatek-ge.c                 | 111 ----
>  drivers/net/phy/mediatek/Kconfig              |  33 ++
>  drivers/net/phy/mediatek/Makefile             |   5 +
>  drivers/net/phy/mediatek/mtk-2p5ge.c          | 399 +++++++++++++
>  .../mtk-ge-soc.c}                             | 522 ++++++++----------
>  drivers/net/phy/mediatek/mtk-ge.c             | 191 +++++++
>  drivers/net/phy/mediatek/mtk-phy-lib.c        | 330 +++++++++++
>  drivers/net/phy/mediatek/mtk.h                |  97 ++++
>  11 files changed, 1277 insertions(+), 438 deletions(-)
>  delete mode 100644 drivers/net/phy/mediatek-ge.c
>  create mode 100644 drivers/net/phy/mediatek/Kconfig
>  create mode 100644 drivers/net/phy/mediatek/Makefile
>  create mode 100644 drivers/net/phy/mediatek/mtk-2p5ge.c
>  rename drivers/net/phy/{mediatek-ge-soc.c => mediatek/mtk-ge-soc.c} (79%)
>  create mode 100644 drivers/net/phy/mediatek/mtk-ge.c
>  create mode 100644 drivers/net/phy/mediatek/mtk-phy-lib.c
>  create mode 100644 drivers/net/phy/mediatek/mtk.h
> 
> -- 
> 2.18.0
> 

