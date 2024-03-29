Return-Path: <linux-kernel+bounces-124078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06CB8911E1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC9951C24712
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FA638F87;
	Fri, 29 Mar 2024 03:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Kxoaro4C"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A5B364D4;
	Fri, 29 Mar 2024 03:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711682398; cv=none; b=BHY3p53gcFsP7wFV9dcXwLaKhUOie3G6+e59GOaadMzu4BaMd0pBS4UMkJde+DR8yUaIQ4UmhqZ74CleJU6Pk3RD/Whghczo5wo2irKA56FLy3L/0pfhjyRkVQFKLUEdtah3VVr2MnGsGjDUrq3+KvFWi9blZT+3pF8nLFlOQFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711682398; c=relaxed/simple;
	bh=exObhU+NPhsrphGqdTFlopH3qXjgSIhlXiSsXlX2p5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kegl/xptCTHy0hf4nvP05v/w0TxrFxCP5VnIdlUu1/QjgU9Vb0sop7S5AD/1gHUUPliAjb1PooQH8QhYceAqMsfAaFq8BZBKooXysWR11uC7qYKjfkppi1J2/IijZYL26blji3ylcMNKn6Vq98+mmRnyc8WAhYGXAnSuvng8DQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Kxoaro4C; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=h8cOZy/XmPaW8U15xIsY8Qi7DKjXQPidiqYs2w/rIm8=;
	b=Kxoaro4CBxsiMM6cSL7pQIQDb5AumCfW9J3fXMxkI3yX69GQt46stjvHdr7egl
	L4q6mwLTvWR6DUPs4hxhr99/RxA1vd5iYbtUuKeE0g8E8wli0n0Xc/JqPYiwzCms
	CBjCZ5DZg77H88HU7RikpCvJVrJ4j07QvM+ZjQIb5OItg=
Received: from dragon (unknown [183.213.196.225])
	by smtp1 (Coremail) with SMTP id ClUQrAAXnw4yMwZmLmJdAQ--.20927S3;
	Fri, 29 Mar 2024 11:19:15 +0800 (CST)
Date: Fri, 29 Mar 2024 11:19:14 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Adam Ford <aford173@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
	aford@beaconembedded.com, Lucas Stach <l.stach@pengutronix.de>,
	Marek Vasut <marex@denx.de>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 3/6] arm64: dts: imx8mp: add HDMI power-domains
Message-ID: <ZgYzMirCta6FbD0I@dragon>
References: <20240227220444.77566-1-aford173@gmail.com>
 <20240227220444.77566-4-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227220444.77566-4-aford173@gmail.com>
X-CM-TRANSID:ClUQrAAXnw4yMwZmLmJdAQ--.20927S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVaZXUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDROwZVszXXHD-QAAsx

On Tue, Feb 27, 2024 at 04:04:37PM -0600, Adam Ford wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> This adds the PGC and HDMI blk-ctrl nodes providing power control for
> HDMI subsystem peripherals.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Tested-by: Marek Vasut <marex@denx.de>
> Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Applied 3 ~ 6, thanks!


