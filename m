Return-Path: <linux-kernel+bounces-95680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A543C875138
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36557B267FD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965B712F37F;
	Thu,  7 Mar 2024 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="AHrVBjk8"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4890912EBFC;
	Thu,  7 Mar 2024 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709820183; cv=none; b=KqeyhOtR+XtfTesgZaZ/vZdJ1VQUDar3pJAPKQZiseGY+g95NNmRlGFdFY1FPEl/2eBsCDHy4vAQkqw4KY0b5oSBBI1FChdAjZ5MrcAnqBT1Sjsj8JwcKzHoO8qxo8PH9UadzHVaotJtV92IK8e5n5t42+adwCsJi6QoKv11WeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709820183; c=relaxed/simple;
	bh=86pJV1of4eM2VTTxab9EqQyEzctfxjuUT6v9b5ZaRR4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RVksOPDDDYyzy3mZoAXN8S2Kx99AvOpK9ZuvJt9dUgZjx8EkUoPlGZkn2486rFM5qAMks3uIfV+3R5It40yAhyLiU8cYH0O4/OV0YugB4Tzv3e+a0Sz4OmI1O294aXEGYIPvj6isoFFPXxWKG7mWouPrfIB02PgS+r+Q+e3UFx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=AHrVBjk8; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 427A9dg7015304;
	Thu, 7 Mar 2024 15:02:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=sMzsSSzo2PkJfpYCCdg9znEVD7Q6RBjU2TnjYoyuVdM=; b=AH
	rVBjk8rM7YTS+jgI8EJcNLY95q+DL53Va4M/AfVEGPrcZgliQNbbgZeEiPfJOXnx
	QFbqvJTlwvX93fGOqh+ewdbpxFcM2ZBujetMGbMu+sL+2QIBzZIwBGmlvj9LzDmg
	yqulRMWT1xPJjfTuDk4BVlMesNMGjPS8s1NTDesf0CCTwI69/35F5tUwiJWhTeTK
	VBRRaqKHfSBfmXKphmk5oGRqeHAa3l9PfA4kyYiT5eS3i5dyLZZ4KqfXqTHFYQv/
	zQmAofOSlyIcoRGfPu4i3pyblcs/7BnxnHxjbZaWX5pESoB32XU5tWhd2tYnISh+
	vkkVI3mDGEHfmyMr8a7g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wmej5dxs5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 15:02:24 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7CADC40046;
	Thu,  7 Mar 2024 15:02:21 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CBE4F27D0FF;
	Thu,  7 Mar 2024 15:01:11 +0100 (CET)
Received: from localhost (10.201.21.128) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Mar
 2024 15:01:10 +0100
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
	<christophe.roullier@foss.st.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] dt-bindings: net: add new property st,ext-phyclk in documentation for stm32
Date: Thu, 7 Mar 2024 14:59:57 +0100
Message-ID: <20240307135957.303481-3-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240307135957.303481-1-christophe.roullier@foss.st.com>
References: <20240307135957.303481-1-christophe.roullier@foss.st.com>
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
 definitions=2024-03-07_08,2024-03-06_01,2023-05-22_02

Add property st,ext-phyclk to manage cases when PHY have no cristal/quartz
This property can be used with RMII phy without cristal 50Mhz and when we
want to select RCC clock instead of ETH_REF_CLK
Can be used also with RGMII phy with no cristal and we select RCC clock
instead of ETH_CLK125

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


