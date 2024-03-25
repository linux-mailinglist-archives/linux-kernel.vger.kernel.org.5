Return-Path: <linux-kernel+bounces-118076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FE988B35A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3BD305571
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA6E73506;
	Mon, 25 Mar 2024 22:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="wcWZDahR"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED356F520;
	Mon, 25 Mar 2024 22:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711404230; cv=none; b=kJ1uW5ab9p0IT7JUa0yiUWVlwkUYEDHKTvOY27Rae9s8qco6TSQd/0CbkeYX0eenPmLV+d1FHijcv2nvbUAoVdDVPsb60d5Dm1VIjLM59bzNMpltPUZmu3FKbkCa3pDlh5ovUw88+IRwypktYT775U0aVAfl/i/W+d49VadkvlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711404230; c=relaxed/simple;
	bh=wILjujuHwaXE035Qg6th/X7umy8fExbM4hbSiy6UlSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFM8qNuz8ar4A4C2BPQFh5NH7t+rBjFKJNyh8MQ3xDDckntmKfb6e1jAERNjXFMmKjLVDjeybuZKttXPPswG9sfrwNlTtl9A8gDjEXX8L7DCj2D5ByU6o05PEKJ0tO0LcsS//Emz0FVSdacoy4+caa+CjpOo59nrK/TMSDDaMMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=wcWZDahR; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 236467E4;
	Mon, 25 Mar 2024 23:03:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1711404194;
	bh=wILjujuHwaXE035Qg6th/X7umy8fExbM4hbSiy6UlSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wcWZDahRijyytCUtYxvi42I6OWjBMYCCwpdBuNX3lnAyLMuPxYi/Mdq6egt4xO8XK
	 XMtYknsnFJZ//PKJvUpADXqEw/O82d5bSIcqU23dtK23anMAGJXVI3pYYAHNZUTnHa
	 oO7GkoR/0ZssUxzL7/ZU63sf7x3TJ7xPWf8Lhg+M=
Date: Tue, 26 Mar 2024 00:03:38 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tommaso Merciai <tomm.merciai@gmail.com>
Cc: Adam Ford <aford173@gmail.com>, linux-arm-kernel@lists.infradead.org,
	marex@denx.de, alexander.stein@ew.tq-group.com,
	frieder.schrempf@kontron.de,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Liu Ying <victor.liu@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH V8 00/12] soc: imx8mp: Add support for HDMI
Message-ID: <20240325220338.GE23988@pendragon.ideasonboard.com>
References: <20240203165307.7806-1-aford173@gmail.com>
 <ZgHxSHDAt7ytqDC1@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZgHxSHDAt7ytqDC1@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>

Hi Tommaso,

On Mon, Mar 25, 2024 at 10:48:56PM +0100, Tommaso Merciai wrote:
> Hi Adam, Lucas,
> Thanks for this series.
> 
> This series make HDMI work on evk.
> All is working properly on my side.
> 
> Tested on: Linux imx8mp-lpddr4-evk 6.9.0-rc1.
> Hope this help.
> 
> Tested-by: Tommaso Merciai <tomm.merciai@gmail.com>

The DRM side has been merged already. The only missing patches are for
the PHY, and the latest version can be found in
https://lore.kernel.org/linux-phy/20240227220444.77566-1-aford173@gmail.com/.
You can test that series and send a Tested-by tag. I'm crossing my
fingers and hoping it will be merged in v6.10.

> On Sat, Feb 03, 2024 at 10:52:40AM -0600, Adam Ford wrote:
> > The i.MX8M Plus has an HDMI controller, but it depends on two
> > other systems, the Parallel Video Interface (PVI) and the
> > HDMI PHY from Samsung. The LCDIF controller generates the display
> > and routes it to the PVI which converts passes the parallel video
> > to the HDMI bridge.  The HDMI system has a corresponding power
> > domain controller whose driver was partially written, but the
> > device tree for it was never applied, so some changes to the
> > power domain should be harmless because they've not really been
> > used yet.
> > 
> > This series is adapted from multiple series from Lucas Stach with
> > edits and suggestions from feedback from various series, but it
> > since it's difficult to use and test them independently,
> > I merged them into on unified series.  The version history is a
> > bit ambiguous since different components were submitted at different
> > times and had different amount of retries.  In an effort to merge them
> > I used the highest version attempt.
> > 
> > Adam Ford (3):
> >   dt-bindings: soc: imx: add missing clock and power-domains to
> >     imx8mp-hdmi-blk-ctrl
> >   pmdomain: imx8mp-blk-ctrl: imx8mp_blk: Add fdcc clock to hdmimix
> >     domain
> >   arm64: defconfig: Enable DRM_IMX8MP_DW_HDMI_BRIDGE as module
> > 
> > Lucas Stach (9):
> >   dt-bindings: phy: add binding for the i.MX8MP HDMI PHY
> >   phy: freescale: add Samsung HDMI PHY
> >   arm64: dts: imx8mp: add HDMI power-domains
> >   arm64: dts: imx8mp: add HDMI irqsteer
> >   dt-bindings: display: imx: add binding for i.MX8MP HDMI PVI
> >   drm/bridge: imx: add driver for HDMI TX Parallel Video Interface
> >   dt-bindings: display: imx: add binding for i.MX8MP HDMI TX
> >   drm/bridge: imx: add bridge wrapper driver for i.MX8MP DWC HDMI
> >   arm64: dts: imx8mp: add HDMI display pipeline
> > 
> >  .../display/bridge/fsl,imx8mp-hdmi-tx.yaml    |  102 ++
> >  .../display/imx/fsl,imx8mp-hdmi-pvi.yaml      |   84 ++
> >  .../bindings/phy/fsl,imx8mp-hdmi-phy.yaml     |   62 +
> >  .../soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml     |   22 +-
> >  arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  145 +++
> >  arch/arm64/configs/defconfig                  |    1 +
> >  drivers/gpu/drm/bridge/imx/Kconfig            |   18 +
> >  drivers/gpu/drm/bridge/imx/Makefile           |    2 +
> >  drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c  |  207 ++++
> >  drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c   |  154 +++
> >  drivers/phy/freescale/Kconfig                 |    6 +
> >  drivers/phy/freescale/Makefile                |    1 +
> >  drivers/phy/freescale/phy-fsl-samsung-hdmi.c  | 1075 +++++++++++++++++
> >  drivers/pmdomain/imx/imx8mp-blk-ctrl.c        |   10 +-
> >  14 files changed, 1876 insertions(+), 13 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/display/bridge/fsl,imx8mp-hdmi-tx.yaml
> >  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8mp-hdmi-pvi.yaml
> >  create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8mp-hdmi-phy.yaml
> >  create mode 100644 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
> >  create mode 100644 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
> >  create mode 100644 drivers/phy/freescale/phy-fsl-samsung-hdmi.c

-- 
Regards,

Laurent Pinchart

