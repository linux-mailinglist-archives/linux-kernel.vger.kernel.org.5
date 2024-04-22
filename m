Return-Path: <linux-kernel+bounces-152752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C7D8AC3D1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE4B1F23339
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC49182D8;
	Mon, 22 Apr 2024 05:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="MMBSo7FL"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D3413FF6;
	Mon, 22 Apr 2024 05:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713764456; cv=none; b=f2Mp4ZyiAmuB/vdH8QDRXE5YbiFjNRsmqDB4eWFqH6y3gJ5nYxDPrEPlLLL+/WgqO8LZnlPpDpJjYLjLwfFkoJGHQWjAfreDmOGfsJI8gdrY+4O22tSWIdq5SiCkZ3NLPZnGt4Vtrwe/mElewoStynYYDbYkptmPZI2RsCUviI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713764456; c=relaxed/simple;
	bh=hh9RxN9jBJ/DfMTBb2xuz2CdAScdEVGGXxdNxLA1rU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUrgJ6Whc1oanKuXVawDVF4w3RblMKCj22VF/b2dZrsBTJvm0VJmvQYmnWY3C0ABb1+IS9ETbhF+O5UibwUzsZEa+U/+JgTRj5VDt2rSkUAxeFbS5fNJLFSSRcR5+cqsQcFOn5VZO82ZBZP+/t/3+qsSDdsffDEXviEIB47S9Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=MMBSo7FL; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=OrzKwWo/B3km3LkyErimGK53sAtA8Zcp7tLaY4gA2do=;
	b=MMBSo7FLbUHcHrW6dPX57C0nc2sc2VQ/eYtsJEo1GQova8T4sM0bSCbMrbBKdc
	pywqcGCFuuKai+pqluDVzNgIH/0GZDg1tqRzK47hsNqmCD89Kb3bSfqwZQuoSNou
	CsETwKZGpeZqJIwr7hVoQZrqYkg2iBhuDLgFBw3SMReKg=
Received: from dragon (unknown [223.68.79.243])
	by smtp2 (Coremail) with SMTP id C1UQrADnT5FM+CVmDc8zBA--.51929S3;
	Mon, 22 Apr 2024 13:40:29 +0800 (CST)
Date: Mon, 22 Apr 2024 13:40:27 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux@ew.tq-group.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: dts: tqma8mnql: Add EASRC support
Message-ID: <ZiX4S/H98e/lQXR5@dragon>
References: <20240412132021.520666-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412132021.520666-1-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:C1UQrADnT5FM+CVmDc8zBA--.51929S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUsPfHUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBQ3IZVsVCfBTAQAAsA

On Fri, Apr 12, 2024 at 03:20:21PM +0200, Alexander Stein wrote:
> Enable EASRC support in tlv320aic32x4 sound card.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Hmm, it doesn't apply to imx/dt64 branch.

Shawn


