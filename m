Return-Path: <linux-kernel+bounces-152692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADB68AC2F3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0240C2812C1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 03:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C23DF49;
	Mon, 22 Apr 2024 03:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="nhKOL9P2"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C474C65;
	Mon, 22 Apr 2024 03:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713756361; cv=none; b=ja4b7sZh0oygrYitZE/zQ753Y4QrRbYL06h4NSnEo4c9jylSmZLaECb5JZUx3PSMFSPlhvktUEVc2PpfkBynzF9hvsufmxSu9lJi6V0IBcCHIAxw5lpXZVhX2uBW0CMQ4FHp8MxfmyiOuSx7p95474udnsKJqWzrAB0Q4e6TE4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713756361; c=relaxed/simple;
	bh=Jo/907Tz+KrXlk7i/V8O/ousZUUkLKQWOor9Si88iro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoBnly2nbCkGj5FZqFu3wnbi1NQ+NK0pWbfWrj9jNP+ZETcnPIAgztSATPMoKQabnDvXXvU1HbB5YbRLHOesHGC2+hn3U2UPO6QR1FnGgTnJIYd0wa6IFKKBjFEnNp/KwKo0UbmHnjqfRecIKPFz8JlD4cp12mMqnWOj972PYIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=nhKOL9P2; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Sx06mjddR7zFEtdIz8pMTSg4vPpM/8R8plT2pGon44w=;
	b=nhKOL9P26k+uCbh+73sGqqQcsCRk+0iCfT1jmuK5Ea7oqa1v2U3U0sdSGGVwot
	mKitEbrw0hnAqtloUlsTXJMWhm6JVi0goeJHRkk32cdnJaog583eATFZBPDFiCPY
	jJfYRqXJPNK1dX8tI20/3o7mTorI8PNwTHTcAiLQYG3RU=
Received: from dragon (unknown [223.68.79.243])
	by smtp1 (Coremail) with SMTP id ClUQrAD3n1aJ2CVm7DMrAw--.50234S3;
	Mon, 22 Apr 2024 11:24:59 +0800 (CST)
Date: Mon, 22 Apr 2024 11:24:57 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/4] arm64: dts: freescale: Add Toradex Colibri iMX8DX
Message-ID: <ZiXYiVnEwBUIWLCj@dragon>
References: <20240402193512.240417-1-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402193512.240417-1-hiagofranco@gmail.com>
X-CM-TRANSID:ClUQrAD3n1aJ2CVm7DMrAw--.50234S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF4UZr1rKrWDuF1UuF1rZwb_yoW3Grg_ur
	W0yF1DA3y8XrZrtw1Yg3W3G39rGa45Cw1Yqa4DJr1SyrW7Arn8ZFZIv3s3GFy5CFZ7GFyx
	tr15J39Yvr4S9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8DDG5UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiFQvIZV6NnFLpQwAAsE

On Tue, Apr 02, 2024 at 04:35:08PM -0300, Hiago De Franco wrote:
> From: Hiago De Franco <hiago.franco@toradex.com>
> 
> This patch series introduces support for Colibri iMX8DX SoM and its
> carrier boards, where the board can be mated with: Aster, Evaluation Board
> v3, Iris v2, and Iris v1. This SoM is a variant of the already supported
> Colibri iMX8QXP, utilizing an NXP i.MX8DX SoC instead of i.MX8QXP.
> Therefore, this patch series also adds support for the i.MX8DX processor.
> 
> Hiago De Franco (4):
>   arm64: dts: freescale: Add i.MX8DX dtsi
>   dt-bindings: arm: fsl: remove reduntant toradex,colibri-imx8x
>   dt-bindings: arm: fsl: Add Colibri iMX8DX
>   arm64: dts: freescale: Add Toradex Colibri iMX8DX

Applied all, thanks!


