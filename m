Return-Path: <linux-kernel+bounces-140530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD368A15D9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33991C2209B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F4F1514F5;
	Thu, 11 Apr 2024 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="BNk87Vc6"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA0014EC67;
	Thu, 11 Apr 2024 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842741; cv=none; b=IFVlHgkaWyelz4e7j9iGWYhayOuzwdGkIOWTLuXilXDwcKaWlxDoJgE+AfQTsxnbIaW68Ke8+UW6FQqtQ56HABA62XvkAw+osfOWZ4Y8r3RRNKVLF/YozAAL9B6zNQo8ee8vnNlNijasc+RKE3a9JgQLbzlTRQHZTP3otbZen1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842741; c=relaxed/simple;
	bh=eKiX+/Kz2JJwdjMCuGv51OdF9N3/l/bTum2+ZwPcTTQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uv/fNykpPJHIW82Zadia/CWLcAhSNGfUun5uCDr56qTpeEXtslRnBRrqITeICwJjA8D0ZxDMOgdSHbHsrCNu0oBgoR4S+DFq2QBihc1LhRYFKhVZq8VDUILLUAE6bxDzWSvoKC4CY0utXb1K3zsxvbdqQuu4qMrYVUZilgoaqkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=BNk87Vc6; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 0264A100040;
	Thu, 11 Apr 2024 16:38:58 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 0264A100040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1712842738;
	bh=kbk01LZx5Gx3XlSl8eks76phYzgWifOc69jIi3h8WLs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=BNk87Vc6Z4FNEg7gMOBiN2EZVZtZvMsqZCd9n1sx3vm4vG1Xm1WvoXA2doHYvyhTS
	 C1HeOeeV/m8Lcs838MaH5h8WKv5uazFAmNyHRwCijn/MstUVF8Zk8DS2nEO8HyaqkR
	 K+ocklUq6kquIS7fL7AkKUZXk3kZTh4m6gQ5Ka92E0xZoSCxuLB+ckRQuUMaChN+Ae
	 hqd4023y7eo/S1aYVM7O9BUe5i71UyPkPQOE4aB1t8NivRx1fqw5SzeupJdD7A6ARr
	 HVrysCOAyeF2LkkJbeDSQ+JggqrrQwwULLxiCJNsDjaHpV1X1d8aLt+3LMZcfy0Bfk
	 LYFcV2bJKClHw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 11 Apr 2024 16:38:57 +0300 (MSK)
Received: from user-A520M-DS3H.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 11 Apr 2024 16:38:56 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <clabbe@baylibre.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <vadim.fedorenko@linux.dev>
CC: <linux-crypto@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kernel@salutedevices.com>, Alexey
 Romanov <avromanov@salutedevices.com>
Subject: [PATCH v7 05/23] drivers: crypto: meson: move get_engine_number()
Date: Thu, 11 Apr 2024 16:38:14 +0300
Message-ID: <20240411133832.2896463-6-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411133832.2896463-1-avromanov@salutedevices.com>
References: <20240411133832.2896463-1-avromanov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184672 [Apr 11 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 16 0.3.16 6e64c33514fcbd07e515710c86ba61de7f56194e, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/11 09:22:00 #24744908
X-KSMG-AntiVirus-Status: Clean, skipped

Move get_engine_number() function from cipher.c to core.c

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/crypto/amlogic/amlogic-gxl-cipher.c | 9 ++-------
 drivers/crypto/amlogic/amlogic-gxl-core.c   | 5 +++++
 drivers/crypto/amlogic/amlogic-gxl.h        | 2 ++
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/amlogic/amlogic-gxl-cipher.c b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
index 1fe916b0a138..18e9e2d39b1f 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-cipher.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
@@ -17,11 +17,6 @@
 #include <crypto/internal/skcipher.h>
 #include "amlogic-gxl.h"
 
-static int get_engine_number(struct meson_dev *mc)
-{
-	return atomic_inc_return(&mc->flow) % mc->flow_cnt;
-}
-
 static bool meson_cipher_need_fallback(struct skcipher_request *areq)
 {
 	struct scatterlist *src_sg = areq->src;
@@ -282,7 +277,7 @@ int meson_skdecrypt(struct skcipher_request *areq)
 	rctx->op_dir = MESON_DECRYPT;
 	if (meson_cipher_need_fallback(areq))
 		return meson_cipher_do_fallback(areq);
-	e = get_engine_number(op->mc);
+	e = meson_get_engine_number(op->mc);
 	engine = op->mc->chanlist[e].engine;
 	rctx->flow = e;
 
@@ -300,7 +295,7 @@ int meson_skencrypt(struct skcipher_request *areq)
 	rctx->op_dir = MESON_ENCRYPT;
 	if (meson_cipher_need_fallback(areq))
 		return meson_cipher_do_fallback(areq);
-	e = get_engine_number(op->mc);
+	e = meson_get_engine_number(op->mc);
 	engine = op->mc->chanlist[e].engine;
 	rctx->flow = e;
 
diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
index 0698ac5e2a6a..52317f111c6c 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-core.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
@@ -22,6 +22,11 @@
 
 #include "amlogic-gxl.h"
 
+int meson_get_engine_number(struct meson_dev *mc)
+{
+	return atomic_inc_return(&mc->flow) % mc->flow_cnt;
+}
+
 void meson_dma_start(struct meson_dev *mc, int flow)
 {
 	u32 offset = (mc->pdata->descs_reg + flow) << 2;
diff --git a/drivers/crypto/amlogic/amlogic-gxl.h b/drivers/crypto/amlogic/amlogic-gxl.h
index 8670f7ebcdda..dc54bd533a2d 100644
--- a/drivers/crypto/amlogic/amlogic-gxl.h
+++ b/drivers/crypto/amlogic/amlogic-gxl.h
@@ -161,6 +161,8 @@ struct meson_alg_template {
 #endif
 };
 
+int meson_get_engine_number(struct meson_dev *mc);
+
 void meson_dma_start(struct meson_dev *mc, int flow);
 
 int meson_enqueue(struct crypto_async_request *areq, u32 type);
-- 
2.34.1


