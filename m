Return-Path: <linux-kernel+bounces-126372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2FD8935E6
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 22:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F12AB21FA3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 20:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9868D145353;
	Sun, 31 Mar 2024 20:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="oAZWgVnq"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018E8433A6;
	Sun, 31 Mar 2024 20:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711917455; cv=none; b=g7SDHmtBBpTSWRoZuYaQfblOlW/8I+7q9qzOjCKHvRV8XksDCMKyyHzDvZy/OLGhe2oB01RocpKTyREmwNgXiyX9DH580ckBCji3t77/Hc+4yzhhtrXDO68tx79l8+RW416vjfYEA+nicaP58f1akEW8UN/AN+vgLyzMNZyb960=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711917455; c=relaxed/simple;
	bh=I/ZnOtCPhHLN9eQSnKGa5MWdlOxMIBa92bbKwdR2sWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPUtU7g3Qcxs7MiSIsZg+LbjIWfFm14/nQCosw7g1ObpkrB7cnTtlubEJneCUCtXu8gnu8PtKxfhfxpfPJUs2XpK+mTccW1JsGVyn8sJ17q/vKYNYS3EmpIXpNyMwPXlPSkW/PGRwzoLa9x9O2hDRnG2ckq+bQrL5P5f91g6Ecw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=oAZWgVnq; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 907CA1FA4F;
	Sun, 31 Mar 2024 22:37:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1711917451;
	bh=4J4UxMw8vCu/e4YwDL2de2cwdYJiMGR5S+olW6/Wq0o=; h=From:To:Subject;
	b=oAZWgVnqbpNY/NnnmLvGf4jms0+WYBdOHuj6GVG2+twoiY2kvJ59PArKOwyHgrBFu
	 /MGz/tkWe+HyJtFWVkp5epS7wje5jgCr+lMQ4ElORxQO6762OoDo81tvY6X4FwXtNa
	 HtADJytvzwGNfGcbyBDGljlmMSyQ8Dy7odJIiQ1jHODmYQLfOU1g5/m4W/jjtva54a
	 Q/u5I2zChQUKUzs781NCH5eFrqXybF+IgTiw37MCg7aj8nrUAtNk1lSZF159sZhKP8
	 C4OKL4DuR+tHGgQgT6myIyyFmHPMFt4OTBBONnZQayJGV06MpVBND6girIBxOdCYJr
	 MPrpOIkJWhgrQ==
Date: Sun, 31 Mar 2024 22:37:29 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Brian Norris <briannorris@chromium.org>,
	=?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH 1/7] mmc: sdio: store owner from modules with
 sdio_register_driver()
Message-ID: <20240331203729.GC4116@francesco-nb>
References: <20240329-module-owner-sdio-v1-0-e4010b11ccaa@linaro.org>
 <20240329-module-owner-sdio-v1-1-e4010b11ccaa@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329-module-owner-sdio-v1-1-e4010b11ccaa@linaro.org>

Hello Krzysztof,

On Fri, Mar 29, 2024 at 06:24:31PM +0100, Krzysztof Kozlowski wrote:
> Modules registering driver with sdio_register_driver() might
> forget to set .owner field.  The field is used by some of other kernel
                             ^^ double space here

> parts for reference counting (try_module_get()), so it is expected that
> drivers will set it.
> 
> Solve the problem by moving this task away from the drivers to the core
> code, just like we did for platform_driver in
> commit 9447057eaff8 ("platform_device: use a macro instead of
> platform_driver_register").
> 
> Since many drivers forget to set the .owner, this effectively will fix
> them.  Examples of fixed drivers are: ath6kl, b43, btsdio.c, ks7010,
       ^^ and here

> libertas, MediaTek WiFi drivers, Realtek WiFi drivers, rsi, siano,
> wilc1000, wl1251 and more.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

My nit comments are irrelevant, but given you did the same twice I felt
like letting you know.

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


