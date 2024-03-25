Return-Path: <linux-kernel+bounces-116766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DAB88AFB4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEA67B3396A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCBD17C1A2;
	Mon, 25 Mar 2024 10:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="wWRh8sbX"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DAF184418;
	Mon, 25 Mar 2024 09:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711359887; cv=none; b=c3odYcjSX00BI1p94uxcXmo548tLpvwy9wmHVXI1sY3KRT5K8JxBNIhCPDJErD4Y7QIRMtJqfqpgWjbt1JC9DikWEBoQ7XXKhI/GDwmKKNdoGVDcwJudnZPD9vph3Hy3BhfUSwzaQLY4bmITcKO3Y8Wx/HO41PSkI6jTrz6xDEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711359887; c=relaxed/simple;
	bh=dVAYdGBq2nlf8m9m7k04u7V6y/IdKZueMG04GsJ80TI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K6l9APm3Jnl6XmZb2dq/g+6Zdmo9vuglp0gjZQAreljqKk8h18Pv7StlV9iLyjg1SbZ6dkjp7n2n6WBBMoke7XkewSeUVJx5LIkW0XghqW5xSxQspR7lgm6LdhszOFetEZcB+HzyPaQdO0fuLDqYpFyjCd+lug5Z7tz2o7mrNvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=wWRh8sbX; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42P8fHpK027449;
	Mon, 25 Mar 2024 10:44:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=TumpbS5vUWGOFAnUTrFiTwigoWxOBILory3Y1hvCVq0=; b=wW
	Rh8sbXOSa0HCm1qDw2GTdinczGE4iRNoMKzZ7d+eb5UHjHsJiN0qP3Fr/Xvk53Iz
	J+wNsoVqGlJYXOJz7xjFeEjIAxCLMac/W5bzILa06kMAzLXmbCI6ULLXkNOG14TE
	owDV+JjBKXjFxbj06eSZgJ01Pco8aFl8ESMtwmKfEcwqMYto19eY7vlMUfdaPixj
	zwgosJVIMzgCbGeBt5aQ8ZbhVzMiKMaaTvLUAcsuUSaUVrGiaDFua2GLwyoyFg1i
	ATP2pzEQGPqaqX5OongDIvdKSsYYrkgQYbiZAvJ0IQioenTg4gAJo0aE4qB3bHKQ
	Dbjj1sRZMBV3mg6hdrcA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3x29h5mfw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 10:44:07 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6089F4002D;
	Mon, 25 Mar 2024 10:43:58 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 94129216EF9;
	Mon, 25 Mar 2024 10:42:44 +0100 (CET)
Received: from localhost (10.201.21.128) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 25 Mar
 2024 10:42:44 +0100
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
Subject: [PATCH v3 2/2] dt-bindings: net: dwmac: Document STM32 property st,ext-phyclk
Date: Mon, 25 Mar 2024 10:42:18 +0100
Message-ID: <20240325094218.56934-3-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240325094218.56934-1-christophe.roullier@foss.st.com>
References: <20240325094218.56934-1-christophe.roullier@foss.st.com>
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
 definitions=2024-03-25_07,2024-03-21_02,2023-05-22_02

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

Linux kernel commit
1bb694e20839 ("net: ethernet: stmmac: simplify phy modes management for stm32")
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


