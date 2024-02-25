Return-Path: <linux-kernel+bounces-80073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DC3862A74
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 14:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5790F1C20B07
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 13:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C74A12E47;
	Sun, 25 Feb 2024 13:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="lUv8Br/6"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA1B469E;
	Sun, 25 Feb 2024 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708867750; cv=none; b=OU/OTj7x9Iel1cDzrxOjvGay2Sf44n7hzgdZHq/wxOiORsKmTwJgvCouJ47F/8fk8sSvQ+z71WQO9yWavDwBoZjJTDglwCTMHJRRNNbs8g5Al9lWG7oQWv6EZrjWPkhFDvHwnQTCPHzT7K28xbSU02SvWABrTlrsWj9EeUxxTHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708867750; c=relaxed/simple;
	bh=iN4WLB6DTmF6voYsCw7klbgrZvZtJf1KI7pwO6cIAV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+Y21UU/iwXPpoT9HrestcFlAdkV+7wfuuqkGDsilWLPECruQKQD9YaXaZ9wqfvPCYxmQdKfy1MlkFUO4tIvdRcgGq+9Eoz5AIdVJlHMEHNE4rqmK1Qweq7GDHUpTJK/Ojoz5NNGYHSOmGdIlpgurdtSOLf9RAzMbHbA4I8bG64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=lUv8Br/6; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=+iyVHlyxgYG8ynH2tYOTKQylHXlf7/DeuoZPPUfIfyc=;
	b=lUv8Br/6/VwW7xl+TjIvB1IsNlzwb7fKSD/ZFK5sRUE8o9iCVep+T8lVDqJXN5
	iWFWy5Ofgpj3eL6Fq/Cfu6IuSEg0mB5PUSyTf1yt781s+pejaKaoXAH7blwtjFXt
	4XbeVcnEiwhew0yfUUsp5k38WnB0pwcZk3egmi1LnQ2tA=
Received: from dragon (unknown [183.213.196.200])
	by smtp2 (Coremail) with SMTP id C1UQrADXHyuMQNtlGmxWBA--.31590S3;
	Sun, 25 Feb 2024 21:28:45 +0800 (CST)
Date: Sun, 25 Feb 2024 21:28:44 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Liu Ying <victor.liu@nxp.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-imx@nxp.com
Subject: Re: [PATCH] arm64: dts: imx8mp-evk: Fix hdmi@3d node
Message-ID: <ZdtAjE2SylK8plBB@dragon>
References: <20240223025738.2486807-1-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223025738.2486807-1-victor.liu@nxp.com>
X-CM-TRANSID:C1UQrADXHyuMQNtlGmxWBA--.31590S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jry5Cw4DJw48uw18GryxGrg_yoWxKrbE9r
	yIg3y7XFZ8tF4qg3sxAF12qwn7Gw1UGrn8JwsYqr1rW3ZxZw4fW3WkZrn3AF43Xws2gr1k
	C34avay7KryrWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0r9NDUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDg2PZVszYWKWxgAAsS

On Fri, Feb 23, 2024 at 10:57:38AM +0800, Liu Ying wrote:
> The hdmi@3d node's compatible string is "adi,adv7535" instead of
> "adi,adv7533" or "adi,adv751*".
> 
> Fix the hdmi@3d node by means of:
> * Use default register addresses for "cec", "edid" and "packet", because
>   there is no need to use a non-default address map.
> * Add missing interrupt related properties.
> * Drop "adi,input-*" properties which are only valid for adv751*.
> * Add VEXT_3V3 fixed regulator.
> * Add "*-supply" properties, since most are required.
> * Fix label names - s/adv7533/adv7535/.
> 
> Fixes: 65344b9bed3a ("arm64: dts: imx8mp-evk: Add HDMI support")
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Applied, thanks!


