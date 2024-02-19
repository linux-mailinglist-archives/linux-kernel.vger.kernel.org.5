Return-Path: <linux-kernel+bounces-71383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E963E85A46C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939901F2382F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE79736138;
	Mon, 19 Feb 2024 13:11:32 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C59836121
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708348292; cv=none; b=qEf0VM6oxEDOv7jiZv8elFBpUgch8mA0/d20SdZeinKaW6QuX8P2/lD/NmAs+Amfh+5Z/SpriZR9tylVj0eZWWjj9csPSRciw2T8SCDa2+lDUt5zeDKjRaFYoDbT6Y178+NsCkkDXE/n5fXTCf9BfhXK8OBYB1R7ygQse7SpWac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708348292; c=relaxed/simple;
	bh=TvR5U9f4990NVUGBUfBdVxKWjB8M/3nA9XEJ9d2pcvg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sinz4D+6zS2eBopBRAqqAGX5+VTlmdqHxfGBtn5Tgfzk7zZa1yq1uxbtxM9XZ6fug33MAcjTUMIne5XPhAzhnnbbQnetxe5CyyaKuzzW/94pqDO2dyTjCsiVfTKe84eNR9Knjo7QhK12reiX9KXuZ1pmYeWE2tTSKmzSH9Ioen4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1rc3QT-0005bN-Lc; Mon, 19 Feb 2024 14:11:17 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: puranjay12@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v2 1/2] dt-bindings: iio: ti,tmp117: add vcc supply binding
Date: Mon, 19 Feb 2024 14:11:13 +0100
Message-Id: <20240219131114.134607-1-m.felsch@pengutronix.de>
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

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
v2:
- mark vcc-supply as required

 .../devicetree/bindings/iio/temperature/ti,tmp117.yaml       | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
index 8c6d7735e875..33f2e9c5bd81 100644
--- a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
@@ -24,9 +24,13 @@ properties:
   reg:
     maxItems: 1
 
+  vcc-supply:
+    description: provide VCC power to the sensor.
+
 required:
   - compatible
   - reg
+  - vcc-supply
 
 additionalProperties: false
 
@@ -39,5 +43,6 @@ examples:
         tmp117@48 {
              compatible = "ti,tmp117";
              reg = <0x48>;
+             vcc-supply = <&pmic_reg_3v3>;
         };
     };
-- 
2.39.2


