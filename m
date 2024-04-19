Return-Path: <linux-kernel+bounces-151666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC588AB1C9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7A71C21984
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5713D12FB28;
	Fri, 19 Apr 2024 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="GJ84Fp0r"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDB6184E;
	Fri, 19 Apr 2024 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713540561; cv=none; b=RP/aGMa6Ktlw5jx5h2VDIQ0sQnZ/arEiPNoSYaldLiNImwUVVYvzqWznfMndR40qgVhy9oFLZFv/EOnEMlOqAc0Ss2A2D7MLVUDSk3CjBLkpng9wfXGe76SVFlIUkF8LJ/goM81zGmTrDD6qVhNlON3KhsPeUobFk+5v6I25mg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713540561; c=relaxed/simple;
	bh=UmFJ/LUxs0W6ixvpBfPvFzcA/mLvLonK3DqTMSN946k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XWl+sF8zV/+YH8Tctme2VsWflxZOvmlWdYHvD/+XTI8I1RUoZdBl44Vd4EQW7Z1NRD1Yu28rVodOmGsEY7/niDzUbh7YBAa1oH7FDAf1FYY3QB3w1j9PLGfsNgA2IBPLJiKovCKCrtYrb1Nc85dRq5/0HtrAjYrrZ3tKGG9h9q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=GJ84Fp0r; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43JAiQPZ020736;
	Fri, 19 Apr 2024 17:28:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=KK3aqD/++znS+Ui0rIV0WpCC4dzzVyWWdficb7dQFvo=; b=GJ
	84Fp0rXCq+z3+owLvCvYjGe3cmMJ8XxITNktEcBb4IDfLm3s9G5eiEeuaZ292PSX
	xcZmlDzjcV5fGFy+cP+oV/4mYCBtAUsQVQ9DLwrnZCG38tApTVCgY2PeUZYsAMz8
	bgR1AH+T6odAWFyi19asvqpFFVONs5gdHEpaL5ybdsqBaFK057IGuLe0SiYKytfY
	yJBpmAb/mWFB8x8jDxv1lfmQOuhrmMxsPkNq7Br7KsMo9JYAzhgr2PXMes6dIcTS
	jeSGAMWtAX3BkCVu/RTVZfpgsiP/Yj0M+8MaSaodpKM2nCtkIaczIVphCBo3VKii
	cnjar+KQePnVLacrz6mw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xg3m132gc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 17:28:51 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 23A9E4002D;
	Fri, 19 Apr 2024 17:28:44 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E3DC722367D;
	Fri, 19 Apr 2024 17:27:53 +0200 (CEST)
Received: from localhost (10.252.27.3) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Apr
 2024 17:27:53 +0200
From: <gabriel.fernandez@foss.st.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] dt-bindings: clocks: stm32mp25: add access-controllers description
Date: Fri, 19 Apr 2024 17:27:20 +0200
Message-ID: <20240419152723.570159-2-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240419152723.570159-1-gabriel.fernandez@foss.st.com>
References: <20240419152723.570159-1-gabriel.fernandez@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_11,2024-04-19_01,2023-05-22_02

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

access-controllers is an optional property that allows to refer to
domain access controller.
The RCC driver will be able to check if we are allowed to register
clocks for a peripheral.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml b/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
index 0929fa7e271b..88e52f10d1ec 100644
--- a/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
+++ b/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
@@ -114,6 +114,10 @@ properties:
       - description: CK_SCMI_PLL3 PLL3 clock
       - description: clk_dsi_txbyte DSI byte clock
 
+  access-controllers:
+    minItems: 1
+    maxItems: 2
+
 required:
   - compatible
   - reg
-- 
2.25.1


