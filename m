Return-Path: <linux-kernel+bounces-124075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 952C38911D9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E70428B2B4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E73538DE1;
	Fri, 29 Mar 2024 03:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="L0GmIJGE"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB22B65E;
	Fri, 29 Mar 2024 03:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711681953; cv=none; b=rRIjC3+wlviClb1UwRSOX82jEdScLG1rGdGIlYZczJwVQeQQOurgruUf73LjOVA/VH0uG9GLl8jl+Y5Y+sIDg1eWuzJAw8gXy52prfehyS/VzTvD2a+CUG+BtmfoGf4SwbQkdE19GzHm/gemXbmVYrKU0bJI8FzjYNDi9JRCDGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711681953; c=relaxed/simple;
	bh=jK3dY3GoNx4EVppbdIQ7dxkkOvAyy7lkytbsA4pUkQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g19K1tkvQMchV4u5dGb37qvNJX5vpdWDuvmCQq1bZkdc/7lMDwMtZLwfANNe8kca+dAmqR0Q2Zi6XR9+HL5gAhQoyvDBl/MH6umGowBxh6H8iUMKb5SG8ds9uiyd+YOiqWNU2ehYt5RUnXpM4pkejWjcSnMESXW5wTui9O/xrZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=L0GmIJGE; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=58Hi+vSS092qGoQrkwZyJIgAtrDsNlDvJNKO6UPHRZM=;
	b=L0GmIJGEIFvJf5nYxJZ2SrJ0ALNA2t7yd++QmDAQIEnAYuaimDmrSSvUFMJwFF
	vSDNQLSB1KXIzkxpyhCEaEbPxBq5ttYX7Q83RsH1Kub8N8cBQ/1g18ndtba2l+Y2
	NG4N8bMtW46FrwTcmmZ2Kav7V0iNGoA2+XyMi45a6oLIo=
Received: from dragon (unknown [183.213.196.225])
	by smtp1 (Coremail) with SMTP id ClUQrADnr0JeMQZmqENdAQ--.13207S3;
	Fri, 29 Mar 2024 11:11:27 +0800 (CST)
Date: Fri, 29 Mar 2024 11:11:26 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] arm64: dts: imx8qm-mek: add adc0 support
Message-ID: <ZgYxXniaORoXOi3t@dragon>
References: <20240227193049.457426-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227193049.457426-1-Frank.Li@nxp.com>
X-CM-TRANSID:ClUQrADnr0JeMQZmqENdAQ--.13207S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIxpnUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBQ6vZVsVCaj6-gACso

On Tue, Feb 27, 2024 at 02:30:46PM -0500, Frank Li wrote:
> Add adc0 for imx8qm-mek board.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied all, thanks!


