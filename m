Return-Path: <linux-kernel+bounces-119029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 258CC88C2E5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90FDF1F6679F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403FA71B40;
	Tue, 26 Mar 2024 13:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="H86dfRXp"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5D76FE26;
	Tue, 26 Mar 2024 13:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458149; cv=none; b=ReuJbXRDqdlyKCL5wY7nrVCCjqgzHeaJPcONi/kKM0wN3+4hweK2sUYw29pxvr5x98FH9Rw4P9kNfsRNkhi8Di+bAgYdIPQ77gogn7t6FW82OVT4Q80+qGH/KTleI7goHS569mLpi4TmedaZjDvZvgsfKtEUOFflkSCiOp4DGoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458149; c=relaxed/simple;
	bh=eNyG2SQ69HyaYFsda24myvfLARA/R7XISr9MP1yNOjs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PO0a0J7dZXFjmaJl8kPx4YzZT3V1RDSMnSJywoyVKbiMevT5EoaApHPvQUbnHWc9d7V8UgPshPIqrE5/FL6jS4kGVx4LkqQfChW9dPMOERd30Un41VmYQ2rs1VqbihPd5ax298QrqVN7BhHCb0iZFFQsOP1XMCGGWAFNgKw3PjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=H86dfRXp; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42Q9FH4S009970;
	Tue, 26 Mar 2024 14:01:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=QloCXwv
	iKDQy08mLenO0tS2XCKRzTagg1MEsZ0Mf8XA=; b=H86dfRXpBT8MM9lxQbwMshD
	XLhWXJq2AGMR8Dz1uSEJAJbKvxy5nUClfKUDL57PePil2AckF37ufhmrRkmTyLe6
	XVu8xjaY+BVyZzmEMPA4aUxw0BCAo3Vo0pB1h/EvzOROiVkq9MBI84bCUm/643uC
	e9SHQJrCzqNAoVjKrBuJMyOFVMTaP+DlOMMN3gMcMTIk3fJTyXKeZirEThPjIe9p
	KH4WlTpjU9Vr3JLfVxPy8IV0v7zeETXsr9eo2A7I8ezTuTnKykEU8h3q5x7+f+2N
	Kpsi3ar4ifVe8IVzuaooC2UwJDYj20IYkRgWzRfZSgqi4f5Diy98/v3dkiHBojQ=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3x2awpasx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 14:01:58 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AA6D14002D;
	Tue, 26 Mar 2024 14:01:55 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 057C221863B;
	Tue, 26 Mar 2024 14:00:42 +0100 (CET)
Received: from localhost (10.201.21.128) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Mar
 2024 14:00:39 +0100
From: Christophe Roullier <christophe.roullier@foss.st.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark
 Brown <broonie@kernel.org>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>,
        Marek Vasut <marex@denx.de>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/2] dt-bindings: net: dwmac: Document STM32 property st,ext-phyclk
Date: Tue, 26 Mar 2024 14:00:17 +0100
Message-ID: <20240326130017.226875-3-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_06,2024-03-21_02,2023-05-22_02

The Linux kernel dwmac-stm32 driver currently supports three DT
properties used to configure whether PHY clock are generated by
the MAC or supplied to the MAC from the PHY.

Originally there were two properties, st,eth-clk-sel and
st,eth-ref-clk-sel, each used to configure MAC clocking in
different bus mode and for different MAC clock frequency.
Since it is possible to determine the MAC 'eth-ck' clock
frequency from the clock subsystem and PHY bus mode from
the 'phy-mode' property, two disparate DT properties are
no longer required to configure MAC clocking.

Linux kernel commit 1bb694e20839 ("net: ethernet: stmmac: simplify phy modes management for stm32")
introduced a third, unified, property st,ext-phyclk. This property
covers both use cases of st,eth-clk-sel and st,eth-ref-clk-sel DT
properties, as well as a new use case for 25 MHz clock generated
by the MAC.

The third property st,ext-phyclk is so far undocumented,
document it.

Below table summarizes the clock requirement and clock sources for
supported PHY interface modes.
 __________________________________________________________________________
|PHY_MODE | Normal | PHY wo crystal|   PHY wo crystal   |No 125Mhz from PHY|
|         |        |      25MHz    |        50MHz       |                  |

---------------------------------------------------------------------------
|  MII    |    -   |     eth-ck    |        n/a         |       n/a        |
|         |        | st,ext-phyclk |                    |                  |

---------------------------------------------------------------------------
|  GMII   |    -   |     eth-ck    |        n/a         |       n/a        |
|         |        | st,ext-phyclk |                    |                  |

---------------------------------------------------------------------------
| RGMII   |    -   |     eth-ck    |        n/a         |      eth-ck      |
|         |        | st,ext-phyclk |                    | st,eth-clk-sel or|
|         |        |               |                    | st,ext-phyclk    |

---------------------------------------------------------------------------
| RMII    |    -   |     eth-ck    |      eth-ck        |       n/a        |
|         |        | st,ext-phyclk | st,eth-ref-clk-sel |                  |
|         |        |               | or st,ext-phyclk   |                  |

---------------------------------------------------------------------------

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
index 80937b28fa046..529665d4fc911 100644
--- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
@@ -85,6 +85,13 @@ properties:
   phy-supply:
     description: PHY regulator
 
+  st,ext-phyclk:
+    description:
+      set this property in RMII mode when you have PHY without crystal 50MHz and want to
+      select RCC clock instead of ETH_REF_CLK. OR in RGMII mode when you want to select
+      RCC clock instead of ETH_CLK125.
+    type: boolean
+
   st,eth-clk-sel:
     description:
       set this property in RGMII PHY when you want to select RCC clock instead of ETH_CLK125.
-- 
2.25.1


