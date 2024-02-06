Return-Path: <linux-kernel+bounces-54488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E9984AFDF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05CE81F24C02
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8982D12B147;
	Tue,  6 Feb 2024 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="e0eaNymx"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06AC12AAE5;
	Tue,  6 Feb 2024 08:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707207870; cv=none; b=WAB3bGxmesQyq6LCdY3c2OdTHfKWDBpbIVg+0WdTxjVqE6TE4RcPJ9zEwoa4890WGABN+hzYXt9smMJiJTxW5iXz7uEFMo2Q26e6hkvOoWppxS6ac6hmvQY/iXsERHm+feZb6qZdPIdHJG6D7LarUu96TlWVsiad7On+asqVvhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707207870; c=relaxed/simple;
	bh=3rTfeK+5Ypr+qRLrvZMhottSRh7ZVqqWADL419UrUqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8RjZ13d1356ZUVdyIuMasmtIfZ+1VRk5McVbkR0Sw0SjaU5Gl9VZMiX3rSwqJxDUGIJKs3qjUz2yHQtD5I6FVh2RC7LumBm0kGKZeZEDVch9IeuOE7hjaV6Q0wwFcUQC1TpVcr8pTD720WTLIK1Hg1wf6TArD9tWUXvfBDJOJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=e0eaNymx; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=05aE/9eHsUQZ50ME8wmdv/83+oShG2SGhiQl1AxYjJw=;
	b=e0eaNymxBy7OqSXKnovdNrk6BZCrQSm6Io5Fe7VngtvZHWEzKF/MEJXCD9QhWw
	CXJ3jVc/HIZ38GjP3jcTckacciXBdUS3AQenftfji6EN+ETZI0zWxGp7xjuxpqST
	xNm0eadTMrpsUuc0+aJlxY0NJ2nAlDwFVHUoSftF1inPo=
Received: from dragon (unknown [183.213.196.254])
	by smtp2 (Coremail) with SMTP id C1UQrAD3HwiB7MFln1EAAw--.34917S3;
	Tue, 06 Feb 2024 16:23:31 +0800 (CST)
Date: Tue, 6 Feb 2024 16:23:29 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, Li Yang <leoyang.li@nxp.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 0/2] arm64: dts: freescale: imx8qm: add apalis eval
 v1.2 carrier board
Message-ID: <ZcHsgUoiB0JCp6U0@dragon>
References: <20240125101457.9873-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125101457.9873-1-francesco@dolcini.it>
X-CM-TRANSID:C1UQrAD3HwiB7MFln1EAAw--.34917S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF4kWF1UCrWkKrW7Jr4Utwb_yoW3Crb_uF
	n5Kr48Gw4DWr15Ga15G34jgrW2g3yrCw1rtw1DW3Z3JFyxJrWqqas5Kr4rZa1rCa13Cw43
	K3Z5GFn5Jry3ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8ZXo7UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDQN8ZVszXNjQIgAAsJ

On Thu, Jan 25, 2024 at 11:14:55AM +0100, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> This series introduces support for the new Apalis Evaluation Board v1.2
> for imx8qm-based Toradex SoM. With the introduction of board v1.2, a common
> board configurations dtsi file and two version-specific dtsi board files were
> added. Consequently, four possible dts files are generated to support the
> range of different SoM versions. Additionally, updates have been made to dts
> freescale/Makefile and arm/fsl.yaml to accommodate the changes.
> 
> 
> Joao Paulo Goncalves (2):
>   dt-bindings: arm: fsl: add imx8qm apalis eval v1.2 carrier board
>   arm64: dts: freescale: imx8qm: add apalis eval v1.2 carrier board

Applied both, thanks!


