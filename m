Return-Path: <linux-kernel+bounces-68154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D14DF857692
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011CA1C22771
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE38214AB7;
	Fri, 16 Feb 2024 07:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Y98Li+Km"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C5E168B1;
	Fri, 16 Feb 2024 07:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708067262; cv=none; b=uclZVPyTELGvh/h6Zfg61B87+eMfTNeR215hWwvckYe4fArybhsNCHwXJRXp3x7/SDGGd42pATOpZXnx74ucmyDJk2mlKH81wOSXMxGjP+gcYH8MeDSi7j7Nw5d4sfrJ+pnOgFkK+Sv42Z307ZgrgzpU8kPOYv31EbNJnbsKQnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708067262; c=relaxed/simple;
	bh=8otNHmTYKeey+Dvf9L6LvBTAkUxF49iCfuzPFKJ6b0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MFxWx890TELxp2k1rsShflUuPQFgHoUxO1lPjdXS5Zzfb0bI8Cc5N7XqMCM/kUmjFcwhuOw4dddI0mRvkamlz8xboZtMHWqytlr4WAWuu8sj1tSnHP9jJRCJ/JG5UAMZq88ltJR8wF2EeA+ETT08Tkw6oQI8PpyzeSbqO6LekS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Y98Li+Km; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1708067258; x=1739603258;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WBfhOO5MG89bHmVdv1ErRWoZYXedtmnnpZfysTdIvno=;
  b=Y98Li+KmI5BVjn3s/So2vSo4fxHdMUTPWIeQuszu/Kq3cMnvVXJQUu2C
   wAuCKwpiZCg0BN0ukNxVm2392BuECVCWDWpuTNSG/TeA1rKrzVSqNrQMy
   OgJIyaBj75SOzjHOF6mEYHb5VJEeycehwjibLcBl2KCTgT++BZFuqc5Zv
   845oliGVs9mFLVe44DERpeO2U4qOMFGukF65hZ9tZ1nx0ie0+Z0xBHNSx
   hKxa+WuoIEfQRnj4JA3FAtaA2CKCJU0bEEow47aH8/qvZ2APCpNWi5dLu
   TehfBLbVFYIpZYebSr7R91oNNah3t9gRYP6MquCsBAzhlB4xtdQBEZuf5
   Q==;
X-IronPort-AV: E=Sophos;i="6.06,163,1705359600"; 
   d="scan'208";a="35436739"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 16 Feb 2024 08:07:29 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 56DA7280075;
	Fri, 16 Feb 2024 08:07:29 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: dmitry.baryshkov@linaro.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, vkoul@kernel.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, Sandor Yu <Sandor.yu@nxp.com>
Cc: kernel@pengutronix.de, linux-imx@nxp.com, Sandor.yu@nxp.com, oliver.brown@nxp.com, sam@ravnborg.org
Subject: Re: [PATCH v13 4/7] drm: bridge: Cadence: Add MHDP8501 DP/HDMI driver
Date: Fri, 16 Feb 2024 08:07:31 +0100
Message-ID: <3549548.iIbC2pHGDl@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <5bd01470cf971e2385ecd169c3d5ac659a020973.1707040881.git.Sandor.yu@nxp.com>
References: <cover.1707040881.git.Sandor.yu@nxp.com> <5bd01470cf971e2385ecd169c3d5ac659a020973.1707040881.git.Sandor.yu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Sandor,

thanks for the update.

Am Sonntag, 4. Februar 2024, 11:21:49 CET schrieb Sandor Yu:
> Add a new DRM DisplayPort and HDMI bridge driver for Candence MHDP8501
> used in i.MX8MQ SOC. MHDP8501 could support HDMI or DisplayPort
> standards according embedded Firmware running in the uCPU.
>=20
> For iMX8MQ SOC, the DisplayPort/HDMI FW was loaded and activated by
> SOC's ROM code. Bootload binary included respective specific firmware
> is required.
>=20
> Driver will check display connector type and
> then load the corresponding driver.
>=20
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> v12->v13:
> - Explicitly include linux/platform_device.h for cdns-mhdp8501-core.c
> - Fix build warning
> - Order bit bpc and color_space in descending shit.
>=20
> v11->v12:
> - Replace DRM_INFO with dev_info or dev_warn.
> - Replace DRM_ERROR with dev_err.
> - Return ret when cdns_mhdp_dpcd_read failed in function
> cdns_dp_aux_transferi(). - Remove unused parmeter in function
> cdns_dp_get_msa_misc
>   and use two separate variables for color space and bpc.
> - Add year 2024 to copyright.
>=20
>  drivers/gpu/drm/bridge/cadence/Kconfig        |  16 +
>  drivers/gpu/drm/bridge/cadence/Makefile       |   2 +
>  .../drm/bridge/cadence/cdns-mhdp8501-core.c   | 316 ++++++++
>  .../drm/bridge/cadence/cdns-mhdp8501-core.h   | 365 +++++++++
>  .../gpu/drm/bridge/cadence/cdns-mhdp8501-dp.c | 699 ++++++++++++++++++
>  .../drm/bridge/cadence/cdns-mhdp8501-hdmi.c   | 679 +++++++++++++++++
>  6 files changed, 2077 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-mhdp8501-core.c
>  create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-mhdp8501-core.h
>  create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-mhdp8501-dp.c
>  create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-mhdp8501-hdmi.c
>=20
> [snip]
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8501-dp.c
> b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8501-dp.c new file mode 100644
> index 0000000000000..0117cddb85694
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8501-dp.c
> @@ -0,0 +1,699 @@
> [snip]
> +
> +const struct drm_bridge_funcs cdns_dp_bridge_funcs =3D {
> +	.attach =3D cdns_dp_bridge_attach,
> +	.detect =3D cdns_dp_bridge_detect,
> +	.get_edid =3D cdns_dp_bridge_get_edid,

Please note that with commits d807ad80d811b ("drm/bridge: add ->edid_read h=
ook=20
and drm_bridge_edid_read()") and 27b8f91c08d99 ("drm/bridge: remove ->get_e=
did=20
callback") the API has slightly changed meanwhile.

> +	.mode_valid =3D cdns_dp_bridge_mode_valid,
> +	.atomic_enable =3D cdns_dp_bridge_atomic_enable,
> +	.atomic_disable =3D cdns_dp_bridge_atomic_disable,
> +	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,
> +	.atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
> +	.atomic_reset =3D drm_atomic_helper_bridge_reset,
> +};
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8501-hdmi.c
> b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8501-hdmi.c new file mode 100644
> index 0000000000000..e6ed13b9f9ca3
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8501-hdmi.c
> @@ -0,0 +1,679 @@
> [snip]
> +
> +const struct drm_bridge_funcs cdns_hdmi_bridge_funcs =3D {
> +	.attach =3D cdns_hdmi_bridge_attach,
> +	.detect =3D cdns_hdmi_bridge_detect,
> +	.get_edid =3D cdns_hdmi_bridge_get_edid,

Please note that with commits d807ad80d811b ("drm/bridge: add ->edid_read h=
ook=20
and drm_bridge_edid_read()") and 27b8f91c08d99 ("drm/bridge: remove ->get_e=
did=20
callback") the API has slightly changed meanwhile.

> +	.mode_valid =3D cdns_hdmi_bridge_mode_valid,
> +	.mode_fixup =3D cdns_hdmi_bridge_mode_fixup,
> +	.atomic_enable =3D cdns_hdmi_bridge_atomic_enable,
> +	.atomic_disable =3D cdns_hdmi_bridge_atomic_disable,
> +	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,
> +	.atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
> +	.atomic_reset =3D drm_atomic_helper_bridge_reset,
> +};

Please rebase your patch series, thanks.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



