Return-Path: <linux-kernel+bounces-52980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7096849F18
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731241F23344
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7F250244;
	Mon,  5 Feb 2024 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="RLt+XpOr"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9FA4BAB6;
	Mon,  5 Feb 2024 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148564; cv=none; b=Hfz/iHcpvnFqkr3lVzeku4YeB8OODuA49+meqhK0TKyEtdVopPIfbWwgaxmPVq/byTts4MHC3stJZkHLWndk9wzK8dtbGqftRItgFBVoHYB1hNvMhwr002YSs3llqJ31jmvN/47J57av7t/Sl5ANIt9trrEXMaiW8uKIK8txBlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148564; c=relaxed/simple;
	bh=Xc0o3jbBAJ4zoyjIrykPdIA+JyN75J7/ftf7hDAal1A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CEAuDucMqcJyMFSj31zCIzSrTOKT/VX93/vIbpIN8IX56oVS3elB96WPc11jw8+35vHedCe78XSRG0fLKtTOJlcm+xg5p9vzcCuqNAhSrlbmCX848c/BB1DZVhIc5kYqWtYgLNBij2FwzK8CThxHkYyQClmUxGDsx4BfMYxe6MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=RLt+XpOr; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 7D9F4120019;
	Mon,  5 Feb 2024 18:55:58 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7D9F4120019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1707148558;
	bh=lnEQAu9jSHDE3/ODiSZUSC4yHnPooP6ni0dyVvfYe+M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=RLt+XpOre9NFUMeL4vT5T1IQ0zaXzzXDxya8nVlhGNFgvQrOnn6RqqJlA2nSH8Ee8
	 ScJQnsO5B44R0xg4+NX20R/m4MQ8AqYL+uh9kfrm7krs05CVesxMjP+VN3wru1pTzU
	 aLNu9P2QECn4hIO/HcQepxybPAixDG7QE++RgkcTVt9phMeMqU0G6C46SU4m7x4vuX
	 U1xKbCaXTFryUlrN20uPGkHBCp5oSGx/RrDOCWrbqf72fp6Jkj0gGtIsSiRiKHH6iX
	 639lpOA2uJ1hSMzG0bxe7+D4VZNt/SBeFWhrhZNcAemtFsKDiKEjuWZuQ0vZ+aShTs
	 h3m5DOQOSCCNQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon,  5 Feb 2024 18:55:58 +0300 (MSK)
Received: from user-A520M-DS3H.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 18:55:57 +0300
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
Subject: [PATCH v3 20/20] arch: arm64: dts: meson: axg: add crypto node
Date: Mon, 5 Feb 2024 18:55:21 +0300
Message-ID: <20240205155521.1795552-21-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205155521.1795552-1-avromanov@salutedevices.com>
References: <20240205155521.1795552-1-avromanov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183204 [Feb 05 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/05 10:19:00 #23362212
X-KSMG-AntiVirus-Status: Clean, skipped

This patch adds a crypto node declaration. With the
Amlogic crypto driver we can use HW implementation
of SHA1/224/256 and AES algo.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
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


