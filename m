Return-Path: <linux-kernel+bounces-65298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4DE854ACA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322861F289E9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14C854BDF;
	Wed, 14 Feb 2024 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="glOf6NWf"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D172A54BC9;
	Wed, 14 Feb 2024 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707918898; cv=none; b=AEcSumaAUlLy84KZ6JHDX/CTzdR8dDVqwYVzaM6e51ksPRrGiOUfccEZ/I18MtCOS6JkVTyDTdZH4FqKTVtnpPzlIDY49s1fRnleMr64GEmoskooBsBNtkXFFeohEtV4l8je2onraP8iS1Wt8i5VKR5xUvbCXZZCddjp5Omu8ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707918898; c=relaxed/simple;
	bh=R2GYoNLZ4RTpO70AujPg/1RrzI1BJGVw3w2HYNt5j9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhWdd+2ykCTpAJVWeYxAZL4txm26yokDvTZ8iYn4G7wgBucRKpay7iNivaRwS5ZEjUBZwpyd2/6CvyZU6hlZUc79oMm92HO++a+M3rRBRTILe7sv5LBTR7JIgvFum0RooPalLeYLfSTUpBJF2hKXMVWdeMXQeiKQXiJ3roKPLUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=glOf6NWf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=dgXYrhLbpWQPlz5UKTX6bJxUhxWWR7lyTKdm0QhL0HM=; b=gl
	Of6NWfNtO/v+zOuzpBcd/d/doAHpd6qkP8hgGN5M5asLoGEuLZRZsb37vZcCaRbC8zMc5fNzHDeRw
	+t86ZZJGL2JdMELzf4Ol/7VA8ged38QGneBC1ZljseePDoZIh51B9b5Oi0WOFaIHVzRFp4QGQR0oz
	ZV/fldP0XIeio88=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raFix-007n5X-Pr; Wed, 14 Feb 2024 14:54:55 +0100
Date: Wed, 14 Feb 2024 14:54:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH v2 1/2] ARM: dts: imx6dl-yapp4: Fix typo in the QCA
 switch register address
Message-ID: <8c765a36-4718-4f5f-a8d0-3763ac97ab7b@lunn.ch>
References: <1707901408-17084-1-git-send-email-michal.vokac@ysoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1707901408-17084-1-git-send-email-michal.vokac@ysoft.com>

On Wed, Feb 14, 2024 at 10:03:27AM +0100, Michal Vokáč wrote:
> This change does not have any functional effect. The switch works just
> fine without this patch as it has full access to all the addresses
> on the bus. This is simply a clean-up to set the node name address
> and reg address to the same value.
> 
> Fixes: 15b43e497ffd ("ARM: dts: imx6dl-yapp4: Use correct pseudo PHY address for the switch")
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

