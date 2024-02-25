Return-Path: <linux-kernel+bounces-80067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF50862A67
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 14:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B241281B31
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 13:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C175125CC;
	Sun, 25 Feb 2024 13:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="MUb9elrz"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1454DDDA;
	Sun, 25 Feb 2024 13:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708866289; cv=none; b=p/OLEYtvlzndTSrSyy0oc96OPX+2dHq9F7hodw2Nba4lfcDx2ukDmXiJ4sMFK6DYSyDjDOXwVvE7u4QSqhO2Tn9eakCozPy1Laven8H/TECV9XaknaBXHr48f3xFgr9Utba17VfzAwHlcx8H/VQrF3Exl77y7dv2twTaTcQiqOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708866289; c=relaxed/simple;
	bh=ln45ZHPv8+YkWi3VQQc0vg+57IBMoHqUd07YiLVFH48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/C1mXpkEBPfSwPc46srQNq1A0/y6dUL3SSP6ZETudPnkjRhA5Wc7Oi1HviV2ByLUkHqgPc4aA4HmYbn8Rj9Nz/X2N/WybS9XOkRFoxjWiZW3+5GKO+BJShnENu99mErNwHdJd4PDWj9PgNrVPgC5kK1JZKjsXoMcN3vqB9ZLWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=MUb9elrz; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=jOX14Uu7tHrKUE0P91Wze9hvWOxj3jqvdUZ1ym6LhD4=;
	b=MUb9elrzC2VUkwtnyy5ExQcS4xhA9QB2WC0pzvi42XuDbEtYqKRVJPCczzFds1
	FLfk6fv1QnuibCFXRxrSBXSEAejI6qF1FFFVbqHWRLvvts5YRFJksrf8Bi5hXB0H
	0qEEIW3IqzVOjB8rP7red7EJjsaCdv5u3Oq1OKQU4lt2M=
Received: from dragon (unknown [183.213.196.200])
	by smtp2 (Coremail) with SMTP id C1UQrADnjy+vOttlOjhWBA--.41198S3;
	Sun, 25 Feb 2024 21:03:44 +0800 (CST)
Date: Sun, 25 Feb 2024 21:03:43 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com
Subject: Re: [PATCH] arm64: dts: imx8mm-evk: Add spdif sound card support
Message-ID: <Zds6rztD3msV/gId@dragon>
References: <1708582633-6969-1-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1708582633-6969-1-git-send-email-shengjiu.wang@nxp.com>
X-CM-TRANSID:C1UQrADnjy+vOttlOjhWBA--.41198S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU3jjgUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDhCPZVszYWKNtAAAsm

On Thu, Feb 22, 2024 at 02:17:13PM +0800, Shengjiu Wang wrote:
> Add spdif sound card support, configure the pinmux.
> 
> This sound card supports recording and playing sound
> through spdif interface.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Applied, thanks!


