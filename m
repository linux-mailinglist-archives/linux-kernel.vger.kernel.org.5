Return-Path: <linux-kernel+bounces-152727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0938D8AC384
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44B71F21571
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 04:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3A2168B1;
	Mon, 22 Apr 2024 04:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="nF1cX8YC"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEB714285;
	Mon, 22 Apr 2024 04:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713761561; cv=none; b=CEi9BSIIGuU5uaFWzdb9lc37CJ6qKbpNeB5xGCRtQW/KNC8fWw+0nMhsLEr37QQiHmANqCnbsEzwSU4ezAo6gTj/lQsoQak9DXfxfq/30CzMuJiWZmqRhjLIDkwVrphyXLkP+Ph1mC52m831vetNiLWkSrApWA34A9GkSuIpUnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713761561; c=relaxed/simple;
	bh=3TKpaHNbYlQ7W5Tewx88xVlKpd8fLXZgs5BUssoZIYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3G23/jMyh8/s0AicwPJ9pG35HB0bC2ExF5RYEG2tzhNQs21JWcrtDS308Lig+9KrGKTQgUEF8ZpH6+ZVcKb/opjXfh7shtii5dAJgOptfEgf4Y7Egk4yCTwU3gBJGFVgd4TlelwW9HG7px7XIHahs3dJYTGGZfROqIMeYf7+ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=nF1cX8YC; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=4uRiF1GyQB9YD8QQ1libjMIe78m2rOWJf5vFvOBAwyA=;
	b=nF1cX8YCW2rwTTXBYdeDiezsnSrNExmnHtQ75z3cRXRTGZ3WEWNlJuvw41gzFs
	oKAQdmL+0dH5K9H2f/uYby9f6K1OCho+0G37tygrbiLrtc+ZL0qRwORz6X6XSeq6
	4hVpVI9gGHOFWqV/fmF5H5WfEATGwpShyKt4FtU1yRb2Y=
Received: from dragon (unknown [223.68.79.243])
	by smtp1 (Coremail) with SMTP id ClUQrAAHbvrf7CVmXF0sAw--.24511S3;
	Mon, 22 Apr 2024 12:51:44 +0800 (CST)
Date: Mon, 22 Apr 2024 12:51:43 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shengjiu.wang@gmail.com, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/2] ARM: dts: imx6: exchange fallback and specific
 compatible string
Message-ID: <ZiXs30oAOjJkkr1e@dragon>
References: <1712894212-32283-1-git-send-email-shengjiu.wang@nxp.com>
 <1712894212-32283-3-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1712894212-32283-3-git-send-email-shengjiu.wang@nxp.com>
X-CM-TRANSID:ClUQrAAHbvrf7CVmXF0sAw--.24511S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVDDGUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDwjIZVnxcqAlJgABsS

On Fri, Apr 12, 2024 at 11:56:52AM +0800, Shengjiu Wang wrote:
> Exchange fallback and specific compatible string for spdif sound card.
> The specific compatible string needs to be in first place, the fallback
> compatible string needs to be in the end.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied, thanks!


