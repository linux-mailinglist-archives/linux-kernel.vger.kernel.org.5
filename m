Return-Path: <linux-kernel+bounces-123038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C890D890158
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5850B1F262A5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2505F12EBC7;
	Thu, 28 Mar 2024 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="qYjX7mHm"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B5280630;
	Thu, 28 Mar 2024 14:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635027; cv=none; b=PQ0KoHTSrubwcEWBK5aXww5HVDaGoz6wPlAn9oAWzAobRhblmkl7VHPfJHwHZlNH/5/9hDJsgq8eb6//3czvckH0d3NnveRgyB8EaqvsDwuKf7gd2SSCCucedDY2pHt7+81e4ZCTctDf9un1ZGzqJFe5HWpwmVji0/YSGayUb9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635027; c=relaxed/simple;
	bh=ov2D7tmh8X+K6i0wYrHkTxzXFBxqNjc8etmkfZRDax8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ty9pzBczcTanj9h6NtWBWFej+ieyGTGoMlB40XiVRubKRAnavnwapqoodAiPWcXouD3CpQEgOaChKXNPhTkNkDwAK9pV0jS5IirL2vhOPQHa5IEY9MhugvhkghhamUjjRCYpchfOdDDNUahfiYkr9IeQfOzRtb5ZblM486/fMUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=qYjX7mHm; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SDpIYE007931;
	Thu, 28 Mar 2024 15:09:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=6PKNIDizNNs2v9Dt/K/rRql3tlVXcVQGNz32rcb+Tmc=; b=qY
	jX7mHmyBjN6+t71PqTsFogIgCkS8/AG0OoPzYb8NkiQKq9qCqg9ngPF3bvBbLIUz
	/P1bLsOtfP/CgwiuRf9orP3Sj3nlv0KGZCLLBmIDy0/mvHUYAUlP2fUKLQJfJ5is
	cgDmx5jpp60Gukxg9KxeRT9pYRpOrnjdj9nv5PJU1HsYomTi1goJkqa3pXZoRJxz
	f7coUHlpWe6vXFx8VgFqh9hdJrCIANOk5Y1hTMBqXz8Em4QwTx0glbckrgqBgGOA
	EjcYAPOS/abpd21XnmhqxEpICs51QRkktFF8pjxDqSicr4OrN+ZFEL+WC6ZJoO6Y
	/2palJr3WTVq6SBZcMHg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3x1pugtf6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 15:09:35 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8E79040045;
	Thu, 28 Mar 2024 15:09:23 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D227C221E9F;
	Thu, 28 Mar 2024 15:08:10 +0100 (CET)
Received: from localhost (10.201.21.128) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Mar
 2024 15:08:09 +0100
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
Subject: [PATCH v5 1/1] dt-bindings: net: dwmac: Document STM32 property st,ext-phyclk
Date: Thu, 28 Mar 2024 15:08:03 +0100
Message-ID: <20240328140803.324141-2-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240328140803.324141-1-christophe.roullier@foss.st.com>
References: <20240328140803.324141-1-christophe.roullier@foss.st.com>
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
 definitions=2024-03-28_14,2024-03-27_01,2023-05-22_02

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
index fc8c96b08d7dc..b35eae80ed6ac 100644
--- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
@@ -82,6 +82,13 @@ properties:
       Should be phandle/offset pair. The phandle to the syscon node which
       encompases the glue register, and the offset of the control register
 
+st,ext-phyclk:
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


