Return-Path: <linux-kernel+bounces-3975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43712817644
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D5FA2810BA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ACC5A842;
	Mon, 18 Dec 2023 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="M/wfuq7B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C1E4FF9F;
	Mon, 18 Dec 2023 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIA66lc016883;
	Mon, 18 Dec 2023 07:44:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=uRAGf5/K1wV9MPPyw6Mk/rMZMpd4u2h8Kh7tH3WPKXQ=; b=M/w
	fuq7BRV4EWdpQvNTu0iF+n9QBO3dkL5JCtPgI858qSIWNnokzvN32nZUVu48F1gb
	zNy6w5i0u60yxU+HPO5Rcq9MEz/cUSXFf26ySQoQLU6lIbXz0dOnhVDaqiI3veio
	lMTjaczjtdd7OTn8zuv27U8dc202SzSaV1zeDfDcAcq3auz4ryy5XLVirnraKklh
	MuomFBwWJgcvp/AgL6ZNS0j7+sbJJr6D5oEVkYl/yf2ZCpMHAzYX0MF2fe0nkTfF
	iBuucUxKh2L6xqHVVwgDELNNQKLDbLx2rK//MPqwLe/X7epdLwNl1vFBsPoYnLnh
	xaW3/Z9mPe3BDB+sa6Q==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3v1c9kpqds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 07:44:50 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 18 Dec
 2023 07:44:48 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 18 Dec 2023 07:44:48 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id F26313F7051;
	Mon, 18 Dec 2023 07:44:44 -0800 (PST)
From: Elad Nachman <enachman@marvell.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>, <gregory.clement@bootlin.com>,
        <sebastian.hesselbarth@gmail.com>, <pali@kernel.org>,
        <mrkiko.rs@gmail.com>, <chris.packham@alliedtelesis.co.nz>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <enachman@marvell.com>, <cyuval@marvell.com>
Subject: [PATCH 1/2] dt-bindings: arm64: add Marvell 7k COMe boards
Date: Mon, 18 Dec 2023 17:44:30 +0200
Message-ID: <20231218154431.3789032-2-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218154431.3789032-1-enachman@marvell.com>
References: <20231218154431.3789032-1-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: owqvVCbnc2-1-dVtTmlKg8RQ8OKgeJUc
X-Proofpoint-GUID: owqvVCbnc2-1-dVtTmlKg8RQ8OKgeJUc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

Add dt bindings for:
Armada 7020 COM Express CPU module
Falcon DB-98CX85x0 COM Express type 7 Carrier board
Falcon DB-98CX85x0 COM Express type 7 Carrier board
with an Armada 7020 COM Express CPU module

Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 .../devicetree/bindings/arm/marvell/armada-7k-8k.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
index 52d78521e412..24d8031a533d 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
@@ -21,6 +21,17 @@ properties:
           - const: marvell,armada-ap806-dual
           - const: marvell,armada-ap806
 
+      - description:
+          Falcon (DB-98CX85x0) Development board COM Express Carrier plus
+          Armada 7020 SoC COM Express CPU module
+        items:
+          - const: marvell,armada7020-falcon-carrier
+          - const: marvell,db-falcon-carrier
+          - const: marvell,armada7020-cpu-module
+          - const: marvell,armada7020
+          - const: marvell,armada-ap806-dual
+          - const: marvell,armada-ap806
+
       - description: Armada 7040 SoC
         items:
           - const: marvell,armada7040
-- 
2.25.1


