Return-Path: <linux-kernel+bounces-52192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 175F7849527
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC252823A9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A023111AE;
	Mon,  5 Feb 2024 08:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="pZczG7Bi"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B696610A2B;
	Mon,  5 Feb 2024 08:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707120836; cv=none; b=pzzhZPm3fO2CCd2F5vib2ZmsNYay0yFRIDCLvYVrXpHQAaUxqtDl6I0WwvzPzhFLBkUlr9Wvc+IVqW4VfBtYjur2TcC+etlAqwBepAS0wPwKH/bkO/rClQqpScjrtntWZGatv9fF2bHFjSWH1N+xpGoKa4P0QOVpGjEkB2wx0qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707120836; c=relaxed/simple;
	bh=dxF4ivzdSF/HaIs4ec/RkTHOP201pbC2sa9DIUYYSoU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=blijSRyO4l7a2iPIB95ol800XGlEot2OU+kmcAcZOLw9W+BcwsnVpMhbucDrdJnU5Idf1ac2vjgfRA3+1X3akSrI5WCB1nvipWfmYW2lVXTSL2XVfVBM6foON/+npJ0krT4FWMH+LumfWIZDBfBmxW6wqnN5U3MBFyTD2Qzuy9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=pZczG7Bi; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707120789; x=1707725589; i=markus.elfring@web.de;
	bh=dxF4ivzdSF/HaIs4ec/RkTHOP201pbC2sa9DIUYYSoU=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=pZczG7BiZs5lK/GxpvClvtCiEc7EwVMv8saNx6h7+pT9uK1XNEaSFAadoDE2NwtT
	 MEcfYCMv/Yng2UD1QVBfa9M+ixJ63WTHUvPP9BGD96V0UUSDt6uMkJr0nebAhLZp8
	 Bh/Dy/j0k0ZKVW48tQ77THk2tCWGH3Ut1Nww7SVHq8SIULAGV4/ZZPSjXMcnRaCo9
	 nA00luXzxU9zpFQSPYVBELpvej3OwyM3xWPvFEe+tTyVGGM9xmKuMwvL8XDgjJGqv
	 kMDjTbMWGs/o2CXLRYDQBKrLATJ5b952nrwP+dFtAWETBvVn5dZyZdUH5lrsLl09L
	 IUyeJJxUsjX7yz1XTA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXoYQ-1rVszJ1NHA-00YEY6; Mon, 05
 Feb 2024 09:13:09 +0100
Message-ID: <b236236a-9953-4246-a697-19ed1b22d86a@web.de>
Date: Mon, 5 Feb 2024 09:12:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Douglas Anderson <dianders@chromium.org>, John Stultz <jstultz@google.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Tian Tao <tiantao6@hisilicon.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Xinliang Liu <xinliang.liu@linaro.org>,
 Xinwei Kong <kong.kongxinwei@hisilicon.com>,
 Yongqin Liu <yongqin.liu@linaro.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] drm/hisilicon: Use devm_platform_get_and_ioremap_resource()
 in dsi_parse_dt()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x1wlb18xkfTer78Ie3A5E8ho8YYjVlXNiE+1fFQJwVEL8Dg7sjD
 VkU9bCD2c+KdRRPXYgktBqwam+KdeuL480zwnsexsipOISpzlebAiPV+4fqCQ8nPvhUeYeC
 +Xma5dgQtUtKzmPbiXf1JIev09eyrq0Q9TClbMZtoso5664ZrYeZbf2nKQH/21n48eHBUFV
 LJ9/EzcqKvgDMN42b4NEw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:s6zlX1qSoE8=;KuScP3CI6WKmk9vGzT4H1HlpKzB
 vvIYJ78Th36GzjPmVk2/smFacTy8svAj7uf/PIZUzTzCpEKbTPOCqiMpwvEXv+msUzpaRFoxd
 w7wf2RBPHYcoi8u5XuNmOeVyy55JG3qdWtC2idLbgMIDbw4irPOUgTRvhXRBbQRi+Li9GEd67
 ciDRmQwRsWXuipsnMGrFoN2TPK+lw/zPHi14eGSLxABVB17S9YlV9fD5aiYNiK9EaCTlYz/4/
 hFHHQM+D6eZwVevjMyuZ7CGefeuFqLM/sSkd+LcyLdUvgETL/7ls4+cWs+IMX2Uqnk/kMA/v6
 9m6gjWRCBrAHMJlx6QSQldePZEC4/mPkTfTuPHiajFGfr0NSLTA0lpulTUv+EN/72fHPrd1/J
 FvdxAkY5AFKHZh9u96evCpbIjoI03kAA/3LCTymWuxhtblxWuEgzT0QFqB3XSQ67zdySvpIUG
 O7cJ/n1CsvBFIBnX0j3UQcYWXQKijDD3kSibx9wYa/Ad01gZ3sRKCyiMSeXzZjNWXZkz5NYNe
 Ir8nsr3Ka7Uoaw9zKZe9dTCw/0QO6EyenXBA6VFHsD9VA3SLCXtOkhZ2rtSiM1KndOvVZVXIZ
 dPvz4lOtOPGxLvkS9ruywENO00K6Q+HUzptdzRf7DL7tG0UyJJrkP2OxKUF0Brg4Ur4C7v5+P
 BTT21nX3Ytm7mjxCqHgJvBck1XzmJ4C3z3fXsRuaITacutmfAeuw0s7G2eSZnm1jFBKp7BLQb
 tQUvSO/nQMtBF6+bn8O/HWjlsTkm9jZiXrMqUmcE4IucTijWo94fsDHGL5c/YqxRN8XOoodPa
 q03XJwObceXzqwVwnkw2aKLGOCq5ihJF9VnfZ/SV3ZquY=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Feb 2024 08:58:21 +0100

A wrapper function is available since the commit 890cc39a879906b63912482df=
c41944579df2dc6
("drivers: provide devm_platform_get_and_ioremap_resource()").
Thus reuse existing functionality instead of keeping duplicate source code=
.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c b/drivers/gpu/dr=
m/hisilicon/kirin/dw_drm_dsi.c
index 566de4658719..1edf429c49d7 100644
=2D-- a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
+++ b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
@@ -834,8 +834,7 @@ static int dsi_parse_dt(struct platform_device *pdev, =
struct dw_dsi *dsi)
 		return PTR_ERR(ctx->pclk);
 	}

-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ctx->base =3D devm_ioremap_resource(&pdev->dev, res);
+	ctx->base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(ctx->base)) {
 		DRM_ERROR("failed to remap dsi io region\n");
 		return PTR_ERR(ctx->base);
=2D-
2.43.0


