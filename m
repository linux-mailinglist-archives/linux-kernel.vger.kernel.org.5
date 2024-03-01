Return-Path: <linux-kernel+bounces-88470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8560786E20D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B88C1C233DE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4186F074;
	Fri,  1 Mar 2024 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="dVecjbKn"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785656D1D8;
	Fri,  1 Mar 2024 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709299813; cv=none; b=j5KH8UcGLZP6CM8ULBHVuEWR2DfOUlH6oQ2KXtvofPpGNF5RiY4P7Bbl3L2Ec3KwoGcMDcjiJbHo1G2HRYTGy+FveNiix9JQ4ilK3V2Va+G0bJjWYldevJgA6tMyxejbgGFFE6LteMda/1NYY0IqcCIaEkFfjtlgEeAxoyQuLkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709299813; c=relaxed/simple;
	bh=oLt2CrfXHGFhPY13rPuRntRoEazDjs+djTBWDS823IE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZRjhiSlUMZcPWtLu0dQnvdR73ZxXnTyYJVbphg/pJK4Y7qn7o87dO+T6FDjwpB5cMvOsnzXDqpqjb2RNX4Ti5tuoD6IJr7hApDVGQEszflTwfAJE4Joy8K1zprPwpYcBqRc7zfSlgAUyY36sBYZs4H90w2FPRf4eUINqKzvqtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=dVecjbKn; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 9609F1000E0;
	Fri,  1 Mar 2024 16:30:04 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9609F1000E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1709299804;
	bh=av4IOd2YUJAYKO3Jponq5Bllw9nK4sneiyc0GQaRres=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=dVecjbKnXBnrJ+DXoKNe9Er+vDRWRrwvTnK/G+KrECap2rbCHhY0asdIvvkd48H76
	 2HFwOCWcVf10fljfd1hRJpdYbYBzlDrfFspF04dH5/sb45Z0me+qBG3YQu3DoSbY+K
	 SJUfEHkns6xE6OLsYlbhKjJJne5hZX9FwP7YdNU9mksCWHQsuNosBaldjnuyhL/04e
	 NGRNtSIruaGHtMWsDfEfHRBmL/L2zULT9htzT+2onwsLmspmEm8XlTl3pt401izgKR
	 bl2/wvlklraNnCG423hKZyNoLH9PYKfVGP0GkdzG4VUEKxoZZCJCiBz5KHMq/XqXJ7
	 /ONrq0sFcsqJg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri,  1 Mar 2024 16:30:04 +0300 (MSK)
Received: from user-A520M-DS3H.sigma.sbrf.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 1 Mar 2024 16:30:03 +0300
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
Subject: [PATCH v5 03/21] drivers: crypto: meson: make CLK controller optional
Date: Fri, 1 Mar 2024 16:29:18 +0300
Message-ID: <20240301132936.621238-4-avromanov@salutedevices.com>
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

Amlogic crypto IP doesn't take a clock input on some
SoCs: AXG / A1 / S4 / G12. So make it optional.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/crypto/amlogic/amlogic-gxl-core.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
index e9e733ed98e0..a3a69a59f476 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-core.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
@@ -269,16 +269,11 @@ static int meson_crypto_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Cannot request MMIO err=%d\n", err);
 		return err;
 	}
-	mc->busclk = devm_clk_get(&pdev->dev, "blkmv");
+
+	mc->busclk = devm_clk_get_optional_enabled(&pdev->dev, "blkmv");
 	if (IS_ERR(mc->busclk)) {
 		err = PTR_ERR(mc->busclk);
-		dev_err(&pdev->dev, "Cannot get core clock err=%d\n", err);
-		return err;
-	}
-
-	err = clk_prepare_enable(mc->busclk);
-	if (err != 0) {
-		dev_err(&pdev->dev, "Cannot prepare_enable busclk\n");
+		dev_err(&pdev->dev, "Cannot get and enable core clock err=%d\n", err);
 		return err;
 	}
 
@@ -306,7 +301,6 @@ static int meson_crypto_probe(struct platform_device *pdev)
 	meson_unregister_algs(mc);
 error_flow:
 	meson_free_chanlist(mc, mc->flow_cnt - 1);
-	clk_disable_unprepare(mc->busclk);
 	return err;
 }
 
@@ -321,8 +315,6 @@ static void meson_crypto_remove(struct platform_device *pdev)
 	meson_unregister_algs(mc);
 
 	meson_free_chanlist(mc, mc->flow_cnt - 1);
-
-	clk_disable_unprepare(mc->busclk);
 }
 
 static const struct meson_pdata meson_gxl_pdata = {
-- 
2.34.1


