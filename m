Return-Path: <linux-kernel+bounces-29942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E9B83158F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13E9F284613
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972431B978;
	Thu, 18 Jan 2024 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="JOxknQum"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902011F946;
	Thu, 18 Jan 2024 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705569133; cv=none; b=fNBlSFv2EUtGZz1iguA5Yv15ypldPZTidWSQr+sfh7101/dlkd85zYOVMMQ+ojwVT1GmljDQ+caWB/u61nHtfJYyeTf8P7x5GLOm841Ry2EB1I7rtZV115Z/TscK9O4OXOaCHgoSpDJOIezgiib9Yf3ynrhVL5tIgFjEplXCprc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705569133; c=relaxed/simple;
	bh=jTOMwYZYOjAXt29qPZUugCW1mNVTtziQZT6XubxjnG0=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Proofpoint-Virus-Version; b=EnUjo+TtLhPYP6Ef1JxaBxRber6Pxi4OkwL8d5y2miwcZxicOD8hXV/T3h6aaUS9CbfDY9aiLeKVrZtwGddbGL2R+UENTFCKc9rkJYdotMPMASUziokoqfP4SCaxFo9tRBLa9PpHP1idorsiecuC5o4s0YVPN5mMbG6lp/vMEx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=JOxknQum; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40I8U27e001957;
	Thu, 18 Jan 2024 10:11:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=LT44wAO
	mjaAsg0tliRvC01UNCZUXx9vWqUxQLz5cG+g=; b=JOxknQumFVqkmGPewGIFhcW
	VgEzl9Eyj6chqTZSrOBSfRA1tK6acLWSJWan3bLlFFCBXhacQiHEZfVZt8UKZ95s
	KC+fwOHOiNMlxOoYrrQGvUH1Cak3Wd8mf4fNNtzX6gDUL/6RSGpebg335Rxyjqyj
	463STz6RQ5YXkhOKX80Unal+0eFDnRJ0X5jPC/uxB1tfGujMwvBzv2uBZuG5cuoe
	4VKBb2nuzRPRetVkkUFDYcm2r9dIEm5iYYpZWEtRRT8y5x8qGgbUCQBKmdli4jnn
	UnDr+Vgx3GvpRz7+Sj3McIwGyl0zm9W3yUugwA0G8FE4/VM6MAhpLszbF8WI7yg=
	=
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vkmde7t9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 10:11:50 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BA15310007D;
	Thu, 18 Jan 2024 10:11:48 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 56946217B6B;
	Thu, 18 Jan 2024 10:11:48 +0100 (CET)
Received: from localhost (10.201.21.102) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 18 Jan
 2024 10:11:48 +0100
From: Valentin Caron <valentin.caron@foss.st.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Valentin Caron
	<valentin.caron@foss.st.com>
Subject: [PATCH v2] dt-bindings: serial: stm32: add power-domains property
Date: Thu, 18 Jan 2024 10:11:35 +0100
Message-ID: <20240118091135.3314330-1-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_04,2024-01-17_01,2023-05-22_02

STM32 serial may be in a power domain.
Allow a single 'power-domains' entry for STM32 serial devices.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
Since v1:
 - Change commit message after Krzysztof review

 Documentation/devicetree/bindings/serial/st,stm32-uart.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
index 1df8ffe95fc61..62f97da1b2fd7 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
@@ -58,6 +58,9 @@ properties:
 
   wakeup-source: true
 
+  power-domains:
+    maxItems: 1
+
   rx-threshold:
     description:
       If value is set to 1, RX FIFO threshold is disabled.

base-commit: 0c84bea0cabc4e2b98a3de88eeb4ff798931f056
-- 
2.25.1


