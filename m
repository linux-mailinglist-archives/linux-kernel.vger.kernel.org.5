Return-Path: <linux-kernel+bounces-69818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EFF858EF2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 12:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 060041F22271
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F037060DE1;
	Sat, 17 Feb 2024 11:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Rs25/BLc"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8308A5EE78;
	Sat, 17 Feb 2024 11:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708167890; cv=none; b=frzHG/veDMHNtOetsd/bvU3XzdxkJ8xdils3RHCjPTFNQrc0eXPxj2tSFaHLl/Kigx07LNWuL3nNysndpPBdKmmu0rRVcpSvqn7QuqYYUON7z80eXLaIn85A6twoLEQ3BTgXSo1X/PUmYcST2b6TaVKEU/Oj5u14MkiDAJLVJJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708167890; c=relaxed/simple;
	bh=ugIMxaqtGiWtkvlDP1PnDeAPKZDlKx1Qzah9gu2ZwmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=scsuRXUNkPHu9WlMUCr/L7Q/ZifI7kF62B3uIiPRhGmmp3gbFJPfNuGtOkmNkYYt5N9qRie5kXdKsg/w8G5+s8hDjahGwsB3dY2Xa7wCHm4hylWG9Cz/ooL+CVAzKdPVIoQ9gZNYfQ77upAK6j+nM//wNeCtzreo9ZHJEu7DcOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Rs25/BLc; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41H4iBek028987;
	Sat, 17 Feb 2024 12:04:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=selector1; bh=RnhRbd/hclbstXd7Q3NPDVDNjfAippsXAKSovZiaCJg
	=; b=Rs25/BLctHvzsAXjDLDQ6PuOhH0RPprK6ImbHWKJB4ggXElnwrey2IMElUE
	DFZ2yxK5VKcduqooM2Bl0wcuslxrmT6r9M3yDfEa9Rnc/tvveM1iuLz0t1ZOpAH8
	8AAhLeAxqL1RIL196lQhbZjy7hPeZIVA08yfc7rCGOMX0RTeL86ZWyYpsCM+gcZl
	K+xXCph+LtfXysAKv8Vg9lovwj9yQ4QQOdTOllJJnx/lXcItJCLTcmtFA5+DyQ7U
	AbX5P5RTubdacf3cn6XqESP6BBcWkfNA31N/VhjX14d2E/4tIhK595xCX+W2ppn/
	s3oK59BK7PDkRs1Bcw55C/u0SWQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wamjh0tbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 12:04:05 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C72F840046;
	Sat, 17 Feb 2024 12:03:58 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8345F253B49;
	Sat, 17 Feb 2024 12:03:12 +0100 (CET)
Received: from localhost (10.252.12.210) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 17 Feb
 2024 12:03:12 +0100
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Date: Sat, 17 Feb 2024 12:02:58 +0100
Subject: [PATCH v2 4/4] dt-bindings: display: simple: hardware can use
 several properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240217-ltdc_mp13-v2-4-50881f1b394e@foss.st.com>
References: <20240217-ltdc_mp13-v2-0-50881f1b394e@foss.st.com>
In-Reply-To: <20240217-ltdc_mp13-v2-0-50881f1b394e@foss.st.com>
To: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        Raphael Gallais-Pou
	<raphael.gallais-pou@foss.st.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-17_07,2024-02-16_01,2023-05-22_02

Setting a panel-timing in the device-tree overwrite the one specified in
the driver and set it as preferred.  In that case 'height-mm',
'width-mm' and 'panel-timing' are properties that can be use for simple
panels, according to panel-common.yaml

Fixes following warnings:
arch/arm/boot/dts/st/stm32mp135f-dk.dtb: panel-rgb: 'height-mm', 'panel-timing', 'width-mm' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/display/panel/panel-simple.yaml#

Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
 Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 634a10c6f2dd..c02cbbc7a100 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -352,6 +352,9 @@ properties:
   no-hpd: true
   hpd-gpios: true
   data-mapping: true
+  height-mm: true
+  width-mm: true
+  panel-timing: true
 
 if:
   not:

-- 
2.25.1


