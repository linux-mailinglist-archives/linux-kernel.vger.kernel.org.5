Return-Path: <linux-kernel+bounces-22305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C10829C0C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C1261C220FC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04DC4B5B4;
	Wed, 10 Jan 2024 14:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="y6clYAhX"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60DD4A98B;
	Wed, 10 Jan 2024 14:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40AE96rI047178;
	Wed, 10 Jan 2024 08:09:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704895746;
	bh=Dw71wexiXFIlCZzzUKlcTTxVGHsnLGkULGEsjttqa2M=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=y6clYAhXNtUVVj7y/cWh7hSFCpO1jmIpOqwwx7GY4he8WvZ/sxWGn6Gd8Fckw5kyb
	 4y3BqSh5CuDgPyI472aVeU9po3B6K8cBlYUvoz3wQ6/oFAV1EX8cg7wFlrdesiIyO5
	 g+yE0foFgEw0wPVM98pK9wRB1XXyoW2FcsaKdkws=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40AE96Gq022970
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Jan 2024 08:09:06 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Jan 2024 08:09:06 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Jan 2024 08:09:06 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40AE96Po025484;
	Wed, 10 Jan 2024 08:09:06 -0600
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 01/16] arm64: dts: ti: Use https for urls
Date: Wed, 10 Jan 2024 08:08:48 -0600
Message-ID: <20240110140903.4090946-2-nm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110140903.4090946-1-nm@ti.com>
References: <20240110140903.4090946-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Replace the pending http:// urls with https

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso              | 2 +-
 .../boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso b/arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso
index 43a0ddc123e5..08eb2e894bbc 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso
@@ -6,7 +6,7 @@
  * AM625 SK: https://www.ti.com/tool/SK-AM62
  * AM62-LP SK: https://www.ti.com/tool/SK-AM62-LP
  *
- * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso b/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso
index 3be92c39ecba..4209d991eb6b 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso
@@ -4,7 +4,7 @@
  * Panel Link: https://www.digimax.it/en/tft-lcd/20881-RK101II01D-CT
  * AM654 LCD EVM: https://www.ti.com/tool/TMDSLCD1EVM
  *
- * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 /dts-v1/;
-- 
2.43.0


