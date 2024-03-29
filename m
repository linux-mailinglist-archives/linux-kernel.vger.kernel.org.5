Return-Path: <linux-kernel+bounces-124100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBE289123A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30CBC288A68
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A99839FFB;
	Fri, 29 Mar 2024 04:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="m3BOdNyP"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1179C748F;
	Fri, 29 Mar 2024 04:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711684865; cv=none; b=XjAipSPMUd8+k8KISW658Fg7mnxOd24EM9mIgnoRyw37vXp04nPX1gzli0wde1G+W7nmL4svH33Wz1TAVEceBdRhACJ+SI4m+llbraCjtnY4yuJfJzgCWgvpQXoXJuOog8+VWvU2Rp2MuIv2rhqEEW38dQ+VuEsmqfzjT0TdS/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711684865; c=relaxed/simple;
	bh=KdV58+A7jq70hTmNjuQ1ANcEK9iaNM8yLy6/dYo3gVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRx2/KodDL8ej9KlieMBwdbpFxeme32ofDtTgjhyKkr+kCt7mn8xOnFgAC7SXYvIuULMx1JRTH/VlUWY7f38zsQcR1N3NazSLYC9ELOLRruv5j/qFftrKzlp3YGbPfxH0mI93r9T+4zlKQhqvyEN151J7dwwngefwPQzNdGBeSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=m3BOdNyP; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=pd7LA3hSubgrgum4MhQwV6M3OozzdvdEm0xgPLCBy6o=;
	b=m3BOdNyPdY/I2Y4D0LUOYKWoDbh6cNtUx5VVgDu01vFWRDVuC/soRZ2Vq802ME
	/ZHnC9+8unSmJ/dqAQmyXhqKJluMq13ZRyM/zEkxQctSEaJVjj3kvPR6NRDQau9K
	RTUYjoWdEZ0zGOCSUNGVsPr+z+AoSllGQsWGDnHK2SbXA=
Received: from dragon (unknown [183.213.196.225])
	by smtp1 (Coremail) with SMTP id ClUQrADnr0HZPAZmOw1eAQ--.13575S3;
	Fri, 29 Mar 2024 12:00:26 +0800 (CST)
Date: Fri, 29 Mar 2024 12:00:24 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Parthiban Nallathambi <parthiban@linumiz.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] ARM: dts: imx6ull: add seeed studio NPi dev board
Message-ID: <ZgY82LADJS9FuvY6@dragon>
References: <20240229082337.3090778-1-parthiban@linumiz.com>
 <20240229082337.3090778-2-parthiban@linumiz.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229082337.3090778-2-parthiban@linumiz.com>
X-CM-TRANSID:ClUQrADnr0HZPAZmOw1eAQ--.13575S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Wr45Zw1fXFyUuF17WrWxWFg_yoW8JrWDpr
	WxuFs8G397GFy2y34rA3WUW3s8Aa1fG340vry3uFyUKrZ2qa18CrnYgwsxJas8ZF40y3yr
	tF1FgF1UW34DuF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jO8nOUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBQWwZVsVCarIGQABso

On Thu, Feb 29, 2024 at 01:53:37PM +0530, Parthiban Nallathambi wrote:
> Add support for Seed Stuidos NPi i.MX6ULL SoM equipped with
> 512MB RAM and 8GB eMMC or 512MB NAND flash. Development
> board comes with either eMMC or NAND based SoM with peripheral
> interfaces like 2 x ethernet, 2 x USB, LCD, CSI and more.
> 
> Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
> ---
>  arch/arm/boot/dts/nxp/imx/Makefile            |   2 +
>  .../imx/imx6ull-seeed-npi-dev-board-emmc.dts  |  19 +
>  .../imx/imx6ull-seeed-npi-dev-board-nand.dts  |  19 +
>  .../nxp/imx/imx6ull-seeed-npi-dev-board.dtsi  | 424 ++++++++++++++++++
>  .../boot/dts/nxp/imx/imx6ull-seeed-npi.dtsi   | 155 +++++++
>  5 files changed, 619 insertions(+)
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board-emmc.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board-nand.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board.dtsi
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi.dtsi

Could you elaborate a bit the point of splitting imx6ull-seeed-npi.dtsi
and imx6ull-seeed-npi-dev-board.dtsi?  Why cannot they be a single file?

Shawn


