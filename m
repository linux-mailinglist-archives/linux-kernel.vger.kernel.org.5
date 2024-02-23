Return-Path: <linux-kernel+bounces-78305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1501B8611A7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE4A11F24879
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181927EEF6;
	Fri, 23 Feb 2024 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="KLgrMamb"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FDA7E788;
	Fri, 23 Feb 2024 12:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708691948; cv=none; b=PCCN0tkcMn70Ujd8qQFDtcgXe03xYkLDxMwr3ZHV6qvkDLlQUeDyTFTCwZOZJINXwYQZW1YgGxqXKeIxKjjRxsN4c2HC0/OEkB8rxDgFQy7t2I5ROX7wyRq7pF31MTd2CIaauYBsmqh6M4J1OgHd2PPJKEVn3Ip0WaseHAWr1es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708691948; c=relaxed/simple;
	bh=knJQXHiHO9YVW+BCkn85q95/1j/TFwLhTq3OVe8TkG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=c63d0AVvhqddc9FpTM8fJmd440VrOjGYfuONO2O6cpjEofMuGBB77iKOuq6dZP+Xt7WXrxOX9W7ZYRRN5C0l5USaaP1KjPtad9Do3twa83iX3mJYWMdjx8jOESqsA1/7FzpnMOmZRFQz7MStPRUOXmilnudH5bXYWUijjs0SO2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=KLgrMamb; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41N8GlAX022193;
	Fri, 23 Feb 2024 13:38:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=selector1; bh=F8zN5Yz0CWcU425g4AE37w9LRhYp8Zn5uSxrL8yHXMQ
	=; b=KLgrMambOr1HfgvJtNKE7rQUf6tvKRDf6amCBEY4a+YxJLQ2vW9rBQpmOWB
	mcPSA/SY3aBdumAM0cZqIUgqAYTHizi52XjhPq9axXa6/yRcGy0LiJVPuKxBJrLn
	TxSl0Ms0KDygiNyBkwj8b3668ZBS0U6PRKlorg0T3uC1yj2EttYL1IZmMZ5b1TUj
	r2JqlSdJqLxHmVYKIbIKeBEHCVi+lLucpCvAL4IgI0lBUpz8Oya9Sf50DiINKP07
	dp08Vb1O4Lq72eaGhLCX6cTaHCZ7rWyTa0hwv0osL0AdPrrY51nV4LwZ7SgeWdg3
	LVUCVnxahCO4nOcUpXvvHGdBC4g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wd2034kjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 13:38:13 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 64DDC40046;
	Fri, 23 Feb 2024 13:38:05 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A7BC428DDC3;
	Fri, 23 Feb 2024 13:36:54 +0100 (CET)
Received: from localhost (10.129.178.151) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 23 Feb
 2024 13:36:54 +0100
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Date: Fri, 23 Feb 2024 13:36:51 +0100
Subject: [PATCH v3 4/4] dt-bindings: display: simple: allow panel-common
 properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240223-ltdc_mp13-v3-4-7f92a59ca11f@foss.st.com>
References: <20240223-ltdc_mp13-v3-0-7f92a59ca11f@foss.st.com>
In-Reply-To: <20240223-ltdc_mp13-v3-0-7f92a59ca11f@foss.st.com>
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
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02

This device inherits properties from panel-common. Those should be allowed
to use, instead of specifying properties to true for each specific use.

Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
Changes in v3:
  - Allow every properties instead of adding each properties to true as
    Rob suggested
  - Rewrite commit log to match changes

Changes in v2:
  - Added this patch

Fixes following warnings:
arch/arm/boot/dts/st/stm32mp135f-dk.dtb: panel-rgb: 'height-mm', 'panel-timing', 'width-mm' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/display/panel/panel-simple.yaml#
---
 .../devicetree/bindings/display/panel/panel-simple.yaml       | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 634a10c6f2dd..01c9153da3d3 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -344,15 +344,6 @@ properties:
         # Yes Optoelectronics YTC700TLAG-05-201C 7" TFT LCD panel
       - yes-optoelectronics,ytc700tlag-05-201c
 
-  backlight: true
-  ddc-i2c-bus: true
-  enable-gpios: true
-  port: true
-  power-supply: true
-  no-hpd: true
-  hpd-gpios: true
-  data-mapping: true
-
 if:
   not:
     properties:
@@ -363,7 +354,7 @@ then:
   properties:
     data-mapping: false
 
-additionalProperties: false
+unevaluatedProperties: false
 
 required:
   - compatible

-- 
2.25.1


