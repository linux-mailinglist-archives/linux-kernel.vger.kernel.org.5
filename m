Return-Path: <linux-kernel+bounces-75241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7F885E518
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24304B2569D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4612B8526A;
	Wed, 21 Feb 2024 17:58:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803E785264
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708538307; cv=none; b=htBqWHXyjcWXkbNH/jmNicM3ZFrvUp6ARalYp5gtgqQId33KIs5rNzqjGJc7EJDnPuxTQnNOBnQTURzYjwW3z0g4TSyn/itIF1/8tSxXGXMcWIR4f77XMQ2as416u+V0HpNfApBtVjPrTNsmYHTvJJ4r1AGs+5xQgBeizCsaiaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708538307; c=relaxed/simple;
	bh=SDXjqB4wIG3XnhyFFBnM6Pd3RHudSe6ZGddZfgcxJrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oGOozsIMsknVWZ72ygVXvoga2owAVHqVqikV4UNMmX6xahfbuqQWGdUIkd/dM79aY92OANVp5NkyWP9CgAE65dCjS5q1VNZHQEOanDUkC8XDU16l5UIXPEt0+T62BQb/tZ5RUaaDebRjDBubIZpt9RjBxhDhZHoXxmzeJ7F4kIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1rcqrF-00046q-LD; Wed, 21 Feb 2024 18:58:13 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	denis.ciocca@st.com,
	linus.walleij@linaro.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] dt-bindings: iio: st-sensors: Add IIS2MDC magnetometer
Date: Wed, 21 Feb 2024 18:58:10 +0100
Message-Id: <20240221175810.3581399-1-m.felsch@pengutronix.de>
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

Add the iis2mdc magnetometer support which is equivalent to the lis2mdl.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
index fff7e3d83a02..ee593c8bbb65 100644
--- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
+++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
@@ -64,6 +64,7 @@ properties:
           - st,lsm9ds0-gyro
       - description: STMicroelectronics Magnetometers
         enum:
+          - st,iis2mdc
           - st,lis2mdl
           - st,lis3mdl-magn
           - st,lsm303agr-magn
-- 
2.39.2


