Return-Path: <linux-kernel+bounces-122472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A7E88F81D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C7E1C24E8B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611114F8A0;
	Thu, 28 Mar 2024 06:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="PrPpJA5M"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F30E4EB4E;
	Thu, 28 Mar 2024 06:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711608681; cv=none; b=d4vAqV3ymEAsmCWK7BWsDc+rJgqPzh2b9YpLycaARk+f4kIcoeOfH3NkJI+G0RCpZ13LIJcjYgAzY/n1tVO9YlrYi099BK4GMvQWUUcTszrsFAxiTaL8Ij+/2RToboZIT5tZ95Ru0rJCRBIfnvFbFXtkwf1DcjLD+NdY7+Xkowo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711608681; c=relaxed/simple;
	bh=DSoYAZRtoHgYM/KynJviZHNN+EVpoG2856a4BtPY744=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjaobA4zBHHQ+5MlMTFYHYgt88uMY1IZmDLfIX3shFoBY1lRqE3mO1Kog3q/xrd4dYzGX3bgc04f9zZ0DhwtZ25Giwy8mqaSEpKxHGPWNtrFNLJ4dF/a/Ue4j3CVIVUpcnrO5Ikdu85l1Jn1/TOLhs9Af6rbwNC5ZfVnqSyM4Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=PrPpJA5M; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=AMl3cfrur7Q30UB4l77cGDONWRYdk/7WxgYJQOmoBp0=;
	b=PrPpJA5Mw2l7vD+441gzUj1wGk4MeBfn/LvEs4QgY+NrH7ThFNfr8+zsu5++II
	Qwck6nheBwXBjaUNoPuic2p3p+IXtQW0UJ2ePXktolCvvG9ffvLqnA7aFklwyXBQ
	gKoB+xpg5lh2Y40NF3rvzRvFAT7TcV1ybxVnrTvzhIUy8=
Received: from dragon (unknown [183.213.196.225])
	by smtp1 (Coremail) with SMTP id ClUQrAD3X09PEwVm2mFOAQ--.32204S3;
	Thu, 28 Mar 2024 14:50:56 +0800 (CST)
Date: Thu, 28 Mar 2024 14:50:55 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6: fix IRQ config of RC5T619
Message-ID: <ZgUTT/sIPhaI2Vol@dragon>
References: <20240225225720.3419129-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225225720.3419129-1-andreas@kemnade.info>
X-CM-TRANSID:ClUQrAD3X09PEwVm2mFOAQ--.32204S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4XTmDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiGBCvZV6NnpnNkwAAsI

On Sun, Feb 25, 2024 at 11:57:20PM +0100, Andreas Kemnade wrote:
> Set interrupt type to level low to correctly describe the hardware and
> do not rely on the driver to do the right thing.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Applied, thanks!


