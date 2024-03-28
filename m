Return-Path: <linux-kernel+bounces-122923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1879A88FF8B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9234028F685
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDCD7D3F5;
	Thu, 28 Mar 2024 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="GHIn1TOp"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DB065BAD;
	Thu, 28 Mar 2024 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711630160; cv=none; b=obgYZqTha1yniy0PivOgcU0/VGY9Q7rczmPatso7FJXwBTia/UtVgV0ZB7U0JSolZ1gtQAaVIw/9/t78iyM5kSfpHkrA9xCfB/RDzX88hE3nORlWMoZpAUMRQRMJqZiNzbyACTsR0ziGK/6+EJs/S0mUUWoFH47LnCmszVtOVYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711630160; c=relaxed/simple;
	bh=R5BfQ+x6QG4BIHt6F7DsPp94Zw24AxagCQdjFgQ3hDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sc0IZvd3bJXDZU72O6ZGrjE7kOCnyNSi8X2R5wu9gXfp5QnwpFFDfB6Pc9TnVOsoS0hBV9BU2ecGEZJaRxzsypy7Mm6+Z3a2G4ml1szRdZ5DmJOwcFTO3n/OzXGODG0rAzut4fLURugTUS479JLY3SN2IrqRtUANJoVmi1WKlXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=GHIn1TOp; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=QyrTRg0Emt1k1i/xXDJd/PDVGiHySINFxWmGwEzJxXw=;
	b=GHIn1TOp8fCUZoSZSNsPJbz5oz6Nu7q8knu26C2SS1Hash/gRkd4+goJTEccc/
	iCHyZzuUzjTgK82cHl7FrSNGr2XujTaA26BkLr88pSrTuNXcxP8avQXTP+O8YERo
	T3muZJYgecZ0SGYbxettfd2ID+Iahjs2rSS3r9PcD+fQ8=
Received: from dragon (unknown [183.213.196.225])
	by smtp2 (Coremail) with SMTP id C1UQrAD3H3z+ZgVm3JFZAg--.35373S3;
	Thu, 28 Mar 2024 20:48:00 +0800 (CST)
Date: Thu, 28 Mar 2024 20:47:58 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: haibo.chen@nxp.com, jic23@kernel.org, lars@metafoo.de, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-imx@nxp.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/2] arm64: dts: imx93: drop the 4th interrupt for ADC
Message-ID: <ZgVm/g04jK+hTNAV@dragon>
References: <20240226130826.3824251-1-peng.fan@oss.nxp.com>
 <20240226130826.3824251-2-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226130826.3824251-2-peng.fan@oss.nxp.com>
X-CM-TRANSID:C1UQrAD3H3z+ZgVm3JFZAg--.35373S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVf-BDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiGBCvZV6NnpnNkwABsJ

On Mon, Feb 26, 2024 at 09:08:26PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Per i.MX93 Reference Mannual Rev.4, 12/2023, there is no interrupt 268,
> drop it.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks!


