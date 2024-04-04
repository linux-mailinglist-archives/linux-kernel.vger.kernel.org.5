Return-Path: <linux-kernel+bounces-131395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB42898710
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5159E296053
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD31128807;
	Thu,  4 Apr 2024 12:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="cqkae22n"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7126612838A;
	Thu,  4 Apr 2024 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712232953; cv=none; b=a6oc2aLl4zeC2UC+ukqvCHzzNlBfmtTDswpIOMvxX8Y9PTD7tR9plUb+PRllCEpQuiv9j9PPt7U+NqvoE2sZZ98dWFTPELclTgsGF9tkeMHRl0uuvpnYAm0rFE1AVnQs8g7U7ORutmYyjNlPv+W3qJGv+dqJ72hjOKY6K9VQz8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712232953; c=relaxed/simple;
	bh=jaWNUV/0rYLFNLGYU8fO5mErt568OH4eL7UBJG8E3lY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lPbMJIcazE9CAdFcRlptRtPquwcRZePGXe8CU08qRiofqqx198G1nCbYix+dSuLsAoq6MOCAA6LBxYXC9YI4zguDVjgBQ7cCPnwkC7eNCDrC5XV9qSZB0z3D6JzbbRNGN+hWsIUQBqxTkRwkcGrHGkCsk+eoDbtLXWkMMn52pkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=cqkae22n; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id E7E0512000D;
	Thu,  4 Apr 2024 15:15:39 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru E7E0512000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1712232939;
	bh=ETwhhACPGuY4BnkEtYjTCpxmGzMAX5wMpPGvtWzJOJ0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=cqkae22nnOJqKTjS9Lp6VhJEf2QNNRAq4f7aVqH2buIB76IitunvIJ44Iwb6PtLsL
	 I2cUykRoAANFgj1t4Rh2xZWfpdnTMB8oLdn2vqW9krJmEmZkVEQ94zwyKMjGUvMM2T
	 lnfLlKg/rHTSY/uVsad5RK4aaS6KJevVoiOVJLKq/LOTtxXykCymr+uKd4Qwo1Rj7M
	 jtwGTstLm5e4zXJ10VZcrafOxnvOAr9xb9AMWz45xIZrSqCkKLRG6tP61svUBo0qtm
	 5j2mjXphjhEqE8bTCwzHo6BtKTTbZWmiPA754x60e7TY+uY2CuXTGXXSX68Xno0ca8
	 F2E0WCNNAez6A==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu,  4 Apr 2024 15:15:39 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 4 Apr 2024 15:15:39 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <quic_sridsn@quicinc.com>, <quic_mdalam@quicinc.com>, <ezra@easyb.ch>,
	<gch981213@gmail.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
	<sashal@kernel.org>, <gregkh@linuxfoundation.org>, <vigneshr@ti.com>
CC: <kernel@salutedevices.com>, <rockosov@gmail.com>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>, Ezra Buehler
	<ezra.buehler@husqvarnagroup.com>, <stable@vger.kernel.org>, Martin Kurbanov
	<mmkurbanov@salutedevices.com>, Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v1] mtd: spinand: Add support for 5-byte IDs
Date: Thu, 4 Apr 2024 15:15:21 +0300
Message-ID: <20240404121532.14755-1-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184579 [Apr 04 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/04 11:24:00
X-KSMG-LinksScanning: Clean, bases: 2024/04/04 11:24:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/04 07:34:00 #24651931
X-KSMG-AntiVirus-Status: Clean, skipped

From: Ezra Buehler <ezra.buehler@husqvarnagroup.com>

[ Upstream commit 34a956739d295de6010cdaafeed698ccbba87ea4 ]

E.g. ESMT chips will return an identification code with a length of 5
bytes. In order to prevent ambiguity, flash chips would actually need to
return IDs that are up to 17 or more bytes long due to JEDEC's
continuation scheme. I understand that if a manufacturer ID is located
in bank N of JEDEC's database (there are currently 16 banks), N - 1
continuation codes (7Fh) need to be added to the identification code
(comprising of manufacturer ID and device ID). However, most flash chip
manufacturers don't seem to implement this (correctly).

Cc: <stable@vger.kernel.org> # 6.6.23
Cc: <stable@vger.kernel.org> # 6.7.11
Cc: <stable@vger.kernel.org> # 6.8.2
Signed-off-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
Reviewed-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
Tested-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20240125200108.24374-2-ezra@easyb.ch
Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---

In the patch series [1] only one patch was marked with Fixes tag, that's
why the secon patch was not applied to 6.6.y, 6.7.y and 6.8y. It breaks
ESMT detection flow with logs:

[    0.770730] spi-nand spi0.0: unknown raw ID c8017f7f
[    0.772688] spi-nand: probe of spi0.0 failed with error -524

Please cherry-pick the second patch from the series to 6.6.y, 6.7.y and
6.8.y.

Links:
    [1] https://lore.kernel.org/linux-mtd/20240125200108.24374-1-ezra@easyb.ch/

---
 include/linux/mtd/spinand.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index badb4c1ac079..5c19ead60499 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -169,7 +169,7 @@
 struct spinand_op;
 struct spinand_device;
 
-#define SPINAND_MAX_ID_LEN	4
+#define SPINAND_MAX_ID_LEN	5
 /*
  * For erase, write and read operation, we got the following timings :
  * tBERS (erase) 1ms to 4ms
-- 
2.43.0


