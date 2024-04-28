Return-Path: <linux-kernel+bounces-161509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4A08B4CF7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 19:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEB9F1C209FB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 17:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF0373177;
	Sun, 28 Apr 2024 17:01:59 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564E873163;
	Sun, 28 Apr 2024 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714323718; cv=none; b=nWKhRIiyVG5MFC0doSmG+bRHyO1wB85N4H88Xh9MRNVB12HUqxEe5A6idJ9r0pftRJBH15WTwQhDTrOSJWZXU/81EsGXiK2mTCrj9SJVXNFf2NkA0t7KJxyu2OyevR1VN5ZgrPVV40JPf1axppVr1wu2iv/xx/T98ukIMPA+Wu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714323718; c=relaxed/simple;
	bh=Po1NSWnLvUFuIzM7E7i739862Xt2hBqwStVAwBSv2So=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NL/GiMHEVmeKuymKRvu1ssqQX099v/8rhDJmxFBsTjYeuBQtQ0R5Ud4oOMN2ErtkinqHfSDvNz1WtDbrfNZrLOWwo32KdLRhKAEzxAKiUBBJ8aV0Vk2nyLV0iQiOP82BWE9Y45Wg/9zrSq6YjB90ztk1AN4niHw1as5CBUk3BYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b01.versanet.de ([83.135.91.1] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1s17uF-0006wg-Pn; Sun, 28 Apr 2024 19:01:39 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linkmauve@linkmauve.fr, Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: andy.yan@rock-chips.com, conor+dt@kernel.org,
 cristian.ciocaltea@collabora.com, devicetree@vger.kernel.org,
 dsimic@manjaro.org, ezequiel@vanguardiasur.com.ar,
 frattaroli.nicolas@gmail.com, iommu@lists.linux.dev, joro@8bytes.org,
 krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org, macromorgan@hotmail.com,
 mchehab@kernel.org, p.zabel@pengutronix.de, robh@kernel.org,
 robin.murphy@arm.com, sebastian.reichel@collabora.com,
 shreeya.patel@collabora.com, will@kernel.org, sigmaris@gmail.com,
 nicolas@ndufresne.ca
Subject: Re: [PATCH v4 0/2] Enable JPEG encoding on rk3588
Date: Sun, 28 Apr 2024 19:01:38 +0200
Message-ID: <3784322.QJadu78ljV@diego>
In-Reply-To: <20240427071638.79915-1-liujianfeng1994@gmail.com>
References:
 <20240418141509.2485053-1-linkmauve@linkmauve.fr>
 <20240427071638.79915-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi Jianfeng,

Am Samstag, 27. April 2024, 09:16:38 CEST schrieb Jianfeng Liu:
> Hi Emmanuel,
>=20
> On Thu, 18 Apr 2024 16:15:04 +0200, Emmanuel Gil Peyrot wrote:
> >- Only expose a single VEPU121, since the driver doesn=E2=80=99t yet sup=
port
> >  exposing them all as a single video node to userspace.
> I'm also doing work with the hantro node on rk3588 which has both vdpu
> and vepu. Discussions can be found here[1]. If I enable the jpeg encoder
> at feb50000, would it cause any side effects if other jpeg encoders in
> your patch are enabled? And what's the disadvantage of enabling multi
> jpeg endoers in devicetree?

the basic problem is that exposing multiple jpeg encoders would require
userspace to do the scheduling. Which is bad.
I.e. all userspace programms would need to know the existence of
all jpeg encoders and then somehow negotiate how to use all of them
most efficiently.

Think multiple different programs that would need to negotiate to
spread across all of them in the best way.

Doing this in the kernel, we just expose one encoder (and queue) all
programs would just pile onto that one encoder and the kernel then
would be on the hook to do the scheduling - which the kernel can do
better (with relevant code implemented)



