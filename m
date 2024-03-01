Return-Path: <linux-kernel+bounces-88481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831D286E22E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B30EB1C21EA1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BCA74E10;
	Fri,  1 Mar 2024 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="XEq+2ADG"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F06F73F20;
	Fri,  1 Mar 2024 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709299822; cv=none; b=Tme+Db6OBy4wg+R9v08i0uf3CQjKUz2eyAnuk/Tay4MkrJsB9vNeF/i/XUBrb7cICHoz6hRwbtGxd5PlS5CoX+vpVTDWUn7gKqSlJkd+Sm3b2wFFurUqnzTkxA//hj7vxM27PdTJH1QSWdDScYOgnEHFCXkhW2IQljzgWeWsyek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709299822; c=relaxed/simple;
	bh=37Hb6ALNxTr0ukvkKamZqmm3ACBeqtqtVxiUDD1+st0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jaN4VDVYK2yeIo+rS094KpwtmOubIO8uvEXXsO2jnrrCopKrhX3nNkwd+m+PDlyBYf/o2BizZuZ5M8v4964CvHFaf334jaijdMGxV0MdbFK52TnQbPALDE/xi6ItcpEIfckrT09O3fKwjclSmROCckG/xIuGPRPrl9u3/Nrw6F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=XEq+2ADG; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 906D01200EB;
	Fri,  1 Mar 2024 16:30:18 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 906D01200EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1709299818;
	bh=APamHELDD1qLAq08AC8iEKQi/FphbL6Q8v5Mtq6PrXE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=XEq+2ADGMEZho+wbBaYIyYikfD24mBSBlfXJCmgqBIydHyW5unjxbBnsJ9/qHKHHg
	 dc9wzjjd6Hjjw8yDQiT+xK49PWBgzI2y8nE80pOoaZjXhwh6jkLijQ5ZnVAXUFJ4Le
	 bEQzFannow4sRHYk5VHgHCKxJ42XBm+3FmTDbo60wy4BnI2+gUaczoIqWiBBe8CtkC
	 284izdUlY8XuBmtn71lLTAMrdtuGKHep28N8gsKNK3Sgvwze1UllFKsWU8V0dXKbvK
	 ONi81ode28V1MeaUW2b0Slo010eNjVDyQMEPsC60rM5nMsrdttNcJqH0nk0nvVZKtm
	 COKsxEGMqVD4w==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri,  1 Mar 2024 16:30:18 +0300 (MSK)
Received: from user-A520M-DS3H.sigma.sbrf.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 1 Mar 2024 16:30:18 +0300
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
Subject: [PATCH v5 14/21] drivers: crypto: meson: add support for G12-series
Date: Fri, 1 Mar 2024 16:29:29 +0300
Message-ID: <20240301132936.621238-15-avromanov@salutedevices.com>
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

Tested via tcrypt module and with custom tests.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/crypto/amlogic/amlogic-gxl-core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
index e841ce25de67..a72a76e28c17 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-core.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
@@ -294,11 +294,24 @@ static const struct meson_pdata meson_gxl_pdata = {
 	.support_192bit_key = true,
 };
 
+static const struct meson_pdata meson_g12a_pdata = {
+	.descs_reg = 0x0,
+	.status_reg = 0x8,
+	.setup_desc_cnt = 1,
+	.hasher_supported = true,
+	.reverse_keyiv = true,
+	.support_192bit_key = false,
+};
+
 static const struct of_device_id meson_crypto_of_match_table[] = {
 	{
 		.compatible = "amlogic,gxl-crypto",
 		.data = &meson_gxl_pdata,
 	},
+	{
+		.compatible = "amlogic,g12a-crypto",
+		.data = &meson_g12a_pdata,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, meson_crypto_of_match_table);
-- 
2.34.1


