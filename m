Return-Path: <linux-kernel+bounces-133145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C21B899F7B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D8AC1C22065
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE1716EBFB;
	Fri,  5 Apr 2024 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eltXqxIs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CB816EBE4;
	Fri,  5 Apr 2024 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327091; cv=none; b=B+epClVHGtr6/YZmeDjbkKpbpJU878mw9gg+t3J5KBG2XMVCIOqo/WeKHTnpGFIjHZ71baWrJ9qZD0GZZ9cHeQ4GTfCjLEf8fpUvQg10fITelUzt9Y0XVRWZTi3ffdA2mJuPUonczVVji3jfdx3q3/DUBWAiGMi6mwFC6iIdfG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327091; c=relaxed/simple;
	bh=9u276kZaHIRoTA4fadL2lfzY0PJaTWAhflWuDXQc7KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUJxMN+3j3/BbAWaUfeCMTpD/3/nc1qOvz4JrvkYYKiYQU4Bs5Wo2pgh1JBJrWsXo2vzWmQ7zg2uXCrltxOJzgXEtvlB/BsKTjqJA1d3GdNXY2Vdmgr/yCI13BsfV18rmnKMHoYd4rKnZ6JjhBGmzcLSYhtfTxcythVsgxp9eOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eltXqxIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85AAC433C7;
	Fri,  5 Apr 2024 14:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712327090;
	bh=9u276kZaHIRoTA4fadL2lfzY0PJaTWAhflWuDXQc7KI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eltXqxIseJTpiuRAJ13spAdHEBB1EkmRpmBqdjP6Uehu/d9KdmHKmpaLerp6rcb1b
	 ytDBJQ9mj8iYPDlAFMU+rbHbI7B2A8Dr21YQV5p+SLT9bq/BLo1HPCnJfXavCO/sUD
	 6OTWC0kWWTQefiM8pVw61K31PavRnvXPa4a70nAJN7WnIQKT+hl3ylfcO4+L5O9/FT
	 01vmrmu0p3OPsUPjB0zEVjw7EglL8QZBLzv97TXIquUwe29e9IJw8PdTBlDh7jqG0B
	 YEj5U8jtyTF0LwOlnHvMtkjYZnV0BpVaMaTgGCz7MrGdazCCg4SuYfSnMLyrUHnzed
	 boUmhxbFl0yxg==
Date: Fri, 5 Apr 2024 19:54:46 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Sandor Yu <Sandor.yu@nxp.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v15 2/8] phy: Add HDMI configuration options
Message-ID: <ZhAJridEyhUeFVr0@matsya>
References: <20240306101625.795732-1-alexander.stein@ew.tq-group.com>
 <20240306101625.795732-3-alexander.stein@ew.tq-group.com>
 <20240306-inquisitive-funny-bull-017550@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306-inquisitive-funny-bull-017550@houat>

On 06-03-24, 15:48, Maxime Ripard wrote:
> Hi Alexander,
> 
> On Wed, Mar 06, 2024 at 11:16:19AM +0100, Alexander Stein wrote:
> > From: Sandor Yu <Sandor.yu@nxp.com>
> > 
> > Allow HDMI PHYs to be configured through the generic
> > functions through a custom structure added to the generic union.
> > 
> > The parameters added here are based on HDMI PHY
> > implementation practices.  The current set of parameters
> > should cover the potential users.
> > 
> > Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Acked-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  include/linux/phy/phy-hdmi.h | 24 ++++++++++++++++++++++++
> >  include/linux/phy/phy.h      |  7 ++++++-
> >  2 files changed, 30 insertions(+), 1 deletion(-)
> >  create mode 100644 include/linux/phy/phy-hdmi.h
> > 
> > diff --git a/include/linux/phy/phy-hdmi.h b/include/linux/phy/phy-hdmi.h
> > new file mode 100644
> > index 0000000000000..b7de88e9090f0
> > --- /dev/null
> > +++ b/include/linux/phy/phy-hdmi.h
> > @@ -0,0 +1,24 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright 2022 NXP
> > + */
> > +
> > +#ifndef __PHY_HDMI_H_
> > +#define __PHY_HDMI_H_
> > +
> > +#include <linux/hdmi.h>
> > +/**
> > + * struct phy_configure_opts_hdmi - HDMI configuration set
> > + * @pixel_clk_rate: Pixel clock of video modes in KHz.
> > + * @bpc: Maximum bits per color channel.
> > + * @color_space: Colorspace in enum hdmi_colorspace.
> > + *
> > + * This structure is used to represent the configuration state of a HDMI phy.
> > + */
> > +struct phy_configure_opts_hdmi {
> > +	unsigned int pixel_clk_rate;
> > +	unsigned int bpc;
> > +	enum hdmi_colorspace color_space;
> > +};
> 
> Does the PHY actually care about the pixel clock rate, color space and
> formats, or does it only care about the character rate?

Nope it should not

-- 
~Vinod

