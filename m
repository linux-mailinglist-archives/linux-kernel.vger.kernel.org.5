Return-Path: <linux-kernel+bounces-158342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E19838B1E9B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976341F23228
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7240E86262;
	Thu, 25 Apr 2024 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="HJ4ikIuF"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3D884E0D;
	Thu, 25 Apr 2024 09:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714039146; cv=none; b=aA37vEX1yCrphN68devF+K/0eNpsnzpcBhQPic20fKE2/qPSHAcZYmeYqfpYqTggg7ggeU+70xkVuYHLz187L01D/36Q9WZ3vt+/kH1LEljehuqQBHiRm0aoXUAxSN1sOOC4T7et8pCSA1qAbPfocXnhdcTaViLQRQHGvqc2tfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714039146; c=relaxed/simple;
	bh=bS5vRZgCepqsfybsuZmUFrGIxQpeiKXaE4I15xitOig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkfA3epl81sHXT+L88dWuC95LV+OUhH3Z82wkn0MMyoksLp8fMQU9y55sh4ujzrWrfFxEug9833/3t4x8V7jgX8yKti/ge0pf/Hu2yP8YoWdP3iPdkYbMaDutoyFPpLkd/2VFUSRsrDEmV2Zb52Uj7HB3pjnR4Ir6ynHVbkL6z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=HJ4ikIuF; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=SUK3KiYsAjXmz1lQMFlWpM7cirHy3HazgSFNWJvitho=;
	b=HJ4ikIuFN43ZQXNjGc2sJM00WaIucvlYOZNwkAcJ6WDdd2evjqUe+8s456JNYl
	fgOe1CD+H0VRnuqB7vlSLlvyJMY1unn7IxuqAqJhVv3bAjt5EtYM3Oe9aBdbgfSx
	l6xaxrK2Mo+6ZQyh0PzsA2GTit/2HRCzLWqdsIaDpCpyQ=
Received: from dragon (unknown [223.68.79.243])
	by smtp1 (Coremail) with SMTP id ClUQrADXHyFKKSpmwUBvAw--.20945S3;
	Thu, 25 Apr 2024 17:58:36 +0800 (CST)
Date: Thu, 25 Apr 2024 17:58:34 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Joy Zou <joy.zou@nxp.com>
Cc: m.felsch@pengutronix.de, frank.li@nxp.com, ping.bai@nxp.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] arm64: dts: imx93-11x11-evk: add RTC PCF2131
 support
Message-ID: <ZiopSiXqkZ3H7Dhv@dragon>
References: <20240425013507.2840128-1-joy.zou@nxp.com>
 <20240425013507.2840128-2-joy.zou@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425013507.2840128-2-joy.zou@nxp.com>
X-CM-TRANSID:ClUQrADXHyFKKSpmwUBvAw--.20945S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUsyCJDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiFQzLZV6NnF5h7QAAsq

On Thu, Apr 25, 2024 at 09:35:07AM +0800, Joy Zou wrote:
> Support RTC PCF2131 on imx93-11x11-evk.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>

Applied, thanks!


