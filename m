Return-Path: <linux-kernel+bounces-79961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA5C8628FD
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 04:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499E41C20C7C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F966110;
	Sun, 25 Feb 2024 03:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="S0nkS04G"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47241944C;
	Sun, 25 Feb 2024 03:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708831300; cv=none; b=kfX7rmjhBaQ7zRAKK9Mw/jyRWhXtHrTVqHsrnBCm2I0WuhykXa+xJx19vrf5z358+9yFX07F30llXOpo4MoFO+UpOptlfFuYOd4rynhyWTtlcmKvp/m5SUB5LZoXv1KLeQhsYohOMMSePo0UixkYLNgP8jOPl0Vb+7oehALCoVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708831300; c=relaxed/simple;
	bh=YraPk7smD0hQddwyLkeAaE9KjkyIqDsL6O5HG4fCQ4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVPH+pWauAgSSSXpWGDurhHl42C7/DEW8TwsEVC8Rpt0F0mnXCCmhbu6ORF3aFu/PHsEeeFeaGPWeALZDrMiZWb//GTIGMniwiFdvwvJ0l6ao8p+R/kBBvEtb0LpPejeJWg1F7qVq+ewJ1WLwiBrGpf0iX7taPon98Vf/Ll2ObA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=S0nkS04G; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=drcgo8XG11s51dMGDsNkek/Z+Rb1gqBzJXxZY7NXX1k=;
	b=S0nkS04Gcb5rk0EGre0XDvRtnzDhbUOgPSHSmxJkrL0T89SNAFQh17fC75LID/
	HmJ4jrBmIKSgQYPA8We/PIlv0aoHTxavyk1X02//EkvDwC8I3VPPtCDNL9/GAV9n
	EEhcepEuIpt2DREvelMtzfZCFjK3IRKgp8x5zVZuKADnQ=
Received: from dragon (unknown [183.213.196.200])
	by smtp2 (Coremail) with SMTP id C1UQrADnz4kestplTG5PBA--.18950S3;
	Sun, 25 Feb 2024 11:21:03 +0800 (CST)
Date: Sun, 25 Feb 2024 11:21:02 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Adam Ford <aford173@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mp-beacon: Configure multiple queues on
 eqos
Message-ID: <ZdqyHj+A+BbPJMW9@dragon>
References: <20240211135535.68516-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211135535.68516-1-aford173@gmail.com>
X-CM-TRANSID:C1UQrADnz4kestplTG5PBA--.18950S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVLIDUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDg+PZVszYWG3kAABsl

On Sun, Feb 11, 2024 at 07:55:34AM -0600, Adam Ford wrote:
> The imx8mp-beacon SOM has an integrated PHY connected to
> the EQOS ethernet controller which can support up to five
> queues.  Configure these queues in the same manor as done
> on the imx8mp-evk.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks!


