Return-Path: <linux-kernel+bounces-152720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B4C8AC362
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7A81C21197
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 04:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECF6175AB;
	Mon, 22 Apr 2024 04:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="g9U64GRU"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E03F168BD;
	Mon, 22 Apr 2024 04:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713759155; cv=none; b=XDbxhDra8irArKbcETmtAosqlX1vI5fi2dQkkN8iY74oe7aRfW650YhCgpI4LZ3S5PFBOmj3A4shlhGVz+CUjm2h2GBn6dKJTYmjX+0VSywhvxFT1YF+SKhIYh5CbdDr4lhIb1HwsSqEzMV1fjm44ytQC4A5lQaAjipVMGRWDX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713759155; c=relaxed/simple;
	bh=zWz7+Hjq7yMUV/hHtMEJ6ElsQCYVh1fQEZy8b6SY/U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGF1nLaMcgIUeaLDrRdlxYV481V/LIpvXOs9CoYsTYrOS5yjaQmBCvPGBgpNelPHd8Dcz+W6NlOncv4qW6TZkozGlBUO8G+q1Rhxn59LU1TVjgYGu/lvi3RPZsavzwTPDjcqGTakzuykkEQSf7l49AmaEqAaJ7pnLnJH8vEk9qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=g9U64GRU; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=o4VJsnjvweSLkqVJ0AMKt6YXK4kE+T99ZNzy7Ggsjpw=;
	b=g9U64GRU+Y53pjIEfOKvxBjZfbms22nTyCsVnyt16MBT1zi+qNDMqJWq7NA05Z
	gbF3o4gddffFS5ERvJGXBVGTctAHyMObQkThU9yPY2lgPmWuiaNfgYNsMRSvj5p7
	fE2kVqIrG/LQZ7yAXG3YukbV06p+8lISxw/REjzX/zG4M=
Received: from dragon (unknown [223.68.79.243])
	by smtp2 (Coremail) with SMTP id C1UQrACHjxCb4yVmAlcyBA--.11221S3;
	Mon, 22 Apr 2024 12:12:12 +0800 (CST)
Date: Mon, 22 Apr 2024 12:12:10 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: imx8mm-var-som-symphony: drop redundant
 status from typec
Message-ID: <ZiXjmgiCO/3FiqsO@dragon>
References: <20240405092819.40994-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405092819.40994-1-krzysztof.kozlowski@linaro.org>
X-CM-TRANSID:C1UQrACHjxCb4yVmAlcyBA--.11221S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUa9NVDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiFRzIZV6NnFMVZAAAsJ

On Fri, Apr 05, 2024 at 11:28:18AM +0200, Krzysztof Kozlowski wrote:
> "okay" is the default status, so drop redundant property from the typec
> node.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied both, thanks!


