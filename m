Return-Path: <linux-kernel+bounces-54697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E60384B28E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 811121C22DE7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F3612EBD2;
	Tue,  6 Feb 2024 10:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="p13So/pZ"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631CA1EA76;
	Tue,  6 Feb 2024 10:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707215632; cv=none; b=Nilsxr+i/GSHMP1t1MD8ofTzWr/13HqWIujO4gMnP01ARu65IeKOOD9VC/Uu3QhHEIXOoIOyyVaP0z2R6d2R4hIHdmTKvvVbdFWuQkqSXTQp7bIpDs0wne7pCvHUuLGr5/UA5Ow9zPgZXAnx8zEyUsSotk2d4nnsvqr0/bsZMNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707215632; c=relaxed/simple;
	bh=HHY4bhdN73SL/2Fqw/lzFjTOJ67Mh8SjdXshSo3e+ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvlAMHYTDqI68V5k+AwkrOKNiOM2S3bYMWY1S9OgERsnu2zxGPQFMlZvD5npFCDU7/xTzo4F9C76Tai7x+3sRWOfnoLBW2YuMeplNNBUzbu9aREFR/88Dkxb602pI0g+9xFwZfkScBjL35oEKGawGqVHkjP1YXZKSIPE8Dr4KBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=p13So/pZ; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=1LM6ZCgi9/9FxX5GU9EoatoU0andrc/FxDxfy6wmO3E=;
	b=p13So/pZ76cSBNtyUzfNFNsbGWn+k7pz+XIA31XwrLmAsTR3+GHbNAxVeZC3xK
	jB9n23838zND+DwxQXyWBDnI5KtIHzOUKWFK/5V7Br/jExvRBquY/kTnbtcqcQ+0
	AQYGmjxp+xdFRAM19ECaRfvSYt2FolJbI5NVhPm0fzS5M=
Received: from dragon (unknown [183.213.196.254])
	by smtp1 (Coremail) with SMTP id ClUQrAAnJ+jJCsJlkm7+Ag--.16149S3;
	Tue, 06 Feb 2024 18:32:42 +0800 (CST)
Date: Tue, 6 Feb 2024 18:32:40 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	leoyang.li@nxp.com, hvilleneuve@dimonoff.com,
	krzysztof.kozlowski@linaro.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	andy.shevchenko@gmail.com
Subject: Re: [PATCH v3 0/2] board: imx8mn-rve-gateway: fix compatible
 description
Message-ID: <ZcIKyL7l2bIN3KeK@dragon>
References: <20240125165935.886992-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125165935.886992-1-hugo@hugovil.com>
X-CM-TRANSID:ClUQrAAnJ+jJCsJlkm7+Ag--.16149S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIzB-DUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiFQp8ZV6Nm3UP8wAAsH

On Thu, Jan 25, 2024 at 11:59:33AM -0500, Hugo Villeneuve wrote:
> Hugo Villeneuve (2):
>   dt-bindings: arm: fsl: remove redundant company name
>   arm64: dts: imx8mn-rve-gateway: remove redundant company name

Applied both, thanks!


