Return-Path: <linux-kernel+bounces-124471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B35B0891889
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FAC2284E61
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A603885926;
	Fri, 29 Mar 2024 12:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="VcMXxBw2"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0B964C;
	Fri, 29 Mar 2024 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711714667; cv=none; b=Oq00uSkR0o5keH30le2GhJAsfAR5ts7Ky/8PIzO6ljp1nM/n4GIkj7Bc3yL5U7s6efqEetE6PCVhUf0d/VBur+eXoVGcwPzkD6utM349SdX25HgpgQ9JSyLQ6FZG3vqEdPEGzpyD9C00AjXbgxE5yMx3xb+nVMYf5stO9uX2JCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711714667; c=relaxed/simple;
	bh=BwzJ4F77ijdSPim6oxVFzaz9GKvT5/g2jWD6+edV0FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ta729VhRcnG3Qo6mL33qY4KbOFLEZVbU2/oiMtPhqdosx+zdxE+3fqa2yxTjzZZyhSI4R0xVY+wL2uTA+Veqo1rjKQU26zjN5GU/hLKlb9gMVtEo3NLUuDwtazvH4Iid695ZGN4kH5QNauWnhGwWQO8JRRL7esrEIie/DqziZRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=VcMXxBw2; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=nJmPfGmdfks9ilRd/z75AIMlDh+qABTjjHAxxNVBALI=;
	b=VcMXxBw2miwVNfMrHTN43yl2vOugSzqDVTtu6r4jN6wmRJGRlJPvp4SsFbG7uE
	JS8YGytJ+bhGJIBRRQaR0GnJ4GOD+dFMCPmnBEvt19D52pzA6W/PchHtDGKMMNaw
	iJbeZOIgz8uY7XFpWNNNWbi81gpnJDbSg5nOT7rKigKIo=
Received: from dragon (unknown [183.213.196.225])
	by smtp2 (Coremail) with SMTP id C1UQrAD3f0wasQZmyCNqAg--.46157S3;
	Fri, 29 Mar 2024 20:16:27 +0800 (CST)
Date: Fri, 29 Mar 2024 20:16:26 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: Re: [PATCH 0/5] i.MX8M add DSI output endpoint
Message-ID: <ZgaxGkSEg7+m8dGf@dragon>
References: <20240301091413.3050689-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301091413.3050689-1-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:C1UQrAD3f0wasQZmyCNqAg--.46157S3
X-Coremail-Antispam: 1Uf129KBjvdXoWruw1ftr1kZF1kGF15uFWruFg_yoW3KwbE9a
	s3uF4kWw4DWrsYkwn8CF9FvryYk34avFyUXr4jgwsIvw1fX3W3Cr95tayfAw18AF1rWFyq
	yFn0yws5Zrn0gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUndMaUUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiGB6wZV6Nnp38owAAsc

On Fri, Mar 01, 2024 at 10:14:08AM +0100, Alexander Stein wrote:
> Hi,
> 
> this series was initially triggered by dtbs_check warnings. Despite [1]
> rendering them invalid, this series still simplifies the DSI OF graphs on all
> i.MX8M variants by adding an empty output endpoint.
> Each board enabling DSI connection can simply reference the label.
> Patch 5 uses applies this to MBa8Mx board.
> 
> Best regards,
> Alexander
> 
> [1] https://lore.kernel.org/linux-samsung-soc/20231122-dtc-warnings-v2-1-bd4087325392@kernel.org/
> 
> Alexander Stein (5):
>   arm64: dts: imx8mm: Add empty DSI output endpoint
>   arm64: dts: imx8mn: Add empty DSI output endpoint
>   arm64: dts: imx8mq: Add empty DSI output endpoint
>   arm64: dts: imx8mp: Add empty DSI output endpoint
>   arm64: dts: mba8mx: Simplify DSI connection

Applied all, thanks!


