Return-Path: <linux-kernel+bounces-96598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C5D875EC5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 055C01C215CC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8914B4F5F9;
	Fri,  8 Mar 2024 07:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="D1EDDlTR"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007862AD39
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709883788; cv=none; b=C6rCbTInw9j87PUVZh6bCTTN+c7FHKvxKI536LWGb5gCyVytuvQ5yJGrRG8YkYpYtR4lhOc12XZMMqmHEi6IIGMo6TRepTZL5LgaHbSW/87hwP0Kr9UId5bSXGPgzYLcBOUQkZbhorL++IfauNFPl6pYRhsZZTXnlRCJVWws/dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709883788; c=relaxed/simple;
	bh=gAzhbqGYaUFA9Soc4JFCbArH4M6I4PLhli+YuD73UvI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klLFfZWGA9e+lmztc4bjBredidi8JpERB4CCVqN4slwS2ToZDDJTR3lyocClYPJ1bdCpZUvUEZYEGEkaHdCYKGHhukwEcLwgZhb6WLYidtfmxj5BJtgZQMbmPLd9AALOmuOYcVspfaLym/auPDYVtkZYz9gG7/+qyXnRX5aB9uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=D1EDDlTR; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1709883785; x=1741419785;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject;
  bh=KIogUl6yzQKUaleo4f1Dbqfw0xuGtCV1uUQgHKZg8Ao=;
  b=D1EDDlTRDrrVKlfMy+JGGHKWDKRdc+UCe1s7fmjS/Pb2eOKSGfZDKJUz
   t5t6q0m76SEOxs5H8PmwnZjD6VDHTSCDzBNeR1GTxmKzhE+SvuilfRp5k
   jYvpiEttw5KXhbkhPTVjajePxQCwBcUdfGhpQzQDWmjZsDLxLD3WREoiT
   XNAJjdr9d+/Fjri0K553Y6uIP/6G4B1ykH9UDhXNGpmPB023zk5vWl65v
   7JXlOwGfp6eAt4+CLd2r+oavueMZhEbfWqKLww31D4hLxJMkDWODdt5Cr
   MBnai0zvnem7g6unHxWmXjgr5ywxIyZOKGT5p/ZJ8viHILjb8fNKKBmpt
   w==;
X-IronPort-AV: E=Sophos;i="6.07,108,1708383600"; 
   d="scan'208";a="35801333"
Subject: Re: [PATCH] Revert "drm/bridge: ti-sn65dsi83: Fix enable error path"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 08 Mar 2024 08:42:57 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id C201928007C;
	Fri,  8 Mar 2024 08:42:56 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 08 Mar 2024 08:42:58 +0100
Message-ID: <3552711.iIbC2pHGDl@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240306-ti-sn65dsi83-regulator-imbalance-v1-1-a3cea5f3e5b3@bootlin.com>
References: <20240306-ti-sn65dsi83-regulator-imbalance-v1-1-a3cea5f3e5b3@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Luca,

Am Mittwoch, 6. M=E4rz 2024, 13:39:20 CET schrieb Luca Ceresoli:
> This reverts commit 8a91b29f1f50ce7742cdbe5cf11d17f128511f3f.
>=20
> The regulator_disable() added by the original commit solves one kind of
> regulator imbalance but adds another one as it allows the regulator to be
> disabled one more time than it is enabled in the following scenario:
>=20
>  1. Start video pipeline -> sn65dsi83_atomic_pre_enable -> regulator_enab=
le
>  2. PLL lock fails -> regulator_disable
>  3. Stop video pipeline -> sn65dsi83_atomic_disable -> regulator_disable
>=20
> The reason is clear from the code flow, which looks like this (after
> removing unrelated code):
>=20
>   static void sn65dsi83_atomic_pre_enable()
>   {
>       regulator_enable(ctx->vcc);
>=20
>       if (PLL failed locking) {
>           regulator_disable(ctx->vcc);  <---- added by patch being revert=
ed
>           return;
>       }
>   }
>=20
>   static void sn65dsi83_atomic_disable()
>   {
>       regulator_disable(ctx->vcc);
>   }
>=20
> The use case for introducing the additional regulator_disable() was
> removing the module for debugging (see link below for the discussion). If
> the module is removed after a .atomic_pre_enable, i.e. with an active
> pipeline from the DRM point of view, .atomic_disable is not called and th=
us
> the regulator would not be disabled.
>=20
> According to the discussion however there is no actual use case for
> removing the module with an active pipeline, except for
> debugging/development.
>=20
> On the other hand, the occurrence of a PLL lock failure is possible due to
> any physical reason (e.g. a temporary hardware failure for electrical
> reasons) so handling it gracefully should be supported. As there is no way
> for .atomic[_pre]_enable to report an error to the core, the only clean w=
ay
> to support it is calling regulator_disabled() only in .atomic_disable,
> unconditionally, as it was before.
>=20
> Link: https://lore.kernel.org/all/15244220.uLZWGnKmhe@steina-w/
> Fixes: 8a91b29f1f50 ("drm/bridge: ti-sn65dsi83: Fix enable error path")
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

This is reasonable and explanation is great. Thanks.
Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> ---
> Many thanks to Alexander for the discussion.
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi83.c
> index e3501608aef9..12fb22d4cd23 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -499,7 +499,6 @@ printk(KERN_ERR "%s: LVDS in fallback (24/SPWG)\n", _=
_func__);
>  		dev_err(ctx->dev, "failed to lock PLL, ret=3D%i\n", ret);
>  		/* On failure, disable PLL again and exit. */
>  		regmap_write(ctx->regmap, REG_RC_PLL_EN, 0x00);
> -		regulator_disable(ctx->vcc);
>  		return;
>  	}
> =20
>=20
> ---
> base-commit: a71e4adac20bfe852d269addfef340923ce23a4c
> change-id: 20240306-ti-sn65dsi83-regulator-imbalance-10e217fd302c
>=20
> Best regards,
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



