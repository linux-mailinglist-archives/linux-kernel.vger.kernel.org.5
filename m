Return-Path: <linux-kernel+bounces-154778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBC58AE0E3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525041C217ED
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E7C59161;
	Tue, 23 Apr 2024 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KVrwJmNz"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D046B58105;
	Tue, 23 Apr 2024 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713864078; cv=none; b=JjTG8BPBCc7hOa4NHay+cEBsaRPyzbpIVVyycZ+8WJxsnmRpEGCUNKV/dCAehsDdtDS+qT5wkxXvpHiWy5ygdO4dQQdIrjy60KULpM16aN2dMkv+fdG9qkT3EgH7+2Zgf7ViAaRJuDkXRVH4k2XqaThL8HLiQHiFrAD1OU9XKAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713864078; c=relaxed/simple;
	bh=yWNGNKRAobsTyRSC8HBOw5su3v89weJyamUOkfBbARw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q7VhNz83o/UyoWR/SXwJrnisnsvqEMjABYkb5SheQRIz1Kcj5xvs3NYLaAqAt4gvwZJ2fVL9Mr93tjg6DzLBj9kZkCp9JXM+tlWbzB86qKnvo0axl63KQBU4FpYc7hpM7gSIilCF3XbOkICTBXQBbF/6dnp943HuzsdPKRyi9f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KVrwJmNz; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D0C8E240002;
	Tue, 23 Apr 2024 09:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713864075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H9/+gdlcc0RNLyeZGAneUT93PRl+K8VA2IX8p/L0w+g=;
	b=KVrwJmNzOcrrH6oRwXLHkF97A8idzsb9WR4n5FH+HBMjsgricvPehGnHf5AfDGOzQ3896C
	2bhNi7UNX89yKL8GgHCtxSzp/NNTYLLD2KHXsQm+yI0XIRhUDDWfi8Gl2+bvJiP482YCMd
	urN8/O8+LNXJTcEYrRTO04u9dcNG/0twtKTOHoBP+49z2cTbBtptYDjkXSdjEUxE6HAJhc
	5bRT2qW1484JJCm+oTe5pR405C/4njXd7FgSzxbJwMPsYNN1g1jf9/QaISC64UF87JuYRg
	/48qD0qA3QkaxgmkY27rQpVKhSTDXNuBjFurjRfQay1+4uc/fiJFssinfy4oKA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 23 Apr 2024 11:21:10 +0200
Subject: [PATCH net-next v3 1/3] net: pse-pd: pse_core: Add missing kdoc
 return description
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240423-fix_poe-v3-1-e50f32f5fa59@bootlin.com>
References: <20240423-fix_poe-v3-0-e50f32f5fa59@bootlin.com>
In-Reply-To: <20240423-fix_poe-v3-0-e50f32f5fa59@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Add missing kernel documentation return description.
This allows to remove all warning from kernel-doc test script.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
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


