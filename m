Return-Path: <linux-kernel+bounces-88488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8140F86E245
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90FE21C22CDC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922BF76C92;
	Fri,  1 Mar 2024 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="vlYgx7UV"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B89E7691D;
	Fri,  1 Mar 2024 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709299833; cv=none; b=AcOG9C54yvceC2ThXkn7GgpXQ2eDZ8DqHsRVyPdhqZmftUp9hg7K9N+vv4EURkwGpi0TovjfQvfmv8lZgUcEInMx2i2l7h25nRHizzpLkEj6SE1gEyBs/TnFOILFlTxmDJVlXtP3a1bge3kBjeANNfpnE16buCo1YeTlTZiL1go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709299833; c=relaxed/simple;
	bh=kcYoxqAYK5p9gEg3hKhkq3gZ/N7v6jmqfQkKHu3bH3M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IDDF1uynwbHXA8eUaRVe6oc4YHC0kFLuvJ3GE9hNu5r1KMgGdpfwBoN4yRe6fIYRPC0YTotelEHDsMtpZSb3YWs0rbk9eyrrlWkAX67J2YhHevtnCbugT0Z15dlTwmbXQZlVzP4gJrHkl1OkJuFTpb2NRj67HM1fr6YBuNe3F8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=vlYgx7UV; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 7B2851000E1;
	Fri,  1 Mar 2024 16:30:29 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7B2851000E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1709299829;
	bh=rBT3wOKZ+ooEHrlrrc5AEUJkk3r7ZyLLb4GID+yN7po=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=vlYgx7UV7C1PQEUIWPmr5+xkXTPoJK/3Py7xU3are/le7BjuM3drc0tHBGghrevTC
	 PZy3Xn6qwFn2JrwifUWtitWgC8k7iuM2y0LVV1VRsV9wf0EHXlna02iFYE9FKqndwd
	 QjwyPOO0g5OtheXbcR7H+1D6+uvsL0OT4g2tD+n8gG4Iz/200s8g7GkSwozeuyjM9E
	 cPdmsigC8drY4XkqUehcebk2EQPE9k9yHPvuNghDqCD3ovJ2q6LMfhUuxU+dqhJjOq
	 fvqm/pJDQHTtogSvrnNaW9fXl1ZLjG77ZdLrhZ8aAcGbdFkmggtxgY9DlEP6VKQ4dT
	 e8ZIjXb22GiDA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri,  1 Mar 2024 16:30:29 +0300 (MSK)
Received: from user-A520M-DS3H.sigma.sbrf.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 1 Mar 2024 16:30:28 +0300
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
Subject: [PATCH v5 21/21] arch: arm64: dts: meson: axg: add crypto node
Date: Fri, 1 Mar 2024 16:29:36 +0300
Message-ID: <20240301132936.621238-22-avromanov@salutedevices.com>
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

This patch adds a crypto node declaration. With the
Amlogic crypto driver we can use HW implementation
of SHA1/224/256 and AES algo.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 7e5ac9db93f8..39ecb894668e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -286,6 +286,12 @@ ethmac: ethernet@ff3f0000 {
 			status = "disabled";
 		};
 
+		crypto: crypto@ff63e000 {
+			compatible = "amlogic,axg-crypto";
+			reg = <0x0 0xff63e000 0x0 0x48>;
+			interrupts = <GIC_SPI 180 IRQ_TYPE_EDGE_RISING>;
+		};
+
 		pcie_phy: phy@ff644000 {
 			compatible = "amlogic,axg-pcie-phy";
 			reg = <0x0 0xff644000 0x0 0x1c>;
-- 
2.34.1


