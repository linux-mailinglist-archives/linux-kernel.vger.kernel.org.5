Return-Path: <linux-kernel+bounces-151167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 913898AAA33
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09CE9B21E18
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FBF5FBB5;
	Fri, 19 Apr 2024 08:31:30 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0A0F507
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515490; cv=none; b=HJ/ayUW/A1JIVm8JJp4C/PXBFGr90O46kODSo/Dz1LJ9nmRMkXPmdSEZl0mh77OzRxSeVGYf9rcxi0MtteOMFeYwx9eEutqAIZnitIG7i5rNV4Qxk9mcoPRyBCkYE+OtEoPt7VnEEsrgqUqzgPqZbGOkrUTFwIFRqAbRLCmQ0PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515490; c=relaxed/simple;
	bh=aLCYOY9uDoJrqIV3AUBSqW/EEWxfcdmxTZoQdRkDNR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JaeBY/2vgYb17hieHTrfe3UlWL1qIhtDddFIbQkMXv+oJy01Q8aelzhPlxt5HH07GdFabmitJEQWkmkzZVQIN1P5DYn3h/irRcx3phXONsdi3yVvbTeZbKQQZP79Q+A81ltfvoo9TriFeHDl+0uHc2fp5PW+0BA9wXkyWg1IB+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <has@pengutronix.de>)
	id 1rxjeR-0006iN-HF; Fri, 19 Apr 2024 10:31:19 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <has@pengutronix.de>)
	id 1rxjeR-00D7hF-43; Fri, 19 Apr 2024 10:31:19 +0200
Received: from has by dude03.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <has@pengutronix.de>)
	id 1rxjeQ-00DyIU-3B;
	Fri, 19 Apr 2024 10:31:19 +0200
From: Holger Assmann <h.assmann@pengutronix.de>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	yibin.gong@nxp.com
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Holger Assmann <h.assmann@pengutronix.de>
Subject: [PATCH 2/2] dt-bindings: regulator: pca9450: add restart handler priority
Date: Fri, 19 Apr 2024 10:31:04 +0200
Message-Id: <20240419083104.3329252-3-h.assmann@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419083104.3329252-1-h.assmann@pengutronix.de>
References: <20240419083104.3329252-1-h.assmann@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: has@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This is an optional property. If set, the pca9450 will be registered as
a reset device with the chosen priority level.

Signed-off-by: Holger Assmann <h.assmann@pengutronix.de>
---
 .../devicetree/bindings/regulator/nxp,pca9450-regulator.yaml   | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
index 3d469b8e97748..7cc2d6636cf52 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
@@ -35,6 +35,9 @@ properties:
   interrupts:
     maxItems: 1
 
+  priority:
+    $ref: /schemas/power/reset/restart-handler.yaml#
+
   regulators:
     type: object
     description: |
-- 
2.39.2


