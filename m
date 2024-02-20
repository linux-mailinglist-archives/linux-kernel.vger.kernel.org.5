Return-Path: <linux-kernel+bounces-72880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCFA85BA05
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28CA1F2558B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD301664D7;
	Tue, 20 Feb 2024 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BSSqGygS"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7826664CE;
	Tue, 20 Feb 2024 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708427459; cv=none; b=KTZyC14ktQClUCiXAIk0pki1PwXdJAihePlEPannGM0rJiMl9l+vQmjkQ28PwjEiZhMan2eHKHiPj3IcpSKMPfezMe/mMnItlxWsacByzzcFrKil6D6PYM9lCRZeo00tOOiquoY0L22D/qr7vUVbN+QOX1s1l9thJWQT1TgNnXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708427459; c=relaxed/simple;
	bh=eRdcavBrbS7Z1tgoLtld/S/+yifdcL68SWTMBVmtqiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdZrQjECEnIgtDZJfEQ4z19X/uhT0LuJp8n+D2dJAv38+KFSzJDvjqZ7hm8Dr7hCXRiFeHiChWP9boLUtdsoste7HM3xYdt+GyWNnUtQTEIUilJbL6He6CiO17pGst2hCMeMFmeqdrSwaqLBQeeZyAXzTHDR0qrSrjuxH9+7vo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BSSqGygS; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 8228F1BF211;
	Tue, 20 Feb 2024 11:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708427455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dIMzuvrtDamZE0HiEkiJxqOPfEthKIYmnyBT6Ohkkxg=;
	b=BSSqGygS1kfJ6h9uzsvevdfUzDbIxGanc5XtUCMUXQGcdCnf3cnhtH0K7dvIZnvx1o4gv9
	pb8b/liLFtzXzfv9QHiHxYs6OKadiTWet707mwjuUUWn+48AZGNzUacFArNfD7qRADz366
	CH7XVs+tmLzCYIaR1jRaQEG7WipxeK+paTL9zXrHvGFqFqITUr+onbxt1Z5ZZ6T7Tenksz
	zNJl2XJlmMUsG4+Ok1TjcDClxVbHO4MsSQ8f0AeKsDJjegLT/08RTNak4iyejl2G4ZRJj7
	8CLqxjwkIZXE4ur2TBC4seu3WJnSSrkMS9zlPTkP3GyxV9kpZb9GR2Trg0DJVw==
From: Herve Codina <herve.codina@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Wolfram Sang <wsa@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] driver core: Clear FWNODE_FLAG_NOT_DEVICE when a device is added
Date: Tue, 20 Feb 2024 12:10:36 +0100
Message-ID: <20240220111044.133776-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220111044.133776-1-herve.codina@bootlin.com>
References: <20240220111044.133776-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Since commit 1a50d9403fb9 ("treewide: Fix probing of devices in DT
overlays"), when using device-tree overlays, the FWNODE_FLAG_NOT_DEVICE
is set on each overlay nodes.
When an overlay contains a node related to a bus (i2c for instance)
and its children nodes representing i2c devices, the flag is cleared for
the bus node by the OF notifier but the "standard" probe sequence takes
place (the same one is performed without an overlay) for the bus and
children devices are created simply by walking the children DT nodes
without clearing the FWNODE_FLAG_NOT_DEVICE flag for these devices.

Clear the FWNODE_FLAG_NOT_DEVICE when the device is added, no matter if
an overlay is used or not.

Fixes: 1a50d9403fb9 ("treewide: Fix probing of devices in DT overlays")
Cc: <stable@vger.kernel.org>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/base/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 14d46af40f9a..61d09ac57bfb 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3619,6 +3619,7 @@ int device_add(struct device *dev)
 	 */
 	if (dev->fwnode && !dev->fwnode->dev) {
 		dev->fwnode->dev = dev;
+		dev->fwnode->flags &= ~FWNODE_FLAG_NOT_DEVICE;
 		fw_devlink_link_device(dev);
 	}
 
-- 
2.43.0


