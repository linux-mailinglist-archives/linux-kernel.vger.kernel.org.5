Return-Path: <linux-kernel+bounces-80074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA689862A76
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 14:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DFA1281B50
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 13:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DB912E5D;
	Sun, 25 Feb 2024 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="IFbcwGvF"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37F810A09;
	Sun, 25 Feb 2024 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708867882; cv=none; b=XUh+lHqNtw22i9OHgtOUt3z8FjOk6/gg83TnWvuXa8nXlnCRFdP1SvW86qYi/Z4FzCsP/BEluAopbPMEcueoP82wc5TSMW3IcoNi9w9VR5sy56NgAExEIkg5BkFy7l3RJB7mt/mjdv2KqNELo6Dc7DR/kPIHQ5NICk3AZBQKzjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708867882; c=relaxed/simple;
	bh=/W1pq4XEAdapNX8RFQqTdUzolkOfaKYU0fjOypQ1DXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrnGfPo1mzxGNy81w2QncnShRQvlb2LIrsJYlkgFa+Blb6DdUtts8b+5/yUSFB/DRS2XM0z9Dbbmbw5N2eurVQEZCIodgNW7p0J7ejJkr4UjMPfjXjQuqMw95pqS/o7+IiEI6lFedjQ7AV3u5mwIcGEAT4TGvycu8au5Krk/bKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=IFbcwGvF; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Cqu2ZXIBpNqsbAWhTsCIwqllICow9j095X0PIZjZnB0=;
	b=IFbcwGvFysP5yCkTVFfbX8xbcLL8qfhWe3zVG+aMXo9E7+EvuHt20Y2B1te9vB
	BW2fWwBaKqJxal/ckNVVm9P21SbdXxMNVV5z9jzwJWIsOhoLblJX0S34t/whp0q8
	SSZtNKlXYLgVaL32GWCjlsI7XQyUEXncm8HOmZlHibtBo=
Received: from dragon (unknown [183.213.196.200])
	by smtp2 (Coremail) with SMTP id C1UQrACXvwcIQdtlGnBWBA--.10980S3;
	Sun, 25 Feb 2024 21:30:50 +0800 (CST)
Date: Sun, 25 Feb 2024 21:30:48 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Liu Ying <victor.liu@nxp.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-imx@nxp.com, l.stach@pengutronix.de,
	alexander.stein@ew.tq-group.com, marex@denx.de
Subject: Re: [PATCH] arm64: dts: imx8mp: Fix LDB clocks property
Message-ID: <ZdtBCEwjonmRV0+X@dragon>
References: <20240223091522.2880155-1-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223091522.2880155-1-victor.liu@nxp.com>
X-CM-TRANSID:C1UQrACXvwcIQdtlGnBWBA--.10980S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrCryDuF4UJF18Zr13Wr45KFg_yoWxGwb_G3
	4DZF1DWw1DGrWay3srGr43A34DKr98Zr17Wr4fGw4vgw1xAr17A3WkZ3s8ZF4rXanIgw1q
	9as8Gay7JFnI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0wvttUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiFQqPZV6Nm6ZxKQAAsD

On Fri, Feb 23, 2024 at 05:15:22PM +0800, Liu Ying wrote:
> The "media_ldb_root_clk" is the gate clock to enable or disable the clock
> provided by CCM(Clock Control Module) to LDB instead of the "media_ldb"
> clock which is the parent of the "media_ldb_root_clk" clock as a composite
> clock.  Fix LDB clocks property by referencing the "media_ldb_root_clk"
> clock instead of the "media_ldb" clock.
> 
> Fixes: e7567840ecd3 ("arm64: dts: imx8mp: Reorder clock and reg properties")
> Fixes: 94e6197dadc9 ("arm64: dts: imx8mp: Add LCDIF2 & LDB nodes")
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Applied, thanks!


