Return-Path: <linux-kernel+bounces-116765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5154388AD00
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 422ECBE5FE6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFC4149C6A;
	Mon, 25 Mar 2024 10:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="zC02mC/l"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D15184431;
	Mon, 25 Mar 2024 09:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711359887; cv=none; b=fExYX4enrNDGj81ELJSJ/SrxyQcwc3Fsgqow0oFXJOyJaFpCzJYW/thjpw8wr/WDinPlwvRNaHLyRBmQP8GRc8L2hjDXHihujJAMoAwGv4pk01/3p218sya0nYJilG0KvQcGfS94Ey8evYQkcJShDxLVN04ICybEd3iAFM1lJOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711359887; c=relaxed/simple;
	bh=WLANAWtK+kltLWAp09rwz3rT8nwKydISAtfzrzERU+4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IBCITTcaiRGQYR+sZcD8YL7tv35/At2NFt3SgZlESXCA+LFgFnsrvFQoFb6QLdZCw/mJ3+aV6n1Ldzux9vou0tRvb1cXrZ/Elqy48zDdBRHhZejCyWbvi/GKJ+cVwLke4rMK+MJCfT8jB54s3b6+WsUd55gwx6/syhrjkeNUTDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=zC02mC/l; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42P8DJeW003218;
	Mon, 25 Mar 2024 10:44:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=i8siADNRHhW+zwunZPKxpBLNdWU5Ljbute+iXFO1D8w=; b=zC
	02mC/lbZoceBF8CLGog3ZHWkoFQWrNX9jO5HYMO5TMgZbtevVwemn0wm/QW7byIj
	8mHDAaQUUvQz5ETcHzMGuWkODC7W6zZ78jkTt4d/re1jJokV9/TULNL+y6bfXmf8
	JxXt2KZW8d/Waf22jYr9rNuHJjdmXIl6pWZw2GgIurZvv1cfwPHyNnKHuNBibvpb
	7HQcoqn/sFxiUbNPKow0pMpdd67J50KDqd9rHX8Jk/cdZiL1DaeU1mMOFQdLOB2G
	1x1cwQLiALpYc3YsjRQlEjp5SxJ1GgYWznqspJoG8LNEF3dBNxIKQSUqynhrBQOW
	UusdAYTcEnNM4/N6txLA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3x1qa2y6f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 10:44:07 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 60F8D40044;
	Mon, 25 Mar 2024 10:43:58 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5F37C216EF8;
	Mon, 25 Mar 2024 10:42:44 +0100 (CET)
Received: from localhost (10.201.21.128) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 25 Mar
 2024 10:42:43 +0100
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
Subject: [PATCH v3 1/2] dt-bindings: net: add phy-supply property for stm32
Date: Mon, 25 Mar 2024 10:42:17 +0100
Message-ID: <20240325094218.56934-2-christophe.roullier@foss.st.com>
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

Phandle to a regulator that provides power to the PHY. This
regulator will be managed during the PHY power on/off sequence.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
index fc8c96b08d7dc..80937b28fa046 100644
--- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
@@ -82,6 +82,9 @@ properties:
       Should be phandle/offset pair. The phandle to the syscon node which
       encompases the glue register, and the offset of the control register
 
+  phy-supply:
+    description: PHY regulator
+
   st,eth-clk-sel:
     description:
       set this property in RGMII PHY when you want to select RCC clock instead of ETH_CLK125.
-- 
2.25.1


