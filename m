Return-Path: <linux-kernel+bounces-154363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2284F8ADB3F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC35E1F22824
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5551799D;
	Tue, 23 Apr 2024 00:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="fZRU8iHZ"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064D917997;
	Tue, 23 Apr 2024 00:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713833034; cv=none; b=apK2r3C/ofRtK8RQ5wvGh+2jca7C+Y0k7mYY3+WIJRZrM6J1aryiaGgT23E0vDBTkVRPiX0zn71eHtD/zSMm4vaZ1Ic/KC/ToS3CE+eqUilyON1xx0QjnNer86JY4GByqlGo0o+XQwyhKKl6NCUct1jmuByySXbYgS8M2OuPCvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713833034; c=relaxed/simple;
	bh=oYSTZRwKWip2C4r+s1bPD+PUIT9VGUTKKbKRVqvibZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uMy1Hh+G+2NFyuk7YRfvq5rmjCo7g7oa0YdDndgXADLgE6lurZtdnuwDysaM+UtynmZibLkUxyDfDXVmFs+ycDZdUNrwIPuf3XCWdcio3gu7t25n3JFXeA2EnRRN2uiLtkLjDMFFskDvrTEzhQAko0U32CNjIRKR67aaczXiOHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=fZRU8iHZ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713833029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=92Gzeso2RKfoZWJr3QPWn/Gt5fFc0yQVUDOpR1xpRaY=;
	b=fZRU8iHZ9RDxDFHJEoLpOjfdy5jYPfdNZZ73gYjtZyt6K5/zsV+rT+hNCTqLIeJcOoCxW9
	0RfvMbFh9QN6ZB3Evqsekns+sOPWW1CAjv1M+eVWZl9cjk9C9gObwfnwJOElBRbaF8FEXs
	/bnD9z2UJ9Pks7KkMo83mPkdNL62k2UX/ylSSndWWCdRCTNpSFfwzy9hwANNrdUsnhZIVj
	b1VVF2TR2BMjEmlDYwyqCGVFcfz8BOl0eQtFAKCgG/jIivm4yL+a2mGPhDSsypxQjS7vQM
	mx95oKhKxODQSBfh1MrKiIsWCEXor+Lpukz4Kn//4w/q77mH000uHuf+uBN9hA==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	didi.debian@cknow.org,
	Marek Kraus <gamiee@pine64.org>
Subject: [PATCH 1/2] dt-bindings: arm: rockchip: Correct the descriptions for Pine64 boards
Date: Tue, 23 Apr 2024 02:43:43 +0200
Message-Id: <ec124dab2b1a8776aa39177ecce34babca3a50e2.1713832790.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Correct the descriptions of a few Pine64 boards and devices, according
to their official names used on the Pine64 wiki.  This ensures consistency
between the officially used names and the names in the source code.

Cc: Marek Kraus <gamiee@pine64.org>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    This continues the description cleanup started with Radxa boards. [1]
    
    [1] https://lore.kernel.org/linux-rockchip/1e148d6cd4486b31b5e7f3824cf6bccf536b74c0.1713457260.git.dsimic@manjaro.org/

 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index fcf7316ecd74..120db82ec4c2 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -631,20 +631,20 @@ properties:
           - const: phytec,rk3288-phycore-som
           - const: rockchip,rk3288
 
-      - description: Pine64 PinebookPro
+      - description: Pine64 Pinebook Pro
         items:
           - const: pine64,pinebook-pro
           - const: rockchip,rk3399
 
       - description: Pine64 PineNote
         items:
           - enum:
               - pine64,pinenote-v1.1
               - pine64,pinenote-v1.2
           - const: pine64,pinenote
           - const: rockchip,rk3566
 
-      - description: Pine64 PinePhonePro
+      - description: Pine64 PinePhone Pro
         items:
           - const: pine64,pinephone-pro
           - const: rockchip,rk3399
@@ -682,7 +682,7 @@ properties:
           - const: pine64,quartzpro64
           - const: rockchip,rk3588
 
-      - description: Pine64 SoQuartz SoM
+      - description: Pine64 SOQuartz
         items:
           - enum:
               - pine64,soquartz-blade

