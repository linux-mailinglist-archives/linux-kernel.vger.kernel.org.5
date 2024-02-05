Return-Path: <linux-kernel+bounces-52117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C5384944D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA9B91F24522
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82F9D524;
	Mon,  5 Feb 2024 07:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="M2L9jptv"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646D011190;
	Mon,  5 Feb 2024 07:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707117540; cv=none; b=nSphi5CRqpYXC+SE+JX861bciXhJwlip07wqENndk66J6M2c4wBYMaJFZiQHMCK3HCD9Pg62cVAtfhpGVoAFBu120S3RKKsqUdLweYZzUcwMTkrB39LHN5dcKRRJ/d6PAcUg4hehEsD52v5vubpRdnfdywDNWf1+ewv0HsY5szw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707117540; c=relaxed/simple;
	bh=73k30Uuu2I0nXwmzN/giEsYyYLykqNOzfOvlrrvM9QI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=jUXCCdz4+jvhNA6MeXAVUHd+8+Lnc/6UdzEqojGPm43C7NaWtPEr8yz4FmefHYANqki00+7if57VgyOHQMQLvDAVAyDIGwV60u3ddjWsYIzNuU/nxtN7PfovqtSrwfUvjdQNS4KAzrBwjNVxw+luNlzYv9ZpAese0EFu4nBfh64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=M2L9jptv; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707117514; x=1707722314; i=markus.elfring@web.de;
	bh=73k30Uuu2I0nXwmzN/giEsYyYLykqNOzfOvlrrvM9QI=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=M2L9jptvoI4I7+K/EudTNtJrCo0CPh8GMvqhLw1GZXVWPw7519nQigtlsdsflvKj
	 rID500k2cNuaQYce/tTHZi/nagQasi/P36aEfd+bMER9Z1psZ8xmcP1XsjJjDpmD+
	 If1DhcgKtHvqpFIGibeD2sLrkhJbynu/hR1vhmYsRqyzBtkFreY8t39DA3B5WwJmR
	 W3/a8I3DyWuzpvjmCDgGjjglQd6a8rJTtf5rfjs7V2zFQkkhoijM1acAzQFsg+ki8
	 JMs7PRZk5ELEXCza8+uUHGma0g7r0Si/Tz4Ho/ysHd2r9FXaaijRaVMe7xy4ImusB
	 m/JNDLfCsQMCTc/Zcg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7Nmo-1rebQ610LE-007sv2; Mon, 05
 Feb 2024 08:18:34 +0100
Message-ID: <0b255d17-deab-4d6e-bf44-d950b512dc14@web.de>
Date: Mon, 5 Feb 2024 08:18:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-edac@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
 Khuong Dinh <khuong@os.amperecomputing.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter
 <rric@kernel.org>, Tony Luck <tony.luck@intel.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] EDAC/xgene: Use devm_platform_get_and_ioremap_resource() in
 xgene_edac_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4hV7VJ0mx1v/VvrknYWWyPT1r0T07XTywcSSrrjZxNUELMe+hag
 MeVbBYU5q/nEhNx0LZ7rfm9tMQ25/pPdOPBlfB1mBPbH9bElk7c0sEEwTOv/QNFYXPkUDg1
 gm25BR26WYV5zBjKKVEJgGH6u3I+VFXERsXymYkVexBoij3lSv9dbX7Wti/2ct06xa1n+tz
 ob6G05muvdrywSLVHp0eA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZAg9M4qwheQ=;c5zCXkRmxY+UGlNIsKrF+g1zke3
 fGPzSLCw34v1RPBeYLeN09uPFDiiYIpivGB7A10GlwaBdEEVLe5gyKoXB4E2yGEu+4+p44Pgt
 M0JQyESTNaySDqnd3yADb7GSYB+2nVPU9/9X20FELbf7jAN1qoDyLyUTYmYKCcvU+mPnNv3HL
 qFevPiEzOe1zesSmEfUa5Wt1HaxGszvx/jsXqQm9BTRSbGROVwmGkOGOjAnIYij1C2OP+n9lw
 xWcD8y0XwqWL66YtZ7IIXAuD6adgkuK5aqgYvejaog2rRg+KWGINnQbI22UrEmg9nOwisGn7+
 azcBlFOpON1E6uAePbgEmuMUkt376Ggtg52udxWoDl/nxlRonv4QdqhZWkpWMsKqSPvXGwqv5
 S35o3A5zlGnO2lpgvtAKPMvftHrqJbXELqI/VOFZGJovEVftAIcAEbIN31bubkUB3S3KnPwbA
 kVU+9SK5IzW2aXHzZkDZtNURbD2G/0rVVjd6emS00QicvaZUQdeQqhgTo1MbnssG5hINMzbHr
 nbXNXdWRw2tXSPnnLwIIpEBAPsFlO6I/1/V9b715fJT2lVFHWpYlefEcmPFEKmRYRUpGfUiae
 ciM0FlPkf/ACR6mldBDse1WOy1jFsEeELznNvvjgyn19w49GvC8gIw7GN3UpWQntIJKUDL6qO
 eXMRgYBr9cSUUt7qp6ejQTvgb1YSQatV0z5U/SUk8JrQZ70XYrLrjYwO4Jw0a0q4Ys43lGAPn
 +a/w0J+ix4UfjIrQas3RrCdbxLHpvT5ZuLj/J6V1KpGkw9nJT7YjLmWF3qrNRWLNUSN4ai5P3
 6eqqLxTzfUoLtVhE/ScEPA5mqf18CI4rLVjMHex0xhF6s=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Feb 2024 08:12:24 +0100

A wrapper function is available since the commit 890cc39a879906b63912482df=
c41944579df2dc6
("drivers: provide devm_platform_get_and_ioremap_resource()").
Thus reuse existing functionality instead of keeping duplicate source code=
.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/edac/xgene_edac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
index 1b50f8160013..8776765b6d2e 100644
=2D-- a/drivers/edac/xgene_edac.c
+++ b/drivers/edac/xgene_edac.c
@@ -1903,8 +1903,7 @@ static int xgene_edac_probe(struct platform_device *=
pdev)
 		edac->rb_map =3D NULL;
 	}

-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	edac->pcp_csr =3D devm_ioremap_resource(&pdev->dev, res);
+	edac->pcp_csr =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(edac->pcp_csr)) {
 		dev_err(&pdev->dev, "no PCP resource address\n");
 		rc =3D PTR_ERR(edac->pcp_csr);
=2D-
2.43.0


