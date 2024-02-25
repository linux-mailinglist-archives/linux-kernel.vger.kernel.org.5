Return-Path: <linux-kernel+bounces-80092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA144862AA8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC90281A95
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 14:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7795C134B1;
	Sun, 25 Feb 2024 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="bbdtxajR"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F93C134A5;
	Sun, 25 Feb 2024 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708870617; cv=none; b=Q65dsrtQcc223NXcIn49DDOEejpb58YgS1IMF9auP0rP++6GToErJMF6FgPaKywnl27XJmFRucOnzjuaxVLL3xCSqg5ITc1Eva6/gvDSylYkQiQSWek5p9GuTWkAyyOxO+7lyYv/7QReBxpvb6AJPdZfKyxpgpYnNHMVA2M/KaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708870617; c=relaxed/simple;
	bh=g4jPkP7X+EsAYI60cjkTqW1WzViJ2PvYFmask+nsaG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHBhp+XeiBcOxyxi70X2PTTsl6NdhPeRX1bTddoCwcM9yQkp3x9oLXwVYmrzhsSLWo03ua1RtkPvFtrgxNuyRUgvt1vD1FmY62I772OD142CueNJ+RTOYJ3qkUvwdonG3B9dLTUxXVyy1sfM/1X4fb7NEMBXxatVIIkvLMiKhXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=bbdtxajR; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=IwgfoSTaVLYGnw8I0fogmOLPKGqOp6nR5Z+q8nO/0V8=;
	b=bbdtxajRYydCK9zrt3pvC58RT+GnkKJhlJ/ZYPJHQRZquSoOcdeA5gD/Xo3qOP
	ZQ1/vci8ysfvWoG5OmRJ2kLoaibaAb0vaSfjxaGuwZPE5cqnwh3gJeZA7Ytb0tkP
	PnciMmGrGcS2qcTJJIo3aD3OxJo/xGhxk6AIBaWnR0GO4=
Received: from dragon (unknown [183.213.196.200])
	by smtp2 (Coremail) with SMTP id C1UQrAB3fwidS9tlDetWBA--.11344S3;
	Sun, 25 Feb 2024 22:15:58 +0800 (CST)
Date: Sun, 25 Feb 2024 22:15:57 +0800
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
	linux-kernel@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH v4 16/16] ARM: dts: imx6ull-uti260b: Add board
Message-ID: <ZdtLnV4IutdMbz4S@dragon>
References: <20240224213240.1854709-1-sre@kernel.org>
 <20240224213240.1854709-17-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224213240.1854709-17-sre@kernel.org>
X-CM-TRANSID:C1UQrAB3fwidS9tlDetWBA--.11344S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUawvtDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiFR6PZV6Nm6aC9gAAs7

On Sat, Feb 24, 2024 at 10:29:48PM +0100, Sebastian Reichel wrote:
> Add UNI-T UTi260b thermal camera board.
> 
> Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Can we change the patch subject to something like below?

  ARM: dts: imx: Add UNI-T UTi260b thermal camera board

Shawn


