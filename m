Return-Path: <linux-kernel+bounces-47175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F3B844A20
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6BB1C247E8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85863987C;
	Wed, 31 Jan 2024 21:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="l55pmr8W"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AEB39851
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 21:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706736966; cv=none; b=AqbE3Glrhs6L6Sc+Ya/Clef7NsYc642MC7hbP1q0oSxToN9tCqR1oElYZKnZz6/LxIxnxT+dhdbZfeSsd6QuUoNkDCH+Qb4wNgThBEGFQaByiazktkd2/OcKKDIREm2oO3HQUaPlXXLs3zMjmcLcrUmswAUNHzcf/e7MMM9ps+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706736966; c=relaxed/simple;
	bh=GYAGK+6wZfDEd17X7XEyJShO8IyOKnBNgDDgZrd+0FQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=QTgvuLP9PRFRWEB/7s0tXOU26yKk3WhIFkY8ClJQxHlHiRDpjH0HCQHsNWKcjzLq1eNRDrDI2Y7il0aiX4sfdEXzxSVjjpgUnpjhLzhZDRRDqo0GlWKy9zJ+csO4FOQcSFS/ApfNeWo7fdAd2s65BtyRnD21zEfeivbCwEyhEjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=l55pmr8W; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240131213601euoutp0100cfa8246f2425ed167aa9f5c92b04e6~vjDlZxJ3_2999029990euoutp01o
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 21:36:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240131213601euoutp0100cfa8246f2425ed167aa9f5c92b04e6~vjDlZxJ3_2999029990euoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706736961;
	bh=8FhZbSfgegnhtR5RRbzkCWHX3gwqerDw8YHUYMMgLLU=;
	h=From:To:Cc:Subject:Date:References:From;
	b=l55pmr8WGjkxb3Eps7kASjkcNOd4u8QwI2kfDCeUqhcKMBq52IpEk1NiyBKJfjgm3
	 XMUrYBnfUlOZtu3kyohqLL7KYg5oNO1MD0RkkOFyGIXZoPNceF+DuyWgXB5TfpdAQo
	 mMRPzUKoIDqWVHX/ogi5Z5VGiWNliB5UYb9qPHKc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240131213600eucas1p1a787991b50fedee0e5395b279a7b9e04~vjDkaB_aE2300223002eucas1p1M;
	Wed, 31 Jan 2024 21:36:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 5B.C5.09539.04DBAB56; Wed, 31
	Jan 2024 21:36:00 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240131213600eucas1p12ecf4d6fb101425fa35e50f45a241c84~vjDjzz3j10038700387eucas1p11;
	Wed, 31 Jan 2024 21:36:00 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240131213600eusmtrp102440985bac7556b0bfdd79be958b15c~vjDjzUe-32141021410eusmtrp1z;
	Wed, 31 Jan 2024 21:36:00 +0000 (GMT)
X-AuditID: cbfec7f2-515ff70000002543-f6-65babd40b7f5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id D3.F6.09146.F3DBAB56; Wed, 31
	Jan 2024 21:35:59 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240131213559eusmtip270d3feb5e5693eb26f3204cedd337576~vjDjVkA3G2026720267eusmtip2S;
	Wed, 31 Jan 2024 21:35:59 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Russell King
	<linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH] tty: serial: amba-pl011: Fix removal of the QDF2xxx
 workarounds
Date: Wed, 31 Jan 2024 22:35:43 +0100
Message-Id: <20240131213543.958051-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42LZduzneV2HvbtSDSa9U7VoXryezeLdXBmL
	jsnbWSwu75rDZnFo6l5Gi7VH7rI7sHlcvnaR2WPTqk42jzvX9rB57J+7ht2jb8sqRo/Pm+QC
	2KK4bFJSczLLUov07RK4Mm5vKC74x1HRdXc5cwPjGfYuRk4OCQETiWcnZwHZXBxCAisYJeZc
	/sMK4XxhlFi6bxorSJWQwGdGifZ3EjAdX2Yfgipazijx7u46FriOo5MfMINUsQkYSnS97WID
	sUUEFCQ29z4D62AWuM4ocWzdBcYuRg4OYYEgiYNLI0BqWARUJV6dWQd2E6+AncT5O7OYIbbJ
	S+w/eJYZIi4ocXLmExYQmxko3rx1NlTNTA6JjcfkIGwXic9XpjBB2MISr45vgfpTRuL05B6w
	QyUE2hklFvy+zwThTGCUaHh+ixGiylrizrlfbCDHMQtoSqzfpQ8RdpT4MWc+K0hYQoBP4sZb
	QYgb+CQmbZvODBHmlehoE4KoVpOYdXwd3NqDFy5BnekhsXzvYyZIgMZKnFvZzzKBUWEWks9m
	IflsFsINCxiZVzGKp5YW56anFhvmpZbrFSfmFpfmpesl5+duYgSmmdP/jn/awTj31Ue9Q4xM
	HIyHGCU4mJVEeFfK7UwV4k1JrKxKLcqPLyrNSS0+xCjNwaIkzquaIp8qJJCeWJKanZpakFoE
	k2Xi4JRqYKr99ZTBxn5/2F7R7KQnysbcPT9jplq+0NA8Oyty0uOOy4r/23oEXF40W1lHreNo
	L3vvGr81uCRF8MDBJbsWT5t+SqH05YokrZOPThcWbSxSvHZ4sqSAzDs2m7Uz4ti/rJS8/uqO
	wT6NIN0NhS0bj/muTcsqkno5mUlx6jpRhtnfGyc94F7/t2LPsZxZnkvuRiq/vNO/L+dTU9uz
	My5ea5t4bp10iZ24r2Gn1tHIjNwZFXPffpQ0uJA0k+n7+8hpUX+zXh+eO3vrdMGAVy4bcryW
	rl/9jdGvobKT/9QXRqm3udGOikouDb8UI0ymTOTJOaP1acUO6zqpub+KP2xf6Nb3gLW60HjJ
	t5WsMtX3/+UrsRRnJBpqMRcVJwIAvqPq46IDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsVy+t/xe7r2e3elGuxfbm7RvHg9m8W7uTIW
	HZO3s1hc3jWHzeLQ1L2MFmuP3GV3YPO4fO0is8emVZ1sHneu7WHz2D93DbtH35ZVjB6fN8kF
	sEXp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZdze
	UFzwj6Oi6+5y5gbGM+xdjJwcEgImEl9mH2LtYuTiEBJYyiix4u4HRoiEjMTJaQ2sELawxJ9r
	XWwQRZ8YJV5+XcsMkmATMJToeguS4OQQEVCQ2Nz7DGwSs8BtRonmJ6fAJgkLBEisfbwRbB2L
	gKrEqzPrwGxeATuJ83dmMUNskJfYf/AsM0RcUOLkzCcsIDYzULx562zmCYx8s5CkZiFJLWBk
	WsUoklpanJueW2yoV5yYW1yal66XnJ+7iREY4tuO/dy8g3Heq496hxiZOBgPMUpwMCuJ8K6U
	25kqxJuSWFmVWpQfX1Sak1p8iNEU6L6JzFKiyfnAKMsriTc0MzA1NDGzNDC1NDNWEuf1LOhI
	FBJITyxJzU5NLUgtgulj4uCUamA6bLrrROk75hXF0yqf5NZv+iNd2viwIVlO7y/rl/VWrVU+
	jlqyjvpyGn02jjuSZtTciL21Y8nrwkQRTSmmn1Lr/h9jLRMzL5s4edEb8VKxjKWO/02Kszun
	i9arRFb53uUO/zVhUutCme0RLNrLf1dE/J8S38ZV2l5/Me9xg1Hkgiav9edVc7w/8QlfXZXv
	eV/d1ojvXeKqfc5f3+2afOFrq9Sre/VhE3b3ex+Z2iMQ/HDWT1N5U3G+k+k3pnnv7M2KNRUN
	OP0tvuBnS+7h1FfuEfIcN3fICgreDzF7yeOWteOeU2e+8Z83+42eHz2WU1F1889szk3cDXeO
	N2SxLradoDKDkWm3+jW2P5Vcr5RYijMSDbWYi4oTAZesJiT6AgAA
X-CMS-MailID: 20240131213600eucas1p12ecf4d6fb101425fa35e50f45a241c84
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240131213600eucas1p12ecf4d6fb101425fa35e50f45a241c84
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240131213600eucas1p12ecf4d6fb101425fa35e50f45a241c84
References: <CGME20240131213600eucas1p12ecf4d6fb101425fa35e50f45a241c84@eucas1p1.samsung.com>

Commit 196f34af2bf4 ("tty: serial: amba-pl011: Remove QDF2xxx
workarounds") removed some quirks specific to QDF2xxx SoC family.
Unfortunately it removed a bit too much code from the
pl011_console_match() function, what broke console operation on QEMU's
'virt' ARM/ARM64 machines. Restore the "pl011" related string check as it
was originally introduced in the commit 10879ae5f12e ("serial: pl011: add
console matching function").

Fixes: 196f34af2bf4 ("tty: serial: amba-pl011: Remove QDF2xxx workarounds")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/tty/serial/amba-pl011.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index c4df9cbc264b..33d559fa10a6 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2451,6 +2451,9 @@ static int pl011_console_match(struct console *co, char *name, int idx,
 	resource_size_t addr;
 	int i;
 
+	if (strcmp(name, "pl011") != 0)
+		return -ENODEV;
+
 	if (uart_parse_earlycon(options, &iotype, &addr, &options))
 		return -ENODEV;
 
-- 
2.34.1


