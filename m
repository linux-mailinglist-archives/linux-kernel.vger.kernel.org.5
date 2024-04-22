Return-Path: <linux-kernel+bounces-153389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 776AD8ACD87
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18C1D1F21231
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB00153839;
	Mon, 22 Apr 2024 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F2V7X6W+"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A116B14F136;
	Mon, 22 Apr 2024 12:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713790278; cv=none; b=hljm8IoyG4sdNTMjb5LNUs7dSc0evA1xxg9nB+4VFYYZljxkIHSY4LYbShHdH8jXdon35oZEkOG6tVt3U13d1c1NDv98yOe9dLi+ag/FWW7cFjK7YN3AsLZmIdtoGxDyDpxCk6g+pCsh8MH69/FXcWunhXWT9LHuVK+HG+SN7Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713790278; c=relaxed/simple;
	bh=C5gdiPjVE0BtgM2TyDSuPLA1PpYri5uOENK+q7t9vbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DhgEybC2lKRJw2YnvX2oyhsnHB1qx/1upEsZzWIByeL2p6gwMARI1pK83hlC5KpxYHoWWtc5JGM5H2HzRzmbkQGiQ3jPrbO8pzqKXgM4a/TfmyqQuGPjYc0LNuMC6GG5OLrJcJpuNBta8UxDHLtJCnYSOV0saxTI/vNQQkdAaKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F2V7X6W+; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7B6D96000C;
	Mon, 22 Apr 2024 12:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713790275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ymt5whlrVYPdvlNoBsWbCBoBILM6qgmZbsGmSLSZ+hw=;
	b=F2V7X6W+pwNUCEW6LhKuuy5bb6J5NQXLnB4jr68N6WhwNrZ7OaQT5IXpZ6M2ndEqOa+GCG
	3dzzeg9Erh/CA4lz4KTAh8T+eWwYZ13qVMMOsMIIyJ26INRskZlS3zT1lGwXpAnz/XbZrB
	BkkpG6cYZsKOrN/DuWVHLTDT7/BHhKDopiqETEvZMdlSkCzToDI6M1Pp3+hMYW6XEK3Kl+
	vA4kcCZ3oEj94lKQ1RFPXK3wZllfSuiKduTxeQpTkEFl2KK3R+KGMiaR95Tj/0y1z65ZbY
	MOMZwjrNuSgyVmL0QFye7+l2PYHYDOFMqvIIt+szz7r+iPJ/0tJeACQv+GPKyg==
From: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
Date: Mon, 22 Apr 2024 14:50:48 +0200
Subject: [PATCH net-next 1/3] net: pse-pd: pse_core: Add missing kdoc
 return description
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-fix_poe-v1-1-811c8c0b9da7@bootlin.com>
References: <20240422-fix_poe-v1-0-811c8c0b9da7@bootlin.com>
In-Reply-To: <20240422-fix_poe-v1-0-811c8c0b9da7@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Add missing kernel documentation return description.
This allows to remove all warning from kernel-doc test script.

Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/pse_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 31f23c454678..bad29eaa4d01 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -320,6 +320,8 @@ devm_pse_pi_regulator_register(struct pse_controller_dev *pcdev,
 /**
  * pse_controller_register - register a PSE controller device
  * @pcdev: a pointer to the initialized PSE controller device
+ *
+ * Return: 0 on success and failure value on error
  */
 int pse_controller_register(struct pse_controller_dev *pcdev)
 {
@@ -401,6 +403,8 @@ static void devm_pse_controller_release(struct device *dev, void *res)
  * Managed pse_controller_register(). For PSE controllers registered by
  * this function, pse_controller_unregister() is automatically called on
  * driver detach. See pse_controller_register() for more information.
+ *
+ * Return: 0 on success and failure value on error
  */
 int devm_pse_controller_register(struct device *dev,
 				 struct pse_controller_dev *pcdev)
@@ -627,6 +631,8 @@ EXPORT_SYMBOL_GPL(of_pse_control_get);
  * @psec: PSE control pointer
  * @extack: extack for reporting useful error messages
  * @status: struct to store PSE status
+ *
+ * Return: 0 on success and failure value on error
  */
 int pse_ethtool_get_status(struct pse_control *psec,
 			   struct netlink_ext_ack *extack,
@@ -704,6 +710,8 @@ static int pse_ethtool_podl_set_config(struct pse_control *psec,
  * @psec: PSE control pointer
  * @extack: extack for reporting useful error messages
  * @config: Configuration of the test to run
+ *
+ * Return: 0 on success and failure value on error
  */
 int pse_ethtool_set_config(struct pse_control *psec,
 			   struct netlink_ext_ack *extack,

-- 
2.34.1


