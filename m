Return-Path: <linux-kernel+bounces-124082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 752948911EE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15F3EB233DA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E99538F9A;
	Fri, 29 Mar 2024 03:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="TQri5zDn"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C811339FD0;
	Fri, 29 Mar 2024 03:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711682650; cv=none; b=MU8RXtqWRntadE47ODwwSDjIMOK9svk8QFILuUpSR4qH81Z6kEJcI4b2kVd7Sn1dq0ODL30OPiI90OSl8zGJJdIJN36BFurMssIbfJ2Iu3joesBqSb1YYwsU9g55Y4SBSvAojB0DHaBqRuKBCm028iHQxhrIMTpn3ea97yJaBEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711682650; c=relaxed/simple;
	bh=6dJL1D7UqTajmrxtnZU3ug4y1I0kNUUl8J/sMQzaJeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJvgYT1sWPbvpHDWUxmSIwMLhmI4394eP6C1m60UxkH3mx9XlDtDRIk9UZSCKKSyI1bsgWZzBXrDpjTLu9OSaQVZzqIJcZNciszT3H69rIpLKjQO9+hHBqROVicY/kD0+JBlnUzYf5tl+/B7pArBgZhf5FYcxf0vXCd0Z6EEPbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=TQri5zDn; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=BwtKXj6fz1tZH4QtdmnZ4cjHjRThN0Q2/L9jVyMVD/Q=;
	b=TQri5zDnt3xgpcxJAhRlyjxJHo6KaGLD1QKjX7E20vSEjkkl+ovDaNl3btzJdf
	/5bh+wG84qcbQ12YYMnY/IWCrmnPzDergVzXfkBkjc6Esr1Bub/205CK5rzIAKtd
	8fxpU7BaW2TsDm5T3cA50TJ1K/Mmh4yiEY+wwnrlWFve8=
Received: from dragon (unknown [183.213.196.225])
	by smtp1 (Coremail) with SMTP id ClUQrAD3_3YjNAZmM3RdAQ--.43665S3;
	Fri, 29 Mar 2024 11:23:16 +0800 (CST)
Date: Fri, 29 Mar 2024 11:23:15 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com
Subject: Re: [PATCH v3 0/3] Add HDMI and PDM sound card for imx8mp-evk
Message-ID: <ZgY0I5ollcmcmuQu@dragon>
References: <1709091013-14026-1-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1709091013-14026-1-git-send-email-shengjiu.wang@nxp.com>
X-CM-TRANSID:ClUQrAD3_3YjNAZmM3RdAQ--.43665S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUswZ2UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiFQSwZV6NnA3F6gAAsp

On Wed, Feb 28, 2024 at 11:30:10AM +0800, Shengjiu Wang wrote:
> Add HDMI and PDM sound card
> 
> changes in v3:
> - split imx8mp and imx8mp-evk changes for HDMI audio. 
> 
> changes in v2:
> - remove 'status' in sound-hdmi
> 
> Shengjiu Wang (3):
>   arm64: dts: imx8mp: Add AUD2HTX device node
>   arm64: dts: imx8mp-evk: Add HDMI audio sound card support
>   arm64: dts: imx8mp-evk: Add PDM micphone sound card support

Applied all, thanks!


