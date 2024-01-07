Return-Path: <linux-kernel+bounces-18891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 765F68264B5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 16:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E35E1C213C2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 15:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29CF13AC8;
	Sun,  7 Jan 2024 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ymf4zCPK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE91134BE;
	Sun,  7 Jan 2024 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 407EvqbT029122;
	Sun, 7 Jan 2024 07:26:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=E5WheNxt
	E7KIkYNksOdMvdibyOlZ+13KdYGfnetHwPQ=; b=Ymf4zCPKtJp3L3WPIFv8GrQN
	lQ9H5VchrHDrG/uQFN4KKxM/Bs4prtajI398Xs4zVo3fL43nexFpRoDOWZIjg0js
	1fSu+keVFf742Tou4MNUB2axDu7OUBXNw97vtX7J4mIx/EIo7sc3fu64ulTuuUII
	QGHflJrMgafwbM9DnWS6RN9XYVLz1yAO6Tw44e3xPjHeYAi9Smgr9lpGm4/sbG0N
	OXjUE5sRZ57f2D2I1F0kGwVpqT2Iv7mPRcfgf/vrB+7MYy4ovlkjyn29ZBc7Ic1Z
	sSLh5SvwEbuUAFYyoaSYUle5yPY1NSS6SbtI+IaGccpiYtp8fFkKsnB4lMZQBg==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3vf78n29jm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Sun, 07 Jan 2024 07:26:04 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 7 Jan
 2024 07:26:02 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 7 Jan 2024 07:26:02 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id 6EC373F7093;
	Sun,  7 Jan 2024 07:26:00 -0800 (PST)
From: Elad Nachman <enachman@marvell.com>
To: <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <enachman@marvell.com>
Subject: [PATCH] dt-bindings: usb: Add Marvell ac5
Date: Sun, 7 Jan 2024 17:25:57 +0200
Message-ID: <20240107152557.3561341-1-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Y5RTahJgokMjyWMMpqEtt-U1bWBPK9sI
X-Proofpoint-GUID: Y5RTahJgokMjyWMMpqEtt-U1bWBPK9sI
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


