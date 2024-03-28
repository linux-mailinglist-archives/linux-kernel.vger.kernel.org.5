Return-Path: <linux-kernel+bounces-123443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6DE8908BA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF521C2873C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117EE137C44;
	Thu, 28 Mar 2024 18:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="1U5LUssV"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC3E137759;
	Thu, 28 Mar 2024 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711652129; cv=none; b=gV/oEU3dJ2ykNpJfgxqp+PzF1AujdGF10Bq8og1Uuw8rQoJLbnJ15gPyKRSoqA66JjO/vkmpeinSN1gsZrk5P66qEBUY11TGJPagyKZuMCl2g78uNJ5FcQhAUdWe3F43lYdvjpUpUZ9A7Nj6SJmCAigt1lUVWzz91QsbEhik/6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711652129; c=relaxed/simple;
	bh=NayzaHMIdkqA2GQKmhidauAzYN535DNAcYvmEvRbSGU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jLvid5iTJmxT1AHd9EQgA5yYH81RwhT7d6ESPx7mnKX/P5s6BtmbC6zE73jSKjc7tInbB/T7SI/aX2VR8FhzX/DjxJwisphaFK7AiGXrQ9YT5ArDwRr9oHgMb7kc49UkvX10jT1eQVGTUfpxqTNhw5uB4qAWkHJJPWY35Ox72pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=1U5LUssV; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SDVYLU018955;
	Thu, 28 Mar 2024 19:55:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=/ayeJsyEPgg8rhZQtvTpIeeccnD5/K0UyzBzpWjer9Y=; b=1U
	5LUssVvBm7XiRB7M429ok1g/vrFLx8CCKUDhHXv1gpsZ48PwsR9+5zYp4NiiuFMR
	+w8GT/9ics2YvzR0Y2/lorRagOF/gJRwNfB0jV4jAgDX16tIjjlGETcINAPzVjPW
	2skxQYWB+zrU0mxbZSHBVnPDs8lTyU8yUHZCih2rzsgqbvIe9vbdErVqeQMux/ta
	xkJVPXkYMxWENiqa5ivdaFwpT6FkUdtJnOyKxzcwRJ4XeBqOwE7uOaGhODX5ezWK
	h3AoGIituoJj5N0qHNgheWNuhJdo6aJ154Ugn1GnPz222vLB+EdBHPftxRNMqssF
	WoleT5yGIFL8OGo6a5qg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3x1ncmc6yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 19:55:03 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 72C1F4002D;
	Thu, 28 Mar 2024 19:54:58 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EADDA22D174;
	Thu, 28 Mar 2024 19:53:44 +0100 (CET)
Received: from localhost (10.252.8.203) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Mar
 2024 19:53:44 +0100
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
Subject: [PATCH v6 1/1] dt-bindings: net: dwmac: Document STM32 property st,ext-phyclk
Date: Thu, 28 Mar 2024 19:53:37 +0100
Message-ID: <20240328185337.332703-2-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240328185337.332703-1-christophe.roullier@foss.st.com>
References: <20240328185337.332703-1-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_17,2024-03-28_01,2023-05-22_02

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
Reviewed-by: Marek Vasut <marex@denx.de>
Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
index fc8c96b08d7dc..857d58949b029 100644
--- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
@@ -82,6 +82,13 @@ properties:
       Should be phandle/offset pair. The phandle to the syscon node which
       encompases the glue register, and the offset of the control register
 
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


