Return-Path: <linux-kernel+bounces-152725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041398AC37C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70C8BB211D8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 04:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568401643A;
	Mon, 22 Apr 2024 04:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="YkjrfQm1"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA382F5E;
	Mon, 22 Apr 2024 04:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713761114; cv=none; b=R+gxvm4IomDkacYbvtujPzz3cq7gRMF/Ti0ItYbLXuvJAphhwbDXM3JMO2x6kSgoW8oKD3SGXKqnTeB5akfpc9kq9sTFgZsWaO1HmQCan1ZkM5Y3X30Ij30cjGTsf5PsqhXEul85W8o7Zggwx1zhPbIe3KexXoVL4OxGAtkEAj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713761114; c=relaxed/simple;
	bh=0tVdYhSFZd+R0p/3AqXpEUYU6mP6piktAZjdODdTH4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJ2J9uhdIiI2L4E9G8lNNUqMFInajaof6FpBcfkhbckZYDX0975G1NBrnFkzo4k1+gko7kdM4+pJnuGgsY0zE8L3ScPRBQ0JkppGmL6DQm+1OEx9fgIjardyknBN99q1MY0ObDLBCd3IGGMw9cw/ZgRR1p/SGXqW9mKgOHU+XgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=YkjrfQm1; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=czzqX/3IzFkEIp0p1i1A3YnyDqpHYaq87jkvP9JeXuY=;
	b=YkjrfQm19MJBU4eR6ETmk/GjgmyFV9ATqxZUIhiE3P9bCsURFw4dewklcxJgOi
	g4gHCTagPNHDYw3VdbCci0dNafkdKQ5DM+WTbOceJXWzFHie5l8tCmuVMuOo8N6G
	B3P2k3121kQe2hA3q9ZZQir1w3IfN1ettweBQ1kFQ98og=
Received: from dragon (unknown [223.68.79.243])
	by smtp2 (Coremail) with SMTP id C1UQrAD3_1Ax6yVm0+syBA--.56737S3;
	Mon, 22 Apr 2024 12:44:34 +0800 (CST)
Date: Mon, 22 Apr 2024 12:44:33 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Mirela Rabulea <mirela.rabulea@nxp.com>
Cc: shawnguo@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, festevam@denx.de,
	festevam@gmail.com, alexander.stein@ew.tq-group.com,
	Frank.li@nxp.com, ming.qian@nxp.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, mchehab@kernel.org,
	hverkuil@xs4all.nl, linux-media@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] arm64: dts: imx8-ss-img: Remove JPEG clock-names
Message-ID: <ZiXrMUmHu2xvvwjs@dragon>
References: <20240408120654.1196880-1-mirela.rabulea@nxp.com>
 <20240408120654.1196880-2-mirela.rabulea@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408120654.1196880-2-mirela.rabulea@nxp.com>
X-CM-TRANSID:C1UQrAD3_1Ax6yVm0+syBA--.56737S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUV75rUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBRPIZVsVCfA03QAAsl

On Mon, Apr 08, 2024 at 03:06:54PM +0300, Mirela Rabulea wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Per nxp,imx8-jpeg.yaml, the clock-names entry is not valid.
> 
> Remove them.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>

When you forward a patch from someone else, you should add your SoB.
I fixed it up and applied the patch.

Shawn


