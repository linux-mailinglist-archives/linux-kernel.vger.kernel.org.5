Return-Path: <linux-kernel+bounces-55125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 207B384B810
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537DC1C215C6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1961F131E20;
	Tue,  6 Feb 2024 14:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="hBlS9meR"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E4A1E500;
	Tue,  6 Feb 2024 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230275; cv=none; b=WAlXJ90XbOa8iZow6Uaw64Eu8LkR43FDvZVwDH7KNhdraNDUiojnjpTueOGM5yM9ezlc7avAI5Lz8tQfyA7IW8L4T5aDpndUFx352syZZ0OYRQS4e7JytoIJPcmP4TcPPWjC6v8q46lRdEApPRGvcZzF46EOKoReJKE2vmb+S2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230275; c=relaxed/simple;
	bh=dACWXeLInRzV10diT38UakiAC6q/ddZegipCKPgaSIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j6hf06dYTBro6/9SJy3x71K9oxr9emE0W9y4I9s4ArGlQYtpRJpbbKDVFkB4+R0KEwqmTuBCHPQOXHKdXGKoteGFI/usfSPfe0xSNxoddE8M4WczpvnMu7lhm57uNF3vvWx4Bz7pJCbUDqusDjF+MrcUHNSQYJZ1w2vDBbU43F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=hBlS9meR; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707230251; x=1707835051; i=markus.elfring@web.de;
	bh=dACWXeLInRzV10diT38UakiAC6q/ddZegipCKPgaSIM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=hBlS9meRQMiujP0vn1fKOzs+e3SDvGJ6a8t6BNXdCHr8t2ofXCN89fEyOG07itUb
	 GHbpvXr4KZaFlFC/NmWxrIT41/rbmTEkbgYD+Rlypi3MHPigQZZDxWdCzf0sEd8ba
	 xzkpl0sI9p44e7ambb5vf/MtgoozrX2DrdrOUuUAs03kq7xrII2HNdzXvQRMm+7JS
	 l7oxVPKW/Zfl+4DGCeB+7gjOD8N76Vc0+fHQU4Y5nW+xEggDJsYCD7lwOA1+bnrl+
	 K3siz+uqqcXd6hvRSI0n/POYXsetNxv+tPSqKIuVy9dSKJfaHZT+U2bytCeE3Aguc
	 wjacLHgpySh/NczJLw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M59jC-1rYSVS3tkS-0016bv; Tue, 06
 Feb 2024 15:37:30 +0100
Message-ID: <c110c46b-e7b3-4175-9b14-d4cfc9982bca@web.de>
Date: Tue, 6 Feb 2024 15:37:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] media: ti: Use devm_platform_ioremap_resource() in
 ti_csi2rx_probe()
Content-Language: en-GB
To: Jai Luthra <j-luthra@ti.com>, linux-media@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <66d7218d-ed57-4dec-b6ac-630b01056b5e@web.de>
 <5m4zr6d3geqdyxtr5owlur4ysn6ublauvc5km3boga2vnm2rwj@mflpsf4ql2yj>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <5m4zr6d3geqdyxtr5owlur4ysn6ublauvc5km3boga2vnm2rwj@mflpsf4ql2yj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uOoIt/XHCy31CBnLmqQO7p8WTNob91ZFaGXyyNoTMv+1EVL+twM
 N5OpjyT0i6oPbhEc0sHmGqCF3M/Lw6qRaOso6La+BbzUgDbL7QrJnRBYkSQAjKWzC5iES1S
 9wFo4QYFX5dQwTov+QojYyTpkJmllrxPil87Ne7AvVvUoXkvMHy+SQCmryBbHi3Md+iWcsa
 bpJZp4qhdYB7Ba2kycQ6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WFXQQheY7yY=;Ji6+JHd+jVBWoMQ33Yl//JXx48H
 sv8P2NTg0wLYVkZ8ocH6Hcub7PjYtuxZMTmseR6w29PWJQa+D9PpHi+PqOMwvmYBVM4O2Cb8i
 OeklnKIlIPQEzHctKAijT8KUaXRyitgMSTM8943mu2ZJhuJE5UpgjIGr6QdJ5yv8mHGUXDbDo
 GhH9sZm5ylH/oyou1UpnRTBHQPPd8ToGHxRcq+sAF9hXgzRZ+nnu7dVCY9Zhib/u4nGp7dhln
 x+hRmlfeg1SvppAySmGuvgxFc4V8vkKfvU+YYd0/2xWNRSCcZeDWOc4Ax8a81LeqlP+iL+cQk
 RC6uqWcSk/wWHPNonhvfS9Zq0C969ZXcI0BbXraf3mPoIAMoxKsdohmHgQqhJ/Bl3OzPaKhHR
 MQ6T19u+AYpXRjmwmYcBBProjdo5iMLAldCnJU6ym6BzqfPNY7APed2CEJoOvthIdLjfVRc7P
 wmflmPuE3hBomfb4BQU5li4UxU5uSHo2R1Lvt9ANu7Nb58w43HcC0zFhlRKcNOzs0Dl2yjaMT
 58e3xhlIBdk5MzFdCf7MvJ8Zmv1zNpBiBwVDjQH872IROeCWR7ehZVbiu3RoFataAcvxEyHd/
 Hd95xSVQyrDAiXWvg0krX5AYMpRHK8Y7XaSG3rCrU/yb9LdXgFRxBf7Vqs7QEiW3Z15fMn2bR
 TMihaq6m2f2TV9ca3cSF/GOF0GmSfCc8oWRWealgmGMejXBdD2MLGWiVBbnszmaSYlagzzeiL
 jAc69qqdkVFS8gJfFEqYGuzsdBZZTDnnc7sOZb3wOk50emCFr9M1mUwZnL4IJ18b8IuylYVsS
 QC8v7evRBf5SFeUWzsu6DCyjKY9VLbVrCtdsmfWObfCfc=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Feb 2024 15:30:13 +0100

A wrapper function is available since the commit 7945f929f1a77a1c8887a97ca=
07f87626858ff42
("drivers: provide devm_platform_ioremap_resource()").

* Thus reuse existing functionality instead of keeping duplicate source co=
de.

* Delete a local variable which became unnecessary with this refactoring.


This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

v2:
The transformation pattern was adjusted based on advices by known contribu=
tors.

Examples:
* Doug Anderson
* Geert Uytterhoeven
* Robin Murphy


 drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drive=
rs/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
index 2b078c5d7f5d..54aba055c96b 100644
=2D-- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -1089,7 +1089,6 @@ static void ti_csi2rx_cleanup_vb2q(struct ti_csi2rx_=
dev *csi)
 static int ti_csi2rx_probe(struct platform_device *pdev)
 {
 	struct ti_csi2rx_dev *csi;
-	struct resource *res;
 	int ret;

 	csi =3D devm_kzalloc(&pdev->dev, sizeof(*csi), GFP_KERNEL);
@@ -1100,9 +1099,7 @@ static int ti_csi2rx_probe(struct platform_device *p=
dev)
 	platform_set_drvdata(pdev, csi);

 	mutex_init(&csi->mutex);
-
-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	csi->shim =3D devm_ioremap_resource(&pdev->dev, res);
+	csi->shim =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(csi->shim)) {
 		ret =3D PTR_ERR(csi->shim);
 		goto err_mutex;
=2D-
2.43.0


