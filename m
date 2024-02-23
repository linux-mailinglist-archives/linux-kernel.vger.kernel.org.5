Return-Path: <linux-kernel+bounces-78525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B9186147C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03FF1C22FDE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4829D22625;
	Fri, 23 Feb 2024 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ZjSFeM1o";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="t846zh2x"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635E36FB9;
	Fri, 23 Feb 2024 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699687; cv=none; b=SpPdDlN+vqmvj8JF6Eu0vp5tvY4TOhX7IkNp+mgZMJuvN2f6iQVcA7xumbIuel2FSqFgmOnVuCI6oVDALImNS17/bfl0XF13YKuUsJl//hOqH/zA4dYcnVCJtYtds4QgRjqtrfXhkQO/al6f6t0uIn8x8NecLTCd4vf8UYIxL2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699687; c=relaxed/simple;
	bh=pL7KXR81eDMm26eIe1ED+Arr5NqgGiHdTsQRyfhEa9c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ir/Jzd8UOoOtSAAqF3XLu/JD4ogI0nYDRggHeHOQWSxnQyND7yf4DKKEvJI/KrGQRd2hHmrG6iw8on8lLjMoZv4wVzKXt1cK1yLl89HT9YPxiu4z9oAWfji7d/Fpu/ZhznqdqUJl/Kie5/1smo4zIo7bTEX/x+RDlMCOO57Cj8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ZjSFeM1o; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=t846zh2x reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1708699684; x=1740235684;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Lv48sZ5mNYZHRwdFnp2DUz9KXOf0oXY3HERuDKla/+U=;
  b=ZjSFeM1oAwCZQZGmG/VRHfop/a0K6Zgs30mKnDPWwPXEKv2bc4jUv2v8
   W/xOIxgAry6XnU2pgTpjwmi7lOcDsy0hHfIQ6QSDQmtEB2RnHkP0Xx8pf
   isqfp4HId24RP83Lc7lrk+rfq2ogEbSYgvGlUm1BLsLIBFvdspOG+6AiM
   8SanNdD+Y9oxdJZ6UW1Fj6czm6j4m3Tdo2fbcEcNyg6YoP+eeF/JlAoDA
   vluVOXS/WO3x645lJ/6z6Xzi2BKWQZzCDr+c4Kzy+HPHwGIp3DITnkvU5
   yi6R3V7ReoX7+0IgSui27xPw1LhkNZziUC19GjG5OCxZ9r7WuPXpc1I0j
   w==;
X-IronPort-AV: E=Sophos;i="6.06,180,1705359600"; 
   d="scan'208";a="35570387"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 23 Feb 2024 15:48:01 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 99C261706D7;
	Fri, 23 Feb 2024 15:47:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1708699676; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=Lv48sZ5mNYZHRwdFnp2DUz9KXOf0oXY3HERuDKla/+U=;
	b=t846zh2x+N/zHy4NkQRRc3Ym9s4x5hHuH4YIvWJqEBhdkmMXBbVSoIXa/u2sUhWcPghPrv
	vYSRPoqAmHp8BpKuf/QBWHYYACUERO/EcGeVDLNad4ZQk8JcW+r8GcmDgMh6umls8kA5nq
	JsWYqx+t8XLJpRybwsCymTbF/KKFyx+YI2h4r6F88g5WUkTe1hClUnns9YvBkvcDLraR0+
	FhYeXBtugkPWRGSf55dOUD/qUGkUbVHQy8TsBn8xyKlvnw9X1WnroCGYaZoMfOiCwJu+V6
	4C4+HR3alolKKHQ+UD9Eol5A8oO3IuS5Iqc3gXEkkq0suePVo/IH0mjzTd4VLw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] media: dt-bindings: sony,imx290: Allow props from video-interface-devices
Date: Fri, 23 Feb 2024 15:47:41 +0100
Message-Id: <20240223144746.2583749-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Allow properties from video-interface-devices. This aligns the bindings
to sony,imx415.yaml. Changes inspired by commit e2e73ed46c395 ("media:
dt-bindings: sony,imx415: Allow props from video-interface-devices")

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v2:
* Use absolute path to other schemas

 Documentation/devicetree/bindings/media/i2c/sony,imx290.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx290.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx290.yaml
index a531badc16c98..bf05ca48601ab 100644
--- a/Documentation/devicetree/bindings/media/i2c/sony,imx290.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/sony,imx290.yaml
@@ -23,6 +23,9 @@ description: |-
   is treated the same as this as it was the original compatible string.
   imx290llr is the mono version of the sensor.
 
+allOf:
+  - $ref: /schemas/media/video-interface-devices.yaml#
+
 properties:
   compatible:
     oneOf:
@@ -101,7 +104,7 @@ required:
   - vdddo-supply
   - port
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1


