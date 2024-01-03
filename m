Return-Path: <linux-kernel+bounces-15799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB163823330
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D1B5B228E3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECD31C2A0;
	Wed,  3 Jan 2024 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="i176oH0k"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427021C283;
	Wed,  3 Jan 2024 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4037XSmF020422;
	Wed, 3 Jan 2024 09:28:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=1RB523u/YzFg6ojBTR5PfGAHwNn7BQfV7Lfr+ultk7I=; b=i17
	6oH0kJS+QBk/IYvdI6lLLppu6PdLqitmuCX+X12PqRPgWcnYVsCxtYqv2XnwA3wL
	9kYo8rxmTu6DB48s/693jywZCECOmqqU+nFnU+EvY2fEZqCPhHWEBxIei0mQfhYW
	U9XWFqaIz3k17t3PecfOOtxqDPIj1Fo7777h7hjmKMLH8NlbxJgf+V8o09pomkKR
	NG//MqKzQoGfpVj9QuSqUPLy2p4YaiL1DZ0SKz2rzfYkC2PnDzxeB2Aiq4Tzegb7
	4hsYTBxNFDmJ1jGAFPRGNJ+FPJrIroG9857LJQbRjW0u/jOtoP015fLZYuZ7pnBm
	5kXBzTzqH75hAxXH1rQ==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3vd39qadtu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 09:28:13 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 3 Jan
 2024 09:28:11 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 3 Jan 2024 09:28:11 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id 29F705B6931;
	Wed,  3 Jan 2024 09:28:07 -0800 (PST)
From: Elad Nachman <enachman@marvell.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>, <gregory.clement@bootlin.com>,
        <sebastian.hesselbarth@gmail.com>, <huziji@marvell.com>,
        <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <enachman@marvell.com>
Subject: [PATCH v2 1/2] dt-bindings: mmc: add Marvell ac5
Date: Wed, 3 Jan 2024 19:28:02 +0200
Message-ID: <20240103172803.1826113-2-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240103172803.1826113-1-enachman@marvell.com>
References: <20240103172803.1826113-1-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: NfWS2ua3aNYgD7XOY9qGhS1C9f2M5O7L
X-Proofpoint-GUID: NfWS2ua3aNYgD7XOY9qGhS1C9f2M5O7L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

Add dt bindings for Marvell AC5/X/IM eMMC controller.
This compatibility string covers the differences in the
AC5/X version of the driver: 31-bit bus limitation and
DDR memory starting at address 0x2_0000_0000, which are handled
by usage of a bounce buffer plus a different DMA mask.

Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 .../devicetree/bindings/mmc/marvell,xenon-sdhci.yaml          | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
index 3a8e74894ae0..cfe6237716f4 100644
--- a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
@@ -27,7 +27,9 @@ properties:
           - marvell,armada-ap806-sdhci
 
       - items:
-          - const: marvell,armada-ap807-sdhci
+          - enum:
+              - marvell,armada-ap807-sdhci
+              - marvell,ac5-sdhci
           - const: marvell,armada-ap806-sdhci
 
       - items:
-- 
2.25.1


