Return-Path: <linux-kernel+bounces-54491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF3084AFE7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8BB1B22899
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6EA12B147;
	Tue,  6 Feb 2024 08:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="AAULVMV+"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3722AD19;
	Tue,  6 Feb 2024 08:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707207968; cv=none; b=PDvq7JJiFQF5iq5YsDc4zhY610rcZIbg7aeWJzV0NR2kpvxOYIzViLH3msUNu4CTHAH2dbYTb7Y8xCNInBzD1GKpqXS8Tv7iIXm+K6JpbyNa7L4ckUDyLNSQLH3Euu+PMNpVw2WPcTY5H0Z9zQej9wle/12nIz05+DgthGxhkQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707207968; c=relaxed/simple;
	bh=t2yAKJurDDjfKO/vW3wSmRuW40exRI8aIXUdYqj/Qbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpOjI7cbBhnZBi1REAmApR7EG3FUwkYjjzAqx+g6gwqhOj6bWCgWA3LiFTETg/NdC7/D1UVeuhKkZXqUaV/IgvyVf2PpZBznOBjWES2tnpdX6f0QWFB+wO9+Oj6/SA17Dbv1k425ZJica8HbECPSBV13AzTY04tQ7nF/SrTaty0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=AAULVMV+; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=D+dpyHzkxQAg52iRrnWaJV0X6pa+2auyDsk3A0BdquY=;
	b=AAULVMV+MICK1NxhCyh7A5PJpnCV3zfU3AAeoC/MWQxveM7mKH1ZvIwKknIFai
	bgYxE4uJWEDXt9YX41RkJAAFIGUUvxhxM8rLN3IQoT5Vsj9cP5Rd5WJj7zatlVop
	S3cggOMA62ozRomCYOa7K1X9vImhh/+RTihLW+PP/4Nyc=
Received: from dragon (unknown [183.213.196.254])
	by smtp2 (Coremail) with SMTP id C1UQrAAH74jf7MFlzVcAAw--.44150S3;
	Tue, 06 Feb 2024 16:25:05 +0800 (CST)
Date: Tue, 6 Feb 2024 16:25:03 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
	NXP Linux Team <linux-imx@nxp.com>, kernel@dh-electronics.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6ull-dhcom: Remove /omit-if-no-ref/ from
 node usdhc1-pwrseq
Message-ID: <ZcHs36/WVSlBQxcQ@dragon>
References: <20240125124621.16011-1-cniedermaier@dh-electronics.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125124621.16011-1-cniedermaier@dh-electronics.com>
X-CM-TRANSID:C1UQrAAH74jf7MFlzVcAAw--.44150S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4Xo2UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDgF8ZVszYTDk5AAAsv

On Thu, Jan 25, 2024 at 01:46:21PM +0100, Christoph Niedermaier wrote:
> Remove /omit-if-no-ref/ from node usdhc1-pwrseq, because if the compile
> flag -@ (include symbols) is used the node will always be there. In this
> case, GPIO H is not released and therefore cannot be used. Therefore,
> remove this node manually from the corresponding devicetree file and
> don't rely on /omit-if-no-ref/.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>

Applied, thanks!


