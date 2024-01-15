Return-Path: <linux-kernel+bounces-26147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B58282DBEF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BED521F22553
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9D817732;
	Mon, 15 Jan 2024 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kyuhyuk.kr header.i=@kyuhyuk.kr header.b="o0uB9/0f"
Received: from pv50p00im-ztdg10021901.me.com (pv50p00im-ztdg10021901.me.com [17.58.6.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D93175A6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kyuhyuk.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kyuhyuk.kr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kyuhyuk.kr; s=sig1;
	t=1705330433; bh=2+fJNK0tDVBz4TCLJ97mC6ABjRsY+gTG6ZoZy4vbqaw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=o0uB9/0fHpuxFGWEyCG906GLotIw53+8nd+k1lnBr8tFnBaPLjIB1W7kPQqA5TKY8
	 k8N2kqGiRAqQnzWw525lDfkeiDeeGTpP80NADBGV7c3+FCYbh7/+uOW9pZ5qO0yp6T
	 cBtDFXOmxK5aK+5CETeFGqVZ96htgaVU9OxyxRXNjxo0+5V8g9CgNi7DxJQ9e0kqGr
	 ZhFQLw00e2p3JOTrSIO2vuGvdi0Tj1H7ZMMGwKSv0KU2rKFcGPakQsUpplAPztWoAU
	 O3IIsDshanl8pHdQoDjALPtl+Wf6aSksesCzQECX5ybQHF3WeNgUPF1BMUmePZdgAG
	 6GZTEg77tIu0w==
Received: from KyuDevelop.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021901.me.com (Postfix) with ESMTPSA id 0E7428148E;
	Mon, 15 Jan 2024 14:53:47 +0000 (UTC)
From: KyuHyuk Lee <lee@kyuhyuk.kr>
To: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Tianling Shen <cnsztl@gmail.com>,
	Jagan Teki <jagan@edgeble.ai>,
	Ondrej Jirman <megi@xff.cz>,
	Andy Yan <andyshrk@163.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	KyuHyuk Lee <lee@kyuhyuk.kr>
Subject: [PATCH] dt-bindings: rockchip: Fix Hardkernel ODROID-M1 board bindings
Date: Mon, 15 Jan 2024 23:51:42 +0900
Message-Id: <20240115145142.6292-1-lee@kyuhyuk.kr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: niry3WWL1W0m_DapRYWwFycyjk25WHMD
X-Proofpoint-ORIG-GUID: niry3WWL1W0m_DapRYWwFycyjk25WHMD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-15_09,2024-01-15_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030 mlxlogscore=690
 phishscore=0 malwarescore=0 adultscore=0 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2401150109

The vendor in ODROID-M1 is hardkernel, but it was incorrectly written
as rockchip. Fixed the vendor prefix correctly.

Signed-off-by: KyuHyuk Lee <lee@kyuhyuk.kr>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 5cf5cbef2cf5..869abf6bcfe6 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -563,7 +563,7 @@ properties:
 
       - description: Hardkernel Odroid M1
         items:
-          - const: rockchip,rk3568-odroid-m1
+          - const: hardkernel,rk3568-odroid-m1
           - const: rockchip,rk3568
 
       - description: Hugsun X99 TV Box
-- 
2.34.1


