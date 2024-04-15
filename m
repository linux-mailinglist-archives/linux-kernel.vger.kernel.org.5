Return-Path: <linux-kernel+bounces-144838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE9E8A4B87
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAFC61C20CC0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F56F3FE55;
	Mon, 15 Apr 2024 09:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="7Rdq0cTp"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5D1446AD;
	Mon, 15 Apr 2024 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713173605; cv=none; b=LYAFHH/d/epi0wHXAR88VIKGfsnWAf5yutknl80EuUEZe0Sw58Pw7uRnRVJo3UGr3WNZcy1dbl1STd+oF+rK3mWCuirZPcHXsnr0e9mOq0eS7dS6fMGv26hmcbKDL0o8hoMrVGzbFadFx8kAW7KZzO6MakETRCfYzaFKK0lh1hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713173605; c=relaxed/simple;
	bh=e7OmjfW0ZfmdJF/7hY2wwAd8dJ7JCsJijNaaHD9bWC4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b62Kpp1J3CRZP8VXkqILQK5YljrLDTMVFIER9T/Hb4On5knhZk3D1FSkuVeoiiqOVuo95mplknQlOP5yxEyM0eEWsDPOv+GgnBabQ9/0lhjxQkSR0GCjz/RVKrFYJ63V0QLLXmwRUNydLgN/61UHuVk88Fi4ldfAH4ptvqxxcWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=7Rdq0cTp; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43F75qkx004772;
	Mon, 15 Apr 2024 11:32:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=CJMsyOU
	vibO44hZ0FRzGuvGUbPQDu1y2PkvDKBeOhvI=; b=7Rdq0cTp5JrEfksjWZr6Myp
	nDuhTxoxGqkrFsf/4oZzLIPsqnbb2GKzTde4YNJrPpiYHa559deP2GthwmpF9BmH
	sKSVulLtuu1dTc4aHMBdR8Y+IQQ7ggQCiktgbwGAxK++tVUzAhX4VQq0biO01DDU
	CUmTiA6m2qPvIEYDGSoybPznT6CiX5IyF4wbszY6btiomtx/wrjaEEZbw8hZFcag
	aPFnBY8lmNOu0m/v3pcNe3ZIyJruq2wMZWxPKfvClhY0d3L9rCyhHBdrPXTc2HAt
	zN1++Y6bExfJe3313flDL5FKW1q7hoEOed779ULq+RCU4Oto3yefH6uEFirvlfw=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xffff6ybt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 11:32:57 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 486924002D;
	Mon, 15 Apr 2024 11:32:51 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EA4E7211F06;
	Mon, 15 Apr 2024 11:32:13 +0200 (CEST)
Received: from localhost (10.48.86.141) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Apr
 2024 11:32:13 +0200
From: Hugues Fruchet <hugues.fruchet@foss.st.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Hugues Fruchet <hugues.fruchet@foss.st.com>
Subject: [PATCH v2] media: dt-bindings: add access-controllers to STM32MP25 video codecs
Date: Mon, 15 Apr 2024 11:32:11 +0200
Message-ID: <20240415093211.809927-1-hugues.fruchet@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_08,2024-04-09_01,2023-05-22_02

access-controllers is an optional property that allows a peripheral to
refer to one or more domain access controller(s).

Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Hugues Fruchet <hugues.fruchet@foss.st.com>
---
 .../devicetree/bindings/media/st,stm32mp25-video-codec.yaml   | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/st,stm32mp25-video-codec.yaml b/Documentation/devicetree/bindings/media/st,stm32mp25-video-codec.yaml
index b8611bc8756c..73726c65cfb9 100644
--- a/Documentation/devicetree/bindings/media/st,stm32mp25-video-codec.yaml
+++ b/Documentation/devicetree/bindings/media/st,stm32mp25-video-codec.yaml
@@ -30,6 +30,10 @@ properties:
   clocks:
     maxItems: 1
 
+  access-controllers:
+    minItems: 1
+    maxItems: 2
+
 required:
   - compatible
   - reg
-- 
2.25.1


