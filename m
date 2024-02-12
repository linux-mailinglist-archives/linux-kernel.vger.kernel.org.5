Return-Path: <linux-kernel+bounces-62133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AAB851C0A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9891B27889
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6393FB01;
	Mon, 12 Feb 2024 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="kv7eBtXB"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DE43F9DA;
	Mon, 12 Feb 2024 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707760243; cv=none; b=SaLkrVVpP5K9SWtDEoL2oG/iiMaUmCbVmlCGcTdJrXYx1XqG0THHh5uDn53d5vv6xiPYGVF/f4rWx/QGUqJE4tpIssAEBk558OWMV7jDkomeQ3JD6V4qz7qs76lxafs77Yt56hnuvejlSa62slq7kWwV3F8DYjEmglPWHGw3Ihg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707760243; c=relaxed/simple;
	bh=dDGK2Cg7wLRy+TwEvAPkyLMsnqWfXkpZ9MQHHU6uDyc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dVmmJZ99WPGV9Dhrt2sh97Nmv5kKFzYHofpYjta57CCFFcwKSFDeVzQ4tcU0Kq0Co7pijyGP3J1dXN9jRb4JhaZIYnRgha93sJf/hR876SocpGjaQLGInMjLwpn2E/T6Ri896RTG9XAsKAWojdO8tNGew28Se8XsWNyULNWViuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=kv7eBtXB; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41CEj6w1026608;
	Mon, 12 Feb 2024 18:50:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=3QGuapQ1pMl6+y67XtYFOHf0HELLIV7lP4kRD4q7dGc=; b=kv
	7eBtXBOnk2vof/1QkqQStAzmjfQk188Zth72pzIOVoXj7LJ5ZQXqArIBmr+op7V2
	I6M25m+XnjZgPdPUN1mE1TdVkPctX0kzzvAHtYFrvZWQ47+NEDRL7/Kf+tKaooM+
	NDIlQkFoPhFNhA/OboFiSt7by8+De/zBBQTXpI50+163O2mc89/eFwLkaT91uUxJ
	SjtfKX0XzZZb9ZChDIMFO0SU+EuNgw9Gt+zRpUjw5atePLUG0WS9IP0qcLYxMfoS
	GohF0d+haoWDiocH9B9FcNxskYtyzYBsQKDLAVosjFhbPrRw7RWMGyNbRCxqHGbZ
	cpExAoRDoVhsuwS1JiUQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w6kk4naxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 18:50:07 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E44A240049;
	Mon, 12 Feb 2024 18:50:00 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B54EE27CC12;
	Mon, 12 Feb 2024 18:48:52 +0100 (CET)
Received: from localhost (10.201.22.200) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 12 Feb
 2024 18:48:52 +0100
From: Christophe Kerello <christophe.kerello@foss.st.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>,
        Christophe Kerello <christophe.kerello@foss.st.com>
Subject: [PATCH 01/12] dt-bindings: memory-controller: st,stm32: add MP25 support
Date: Mon, 12 Feb 2024 18:48:11 +0100
Message-ID: <20240212174822.77734-2-christophe.kerello@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240212174822.77734-1-christophe.kerello@foss.st.com>
References: <20240212174822.77734-1-christophe.kerello@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_15,2024-02-12_03,2023-05-22_02

Add a new compatible string to support MP25 SOC.

Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
---
 .../bindings/memory-controllers/st,stm32-fmc2-ebi.yaml        | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-ebi.yaml b/Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-ebi.yaml
index 14f1833d37c9..12e6afeceffd 100644
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
-- 
2.25.1


