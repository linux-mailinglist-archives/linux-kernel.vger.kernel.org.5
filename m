Return-Path: <linux-kernel+bounces-158150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB858B1C32
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69B91F24477
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5816C74425;
	Thu, 25 Apr 2024 07:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="4onwIYwL"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310536EB52;
	Thu, 25 Apr 2024 07:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714031391; cv=none; b=p8NIbcBoR1XwUJXHhhc526CROsx59CznCQQRtkQd1xEbuEDAg26hrsMOdusHxm+8gmlth9Wsb9oaDjewTFgGGby8hi23lWlJiGElhZgsEf9zQdiayaw7nyPjPbKqRuMzcvMYjqM8tT4qcHt6qYD0kZdOvy9HPO38dkZ5jkBRkp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714031391; c=relaxed/simple;
	bh=3G0UGH5MCIsAPQZoDI5vLfJ9Kqk7xgISTfVtP0OmbzM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AXM5Eec8dlO3O+SiwnL40m/5ERlLeWcooDFhlbvnvkPUM8OQcU+R7zyzx+Iy6mwCBZGCU+77cnpPqt1/lmNA26CiORQST7XgL3hFQGYxflD6G8/bOrvtdVmgHL2Hd7whJ1q+mEwVI7N5mOxM/xPXcKAY+BTLuBJzC9kYfBqp8NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=4onwIYwL; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P72VrZ032344;
	Thu, 25 Apr 2024 09:49:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=cCsDk+4Aum2chjAhcJX8uB4K6blwXHcO0YE8sWRZIQI=; b=4o
	nwIYwLnYdIt/p60SXvXA0VQ9GAYuCcW/giq0VbVXuFh0ZvLgSQCAI2UcAF4lqULw
	x9RAwncI7I1bO1B4rwLQzKrdGGXartbVbfjAMZCYQW8gbEuNngGzTfoBthDHje7Y
	jPWfQgi5ot1bNJ8xxJl0L1rKvsRNHew4OVvrJuimd9B5LOePmYygO0khVchIxabZ
	452gBZptx2x3xRajSTp6xj5IRH+LjFMrsDVJ/ympN1/XlHh2H89ztXFxxzFrFmQN
	PQl8wjd5mZOdSfCHCNVC7jH/VUVdvmx6CpImEfzX84hWvsz2rcuU8sJlHogWSF30
	ZYpsGoY6Pnx9qXBVMKQQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm4kbc3w4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 09:49:38 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 875A540045;
	Thu, 25 Apr 2024 09:49:34 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D5E14212FD9;
	Thu, 25 Apr 2024 09:48:52 +0200 (CEST)
Received: from localhost (10.48.86.112) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 09:48:52 +0200
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Pascal
 Paillet <p.paillet@foss.st.com>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 1/3] dt-bindings: regulator: st,stm32mp1-pwr-reg: add correct compatible
Date: Thu, 25 Apr 2024 09:48:32 +0200
Message-ID: <20240425094829.1.Ia0a99d90acb512aa020a6e7a8cca8cc1b71f1759@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240425074835.760134-1-patrick.delaunay@foss.st.com>
References: <20240425074835.760134-1-patrick.delaunay@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_06,2024-04-25_01,2023-05-22_02

Remove the unexpected comma in the compatible "st,stm32mp1,pwr-reg"
and define the new compatible "st,stm32mp1-pwr-reg".
The old compatible is only keep for compatibility with old device trees.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

 .../devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml  | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
index c9586d277f41..2a52f9e769c2 100644
--- a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
+++ b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
@@ -11,7 +11,9 @@ maintainers:
 
 properties:
   compatible:
-    const: st,stm32mp1,pwr-reg
+    enum:
+      - st,stm32mp1-pwr-reg
+      - st,stm32mp1,pwr-reg
 
   reg:
     maxItems: 1
@@ -37,7 +39,7 @@ additionalProperties: false
 examples:
   - |
     pwr@50001000 {
-      compatible = "st,stm32mp1,pwr-reg";
+      compatible = "st,stm32mp1-pwr-reg";
       reg = <0x50001000 0x10>;
       vdd-supply = <&vdd>;
       vdd_3v3_usbfs-supply = <&vdd_usb>;
-- 
2.25.1


