Return-Path: <linux-kernel+bounces-88483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A64086E236
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28EC1F22887
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8CB763E3;
	Fri,  1 Mar 2024 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Vgda+SD3"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8B076038;
	Fri,  1 Mar 2024 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709299826; cv=none; b=T8VwSZ6vSuv0KgSLhqzKheD19O1kUK7AvJ3Yk/HRq+aKIq5NfoyPz52ntD0/KM967mxEO8OGzaL9Y08+bztiC6Y76z4etLMxG82XYq8rMhwn9EP9CsfZqdb25B2wKuz6Ctj0QwBuwGzxmXPPF3y1+PQIHb8POP4uEy2GkWxTKOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709299826; c=relaxed/simple;
	bh=UG7lYaB13uiTig6plxzy3A9YXa1a5ACuobr/nRru61g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g0hCTIo26nD6sz1MgRg+DiTvxq900a74g+g9x22JeR4lFKtaJiWi1VFvzrKr4cHMOY6kTNXNz6R/xcWXLfIrsqEgfnNDThIc9TW3jqOEXhvhl/wCvn+LjpcbzUdtWdEkgXkISKmxz5H7zoSZRBFYJ7Y76A97RNYI8qlvI7/72Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Vgda+SD3; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id D1EA41000E1;
	Fri,  1 Mar 2024 16:30:21 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D1EA41000E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1709299821;
	bh=IxcU9+lFaLOEdFwuOIjcikKfTHMs3QUyk1dlTIUL5nk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Vgda+SD3kvSgYFr44L2vlUmFldGUBY4Tyx/Sosa1fF8ZNJY1Q8ufeYU3kiun+Mqfe
	 giF9ynPQ6Ra3bPN257hs096tLixYoyYyD/6TMGmdVNUID8S0ozfhjUc+jNPEy5H20/
	 FMXKQwLO/czkOFWRuvAhtvvWjEbxiSEhtJB/S/UPe/lbG5oi/Q4TwL47386lKZ21Xv
	 ZO4f4Q8+rEJJZ8+e3B+D07hnWlB6wkU2EKpPpVT3QisB4I25XBUWOZfA5ybiajcPf8
	 0fG5ZIs/3lCAnuX144iSZjMTlOSrzODLYitIlqMNOuAvwe5tE8cyopyniHUa7wO9f7
	 HHzb9LLnNcc3Q==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri,  1 Mar 2024 16:30:21 +0300 (MSK)
Received: from user-A520M-DS3H.sigma.sbrf.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 1 Mar 2024 16:30:19 +0300
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
Subject: [PATCH v5 16/21] drivers: crypto: meson: add support for A1-series
Date: Fri, 1 Mar 2024 16:29:31 +0300
Message-ID: <20240301132936.621238-17-avromanov@salutedevices.com>
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

This platform data also can be used for S4 as fallback.
Tested via tcrypt module and with custom tests.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/crypto/amlogic/amlogic-gxl-core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
index 1ca91cc3fb73..20c5924853cc 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-core.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
@@ -312,6 +312,15 @@ static const struct meson_pdata meson_axg_pdata = {
 	.support_192bit_key = true,
 };
 
+static const struct meson_pdata meson_a1_pdata = {
+	.descs_reg = 0x0,
+	.status_reg = 0x8,
+	.setup_desc_cnt = 1,
+	.hasher_supported = true,
+	.reverse_keyiv = false,
+	.support_192bit_key = false,
+};
+
 static const struct of_device_id meson_crypto_of_match_table[] = {
 	{
 		.compatible = "amlogic,gxl-crypto",
@@ -325,6 +334,14 @@ static const struct of_device_id meson_crypto_of_match_table[] = {
 		.compatible = "amlogic,axg-crypto",
 		.data = &meson_axg_pdata,
 	},
+	{
+		.compatible = "amlogic,a1-crypto",
+		.data = &meson_a1_pdata,
+	},
+	{
+		.compatible = "amlogic,s4-crypto",
+		.data = &meson_a1_pdata,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, meson_crypto_of_match_table);
-- 
2.34.1


