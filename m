Return-Path: <linux-kernel+bounces-62143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2040B851C27
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C308F280F7C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA703F9F1;
	Mon, 12 Feb 2024 17:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="bTfuljjs"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F208D47A5C;
	Mon, 12 Feb 2024 17:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707760340; cv=none; b=MDqNsWJkTdxbRc4T4uInDY8hJsN1in4aRGhGpsnRCl+TOWLT/SIbVq6WegvAlf1j574qpGAcpC+RzAaQWkoZVsW7ES2dYg03UsEYCUqq2erDLxLU2DE4l13uvvgX1ji14mMAh4tUJSpYhfO8eK+Lqo88X82I1tZ1fy9z7qjD+6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707760340; c=relaxed/simple;
	bh=aTM2opUIkaGKFTyUxLEtlsFqxWxPW4PCU7/ZfhqzJMw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HPC8FrEYP7ThGOrJt5e2CrcusnujZH5hSNn5qoBj99KLSYQjUYwfuSC1G3oZAu6GCbHMCBiueUcqTLr0geDYyJV8UCft1D+srl4vCE4nsho5Hp7zrjUHxbhStm2YXotnEEWxMosi0nuN/QMX44YuVcGVJjriCa4fciDLkGGtrPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=bTfuljjs; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41CE0Pss006769;
	Mon, 12 Feb 2024 18:52:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=I6lmN2xCUej6ttHOqZWgQxZiDTKDUdt1z5FZ4+Y8XuI=; b=bT
	fuljjs28ay3pmxwTNnRZOCjY5iPxhWI5kB60eYWnXAJ9qs3JaqOvU/8JUu1A2tWc
	o7y8KHfMd9+uv/RTW2QwZpnsQHmnQ5l6kV4T7CT1CqZmLHBVeXxEUGL+JhyuaFA+
	IB5pMuQaeD+k+74grTeMxNLae0ZuQhZ3Qh2Cf2RQ0fdicG2RQeB9mKFKR5V4u213
	DQ/maEO9YvUhpd9RmcXz9m6yhm7CzFj2zO6+25lbOjSRO6eI1a8RaDTAV7XMbwn+
	Ub80i2BiC+4xHfgPGdSQzM9WgjQrKB4W0F+xRh1vMFnueePIprGp4hsN5vH207Ps
	NrQ6MjHd+MQd4+3jnqUw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w62js7py0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 18:52:06 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7B2B140044;
	Mon, 12 Feb 2024 18:52:03 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D0A6B2688CE;
	Mon, 12 Feb 2024 18:51:21 +0100 (CET)
Received: from localhost (10.201.22.200) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 12 Feb
 2024 18:51:21 +0100
From: Christophe Kerello <christophe.kerello@foss.st.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>,
        Christophe Kerello <christophe.kerello@foss.st.com>
Subject: [PATCH 11/12] mtd: rawnand: stm32_fmc2: add MP25 support
Date: Mon, 12 Feb 2024 18:48:21 +0100
Message-ID: <20240212174822.77734-12-christophe.kerello@foss.st.com>
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

Add MP25 SOC support (4 chip select are available).

Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
---
 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index c5bdb43f7221..d71ec12cd5b1 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -1878,11 +1878,14 @@ static int stm32_fmc2_nfc_set_cdev(struct stm32_fmc2_nfc *nfc)
 	struct device *dev = nfc->dev;
 	bool ebi_found = false;
 
-	if (dev->parent && of_device_is_compatible(dev->parent->of_node,
-						   "st,stm32mp1-fmc2-ebi"))
+	if (dev->parent && (of_device_is_compatible(dev->parent->of_node,
+						    "st,stm32mp1-fmc2-ebi") ||
+			    of_device_is_compatible(dev->parent->of_node,
+						    "st,stm32mp25-fmc2-ebi")))
 		ebi_found = true;
 
-	if (of_device_is_compatible(dev->of_node, "st,stm32mp1-fmc2-nfc")) {
+	if (of_device_is_compatible(dev->of_node, "st,stm32mp1-fmc2-nfc") ||
+	    of_device_is_compatible(dev->of_node, "st,stm32mp25-fmc2-nfc")) {
 		if (ebi_found) {
 			nfc->cdev = dev->parent;
 
@@ -2119,6 +2122,10 @@ static const struct stm32_fmc2_nfc_data stm32_fmc2_nfc_mp1_data = {
 	.max_ncs = 2,
 };
 
+static const struct stm32_fmc2_nfc_data stm32_fmc2_nfc_mp25_data = {
+	.max_ncs = 4,
+};
+
 static const struct of_device_id stm32_fmc2_nfc_match[] = {
 	{
 		.compatible = "st,stm32mp15-fmc2",
@@ -2128,6 +2135,14 @@ static const struct of_device_id stm32_fmc2_nfc_match[] = {
 		.compatible = "st,stm32mp1-fmc2-nfc",
 		.data = &stm32_fmc2_nfc_mp1_data,
 	},
+	{
+		.compatible = "st,stm32mp25-fmc2",
+		.data = &stm32_fmc2_nfc_mp25_data,
+	},
+	{
+		.compatible = "st,stm32mp25-fmc2-nfc",
+		.data = &stm32_fmc2_nfc_mp25_data,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, stm32_fmc2_nfc_match);
-- 
2.25.1


