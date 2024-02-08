Return-Path: <linux-kernel+bounces-57728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F4B84DCC3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7646A2810E4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC5C7316A;
	Thu,  8 Feb 2024 09:21:39 +0000 (UTC)
Received: from esa1.ltts.com (unknown [118.185.121.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC276D1BB;
	Thu,  8 Feb 2024 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.185.121.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384099; cv=none; b=q6qrO7NtWs7a5IK1+whbuE9qCdBQxBzOrHxb4mDVupEZAUy7d93l8N2mItDw39sig7CgSYUhVoUCqGAI4IjMH7Jv49L/ZnKjSN3kjGFZWs4FnEIiUO+EFschOeRM0/rK/iSFG7Uq/uANaMeTj3JZY9qDhobP2Ll28I/VP7pJSSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384099; c=relaxed/simple;
	bh=1Zn0pbl+Us/lPLFf385YwPJy/pjFtQA4GG45Zc7JrJM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q4PeRKhnTZcCqqY/pS7zk9v7pypLMEPSYt2eVq8+bqgyqYb7pbl+0EPFaY6VDXuc1Couqp1vyrYbyqy0wPQf1kUcX6lQKW47fTmmPi5lfOliyDqdQl5tlqQ4rvZcj9sSbBZnUYp1AF+trShX80H58E8Q0lXk4WP2Rqg7TmTIumI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=118.185.121.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: JOK1B6F2fRJ5W+a31S13F+GYXT68mhdior8jwWtyNAAWFmCKbP6B34/kYUhJnpSkB8ywCmIVyk
 Rdcn4OiAwBKA==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa1.ltts.com with ESMTP; 08 Feb 2024 14:50:26 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: linux-kernel@vger.kernel.org
Cc: m.nirmaladevi@ltts.com,
	lee@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jpanis@baylibre.com,
	devicetree@vger.kernel.org,
	Bhargav Raviprakash <bhargav.r@ltts.com>
Subject: [PATCH v1 03/13] dt-bindings: mfd: ti,tps6594: Add TI TPS65224 PMIC
Date: Thu,  8 Feb 2024 14:50:11 +0530
Message-Id: <20240208092011.1206988-1-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TPS65224 is a Power Management IC with 4 Buck regulators and 3 LDO
regulators, it includes additional features like GPIOs, watchdog, ESMs
(Error Signal Monitor), and PFSM (Pre-configurable Finite State Machine)
managing the state of the device.
TPS6594 and TPS65224 have significant functional overlap.

Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
---
 Documentation/devicetree/bindings/mfd/ti,tps6594.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml b/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
index 9d43376be..6341b6070 100644
--- a/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
@@ -21,6 +21,7 @@ properties:
       - ti,lp8764-q1
       - ti,tps6593-q1
       - ti,tps6594-q1
+      - ti,tps65224-q1
 
   reg:
     description: I2C slave address or SPI chip select number.
-- 
2.25.1


