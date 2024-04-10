Return-Path: <linux-kernel+bounces-138801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA1189FA85
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5062844A4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914BD16F0F8;
	Wed, 10 Apr 2024 14:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="UvWhaROV"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD1E16D30C;
	Wed, 10 Apr 2024 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712760211; cv=none; b=SE8tKQCH6BvRdU1m/Sqqn/LPnS3N5bhIfLNywdwHCyuOYjJezjd+0Hm0rGhtQPl+dWQ/2kxw4LaQ//PcGYKDl8i48UdB1jeXTZ7voeJY/bWx7msaa8Vohfh3BPBsghDCERUyDRF+aKq4MUYu2ahONmWXA/SgtDgEoOMWce4vnXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712760211; c=relaxed/simple;
	bh=k2hi3unLT57nDJF5zNI6cNBtlT23Yvls+wYLytdrX4E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eS3qgUGZBis1wgoBcazySTscGt3qyS34D6JILSg3nCwpyf5ctjtmpXsjt8C6p7jKahWELQRKxOK/wh0r93HPlFPlkiRSG5Rnx+F46iTCktXX2RcB39uXZqrkreQptASyGuq+baH47/4UdUwlKh9Kg8reDZc8BH/AKhMvCEzKmzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=UvWhaROV; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43AC4vK0002860;
	Wed, 10 Apr 2024 16:43:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=8QujdN4
	XDCTSNrM7s5UiY+ADwmGpvJW4wLZimrrKB/s=; b=UvWhaROVFRo/53vXc7kRWqi
	A96MfYR8i/aFyf+TEULyInW53w8OlYyrNgP8qx16ZCt6r7/zCxBgCS3cyCL1Kgz/
	a1PLoiIgR4G4osqH13Me9kWOXsu89CMNBtESZy9FFmmv8Q/pCU4HWKIZvyqZDNoC
	hKfWPSbLaI8uLtiqu4WqdhWQ7rn6nsdAWcbrAhN4Ii1XRy+6g8GnE+15RJ86GszL
	TF0biueF28B9IFr3HcnuupknCr5/zOHuRG7J1P7nxfkt5pwGbvvsMIEnaYYUDP4N
	1yRhQDHX+UMIS75qt8tQkWdyINHD0hCyXPmPFi46A95OrTNmFTBkhBDmv9IxACw=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xautg14cb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 16:43:13 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A82D340045;
	Wed, 10 Apr 2024 16:43:09 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DF81F22AFEB;
	Wed, 10 Apr 2024 16:42:31 +0200 (CEST)
Received: from localhost (10.48.86.141) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 10 Apr
 2024 16:42:31 +0200
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
Subject: [PATCH] media: dt-bindings: media: add access-controllers to STM32MP25 video codecs
Date: Wed, 10 Apr 2024 16:42:22 +0200
Message-ID: <20240410144222.714172-1-hugues.fruchet@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02

access-controllers is an optional property that allows a peripheral to
refer to one or more domain access controller(s).

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


