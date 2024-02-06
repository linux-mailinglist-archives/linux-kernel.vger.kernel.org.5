Return-Path: <linux-kernel+bounces-55536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B726984BDC9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 244F5B27266
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CAE1426B;
	Tue,  6 Feb 2024 19:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Snf7yBIv"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1467A1B94C;
	Tue,  6 Feb 2024 19:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246223; cv=none; b=HB9mH0/HR9JytSUYPKCbel63713N+sjHcmirVDXi/IsPh+xT0d0I3BxRCZtr36Xu6+NTa90xjs1as2zE9KQY+nJUjRUGauvDgsfJsUxliNCPk9yazz/U5/5ZvwjG94WZtSUH1SA+IVwjBqvz5/uaG9nqY7sysFOVM8S6AE0hX4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246223; c=relaxed/simple;
	bh=FYZc1LEGrrqC1+w/ETxpgrgL8ru/UNKTc7lQka6Mvbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GJWx3GUG/p2Ds4C2kB54XBTpwtrNLi51ON8WBZLUu0hXET334+HG1KICeqPHsKSCwsFOPMFFHv8nCFfUy+CFVop6PtjMcomsY5tDBUOffon5EsA86ZHBRwIwOBE/Zhe5cKx9uf6jigWmwEp6ExH+e+4kUrBVcIk879kIVl4YJuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Snf7yBIv; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707246168; x=1707850968; i=markus.elfring@web.de;
	bh=FYZc1LEGrrqC1+w/ETxpgrgL8ru/UNKTc7lQka6Mvbg=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Snf7yBIvBzdWtiPR583PSVgqSpFc+/OpYFMacVTjpyprUXgQ2Exz+eHxwFeQiAXE
	 JVfFsoGq94BOjFIct7UHF7wYdeDZVrJC2BB3z6pHbnuaPtn/72Q3dR7cLDKvX+9o5
	 KDiBR1DNVMH3iJ298Lga78mBDr0TbL5mRLz2TxpcHT7pCz3HgWpOIdAs/SA0QfS58
	 EgacUkcYCjmvqX9JxWZ7p5gadhf48ThZb8cdQfKAionthqgr0lym69FMbwfMlFGXM
	 447hE+UwicdCUWlJ/19kbNQx1n7pRpGZEMDhFpj3d58G+MMckj5182KuuS0LddZ3k
	 mOmw6gmPdDL1SFdj+w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MzCA3-1qkhoC3NdT-00wGTb; Tue, 06
 Feb 2024 20:02:47 +0100
Message-ID: <10c0148d-696d-4601-8852-ee5bfea19602@web.de>
Date: Tue, 6 Feb 2024 20:02:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] drm/hisilicon: Use devm_platform_ioremap_resource() in
 dsi_parse_dt()
Content-Language: en-GB
To: Douglas Anderson <dianders@chromium.org>,
 dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 John Stultz <jstultz@google.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Tian Tao <tiantao6@hisilicon.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Xinliang Liu <xinliang.liu@linaro.org>,
 Xinwei Kong <kong.kongxinwei@hisilicon.com>,
 Yongqin Liu <yongqin.liu@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <b236236a-9953-4246-a697-19ed1b22d86a@web.de>
 <CAD=FV=Xsg3Fs8XQ0piBYKGSYOhuGXyKpoJ5dbtGPdP5HU+2RyQ@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAD=FV=Xsg3Fs8XQ0piBYKGSYOhuGXyKpoJ5dbtGPdP5HU+2RyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2kLa2ysUN9d2xVJRXxMU5jwpcPqpCNCqfK5aQK8Z8SZkAoJmwrI
 51MM/OnKS58cjcH+w2KlM8svznfZhdOBNIzjMDwK+K8nqwSAScyS+mLVhS6oKLmKh+VXXlc
 1F6sEjS7xdTg8/21QqOUqKV1QyEdUdwoFdL+s/lcAJTJzCmMxIqipPhlZnFOq799DZAX1NB
 9P19bitGoqHTmYyAN2Wkg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xkHi6bv8veo=;zt+BIeoCQAK8OkXMxk0kXGXRY+r
 Rl8t1SaL8N0etUcfbX9GFRZy8E2nr1PX3ujh9LTGIK0cv38ewfHlw8lfcIoqw3LGi0f90ZjPh
 c6DNCURdreKjJw19DEYeS9o82zVUeyTGA+Bw1gsQlRNTpY8cFzNPIbF0VT2vyUR40IHQH5FIH
 lV6E46PmNXz9oIiWrc5fVZR2Mh3OEQEE55aQ6z3r6jrlJV1yBICrtnnjDigXV+Vfidz1MjlaW
 2WdU8IjpYR+HAQ+Cgs/U7u5BiHkClvJdSUBjWatzI6icJ8hmd/Oi3YKVPp9xDy7xBcVdWecj4
 9bOk/qAownBHf/u9ZuK3CjW6u2AZhvz+0x8i5ADLQbCR2wVjGKYU5pdTdhgpElVgMAtFYP3Qe
 Sgya4Wfy72SyyUcJHk11TFvHO1GrVLDah39vEWGi1xOKNFZyrBqvbnB2f0no8/nqmldzVNS/Q
 2I3Pf7EyuYB+D+UkhB01eEKpbkUU6uRfiauH/EHO1nsu4w1hMoa9e3LdeJiSpxlH3NS3rn81I
 Pqaxb2VRpTpVE6NW0741ZEnMSOig9lHsrPIVRsS3eqFqBFcp6yCSrXGvtC5ZmGvMgK5VFcMf8
 Cl/Ymv1F3VYlOaWwICKtWtoMsojpj8vjspij47KuRpE3sfB9Wec+PCobopea1DFqFS8Vq7IGy
 eFOfE6b2Tfnc6hNlh2KhWGqoQUyHr9ops39+tW0OmGYRoLkkSL9ObWW3YSNkEBTM5BwRLVkg1
 gfwn5lEbHgWeMvstj8jjDmcWS7ehyWxVml8Vhyft0UKXe4Tw8fUpT1i5lrWPPNrKBNREdcFYL
 BqLNDFina4Yyjn+FExNsJbbATCdsZ0XGoSSOd79j0clbo=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Feb 2024 19:51:25 +0100

A wrapper function is available since the commit 7945f929f1a77a1c8887a97ca=
07f87626858ff42
("drivers: provide devm_platform_ioremap_resource()").

* Thus reuse existing functionality instead of keeping duplicate source co=
de.

* Delete a local variable which became unnecessary with this refactoring.


This issue was transformed by using the Coccinelle software.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

v2:
The transformation pattern was adjusted based on advices by known contribu=
tors.

Examples:
* Douglas Anderson
* Geert Uytterhoeven
* Robin Murphy


 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c b/drivers/gpu/dr=
m/hisilicon/kirin/dw_drm_dsi.c
index 566de4658719..6db6f355394c 100644
=2D-- a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
+++ b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
@@ -826,7 +826,6 @@ static const struct component_ops dsi_ops =3D {
 static int dsi_parse_dt(struct platform_device *pdev, struct dw_dsi *dsi)
 {
 	struct dsi_hw_ctx *ctx =3D dsi->ctx;
-	struct resource *res;

 	ctx->pclk =3D devm_clk_get(&pdev->dev, "pclk");
 	if (IS_ERR(ctx->pclk)) {
@@ -834,8 +833,7 @@ static int dsi_parse_dt(struct platform_device *pdev, =
struct dw_dsi *dsi)
 		return PTR_ERR(ctx->pclk);
 	}

-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ctx->base =3D devm_ioremap_resource(&pdev->dev, res);
+	ctx->base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ctx->base)) {
 		DRM_ERROR("failed to remap dsi io region\n");
 		return PTR_ERR(ctx->base);
=2D-
2.43.0


