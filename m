Return-Path: <linux-kernel+bounces-71225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B30785A22D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E18F1C2231B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18B82CCDF;
	Mon, 19 Feb 2024 11:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="POKXkAnA"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEBA2C84C;
	Mon, 19 Feb 2024 11:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342790; cv=none; b=MkCJ230JOFan7u3aM4RANvpMi/5II7EvAD3XRAqaOupQsKPw+HyD76MqbFRmXmZX+FeumlSe9mmPMvAjyzfG0czFnjMjqMCKJohTl7gDm+bAW2jOzDA4hHH4pNAKrB00B68YbEMUy/FEMxds7CrI74T1k8Gh/5u7lE+dMRSm3xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342790; c=relaxed/simple;
	bh=wxPogXv4thk9tgK7ArfVDyswjN7usCV1N4Tx6ibXSAM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ssRfnwTuxDyrAaFrKjRZAcR9NFpKhHgvlS9G+wsGpTt2gHsGzWYQnp01muPLis/QKyFXjx+kTpIMso0e9mvIQCTOCzXUhnzrokV8S8rvtyVEhpi7sutRUEC9Mfv/6ZpJky9BT/uLLuL3Tc9oklZXj5J+sAm8xkpJ418IsxCScKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=POKXkAnA; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41J86YTn031767;
	Mon, 19 Feb 2024 12:39:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=wWuk9zKWKWnIIZEgyrM9Had0Pm81rB13rP0pqzFN9Fo=; b=PO
	KXkAnAQ3cWZ+IZUGxA7Pu7B+AwaTLIfW5W8AiuIq7+8F40YVnj6emIjqlaKDySRb
	6fClcSxJZAQ/qN/CjONYN85cMK+2KxO1QRvcNDi+Tq8Hsx+fpczxK4740JKa4GVE
	zLoNuV0galEbNfsnXPZiXN1dGKm+klTRl3r+l+Vkhp57DjTY8w3/DLPdgTYm61xT
	GgFUOHkAsQ4398iv/il6Xksz93SQj6m48r/6lpqQqDIWy4MzqIWNZJcsZLRb5F/e
	WdjgBcuStJpPSP7W6CZASgHeuifMObA1NM4i98/l0lrxe8JjXwmg9H88ec3hKTqR
	f6AenWNpwp8Fs5Aw5mZA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wamjh6491-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 12:39:35 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 14A7040045;
	Mon, 19 Feb 2024 12:39:29 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 61E8525AEE8;
	Mon, 19 Feb 2024 12:38:57 +0100 (CET)
Received: from localhost (10.201.22.242) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 19 Feb
 2024 12:38:57 +0100
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
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Lionel Debieve <lionel.debieve@foss.st.com>
Subject: [PATCH 1/3] ARM: dts: stm32: add CRC on stm32mp131
Date: Mon, 19 Feb 2024 12:37:43 +0100
Message-ID: <20240219113745.92538-2-thomas.bourgoin@foss.st.com>
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

From: Lionel Debieve <lionel.debieve@foss.st.com>

The Cyclic redundancy check calculation unit (CRC) peripheral
offers a CRC-based operation (CRC32/CRC32C) used to verify data
transmission or storage integrity.
This peripheral is integrated in stm32mp131 and can be default
enabled.

Signed-off-by: Lionel Debieve <lionel.debieve@foss.st.com>
Signed-off-by: Thomas Bourgoin <thomas.bourgoin@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp131.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp131.dtsi b/arch/arm/boot/dts/st/stm32mp131.dtsi
index b04d24c939c3..3900f32da797 100644
--- a/arch/arm/boot/dts/st/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp131.dtsi
@@ -1315,6 +1315,13 @@ sdmmc2: mmc@58007000 {
 			status = "disabled";
 		};
 
+		crc1: crc@58009000 {
+			compatible = "st,stm32f7-crc";
+			reg = <0x58009000 0x400>;
+			clocks = <&rcc CRC1>;
+			status = "disabled";
+		};
+
 		usbh_ohci: usb@5800c000 {
 			compatible = "generic-ohci";
 			reg = <0x5800c000 0x1000>;
-- 
2.25.1


