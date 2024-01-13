Return-Path: <linux-kernel+bounces-25339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B02A782CDEA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 18:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F37F1F223FC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 17:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E97A538A;
	Sat, 13 Jan 2024 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kyuhyuk.kr header.i=@kyuhyuk.kr header.b="AETQMjxv"
Received: from pv50p00im-ztdg10021901.me.com (pv50p00im-ztdg10021901.me.com [17.58.6.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B525231
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kyuhyuk.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kyuhyuk.kr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kyuhyuk.kr; s=sig1;
	t=1705166936; bh=Ncm/r4hpmcrpUhX1fSR5itLc4xrV7NoGJc5rt7JL7Tk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=AETQMjxvQQErbY/lyVVbUU9dD1xPLM3nvimfEzzmbmeH6FLrS1lOzpI6foZeUMm76
	 0zpgHM0NKLBKwi5k3kY790IdIBAne+Ot/mHhAHFOCTr5KkVqu+pdz1+muGiP9x3tLN
	 dnxwNFbF0halDD5Hkex4vr2AOvzA8O/k7J9m+AJZ7qS1TznxA6tBeV5tfBWbrQ2L2F
	 ucmMAgC7NQANWVL7ab3pDjCxjmGDyE3ZiFZhSyWAxojmZCf5+PEiOgHF02tOE90NJ0
	 8t8Gua0FNFhBgkiYchSpcjH4ZzxGOXuRpW2Vkfo1KNCN8+WhoNzOIZLy/Q9jnu4uFn
	 ecItlGyztNdPg==
Received: from KyuDevelop.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021901.me.com (Postfix) with ESMTPSA id C3CC9813EB;
	Sat, 13 Jan 2024 17:28:52 +0000 (UTC)
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
Subject: [PATCH v2] dt-bindings: rockchip: Add Hardkernel ODROID-M1S board
Date: Sun, 14 Jan 2024 02:21:03 +0900
Message-Id: <20240113172102.6890-1-lee@kyuhyuk.kr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: s5LNHj3FkFfaIArGgtvgU_W7ExD_8Rdg
X-Proofpoint-GUID: s5LNHj3FkFfaIArGgtvgU_W7ExD_8Rdg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-13_07,2024-01-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=735 mlxscore=0 adultscore=0 suspectscore=0 clxscore=1030
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2401130147

Add device tree binding for Hardkernel ODROID-M1S board based on
RK3566 SoC.

Signed-off-by: KyuHyuk Lee <lee@kyuhyuk.kr>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 5cf5cbef2cf5..9a65f7269a27 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -566,6 +566,11 @@ properties:
           - const: rockchip,rk3568-odroid-m1
           - const: rockchip,rk3568
 
+      - description: Hardkernel Odroid M1S
+        items:
+          - const: hardkernel,rk3566-odroid-m1s
+          - const: rockchip,rk3566
+
       - description: Hugsun X99 TV Box
         items:
           - const: hugsun,x99
-- 
2.34.1


