Return-Path: <linux-kernel+bounces-152748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA868AC3C9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1BA28286A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE4618059;
	Mon, 22 Apr 2024 05:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="S4a+wRNB"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F1CEEDB;
	Mon, 22 Apr 2024 05:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713764301; cv=none; b=nlHZUWE6K92AHcuBUBlsbWIgLah3YVR1dXMCpClle93GdGojahjrYrHtnqQku+y9ck4e92uEo5Un50LtbPzLttnyTj42rC0erx0ZrOpHhudNLItaqJs3vTi6bBq84xQQMibMY2WcpaldtYQe8PPkOBm56r7POyJOyIB6YQrLbvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713764301; c=relaxed/simple;
	bh=UvqDzdu2TTJTK4OdDH0/3J+sp3kr4bzNlQFZ8kZqx6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+LXNkgNu5Nbs7WM/TLYbKUPr/fUMT/XXpgh7+XcKs/25W1eaHpzT9v8OATgQTgc+iQQFXuY8agYGgjN417HK2i3GhtTC/xekvBPDXOvz0N8DppKphqM9IHjfCMFs/jl23h8bnmefRTnDr08RSp+/M/kUhMOSZ2YzQYHTny08+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=S4a+wRNB; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=U7ZXAal9WFWFi5DDqMaGeebZSbq/tx1oQT0cheVJWL0=;
	b=S4a+wRNBikEbjIczCsK7YbINnGaDrT4tQCGqzmieL4zTt8BovudHH6XlbNhL12
	Iy6u3HMGLs1u4NBEc7o4HLbeLWsQKts+LIvND1oYm66aeuFh+4cUuP36xS6nAoId
	O/i3wmAJiFudzy2GrathB1ubH8vgAol1jMJ6Q5kkchu4E=
Received: from dragon (unknown [223.68.79.243])
	by smtp1 (Coremail) with SMTP id ClUQrAA3vw6C9yVmPxMtAw--.30495S3;
	Mon, 22 Apr 2024 13:37:08 +0800 (CST)
Date: Mon, 22 Apr 2024 13:37:06 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: Re: [PATCH] arm64: dts: freescale: imx8m[mp]-verdin: Update audio
 card name
Message-ID: <ZiX3glaq0+cTywEx@dragon>
References: <20240411161441.70262-1-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411161441.70262-1-hiagofranco@gmail.com>
X-CM-TRANSID:ClUQrAA3vw6C9yVmPxMtAw--.30495S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUs4EEUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDQTIZVszXbdSjQAAs5

On Thu, Apr 11, 2024 at 01:14:41PM -0300, Hiago De Franco wrote:
> From: Hiago De Franco <hiago.franco@toradex.com>
> 
> On the Dahlia and Development carrier boards for the Verdin family
> (iMX8MM and iMX8MP), WM8904 and NAU8822 codecs are used. Instead of
> module-specific names, switch to more generic names based on the codec
> employed on the carrier board itself.
> 
> This modification facilitates access to ALSA card names, ensuring
> consistency across iMX8MP and iMX8MM, as they share the same carrier
> board.
> 
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>

Applied, thanks!


