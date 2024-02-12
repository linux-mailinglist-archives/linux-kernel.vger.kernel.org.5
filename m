Return-Path: <linux-kernel+bounces-61766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF6E851653
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A441F263F6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD03E44C77;
	Mon, 12 Feb 2024 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="ix33G0Sc"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B913EA83;
	Mon, 12 Feb 2024 13:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745911; cv=none; b=JYOStIwjZhMWZsdsuQZNTVzu7FF0EUTIcGCZRazPNmBhEjJwsNmH9RF1PKTAVH6gBgJ6E6VreQMYzFapcVg8dhPAp/WIAw/UrPd5S/tK/4IxdhabtEoV74m3o4WLTCF49lxza2d7iMHQRUnqvZwHL/83+kxsuUR/HRpl07c58Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745911; c=relaxed/simple;
	bh=j/npYAldlvd9Qq3pg+DESbC3wWELF/8rKRlRxhrdEk4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2DgupL1utooBwrqB5lXHeCnH1O0g+HFncHl867lDOU15B3+Hd5cai3YevXZw3Rf5nfr8aXU/aT1C4jEYg2ZXprQonDUBlThQWmyB0PDztwAU+YBw5mfmV+ltrl8wO0cOSmDIRKE6k8EO9+bS3goPgu4ecs0w6NDf07HHWNOtb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=ix33G0Sc; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 1A6C9120006;
	Mon, 12 Feb 2024 16:51:47 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 1A6C9120006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1707745907;
	bh=nepK9/S3PvUYFkBSk3ayS3sP15UZveTig8m4Oij780o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=ix33G0Sc4bUmf3cMpdxGONoUOdlCN5tI1S5MHukh+aTiMdTqvTDfu28XJEKwowrAJ
	 hbpZay9ekNkMSBZxqIQjpCYJEBReJwVcja5TPm1nkSYSTZ5WJXl0xthteoZqJdpyTO
	 k6xx38Qj8F+5DFMYhsqPTDX7aJj/kk4HL0Bye2lCglZzlUrGxMeel5nJR9CHU4Dhhy
	 jzUYGpU+WhHzbUWIX1kLFYxO/TtQiAGLd961Uz0aN2rfds/nx/MjmuJKc3LCJuiIN1
	 kg/37gvIiMts4xETfSVTaOnCkkMsmMtfWb70kgX8vnJB2UrAE6NZG781mBQuvU8AGx
	 XSF0Qk/l+UT/Q==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 12 Feb 2024 16:51:46 +0300 (MSK)
Received: from user-A520M-DS3H.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 12 Feb 2024 16:51:46 +0300
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
Subject: [PATCH v4 15/20] drivers: crypto: meson: add support for AXG-series
Date: Mon, 12 Feb 2024 16:51:03 +0300
Message-ID: <20240212135108.549755-16-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212135108.549755-1-avromanov@salutedevices.com>
References: <20240212135108.549755-1-avromanov@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 183368 [Feb 12 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;100.64.160.123:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/12 07:49:00 #23556813
X-KSMG-AntiVirus-Status: Clean, skipped

Tested via tcrypt module and with custom tests.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/crypto/amlogic/amlogic-gxl-core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
index 2ffe5994b353..536ad438f713 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-core.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
@@ -226,6 +226,14 @@ static const struct meson_pdata meson_g12a_pdata = {
 	.support_192bit_key = false,
 };
 
+static const struct meson_pdata meson_axg_pdata = {
+	.descs_reg = 0x0,
+	.status_reg = 0x8,
+	.need_clk = false,
+	.setup_desc_cnt = 3,
+	.support_192bit_key = true,
+};
+
 static const struct of_device_id meson_crypto_of_match_table[] = {
 	{
 		.compatible = "amlogic,gxl-crypto",
@@ -243,6 +251,10 @@ static const struct of_device_id meson_crypto_of_match_table[] = {
 		.compatible = "amlogic,s4-crypto",
 		.data = &meson_g12a_pdata,
 	},
+	{
+		.compatible = "amlogic,axg-crypto",
+		.data = &meson_axg_pdata,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, meson_crypto_of_match_table);
-- 
2.34.1


