Return-Path: <linux-kernel+bounces-71227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F034B85A232
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90718B2587B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145012E400;
	Mon, 19 Feb 2024 11:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="RYL9GG4y"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28DC2D60A;
	Mon, 19 Feb 2024 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342809; cv=none; b=DXPMv+v17Gl98zzupg4R6u90uI66qmq0z4Lu7THYDDakJi5E4kgoSLzPQfu07Dd8YZvTvy9qyLiMCdPv6FM2agaAmO/9JXEN1nB9NvTR9Omri1UEUUnzlpFTyntNVEAwqlxoDHZr6TTwH1Pu7WnGx3yRBrb+eysdfYX9qEZLSYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342809; c=relaxed/simple;
	bh=PMjrJxaGw1vp+bTkLVKB5OJW5cHn681QdVSr9K26QwU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dyTe9xU/44qfTFEu0L2yRfVbU/VBoHdgMSf/It9U+LwoUcWplYPzP5I4+HK1OGn0muTJsj167x/AAjNCJ6ptW+PyJCEJN2cl4Vcj6qSnGL6fYGNnRrRCvYAUBqMNxglZ71rJGsT3ic6f4/gmg/Ic0G7gvtmqUtdtUQvih28OE5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=RYL9GG4y; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41JBdpjn015778;
	Mon, 19 Feb 2024 12:39:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=n3ZX4og6N+EjU2DvZFG9aH+WjUbp+3YK366HjBe+Q40=; b=RY
	L9GG4yeHpaQe6vr6LdInDpmbD/n6SgnlRFGQhU8sf4rZNzC9t79TAIG4SSoBZbkc
	zXIThoyImhgjoseu3ORMegx2BfnG12XUKUMO8Mxt06IHLAmcdgp/1SlEwqdnNpYs
	49TLycNoSsR3nnvt5G+wxpvrO+AmAxKixjS84x/f7by4xRhsEUTxGK+zf9m7SvnK
	JU8jky7Q6uiMg09EkRP8JrJuAzv/xkAIIEKwJYIWqkaUJSB6rTm5gxOQkF18d1gv
	ydlpyFlrMjZ8GLPYhe8uMNVtDc3aovjUfWWkiXAL6vweMkY+H335vnPjXQSJdJqy
	RVUsANagfRMUUH/j1aWQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wamjh64a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 12:39:56 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 84BB94002D;
	Mon, 19 Feb 2024 12:39:52 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 700C125AEEA;
	Mon, 19 Feb 2024 12:39:19 +0100 (CET)
Received: from localhost (10.201.22.242) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 19 Feb
 2024 12:39:19 +0100
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
Subject: [PATCH 2/3] ARM: dts: stm32: enable CRC on stm32mp135f-dk
Date: Mon, 19 Feb 2024 12:37:44 +0100
Message-ID: <20240219113745.92538-3-thomas.bourgoin@foss.st.com>
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

Enable Cyclic redundancy check on stm32mp135f-dk.

Signed-off-by: Lionel Debieve <lionel.debieve@foss.st.com>
Signed-off-by: Thomas Bourgoin <thomas.bourgoin@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp135f-dk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp135f-dk.dts b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
index eea740d097c7..a7b1b2ca9d0b 100644
--- a/arch/arm/boot/dts/st/stm32mp135f-dk.dts
+++ b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
@@ -93,6 +93,10 @@ channel@12 {
 	};
 };
 
+&crc1 {
+	status = "okay";
+};
+
 &i2c1 {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&i2c1_pins_a>;
-- 
2.25.1


