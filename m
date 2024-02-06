Return-Path: <linux-kernel+bounces-55093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1481484B797
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4F39288086
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D95113248A;
	Tue,  6 Feb 2024 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Ykd65aBQ"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3FB131E55;
	Tue,  6 Feb 2024 14:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707228966; cv=none; b=cLzkBqZFSn5/j0a7qNbRf3fsCuJHfH4uQf6Ij5sA+5NgRwMpMxFyY+WsgbSX8a9VRWWmPKFBrb0UDEeeQVupzp08xKUbMc9Em25i74eLKBDGM22N3tS2jVmO1m2hRsGH2C2yIg87JAOG++Ca/wQPpx1Qs38Nu5nemqmPeumAxzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707228966; c=relaxed/simple;
	bh=3i1pZdvo2r3BXMaevJFKXByzHrypyI04neeHTBdO3m4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BQXt3/Kvhzb1arHeRPSLyrbJbpdF1hppZRRKz8e5HkTA3Y2z3ynQMddLNKcdt1UiszY24tHTNc7yi3jXn3h03mF2424IC7y810GPQv3xz4SvjIgdOF1LAIq7YdmlNtjb37IVsuK4Oc6Gxsaj+KnrfNJFE7NEawPPxjg9tPdHWFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Ykd65aBQ; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707228943; x=1707833743; i=markus.elfring@web.de;
	bh=3i1pZdvo2r3BXMaevJFKXByzHrypyI04neeHTBdO3m4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Ykd65aBQh90DaRZO1x3btzWdGHH7FW88bZSoxGx3JNJVxxPkZt/OotK0KT5QVCPe
	 n9KByG8wCtMRcit5S64oEJuhVMM8mcK8GmBywydIUdbN8K0la+pc8zHA8Mg+d0WBk
	 JCbPObBs2E9RTvA1ZAr0NCYbLxCTV3Ax4+2EGHcT9uBfIRzple0RoL1AwEe6wO6rL
	 4XjZfQIJUNRWAgSfPL0KE/KYLluvS3NEk/ZEy6kmBbTjF67U+y3JsNf4z0/TA/Mix
	 oUbNxUWzGYnrv7Z2YPne5T9GKnWG2pbKj21sV/WsXW3E/aqHONEfIfgzMsU1gPxRN
	 FDt5RKtNvtQtduXvqQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3ouw-1qpX7n2Zl2-00zq1o; Tue, 06
 Feb 2024 15:15:43 +0100
Message-ID: <596b3bda-3bef-4e28-b9dd-08b96da97097@web.de>
Date: Tue, 6 Feb 2024 15:15:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] iommu/ipmmu-vmsa: Use devm_platform_ioremap_resource() in
 ipmmu_probe()
To: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 kernel-janitors@vger.kernel.org, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <e01cdb99-8497-4fec-b423-a0bfb483ac75@web.de>
 <324d4e02-6a5a-4112-a3a7-d7aeb5876acc@arm.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <324d4e02-6a5a-4112-a3a7-d7aeb5876acc@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1GavO/jqMcqRN1BtjZgAUfaF8zQP8ZZ6HX5WMwrlBEsJoGeDJVY
 IKXoCa9LumD5e+pjiU6GG6lQSgDPGG2FoL1UZsWwoGv3DPlNtv9Pe7X/ad8kaLXP8ihE+pO
 nnPCEo1NH32sPL24Obk2n5hjxETQSjWguVujlm8Dv52pPeA9N4TzfI1N/s3VlcVTN0PXMui
 Uq4v54OwpuJeRL2SxK4ug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Skb7Gp/BNDw=;4qnmnNiFDllDhJDPdwsxIUfqFhS
 a+iiDCkpzoIM6diumPEtrCekaGiHtQa0fH7Q5qXo2UwBMqMwpRHeX78I71hkgzoxf//BXoHK+
 fTgLXm6tzovAPHkRhtuTxjH4ZCMZM41J1C87zJd63cwQhN4Va3/DI2uluhC+OvwpT2VBUMnzD
 FpSSb9d0O0+iY1ILHEk8sObLEloKkSBmY9ujxwG7QLUIftRo3lnzBKs6W8PehsxMOFRcuP7Ge
 sWK9TVkZw1IIA3oibgLKd6wVT4nhRKSVp2WE62HNbouV/js423TUnYH/oP8T/1gLEC431Ve0K
 riL0IMPsP+OYegM6mJAONo9uEc0hZiEa1kCuQJxDR8t2pKvkeC0fpfvuJsro22cQJ+2mnGLwp
 GhYv0KBI8CaxTbZOYDrFgjtqiFVY984GJm57SCWLM9hgkF5xJmXT+99RlDzuNj2r560W1Faqz
 HoUjYhf8OOmNaz8VRJR190X6EGKo74PREYpJaJhopuaSmrmV8ylC7GfC1JJx7aHygpc5S7acr
 8BydEO3F3qzkIyFqCG9TdKzt1+H/zbR3T0435sYeX0XnO2bKWu9Juo4fyvG+kzYRX9O27oB+q
 70H4cNEhLtlKo+gzvCSoiqIVsylhEueqBODnC1HjsdR1t7ddpb09dSC3oRb+/l7RcXWLfCH63
 +4hrY6J6zZerZYVgQ5Jgn0QFQSY1jDb2is3MO5x205su3+feRbboVTC6/hs+anh36lphAM19X
 FBigUf9YLFyCdgux1Z6bEdrx3IUsEAb4tBbv15jDWDLz5LJVdp09PLZVrku+vFVy9VAh/Ofps
 aX4iYownoQSS8h7HKqQ0pTgrE7xsqge38K02Mszg+vabI=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Feb 2024 15:00:23 +0100

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


 drivers/iommu/ipmmu-vmsa.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index ace1fc4bd34b..7e28aac1e383 100644
=2D-- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -1005,7 +1005,6 @@ static const struct of_device_id ipmmu_of_ids[] =3D =
{
 static int ipmmu_probe(struct platform_device *pdev)
 {
 	struct ipmmu_vmsa_device *mmu;
-	struct resource *res;
 	int irq;
 	int ret;

@@ -1025,8 +1024,7 @@ static int ipmmu_probe(struct platform_device *pdev)
 		return ret;

 	/* Map I/O memory and request IRQ. */
-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mmu->base =3D devm_ioremap_resource(&pdev->dev, res);
+	mmu->base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mmu->base))
 		return PTR_ERR(mmu->base);

=2D-
2.43.0


