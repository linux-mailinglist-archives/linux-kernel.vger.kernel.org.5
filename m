Return-Path: <linux-kernel+bounces-52426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A29088497F4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D51501C233B1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8BE1758F;
	Mon,  5 Feb 2024 10:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="b4Qlzh7r"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BAE1401D;
	Mon,  5 Feb 2024 10:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707129760; cv=none; b=ZZ5nY8vOoUeRrBTYCSjaT+BsJtzQDrvJX4d7RLnMM9Bce7yPJhXVtfuRZjQNqAI2oxvhVcHsCR1T//eUF3pAwtG3AwVG7+5EHSDyFUOWdxx5JmgC3QL7nmcym9X0Tf+UpiFKkzUEU0pE0UD6e079PWQcz1ojvVMnjzwQtSCKh2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707129760; c=relaxed/simple;
	bh=/lTk+9N9Tl9ISnjaDgaHVZl0B7sj4vhWjLvyKn2MSww=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=mFiUxF60VRyl3abBEiZ0sj0lZyB2AmqW5gIMqdyTYNIHAwkAdjGtA6OfpWhq57F/IAYfNKq6VyAAntYYiF6M/7IfHyRcYfmD8T7RN4arnfg6JElSTe0jcDtEMRBf/w3N7khi8m0i1jZ4zKHYeI9qe01UsZ+LcLUfI38SX0VeRJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=b4Qlzh7r; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707129749; x=1707734549; i=markus.elfring@web.de;
	bh=/lTk+9N9Tl9ISnjaDgaHVZl0B7sj4vhWjLvyKn2MSww=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=b4Qlzh7rW8etxiqQ9lFmx5NbG2L6gB43ieV6ucFBlc4PY/yoE/EAqvhDitmqxorp
	 7xUMny9yfrpTjl3tQvFeFdzRxpP5S1pyJgDB8FFyHYutm9VfzSzdPoS/49VeBv2Ky
	 KkLN1X9vpYetfvec1ojdNjkifo6dVdv16gA7YixdCIvklth66i+f0jdKjl5gCgPr0
	 IBWUZlmhW43hGzzXv3v2ll6xH2qh3fi/7fhBDM1AgyfJpVwEfYo6lUyqgi7CRuNhW
	 H55+AEHTQfB4KtRaJjgmFAtYyM9VhIEKN+x3YdHP5iOCuHptgJguwWep7W92T4yze
	 +r1KT/g3tmYvvx8qeQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5CQh-1qqDeC1oTV-01140j; Mon, 05
 Feb 2024 11:42:29 +0100
Message-ID: <e01cdb99-8497-4fec-b423-a0bfb483ac75@web.de>
Date: Mon, 5 Feb 2024 11:42:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: iommu@lists.linux.dev, kernel-janitors@vger.kernel.org,
 =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] iommu/ipmmu-vmsa: Use
 devm_platform_get_and_ioremap_resource() in ipmmu_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pFkITfov5VDizKB661GXtaC2oOZeKctSayG3VAgdcSyTzXkOzU1
 HmdfJ8l3C9QNGlAT5M6Tn/wfC1X1Orhck5s229OEHQQ4Tco4fRQC+sZ0BxPcC64cE4yDmam
 5k3PdgvJ4J3X0D8JVFclnuKepZxQgvuqT0Ql8eOVdiQZlq9HFNVa8/m+SVNug+ioqidd7wP
 ED9vCEcPL1pZUg7FLFzqw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kEpDxHbnr7o=;w9Qz3MztgeXwbrCdkYQbthc/jXJ
 3U+0P71vSLLNiy5vXIgerarSjIG1qGqfTle8nC9ZRrXqyK1Q2SUA+oi1a1Za24Hk8VZ2fXRKX
 Bq9kQrsM5rAohCyiehpShGP6KU6siFZ4vqGmTDcyiimM0sOy/32QJ0MeErDc7bXGT8Nen9Mto
 HEP4eCSVMvO7nByKSULoHEg0Lju1KzI8+LPro93hEclqb4H+fW4tawQ2BG4XpFD0ECW7l8Ece
 jGxm2xKPAv7rDwVx5CIFvsrJSmbLlJzxicz085EpzqMAOXYCbN3/KQKjm3yErc4PQkO16UP66
 RiId4r+9g0jhCjfq9nlv5/5eU200aMud3FTdlGNRoWokamIetbJ7u7GQdFibdvU+w5JNfA3Ya
 vHJ2+jVvpPL2oeUeEb5mgTLJFewZ0slAEUzGtYgZteh1ULNUhYSRrNufHWJBU4vqfhd+dl/0o
 cjhP9uds+72TzOdAmQ2xk/LCXW4tHffvMlfGdWCqtcSQ34S/3ts6KacJovXixNeOGOaFe/U0A
 eDDNu26zNEVaZHqmvN/wA98sT52hQGTO6lGd5xH5C/tUvsfmmM+ESSxBcYzpS5PVjS9yOSTvo
 UyQ8IUsIl4ISkqijr/2g3XWIWlYXE8bbIjrOGAMvUdEuJGc+Oya4KMqg35jbjICgII4ayOuDE
 bJ1XKtlzlzBt5oEZFIFyEcxykQB60VknmGpIaTgmrErDtAL4Y9aEowUMMxrUNDRO/tgyPa2Tc
 025Q/bYTfg9UCV5iRki0befzjPK4bYEGesA/QOT8CprNS1jrH9eP/+Blm4shnZQ7gN16oM9AT
 G2yFLq0VfLosfLK1eaLV4uuL6thFYahOkvv3B0OxVuSlY=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Feb 2024 11:36:51 +0100

A wrapper function is available since the commit 890cc39a879906b63912482df=
c41944579df2dc6
("drivers: provide devm_platform_get_and_ioremap_resource()").
Thus reuse existing functionality instead of keeping duplicate source code=
.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/iommu/ipmmu-vmsa.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index ace1fc4bd34b..12685dd2dd31 100644
=2D-- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -1025,8 +1025,7 @@ static int ipmmu_probe(struct platform_device *pdev)
 		return ret;

 	/* Map I/O memory and request IRQ. */
-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mmu->base =3D devm_ioremap_resource(&pdev->dev, res);
+	mmu->base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(mmu->base))
 		return PTR_ERR(mmu->base);

=2D-
2.43.0


