Return-Path: <linux-kernel+bounces-75210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A39985E4C7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3541A1F21EBD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D97883CC7;
	Wed, 21 Feb 2024 17:43:26 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338A683CD0
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537405; cv=none; b=SclC4s9kz4Qm+h+JpzaoI3mU8wFXhQ3G2JKSasknWY8ZiXes6jMgy+NOKy/t7O0IEv1l6i2fdEQkdpB5gjlLDRUb1S/cacyBpQBa2qlGeFpZ2GrAOzi3VmQ7bI9cOkKkSzvNptTnM7a4tBpOJgvx4Scl2yqFcenFelY2KQqmDwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537405; c=relaxed/simple;
	bh=x1whNrwYpej7zBfBOVkC3JBgqGT5iobnkHLXgVKm50M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eTnUWCcyJGBlbvz3eJNZjwo41K9meL/9V6ivcqH4bO6j0OYdAoVRWzeJQd6uEUxJLh/4vyB/3GpLeCqM9F9cLSbBPEqFDYLtsmQM4PqsbjoOP1wrpoQbcOR2eg32St9vx2eTXQ5BttUg4iD+W01QukhChpkWE/vuaSMV+gzN1CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1rcqcd-0001Z2-FM; Wed, 21 Feb 2024 18:43:07 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	hns@goldelico.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] dt-bindings: iio: gyroscope: bosch,bmg160: add spi-max-frequency binding
Date: Wed, 21 Feb 2024 18:43:05 +0100
Message-Id: <20240221174305.3423039-1-m.felsch@pengutronix.de>
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

Make use of the common spi-peripheral-props.yaml to pull in the common
spi device properties and limit the spi-max-frequency to 10 MHz as this
is the max. frequency if VDDIO >= 1.62V.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 .../devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml   | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
index 1414ba9977c1..3c6fe74af0b8 100644
--- a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
+++ b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
@@ -22,6 +22,9 @@ properties:
   vdd-supply: true
   vddio-supply: true
 
+  spi-max-frequency:
+    maximum: 10000000
+
   interrupts:
     minItems: 1
     maxItems: 2
@@ -33,7 +36,10 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.39.2


