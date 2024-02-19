Return-Path: <linux-kernel+bounces-71443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFF385A550
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D8B284938
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158CE37143;
	Mon, 19 Feb 2024 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="PkBuWUzY"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4F5374DE;
	Mon, 19 Feb 2024 14:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708351459; cv=none; b=bg7b3WT/6w9+LEpJDHMuTt6IeiBPFU6JYRTNHOZKrNhvLGKsOlfF8hpUXG1ltuNqPkBPzbTMEYp7+52FIe0iVAsYTh7VSfb3VKMtfHAxyP+Tt5hKKJn8dnkUhC/yLxsm9bDZ3x38dOSDcH/QyYLG1RE9foUrIDFi42SzDprMZKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708351459; c=relaxed/simple;
	bh=UDNvKSYg+/SA5i8qLf0z8IBqL6wuxzfyh+tb5eFpRXg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+7bef9TYUih+47sPE+ItrEPeqEOT+DrqcAbTrsx3q4gnpax1f5EKYw40GmZy5QxbjRLic8MpdpOg5b4Pvy5R1BMiIy9VovkMAp6v5kEFTq7FjIlQCLT+KEZRkE/c3mtzEoBsVBeXboL+/nOT8UkAzzMtrIh22dOpDwB6iC9FJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=PkBuWUzY; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41JAMD80022490;
	Mon, 19 Feb 2024 15:04:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=OW57AZTUsQlp0CNOE8yjZNo7VI7deZ88cKgdLkWe72c=; b=Pk
	BuWUzYgnFW0OwxNQT3LT5+hHABWfGebe6rYGBpNcXahClRMRdccU2S4/i4LuOxB1
	sZnl2GDl51s0No4dVIkA0fLT6virjUPzu8yQ2ThYsJLESu5cPPrJyeS2q85r5CqZ
	NtaMIb1Xl+0vIjjRvrCr7dSQb7ZfX0iYVOnuFzEKtOVR5sOO8hZhs7nPNpvRHttE
	S1aR8EFbqIp1zOOE1YONRD5LdjDGa86LKKrLL9ynXHBV3LiNdCF7aRmPwTJFiMpd
	TkWJcfuHe+oU7wPtpsN8reP36ziy0YM71USmV4zKgJ2hOwcKbWD+fw7xI5UvDjlW
	UWygZaaBwUr5AEsv15qg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wak3m78fq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 15:04:06 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8DA2840045;
	Mon, 19 Feb 2024 15:03:55 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7AD1A2690DD;
	Mon, 19 Feb 2024 15:03:29 +0100 (CET)
Received: from localhost (10.201.21.177) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 19 Feb
 2024 15:03:29 +0100
From: Christophe Kerello <christophe.kerello@foss.st.com>
To: <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>,
        Christophe Kerello <christophe.kerello@foss.st.com>
Subject: [PATCH v2 1/5] dt-bindings: memory-controller: st,stm32: add MP25 support
Date: Mon, 19 Feb 2024 15:01:58 +0100
Message-ID: <20240219140202.85680-2-christophe.kerello@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240219140202.85680-1-christophe.kerello@foss.st.com>
References: <20240219140202.85680-1-christophe.kerello@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_10,2024-02-19_01,2023-05-22_02

Add a new compatible string to support MP25 SoC.

On MP1 SoC, RNB signal (NAND controller signal) and NWAIT signal (PSRAM
controller signal) have been integrated together in the SoC. That means
that the NAND controller and the PSRAM controller (if the signal is
used) can not be used at the same time. On MP25 SoC, the 2 signals can
be used outside the SoC, so there is no more restrictions.

MP1 SoC also embeds revision 1.1 of the FMC2 IP when MP25 SoC embeds
revision 2.0 of the FMC2 IP.

MP25 SoC is also using PSCI OS-initiated mode, so allow a single
'power-domains' entry for STM32 FMC2. As MP1 will move on PSCI
OS-initiated mode, add this property as optional for all FMC2 variants.

Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
---
Changes in v2:
 - V1 patch 1 and 2 have been squashed and commit message has been updated.

 .../bindings/memory-controllers/st,stm32-fmc2-ebi.yaml     | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-ebi.yaml b/Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-ebi.yaml
index 14f1833d37c9..84ac6f50a6fc 100644
--- a/Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-ebi.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-ebi.yaml
@@ -23,7 +23,9 @@ maintainers:
 
 properties:
   compatible:
-    const: st,stm32mp1-fmc2-ebi
+    enum:
+      - st,stm32mp1-fmc2-ebi
+      - st,stm32mp25-fmc2-ebi
 
   reg:
     maxItems: 1
@@ -34,6 +36,9 @@ properties:
   resets:
     maxItems: 1
 
+  power-domains:
+    maxItems: 1
+
   "#address-cells":
     const: 2
 
-- 
2.25.1


