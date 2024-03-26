Return-Path: <linux-kernel+bounces-118933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8436688C16C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1240D2E87EF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CDA6F06F;
	Tue, 26 Mar 2024 12:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j69h30g2"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B6470CCB;
	Tue, 26 Mar 2024 12:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711454435; cv=none; b=NEV8bTJi0ia+L9TsLORFUHYd0XUgm+j7hWsljOQVfWRgcDLOJxRX6eZcDn/6XReVcDI5e2WOtm0T6AQoVO6hIRfgvJy0kYfSxPj3lTlfPOSF/bMnDJ9feW68Pkjn+iluXdQqqUs4UWfDFieQLd8HL1D3I2QbfIgKPBs6Vull9yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711454435; c=relaxed/simple;
	bh=QH35J28F0o6z7oCsR7OFqIFLPzX7jsFPWeCeVmDkrNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITQzDHNVIWbMZMhz20W9U4rNUTUnQBJtN1b1QhZa96VyqVitn9GsGAYwmi7Hl/PEOw0unDp+ltW1C6ehQqAYUY/i2eX81aoBi15k766AbRztTzKKbDID1wVbNenCOM5yfp6zJDDIBtUNRPETGqUK2UPkFayL6t2i9t1X43YxYLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j69h30g2; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so935428866b.1;
        Tue, 26 Mar 2024 05:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711454432; x=1712059232; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q+cRXbwSy+kj+jFr9nkKiGYcj2SC4D7bitszSSYK23c=;
        b=j69h30g23kHviUVZ0Wu04mys49SwIC3A/KezBnWQG4n80vuPrYef0irXXkCi85Okbk
         ZhuMhYO0RmrhQ5FRJOr0lBs8zeGGPRplvy/Qvw0YLX8G07gdc8MQv2gyS0yjG5wYm4wv
         3Eodl1P3us8U9DHcatCQpKc4eZ4k8aeth+IfN8R2b1ekytJhyo6ZpD/fydkxMpHByHyd
         SWi8rGlXlxCGV2UilR5QV0Z6l3wEtNeGSy02tOgHFq+kAsyXRuogY+7syDC/NlAkqDGv
         Qatykjzlr4NILJGCFkkrMQvL52ETRsYu1cH/iBXce7nmg2EFidryF4ixbhPZrp7lwvVD
         7BPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711454432; x=1712059232;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+cRXbwSy+kj+jFr9nkKiGYcj2SC4D7bitszSSYK23c=;
        b=mW1HiGEP597DHD1J8GEWCDRGjOXlW53Gi/ueRxlP04QOvHKeFZxySxPwghKsq58TJD
         IIKYHuag3LTx31qkcuN6HpPqX8HeZzxHMU6R1HQdnwVi0mqj3bwMW6fD7qkMX7FYFvPV
         mg6j4vUZGVo4pwH0Gfw1lYwDGapTIe6SsDqJ2+xbzrLprn61t7Um09kEFP0wjop8tOou
         rGr9IrfIfI2oy6fuVVN7ECaUdyPR0n6MveVN/JcIeqy3WL5mLlClDwHPh6VXbAPBdgq5
         d4eKsCbaQ9/Jv6gWlsY9BTlyMQi+wd8ldw/tQXkXktwneqgq1DOcx2HzzG+xnBoUxbVY
         frHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqytn26ZxRVJcN/cC8nl98zof3+6xS/n4YNJa5W99Ztw0IH5RnL8kErW4pd6J0xu0KHTw6wCOhvl0thK2s9AJFlPfkKW2pDKxfK1WsWTkp4ODuTqEim3r+5HcDzvoRooHKyjFLqCSO+u9uVoXVojEFiEEe/56JQsasLlU5/LdhVE0d
X-Gm-Message-State: AOJu0YxgZhDaLGD/DNB2Pcpfc33QxxlISnfVGQTX0hjpDIeHqu3HG/yY
	rAuGg7gE14bw6HB8/W7kcy1MPaGEpRKwV8H+aoHUdViCUQMeRCMK
X-Google-Smtp-Source: AGHT+IGTVHhqv1Z3qZT1O+W/QmPwT2rWCjt3Smjij2n/6C0H4oN7ExLhExY+im0uK0tJh985OvfRtg==
X-Received: by 2002:a17:907:86a5:b0:a46:e672:9619 with SMTP id qa37-20020a17090786a500b00a46e6729619mr1376237ejc.24.1711454431323;
        Tue, 26 Mar 2024 05:00:31 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-49-82.cust.vodafonedsl.it. [188.217.49.82])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090626cd00b00a45200fe2b5sm4128790ejc.224.2024.03.26.05.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 05:00:30 -0700 (PDT)
Date: Tue, 26 Mar 2024 13:00:27 +0100
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: Adam Ford <aford173@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-arm-kernel@lists.infradead.org, marex@denx.de,
	alexander.stein@ew.tq-group.com, frieder.schrempf@kontron.de,
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
Message-ID: <ZgK42/ODNt7prTvD@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20240203165307.7806-1-aford173@gmail.com>
 <ZgHxSHDAt7ytqDC1@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <20240325220338.GE23988@pendragon.ideasonboard.com>
 <ZgJ9P3Wx2A2n9Gt+@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <CAHCN7xKWUQwfNmTB_bu4Kqm-b6PSPBHvyf8yfRbL53rB20-=DQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCN7xKWUQwfNmTB_bu4Kqm-b6PSPBHvyf8yfRbL53rB20-=DQ@mail.gmail.com>

Hi Adam,

On Tue, Mar 26, 2024 at 06:43:26AM -0500, Adam Ford wrote:
> On Tue, Mar 26, 2024 at 2:46 AM Tommaso Merciai <tomm.merciai@gmail.com> wrote:
> >
> > Hi Laurent,
> >
> > On Tue, Mar 26, 2024 at 12:03:38AM +0200, Laurent Pinchart wrote:
> > > Hi Tommaso,
> > >
> > > On Mon, Mar 25, 2024 at 10:48:56PM +0100, Tommaso Merciai wrote:
> > > > Hi Adam, Lucas,
> > > > Thanks for this series.
> > > >
> > > > This series make HDMI work on evk.
> > > > All is working properly on my side.
> > > >
> > > > Tested on: Linux imx8mp-lpddr4-evk 6.9.0-rc1.
> > > > Hope this help.
> > > >
> > > > Tested-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > >
> > > The DRM side has been merged already. The only missing patches are for
> > > the PHY, and the latest version can be found in
> > > https://lore.kernel.org/linux-phy/20240227220444.77566-1-aford173@gmail.com/.
> > > You can test that series and send a Tested-by tag. I'm crossing my
> > > fingers and hoping it will be merged in v6.10.
> > (same here :) )
> >
> > Thanks for sharing! :)
> >
> > To be honest I test all this series rebasing my alvium next branch on top of media_stage/master (6.9.0-rc1)
> > All is working properly on my side.
> > I found v8 into the commit msg here: https://patches.linaro.org/project/linux-pm/patch/20240203165307.7806-9-aford173@gmail.com/
> > then I'm thinking this is the latest.
> >
> > I'm going to switch to your suggestion that looks more recent :)
> 
> Sorry about the confusion.  I was confused by the versioning too when
> I pulled from different parts of Lucas' stuff.  Since varying
> components were applied at different times, and the remaining part was
> based on the wrong starting point and not applied, I reverted back to
> the versioning of the PHY which was the only remaining part other than
> device tree stuff.

No problem, thanks for clarify :)

Thanks & Regards,
Tommaso

> 
> adam
> >
> > Thanks again,
> > Tommaso
> >
> > >
> > > > On Sat, Feb 03, 2024 at 10:52:40AM -0600, Adam Ford wrote:
> > > > > The i.MX8M Plus has an HDMI controller, but it depends on two
> > > > > other systems, the Parallel Video Interface (PVI) and the
> > > > > HDMI PHY from Samsung. The LCDIF controller generates the display
> > > > > and routes it to the PVI which converts passes the parallel video
> > > > > to the HDMI bridge.  The HDMI system has a corresponding power
> > > > > domain controller whose driver was partially written, but the
> > > > > device tree for it was never applied, so some changes to the
> > > > > power domain should be harmless because they've not really been
> > > > > used yet.
> > > > >
> > > > > This series is adapted from multiple series from Lucas Stach with
> > > > > edits and suggestions from feedback from various series, but it
> > > > > since it's difficult to use and test them independently,
> > > > > I merged them into on unified series.  The version history is a
> > > > > bit ambiguous since different components were submitted at different
> > > > > times and had different amount of retries.  In an effort to merge them
> > > > > I used the highest version attempt.
> > > > >
> > > > > Adam Ford (3):
> > > > >   dt-bindings: soc: imx: add missing clock and power-domains to
> > > > >     imx8mp-hdmi-blk-ctrl
> > > > >   pmdomain: imx8mp-blk-ctrl: imx8mp_blk: Add fdcc clock to hdmimix
> > > > >     domain
> > > > >   arm64: defconfig: Enable DRM_IMX8MP_DW_HDMI_BRIDGE as module
> > > > >
> > > > > Lucas Stach (9):
> > > > >   dt-bindings: phy: add binding for the i.MX8MP HDMI PHY
> > > > >   phy: freescale: add Samsung HDMI PHY
> > > > >   arm64: dts: imx8mp: add HDMI power-domains
> > > > >   arm64: dts: imx8mp: add HDMI irqsteer
> > > > >   dt-bindings: display: imx: add binding for i.MX8MP HDMI PVI
> > > > >   drm/bridge: imx: add driver for HDMI TX Parallel Video Interface
> > > > >   dt-bindings: display: imx: add binding for i.MX8MP HDMI TX
> > > > >   drm/bridge: imx: add bridge wrapper driver for i.MX8MP DWC HDMI
> > > > >   arm64: dts: imx8mp: add HDMI display pipeline
> > > > >
> > > > >  .../display/bridge/fsl,imx8mp-hdmi-tx.yaml    |  102 ++
> > > > >  .../display/imx/fsl,imx8mp-hdmi-pvi.yaml      |   84 ++
> > > > >  .../bindings/phy/fsl,imx8mp-hdmi-phy.yaml     |   62 +
> > > > >  .../soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml     |   22 +-
> > > > >  arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  145 +++
> > > > >  arch/arm64/configs/defconfig                  |    1 +
> > > > >  drivers/gpu/drm/bridge/imx/Kconfig            |   18 +
> > > > >  drivers/gpu/drm/bridge/imx/Makefile           |    2 +
> > > > >  drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c  |  207 ++++
> > > > >  drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c   |  154 +++
> > > > >  drivers/phy/freescale/Kconfig                 |    6 +
> > > > >  drivers/phy/freescale/Makefile                |    1 +
> > > > >  drivers/phy/freescale/phy-fsl-samsung-hdmi.c  | 1075 +++++++++++++++++
> > > > >  drivers/pmdomain/imx/imx8mp-blk-ctrl.c        |   10 +-
> > > > >  14 files changed, 1876 insertions(+), 13 deletions(-)
> > > > >  create mode 100644 Documentation/devicetree/bindings/display/bridge/fsl,imx8mp-hdmi-tx.yaml
> > > > >  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8mp-hdmi-pvi.yaml
> > > > >  create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8mp-hdmi-phy.yaml
> > > > >  create mode 100644 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
> > > > >  create mode 100644 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
> > > > >  create mode 100644 drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> > >
> > > --
> > > Regards,
> > >
> > > Laurent Pinchart

