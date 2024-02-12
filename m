Return-Path: <linux-kernel+bounces-62132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B33B7851C09
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 654331F22CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520793F9FD;
	Mon, 12 Feb 2024 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="see1PXtW"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ED33F9D8;
	Mon, 12 Feb 2024 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707760243; cv=none; b=R6aW8aEGS66GLSLskDUverxBdy/Z0hBKoWaPyZXsq6W/I3luVnBLxSWtMMwrEplCfkYjSsbMbKOh1hfDFl7GjFqlZ1o5tvTVNFWlmaUqDENEMS/N09oU6m4kml4T4ne8/lkFJP+fjuJKTX7n/UXWCTHhl1E0rsqm+11wBtCdCus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707760243; c=relaxed/simple;
	bh=nZ13Ys3CpROuP0ZnM9C1WxzvGrxH5STRvj92wL3lesM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c9v12n1K6TNOpy2L049e3h6OUezKGSCmU13jhIPGf1rcO+vIyiKPMQczfvqzE23Hws7I+pLSlT2354XaC8DqhsBDIYWs174vNXA96qAqcRZJKYPJIlhxKHbB2O3iEDAdbPdc5NB7tq0C3hwXlObkwxsMPFyWuqM0HrISobRRl24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=see1PXtW; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41CF4fx4002434;
	Mon, 12 Feb 2024 18:50:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=r6RWTYufSQBKqRLetLHxbThC+14OuOlj1dpd6iOn9yk=; b=se
	e1PXtWLwSNmdKoYwsM9aaKpfFhLFdGOS0HpawjkYUzXY7A5uokS//xgmvII+eV2W
	Gkb6Z8DF+jbwcdKHPJy9zd/ujQOZfIYUe1uYqtDonmjClHUnIu165wCB++LvBaz5
	XrKAEOeAUi0g+tvpJcc0hcyp1quuQa4/Xqw6muN6H1DTzxQAAP7sVtbn1TWQSmoI
	P1u7fZNcDh2WrUUEOngO54SCR+QRoiSxbWP3e/fHq8GYJ+NHA6/agaN3bbvKW3JK
	gw5OFyK3aRlWFueIBlRfVsU36kj5QOtWnJPPyAz5rXWVv3qV85gtvpcKwrU7sUNR
	D5EqyH+e0FfUm+ebuK0w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w6kk4naxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 18:50:22 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C789E40044;
	Mon, 12 Feb 2024 18:50:19 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 51D0B27F265;
	Mon, 12 Feb 2024 18:49:37 +0100 (CET)
Received: from localhost (10.201.22.200) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 12 Feb
 2024 18:49:37 +0100
From: Christophe Kerello <christophe.kerello@foss.st.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>,
        Christophe Kerello <christophe.kerello@foss.st.com>
Subject: [PATCH 04/12] memory: stm32-fmc2-ebi: add MP25 support
Date: Mon, 12 Feb 2024 18:48:14 +0100
Message-ID: <20240212174822.77734-5-christophe.kerello@foss.st.com>
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

Add MP25 SOC support. RNB and NWAIT signals are differentiated.

Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
---
 drivers/memory/stm32-fmc2-ebi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/memory/stm32-fmc2-ebi.c b/drivers/memory/stm32-fmc2-ebi.c
index 5f82686689ee..d79dcb6c239a 100644
--- a/drivers/memory/stm32-fmc2-ebi.c
+++ b/drivers/memory/stm32-fmc2-ebi.c
@@ -1203,11 +1203,19 @@ static const struct stm32_fmc2_ebi_data stm32_fmc2_ebi_mp1_data = {
 	.rnb_for_nand = false,
 };
 
+static const struct stm32_fmc2_ebi_data stm32_fmc2_ebi_mp25_data = {
+	.rnb_for_nand = true,
+};
+
 static const struct of_device_id stm32_fmc2_ebi_match[] = {
 	{
 		.compatible = "st,stm32mp1-fmc2-ebi",
 		.data = &stm32_fmc2_ebi_mp1_data,
 	},
+	{
+		.compatible = "st,stm32mp25-fmc2-ebi",
+		.data = &stm32_fmc2_ebi_mp25_data,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, stm32_fmc2_ebi_match);
-- 
2.25.1


