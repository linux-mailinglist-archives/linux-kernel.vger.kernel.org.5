Return-Path: <linux-kernel+bounces-80087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F913862A93
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 14:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFD051F2144A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 13:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31605134A5;
	Sun, 25 Feb 2024 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="b7MN18W6"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B00F12E63;
	Sun, 25 Feb 2024 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708869476; cv=none; b=QORFSP78aukQzClmjRx+qav1EMPZPPA5AHyCjch5gO98+U2ej/uJ69n7P2oIGgTNtyvoSCKsp5s4RcPup/LgxoKIn9eD1kplNT05WrvlB2wzlGkzxAZ6BMGHi4ipS6KxLZLdD0ttKuotRNKtEemhQM+LBFOVk8wMikXshAfkgQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708869476; c=relaxed/simple;
	bh=QgW5eFUnGCQJpfHzxPZzus4WbzbIwcLa646J3/OHdn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrzjzIS83YeDtO6wrOOS84fNSJ7BtGWKh/VtKTAr73a4y5i1Z62mnIPc0oQ7A4Y+pxGQbVmywDiIhjOkodHBCxR0ZMaAT9J2hg9/bWmY6A1Bin/+ewX2Yf7VqZWCJGun7ycfdB8WprfH2b7J87ZOlohBFeX3Og346lhRafa4Cv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=b7MN18W6; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=MRJTwcs94vB+Lx2+6Kp2OGYsHR+TMwHjXKTcIeuFcdQ=;
	b=b7MN18W6NvNVPdNNd1HDHVUpzCbXk5aYorZ1BwKz3cWG4KMld5IQrW0eJMB9vJ
	n3SmiLtlhb7hMXUGJQ7/Ef/KrW27u9hm524v2KyfC0Iyg2SYHpR4MP+Fo+1JwVLJ
	tFSCvT8X3kmBrBWx5/qMFYun94zHTrMDrWahoRj9lcZNE=
Received: from dragon (unknown [183.213.196.200])
	by smtp1 (Coremail) with SMTP id ClUQrAB3PCFPR9tlGcVXBA--.20415S3;
	Sun, 25 Feb 2024 21:57:36 +0800 (CST)
Date: Sun, 25 Feb 2024 21:57:35 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 15/16] dt-bindings: arm: add UNI-T UTi260B
Message-ID: <ZdtHT2dm36/Tpz3F@dragon>
References: <20240224213240.1854709-1-sre@kernel.org>
 <20240224213240.1854709-16-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224213240.1854709-16-sre@kernel.org>
X-CM-TRANSID:ClUQrAB3PCFPR9tlGcVXBA--.20415S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUaCJmUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDQKPZVszXQqBVQABsP

On Sat, Feb 24, 2024 at 10:29:47PM +0100, Sebastian Reichel wrote:
> Add compatible value for i.MX6ULL based UNI-T UTi260B thermal camera.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Applied, thanks!


