Return-Path: <linux-kernel+bounces-120264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F7688D511
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446C71C24027
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9272261D;
	Wed, 27 Mar 2024 03:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iZi6g87e"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A58380
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 03:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711510507; cv=none; b=RnTKSZY3h2+Uj+PSOqK4RTOHUGazJxTivRaK8d464kmmVAc2n5QsVlYSpbILaiPNxlDkbr5mKsjAjOhZuPQuhjbpMeTzb5MpbJTwaiEXwoEzb9EpdDyDnT2m17GUcm3eZJ3Ycfu2R+vaYsbiVOF+GgVZkiVCxmKVsfqQBuzngfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711510507; c=relaxed/simple;
	bh=yE4PMETRYM/2rpfGQXheo9i6JB20t0k0UI0M+ZWUews=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=GgPA5SH9SBj9V+t0KqoELlODwnWGy6VKZ2Wi0HAIJgJF0FxJCpQcam15mWIGmxYvxC0pRYvqv1mbviGwgReGo53T7GgNg5210REO8J32IoqJ+2F5TbooGrmEcwyoKJWaXvb6pwQT0HB2RJU8DOIeq+eHJaoq9dkmXbF5+vIV4WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=iZi6g87e; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240327033502epoutp03e89f9005433181a7a21c82ba89642d59~AgbvzUGAb2505925059epoutp03M
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 03:35:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240327033502epoutp03e89f9005433181a7a21c82ba89642d59~AgbvzUGAb2505925059epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1711510502;
	bh=4vLIx4cKbVxH4k3P7I50/kDpmxK4TCaZJ+e8oBu8dro=;
	h=From:To:Cc:Subject:Date:References:From;
	b=iZi6g87ey5by0Q6f2un91DzAOAAfMvHjRGZCsxE1TmoJXggJhp+xFVKk5RZItBwZU
	 DyJF0p3hWBKAq/h7c+eKdkZwHnwLVnMC7DYuC2f2aCII8zqW5Yzg0fUipBSnn0EYFW
	 0jtAQbF6Rf94YufEyE+ZZFnTHg+Q1STnr1NvPBdM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20240327033502epcas2p4835a84a54f1999514440b7d361df4a41~AgbvcJbu02511025110epcas2p40;
	Wed, 27 Mar 2024 03:35:02 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.91]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4V4C3T3MMwz4x9QH; Wed, 27 Mar
	2024 03:35:01 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	0B.EA.09639.5E393066; Wed, 27 Mar 2024 12:35:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20240327033501epcas2p2bbe21301da5584f7f3a073c51a363c00~AgbuWqU8y1245812458epcas2p2F;
	Wed, 27 Mar 2024 03:35:01 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240327033501epsmtrp2cac592103009f2358a153ff29e04f89b~AgbuV7hV42125621256epsmtrp2k;
	Wed, 27 Mar 2024 03:35:01 +0000 (GMT)
X-AuditID: b6c32a46-8ddfa700000025a7-2f-660393e5a775
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	82.91.19234.4E393066; Wed, 27 Mar 2024 12:35:01 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240327033500epsmtip10f06e521fafec7b31e710706bda00497~AgbuMrnZD0139001390epsmtip1B;
	Wed, 27 Mar 2024 03:35:00 +0000 (GMT)
From: Jaewon Kim <jaewon02.kim@samsung.com>
To: Andi Shyti <andi.shyti@kernel.org>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Alim Akhtar
	<alim.akhtar@samsung.com>
Cc: linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jaewon
	Kim <jaewon02.kim@samsung.com>
Subject: [PATCH] spi: s3c64xx: Use DMA mode from fifo size
Date: Wed, 27 Mar 2024 12:30:41 +0900
Message-ID: <20240327033041.83625-1-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkk+LIzCtJLcpLzFFi42LZdljTVPfpZOY0g5VLxCwezNvGZnH/awej
	xdSHT9gsdjQcYbXY+3oru8Wmx9dYLS7vmsNmMeP8PiaLxo832R04PTat6mTzuHNtD5vH5iX1
	Hn1bVjF6fN4kF8AalW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk
	4hOg65aZA3SPkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAvECvODG3uDQvXS8v
	tcTK0MDAyBSoMCE7487VG0wFZ7krWt9NY2tg3MDZxcjJISFgInGm7y5zFyMXh5DADkaJr5cP
	sUA4nxgllre9YYVzZn4/zgbTMmfDdEaIxE5Gibt39kP1f2SUeHh0DQtIFZuAtsT39YvB2kUE
	VjBKbLvwAWwws8B6Rol1F74wgVQJC1hJfFu8gBXEZhFQlZi9YQqQzcHBK2ArsfxdNcQ6eYm7
	Z2Yxg9i8AoISJ2c+AVvADBRv3jobbLOEwC12ibPtDxghGlwktvx5DXWrsMSr41vYIWwpic/v
	9kLF8yXarpyBitdIbFxwCarXXmLRmZ/sIDcwC2hKrN+lD2JKCChLHLkFtZZPouPwX3aIMK9E
	R5sQRKOaxP2p56CGy0hMOrKSCcL2kGhpnApmCwnESqz/9419AqP8LCTPzELyzCyEvQsYmVcx
	iqUWFOempxYbFRjBYzU5P3cTIzhNarntYJzy9oPeIUYmDsZDjBIczEoivC1fGNKEeFMSK6tS
	i/Lji0pzUosPMZoCQ3cis5Rocj4wUeeVxBuaWBqYmJkZmhuZGpgrifPea52bIiSQnliSmp2a
	WpBaBNPHxMEp1cC0uv5Ws7NSW0VP5tqpfP6TXh9Vzug2zJohe5H1zecpridXMVz6ZVB1rVhr
	arFFaX0A+/K03Nl77l1aGfgipDCxlvkt10vW9/oCFf5rcuNXpocrTWmZvl35ocq/cwWetVUu
	3y2m9W3QCBf2+poXqjJH0engpUWqnr12oUnOjse8Lyz9pORy11L1yZP/m+euexBnc+X2lhif
	4PcvmSxuylSFWHspd77Wn+i3x37uhNlvZvwTsF95NPLWw+hrR5oClEJPTEk/r6Oybuqrez2u
	Gz9svWuzoHMy7057q6WP+b8kvOQ/s+0p48ECy+knGVj+KC41qfP3n6nmaMAe3Ju3Zb2tt39T
	/u5FhiFHu/bWbuVUYinOSDTUYi4qTgQAAk81zBwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsWy7bCSnO7TycxpBqt/MFo8mLeNzeL+1w5G
	i6kPn7BZ7Gg4wmqx9/VWdotNj6+xWlzeNYfNYsb5fUwWjR9vsjtwemxa1cnmcefaHjaPzUvq
	Pfq2rGL0+LxJLoA1issmJTUnsyy1SN8ugSvjztUbTAVnuSta301ja2DcwNnFyMkhIWAiMWfD
	dMYuRi4OIYHtjBL3Fy5nh0jISCx/1scGYQtL3G85wgpR9J5RYsG69WAJNgFtie/rF4MlRARW
	MUpsWn4GbBSzwGZGifbz51hBqoQFrCS+LV4AZrMIqErM3jAFyObg4BWwlVj+rhpig7zE3TOz
	mEFsXgFBiZMzn7CA2MxA8eats5knMPLNQpKahSS1gJFpFaNoakFxbnpucoGhXnFibnFpXrpe
	cn7uJkZwyGoF7WBctv6v3iFGJg7GQ4wSHMxKIrwtXxjShHhTEiurUovy44tKc1KLDzFKc7Ao
	ifMq53SmCAmkJ5akZqemFqQWwWSZODilGpjmTTZvYW79OHv6jNkHRNkFf4QHsYlEf3q2PSk/
	edenJW+MmmL/uB1K/ZJ0z2Xy89sNmRLR17d7yZXe0V21Vv3pEjWeYPVPqltNg2Y0pk3QXata
	+yzKc2GQYFNZFL+yRp7reS5WsRsh7l6d16TepH17HpxluoVjmc+2t0aTTtecSbETes9y20F+
	U+X5Vhu3TTYLtXo3/yt6f2vCacll2h+2pH61jOCreWfd+KbkllTnFp6FrjImdnO9W1evOXVw
	doY8xxP5Cqk1N58pfJZZfY3B6XzUAevyi8arNx49vueA2RtFDgm184f3PDELSLlT7dZy7d3r
	k8v0Xy1aHntyjvok6/Oz6zol3j/1m16rl6ukxFKckWioxVxUnAgAnZWtWsgCAAA=
X-CMS-MailID: 20240327033501epcas2p2bbe21301da5584f7f3a073c51a363c00
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240327033501epcas2p2bbe21301da5584f7f3a073c51a363c00
References: <CGME20240327033501epcas2p2bbe21301da5584f7f3a073c51a363c00@epcas2p2.samsung.com>

The SPI data size is smaller than FIFO, it operates in PIO mode,
and if it is larger than FIFO mode, DMA mode is selected.

If the data size is the same as the FIFO size, it operates in PIO mode
and data is separated into two transfer. In order to prevent,
DMA mode must be used from the case of FIFO and data size.

Fixes: 1ee806718d5e ("spi: s3c64xx: support interrupt based pio mode")
Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 9fcbe040cb2f..81ed5fddf83e 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -430,7 +430,7 @@ static bool s3c64xx_spi_can_dma(struct spi_controller *host,
 	struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(host);
 
 	if (sdd->rx_dma.ch && sdd->tx_dma.ch)
-		return xfer->len > sdd->fifo_depth;
+		return xfer->len >= sdd->fifo_depth;
 
 	return false;
 }
@@ -826,11 +826,11 @@ static int s3c64xx_spi_transfer_one(struct spi_controller *host,
 			return status;
 	}
 
-	if (!is_polling(sdd) && (xfer->len > fifo_len) &&
+	if (!is_polling(sdd) && xfer->len >= fifo_len &&
 	    sdd->rx_dma.ch && sdd->tx_dma.ch) {
 		use_dma = 1;
 
-	} else if (xfer->len >= fifo_len) {
+	} else if (xfer->len > fifo_len) {
 		tx_buf = xfer->tx_buf;
 		rx_buf = xfer->rx_buf;
 		origin_len = xfer->len;
-- 
2.43.2


