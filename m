Return-Path: <linux-kernel+bounces-67695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 045E3856F54
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3632E1C22D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0F014533E;
	Thu, 15 Feb 2024 21:29:13 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97373145320
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 21:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708032553; cv=none; b=d3XtAapCagsLOSt3sv054paMWmzKYV68uBqSlsI9/7QAdRGoc/lNxRuJSc4vnZd+XW2F5I6w4vQs8TXsyEIm2+NgFKyXoLACGHQ0E+XEuxJZBfWoejwfBqDLVTCa3t1CP8PbtiehFxSr5RyX4y4Bmm6jZ88jeMJ/w6RJrj66K5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708032553; c=relaxed/simple;
	bh=Pp1gNDwQrjYX8JdcQvv3H9tjki5TYsWrM8W3/pzFDaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iq762umvpRxBOT36G4mfvqUjQPQRPirh7CHVZcmsbLvafDwGJJ0HdnEJ9OwmLlS2Qg+XlJZLlavydamXnxD6zblIfOYrj14bUfh9dc4/mFe5b4BqdegIixx/h6jkEfPEffQBY25m2HIamHaBgZkup+0BYojhH2fmHhHybpjl+xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1rajHr-0001xh-Du; Thu, 15 Feb 2024 22:28:55 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: gregkh@linuxfoundation.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux@roeck-us.net,
	heikki.krogerus@linux.intel.com,
	jun.li@nxp.com
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v2 1/4] dt-bindings: usb: typec-tcpci: add tcpci fallback binding
Date: Thu, 15 Feb 2024 22:28:49 +0100
Message-Id: <20240215212852.1202339-2-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215212852.1202339-1-m.felsch@pengutronix.de>
References: <20240215212852.1202339-1-m.felsch@pengutronix.de>
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

The NXP PTN5110 [1] is an TCPCI [2] compatible chip, so add the fallback
binding.

[1] https://www.nxp.com/docs/en/data-sheet/PTN5110.pdf
[2] https://www.usb.org/sites/default/files/documents/usb-port_controller_specification_rev2.0_v1.0_0.pdf

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
v2:
- rephrase commit message

 Documentation/devicetree/bindings/usb/nxp,ptn5110.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/nxp,ptn5110.yaml b/Documentation/devicetree/bindings/usb/nxp,ptn5110.yaml
index eaedb4cc6b6c..7bd7bbbac9e0 100644
--- a/Documentation/devicetree/bindings/usb/nxp,ptn5110.yaml
+++ b/Documentation/devicetree/bindings/usb/nxp,ptn5110.yaml
@@ -11,7 +11,9 @@ maintainers:
 
 properties:
   compatible:
-    const: nxp,ptn5110
+    enum:
+      - nxp,ptn5110
+      - tcpci
 
   reg:
     maxItems: 1
-- 
2.39.2


