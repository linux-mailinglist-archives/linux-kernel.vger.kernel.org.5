Return-Path: <linux-kernel+bounces-88468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA39786E20C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A4BCB21B7D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86AA6F066;
	Fri,  1 Mar 2024 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="j+5BjEsC"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C995A6D1A7;
	Fri,  1 Mar 2024 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709299812; cv=none; b=p0eF1KDWvVrDrpNfusaA1kCgeddbccNklZdEHYw6cj+WBnVoF2DCzI0r911G0TDmJSU3MJQc1D8/AQqp1TxLih1qQu5Yr/uJGKoOhLRgSum+y/A6HRx1IRL2qWTJRUmpq4RvcksfI3uVd0LgguYyWZ5OXH+7n2aiwNm+2PX5Ufk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709299812; c=relaxed/simple;
	bh=K7UieHG9RsHgDBpcjxeQWQsIDLszF4my3Mke2V00m8I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=drFAW8sp8a9I1MTu+W7Pj5HNgV3Wj9+uX2nySPZSnsLI2Y6cB2GUcFhGpf0MjeNMQi+bv5kebPtMtUaGZzKeml8nU3jbTb5t6GUShcRp0Lo+cp0KB+hOtXll/kIRqHPr3MLy3lEUliK7DE27O2kNvFXXFWrJnGVy9lkqJQQRo7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=j+5BjEsC; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id A77D21000B1;
	Fri,  1 Mar 2024 16:30:00 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru A77D21000B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1709299800;
	bh=T4w8YmD8VWdxpwAM+qh0428tx6ubcLSqso0bV80y5tA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=j+5BjEsCpZp/8b+5UsZMBaMMwaaPZ2UHWJQSa1iI45Dn9LRQDQLGVQef+IW5EKre1
	 5O/mSU6fWp78ii79+8AitYXZ83z5141+BmbwfxNyiMGcRDILmh/FRZl3v3KU6/Ar29
	 sjcx4uALM5bKQLkYnj44geBxwo6nx07vE/eR3+Fi28dKMzOKcKl5qGL9+ZDD7J24t+
	 bo/SDAyOZXXSqFdl0S6SDok2uBCOHg1y3kF6BA0yWyX1VJhDIawP3oZXejXI8/Sxie
	 r/AiPbX0jczZgCmWoavKfS7zr3aqx2vYiZfuldGJNGc0/ebWM8GIZUjAX/xvNdziO+
	 o9CVcmhPzdvyw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri,  1 Mar 2024 16:30:00 +0300 (MSK)
Received: from user-A520M-DS3H.sigma.sbrf.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 1 Mar 2024 16:29:59 +0300
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
Subject: [PATCH v5 01/21] drivers: crypto: meson: don't hardcode IRQ count
Date: Fri, 1 Mar 2024 16:29:16 +0300
Message-ID: <20240301132936.621238-2-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301132936.621238-1-avromanov@salutedevices.com>
References: <20240301132936.621238-1-avromanov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183875 [Feb 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/29 19:21:00 #23899999
X-KSMG-AntiVirus-Status: Clean, skipped

IRQ count is no longer hardcoded, and make it part of
struct meson_flow. We need this for extend driver support for
other Amlogic SoC's.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/crypto/amlogic/amlogic-gxl-cipher.c |  2 +-
 drivers/crypto/amlogic/amlogic-gxl-core.c   | 47 ++++++++++++---------
 drivers/crypto/amlogic/amlogic-gxl.h        |  8 ++--
 3 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/drivers/crypto/amlogic/amlogic-gxl-cipher.c b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
index 29048da6f50a..b19032f92415 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-cipher.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
@@ -19,7 +19,7 @@
 
 static int get_engine_number(struct meson_dev *mc)
 {
-	return atomic_inc_return(&mc->flow) % MAXFLOW;
+	return atomic_inc_return(&mc->flow) % mc->flow_cnt;
 }
 
 static bool meson_cipher_need_fallback(struct skcipher_request *areq)
diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
index f54ab0d0b1e8..35ec64df5b3a 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-core.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
@@ -28,8 +28,8 @@ static irqreturn_t meson_irq_handler(int irq, void *data)
 	int flow;
 	u32 p;
 
-	for (flow = 0; flow < MAXFLOW; flow++) {
-		if (mc->irqs[flow] == irq) {
+	for (flow = 0; flow < mc->flow_cnt; flow++) {
+		if (mc->chanlist[flow].irq == irq) {
 			p = readl(mc->base + ((0x04 + flow) << 2));
 			if (p) {
 				writel_relaxed(0xF, mc->base + ((0x4 + flow) << 2));
@@ -110,7 +110,7 @@ static int meson_debugfs_show(struct seq_file *seq, void *v)
 	struct meson_dev *mc __maybe_unused = seq->private;
 	int i;
 
-	for (i = 0; i < MAXFLOW; i++)
+	for (i = 0; i < mc->flow_cnt; i++)
 		seq_printf(seq, "Channel %d: nreq %lu\n", i,
 #ifdef CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG
 			   mc->chanlist[i].stat_req);
@@ -153,14 +153,32 @@ static void meson_free_chanlist(struct meson_dev *mc, int i)
  */
 static int meson_allocate_chanlist(struct meson_dev *mc)
 {
+	struct platform_device *pdev = to_platform_device(mc->dev);
 	int i, err;
 
-	mc->chanlist = devm_kcalloc(mc->dev, MAXFLOW,
+	mc->flow_cnt = platform_irq_count(pdev);
+	if (mc->flow_cnt <= 0) {
+		dev_err(mc->dev, "No IRQs defined\n");
+		return -ENODEV;
+	}
+
+	mc->chanlist = devm_kcalloc(mc->dev, mc->flow_cnt,
 				    sizeof(struct meson_flow), GFP_KERNEL);
 	if (!mc->chanlist)
 		return -ENOMEM;
 
-	for (i = 0; i < MAXFLOW; i++) {
+	for (i = 0; i < mc->flow_cnt; i++) {
+		mc->chanlist[i].irq = platform_get_irq(pdev, i);
+		if (mc->chanlist[i].irq < 0)
+			return mc->chanlist[i].irq;
+
+		err = devm_request_irq(mc->dev, mc->chanlist[i].irq,
+				       meson_irq_handler, 0, "aml-crypto", mc);
+		if (err < 0) {
+			dev_err(mc->dev, "Cannot request IRQ for flow %d\n", i);
+			return err;
+		}
+
 		init_completion(&mc->chanlist[i].complete);
 
 		mc->chanlist[i].engine = crypto_engine_alloc_init(mc->dev, true);
@@ -230,7 +248,7 @@ static void meson_unregister_algs(struct meson_dev *mc)
 static int meson_crypto_probe(struct platform_device *pdev)
 {
 	struct meson_dev *mc;
-	int err, i;
+	int err;
 
 	mc = devm_kzalloc(&pdev->dev, sizeof(*mc), GFP_KERNEL);
 	if (!mc)
@@ -252,19 +270,6 @@ static int meson_crypto_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	for (i = 0; i < MAXFLOW; i++) {
-		mc->irqs[i] = platform_get_irq(pdev, i);
-		if (mc->irqs[i] < 0)
-			return mc->irqs[i];
-
-		err = devm_request_irq(&pdev->dev, mc->irqs[i], meson_irq_handler, 0,
-				       "gxl-crypto", mc);
-		if (err < 0) {
-			dev_err(mc->dev, "Cannot request IRQ for flow %d\n", i);
-			return err;
-		}
-	}
-
 	err = clk_prepare_enable(mc->busclk);
 	if (err != 0) {
 		dev_err(&pdev->dev, "Cannot prepare_enable busclk\n");
@@ -294,7 +299,7 @@ static int meson_crypto_probe(struct platform_device *pdev)
 error_alg:
 	meson_unregister_algs(mc);
 error_flow:
-	meson_free_chanlist(mc, MAXFLOW - 1);
+	meson_free_chanlist(mc, mc->flow_cnt - 1);
 	clk_disable_unprepare(mc->busclk);
 	return err;
 }
@@ -309,7 +314,7 @@ static void meson_crypto_remove(struct platform_device *pdev)
 
 	meson_unregister_algs(mc);
 
-	meson_free_chanlist(mc, MAXFLOW - 1);
+	meson_free_chanlist(mc, mc->flow_cnt - 1);
 
 	clk_disable_unprepare(mc->busclk);
 }
diff --git a/drivers/crypto/amlogic/amlogic-gxl.h b/drivers/crypto/amlogic/amlogic-gxl.h
index 1013a666c932..79177cfa8b88 100644
--- a/drivers/crypto/amlogic/amlogic-gxl.h
+++ b/drivers/crypto/amlogic/amlogic-gxl.h
@@ -22,8 +22,6 @@
 #define MESON_OPMODE_ECB 0
 #define MESON_OPMODE_CBC 1
 
-#define MAXFLOW 2
-
 #define MAXDESC 64
 
 #define DESC_LAST BIT(18)
@@ -62,6 +60,7 @@ struct meson_desc {
  * @keylen:	keylen for this flow operation
  * @complete:	completion for the current task on this flow
  * @status:	set to 1 by interrupt if task is done
+ * @irq:	IRQ number for amlogic-crypto
  * @t_phy:	Physical address of task
  * @tl:		pointer to the current ce_task for this flow
  * @stat_req:	number of request done by this flow
@@ -70,6 +69,7 @@ struct meson_flow {
 	struct crypto_engine *engine;
 	struct completion complete;
 	int status;
+	int irq;
 	unsigned int keylen;
 	dma_addr_t t_phy;
 	struct meson_desc *tl;
@@ -85,7 +85,7 @@ struct meson_flow {
  * @dev:	the platform device
  * @chanlist:	array of all flow
  * @flow:	flow to use in next request
- * @irqs:	IRQ numbers for amlogic-crypto
+ * @flow_cnt:	flow count for amlogic-crypto
  * @dbgfs_dir:	Debugfs dentry for statistic directory
  * @dbgfs_stats: Debugfs dentry for statistic counters
  */
@@ -95,7 +95,7 @@ struct meson_dev {
 	struct device *dev;
 	struct meson_flow *chanlist;
 	atomic_t flow;
-	int irqs[MAXFLOW];
+	int flow_cnt;
 #ifdef CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG
 	struct dentry *dbgfs_dir;
 #endif
-- 
2.34.1


