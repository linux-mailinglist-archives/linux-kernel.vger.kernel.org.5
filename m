Return-Path: <linux-kernel+bounces-55324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D80E284BB1C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776511F254B5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDF9BA50;
	Tue,  6 Feb 2024 16:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="wm2GeNKk"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1342E552;
	Tue,  6 Feb 2024 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237332; cv=none; b=Sl1aPlLkxJUBEnbrUgJQ3Mu+cNE3xKAAWihXtL9zVBZuZ9dlWGINhXvDh9blYE5eP0Rtp5RhfkvTyueKdPIosKYAX6Xu+SE8x8s/OEgWJqaWL7ZtTV1xo/UATFSVBuFTrL2E06N9Ms6LyUZmOQNu2A+MMfqkFQqB05sohZjrzKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237332; c=relaxed/simple;
	bh=JM/dM6wGVgOsNpN99AnBS8S4uISuXxo9JPeocMSYoto=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MxR1dU0V5ONRhVWkbh7oht/w5skTXHyWapXWRS663eYotNq8knsLFqwXFvbxgEMEzl7HyN9/amsVeVGw4vLKSLoXpJ/IqA8o+nv8SkwJTfss6/k1BjISby6tpZ1Ab5BQ2etsJPsdZLUkjnIiBiosALR/8oQjUMeIDqnrr4i04x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=wm2GeNKk; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707237302; x=1707842102; i=markus.elfring@web.de;
	bh=JM/dM6wGVgOsNpN99AnBS8S4uISuXxo9JPeocMSYoto=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=wm2GeNKkzOndkNz/FtcaFa4S9HHjec3kDslAkK3GraBiGHrAmC00TncNVhbeqBDk
	 dI1i1sB69oHbVdYiHHSchrj9LrCVHAbTbNNk7nWefWQQkT2dHDB4cSNsZZLVRejnR
	 y0TgGNQb3ZPou/oJ6mfKrKpU1cWirhDQhv4tL3qtjEMuOns6zeHCmeknH2GyPEeah
	 qkIufCXsWWFi9+uQzCmj+a40Kba5FHwRvlbDV+NSkKCYvFwBEvn5/phnclWvdjtZb
	 0dZt3Yd7WDZt/0zjDefOQ1i7mic/Yiyi1GzIqZ/hZcFA+tRk5EHp496fzC7c0mVa+
	 XOVult7M7Rlgdp1nqw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MbCI8-1r0WVC29Yu-00bZlD; Tue, 06
 Feb 2024 17:35:02 +0100
Message-ID: <6e6ce5f8-b701-4660-a71b-478b29197a21@web.de>
Date: Tue, 6 Feb 2024 17:34:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] EDAC/xgene: Use devm_platform_ioremap_resource() in
 xgene_edac_probe()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-edac@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
 Khuong Dinh <khuong@os.amperecomputing.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter
 <rric@kernel.org>, Tony Luck <tony.luck@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <0b255d17-deab-4d6e-bf44-d950b512dc14@web.de>
In-Reply-To: <0b255d17-deab-4d6e-bf44-d950b512dc14@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hVEeAHWZkLBabGliku9TpAcPPUlMuNPVJGnTqc1ncndDJaWdiqz
 YkXhK1xHsPme+wPdYtE5z5VFxNbLpIa6lUSqXKzTxukevtlGSwPDKU8GaJfbE4+xK1ilUm9
 l4QodqIrM8Pc9YiHhoVkzkywvzjFktTpCw/HSRW9OGmg24lFh70VVurOGHjPrY4UYqLmLk+
 bgoWGL8r+og8Qow6uBrAQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oJf/jY8IscE=;Q+dSKDZhB+CRZBgbdhZB6FGd8+h
 lZ4qQNrVgZ+UFYwLfo7r4KNrViFvHZE0po8IlJ5SFcT62UUivK3MYd1LPpkyY1MtsvKNfLxHi
 yEY8GM8dJro0FmRJJW4DwmWYcLciEVnVjlhgahgKZTCTgeS1hM7J773mBZuxJtNGzPlvqnEWM
 8xIrbvQm+I5qJU3QPCxy/YiDlkToKOH3ZPeKPYk/9BGQ1GXUhXYD9+ODA99S+lAjj88ZD8s9O
 78rzvWfPPFm5EKr4NUsttFqZ3tzM2x6Og+jwMs939+OV1MEQC0+BEeCKKQJYilh42i0KfM6Gk
 dwvqk53uqmXWcMURgq1xYrUPeeOEczS3UOwdb0i7VQE83bfFYz/OTpOQ8TuhyWmvGGjfzTxYa
 D4fkVJTKt7oR3INknULpqlrn9lGJYcHpaqiNqh8m4Dx4SqUPVrtoQD03VXVWS6keBhs+alSC+
 DSnn4PJ/9jyH1Cypg9DK39u9f3M9h+M1uSvWfhEqpTh4V22G3LPIcDxT1yOfG1CrDn4e5HG/+
 hKdDw2um0ilxPMG4y+9hcLTno6kxW30c8xrtT5wl5Srd57hDagJX9HmNQTNchh1CZ4rOr3uFK
 OImKxLGnDdR5MRaRbCxMKm4UvkNUnjL4xlQP2+3Rbe63tq+3bQZqKo6Luo5Jb3J3PCK/I2Fly
 Pr0pNEpiR9hM7QUOwyfJC0mYx25qcqMkPJAZkwl009TIzwh1x4to/MgsFjwyEt19aaZCTKy++
 z1HSWt3Ipakixy8V3vYm+sKPXxemyCebs56anaIa5OR13Yr90lAs/RVGSneZNPoiSgC2wfyjy
 M9h7ere6ST0hrdNh5w2+vM9H4GRFiToE9adw0RSiXKdjs=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Feb 2024 17:30:11 +0100

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


 drivers/edac/xgene_edac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
index 1b50f8160013..59eb0e97adef 100644
=2D-- a/drivers/edac/xgene_edac.c
+++ b/drivers/edac/xgene_edac.c
@@ -1845,7 +1845,6 @@ static int xgene_edac_probe(struct platform_device *=
pdev)
 {
 	struct xgene_edac *edac;
 	struct device_node *child;
-	struct resource *res;
 	int rc;

 	edac =3D devm_kzalloc(&pdev->dev, sizeof(*edac), GFP_KERNEL);
@@ -1903,8 +1902,7 @@ static int xgene_edac_probe(struct platform_device *=
pdev)
 		edac->rb_map =3D NULL;
 	}

-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	edac->pcp_csr =3D devm_ioremap_resource(&pdev->dev, res);
+	edac->pcp_csr =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(edac->pcp_csr)) {
 		dev_err(&pdev->dev, "no PCP resource address\n");
 		rc =3D PTR_ERR(edac->pcp_csr);
=2D-
2.43.0


