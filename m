Return-Path: <linux-kernel+bounces-158149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 362C68B1C31
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72F84B23337
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163FE6F513;
	Thu, 25 Apr 2024 07:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="r4P+xO9D"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB62A6D1D7;
	Thu, 25 Apr 2024 07:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714031391; cv=none; b=KfDmuwwxCTnOLByprraNu8ofTGCynOzKycDdNElTc3Gb4yvkqJ05IUj9CR9BuU5Edn0VQhJ9PJnwCfJvDJD5pQIrV9eUtq6bxZNvwHvvkLmj5bSZjxJGZ0NGMU/0DycOoRn1QBlVD9p/r54c4a8uBSeZYYk8zCCYKHap8OtASH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714031391; c=relaxed/simple;
	bh=TU7JPNtJvYbfkkiLFRUnN0+GgPnAr41+YYpHl9dtzLE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jU/0cskSnIv8FW0TXjn7P/pCbJ6ZiDd1Jve1gt+fZ8jOypE7TakfLbaRObsbeOCPaK1F5Rd6hD3Iu1Gwdai3Q4Pvtuw0dc5eEmRWuNwgOXSt3v6bucSu8UuoORVZp7Z9VhLtXZ5//T7t6gwhC0pikiLCL7c0mcaDvSYpkuOQV9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=r4P+xO9D; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P7GipT029734;
	Thu, 25 Apr 2024 09:49:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=wjswcOrzvwCTm6d/+dyApwtqZE5TvkRvblZWO7jtgTg=; b=r4
	P+xO9DO9R1YHT/q5niatzjieot9oqD41SGJUgrLdnMpj9z43Qf+tMn+gmIBO/N2f
	Hvs27uuwxZLg6MSock+uOKDaf+/wbYHTy9qFMZhRKw+/Y38KW/uIH1iPAyaiSKmO
	JAUpSlWKWNi1AjiEsaYhaEYaH4onablLGyzEnPTBW5I01S++Xymti255I8OXb/L6
	P8TF/0fB8bsS8afW72t2pr1ChEdw9ovj3hHgcKT9zMX/ENABNdPh46k24tnAEOLy
	42FvBqbu4LhsZ0EJB34ih4MeVm5ptp0e981IKy93Kdv+e1FfcGlzgBF4QOpwY6+Y
	akMPDPaW3mMEjoy5562w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xmrnj9vyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 09:49:38 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 506AA40044;
	Thu, 25 Apr 2024 09:49:34 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 521162132C5;
	Thu, 25 Apr 2024 09:48:55 +0200 (CEST)
Received: from localhost (10.48.86.112) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 09:48:55 +0200
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 3/3] ARM: dts: st: update the pwr compatible for stm32mp15
Date: Thu, 25 Apr 2024 09:48:34 +0200
Message-ID: <20240425094829.3.I493dfe2bde7f40beb48455f8ff8368cc8a869cdc@changeid>
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

Remove the unexpected comma in the compatible "st,stm32mp1,pwr-reg",
and use the new supported compatible "st,stm32mp1-pwr-reg" in STM3MP15
SoC dtsi.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

 arch/arm/boot/dts/st/stm32mp151.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stm32mp151.dtsi b/arch/arm/boot/dts/st/stm32mp151.dtsi
index 16bd6eee32b4..702cdaa1343a 100644
--- a/arch/arm/boot/dts/st/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp151.dtsi
@@ -144,7 +144,7 @@ rcc: rcc@50000000 {
 		};
 
 		pwr_regulators: pwr@50001000 {
-			compatible = "st,stm32mp1,pwr-reg";
+			compatible = "st,stm32mp1-pwr-reg";
 			reg = <0x50001000 0x10>;
 
 			reg11: reg11 {
-- 
2.25.1


