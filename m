Return-Path: <linux-kernel+bounces-20525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12924828025
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A44E28652C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2DB2575A;
	Tue,  9 Jan 2024 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="AwyWrXNA"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE42924B58;
	Tue,  9 Jan 2024 08:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 408JK6pe017620;
	Tue, 9 Jan 2024 00:10:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=E5WheNxtE7KIkYNksOdMvdibyOlZ+13KdYGfnetHwPQ=; b=Awy
	WrXNAPXBb0W7Im4Gl6sqniniX9gmj53NYvhRAtE/1qnAULgnjnguN+r4dWnTdTCH
	Kvle4UygkiGvX+/a2kWAwdkF0XnfxmWUbnlgfdeIViP7pH47WjBs0EyV9iFx61e5
	/BwmJw09jKvh07ilxy0U02f0Qub1zVvcji5kFk8+Vn5L9T0t0kJ2g2z608Sq24Ef
	B0YB8pANo8eenFYpnRFqr4SMkTakJNITa7Mq0AVEDKytbDWKcvGPzQbvz2JZQe+F
	5JIRlsFv/SrnRsVgoXq/mZsxXj0CQh2ezPhZuCuT1Fpq2nfxi97NxTbChDYbehHC
	3N9mpcEbU+4St/DetSw==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vgq4925uy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 00:10:52 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 9 Jan
 2024 00:10:51 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 9 Jan 2024 00:10:51 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id 025423F70AF;
	Tue,  9 Jan 2024 00:10:48 -0800 (PST)
From: Elad Nachman <enachman@marvell.com>
To: <gregkh@linuxfoundation.org>,
        rowland.harvard.edu@mx0a-0016f401.pphosted.com, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <enachman@marvell.com>
Subject: [PATCH v3 1/2] dt-bindings: usb: Add Marvell ac5
Date: Tue, 9 Jan 2024 10:10:43 +0200
Message-ID: <20240109081044.10515-2-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240109081044.10515-1-enachman@marvell.com>
References: <20240109081044.10515-1-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: BSuS_OcrTzHOJE1wFxQSAditxEzjXMpy
X-Proofpoint-ORIG-GUID: BSuS_OcrTzHOJE1wFxQSAditxEzjXMpy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

Add Marvell ac5 device tree bindings to generic EHCI.
This compatible enables the Marvell Orion platform code
to properly configure the DMA mask for the Marvell AC5 SOC.

Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 Documentation/devicetree/bindings/usb/generic-ehci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/generic-ehci.yaml b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
index 87986c45be88..2ed178f16a78 100644
--- a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
@@ -77,6 +77,7 @@ properties:
           - const: usb-ehci
       - enum:
           - generic-ehci
+          - marvell,ac5-ehci
           - marvell,armada-3700-ehci
           - marvell,orion-ehci
           - nuvoton,npcm750-ehci
-- 
2.25.1


