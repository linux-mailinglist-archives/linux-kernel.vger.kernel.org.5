Return-Path: <linux-kernel+bounces-55301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBED284BA9D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 794FC1F24600
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC150134CE0;
	Tue,  6 Feb 2024 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="qow08uAw"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31C813474D;
	Tue,  6 Feb 2024 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235722; cv=none; b=jtOhnsAik4NreUMajDgGuCYn3r7q5X21zgnwGN71ItrxHTR93q/oTHlksK7Vg3d2RtItnqhvD+4Cm31Ys1bOOLHAu2yaF63QMB92TnbJv1F2uWp64JjlIdENE6wGvdtDPDfWFQeGuW96a64P72r5r1QjX5LNyAwrLMVl6RfmbnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235722; c=relaxed/simple;
	bh=vTxrG4v2mMuRDOPQJTUsTxo4xRJdjAEb+Gx4TOmxTdc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NLe/rJd4+/QoWeuHLksaIW12bAKgH4h5TrJm4qHNAgHmB+Zys86Byqj7OrXBYV6ftWq+PCXA+/rQxL4xCbWSCnfgZaDU1i1j0kIe22T8dIWcy6h06vQwufLpkIwVxiNek3EapLHitd8LUKVo2xJBdmZf2Wfa1KQ6n4AhqdG+eqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=qow08uAw; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707235712; x=1707840512; i=markus.elfring@web.de;
	bh=vTxrG4v2mMuRDOPQJTUsTxo4xRJdjAEb+Gx4TOmxTdc=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=qow08uAwuU19vDccnNrSwQm999hAa+xaJqjaRKveLz4TuaqAlPS9xDy/FntFsVhj
	 gpHRLXkhaLsvjAl4qVEgHDGvkmfdObJD7GgrY/uuvFL0OdKVF4zA0VQwdsLjEG7l2
	 B1ZHGXJQTyFBJn31nLWvTOGy/vwZy9zWL9xbyk6v+zqKHGT0QOmMh16Oc/lI6rvWf
	 DTHqfPPW7/QSvf2L3nmv43pQKNtQ/ccfTg2BGJY851jjzFjIFofDeBuXzyrsb8rRg
	 /Z9Kp3+DVmdiNh5Ipupmk0eACCTAZzT2kT1rXuf/zPOVvOIngMInviTo78oqq95L6
	 oGao9Zg5yxoe/e5Sxw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MN6FV-1rH61y465N-00Ilk0; Tue, 06
 Feb 2024 17:08:32 +0100
Message-ID: <59412fc9-396d-4b62-95a8-1aed3d61cd0c@web.de>
Date: Tue, 6 Feb 2024 17:08:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] bus: omap_l3_noc: Use devm_platform_ioremap_resource() in
 omap_l3_probe()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-omap@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Tony Lindgren <tony@atomide.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <10028785-166f-4473-900a-c845cb690dc8@web.de>
In-Reply-To: <10028785-166f-4473-900a-c845cb690dc8@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yMKkzTis1C5GrJg1MYR0yoiI0PL6rmtZvDNGLvL1U/FuGBODU6U
 YmaRourHQLmJJlI4TyOdG7Z5UkiNz0HHSeuslLd3I7C9QMjuiDBEEkOSJPxWxmJSrhvZKK1
 ubwWVK4LkcnXp7ndwro4xC5TiQn7cn/tmr7srnfRZ3FDKg9DACDjk4zBDjpVmG6KYFhtYrs
 HzKIoRUk3TXQFXJF9ip0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CgzI+ARSy5g=;PGo8R9aGxN5wkV9x6th3wTbZxQk
 ajU59lUXBIyYEMOnll9JQJxGAkAH+2NeFRzzuLJMnXGsVxnfX6/fj6Qwmh9+oLUIV/VjVqLVI
 5TUKr4KB1+r0eln8fVx6UXL9nIYzmfiBFyv3JF8dZiv0OvNFCQAK8bV6xNTj55JrIbBK77lPW
 MwMXdU5VLFFup8kzRvogISabQC+pAK2uUVUeHpo70tuKNGrlZu3XkQjVC5prYiRmr7VShYMdu
 llgL3FLmplraSZyKsk/5acqp4xYdS+FLbIf/Vi9Mo5cwKiDvXs0WVPBCb8sjvENIOcW71+dBN
 G7CKSPjhYrxhkZ0az7/MOP0vU7HuezBDsXXtFVsm3w6jAqHiGU/Ezwky5Ug8kp3urgQHhE6XT
 lZE4CsUXk7mGTNDEzt4nLqveOifaFWnPFH/X3zAKL9S3B+7+HbQ6Z3QTtQaMKtl8imz6k8yRn
 zwKRjpH/AXgNXV32IxzZ/MHm1rjnKjdd0+M3kICYWiBmqDagSaLMXVKGPnoRuabGevTlD36Xn
 J0t02bl5reG0V3Nbd43a/crwEvXEOnjBV+YkIWmANn9DkryvOCkm348fsub6OWID0sa7hulRW
 TmvhpjVoauEHUoarEGeAbCT+v0egoAakA1TovMyYFvX4F4CyLDEZhAJIgox+dcfZKzsC3Mva6
 IbUeuFxWu7K4k86RGTHimJi25c6F0anAfcjClQeGdUH+KUPrHNPRsTGfXe3v8YpBdKiW6YOJu
 aQ+5meeXkVfDZ2WudzVLSTFLPfu9AdWwARqrF2HdUiWbfTOxYD+rVH2DI61a5qUSbCwQblcoj
 7CPjb41poqYz3o0bqyGi4IQqVKui2aCHfEOxrDoy7glFA=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Feb 2024 17:01:25 +0100

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


 drivers/bus/omap_l3_noc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
index eb1ba6319fda..f114dee4e937 100644
=2D-- a/drivers/bus/omap_l3_noc.c
+++ b/drivers/bus/omap_l3_noc.c
@@ -255,16 +255,14 @@ static int omap_l3_probe(struct platform_device *pde=
v)

 	/* Get mem resources */
 	for (i =3D 0, res_idx =3D 0; i < l3->num_modules; i++) {
-		struct resource	*res;
-
 		if (l3->l3_base[i] =3D=3D L3_BASE_IS_SUBMODULE) {
 			/* First entry cannot be submodule */
 			BUG_ON(i =3D=3D 0);
 			l3->l3_base[i] =3D l3->l3_base[i - 1];
 			continue;
 		}
-		res =3D platform_get_resource(pdev, IORESOURCE_MEM, res_idx);
-		l3->l3_base[i] =3D devm_ioremap_resource(&pdev->dev, res);
+
+		l3->l3_base[i] =3D devm_platform_ioremap_resource(pdev, res_idx);
 		if (IS_ERR(l3->l3_base[i])) {
 			dev_err(l3->dev, "ioremap %d failed\n", i);
 			return PTR_ERR(l3->l3_base[i]);
=2D-
2.43.0


