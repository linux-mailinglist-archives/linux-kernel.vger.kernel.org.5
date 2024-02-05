Return-Path: <linux-kernel+bounces-52082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B987B8493EF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0E2281DD7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A54C133;
	Mon,  5 Feb 2024 06:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Ww464LoZ"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA97C10A11;
	Mon,  5 Feb 2024 06:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707115276; cv=none; b=coWq/tNiTaEhrDNECY+eeDcvybzg04lpd7JZVXxB1gUbhdyI6OQX77OOPY5pKbKgNOC+aSAgMxGEmZaEecTMsjrUON0xJyWZipZkAq9xm8C4vFl7hVX6EW2suS3RXPwrK4zAt4taOo2xFMk7vdmH6tes2MEKf9x+bpcFniMOLaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707115276; c=relaxed/simple;
	bh=am6WsuifvtPup2KTUXEts6d1h6SSbfsEYF607AIX13c=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ldJPWU8i+p9NbIZmNCx/mUYl2QCnn6hYytqFDO25kxVH8nGsQBNFlFT0FALiEtIEi8WABgPe67R7wpoebK1MRp1516MJe3o5R5g1ARiDEzhsjbGbETcSoZ0IMITJdPtIRjdWjx8ZoCzNOMwXu1NFvBdTFqcfnuClC2k8ri4+Xls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Ww464LoZ; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707115266; x=1707720066; i=markus.elfring@web.de;
	bh=am6WsuifvtPup2KTUXEts6d1h6SSbfsEYF607AIX13c=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=Ww464LoZ8MGtrwn3mtDZskPcSYooQG/aozaNuxeT+XNimsyA8HR2w0YTX2irdyCW
	 wrxdVrIlVFspVWvdRTLM32ozyQEsSf93emHg1eSVFOBbo8AjqYtskfBJwEImSvQY0
	 IegeOkYip6f5GaruAaT1GEFhe66COG/T9P1kvsKTuKU0RUdyg9XMHWZ8gc1gRzKKk
	 ef7UKo6alhmqTWChJqR1O2w+/OKf/uYM2PYVJRPMwmRWq77IRBCSAU1XXmNCAhQlh
	 gu3hmcdt6A3pr33cE6z383wyraynr3wcD5ltEMPok8y9cuQ3vH0yEZ+V6BBO8m6Xk
	 a2Pg3hnFY+rm3jeanw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBB80-1rjZim04ju-00CotE; Mon, 05
 Feb 2024 07:41:06 +0100
Message-ID: <10028785-166f-4473-900a-c845cb690dc8@web.de>
Date: Mon, 5 Feb 2024 07:40:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-omap@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Tony Lindgren <tony@atomide.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] bus: omap_l3_noc: Use
 devm_platform_get_and_ioremap_resource() in omap_l3_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kqs4HEnBiV0ZxdRFy0oeu4OxsPzCWVJFyn/mEzc1px5Uiqp8ru1
 btqpz+uTdPdwyHSQZbJss2+pHS0xbKzBZc7PQTlRFAbANOCWbgRa43foiMZuWPz95eI1izF
 cjo+iXDKY1iZpp5ecD9q0Fay1x3FgC1CzxqZEuJ4rTANb+BtK2CuIa3N/0/lPznGavi1lBX
 9FanZpqBuO5ouxBu3nP4Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kB2VlWq1rR8=;+CxqfSdMjrjrElOWuLwVnsPshuQ
 h88enz+jrTAHzpnTlQeIH8xpazjXWZ6JMoAb+Qa3hksQhzSy/Xq3wdtarX/zClST7pZo3uLEy
 qpba8Lio0bY4k7XH+h1p8X3stYslummXFE7aZD8i5sj0H4WWgZ1+GIDLLP3Ahre1Q3msFlgSW
 +xj+RNn6p9Xgm3d7IPOjdmzT0BiTj2qPG3ImLt1sv0z15gvHaPjcF7DWkzikhF/Tvyp8Ahgj9
 HQwhWRHBSSueRV0OTrMupGFwt1Ho2GJzodhB1APTLogcv2/EqdbL+k52NgI8sP8do5npkw2DI
 gkLQhcSVFiNqxPZ9HYBoQRZeaJtqiY+VuiGrc1BcNDArKWe8LWOwMoS55uVp0n3+OKylfYeFS
 6QmCogepuIZLRpFCQEdJRq0yKuvjzwUcyeRawqOwqrhzNx9lj4ZdMSKPshNIQjeGtG7CnkpSU
 xxGsmNd7t4dufptyN13kFHLBYijHDokPyMTZWHF7Y4h8dornzhfIYISq/TznPcjXvHbXRdApI
 mMaW5sUrV0pzDTN+cKwJbSSHNIYhRJSF+Uho+/KVcPgw21WohaaJReA7tYBiNIaXiqduwMU+h
 lSPq/b2pwvmQUEqI+I9a1fpTcEQUvBnZzqrSZOc0xbb/YzmHw+8ovvnkp3oT+KDRwNvcSGAGt
 x6hZyFlqKNFo8DKrk1r75MjSzQ4YZE8LYpDaqMPfu1Czl2pIgnFlXhl1R5sXsxGFXPa1SOcsE
 OoFDqwLcXrYIYk9CsD7UWpUoAl96Cw79f3jB5TaKqp7hE/dKePQu8rcTPpdzwaMmQFxqDvBEo
 DAZg0YuAu+lqISQDU1LyuZB6UHKNIP6Nl3Ol5Wq/vqmXA=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Feb 2024 07:30:56 +0100

A wrapper function is available since the commit 890cc39a879906b63912482df=
c41944579df2dc6
("drivers: provide devm_platform_get_and_ioremap_resource()").
Thus reuse existing functionality instead of keeping duplicate source code=
.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/bus/omap_l3_noc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
index eb1ba6319fda..3c9e342b9e35 100644
=2D-- a/drivers/bus/omap_l3_noc.c
+++ b/drivers/bus/omap_l3_noc.c
@@ -263,8 +263,10 @@ static int omap_l3_probe(struct platform_device *pdev=
)
 			l3->l3_base[i] =3D l3->l3_base[i - 1];
 			continue;
 		}
-		res =3D platform_get_resource(pdev, IORESOURCE_MEM, res_idx);
-		l3->l3_base[i] =3D devm_ioremap_resource(&pdev->dev, res);
+
+		l3->l3_base[i] =3D devm_platform_get_and_ioremap_resource(pdev,
+									res_idx,
+									&res);
 		if (IS_ERR(l3->l3_base[i])) {
 			dev_err(l3->dev, "ioremap %d failed\n", i);
 			return PTR_ERR(l3->l3_base[i]);
=2D-
2.43.0


