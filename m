Return-Path: <linux-kernel+bounces-52590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2956849A06
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EC24B28412
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260721BF50;
	Mon,  5 Feb 2024 12:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="vtp3+NxY"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6B21C2AC;
	Mon,  5 Feb 2024 12:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707135656; cv=none; b=lIYaPlGdNblQ72nanLNxMwJe6akkMsujUY/W7nUE9GGqU+ccwqsL/1uBurJw+6IKsf3lBI+aal9+G5Bh2j5YGkAV5UGkoM8lcpcOlGnspV+joiginzRnfoU043VnZNPRLPPfFa6iLl3MiIe55yRdTDlmiKjEsUXXI3SOzQSzYNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707135656; c=relaxed/simple;
	bh=ssiJlgBUI7ADgXSqk107hR0CggEulbQh1yQXI0z7sdc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=l06w0undXnc5lnhI5lyeOw26yCj8uOlwxzv3QJsEOKpYGi/abkj6j1SF83W0Bo2ilGlNlJ9bfN+xD6Z2IIXk7AZvyPKJbqwbrLTnBWrbTlua/H2gRg6VfEJd40PLWADaoEouz2Hiiisc/vP9Y+gNVgg2xaW1iM8ZV1/LVPZLHlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=vtp3+NxY; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707135631; x=1707740431; i=markus.elfring@web.de;
	bh=ssiJlgBUI7ADgXSqk107hR0CggEulbQh1yQXI0z7sdc=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=vtp3+NxYPaQVXNd+ebO+tEKeJ6HD7qi3MAxXoevBMmguK9PaLZ5/MoRxYaa0+DCZ
	 TD3GKN7XJiXray4h3S9I9YfGf+9/fVpxYFPG9382PLUOLSj0NqVL0mh26U0i195oz
	 rZjklZxMPm8kJtE0jHU1bHYbDwm5XAQp7QPNDCwDELhasBxANPJWzRNwlYEoWTBRa
	 LyTJW5G1xQ4EEyxHwsTHvB5ndbsK1FoQib4+i5s0QoV7msQ6os3b0ZkWqh8YFplA0
	 jHHHxrItYmB9WTsA0q9O8DatO9tBBfyPnfD7Ubl/jeP0GS5gPXfPQYae3CnixGcn7
	 fODx6hGqQEBWoMsIfw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mdf89-1qxuG61hOD-00Zemy; Mon, 05
 Feb 2024 13:20:31 +0100
Message-ID: <66d7218d-ed57-4dec-b6ac-630b01056b5e@web.de>
Date: Mon, 5 Feb 2024 13:20:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-media@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Jai Luthra <j-luthra@ti.com>, Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] media: ti: Use devm_platform_get_and_ioremap_resource() in
 ti_csi2rx_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c8yM135bGmgwYC7BG02277c5xhebqr+9/bcAkhSvOz8K9U1VdZk
 C1x4YkMyfvuW747HRLRycFhOiawMvQmF+5q4wq+lMHvfwaYPHiHnl1SlWMANc7jAv1RjGYP
 xJO58S+2daU2kHEXQQNDZTtzVPmIYADevmWLK/7kq8VsriHFa1U64zw+eA6DBQVad+3t4h2
 GJ/nZnrnDxv5KMk3QuGdg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XYQUlrf8/cI=;p+FRLnS58AOgbgxls0D7TAWU6yT
 3xoTpT5Kz6fwRYNCvz8HLRuEPDXBacEOE4CYolaqKxB1cNX791czIDlHaHObPLBJPn8uqTjRD
 D6WoL+WDYzjQmPjIRcChr4/QzPF6ZQligVYnHymEkAfj+FmY86UtB6IRO8nlCTw6jUumsI5BC
 ZOhifBuS+aZNGmSQNNCyENn5e2M73dlb+0kZOEUybjakHy7MTAwmqCaULYE3n2LqcR3GHQaHY
 qkFiiVPoNdfyCga8rf4dayFobCqYXqxWmp/o56tRI+9HrQ2UtXEwMc6wh5YWcNCSYPfO7Rh4U
 tZaMgrHncvibDJHJNkaphbnRwx1DyRycePchDrpvJXeIHJ8X6zPi9Izt6FwTWpg5ijOUxG8tc
 LmtX0GLoBz0c+xumOTJo3DY0CmJ2ULS1sUuhVGpj3z7E5TWBSG3sL20qBHitiYHMsc35sMJ6z
 cXKBTMn+2FZUTphdtqrqvsFs9SzYtmXi62lBbk6XKXlPL7MTkkqvWKe0XauGbYCUkg5AeywjG
 HzMcVOIZVN9IOwv1yIJ7ldLDd5DghCphEL5gp94QsoOXCJy2qE2XSwBANsrftg3Z1foV7MTL2
 U1Ke6aujzi8zvBJpg2psKRuGX0Y++dX0jo0bD63jzu390hrgELZxXmMiikflE0K2BDX8LOlaV
 oxUZLuWAA5saf+f6ur4qA8o6VZEKxpfXuIHX9BAE3KMV0CdjFUqf2Q+hZ3Cpxs41Idxic03wD
 HWN7g3YP0BZ1jhSLsgc1P//UtGNxyqsqDVShtn2RhElRuPRfKJ8S7lhDosmowFJx7cMHMP8iE
 Zw5PYPKlL8Fcxm4zSZQmwR22t7OLlCnG4XEYKpZVAV6GA=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Feb 2024 13:14:00 +0100

A wrapper function is available since the commit 890cc39a879906b63912482df=
c41944579df2dc6
("drivers: provide devm_platform_get_and_ioremap_resource()").
Thus reuse existing functionality instead of keeping duplicate source code=
.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drive=
rs/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
index 2b078c5d7f5d..6ff066097346 100644
=2D-- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -1100,9 +1100,7 @@ static int ti_csi2rx_probe(struct platform_device *p=
dev)
 	platform_set_drvdata(pdev, csi);

 	mutex_init(&csi->mutex);
-
-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	csi->shim =3D devm_ioremap_resource(&pdev->dev, res);
+	csi->shim =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(csi->shim)) {
 		ret =3D PTR_ERR(csi->shim);
 		goto err_mutex;
=2D-
2.43.0


