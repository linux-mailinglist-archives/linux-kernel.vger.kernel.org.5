Return-Path: <linux-kernel+bounces-108798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6549888101A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE33283B09
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FD83BBF7;
	Wed, 20 Mar 2024 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="QwZCousJ"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A763BB4F;
	Wed, 20 Mar 2024 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710931235; cv=none; b=JfvcZIMx/R0Gt1kcDRPdS5dt1XP8tC6axGwoyI3GLmfhu3H47mzL/PIGB5waj72IDGPQ2Q/BD8MHVYkOtrNatbKV2YqFt2/8iffUAdlDAhfHWsu7tVNlU8yFzq38q+gtDrvSTatTzk7NsWFMiYtvU/UdLkArLwFWejmm/Kke0jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710931235; c=relaxed/simple;
	bh=R8fTGH9OWGPMs9dIN2Cm0WFP0y0lgeZLVmVYPrCVwSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uY6EZVKBELxJcxZTE6vcMa6Ig/03/Eaui/JqLGxYZADIPzhy5Ia23dUGEOCqTxJ7SeP9Rqgajo59ES5R57SEjOyxyxis2K7kOsmBAVigmWq0omxxnwmU0pLjMHKTpMxMN0mBXzFPQnMHl9updPv4J8tKb6gbPl08OSC+DWDv5UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=QwZCousJ; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=brVvifDkJB4+mWvFeTvzWiEvVdd6+g5oyJp8fuUKCZc=; b=QwZCousJRw5qU30TISjc8Lk19f
	818/2S46S5WaeIs8rpvdGZZCe0/0kk8CyHKr5lDkyhlXUwnsAacbxuJElzuvN8bBDcCLI94ghTJWs
	05A1VCZVddNtAqRMjoNAtdvOa4pG9xDeLelO3vm0sSx3dtlDwxXIt3nvmja81jk3VT04uWWmeBfT4
	ANyB3I8cib3eKMmQm2rJtfTm43rwCJwzSpq1kKOwt4a+W4ypXpf6sLq3CN3/q/X6hLf+TdVZcay6s
	Wgs8twucDjT+Qc4zWcIJTd8yNydrVEIjSMPRTYybRisNdAiCMQ7vzKCUckbDwuKwtLAwpKjt+FgbN
	HaSygMWA==;
Received: from [89.212.21.243] (port=57750 helo=localhost.localdomain)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1rmsnx-005Tm8-1J;
	Wed, 20 Mar 2024 11:04:17 +0100
From: Andrej Picej <andrej.picej@norik.com>
To: haibo.chen@nxp.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH 2/2] dt-bindings: iio: adc: nxp,imx93-adc.yaml: Add calibration properties
Date: Wed, 20 Mar 2024 11:04:06 +0100
Message-Id: <20240320100407.1639082-3-andrej.picej@norik.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240320100407.1639082-1-andrej.picej@norik.com>
References: <20240320100407.1639082-1-andrej.picej@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Document calibration properties and how to set them.

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
 .../bindings/iio/adc/nxp,imx93-adc.yaml           | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
index dacc526dc695..64958be62a6a 100644
--- a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
@@ -46,6 +46,21 @@ properties:
   "#io-channel-cells":
     const: 1
 
+  nxp,calib-avg-en:
+    description:
+      Enable or disable averaging of calibration time.
+    enum: [ 0, 1 ]
+
+  nxp,calib-nr-samples:
+    description:
+      Selects the number of averaging samples to be used during calibration.
+    enum: [ 16, 32, 128, 512 ]
+
+  nxp,calib-t-samples:
+    description:
+      Specifies the sample time of calibration conversions.
+    enum: [ 8, 16, 22, 32 ]
+
 required:
   - compatible
   - reg
-- 
2.25.1


