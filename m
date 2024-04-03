Return-Path: <linux-kernel+bounces-128899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F54B89619C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BEFA1C239DA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC22BDDAA;
	Wed,  3 Apr 2024 00:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="NyFIJODy"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465A4134BD;
	Wed,  3 Apr 2024 00:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712105226; cv=none; b=d6AfcIBbWSC+7zEDsYf0SPrYIf4EnmwiNe3Dnkp1dnVBMpTeiFJiio5Yomae1yzODBCx2hI6wVdVEhYG354DcadUH0prwzPpthLTljkykj8+76C4T4qtshwSgXOyHWF8J174/i9a+zXvZFK6SsH46V2LoEqa1TPjhOps2DxFt+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712105226; c=relaxed/simple;
	bh=FmUnlCD2Kqkpp8avdQ1VCiU+CQQmLmZth2BSXulnBNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/l9pcANTIldt9lhmAW0CnSNRqwJXn9hK0bi0zjWE/h3VEVJFpO+1185L4vWG/N/8GwrYeOukIu38TpcjefFewuU5NXLFvDux5k3csz8ioyev43Fq76Hw01TvfRxz6K36gWnNqq4CQVZF/h6RlHyAxVkcoM0dNbPUDnyLUKYvTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=NyFIJODy; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=/CO89Gu/2gWODTrM8HdcaioDxZcGJnt49ZnKxSxEhjE=;
	b=NyFIJODyiTMlmxBKXGStL6resjm7iWEVcm5rz4t2MYpHYdFdEiLa3I4tO7lC3h
	KfBo6coHtsJ3uHpOFuSvrKbW2O8nzPUldHj7qfs/Sem2EU+myj59mD8r8FmOieIQ
	7c016iydFQ8PdoS7bZkmyBFJlETjhMb7V9dLd7bqgyOS4=
Received: from dragon (unknown [223.68.79.243])
	by smtp2 (Coremail) with SMTP id C1UQrADX_1LspgxmnF+yAg--.8774S3;
	Wed, 03 Apr 2024 08:46:38 +0800 (CST)
Date: Wed, 3 Apr 2024 08:46:36 +0800
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
Subject: Re: [PATCH v8 5/5] arm64: dts: imx8qxp: add asrc[0,1], esai0, spdif0
 and sai[4,5]
Message-ID: <Zgym7Pw2c34LIkd4@dragon>
References: <20240328-asrc_8qxp-v8-0-801cd6bb5be2@nxp.com>
 <20240328-asrc_8qxp-v8-5-801cd6bb5be2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328-asrc_8qxp-v8-5-801cd6bb5be2@nxp.com>
X-CM-TRANSID:C1UQrADX_1LspgxmnF+yAg--.8774S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU42YLDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiGA61ZV6NnqoMcQAAsc

On Thu, Mar 28, 2024 at 10:51:37AM -0400, Frank Li wrote:
> Add asrc[0,1], esai0, spdif0, sai[4,5] and related lpcg node for
> imx8 audio subsystem.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


