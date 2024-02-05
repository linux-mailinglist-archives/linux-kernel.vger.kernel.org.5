Return-Path: <linux-kernel+bounces-52715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ECE849BC2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 240EA1C22A11
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CC220DC9;
	Mon,  5 Feb 2024 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="g9WM9paX"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B19B1CD05;
	Mon,  5 Feb 2024 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707139717; cv=none; b=sy5ejbwy8kB+rhZXZUrYnUyOJ/Lw6Xo2//jWg+/zoeiV6MtW0/JH7jTlMPi4PfGQpIUu3QR3SPv8BBxe9nKzUBDZ+We8CgP1hjJ3kHZy7zaMPQh58vJ3W4Q3Y0oz+Ig5Po2qBdDaSnMHmomq6p6UPZOLq8eVQcdXsftqWRNJlvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707139717; c=relaxed/simple;
	bh=YOHneSgCtSbbCAEEWSDGu9l2zrgvc3/nDi0e9391Wz0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=l5/03DFgHgvz6gavF0onHEKADJftONKLU3zjcy4oN+Hrnq5oubRWrLS+ZhcTg9Udh5EukJRGi35F/PivRn5CRFwt26e8WMzD5sPl64kF1tl+nZCa0nuBkH0iZdwhEvTzRsQIOiCBOg3yFDLeWa0QG/LzXWeTJSYe8MsYhiJZT7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=g9WM9paX; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707139698; x=1707744498; i=markus.elfring@web.de;
	bh=YOHneSgCtSbbCAEEWSDGu9l2zrgvc3/nDi0e9391Wz0=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=g9WM9paXjX9wywiuC5nYS8ycoFA8SfmefVc3BzD/de7CgVa5xl428ZKV3T2K/rXR
	 a3uiJ6giTkCdc1D9V/3Sih5jKBSKoR7VgFXvaplcCgCyTeGI9ML58d8JjWw/UQgRH
	 YmyvT9Tx4UeAl4VXa/Bp7QNXitL2ynZgr2pAZfUraj0eAmm/wT5Q5lqldor8SZ9Qq
	 SGpOpdECNvPAPl7KDNpVD+MMJyNO0ANtEKWxlx2EjKR90jm1EJi2QXqYLlWIPWlY7
	 mrsYWBAUnjwzMMZ/rQFQgDbSs+UCOJNflpSbeUBK92X945/jymU3f2FHHj/C/SRN6
	 jhcxr1VKT8GzigsTSA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5lnT-1qwC8P30jj-0170l7; Mon, 05
 Feb 2024 14:28:18 +0100
Message-ID: <46f64db3-3f8f-4c6c-8d70-38daeefccac1@web.de>
Date: Mon, 5 Feb 2024 14:28:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] ethernet: wiznet: Use
 devm_platform_get_and_ioremap_resource() in w5300_hw_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4kOjvGr+eOI8kHD1c1zu6LXaME5jhgkOkZMJfdQiWaPO+hwI4+V
 1c2xPp5WClaUGRqNxb4QwwylZTeYI3ecagsR2nLhEev5Wgk+uR9ef30UbqlRzzbvAltYQUn
 aR1iGEWAks1T4Rj2kA/Afc8K16tQ24UXK5WjkEZBjDUppBZM57BXAKt/Bsmu8u88kRLc2u8
 dZ+uNdjSMMSVU7D9/qjlQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4Ac7b6On9jk=;4ivussFx913jbC6WDFNJonKUDMR
 RTAavQciVlj3k8PuQ4w9/Nr5QcB+YnV+6crIhImjI3/YeAvQdK5xhu7v/jUbW1lh0mrKJd+LZ
 DJTBersgp2hQgNZGB0pKdxzsIyEZIDHS/FuUfFIExwzpVkGpiYpMRwp5d7IGe0pyJhanZa7Mf
 yr/CVeBpfC8+zqYgFksNNsrY6NK3Lr801dJPej85YuNjTRXZgBfZtW8ceQiz2ZFLUhEDTJ3WE
 rF75wTPgjF17D+jHvIkVHKHb3mz0fdLrKXHgucEtPEsMLDkzAZdhcgvD/bUOAffEP2+YZu8EA
 QiuL4EjQ3SdElBsTMtFBiimMU+1zpQ/sQzBiHcPuScpKRb9hyYW4Liq5BrX7khyWggIeFz2l5
 rGg4T9R+Lf2tvh17lOTN9pA6prLqXUW2xVD/eMO2iyauWz1OoXNI4P9RQr/0Ey7DWJGyBgzRz
 mXAZg02oBQKwlVyE6fAjy6T6xcfuBiFcJCku6IJ7Oy90e7JLot9wGzK5VQzqEhMsoNHPOecCj
 +L7Z/7FyLi4wz+/LTNnd6e4GBnPYLycTkbPvSAnVsJo0r+6sV5IWR2aio2uqzjsdV9d0DkgZ5
 Oxd4DPh+0jAmqp5ZLgvXBK1YPZNTif8+idWI0RR1mkknX27WJLKGi9/eZltTorYC1NbBEohVG
 H/fdzra39ratSLB5h7twMuKip3V9Mfoy9QuKYmueKSHIGdJLV5Ua7rkqAr3ob3GAm4C2A/7hM
 YVLUtCc/SJF4ygcnQGzyXzSWckd82iDebD+Xwvzg8KqF6SE5OLgYC5MCJsi4fAKqHhlgC0VoX
 XimXV2409vqXyEenchjP888MTbdx41aJMPtm20bCOejeY=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Feb 2024 14:22:32 +0100

A wrapper function is available since the commit 890cc39a879906b63912482df=
c41944579df2dc6
("drivers: provide devm_platform_get_and_ioremap_resource()").
Thus reuse existing functionality instead of keeping duplicate source code=
.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/ethernet/wiznet/w5300.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wiznet/w5300.c b/drivers/net/ethernet/wi=
znet/w5300.c
index 3318b50a5911..f165616f36fe 100644
=2D-- a/drivers/net/ethernet/wiznet/w5300.c
+++ b/drivers/net/ethernet/wiznet/w5300.c
@@ -539,8 +539,7 @@ static int w5300_hw_probe(struct platform_device *pdev=
)
 		eth_hw_addr_random(ndev);
 	}

-	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base =3D devm_ioremap_resource(&pdev->dev, mem);
+	priv->base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);

=2D-
2.43.0


