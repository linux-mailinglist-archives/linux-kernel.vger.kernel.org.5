Return-Path: <linux-kernel+bounces-54726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4ADD84B2ED
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61FFAB2644A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9F21292CF;
	Tue,  6 Feb 2024 10:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="bdOP8/s2"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3977C537FA;
	Tue,  6 Feb 2024 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217076; cv=none; b=CThFdIUSj3i5rH3voKNVDZ7f0WbtQ7cho+eB/9+ZPxCaqQdtOMspOyIJhizsEfsfQ0hy1C7YxkuBScNxGNWxP4Nowr1sjjl1uPx72bSwfhHd7ze9OZE+fsirruPsRDx6UqRjnogBbK6R8zjIMlAi39ric+PF5IV9U3X0LWnvkQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217076; c=relaxed/simple;
	bh=9mE0Q4jvlw8CR8FY459hojqXRI2e6y25B6T57rt5+gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+67rpQR70GOGRUSpcS0rSg8LFfd4nqqhTdfMp1y++AMGIaTcJIvFoSWPX9knbAghsn0fdorNDKNH6uBHfRE7G/oXjZpxN5uUvvvB+EQZ1+35ipKlaUmS+mPy95KJsZdzXci924By1cmo04s5kIlF9BrLD12Rlg6e6xRsEp2Gz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=bdOP8/s2; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=8IsNQsKHtVb71ghYcVFDX4vmLW28dBIyYiAv6/NlwF0=;
	b=bdOP8/s22of9m0BqzRC7Lu4gHR2E72YmGX4ZtYejmk9/Tkkllf2wVw72x0DpV1
	WD9Lm/QfUwg3CKljgxS2KWZGl1osqejzaMOhZSOOACFgDlWii9Tq+vS7Tek6iEb8
	vOobR/370HlWdCRqCD4rYlWfnhvBsD2S2fEL+BrYuD/GA=
Received: from dragon (unknown [183.213.196.254])
	by smtp2 (Coremail) with SMTP id C1UQrADHrwWAEMJlZ3ACAw--.34782S3;
	Tue, 06 Feb 2024 18:57:05 +0800 (CST)
Date: Tue, 6 Feb 2024 18:57:03 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com
Subject: Re: [PATCH v2 1/2] arm64: dts: imx8mm-evk: Add PDM micphone sound
 card support
Message-ID: <ZcIQf6qvoDIYj+6v@dragon>
References: <1707098664-23265-1-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1707098664-23265-1-git-send-email-shengjiu.wang@nxp.com>
X-CM-TRANSID:C1UQrADHrwWAEMJlZ3ACAw--.34782S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU-bAwUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDwF8ZVnxccIVEAAAsJ

On Mon, Feb 05, 2024 at 10:04:23AM +0800, Shengjiu Wang wrote:
> Add PDM micphone sound card support, configure the pinmux.
> 
> This sound card supports recording sound from PDM micphone
> and convert the PDM format data to PCM data.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Applied both, thanks!


