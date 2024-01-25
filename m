Return-Path: <linux-kernel+bounces-38594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BCF83C2BD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F841F2531C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0DF48CC4;
	Thu, 25 Jan 2024 12:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="ie/Xt2ng"
Received: from mx4.securetransport.de (mx4.securetransport.de [178.254.6.145])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B844EB55;
	Thu, 25 Jan 2024 12:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.254.6.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706186866; cv=none; b=f/wjJplxDXspJivKKfH6qZ2F4c9zSPLYAdpDe8OjkW+AjL5mzfdZ+s2DIUHztNQgvRhkGDPWnUEN+t1I8n1AANLFkEnO4XVRisxBqOGOl3VpfzCRH/yyllbtUJOAW1EXx4Oaigot6VzrIFiauukJ55QBn4EP2kIB4pE30EnFgzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706186866; c=relaxed/simple;
	bh=WHNYX9+EJRxk2fkvssctu49J3vAWfzkUKsCYIZ7poJc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=daoHb/93gbf54CUttUK1XjxOqxMIFIRy1v0EGwiaF+5GdGf0tDBUD7WQQOvLTcA81w+/E/2hIOFeEF4uP4+kJ1KTlXHqSm1OJWQe0hlrjj74ww8O4btRlC8nRSgB2CPuwV60nu4olH9L9MXzdPvfercC77pkxl5j/hKb5wP4hw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com; spf=pass smtp.mailfrom=dh-electronics.com; dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b=ie/Xt2ng; arc=none smtp.client-ip=178.254.6.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
	s=dhelectronicscom; t=1706186815;
	bh=kvCjBh1lpWNwN8ASXjngcJYCu+H0FU6kjHgWOEasxvA=;
	h=From:To:CC:Subject:Date:From;
	b=ie/Xt2ngyb70Z53CBvzZ85zfFyzd1/wbYImwmeYVlbNfw3FSecAW9b+0SkautZu9x
	 FBhk4Cz0ID8Ti/pF9rXedCJ1B3Jkk2sws+SN4b6dpaOsDoCxsi31vUXQf0Cnq8iRiz
	 c93dUIpd7CvlnmePdRNymO5TCv1JpRS6HkWKoxiZQZ1l/N1BKrcbeHQ59JuLLk49wa
	 a49Iuy29Fosczk5VpDl++qcawH/Bn7fLMMKrAvq3lUoX/14Y+QURHFgstFgp4Zro3M
	 DTwSUflcZjnL0xYbsTjW5Ig4JnRj+lpx+6n3cyj4z30h0EmCwIGK6yO1Z4gAoiNtOx
	 hF2KfrGcjywKQ==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <linux-arm-kernel@lists.infradead.org>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>, Fabio Estevam
	<festevam@denx.de>, NXP Linux Team <linux-imx@nxp.com>,
	<kernel@dh-electronics.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM: dts: imx6ull-dhcom: Remove /omit-if-no-ref/ from node usdhc1-pwrseq
Date: Thu, 25 Jan 2024 13:46:21 +0100
Message-ID: <20240125124621.16011-1-cniedermaier@dh-electronics.com>
X-klartext: yes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Remove /omit-if-no-ref/ from node usdhc1-pwrseq, because if the compile
flag -@ (include symbols) is used the node will always be there. In this
case, GPIO H is not released and therefore cannot be used. Therefore,
remove this node manually from the corresponding devicetree file and
don't rely on /omit-if-no-ref/.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@denx.de>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: kernel@dh-electronics.com
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
 arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-som-cfg-sdcard.dtsi | 4 +++-
 arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-som.dtsi            | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-som-cfg-sdcard.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-som-cfg-sdcard.dtsi
index 040421f9c970..5e39f8dc1351 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-som-cfg-sdcard.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-som-cfg-sdcard.dtsi
@@ -14,10 +14,12 @@
  */
 
 /*
- * To use usdhc1 as SD card, the WiFi node must be deleted.
+ * To use usdhc1 as SD card, the WiFi node must be deleted. The associated
+ * pwrseq node is also deleted in order to ensure that GPIO H is released.
  * BT is also not available, so remove BT from the UART node.
  */
 /delete-node/ &brcmf;
+/delete-node/ &usdhc1_pwrseq;
 /delete-node/ &bluetooth;
 
 / {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-som.dtsi
index 830b5a5064f2..f914fe3818c2 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-som.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-som.dtsi
@@ -52,7 +52,7 @@
 	};
 
 	/* SoM with WiFi/BT: WiFi pin WL_REG_ON is connected to a DHCOM GPIO */
-	/omit-if-no-ref/ usdhc1_pwrseq: usdhc1-pwrseq {
+	usdhc1_pwrseq: usdhc1-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>; /* GPIO H */
 	};
-- 
2.11.0


