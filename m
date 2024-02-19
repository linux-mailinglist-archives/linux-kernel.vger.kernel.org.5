Return-Path: <linux-kernel+bounces-71228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A8685A236
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B627B25B0B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93D42C6B6;
	Mon, 19 Feb 2024 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="5TbEunxB"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC8D2C6B4;
	Mon, 19 Feb 2024 11:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342821; cv=none; b=T97EH3f5jjx7+8GGppBDmFwTcnqdnFCQJayD33yAygnZK5tMPFJ+NHcolVB/0eIzYsAKwXp9jWUnvRH6GaJ6ksQlkoRMVVDZK0d+/KTw9LFZ3zQrYyWhmibs1leyORG2Xxg+mEzWUpLAzbaMkiQUNSLcGSZsTmVqrf+AsF0fx5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342821; c=relaxed/simple;
	bh=wXup3JEP9EFvX0hKXUJgvMA+ckyVWQnXRIWp9xhXjFc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=biixXRjjucByLfztT/CKiEtBmZUMWwMmFSPk3wNOCXQoznOwQLJ0uihQFo7BNGhEvYwzzKiBYaFpQmATDziPPUNERx2njBtqhr4cvWmJAehTxfD3I5zVk4oBVy0qibq9B4eh466yTnNCwxUZYLx8QVoOHj12RSC67B6EsK2czVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=5TbEunxB; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41J820MB027184;
	Mon, 19 Feb 2024 12:40:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=vtgOW1F/P27OtsClB1wYitZvlIxif1OkjeVL9NFq9+g=; b=5T
	bEunxBjlUCxLM+pnT1gCjB2gRnZVdl/sMTsbIeyPHe+i+Gn/CPFwpKA00+T0PBDN
	Fi7lCyfa/ANpPUn5xzORLA5FVy1BpsH2t3+0GMuw6Euf/6/n1uXsUmxs7MfavK1m
	Wz76JPGxSiVY5e1K2nZImI+6KdDczW6MSx/pfnvuYK8KIaJ7EGS9l3FpG80JIoDl
	HYI8F7xFyG8bZI/2zMHutQqy3jpxrF5MfDmvvyRIFMSQ+uErAtqxbAj5/sVPEaZT
	09i4aDlZ48+mcbJV+dOX8gSTKmZW0lNFH2cfjuy7ib45cWZ9gSdAFwzEr+h6iED5
	BYGGM15rcCkMnnpBNg7w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wb8mnm4gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 12:40:07 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8D8ED4002D;
	Mon, 19 Feb 2024 12:40:04 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 33B1425AEE4;
	Mon, 19 Feb 2024 12:39:32 +0100 (CET)
Received: from localhost (10.201.22.242) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 19 Feb
 2024 12:39:31 +0100
From: Thomas Bourgoin <thomas.bourgoin@foss.st.com>
To: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: Thomas Bourgoin <thomas.bourgoin@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] ARM: dts: stm32: enable crypto accelerator on stm32mp135f-dk
Date: Mon, 19 Feb 2024 12:37:45 +0100
Message-ID: <20240219113745.92538-4-thomas.bourgoin@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240219113745.92538-1-thomas.bourgoin@foss.st.com>
References: <20240219113745.92538-1-thomas.bourgoin@foss.st.com>
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
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_08,2024-02-19_01,2023-05-22_02

Add the crypto accelerator enable on stm32mp135f-dk board.

Signed-off-by: Thomas Bourgoin <thomas.bourgoin@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp135f-dk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp135f-dk.dts b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
index a7b1b2ca9d0b..52171214a308 100644
--- a/arch/arm/boot/dts/st/stm32mp135f-dk.dts
+++ b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
@@ -97,6 +97,10 @@ &crc1 {
 	status = "okay";
 };
 
+&cryp {
+	status = "okay";
+};
+
 &i2c1 {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&i2c1_pins_a>;
-- 
2.25.1


