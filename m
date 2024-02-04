Return-Path: <linux-kernel+bounces-51620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59D3848D5E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427AF28268C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C65C22330;
	Sun,  4 Feb 2024 12:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="ROOY3X9d"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278DF22301;
	Sun,  4 Feb 2024 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707048506; cv=none; b=bjjKkAI8PvR3fru7ETiWzdD9ygtlghU/tW7/mNCeRoDSRfAFy+TiRNzCGQTA905Qiyx+IOr3HDsmkOviaUUESjCoFTgerm6ud94izIUupx4SoXa3jVHs1pgVRi4dAYft30LYW5vI9454EnS4RqxORHzG/iy1JfqGD4gaD5VvSI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707048506; c=relaxed/simple;
	bh=4p2LdF4W3zyeFbKsz2u3VE+emGdF/UbygSLZnNszXfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wwmmq8DGptZIW40ScK34S2RekN3VmucCaWSt1LE6lkD9yho1ElIBEJlG9PQVTXPYUpRCI305IXy3ljAHAr/xoUg5S5ujLrC8OrjycQl5QXO76C73f27Y+2yH3ORefty+ecYhyk3YAsb39Ttnzn5hsEnOw6KAkLFs/9vY5r3Cc3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=ROOY3X9d; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 5D2C122352;
	Sun,  4 Feb 2024 13:00:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1707048049;
	bh=hNBhjuj5iOFzwHKbDLRqgrUiUwu8spdC0cNIku83Ix0=; h=From:To:Subject;
	b=ROOY3X9dZiwGhbpObv9MEW8DVpX0EPcrjFwq235uTkOz73e5j5rQznImCKXF23efY
	 r6rlHe/Q3W3CpUCPZQPfQDCaGm5xIZ/EU23Rr/pyeS3exy4D1M5zyEcWGEInbELBs4
	 rWPLoalJDge8ZAQ9OokOWfW1km4xH9YQRYlowrLOTVhy2w84kpvg1x4WSxnGzDTNhL
	 Nhgo6L6H4LP/OBVeVFVhHx75vrX+tkpon9aG5LaAXYPpn1MojgJbbvucyy4OvOV4ug
	 3SWXfZV0uxdEFR0e/X+y8/CEKSGam5cOKpBEHAocLvh0mhSLOQu39atHEwFTQZfrRm
	 bX9wgy/4St07w==
Date: Sun, 4 Feb 2024 13:00:33 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Adam Ford <aford173@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, marex@denx.de,
	alexander.stein@ew.tq-group.com, frieder.schrempf@kontron.de,
	Lucas Stach <l.stach@pengutronix.de>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
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
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH V8 06/12] arm64: dts: imx8mp: add HDMI irqsteer
Message-ID: <20240204120033.GA4656@francesco-nb>
References: <20240203165307.7806-1-aford173@gmail.com>
 <20240203165307.7806-7-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203165307.7806-7-aford173@gmail.com>

On Sat, Feb 03, 2024 at 10:52:46AM -0600, Adam Ford wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> The HDMI irqsteer is a secondary interrupt controller within the HDMI
> subsystem that maps all HDMI peripheral IRQs into a single upstream
> IRQ line.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

This is missing your signed-off-by, and in other patches of this series
your signed-off-by is not the last, as it should be.

Please have a look and fix this and the other instances.

Thanks for this work!

Francesco


