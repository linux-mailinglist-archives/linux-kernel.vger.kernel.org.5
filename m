Return-Path: <linux-kernel+bounces-66486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC35855D61
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 298611C29CCE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF0B1759C;
	Thu, 15 Feb 2024 09:05:11 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5F4171A7;
	Thu, 15 Feb 2024 09:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707987910; cv=none; b=gJf9lHEfxdxItbbpxPz5QCF8q4No8c7AF9hXcyGgFIOoUr0TKGcVsGsY1MFg9liH8y9Il64PHxi7IKGvXTmjCi/sv0W1RSJHKLVXQBNNj4CQxTCSyCPt8DzLqjRIUbxLPks4ws4TQ9etSduIHyAB490FBK4sJ21LfN4vsBqs4FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707987910; c=relaxed/simple;
	bh=mK2XIGIGGN3r4jmKbz0on/M6QGPvYXqiPq2RBv11Xv8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DYrZaG6ntbA1C7AfOj9XH5rPO3Y8G2GuKJTgTxmFuIXJ1dCvt4sBiy259Zgh4nF7ie7BqLnBoNT863ocKyoshbrBa+CeuJug+rM5IDBhzlBlGOblYyX+0SWPPn56KNEleyXmdJx0pptJ7EGOf5FuCr0XK3izstSQzl0YdJWk/KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6c.versanet.de ([83.135.91.108] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1raXfh-0002L8-3L; Thu, 15 Feb 2024 10:04:45 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: neil.armstrong@linaro.org
Cc: quic_jesszhan@quicinc.com,
	sam@ravnborg.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@theobroma-systems.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 1/2] dt-bindings: vendor-prefixes: add prefix for admatec GmbH
Date: Thu, 15 Feb 2024 10:04:41 +0100
Message-Id: <20240215090442.3513760-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

admatec GmbH is a german supplier for industrial displays.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 1a0dc04f1db47..fef2e12b504ee 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -61,6 +61,8 @@ patternProperties:
     description: Analog Devices, Inc.
   "^adieng,.*":
     description: ADI Engineering, Inc.
+  "^admatec,.*":
+    description: admatec GmbH
   "^advantech,.*":
     description: Advantech Corporation
   "^aeroflexgaisler,.*":
-- 
2.39.2


