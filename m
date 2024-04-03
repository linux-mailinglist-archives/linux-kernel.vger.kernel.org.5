Return-Path: <linux-kernel+bounces-128898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD73589619A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35321C21F1E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC4CD527;
	Wed,  3 Apr 2024 00:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Ie3XkEtJ"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE0710A3C;
	Wed,  3 Apr 2024 00:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712105211; cv=none; b=Ff5MqgbZkYJkmU64ZFoXrNTsH/dXl9YJP9lNGkxUeHHz7FFHlUv5WTptYCGilcl0iIyZxa8uqtQPDPrqaQwI5JyyP1L9+NwdkPe9njz/KiT4pZybyAqRIEwK8ApQhtqM4ANGOTccvOqd3545IUNmsOtrH1cI5VmizpMOwqVpCRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712105211; c=relaxed/simple;
	bh=/LLxUfWngEK03tH5oBRilnm+GpQ91N397XktA8GjK3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSgXVDdawYYHcwGt0oXKkFzi/enWF3Aamu6AQ0JPQSlnrSQPxzfL0R1sXR1snonSeZXXGWWlObp7KK8quW8Gmpzy28zlVZJFeCuxdn9u5BmoocikyOGmIpoDzPRRMX9+udkBBIAIB5VFSz1z+mJRW+ow5w1zll9KlFlHNmc30iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Ie3XkEtJ; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=JbLQmn1f4KqgDj+3CsmOO0aLXXSbBrAVqrmpKxQMRho=;
	b=Ie3XkEtJ4cp55rTC7Kw7o8dz7IRo4uqegdzmawG9n8hiWrReqEgr2q+1huXzuV
	GOLcGR9vHPKmXv1XAataCrDTlNSpfenBLF2YwIu+iqnSCo5Y2t2gl2nJ7pJyPfXd
	xVEc+FL8poG0/oFShlrkOIHCDatNxfVRawJM9XrpsoVvk=
Received: from dragon (unknown [223.68.79.243])
	by smtp1 (Coremail) with SMTP id ClUQrADnr0Hfpgxmrc2sAQ--.48995S3;
	Wed, 03 Apr 2024 08:46:24 +0800 (CST)
Date: Wed, 3 Apr 2024 08:46:23 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/5] arm64: dts: imx8: fix audio lpcg index
Message-ID: <Zgym35B8Ig5ej5QF@dragon>
References: <20240328-asrc_8qxp-v8-0-801cd6bb5be2@nxp.com>
 <20240328-asrc_8qxp-v8-4-801cd6bb5be2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328-asrc_8qxp-v8-4-801cd6bb5be2@nxp.com>
X-CM-TRANSID:ClUQrADnr0Hfpgxmrc2sAQ--.48995S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xry8WFW8uw1UWF1Dtr1xGrg_yoWxtFXEqF
	4UJw4kur4Duryfta9Iqr13Aa48J3Wv9wn8WFWjqFn7Jas5JFZrAF18Krnxur45GFsxKr1U
	GFyUG3yUW3WI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0nqXJUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiFQq1ZV6NnBsUdgABs4

On Thu, Mar 28, 2024 at 10:51:36AM -0400, Frank Li wrote:
> lpcg cell0 should be clock's 'indices' instead of 'index'.
> 
> imx_lpcg_of_clk_src_get(struct of_phandle_args *clkspec, void *data)
> {
>         struct clk_hw_onecell_data *hw_data = data;
>         unsigned int idx = clkspec->args[0] / 4;
> 
> 	....
> }
> 
> <@sai0_lpcg 1> will be the same as <@sai_lpcg 0>.
> 
> Replace 0 with IMX_LPCG_CLK_0 and replace 1 with IMX_LPCG_CLK_4.
> 
> It can work at iMX8QXP because IMX_LPCG_CLK_4 is ipg clock, which already
> enabled. But for iMX8QM IMX_LPCG_CLK_4 is mclk, which trigger issue.
> 
> Fixes: 0a9279e9ae88 ("arm64: dts: imx8qxp: Add audio SAI nodes")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


