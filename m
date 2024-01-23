Return-Path: <linux-kernel+bounces-35740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 466768395CD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76AD11C25279
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB384129A72;
	Tue, 23 Jan 2024 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="eHf5dJvk"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDAF1272CA;
	Tue, 23 Jan 2024 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706029141; cv=none; b=TlvizgkNtAhNpGr4RkB+9pCwA9oJKdzT/afKerHmJktyXlI76kFSoqc6whx+q5ZmrAcg3LBPdyN4+NVuFDScurLNKwPVduJY/S+Ka4A5OmgadF59D/YG2HA1ApRjLrTSFAflTgf3IMafl38SOI8N1eFkdUNI2S0SYgOYuHfFnG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706029141; c=relaxed/simple;
	bh=p75gyEKuZUMyzfXndu7/DaPEMCaTLTrP+tiFaL/zmyk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hqij8oYYh9hX8F4asnhThAfAeO37JFdG6QCNVB+gqA3TEiOQaqopoDz9Avicg5cAQuhMv17HQRUWRZA1ZmfruF2Zo9Z88s/wz44RQiEUsUHYczisiV3vBfXlrthseVxHSMW7VEaxcuNSGQiGKnnAqn6qu+dp6R5xoQm/tS8KWuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=eHf5dJvk; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 3308512001A;
	Tue, 23 Jan 2024 19:58:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 3308512001A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1706029137;
	bh=L0Kr6PSaW/CeJjCIRN2fyh6XpKkpUR7UXWLxlaNtQ1s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=eHf5dJvkvVr+ROzHAxgWnRxWIiLK72eUFkCHs6KdQg7Mv/KvyK2kOOGryzo6mDPAt
	 77i5JE7WwyOv7Tf2Lva7v8AQMhydzLCzQ/WwuDVeTjXdQDY6R3HGaZ6cHm90ezElun
	 hKwszxBSz3EUuAZ4v/OHlnazm361fGGdR9tKYrrX0tZtXJHBTWPWhCz85Kpq2LTQH9
	 fMrn2hcfUAE8npD9OPc/in0uteX1zCBmKO2kOnIC6bq3f1GRz2IKzVBQtYjKNl/6Zw
	 7+4lnJ2oWMz2tbPayL6Afv+wCTBms+0Ri2kS/UMjNo+LRidMNNi2S1bp/jo7gYX51G
	 IwPn/tnTlYs6Q==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 23 Jan 2024 19:58:57 +0300 (MSK)
Received: from user-A520M-DS3H.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 23 Jan 2024 19:58:56 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <clabbe@baylibre.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>
CC: <linux-crypto@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kernel@salutedevices.com>, Alexey
 Romanov <avromanov@salutedevices.com>
Subject: [PATCH v2 19/20] arch: arm64: dts: meson: g12: add crypto node
Date: Tue, 23 Jan 2024 19:58:30 +0300
Message-ID: <20240123165831.970023-20-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123165831.970023-1-avromanov@salutedevices.com>
References: <20240123165831.970023-1-avromanov@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 182874 [Jan 23 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/01/23 13:53:00 #23383939
X-KSMG-AntiVirus-Status: Clean, skipped

This patch adds a crypto node declaration for Amlogic G12-series.
With the Amlogic crypto driver we can use HW implementation
of SHA1/224/256 and AES algo.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index ff68b911b729..f6d7047a579c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -1709,6 +1709,12 @@ internal_ephy: ethernet-phy@8 {
 					};
 				};
 			};
+
+			crypto: crypto@3e000 {
+				compatible = "amlogic,g12a-crypto";
+				reg = <0x0 0x3e000 0x0 0x48>;
+				interrupts = <GIC_SPI 180 IRQ_TYPE_EDGE_RISING>;
+			};
 		};
 
 		aobus: bus@ff800000 {
-- 
2.34.1


