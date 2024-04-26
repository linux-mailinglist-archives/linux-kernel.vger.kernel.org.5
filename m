Return-Path: <linux-kernel+bounces-160012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F16088B37AB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1EAE1F23020
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8864146D4A;
	Fri, 26 Apr 2024 12:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="eHmY8Eok"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887CA146A97;
	Fri, 26 Apr 2024 12:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714136392; cv=none; b=qzxcdGdi79TzYmKSGayC3tfruiiPWAOs4F9M2nr/9Q4SKhP+tPDoMZD6RsV3Kul6I8eYVAMHcdw2POoUT7+UQe4oSFaLWG93e2Yb6Xthm6c4t8cjM1nJ9ekNDFQ/gO9bffHvkzf20gyjnSnoEGsTY0XP9dHIJILZJso5MqLAnfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714136392; c=relaxed/simple;
	bh=3ZIAtIFMpk4Nj51pnwTcmPvMDgP1QrysF8hjWZJKlfE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aquH6I53GuPpqh2+JQmfy7z5Z7sYvP0IT5rX/VfsPRdncoM9/nDOI0CwCE5WPkDnUUjCGglBU3ztmKjx9z6yYUuJt9jIJKPLIrFaQ42h8FaGGnjpi4rA70y2GDaXglGrklgMlHJMJTu7CMaTvjfrOlnlYrFPQNvkyrj7rWjU/8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=eHmY8Eok; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43Q9VPgV004073;
	Fri, 26 Apr 2024 14:59:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=TDZhU94secgxkrQi4u5HTCqjPQQxqe0PmG+ofWUGEEE=; b=eH
	mY8Eok48Dt7shSYisZIEt8GudbHLLhM3jfMeTCK4YrvkLDmbD/eXwCzE0Y70Y0fe
	KKRdtoDj/t6vL2RwPRjKdI9E859aD5xq32r8Woe5lF5vq+X0HTf72OJJrHePoQZh
	ZEX8fRRcx8fAUbXga7m2ngGCyJxjNYpRUHtlSJ/PCLr0OeA+RJRywD88Ib6XR9L9
	5wuP/yGzI0ezRT2BcynxMwRvhXO9ZVarqpdbYWA+4Ajqnu/NRPliFUTGRLy7EIw2
	mlP45nTzA1RhZYuEi4rTLFFgPgcGnHpXAVv/DP0hISbaKirEukMpceUGQCwjR+El
	/7fjt2yr4nSjyLWA0w6g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm4ee9ur7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 14:59:24 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 70AD040047;
	Fri, 26 Apr 2024 14:59:18 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7A300222C9B;
	Fri, 26 Apr 2024 14:58:04 +0200 (CEST)
Received: from localhost (10.252.17.191) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 14:58:03 +0200
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
Subject: [PATCH v2 02/11] dt-bindings: net: add phy-supply property for stm32
Date: Fri, 26 Apr 2024 14:56:58 +0200
Message-ID: <20240426125707.585269-3-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240426125707.585269-1-christophe.roullier@foss.st.com>
References: <20240426125707.585269-1-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02

Phandle to a regulator that provides power to the PHY. This
regulator will be managed during the PHY power on/off sequence.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
index b901a432dfa9..7c3aa181abcb 100644
--- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
@@ -84,6 +84,9 @@ properties:
           - description: offset of the control register
           - description: field to set mask in register
 
+  phy-supply:
+    description: PHY regulator
+
   st,eth-clk-sel:
     description:
       set this property in RGMII PHY when you want to select RCC clock instead of ETH_CLK125.
-- 
2.25.1


