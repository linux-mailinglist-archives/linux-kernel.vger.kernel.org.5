Return-Path: <linux-kernel+bounces-146097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 663108A60A7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7CFDB20FE8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EF5FC1F;
	Tue, 16 Apr 2024 02:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IFNxCzpK"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B274ABA42;
	Tue, 16 Apr 2024 02:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713233037; cv=none; b=Qmkpyd7WXjChlCoQza5ctY7dSZvWnzbDNKVF4xWILHV2ddxFc8CCgpWffsMJp5ESw9yFwG/vLBjgzuE33aO5gRvQELznd8xvZbxTsPmz5rTECO68KcXyunfu0PA2miE7DLBDtGoSzVwg5vAiozRUP15wljmqtDZ7h9RQdt79L6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713233037; c=relaxed/simple;
	bh=x2n7YztkZD11QLiH+N5XoPcJPoWlyoWKd+CrQ56g3vI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/lGssdfXF9Y/GUTT3Xn7JZpnSL2ZLteuAMdjtA9RVbGpM8nSrQso3jezzVItdAi/1TwcsYRLRDT37ousHRz0+gubNIIzi1sKhKIHEZ/5u/6sVhZruEIg2T3wOiYFngmG6uPPNlQphfM2pUMB9rfEMLDniZSs6S6HVQNL3JqI14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IFNxCzpK; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 029581C0003;
	Tue, 16 Apr 2024 02:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713233025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdhfOsUByq8rUAvMMWe9XMEbUc95e1ogkd9aQZm1obo=;
	b=IFNxCzpKpOnKB5fD2zdxHmr4+x/odprRgDb1rV44iTZF88RaqG4RxMU+ttqzXq8OrutgfO
	VAmz+TbMrq/IY69cjJIP0da5VNZ7cKiBkq1UnoOmzgOrxs2gTErWowdwuCzROabUtkwOsS
	ZxDJnk31eyhyeF9s34aBwWGX+UOQfnnLyXXCMrTuD6A+J7WvE/gdZYnmhqZ4H+io4spEuz
	SsxErIMnd13MRzCr1PCtxoET2JUPs7qWnI/3IxPjFHvh5XrCHLCjwwvZlUVdA+6IazbD8v
	/mgR8byu4c7wptGosm3glSCwJcJHIDkiErIHWN8fCCWJHdd59bPXayxzBYieug==
Date: Tue, 16 Apr 2024 04:03:29 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Martin Tuma <martin.tuma@digiteqautomotive.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, Hugues Fruchet
 <hugues.fruchet@foss.st.com>, Alain Volmat <alain.volmat@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Paul Kocialkowski
 <paul.kocialkowski@bootlin.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Sakari
 Ailus <sakari.ailus@linux.intel.com>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Hans Verkuil
 <hverkuil@xs4all.nl>, Sergey Kozlov <serjk@netup.ru>, Abylay Ospan
 <aospan@netup.ru>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Dmitry
 Osipenko <digetx@gmail.com>, Stanimir Varbanov
 <stanimir.k.varbanov@gmail.com>, Vikash Garodia
 <quic_vgarodia@quicinc.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio
 <konrad.dybcio@linaro.org>, Benjamin Mugnier
 <benjamin.mugnier@foss.st.com>, Sylvain Petinot
 <sylvain.petinot@foss.st.com>, Jacopo Mondi <jacopo+renesas@jmondi.org>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, Laurent Pinchart
 <laurent.pinchart+renesas@ideasonboard.com>, Niklas =?UTF-8?Q?S=C3=B6derl?=
 =?UTF-8?Q?und?= <niklas.soderlund+renesas@ragnatech.se>, Pavel Machek
 <pavel@ucw.cz>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 10/35] staging: media: tegra-video: Use swap macro
Message-ID: <20240416040329.31547d8f@booty>
In-Reply-To: <20240415-fix-cocci-v1-10-477afb23728b@chromium.org>
References: <20240415-fix-cocci-v1-0-477afb23728b@chromium.org>
	<20240415-fix-cocci-v1-10-477afb23728b@chromium.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Ricardo,

On Mon, 15 Apr 2024 19:34:27 +0000
Ricardo Ribalda <ribalda@chromium.org> wrote:

> Makes the code simpler and cocci happier:
> 
> drivers/staging/media/tegra-video/tegra20.c:324:44-45: WARNING opportunity for swap()
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

