Return-Path: <linux-kernel+bounces-80085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2372B862A8F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 14:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F73281BB0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 13:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019D11426F;
	Sun, 25 Feb 2024 13:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="O/4eoxQW"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B102113FF6;
	Sun, 25 Feb 2024 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708869432; cv=none; b=pJF2yRi3kLZGtUnh1dLU5jfOgTrKP6gJJLkx6V9q0kHXhq3ohSf2ElKqL/Hd6tC7j4P2ShuP78LNQ35qZXi3ciduoC8Gu1PrN+GH/ttlMlkZnfP/bdscluWzrokMeIazQQohFULgXW/68c5wf8A8/DugM8KLkShMwrWNe1JtpoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708869432; c=relaxed/simple;
	bh=Y5V04YIMrXyVAQTp9w7j27myasXGn8hofHY6HfZqgo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knPer5W99p3RU0kJKP1GopBCl2Uaa5kqbOGUBeQO15aOMeZLmbvdH0hmLnthjvNDuABSVC0Z7aLUTm0RydV05AQg806tOoOoD8m6AfF1fcpBmf/uY58uhsdt/cLB/OZNKcNCkxnJTMQyGJc3KpnnMCG+RJE2pbE0MPTdjcW1HXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=O/4eoxQW; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=BBcIfipgVkDfL7D0t9PhLeKx0v9Zcyil9n1gX6X4j/8=;
	b=O/4eoxQWwbRvHllcRrKZECzaP+h/mFg2bXjuwHWSdxQNHVizmEwhlmiT/TXb4y
	PBh+qRLhgDfaYLDg8VW+AgMUd5RdqJ63xJfNLS4YfM8cQUojuQKjHmJ6y7k9LsHE
	TP5QJGquridZoxpP+7bXhmYUEcC5Yzdg2Y06jAmPGGO9E=
Received: from dragon (unknown [183.213.196.200])
	by smtp2 (Coremail) with SMTP id C1UQrADXfy8AR9tls7ZWBA--.31462S3;
	Sun, 25 Feb 2024 21:56:18 +0800 (CST)
Date: Sun, 25 Feb 2024 21:56:16 +0800
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
Subject: Re: [PATCH v4 13/16] ARM: dts: nxp: imx: fix weim node name
Message-ID: <ZdtHAF6+fTYOm2co@dragon>
References: <20240224213240.1854709-1-sre@kernel.org>
 <20240224213240.1854709-14-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224213240.1854709-14-sre@kernel.org>
X-CM-TRANSID:C1UQrADXfy8AR9tls7ZWBA--.31462S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUfcTmDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDwKPZVnxcfN+BQAAs2

On Sat, Feb 24, 2024 at 10:29:45PM +0100, Sebastian Reichel wrote:
> DT node names should be generic, so replace "weim" node name with
> "memory-controller" in all i.MX SoC DT files.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Applied, thanks!


