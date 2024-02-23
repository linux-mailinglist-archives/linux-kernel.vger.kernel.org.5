Return-Path: <linux-kernel+bounces-79314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4478620AB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1FB1F23494
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B937C14DFD6;
	Fri, 23 Feb 2024 23:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="LYtYRFTl"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA4914D42B;
	Fri, 23 Feb 2024 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708731059; cv=none; b=En6kC9qgzH7rCmYMls0OINVF61bbH+dsmNvu8UWbtWMo9KVf0M+dlnQLJCznWBCjV1+lrKIIgcNiX2429LKcYS15/J/ub095VtJPyykNr+83imR1eiGI67ZfgM5ySm+YTG5Vrn7SGQhlfZcEjq2fvfdSYutzEGV/zVs3F48QWY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708731059; c=relaxed/simple;
	bh=Dls6Z90ot0nsieIIxV7nVTDnfpxy0B7m0BRTcuH40iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvYMdeuUdQz1FNoTVpj+2P2if2tMkbvK9hM2sjhx6LLU/s3gerBX9avkW+xARe6EusxpLwp2Xi6AgBemdzsbZBPOYZ9HLmFutywK0sakkXpBNW1xVZdTb5K4Zvn8/DBGnh49Nt/rljNuMcKYjCNI96zDZbWWGNhSttDDkZAsk5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=LYtYRFTl; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=amwAWmFtC6C9Xm5MB+erBDihO0nZs63fdOhlOAyvBWM=;
	b=LYtYRFTlLbx0SQoBX/YNCA086FSjLZNkPtvyosTc2S05AUJMZ5E4jyAG7nw550
	2GOBsKOhE7Hxmue1dRuFLvsw8vbyLkeVKwwz5BKVPNZKe2il68IJVkRu31J1lX8D
	EbPGOc865jbX3tnlIkglFJYd3AScP2e0iOjI7bzL7uT0I=
Received: from dragon (unknown [183.213.196.200])
	by smtp2 (Coremail) with SMTP id C1UQrACXfwWQKtlliXY8BA--.65296S3;
	Sat, 24 Feb 2024 07:30:25 +0800 (CST)
Date: Sat, 24 Feb 2024 07:30:24 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com
Subject: Re: [PATCH] arm64: dts: freescale: minor whitespace cleanup
Message-ID: <ZdkqkFjL6U9zEpX7@dragon>
References: <20240208105217.128748-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208105217.128748-1-krzysztof.kozlowski@linaro.org>
X-CM-TRANSID:C1UQrACXfwWQKtlliXY8BA--.65296S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIxwIUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiFRGNZV6Nm6LFUgAAsR

On Thu, Feb 08, 2024 at 11:52:17AM +0100, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space before '{'
> character.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks!


