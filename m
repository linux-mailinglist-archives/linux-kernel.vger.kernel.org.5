Return-Path: <linux-kernel+bounces-44734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CCD8426B3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA941F27C9E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616F56DCFF;
	Tue, 30 Jan 2024 14:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GwNTLTQ8"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3B867A0A;
	Tue, 30 Jan 2024 14:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706623926; cv=none; b=ViY73QJNes6+uf/vaiAxiCjAScbcVoHTbo07lQeRdevkg4oSPauCZ+PsFALtYwkwJukaOajWkIlPGzoMEonfSTeLPn8VWfoe9x3Qo1OTvjNITUjyqTUlgZZacLxlas86fAyiZ1Kxg8U48hnOqY7JlIZBaB2Max0f6wNvxK3qyOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706623926; c=relaxed/simple;
	bh=zBzQq5IufcMsy/RtjMvFMem+jfEfpWCQ/Zk2VEYzx/0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kt94JFKY/6hagsnzAflnAsOkNTQJHkVWTCeQJc/PqpU6Et5ZCnwTKkYSyD8O7olOOLPPw4ypc7DPJdQtQnyD7lazcIzI6dKwEv7rpNPp5qBWe1NyCen0CZ0OoU/nvCTlw2Q17OT+UuWMEYAy7nee1sPubTRVCjmF/hF5SKzdv0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GwNTLTQ8; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8B647E0006;
	Tue, 30 Jan 2024 14:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706623921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zBzQq5IufcMsy/RtjMvFMem+jfEfpWCQ/Zk2VEYzx/0=;
	b=GwNTLTQ8StsesbERh/DoVKvxkf9n8MUZ2ccyF2WyhsNiFwgYwUAQHLjGS62ThSxJ4hOK9U
	t/DJmfy+voD4JvFp8J5HbJ/M6hZtQNS77efTa5mY4Y96fIU3YioJNoS0Ac/tIpWaQQHOBr
	N1cwEKKghiGlZ++Kgf4ArRVmPlH1qzKF0fZxhH10RwxaNTwiWnyuMn6Tu6FVMUHpvf57ZJ
	MeZK6q2BsOkJMrr6cT+nUsEdn5Slgd0HrX9lpkauaRazRvmE9Vh03++0R88zGMdoYCQk9S
	P06BTI3lsbEfKNKK91VRzvIDPVU8kduotsSln2EynOFm3V/O6l+qKj1Xx1mFTw==
Date: Tue, 30 Jan 2024 15:11:56 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, support.opensource@diasemi.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, andersson@kernel.org, konrad.dybcio@linaro.org,
 amitk@kernel.org, thara.gopinath@gmail.com, niklas.soderlund@ragnatech.se,
 srinivas.pandruvada@linux.intel.com, baolin.wang@linux.alibaba.com,
 u.kleine-koenig@pengutronix.de, hayashi.kunihiko@socionext.com,
 d-gole@ti.com, linus.walleij@linaro.org,
 DLG-Adam.Ward.opensource@dm.renesas.com, error27@gmail.com,
 heiko@sntech.de, hdegoede@redhat.com, jernej.skrabec@gmail.com,
 f.fainelli@gmail.com, bchihi@baylibre.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH v1 14/18] thermal/drivers/armada: Migrate to
 thermal_zone_device_register()
Message-ID: <20240130151156.720ca0fe@xps-13>
In-Reply-To: <20240130111250.185718-15-angelogioacchino.delregno@collabora.com>
References: <20240130111250.185718-1-angelogioacchino.delregno@collabora.com>
	<20240130111250.185718-15-angelogioacchino.delregno@collabora.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi,

angelogioacchino.delregno@collabora.com wrote on Tue, 30 Jan 2024
12:12:46 +0100:

> The thermal API has a new thermal_zone_device_register() function which
> is deprecating the older thermal_zone_device_register_with_trips() and
> thermal_tripless_zone_device_register().
>=20
> Migrate to the new thermal zone device registration function.
>=20

LGTM

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

