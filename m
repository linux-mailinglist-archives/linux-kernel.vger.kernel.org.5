Return-Path: <linux-kernel+bounces-161314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 990378B4A92
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 09:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2894A2816B8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 07:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A45A51C5E;
	Sun, 28 Apr 2024 07:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="eofGzXtg"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F76EED0;
	Sun, 28 Apr 2024 07:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714291169; cv=none; b=WJ5ESVCeJuHcDpkaGdKSoCvfUzcQ82NOBEmpGDabC2/e3nQYelV9690A4iwy9ZcDMMdtqmSm6AK/mklDjaYMhajGCty0f7HRYQJi7ThmctjLNaCK2QB5ATFnJNlP/2sp2J5OK5BVzNq3INzx43fX0Tcp25GNxbxxV6ZY3pGN14o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714291169; c=relaxed/simple;
	bh=sJweSO7ymb4LO1Afes/fz5qes9jXjF77aWOkkBcE/LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWibhsOnbVcpEB3XgnoUzq53cHRMhXIwPbQ8C/7PH4Vid71oudPAVEDDtpGV/xkN5d7ECYxXW5tHdhf62/jUdF5uZTh/ZZNDzs/etg04unNocs7OAkfic7ZWBWjDdKpex0WYtvA8ZdQNPUpeZYF1zjfnmlJRZIHmphFnY1vFBk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=eofGzXtg; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=N/5F1F5Rz7AAM3iNROhjX8YnjpmKVMOyfv0VpHrRf74=;
	b=eofGzXtgvx2EtQ8WNM5a6W0OgTp5A7nGRgZioPZR2v+VBgg0/pxA3DI4SCNfOy
	FytTEGmQ0huPOU61KPTWV5YKF8CgF2UTAUKPGuvJBmi/v8P/CMoRn54Hkk2QD6Ex
	TOwozFBoQfXXxJxSOgj/t/2ccZvvZAlRV/F+wzkNCtyVI=
Received: from dragon (unknown [114.216.210.46])
	by smtp1 (Coremail) with SMTP id ClUQrAD3f3VwAS5mp07GAw--.21974S3;
	Sun, 28 Apr 2024 15:57:39 +0800 (CST)
Date: Sun, 28 Apr 2024 15:57:36 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 00/49] ARM: dts: imx: Use #pwm-cells = <3> for
 imx27-pwm device
Message-ID: <Zi4BcG+1d5LEdbms@dragon>
References: <cover.1712352665.git.u.kleine-koenig@pengutronix.de>
 <oy4mnbkskyrw5dwkq3rebe2yh4i3fy44rubhvesug7pedzws46@472pzktn5t22>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <oy4mnbkskyrw5dwkq3rebe2yh4i3fy44rubhvesug7pedzws46@472pzktn5t22>
X-CM-TRANSID:ClUQrAD3f3VwAS5mp07GAw--.21974S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw4xXr47Xw4kGw18tFyfCrg_yoW3ArgE93
	W293WDCa95AFWkGas0yw45t343KrWUt3y3try7Wrn29Fn3Cas8Ca4kKrWrtw13ur4rtas7
	KFZ3t3WUX34Y9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8qYLPUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBRTOZVsVCgQLwwAAsy

On Fri, Apr 26, 2024 at 09:40:24PM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Fri, Apr 05, 2024 at 11:41:47PM +0200, Uwe Kleine-König wrote:
> > this series addresses many warnings of the type:
> > 
> > 	arch/arm/boot/dts/nxp/imx/imx6ul-pico-dwarf.dtb: pwm@2088000: #pwm-cells:0:0: 3 was expected
> > 	        from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
> > 
> > that is emitted when building with CHECK_DTBS=1.
> > 
> > This completes the conversion started with
> > 
> > 	fa28d8212ede ("ARM: dts: imx: default to #pwm-cells = <3> in the SoC dtsi files")
> > 	4c6f19ab2aed ("dt-bindings: pwm: imx-pwm: Unify #pwm-cells for all compatibles")
> 
> Gentle ping! I would expect that Shawn picks up this series.

Thanks for reminding!  Applied all, thanks!

Shawn


