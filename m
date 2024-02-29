Return-Path: <linux-kernel+bounces-87592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AEE86D643
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 271001C215C8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4346D506;
	Thu, 29 Feb 2024 21:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KK/ZUxdM"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D8B16FF21;
	Thu, 29 Feb 2024 21:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709242709; cv=none; b=BxHkX2K72uVEqOE7G3HGTI3nkJNm5wCCsQd2VSE23RKR8Nc1JRtsyPaBnQYO1+9XmStPrDYkhsAE3aJOhwtdQrZES+7MqKak7+nwA8EXYuKjYwvZkpXgLmNPgHw90n6TKszRH3mHO3rbgEJ9AADNYOgjGkosagRCnPD51jBkk24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709242709; c=relaxed/simple;
	bh=Jyx0yX1/osNIVS5HxoUVFoplp5LxTV1iTRgXQQ4GFlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTHGOcg3smoVkzaKOItR2f9ensTB7dFSZ87GXGOlsgqT5v3CQ2l6ffLsHrcjDX1hkOLh7fu3ILkkhszqPpXbM5xopnJxuIzkSLFCLpwfWZcgvariWs6bNlIfgonKBkP1/lGAhltPt01RryHbDZUBOi8QcUEymTMJrcIZFMefhe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KK/ZUxdM; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6FA29FF802;
	Thu, 29 Feb 2024 21:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709242703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=06h+Dixp3pfmyNHLmEgwHvnmTLomiV3h0dUw0wK6Rv0=;
	b=KK/ZUxdMUD8UIdRpFCufS6iKlqdVruNm8S81hf2wcXf/Raw2jCZcI4NK2pwFHkxIIq49Y2
	t/VtghIveB0cag2gAQK8iKU3/fTWg+vk+qymC3OZUOKuD6fASsMaJymE2wBIqzuKPJSQdk
	z37If8Lmeh1XECZMoRO1DEJBJ7zIF4kna7SrbKqxAUeRAp2kacwhxsdtL/1HfAijE98fFc
	QotFWYt71t7aWuIgs4auu6joCsglV0fmaFw6ABF/1kwzYP3ZZZ8chL5RABl9JPi4DJ5P4f
	V2F/IqwpVP5MWV9iKe/XQjJGWl6Teo+zTuQKJxOgv+YeK6a92Wss58YvgjtenQ==
Date: Thu, 29 Feb 2024 22:38:21 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Eddie Huang <eddie.huang@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Peter Rosin <peda@axentia.se>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2] rtc: mt6397: select IRQ_DOMAIN instead of depending
 on it
Message-ID: <170924268327.1875298.3046212604206136101.b4-ty@bootlin.com>
References: <20240213050258.6167-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213050258.6167-1-rdunlap@infradead.org>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Mon, 12 Feb 2024 21:02:58 -0800, Randy Dunlap wrote:
> IRQ_DOMAIN is a hidden (not user visible) symbol. Users cannot set
> it directly thru "make *config", so drivers should select it instead
> of depending on it if they need it.
> Relying on it being set for a dependency is risky.
> 
> Consistently using "select" or "depends on" can also help reduce
> Kconfig circular dependency issues.
> 
> [...]

Applied, thanks!

[1/1] rtc: mt6397: select IRQ_DOMAIN instead of depending on it
      https://git.kernel.org/abelloni/c/544c42f798e1

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

