Return-Path: <linux-kernel+bounces-166692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A63DB8B9E3C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6141F2541F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4E115E7E7;
	Thu,  2 May 2024 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Sp++7kuI"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A25915E1F6;
	Thu,  2 May 2024 16:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714666121; cv=none; b=lP+kmycoKhzvVvCDBeu+vu5OEb6Y9h/pi/w8967pg9V3WeJ5XJB/ge+V5rsLKcHbJZiQrDSkUmtPkVBbm9uQCtByEKXiEaPs9uqz/FhE0ZTYxGPBQkusB4sQBiDcq5ee0rrfK8OONzgI8IGLmHiAoWvErTIq/miV8M5DaMkl2NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714666121; c=relaxed/simple;
	bh=1zxbeK2Vc5xzfg9ivasxN0Y8bxeQt6RGSMFz/qIJEB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOZPijtHsdzTU36PQhByTl4BEEvxNIHx/yrAiggI5aYl0tH1XOli+T1USG/52Ah22UvaK9AjiFbgwREImuhYpIeZMeCCsz3HUgEP9WCBLcP2oJESX5hITAJSrWytGL9ul92Hn7YJ37ISLCpZeMNw+eVhxK1tpaQVrsHn20c1d14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Sp++7kuI; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 50D974D4;
	Thu,  2 May 2024 18:07:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1714666059;
	bh=1zxbeK2Vc5xzfg9ivasxN0Y8bxeQt6RGSMFz/qIJEB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sp++7kuIo7u0MWn92GCxF9L94GCFpxrJwg8v0jK9FWCLWTQXiLcmGPrhGhzZkfM7E
	 637vea6WUMWJ4A5o8RWfMKEhzyGsgm4Z3MNtZDwDfy83U9wUHOM0plYnky+y+NlbYU
	 ozCC8vCzQXC5O9dQNjVpuQnijTzGK8LEvmClhovE=
Date: Thu, 2 May 2024 19:08:30 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Julien Massot <julien.massot@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Jacopo Mondi <jacopo+renesas@jmondi.org>,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
	Sylvain Petinot <sylvain.petinot@foss.st.com>,
	Yong Zhi <yong.zhi@intel.com>, Bingbu Cao <bingbu.cao@intel.com>,
	Dan Scally <djrscally@gmail.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Eugen Hristev <eugen.hristev@collabora.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Maxime Ripard <mripard@kernel.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Martin Kepplinger <martink@posteo.de>,
	Purism Kernel Team <kernel@puri.sm>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Robert Foss <rfoss@kernel.org>,
	Todor Tomov <todor.too@gmail.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Dafna Hirschfeld <dafna@fastmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Hugues Fruchet <hugues.fruchet@foss.st.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Yong Deng <yong.deng@magewell.com>,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Benoit Parrot <bparrot@ti.com>, Jai Luthra <j-luthra@ti.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Michal Simek <michal.simek@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev, linux-staging@lists.linux.dev,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 0/2] Introduce v4l2_async_nf_unregister_cleanup
Message-ID: <20240502160830.GB11443@pendragon.ideasonboard.com>
References: <20240502-master-v1-0-8bd109c6a3ba@collabora.com>
 <20240502155626.GD15807@pendragon.ideasonboard.com>
 <ZjO46Uo_tVcRTdA0@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZjO46Uo_tVcRTdA0@kekkonen.localdomain>

On Thu, May 02, 2024 at 04:01:45PM +0000, Sakari Ailus wrote:
> On Thu, May 02, 2024 at 06:56:26PM +0300, Laurent Pinchart wrote:
> > On Thu, May 02, 2024 at 05:22:20PM +0200, Julien Massot wrote:
> > > Many drivers has
> > >   v4l2_async_nf_unregister(&notifier);
> > >   v4l2_async_nf_cleanup(&notifier);
> > > 
> > > Introduce a helper function to call both functions in one line.
> > 
> > Does this really go in the right direction ? For other objects (video
> > devices, media devices, ...), the unregistration should be done at
> > .remove() time, and the cleanup at .release() time (the operation called
> > when the last reference to the object is released). This is needed to
> > ensure proper lifetime management of the objects, and avoid a
> > use-after-free for objects that can be reached from userspace.
> > 
> > It could be argued that the notifier isn't exposed to userspace, but can
> > we guarantee that no driver will have a need to access the notifier in a
> > code path triggered by a userspace operation ? I think it would be safer
> > to adopt the same split for the nofifier unregistration and cleanup. In
> > my opinion using the same rule across different APIs also make it easier
> > for driver authors and for reviewers to get it right.
> > 
> > As shown by your series, lots of drivers call v4l2_async_nf_cleanup()
> > and .remove() time instead of .release(). That's because most drivers
> > get lifetime management wrong and don't even implement .release().
> > That's something Sakari is addressing with ongoing work. This patch
> > series seems to go in the opposite direction.
> 
> This still avoids the driver authors feeling they need to implement wrapper
> functions for v4l2_async_nf_{unregister,cleanup}. I'd be in favour merging
> this.
> 
> I don't see this getting in the way of adding use counts as the code will
> need to be changed in any case.

Fixing the lifetime issues would essentially revert 2/2 and move the
v4l2_async_nf_cleanup() call to .remove(). I don't think providing a
helper that forces the cleanup at .remove() time is a good idea, it
gives a false sense of doing things right to drivers. This is the same
reason why devm_kzalloc() is so harmful, it gave the wrong message, and
created (or participated in) all those lifetime issues.

-- 
Regards,

Laurent Pinchart

