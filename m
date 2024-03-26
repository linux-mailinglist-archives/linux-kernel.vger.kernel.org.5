Return-Path: <linux-kernel+bounces-119326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC3488C71A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BC461C63EEA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E99013CC75;
	Tue, 26 Mar 2024 15:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="AIRsmf8r"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9651213CA89;
	Tue, 26 Mar 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467167; cv=none; b=lE5M3UZm0u3tUwzP/CIKyO64aeDh5hWiIVf5dpogJ9qGxLaGTuBc/JWbZRMTm2qTglQcbGER/tDsCAn2BjbCO6aa9zwHyxaPTmuTNZCGL7v/ItLJ9ZHz3bdSjF3WemBn5lQo/wRt8aAbWyi+AD0Ny9Au8lNx5Bx/4Tv7jnIGzzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467167; c=relaxed/simple;
	bh=5nLH5t7ySGq5EY/n7ikVY0jUSS636Sdsw76fKnUEKQk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eI8By0Xtts2fYcIwcHhlKqAmnu989Z56wL8BfSSwBN+YXmQVjEpoisLTfj0gsEpCwGfvstApTw2yA7inqkjU/Dp2t2d+5BAtaacC04/xgffbStQtDyaGJ7/76toFOcpPibw+kCA1H4UHdcBcG5x57Rne9E0w1UD7CsQnuWaKq1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=AIRsmf8r; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id C9F0810000E;
	Tue, 26 Mar 2024 18:32:37 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C9F0810000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711467157;
	bh=HfV9iF0dvGOWT3RLcCjTwSmOj3751yeXQaYbGDhTmqU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=AIRsmf8rHuGQAeBBEuFbU22K0pHlpzEwHrFi2zxs7nUtFFiCXRi+KP7PVeB9AVprr
	 zkBhXxE8L22OoDs5oOsyQFsTZbSbc5itkT0NgVb7kfpV7Vz75LZ0UEN2GBEQohWZxG
	 VwTqpikENm01qbL5kIj8g07lklsk4/ttRlqU2kUCqrzVTqvWw6c0ZhYyWvK9mrh8CE
	 OBs8vqZxU12af/pQrLQPZ4RE5tagY7mNu+YYl6CbnEOXgsETsNqbkkLSZfT4/SJsxo
	 vVwPnFbv6NS4gF1gHd3NtahSiAQoLH+fAs3SKgR8ewQtMjoWYI61tbBLM//8MotFKw
	 omh6yOBW6f4jg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 26 Mar 2024 18:32:37 +0300 (MSK)
Received: from user-A520M-DS3H.sigma.sbrf.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 26 Mar 2024 18:32:36 +0300
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
Subject: [PATCH v6 03/23] drivers: crypto: meson: remove clock input
Date: Tue, 26 Mar 2024 18:31:59 +0300
Message-ID: <20240326153219.2915080-4-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326153219.2915080-1-avromanov@salutedevices.com>
References: <20240326153219.2915080-1-avromanov@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 184425 [Mar 26 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 12 0.3.12 d1a01b14eb3fc102c904d35fe6c2622ed2d1c16e, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/26 13:11:00 #24452135
X-KSMG-AntiVirus-Status: Clean, skipped

Amlogic crypto IP, which uses DMA crypto engine,
doesn't take a clock input.

Fixes: 48fe583fe541 ("crypto: amlogic - Add crypto accelerator for amlogic GXL")
Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/crypto/amlogic/amlogic-gxl-core.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
index e9e733ed98e0..9d92115043c3 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-core.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
@@ -9,7 +9,6 @@
 
 #include <crypto/engine.h>
 #include <crypto/internal/skcipher.h>
-#include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
@@ -269,18 +268,6 @@ static int meson_crypto_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Cannot request MMIO err=%d\n", err);
 		return err;
 	}
-	mc->busclk = devm_clk_get(&pdev->dev, "blkmv");
-	if (IS_ERR(mc->busclk)) {
-		err = PTR_ERR(mc->busclk);
-		dev_err(&pdev->dev, "Cannot get core clock err=%d\n", err);
-		return err;
-	}
-
-	err = clk_prepare_enable(mc->busclk);
-	if (err != 0) {
-		dev_err(&pdev->dev, "Cannot prepare_enable busclk\n");
-		return err;
-	}
 
 	err = meson_allocate_chanlist(mc);
 	if (err)
@@ -306,7 +293,6 @@ static int meson_crypto_probe(struct platform_device *pdev)
 	meson_unregister_algs(mc);
 error_flow:
 	meson_free_chanlist(mc, mc->flow_cnt - 1);
-	clk_disable_unprepare(mc->busclk);
 	return err;
 }
 
@@ -321,8 +307,6 @@ static void meson_crypto_remove(struct platform_device *pdev)
 	meson_unregister_algs(mc);
 
 	meson_free_chanlist(mc, mc->flow_cnt - 1);
-
-	clk_disable_unprepare(mc->busclk);
 }
 
 static const struct meson_pdata meson_gxl_pdata = {
-- 
2.34.1


