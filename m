Return-Path: <linux-kernel+bounces-29074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E76EB8307E7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1906B1C23946
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187B42032C;
	Wed, 17 Jan 2024 14:22:50 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5F620305
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705501369; cv=none; b=ZYnJhxd726aEVsOidiYOb2V2bv5PbYCCDadd2w9JvS/S6q2VC47IlfT9nv3jRRrM9XpALaicliAHybkGiPm0Xr9Ou8qILFaBdXUxkNFK/FPVpgs99nv46ocGwjWCCJlBt5ayhOx/xHbYioLYjNQo1aVWNDd/FkSvMQyN0xs/C6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705501369; c=relaxed/simple;
	bh=QPnsa34PIweq9ph04OZHjus2xFdiAhqwHh0IvyGTctk=;
	h=Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type; b=u9xVDMMdqXHTN9pkObX6qBNhAOFiV8B9ErA6/lqVNOWakqgCLPfyh5sQbhpDyaH4s4vpOqcTBsNLQtTfbXxY6OM4A8ydj59OnkMzvNSuF1Turti8khWs5LBPvnKy8cTpjrBXs8n6LrdHFZiokfoAa4RgQdF+eZBfmMLYC01pa28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cd7.versanet.de ([94.134.12.215] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rQ6oK-0008Gl-U3; Wed, 17 Jan 2024 15:22:32 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Maxime Ripard <mripard@kernel.org>
Cc: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Alex Bee <knaerzche@gmail.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
Subject:
 Re: (subset) [PATCH] drm/rockchip: inno_hdmi: Explicitly include drm_atomic.h
Date: Wed, 17 Jan 2024 15:22:31 +0100
Message-ID: <8001861.oDFzTOozpa@diego>
In-Reply-To: <iuorynvlxp6m6u5hz3yi5d2ibfd3w6pdsm5ajlztjcsjuaczzl@f7jl7vyux2cl>
References:
 <20240115092434.41695-2-knaerzche@gmail.com> <3186012.MsWZr2WtbB@diego>
 <iuorynvlxp6m6u5hz3yi5d2ibfd3w6pdsm5ajlztjcsjuaczzl@f7jl7vyux2cl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Mittwoch, 17. Januar 2024, 14:47:48 CET schrieb Maxime Ripard:
> On Wed, Jan 17, 2024 at 10:52:04AM +0100, Heiko St=FCbner wrote:
> > Hi Maxime,
> >=20
> > Am Mittwoch, 17. Januar 2024, 10:46:57 CET schrieb Maxime Ripard:
> > > On Mon, 15 Jan 2024 10:24:35 +0100, Alex Bee wrote:
> > > > Commit d3e040f450ec ("drm/rockchip: inno_hdmi: Get rid of mode_set")
> > > > started using drm_atomic_get_new_connector_state and
> > > > drm_atomic_get_new_crtc_state which are defined in drm_atomic.h
> > > > Building does currently only work if CONFIG_OF and CONFIG_DRM_PANEL=
_BRIDGE
> > > > are enabled since this will include drm_atomic.h via drm_bridge.h (=
see
> > > > drm_of.h).
> > > >=20
> > > > [...]
> > >=20
> > > Applied to drm/drm-misc (drm-misc-next).
> >=20
> > wouldn't have drm-misc-next-fixes been more appropriate?
> > Because I _think_ the change causing the issue made it in during the
> > current merge-window?
>=20
> AFAIK, the offending commit is in drm-misc-next only

ah, you're of course right. Mistook that for the one in the rk3066_hdmi
but that was fixed back in november already.

So all is well.

Heiko



