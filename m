Return-Path: <linux-kernel+bounces-152726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4758AC380
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B7D2811B3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 04:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A0D14AB8;
	Mon, 22 Apr 2024 04:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="AOQxH84i"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A417A13AD8;
	Mon, 22 Apr 2024 04:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713761251; cv=none; b=UjZqxrigWzH9QH9+CD65OWAeipd11G0hf7hkWcPzhDD1mk6csFwEoM/n4ZZKJaP1NDn8YiKNON8wC49SjInC1hkH6caYXzkerNjyBLSVH/l1rEXfGeMruc2WuiHOY7g1yq1yEn+47wM8zwu1KcAs6GJkgrdgxSEoGIgSh0kzW6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713761251; c=relaxed/simple;
	bh=O5AhC9Oai8ejuwYTbIzKPn+tBGuRCa6rVo1NLxcf7PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqsU/XMk/by8P7imnFLbIN7rkfcJPjUA49pSTfOED4oCNZgAcUtDRe64O8fuwIqt32dbRmRuhwA98LLFxdb/SmkPS5cDnmpxbgx4Ciwfosiy68hrktczYSGasMEmQYrQGIqDbw8R9TgrYRZYXDLKd0iXKDAf7+R8Zy5DnJCSadw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=AOQxH84i; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=bruPpaRPsO8HMCfcdLVi2EDHWOtroBLaqQU/MSt+mkc=;
	b=AOQxH84iMDt0Je0aFb0rExZqJ4XofJFrwTqY7uLMl4/hTySVMPwVx/L0K0Nnp4
	RfUnNDlSWeMSanAL9kWc7+cdkhvWD3IR8feUHQ3NrFgz2XEq5Xw+TInPtOlD/a3g
	s2Sk9LljrS57Cqztvr4WPN/ijpLVjgHNqbz43N5qFwOP0=
Received: from dragon (unknown [223.68.79.243])
	by smtp1 (Coremail) with SMTP id ClUQrAAHbvrH6yVma04sAw--.24483S3;
	Mon, 22 Apr 2024 12:47:04 +0800 (CST)
Date: Mon, 22 Apr 2024 12:47:03 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Ian Ray <ian.ray@gehealthcare.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/2] arm64: dts: imx8mp-msc-sm2s: correct i2c{1..6}
 pad drive strength
Message-ID: <ZiXrx9I7YcB7tSWW@dragon>
References: <20240410105612.982-1-ian.ray@gehealthcare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410105612.982-1-ian.ray@gehealthcare.com>
X-CM-TRANSID:ClUQrAAHbvrH6yVma04sAw--.24483S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUI5fHUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDwjIZVnxcqAlJgAAsT

On Wed, Apr 10, 2024 at 01:56:10PM +0300, Ian Ray wrote:
> Adjust i2c drive strength based on latest Avnet BSP.
> 
> Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>

Applied both, thanks!


