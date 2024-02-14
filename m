Return-Path: <linux-kernel+bounces-65106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 581438547DF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84C091C21C78
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFB61AACE;
	Wed, 14 Feb 2024 11:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AbEKSgj7"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F8B19472;
	Wed, 14 Feb 2024 11:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707909285; cv=none; b=ier8M2fDwVtCf31wza/DBCPieW9HIxQK29clU3l0HGhmxSiKN3mnsRg4wCxtS2mrfjrSuBDDOK+WwvynpX9i6dX/Ps2LT/qAtEg2b5GazKblZ4v0pii/SgB3xce3fkwp35PIA3WkmuxFP+B8kDkhFsty757MISQCgWWxbLBgyjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707909285; c=relaxed/simple;
	bh=Gd+CyunHvxbNvpxVptSLPcR33LuEQ3hVkYeWqA0Wbfg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YoyqkDgnJkw5IPUcD8TqGZaPlRTM4OJwU2z96Ljg7xv/Lfvi87W7J1WgY8aG/pwaDhYd1wsztwcBEFJdknwK6cpFfnW/+b20xXuM/1EMS9Y5gv0HEgOd5CQd4Sx0Oc/0cyYWeZoTZSVJ0GMn1Qa2ROxOHWF9oXJoLJhNnTlI6Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AbEKSgj7; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A01D91BF206;
	Wed, 14 Feb 2024 11:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707909281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SFE52PNY0PA+F+7I+xnGT+orJnrsDWlnFLaYnniFSWk=;
	b=AbEKSgj7YizzA9FSXFNoFGNM2c+Dd77VOoKF3E2vxFCl/IGSUYHAJIKtCmT3qktxNJm03X
	uG9ZaNxs+6988esaoIRk7bVW3BSO0Bg0b0+6Apw7eNG8xbfGGqywxGMhA3MnmY35eTXskR
	CR4pS6cxtdRPpT6JB8kMUVjHQYQzCTwSAh0fg1fGFg2BDuZLA8c2yLjq/ES2ZlUDx/XdtR
	dvVppER5XIOGw8hE+kcJmpa9jqQozeM8D+QfIqNgxXUcXJ1w5I1l7ZsVsdpXBsEdh3ck0k
	QOUoNqgrFv07yTRpd/0jo72K5XlBwjDAxWKqkxdJk51j8+iAXpx/n9L1Ia574Q==
Date: Wed, 14 Feb 2024 12:14:38 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Adam Ford <aford173@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, marex@denx.de,
 aford@beaconembedded.com, Lucas Stach <l.stach@pengutronix.de>, Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 1/6] dt-bindings: phy: add binding for the i.MX8MP
 HDMI PHY
Message-ID: <20240214121438.331a9f20@booty>
In-Reply-To: <20240210204606.11944-2-aford173@gmail.com>
References: <20240210204606.11944-1-aford173@gmail.com>
	<20240210204606.11944-2-aford173@gmail.com>
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

Hi Adam,

On Sat, 10 Feb 2024 14:45:57 -0600
Adam Ford <aford173@gmail.com> wrote:

> From: Lucas Stach <l.stach@pengutronix.de>
> 
> Add a DT binding for the HDMI PHY found on the i.MX8MP SoC.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

I was a bit puzzled by this v4 series as it comes after v8... however
thanks for keeping up!

This patch is identical to the v8 I already reviewed, so:

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

