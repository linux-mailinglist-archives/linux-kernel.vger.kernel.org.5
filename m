Return-Path: <linux-kernel+bounces-49744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DEC846EE3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 141381C22844
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5AE13D507;
	Fri,  2 Feb 2024 11:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="V+t8zMK9"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0575283CDF;
	Fri,  2 Feb 2024 11:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873266; cv=none; b=Glu3Up8VSpVquZc/JfT+ac3ziwssFf7oy4OtGpAPZdOIGEi2GyJdCyF9vjxcC1TWifs+uGBw79me9X9sZ0F020wRPk68nQ9CKucjuFUwbRwxuTI6RaKJPOD+T454O7nkFs9qCGvmd+SHizKf6Rdav+V4hU4JeLlF3Ct6e9OZ3kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873266; c=relaxed/simple;
	bh=DjZR+x2AJlobZlRmeg7f3hep16VPLXZQx9SSAKPUDkc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iuHAg1Xd2aeJD23+w190H1a/9z9iDvXRsa9SifOBylTnpPCAORFSctvNvgVd/bx286YdEvx2jv2gkVg41NERJQoOy52OSLQ7ENBuDDQ0gyKZ7zzBRPkMyOHf9NU9uERXJkxY+t1xpFgTl6nGKWhJvV9st6+uUP9ESl+Tx8ZnBis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V+t8zMK9; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3A1871C0010;
	Fri,  2 Feb 2024 11:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706873262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vbhRXgt30hzZKewtZ8Axp/TleoIkIaqCjSqmkD/kB0=;
	b=V+t8zMK9ldZOp91+++bCUBkRP0gxDLTsku7L7mfPyqijvPRvdWPE9dw8bAZwK0Gld16NC7
	mbxtb8QiigimSVukX0Y9yXu2q6/dgRQoCxk/P3SP+tZP8Q2VcqpGfPcWD/b4sIcEds1rVZ
	/lX1fr4j44Bl/nGbyb2QY/6Czr6qQkz58z4dZ9Vc5vh4AXbDQySpDF5+zaZJZwNMLqzpMe
	5naY+T673vdw1sIJe6Q36f9KRU/iKEUN0E6Y8cOTBjyNj47IsWsY8Ugrd3/zWYunM4cFZk
	oapX5dqoarPjNkiFVM2MNDTmoEY5n8NIL26JPm3irfgm9RuaMSqLBVXi4pbEBQ==
Date: Fri, 2 Feb 2024 12:27:37 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Adam Ford <aford173@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Fabio Estevam <festevam@gmail.com>,
 Richard Leitner <richard.leitner@skidata.com>, Marek Vasut <marex@denx.de>,
 Robert Foss <rfoss@kernel.org>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, NXP Linux Team <linux-imx@nxp.com>,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Thomas
 Zimmermann <tzimmermann@suse.de>, Jonas Karlman <jonas@kwiboo.se>, Liu Ying
 <victor.liu@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, Maxime Ripard
 <mripard@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Neil Armstrong
 <neil.armstrong@linaro.org>, linux-kernel@vger.kernel.org, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH V7 2/2] drm/bridge: imx: add driver for HDMI TX Parallel
 Video Interface
Message-ID: <20240202122738.7dde2801@booty>
In-Reply-To: <20240106215146.147922-2-aford173@gmail.com>
References: <20240106215146.147922-1-aford173@gmail.com>
	<20240106215146.147922-2-aford173@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

On Sat,  6 Jan 2024 15:51:45 -0600
Adam Ford <aford173@gmail.com> wrote:

> From: Lucas Stach <l.stach@pengutronix.de>
> 
> This IP block is found in the HDMI subsystem of the i.MX8MP SoC. It has a
> full timing generator and can switch between different video sources. On
> the i.MX8MP however the only supported source is the LCDIF. The block
> just needs to be powered up and told about the polarity of the video
> sync signals to act in bypass mode.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com> (v2)
> Tested-by: Marek Vasut <marex@denx.de> (v1)
> Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com> (v2)
> Tested-by: Richard Leitner <richard.leitner@skidata.com> (v2)
> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de> (v2)
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com> (v3)
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Tested-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Adam Ford <aford173@gmail.com>

On v6.8-rc1, custom hardware based on the Avnet i.MX8MP SMARC SoM.

Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

I think you can remove the Tested-by I sent for previous versions.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

