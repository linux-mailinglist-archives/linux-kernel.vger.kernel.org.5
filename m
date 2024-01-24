Return-Path: <linux-kernel+bounces-37301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF7F83AE02
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69EBD28D752
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9717CF08;
	Wed, 24 Jan 2024 16:10:19 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D5040C1B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112618; cv=none; b=mWPR4ztMHIgGotY9Vc3iLEcveUI0izR5HXwW1IvX1K8t9Xx2WnFBO0ptbJQ0a7wF2eRFU9IDGOfg5Pds0DGc3Cz8OQz5l7cVntTeGj0hZ6SfdWmZpDhRxohytRySys7Pr2YDR1imEtlugBvi8fs/tMmYBnuOUFGP/QnT3LJr7+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112618; c=relaxed/simple;
	bh=Ujoipw9dh78mtkpsy6gJoGIWkFJGg9vH0lQ7gLAMv7k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CwK7V5xK2hwZ7akL+J8/5Zi+CPWVPsqZ5PtyFY6eChB2SpY8MINwJVpBB9MZWdlXi0wCej2MqKPWMr96JvStJ0gHDFMyrgqADk1YztLKTN6thRi7BLIRFld84knmRCFaDHoMsamNZqVqniGMoIhSWePOxhlKB+IhOaZz1CSY9a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1rSfnA-0007qU-9Q; Wed, 24 Jan 2024 17:07:56 +0100
Message-ID: <4e495bd7449159b9fe1710b673b6f9b4f185862d.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] drm/etnaviv: Disable SH_EU clock gating on
 VIPNano-Si+
From: Lucas Stach <l.stach@pengutronix.de>
To: Philipp Zabel <p.zabel@pengutronix.de>, Russell King
 <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner
 <christian.gmeiner@gmail.com>,  David Airlie <airlied@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 24 Jan 2024 17:07:55 +0100
In-Reply-To: <20240124-etnaviv-npu-v1-2-a5aaf64aec65@pengutronix.de>
References: <20240124-etnaviv-npu-v1-0-a5aaf64aec65@pengutronix.de>
	 <20240124-etnaviv-npu-v1-2-a5aaf64aec65@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Am Mittwoch, dem 24.01.2024 um 10:22 +0100 schrieb Philipp Zabel:
> Disable SH_EU clock gating for the VIPNano-Si+ NPU on i.MX8MP.
> Taken from linux-imx lf-6.1.36-2.1.0, specifically [1].
>=20
> [1] https://github.com/nxp-imx/linux-imx/blob/lf-6.1.36-2.1.0/drivers/mxc=
/gpu-viv/hal/kernel/arch/gc_hal_kernel_hardware.c#L2747-L2761
>=20
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etna=
viv/etnaviv_gpu.c
> index 9b8445d2a128..e28332a2560d 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -641,6 +641,10 @@ static void etnaviv_gpu_enable_mlcg(struct etnaviv_g=
pu *gpu)
>  		pmc |=3D VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_SE |
>  		       VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_RA;
> =20
> +	/* Disable SH_EU clock gating on affected core revisions. */
> +	if (etnaviv_is_model_rev(gpu, GC8000, 0x8002))
> +		pmc |=3D VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_SH_EU;
> +
With the other clock gate disables in the driver we match on all chip
revisions found in downstream drivers, even if etnaviv hasn't been
tested with the specific GPU. To stay consistent, this workaround
should also match GC8000r7200 and GC9200r6304, same as the downstream
driver.

Regards,
Lucas

