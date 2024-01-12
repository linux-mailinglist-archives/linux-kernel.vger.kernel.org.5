Return-Path: <linux-kernel+bounces-24702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DD682C109
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514F51C22552
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950F16D1B1;
	Fri, 12 Jan 2024 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kyuhyuk.kr header.i=@kyuhyuk.kr header.b="JdOrSWU8"
Received: from pv50p00im-ztdg10021901.me.com (pv50p00im-ztdg10021901.me.com [17.58.6.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3EF6D1A3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kyuhyuk.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kyuhyuk.kr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kyuhyuk.kr; s=sig1;
	t=1705067103; bh=hV9qahS+iLpFfTt/jCTDYwSpdiQY5P5vsdWDuLj9MLQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=JdOrSWU8LKMGis1slhHmacEUzW9c1V06PwvhcQku07Nhny6Ausiv6DwWiVAKDu45l
	 gsMLvXXNNzHxVB+Zf8LcDgFRHzz8eSpu/8VtXH1by7iLpM52vO3Yw5L0boRXzB1bnM
	 eWr4MGbksIEMtrxHVebkGmwLbqpVtm9mfRS80S3csTkFjFNdjJ8aodbXHmgrlGsgEM
	 5aL0Y0gxLAVsNOTQIidkZEP96l6aALBhv0TiesYB/wExMBVFRzECwQ+/mBEVdkCG8l
	 e6cqr8JFUaDr0er2JZLcBJgT8nE83uJNSMECrv5RAE6CFBNysa2WCCa+tZmXMBNR/e
	 TnuS6x0rPtlTg==
Received: from KyuDevelop.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021901.me.com (Postfix) with ESMTPSA id A568781300;
	Fri, 12 Jan 2024 13:44:59 +0000 (UTC)
From: KyuHyuk Lee <lee@kyuhyuk.kr>
To: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Jagan Teki <jagan@edgeble.ai>,
	Tianling Shen <cnsztl@gmail.com>,
	Andy Yan <andyshrk@163.com>,
	Ondrej Jirman <megi@xff.cz>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	KyuHyuk Lee <lee@kyuhyuk.kr>
Subject: [PATCH 1/2] dt-bindings: rockchip: Add Hardkernel ODROID-M1S board
Date: Fri, 12 Jan 2024 22:42:30 +0900
Message-Id: <20240112134230.28055-1-lee@kyuhyuk.kr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: o5eyssMOQI5Rn3uKiJiv6EYvTWZZTMXt
X-Proofpoint-ORIG-GUID: o5eyssMOQI5Rn3uKiJiv6EYvTWZZTMXt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-12_06,2024-01-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 clxscore=1030 suspectscore=0 bulkscore=0 adultscore=0
 mlxlogscore=800 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2401120108

Add device tree binding for Hardkernel ODROID-M1S board based on
RK3566 SoC.

Signed-off-by: KyuHyuk Lee <lee@kyuhyuk.kr>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 5cf5cbef2cf5..cc37d2118131 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -566,6 +566,11 @@ properties:
           - const: rockchip,rk3568-odroid-m1
           - const: rockchip,rk3568
 
+      - description: Hardkernel Odroid M1S
+        items:
+          - const: rockchip,rk3566-odroid-m1s
+          - const: rockchip,rk3566
+
       - description: Hugsun X99 TV Box
         items:
           - const: hugsun,x99
-- 
2.34.1


