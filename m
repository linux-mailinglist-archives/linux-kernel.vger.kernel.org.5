Return-Path: <linux-kernel+bounces-80086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D1C862A91
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 14:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5217BB20FF9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 13:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF62313FE7;
	Sun, 25 Feb 2024 13:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="KcRDngPk"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF9613FF6;
	Sun, 25 Feb 2024 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708869465; cv=none; b=exAMI5KMtndrXCluHyrCcrP1pR1mbOYZ8eqafjY2wAFSkL9sMWuN8UOvR++RTr/UtRD7FQt0B5g8THsueF56KOBPWluVDferTPxEM9V3cg5jkYc6QCBIvc0/BWvRXEmk/4/F3EWJSfe3QOYWpkt5NkTioHPkbvEO5a9vfbZybAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708869465; c=relaxed/simple;
	bh=dT6UjOq82OtGv8JhWMCFAAUndjXATg2Q1WbFRoN0Ljc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxIqSBh2WrmWsbQXFMnrIMCd3RONUW/Kyk7Dw8xXv77DiqZoIl47UixWfgaRUkyXd1AQAKoVxEcfPH9wmpVEZKID+64biRbBR6GFdYF8/fxuWudppJJ82jelrE3aPmn58DruWlqCD1bUKssEE7awz3AXEY7kG/qN5R/kMu6cuog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=KcRDngPk; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=s7sgSnML5VETSzdPZXDDSYO56ce74VYbKYjh5xIIj38=;
	b=KcRDngPkoyN89PltDhSZl8Sg9z81AZZ/DB0FRfrbN9YTglpArqYxbECQAlSOGy
	pVM0AK7PPCzfPNhcaWB3IIkLJbrdJWsDNlNQ3wuOnNowTrlgtKeuT1/x1+RMQiAe
	VXVd6u334cqtvW7q7St5FjKt2hNOElqO+b/mAB2iUAJc4=
Received: from dragon (unknown [183.213.196.200])
	by smtp2 (Coremail) with SMTP id C1UQrAC3Pw5BR9tl6LpWBA--.10003S3;
	Sun, 25 Feb 2024 21:57:22 +0800 (CST)
Date: Sun, 25 Feb 2024 21:57:21 +0800
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
Subject: Re: [PATCH v4 14/16] dt-bindings: vendor-prefixes: add UNI-T
Message-ID: <ZdtHQRK3y06pExMt@dragon>
References: <20240224213240.1854709-1-sre@kernel.org>
 <20240224213240.1854709-15-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224213240.1854709-15-sre@kernel.org>
X-CM-TRANSID:C1UQrAC3Pw5BR9tl6LpWBA--.10003S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUaCJmUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDQKPZVszXQqBVQAAsO

On Sat, Feb 24, 2024 at 10:29:46PM +0100, Sebastian Reichel wrote:
> Uni-Trend Technology is a manufacturer of measurement
> and testing tools.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Applied, thanks!


