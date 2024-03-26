Return-Path: <linux-kernel+bounces-118482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5D888BB9A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A671F3854F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFE813281A;
	Tue, 26 Mar 2024 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsLpowMR"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476781804F;
	Tue, 26 Mar 2024 07:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711439175; cv=none; b=IxMcUCKqk+QIFovUlSeYdIKMscA/dIgsKmO2BmsQYGmVTveUpNayy6sGG4AbHLVl2PCMQH5+5CPOPf5pTqBNwe8w0HqbDnxzAdgX+e4AqEDdpyvvuxbqVcHFQydMltD5tA47hxxAsAyLmYH+yhRnXeZccalRRqO1Kd1xcy/1REs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711439175; c=relaxed/simple;
	bh=9nbuupSTwnqhgE67/6uv0FOLeTMTUSay5mBf80zherM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3UlDHyMj6Kj3uHDmTNW+a3UP5Wm6bJxjQQjZO2CdE+Fim7u5MNfG37GdGii/UgkiUdh6BfKkmd/NPTDtJs84tk3NEmrCqyZ+Fpl+aEBiJ79MI8eEgz4HCn4ygMwB+bIJZ9VMh2T6nICgXqmbtYSPIdk7PbfVcW1wLisUAsX6E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsLpowMR; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso5360323a12.3;
        Tue, 26 Mar 2024 00:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711439171; x=1712043971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cs2IwigS62lW2NUemYpoxv0KHk0e1rYE/O58ogrWzrM=;
        b=gsLpowMRH3b18jXTudj2fu78Gwju8x4FREaOkDHP82qoXt3IKM8DaRk8k7j0qwJ4wP
         lw/7bT+n2BkoFmjzOrqYroUS2R7XGVI1FxE67spJUv9Wm11h8Iql6Zuslu92vFLAXnSf
         ngnb74DcHVb7jsHHR8HqJfLDkZ9ZwCqIhFAvHcKMt1uZZ4Cz6XW4hrggATrNR8bmWFh+
         9iXVv1GKOwOxgXTDeNosufmRtdT0H7S9HDj6/Oo9SINX2zYOEjr+EaSuqdF5bi35lrWC
         YhrtXCSRz+vXNQyyYyEr+rs2r+vrg8D8McfG6csRdBLoZZUxc2emmK1oieTndPj6nk9i
         aR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711439171; x=1712043971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cs2IwigS62lW2NUemYpoxv0KHk0e1rYE/O58ogrWzrM=;
        b=l+uJ9JeR0+AkQt+xZ716scprp23L4/nBr25vSvGFmIYLWx/F5tfMEP/XlS0U50eVYw
         HHmo10POf+ief2eEiHi13L+QaAsMrD+IIZ2XjP96iEXND+K8uiMcqsdFSmq79jZBBxP5
         EYkT+FmaS0VCG7biKySnBRYy5F/sI1mQbkwvdgRHJ1N51fYhycJ1nI2+JmMTMdQ/d64G
         6/R6ZWdYE8QUDvG2CxJcgX9+Fjn9oaAQB95WdmPe93vBiVQvTC2nYA3VIUuoHty6HKZO
         hne3NuWDZRPT0O+6WiZ7bumlGveZyO40cnAqlO1VlHZtwtdZLAvxiCvIKs8I6ahYg4e3
         nm8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXl0idTZjMbD2xWEVUcl98V7Kbc8XMNzRXmXoH/SaTOjpjjxlabiyYpaPLywLRWLaIj3pUzNQzfu9f/PyscCw+dvN3FjVS9dzjJua+DtLiRKzHgrcyMVv2KPwx22/M3bp3R8XjRz2IL0VQUDmzWuNgTJ6UTD2Gtd6wrwfzffTFG1hCm
X-Gm-Message-State: AOJu0YwFcAGLIKILlxrejxvCYJ95NA1vGZ1z1fU7lIA8Id8SyiuMQfJe
	FI/uIj5nmqx7pVKhPXzIJI9+NgDeFEfAxUlMph4KQtIBUjRIeVRR
X-Google-Smtp-Source: AGHT+IGrIlCSSn2r2+Hg+P0/A4xj4OXP7apyF3284aGBI7zxVjMxD5nzUTRKGklIY7bvBEYmSkW8Iw==
X-Received: by 2002:a50:8ac9:0:b0:568:a420:7d80 with SMTP id k9-20020a508ac9000000b00568a4207d80mr6923066edk.27.1711439171189;
        Tue, 26 Mar 2024 00:46:11 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-49-82.cust.vodafonedsl.it. [188.217.49.82])
        by smtp.gmail.com with ESMTPSA id dh16-20020a0564021d3000b0056c1c4b870asm1167067edb.16.2024.03.26.00.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 00:46:10 -0700 (PDT)
Date: Tue, 26 Mar 2024 08:46:07 +0100
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
Message-ID: <ZgJ9P3Wx2A2n9Gt+@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20240203165307.7806-1-aford173@gmail.com>
 <ZgHxSHDAt7ytqDC1@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <20240325220338.GE23988@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325220338.GE23988@pendragon.ideasonboard.com>

Hi Laurent,

On Tue, Mar 26, 2024 at 12:03:38AM +0200, Laurent Pinchart wrote:
> Hi Tommaso,
> 
> On Mon, Mar 25, 2024 at 10:48:56PM +0100, Tommaso Merciai wrote:
> > Hi Adam, Lucas,
> > Thanks for this series.
> > 
> > This series make HDMI work on evk.
> > All is working properly on my side.
> > 
> > Tested on: Linux imx8mp-lpddr4-evk 6.9.0-rc1.
> > Hope this help.
> > 
> > Tested-by: Tommaso Merciai <tomm.merciai@gmail.com>
> 
> The DRM side has been merged already. The only missing patches are for
> the PHY, and the latest version can be found in
> https://lore.kernel.org/linux-phy/20240227220444.77566-1-aford173@gmail.com/.
> You can test that series and send a Tested-by tag. I'm crossing my
> fingers and hoping it will be merged in v6.10.
(same here :) )

Thanks for sharing! :)

To be honest I test all this series rebasing my alvium next branch on top of media_stage/master (6.9.0-rc1)
All is working properly on my side.
I found v8 into the commit msg here: https://patches.linaro.org/project/linux-pm/patch/20240203165307.7806-9-aford173@gmail.com/
then I'm thinking this is the latest.

I'm going to switch to your suggestion that looks more recent :)

Thanks again,
Tommaso

> 
> > On Sat, Feb 03, 2024 at 10:52:40AM -0600, Adam Ford wrote:
> > > The i.MX8M Plus has an HDMI controller, but it depends on two
> > > other systems, the Parallel Video Interface (PVI) and the
> > > HDMI PHY from Samsung. The LCDIF controller generates the display
> > > and routes it to the PVI which converts passes the parallel video
> > > to the HDMI bridge.  The HDMI system has a corresponding power
> > > domain controller whose driver was partially written, but the
> > > device tree for it was never applied, so some changes to the
> > > power domain should be harmless because they've not really been
> > > used yet.
> > > 
> > > This series is adapted from multiple series from Lucas Stach with
> > > edits and suggestions from feedback from various series, but it
> > > since it's difficult to use and test them independently,
> > > I merged them into on unified series.  The version history is a
> > > bit ambiguous since different components were submitted at different
> > > times and had different amount of retries.  In an effort to merge them
> > > I used the highest version attempt.
> > > 
> > > Adam Ford (3):
> > >   dt-bindings: soc: imx: add missing clock and power-domains to
> > >     imx8mp-hdmi-blk-ctrl
> > >   pmdomain: imx8mp-blk-ctrl: imx8mp_blk: Add fdcc clock to hdmimix
> > >     domain
> > >   arm64: defconfig: Enable DRM_IMX8MP_DW_HDMI_BRIDGE as module
> > > 
> > > Lucas Stach (9):
> > >   dt-bindings: phy: add binding for the i.MX8MP HDMI PHY
> > >   phy: freescale: add Samsung HDMI PHY
> > >   arm64: dts: imx8mp: add HDMI power-domains
> > >   arm64: dts: imx8mp: add HDMI irqsteer
> > >   dt-bindings: display: imx: add binding for i.MX8MP HDMI PVI
> > >   drm/bridge: imx: add driver for HDMI TX Parallel Video Interface
> > >   dt-bindings: display: imx: add binding for i.MX8MP HDMI TX
> > >   drm/bridge: imx: add bridge wrapper driver for i.MX8MP DWC HDMI
> > >   arm64: dts: imx8mp: add HDMI display pipeline
> > > 
> > >  .../display/bridge/fsl,imx8mp-hdmi-tx.yaml    |  102 ++
> > >  .../display/imx/fsl,imx8mp-hdmi-pvi.yaml      |   84 ++
> > >  .../bindings/phy/fsl,imx8mp-hdmi-phy.yaml     |   62 +
> > >  .../soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml     |   22 +-
> > >  arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  145 +++
> > >  arch/arm64/configs/defconfig                  |    1 +
> > >  drivers/gpu/drm/bridge/imx/Kconfig            |   18 +
> > >  drivers/gpu/drm/bridge/imx/Makefile           |    2 +
> > >  drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c  |  207 ++++
> > >  drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c   |  154 +++
> > >  drivers/phy/freescale/Kconfig                 |    6 +
> > >  drivers/phy/freescale/Makefile                |    1 +
> > >  drivers/phy/freescale/phy-fsl-samsung-hdmi.c  | 1075 +++++++++++++++++
> > >  drivers/pmdomain/imx/imx8mp-blk-ctrl.c        |   10 +-
> > >  14 files changed, 1876 insertions(+), 13 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/display/bridge/fsl,imx8mp-hdmi-tx.yaml
> > >  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8mp-hdmi-pvi.yaml
> > >  create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8mp-hdmi-phy.yaml
> > >  create mode 100644 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
> > >  create mode 100644 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
> > >  create mode 100644 drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> 
> -- 
> Regards,
> 
> Laurent Pinchart

