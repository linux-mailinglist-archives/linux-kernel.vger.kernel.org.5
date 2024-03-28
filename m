Return-Path: <linux-kernel+bounces-122997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6769B8900D8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13C9E1F22EFA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB328175E;
	Thu, 28 Mar 2024 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="B2GyGhGb"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4060314294;
	Thu, 28 Mar 2024 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634116; cv=none; b=WZ6/Bnw1l1IabIA8odxlZx3Pc7+wUbTEP0QbdQZOR6aQMlSlQgEUfepXePQpYIDsoR/Xx+DeCEy2aOmOXHlgwg1UfBtI83wyXPzyePgOwzNF1oXFi15wXvObf4x363L7eLjYUSMwSpXqZi+0TuYQZK9ice5ovwaN7vXLSU1dT2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634116; c=relaxed/simple;
	bh=DfrrIRMhf7F8dxUPrgdMEfjKADIvaXWsP4TCkcLf8oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEyS0GKjnyPVkDS9txmRLS1jWbm+Acnv6+77/DQhj2FGnlDpGKxGMkyLZW7wSsWvyWdqNjd/uXymft9HsVFNNpuKcsZ52MTO6zFWfhtftnaftx238n95OZfx0KSCgRV4Cp+wlDyxT4Al3wz4mPmJvq+zF7K/o9KWo+C0AiX6NQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=B2GyGhGb; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=7HuHZRVaWONhQpUVLGaH8mCBo7oDHLgcq9J6Ysi17V0=;
	b=B2GyGhGbnijYUIE6ovaPBfHzlyeGNvjf5Hhrjr8xzi9lf6SKybB5fCzs2nsSwP
	8yRBh9ydcmcMzpDLlDtl85B3L+9oYj7BH7B362RxH/J9yoXxb/KNunXRYX4qiDyw
	N+hCK6djPwQlH1MPT/ayTcKoR+M5tH4kvAtUz6U8IMvfM=
Received: from dragon (unknown [183.213.196.225])
	by smtp2 (Coremail) with SMTP id C1UQrACX_heAdgVmyl1aAg--.12337S3;
	Thu, 28 Mar 2024 21:54:09 +0800 (CST)
Date: Thu, 28 Mar 2024 21:54:07 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Sebastian Reichel <sre@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH v5 6/6] ARM: dts: imx: Add UNI-T UTi260B thermal camera
 board
Message-ID: <ZgV2fyfV5/SW/v+x@dragon>
References: <20240226212740.2019837-1-sre@kernel.org>
 <20240226212740.2019837-7-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226212740.2019837-7-sre@kernel.org>
X-CM-TRANSID:C1UQrACX_heAdgVmyl1aAg--.12337S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIzB-DUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiGBCvZV6NnpnNkwACsK

On Mon, Feb 26, 2024 at 10:26:28PM +0100, Sebastian Reichel wrote:
> Add DT for the UNI-T UTi260B handheld thermal camera.
> 
> Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Applied, thanks!


