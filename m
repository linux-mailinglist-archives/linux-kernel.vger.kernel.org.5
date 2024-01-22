Return-Path: <linux-kernel+bounces-34055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BFA83729B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3819A1F2769D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20983F8D4;
	Mon, 22 Jan 2024 19:32:05 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75E13D553;
	Mon, 22 Jan 2024 19:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705951925; cv=none; b=ogzHtlUIs2EslTLhj+nA+ebXGNuDiffQI3aBu7Jf5sSEZrFfgSntLniZzr2F0AH/tCQyFU2ttcK8xoIM+KrWNt1XOOlcdfJymh8s5obWMLsUM7HDLYycGDMaLowVdB4sZE6HJ4gvwMT4Ys2/ao/Pom+rK+vnf9PmBqj1ILZ655w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705951925; c=relaxed/simple;
	bh=p6s5VVT4V3wWUeTopZg8BLSWXqDSEU8WgqilLe024xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYbACHxkJQtDYEqKdH7dlE/h/JFyaaNEM+1dTjNXoStCAgqvHe8MEBuByYPKgULj7P04Bn22/q4H3ccEa7C1VPG84XYJgeqzA2WIAKDpTERT0/v5d7duTkYyAj8H/y/PxDDB82jMg4Nn3jiP802T8pq/2lsf0dBh38d78BfCscI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rS010-00082y-1s;
	Mon, 22 Jan 2024 19:31:27 +0000
Date: Mon, 22 Jan 2024 19:31:18 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, abeni@redhat.com,
	edumazet@google.com, Ioana Ciornei <ioana.ciornei@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Alexander Couzens <lynxis@fe80.eu>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>, dsahern@kernel.org,
	weiwan@google.com,
	"open list:LYNX PCS MODULE" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH net-next 03/22] net: fill in MODULE_DESCRIPTION()s for
 PCS Layer
Message-ID: <Za7ChrR88vvqAJ5X@makrotopia.org>
References: <20240122184543.2501493-1-leitao@debian.org>
 <20240122184543.2501493-4-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122184543.2501493-4-leitao@debian.org>

Hi Breno,

On Mon, Jan 22, 2024 at 10:45:24AM -0800, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the LynxI PCS MediaTek's SoC.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/pcs/pcs-lynx.c      | 1 +
>  drivers/net/pcs/pcs-mtk-lynxi.c | 1 +
>  drivers/net/pcs/pcs-xpcs.c      | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
> index dc3962b2aa6b..d51d09beaab3 100644
> --- a/drivers/net/pcs/pcs-lynx.c
> +++ b/drivers/net/pcs/pcs-lynx.c
> @@ -398,4 +398,5 @@ void lynx_pcs_destroy(struct phylink_pcs *pcs)
>  }
>  EXPORT_SYMBOL(lynx_pcs_destroy);
>  
> +MODULE_DESCRIPTION("MediaTek SGMII library for Lynx PCS");

Nah, pcs-lynx.c is used by various SoC vendors **other than MediaTek**
such as Freescale and STMicroelectronics.

Users of the pcs-lynx.c driver are
ethernet/stmicro/stmmac/dwmac-socfpga.c
ethernet/altera/altera_tse_main.c
ethernet/freescale/dpaa2/dpaa2-mac.c
ethernet/freescale/enetc/enetc_pf.c
ethernet/freescale/fman/fman_memac.c
dsa/ocelot/felix_vsc9959.c
dsa/ocelot/seville_vsc9953.c


>  MODULE_LICENSE("Dual BSD/GPL");
> diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
> index 8501dd365279..4f63abe638c4 100644
> --- a/drivers/net/pcs/pcs-mtk-lynxi.c
> +++ b/drivers/net/pcs/pcs-mtk-lynxi.c
> @@ -303,4 +303,5 @@ void mtk_pcs_lynxi_destroy(struct phylink_pcs *pcs)
>  }
>  EXPORT_SYMBOL(mtk_pcs_lynxi_destroy);
>  
> +MODULE_DESCRIPTION("MediaTek SGMII library for LynxI");

Ack on this one.

>  MODULE_LICENSE("GPL");
> diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> index 31f0beba638a..9c020dd3c766 100644
> --- a/drivers/net/pcs/pcs-xpcs.c
> +++ b/drivers/net/pcs/pcs-xpcs.c
> @@ -1456,4 +1456,5 @@ struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr,
>  }
>  EXPORT_SYMBOL_GPL(xpcs_create_mdiodev);
>  
> +MODULE_DESCRIPTION("Synopsys DesignWare XPCS helpers");
>  MODULE_LICENSE("GPL v2");
> -- 
> 2.39.3
> 

