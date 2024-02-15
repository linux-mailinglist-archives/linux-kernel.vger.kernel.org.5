Return-Path: <linux-kernel+bounces-67666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D68856ED5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8F371C230DF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F1913B7BC;
	Thu, 15 Feb 2024 20:48:07 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C9D13AA39
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 20:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708030087; cv=none; b=GonqZKxEAZBMuABSH6/eTVuM/leodYS3Zpx+ch19S9XgiWQWxqLsqBkyp5j2WOPeNv08kUed8fYvF5laIIEljVz0xu2XTvbTAMXeSS/2H6HhsRbOvCPAg6ja4vVj94N7WyTxoJZM5L5pQYKg0nQO+03JGsMvyZ4cq5RicqugBrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708030087; c=relaxed/simple;
	bh=+jo9igZ8eH78xZ54jxpf7OZVLWMsv/b4wz2mLjajbvA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NC/y7nKgjXe83Whk39uiXtRAHyjZi5y8Gs9Dwtjs0HudNpiigD1TtbZ1Jf47qDStktGf5r0uD1lQkR9ItWJhi6ShDXQJJ94rzmtmVUoVRSp+/GQ+rPYCd+eMp6IqMzFxF5I3rlwTjrCngARugWozJ1vydRzX7LBfVGkZ49qKznY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1raie7-0007Dj-GX; Thu, 15 Feb 2024 21:47:51 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: puranjay12@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de
Cc: thomas.haemmerle@leica-geosystems.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 1/2] dt-bindings: iio: ti,tmp117: add vcc supply binding
Date: Thu, 15 Feb 2024 21:47:45 +0100
Message-Id: <20240215204746.1197619-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

From: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>

Add the binding to specify the vcc supply. We can't make it required
since this would break the backward compatibility.

Signed-off-by: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 .../devicetree/bindings/iio/temperature/ti,tmp117.yaml        | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
index 8c6d7735e875..cf7799c9734f 100644
--- a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
@@ -24,6 +24,9 @@ properties:
   reg:
     maxItems: 1
 
+  vcc-supply:
+    description: provide VCC power to the sensor.
+
 required:
   - compatible
   - reg
@@ -39,5 +42,6 @@ examples:
         tmp117@48 {
              compatible = "ti,tmp117";
              reg = <0x48>;
+             vcc-supply = <&pmic_reg_3v3>;
         };
     };
-- 
2.39.2


