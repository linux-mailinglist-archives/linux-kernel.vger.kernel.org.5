Return-Path: <linux-kernel+bounces-52406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 848B48497B5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40CAD283746
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CF9171B8;
	Mon,  5 Feb 2024 10:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="v+IqlpIG"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AA6171A2;
	Mon,  5 Feb 2024 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128666; cv=none; b=evb+LrDZ8L0JW3XsiNby2xWV8akbJnUlRIN+0c3qhCQVWaALg4k0SZsUcfvtBYDWS51hJU12m0sgh4ylYnCwirTFGhdkTVIfKKWVb0bBJQMf9whRGW72yqwJo13q6LeJqj3w5ryy2b93L/DmVVYCsL3tKuXAzL+NdDnwJdSwitI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128666; c=relaxed/simple;
	bh=NnYE8bbILAW26+vAJtdRxYeGAAdC5YtkedHUkzckdD4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=hQ6zq9TSyFk3aBO7RCZcvNvRhf2LD8oAkUCxv9HN6WLhH6ADwqSURFYqkS/LBJiS8wlqAOt0KW8okLhyi1GQgFuSOWkyXAUsqfDPs5SB4rtttKccZpmzZ+K7NVl9GJQxsAxhPVW/MUReyqEeBtunq1wLAeUzrE+Shn5VdRYKpI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=v+IqlpIG; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707128635; x=1707733435; i=markus.elfring@web.de;
	bh=NnYE8bbILAW26+vAJtdRxYeGAAdC5YtkedHUkzckdD4=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=v+IqlpIGM8LcYdlXGr8tIgZSbkYiaspbbGkDShtupIzcT/crkwMrynT1G4KeNUF5
	 V6WWF+r4/m6FzNZxIAVamOvWTJYUII+D7TbVmT79OTkyCDHRjpVGGoZsHhU/HRuG/
	 OZ1u1v+hCn0j7U1t+N1AcN4oTS8IlClHY6Mtyc8wfr5KSmDgDDPGJ6+cGT+bgaJ34
	 lyOVZQun0MeSMGUHhNo4VdGahne+YibjO2QSlHSAhsV/gucSb0PAxecU7CCp9RIfG
	 yB3CvZCOyj+He6vtd9/yv7IzTk+RGVsn0nCkO3q/dTMWLhnc9iTPxuZNWo3wV8WKr
	 ph+15O1kpyYaX4W+9w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7epr-1retgl3bRN-007wSM; Mon, 05
 Feb 2024 11:23:54 +0100
Message-ID: <e1458683-1270-4b9f-afdb-2f0112d66245@web.de>
Date: Mon, 5 Feb 2024 11:23:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 Alexey Brodkin <abrodkin@synopsys.com>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] drm/arcpgu: Use devm_platform_get_and_ioremap_resource() in
 arcpgu_load()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KVeAwmoXQTlXGed7bvDvvu5QWlrOEBIVyiLqAsV4nn+zEWWsXx0
 pb7SJ3z6qkW57aHeqg2cb394t85Soe3Lwn8qG2P0WO1yvfKf4jxgF4qT6H9aRyyWA4NBlI4
 7DgQavedJMooj60TH7uSxE1hc8nl3oPbcjVsCfOb5/K1WYr2iNURnHOb/xxQqaPfgYRSBjf
 ekGNL8KJ7mDUFOBRV+9UA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iCCk1+Z8zWQ=;IVOtri+y3nb3aQV+8+sKiAHKG/N
 Is8V2hQrHwSRwxenxyJiwvTOKq+40YvLeHkRr2ayfMNQrZ91lWkNnUt8IIwDKNu/K0Oq64bgP
 Y3ouzPC3ohS8lG1u2n8NMhiUUThcccOztYQfWwmrIjcc0aUU/VpjmfpHXmTeA98DFoInfRaqP
 TZYn5VAkCOLXCBvI7b8LNgyGb45UEbYAyZrhG9R+WitF58vcC2wvoWxuKfXJvz7e+tlXEnUNR
 Qqd5rcDBW/7i88k939/l0z8k/vpzRkChjyoIowYJzCVezi2vRp5COE3mk02tkMr5fGIctyqTG
 TZ8e05cE7j14oMZ9UGsPZLIw9VbNhFzRGnvtLBHfCLgWHfr4iCmC+b2qov+LUY4TQGDQiMTGE
 gACAfONy3JlJg24ssdkM1Z+WiAwVPmQKb1FKMiCp3qcS2ma6+CyZbkwiTbMai0GzVlFDtUCjC
 pTeEoCQofZVgf/cgtWyYI7RSe6a/0gz3DnboFQX97Q+zn2bQd38H0565X1Lv34dcbjbH7Qo0s
 DvQ6WV34s+cWAKtP4XCWDBtn9g175m5493IGCM7e/yRQQkT5KkyMbTKqWK7W4gymWkeQpkv75
 Y/nJAzQdytijbKKFQe6K5U8+pFKHCwoBmSytxSOsx5GDstvCL4JB2RJxWhf8vJJpqjL/pss8h
 hND6b8P3aZl5/mcTTe0SkJ65FCy9V+Kfd0pojQqnaRbRocncUHpsCCxOKbTzo1xTs2ycasfC0
 5HBNpPbXtPL/QwqkTqMvF9oQWeI4+brwutP86b0Yxnqzaf3ODrt9YlFSLujPVrL/bymvN8pWV
 ZHmXI0xbVZYlbCzrjZdZ1s1JJx2Zv+xxGW263iEekrAn4=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Feb 2024 11:16:27 +0100

A wrapper function is available since the commit 890cc39a879906b63912482df=
c41944579df2dc6
("drivers: provide devm_platform_get_and_ioremap_resource()").
Thus reuse existing functionality instead of keeping duplicate source code=
.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/tiny/arcpgu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
index 4f8f3172379e..29929f093d55 100644
=2D-- a/drivers/gpu/drm/tiny/arcpgu.c
+++ b/drivers/gpu/drm/tiny/arcpgu.c
@@ -268,8 +268,7 @@ static int arcpgu_load(struct arcpgu_drm_private *arcp=
gu)
 	drm->mode_config.max_height =3D 1080;
 	drm->mode_config.funcs =3D &arcpgu_drm_modecfg_funcs;

-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	arcpgu->regs =3D devm_ioremap_resource(&pdev->dev, res);
+	arcpgu->regs =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(arcpgu->regs))
 		return PTR_ERR(arcpgu->regs);

=2D-
2.43.0


