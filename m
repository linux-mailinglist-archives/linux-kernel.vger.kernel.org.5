Return-Path: <linux-kernel+bounces-62134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B43851C10
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0F21F22DAB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62383FE47;
	Mon, 12 Feb 2024 17:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="z2/7CTCJ"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF8E3F9CE;
	Mon, 12 Feb 2024 17:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707760245; cv=none; b=ffoagSVdwvIw3XG1v/yFVeA9xNhfLGn3UlQyXLWeFFwN6bwHow9lcXG57Zx330WG0aDKNEYkY9w6+dTVyspXLt4383Sjr8Rfk4AiMhpUzSJcV+0GnCBENxvKuy1XJnoxGDrNYOuFc1CXP7M2nvaF7RCaVF91AZXRFkJbXPXxH0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707760245; c=relaxed/simple;
	bh=nqyn+NMPR3Qp4kmN/ffUDDJqekW6aeJgiis655KEkbA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHlgIsZfe+TGCn7vEAnBO1xFJ3eKw+1ZAk6ZZoL/qzjh5uWLe8syod0o3zELnQWjUu6qwc1qRXg2XMumQdT+jA20J0UDRZKE2igQGlklxwB92j3+muU8zMSVf5x08lVx5Li/4V9IGM2XSeeN+KxQkJ/bB4rYl7UZJoL4S2/bNm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=z2/7CTCJ; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41CEQj5x018688;
	Mon, 12 Feb 2024 18:50:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=X5FzM+bKH9CfiJVb/5vMppNol/5mtkgXoVYxjRsJvyc=; b=z2
	/7CTCJwgOTdOfiEWRG7uoiVStPGN4WnYG6/gHzmcZ/MkiK5Mu8+wP5bXfbU5kSbA
	H8MWbiDT9zY0G6HqbWDiaAEjkyRXi/PhQ1df4v/cZwmfgoTzyVEPJ/OkSGUQtwQM
	a46ZgVpMUFvNzGhSHutem3z03C7+yIWC1yOPRZl+u4hQTJmtZEQzuAkpBKjRL0RS
	Cn7VHuTV2g+JLlVMgwk9+hpVsOc9pkX4myqYdFofMSwRFJDn1NzQpuOB/NZQdNPA
	OBdoX5FmNYQaQ837RGpcPwBuUbffgrZdKeqRKIgmZ9SfSmby5i9qdTzJKX/zx0ea
	DKVsx1tbOWyrZy4diD/Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w6kk4naxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 18:50:10 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 073E44002D;
	Mon, 12 Feb 2024 18:50:08 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 66E49275757;
	Mon, 12 Feb 2024 18:49:07 +0100 (CET)
Received: from localhost (10.201.22.200) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 12 Feb
 2024 18:49:07 +0100
From: Christophe Kerello <christophe.kerello@foss.st.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Christophe Kerello
	<christophe.kerello@foss.st.com>
Subject: [PATCH 02/12] dt-bindings: memory-controller: st,stm32: add 'power-domains' property
Date: Mon, 12 Feb 2024 18:48:12 +0100
Message-ID: <20240212174822.77734-3-christophe.kerello@foss.st.com>
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

From: Patrick Delaunay <patrick.delaunay@foss.st.com>

On STM32MP25 SOC, STM32 FMC2 memory controller is in a power domain.
Allow a single 'power-domains' entry for STM32 FMC2.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
---
 .../bindings/memory-controllers/st,stm32-fmc2-ebi.yaml         | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-ebi.yaml b/Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-ebi.yaml
index 12e6afeceffd..84ac6f50a6fc 100644
--- a/Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-ebi.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-ebi.yaml
@@ -36,6 +36,9 @@ properties:
   resets:
     maxItems: 1
 
+  power-domains:
+    maxItems: 1
+
   "#address-cells":
     const: 2
 
-- 
2.25.1


