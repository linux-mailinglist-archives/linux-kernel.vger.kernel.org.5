Return-Path: <linux-kernel+bounces-140154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8936B8A0C1F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4025A1F23BC7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF955145334;
	Thu, 11 Apr 2024 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q2dvg2J/"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A10C144D16;
	Thu, 11 Apr 2024 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712827033; cv=none; b=qcXEEVaBBuw/Bz0Pc+615a6usOEquPUuMkKF5YPOWL83uJLRhPhtwUv9dAN9ACwTZ0W0t50njOP7j4p7UCQaygB2W3JdN8mf+XTcYuvoZ/MIqAe/IWU4F7H45SWl5u2IL/6c1BdzekILoFZwuxVzp6+iYieZ1duWAbTjJjuleOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712827033; c=relaxed/simple;
	bh=9y5foYOUe1zzxCC5L4B/lU0OmGrdu2QwBon//WkLfhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6tEMwvCh/6jPmw+cmWFif0OpJU8DOyKi1Ofd5wE2k2AqLfQ0fmttRmTq1412Zka1uuLRvPIlxay3H3h55BdnZcotAn+FySWHXFQLaJtBNZNS5NEerRC5ikk+QPlkmhl0UxRCdcFPOXmUulPMgR4p1vHj94i/wu6DtPx4uhvFi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q2dvg2J/; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4B21B1C0005;
	Thu, 11 Apr 2024 09:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712827022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HPI71wuuzz/zgN0swML4xk7MozrGvdKbjPLs6yiiQXo=;
	b=Q2dvg2J/fHIshqJlNqOP5OVrPBGECmv0kAf6Kpr5NXKGjDIV7QgA0GlTHYZieMPuM7Js/9
	P6euw7U/k7lYojZkZkrM7lnodwPes1Kcl6r7skfSRzzYUXUXbqlnC2npHr4mQx5YNQ81hR
	OcFTZY9HM8x1HWj1wC1ShslBp68OwWzblt6pdhnKindwUMcIdBCvv+UK+YvDatZQK1n5hs
	omYSOzWGXjjsVHX7x/iqi0vwyzUkUlrTyYY56FNP278M2mF21jHx/xKrkHxkhHPQL04jpX
	awDR86TTHrZj5XeFFHOdOA+AQKlsQ5rq8gThAIUO5hvTUBNVkWKmUoIgxysGHA==
Date: Thu, 11 Apr 2024 11:17:01 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Mihai Sain <mihai.sain@microchip.com>
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] Remove the empty lines from sama5 and sama7 DT
 files
Message-ID: <20240411091701837a531a@mail.local>
References: <20240411073353.3831-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411073353.3831-1-mihai.sain@microchip.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 11/04/2024 10:33:40+0300, Mihai Sain wrote:
> This patch series removes the empty lines from sama5 and sama7 DT files.
> 
> Mihai Sain (13):
>   ARM: dts: microchip: sama7g5ek: Remove the empty line 50
>   ARM: dts: microchip: sama7g5: Remove the empty line 139
>   ARM: dts: microchip: sama5d2: Remove the empty lines 47 and 63
>   ARM: dts: microchip: sama5d27_som1_ek: Remove the empty lines
>   ARM: dts: microchip: sama5d27_wlsom1_ek: Remove the empty line 31
>   ARM: dts: microchip: sama5d29_curiosity: Remove the empty line 48
>   ARM: dts: microchip: sama5d2_icp: Remove the empty line 47
>   ARM: dts: microchip: sama5d2_ptc_ek: Remove the empty line 401
>   ARM: dts: microchip: sama5d2_xplained: Remove the empty line 710
>   ARM: dts: microchip: sama5d3_eds: Remove the empty line 24
>   ARM: dts: microchip: sama5d3_xplained: Remove the empty line 377
>   ARM: dts: microchip: sama5d4_xplained: Remove the empty line 247
>   ARM: dts: microchip: sama5d4ek: Remove the empty line 274
> 
>  arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts   | 4 ----
>  arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts | 1 -
>  arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts | 1 -
>  arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts        | 1 -
>  arch/arm/boot/dts/microchip/at91-sama5d2_ptc_ek.dts     | 1 -
>  arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts   | 1 -
>  arch/arm/boot/dts/microchip/at91-sama5d3_eds.dts        | 1 -
>  arch/arm/boot/dts/microchip/at91-sama5d3_xplained.dts   | 1 -
>  arch/arm/boot/dts/microchip/at91-sama5d4_xplained.dts   | 1 -
>  arch/arm/boot/dts/microchip/at91-sama5d4ek.dts          | 1 -
>  arch/arm/boot/dts/microchip/at91-sama7g5ek.dts          | 1 -
>  arch/arm/boot/dts/microchip/sama5d2.dtsi                | 2 --
>  arch/arm/boot/dts/microchip/sama7g5.dtsi                | 1 -
>  13 files changed, 17 deletions(-)

Please squash all of these in a single commit.

> 
> 
> base-commit: e8c39d0f57f358950356a8e44ee5159f57f86ec5
> -- 
> 2.44.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

