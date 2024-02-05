Return-Path: <linux-kernel+bounces-52300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF84849680
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91EA21C224AE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B118812B98;
	Mon,  5 Feb 2024 09:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ovux59WT"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C4A12B71;
	Mon,  5 Feb 2024 09:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707125556; cv=none; b=mqvNERv5ELyNx9NdQfFAIMWRVRjU2l1keR9vdfAf8CdfJH9WvlPboYCdNFtbojFyAFQt0pR9M9Ft6f54yy8gXHKVOiKnBnobXz3l+0RBP19dOWh0pKAhOrtKDSMsiaH+dU5belGpwauEHeSgGEUxhH5JzXPJC6UFg0a0R/PfOq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707125556; c=relaxed/simple;
	bh=GEntBRcn/VvV5CPwy8i6X54F9AV/5jvw0rbYXd4l4oQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=M2r0rrlZn0vrh1dtKxUfuiQaW2of8iCzehxomaEj/zE4lDwi1ORrW0UxQyV4M6e/cC5aN9EUNRf5fo8fsBoudokgTsBsRdKgUJD3sMIDqfmuau/gJ9E6FcfpX4QtNmhS0/rrnWLNn084nv+z57ZPceVFYvKxf7N7K1tecw1r4Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ovux59WT; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707125533; x=1707730333; i=markus.elfring@web.de;
	bh=GEntBRcn/VvV5CPwy8i6X54F9AV/5jvw0rbYXd4l4oQ=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=ovux59WTPEtWvqN8rRPh8tPJL/y2zUri9qeSupWxr7mTWII6DPCIXoTEnUM69zib
	 gI7LPQUVxjvCIuXqiIsbOIy0AXB0J68XnavX67heKWA7I6Cp7BPEShIPb9rfGl279
	 7bREACCY4YqZ99V84eGeX7J4QBZAqj0zdOHEUShVERwV8/qbQkMYYyT7zY/jdV2w8
	 qUFu5DNT8qs1WvRLlq6XTnxN2TGAthDBdnemf5aX3BWdq4ktsu/FnlZ0YGLcr5Nzo
	 6TjEtQQzu19Q3t8LJwBRIqV6xnsgDFpJVac8wpEuxi9xKWTtyYO5Ce1KthvfSUMyn
	 tPTdXnXAQk0B2bbbrw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRW2R-1rLBlo1cqj-00NcQg; Mon, 05
 Feb 2024 10:32:13 +0100
Message-ID: <2a4ecf78-20e7-4678-a67d-0d66956b07cc@web.de>
Date: Mon, 5 Feb 2024 10:32:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] drm/mediatek: Use devm_platform_get_and_ioremap_resource() in
 mtk_hdmi_ddc_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WNiOKf02rYQX2wRHyD+44vgsxq4gvfzYMMnvPUEMljK8TxTVSZE
 crq19rcOVrfbBjGR4a2tr2LgwUdDKYHxZnfmOLYAwN7Q/U+6PCuurLhtYANurbla/ARGuuO
 EJRLtucvVTbdVD2WNcaEYmUGQzl8VgZJMsJ57eCz2srWUjfkWUv1JTFX6zkmehC+72rjhJc
 1KLOLVClOJ33TGxdHXMcQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WOh8rUEyD44=;2uUXQdcmdakS8l1q5N6ORN+MzQd
 PTEI2vpWHlHk1lzz5qPwlhQR30W8ymGIbUmylBV2BFLL0S9+0rcNjv7ZCziWx9bcp7FttBn9F
 8ZqjRa3EvtkSzT8JIVQjRcg7HIXr82VbWOYyqLbzgh3xCYNYnoEqD0S//M75LE0DGP6rMvTDS
 5efmaFuiDm4WUY5MQ7zpG2ro0E45Z5Svh5Z3OIiTH7VTrfhhKd00a2OsO5GRk84wppABZqMlX
 c6AcmKZV1qPTW/IT736+BpZRSo/yWfv3YVvKfyqDszssPNBQV9+l11Qr228pF5W8B2YC3bck3
 RscinEKcvO91A2MRNCzSNmYOkbQMkwlfepYHAZ1bNjPLepwrFcX2aqPw/HXxNwYmSyIxd8U/a
 X3y1VaXg1z/qsw1KFry5vJeplw3izdgHnQG4h4Vs0ta5bnzITl+3JspE82oNSY4mdbfiJLiFo
 haUnWxAJcXmm3nlpBKNkK0Q/9FnJK64GbT+HHTwGC33RSxmdI5nP0qjoyuFF+0c9z6mCudfDQ
 vwxYXuFXqix6/VlVKuANKkNPdN6MRhQqltrGht+T2IxqfPYoECFQNotY5xEH5s3xlwX5UI9qG
 xXiFRGtaBQXbx7XhOqd/B3Q5elC+G+8NSu0tlWVgiPmoHoDgHZUPaFkaO3SufpXUrH1x8WNy4
 qzkOnMypTqSAz/jlt9YYBLgyqh9H6E/U5ZxOALCXYNxafNxJQxA1gJ8ShrMvNh8aVBLecyTPR
 ITVGwM3ZqbrVSepwy105IemQUkZKzlcXlH4q8Iw0Za1lEAzp6rD881qoBssa6z8vJTifmgtAI
 UE0lmtKqNNkpFxPzRSxAbUSEJWT5fgCDKH+H4LCarI6fU=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Feb 2024 10:18:47 +0100

A wrapper function is available since the commit 890cc39a879906b63912482df=
c41944579df2dc6
("drivers: provide devm_platform_get_and_ioremap_resource()").
Thus reuse existing functionality instead of keeping duplicate source code=
.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c b/drivers/gpu/drm/med=
iatek/mtk_hdmi_ddc.c
index 54e46e440e0f..52d55861f954 100644
=2D-- a/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
@@ -284,8 +284,7 @@ static int mtk_hdmi_ddc_probe(struct platform_device *=
pdev)
 		return PTR_ERR(ddc->clk);
 	}

-	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ddc->regs =3D devm_ioremap_resource(&pdev->dev, mem);
+	ddc->regs =3D devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
 	if (IS_ERR(ddc->regs))
 		return PTR_ERR(ddc->regs);

=2D-
2.43.0


