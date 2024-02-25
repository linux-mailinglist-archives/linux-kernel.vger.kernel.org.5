Return-Path: <linux-kernel+bounces-79960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC758628FB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 04:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07C861C20AFE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D078C748D;
	Sun, 25 Feb 2024 03:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="bXW/lwZt"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842B95664;
	Sun, 25 Feb 2024 03:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708831292; cv=none; b=kMNaNQ3aJmf71ascsbnsAfhc4gVLRp7crN2KXJKD9IJ8ej0YjvvCe4nKaixckJoW2zG+Kp4X7hHrt7J2mzl8YFZwIFeSfTdjfQlE6f7ihhij7SSFs7U/GSitVCOufmsco38BBCtIxKx50pmQ0gwKjtgVlqjaWCQIzfGX+p/8FkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708831292; c=relaxed/simple;
	bh=NFySs+5B4dprx0MHXz/GZz/nyHW7m18SEB6hwoWPxPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuJo4tNRKNqzehkV8yjFGY2pL30T7qOUK1plD+j596a+O5dsunN3Ir+I9bb1mq1m8/gF1acuwgPEvy9AxfulK+NlE2/ctQG5XL+F/6nKHyHj4YOsIEmL1x9HH1+eAeO/+4piAQxJAVHkTj6yFvY2MSDrnldP2R1qQCEVgHtQcOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=bXW/lwZt; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=T0BiYckLOsHMfpdRbzfvGEXTZA9/ISr9qW+zImjF/H4=;
	b=bXW/lwZt+9Yi1nfE1Oz/q3wWXz3hW+HbSLmjxwegdFAuVExxTjG3PCTMSagmvp
	lEamZTBaY8K9KKjaA/jzL4l7x9JEoemPIoBPlln4yBqibVSUqmCxodxelIXWwNRx
	hzR6UBlK0/qV1lbWsFbbZEq1nDrXbblC88gV6Ad2ICQwo=
Received: from dragon (unknown [183.213.196.200])
	by smtp1 (Coremail) with SMTP id ClUQrAB3P4kNstplfjZRBA--.58447S3;
	Sun, 25 Feb 2024 11:20:47 +0800 (CST)
Date: Sun, 25 Feb 2024 11:20:45 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Adam Ford <aford173@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mp-beacon: Enable Bluetooth
Message-ID: <ZdqyDTIUsz49TefQ@dragon>
References: <20240211131116.66490-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211131116.66490-1-aford173@gmail.com>
X-CM-TRANSID:ClUQrAB3P4kNstplfjZRBA--.58447S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxuWlDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDg+PZVszYWG3kAAAsk

On Sun, Feb 11, 2024 at 07:11:16AM -0600, Adam Ford wrote:
> The imx8mp-beacon SOM has wireless chip supporting Wi-Fi and
> Bluetooth shared.  The Wi-Fi is already enabled via the SDIO
> interface, so enable the Bluetooth via UART1.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks!


