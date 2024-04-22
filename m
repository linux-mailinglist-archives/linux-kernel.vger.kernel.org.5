Return-Path: <linux-kernel+bounces-153463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7078ACE66
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 823BBB23281
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFF61514D4;
	Mon, 22 Apr 2024 13:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kHIahNTS"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0C715098F;
	Mon, 22 Apr 2024 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792970; cv=none; b=mextamYu45FPPOTOlxtanVUAVIvO6BjTOAD09a1WKuhKN4kAQlO1SADnLapD8rd2MblOuhim9w19Tds224W1YxohVx99qwK0MFZcPQkZLwQCrWoOBCIz5F0QMA1O1e1QT/XR1t/ruTjkKYwU1AZo4bC/SZf97CxR3lsaJbjnQF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792970; c=relaxed/simple;
	bh=bXi29gIZ4zvr8ZuPsErOR7MMJWSFxgIYO6IzdNg2uN4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gUmcTFLBJaadFNPSGY1YwQ8QEwlNJgWS/Itxc7LRAHPlHVidAlBTLr0N5pObWsBWHokFzFV8UeXXDtkXRf9AagTuX4CIcZjVhFzZTbkeF5/I6CxTVadCk+aR+fFPS4NYDvyQONjRhVjlwjopwrmIjy8qQFxN4cW2JXMk2r+jKbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kHIahNTS; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A41BE1C000B;
	Mon, 22 Apr 2024 13:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713792961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SJjYjznxGBCfpOCBWtP0dj9JIhOm2DN+x+GnGTRrtMw=;
	b=kHIahNTSmfwXcFHJ/G+FlcgRVC0CRptEJhxaUPTq/AgDR15eQOZykngop4H6k47cIkASp6
	Ro4DqA2XZGytehFHmvtUbJmB197/xO0lHUrhZUihn+/ASpGaiNz9DJL9sGbZN1e/zfz/EW
	s6XTx5cMpFtZd+1H0D6Nz+CcqCNcayDwOXO+DCx57jhy2qWo0fs1o6eczdR4AYnU7UsK5y
	9AzfylSiF+CfOWl5ibH7tCWQl5I3DEPmMDcchEPGXfQNZ+IShwO1pDGFdByCz/lJ6UN28D
	GX0ooOOwp4HDpwHmhZwfT3ld7xnPUemQ2kjcmilxqZKAapyTtOD45KIZzxxM0w==
From: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
Date: Mon, 22 Apr 2024 15:35:46 +0200
Subject: [PATCH net-next v2 1/3] net: pse-pd: pse_core: Add missing kdoc
 return description
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-fix_poe-v2-1-e58325950f07@bootlin.com>
References: <20240422-fix_poe-v2-0-e58325950f07@bootlin.com>
In-Reply-To: <20240422-fix_poe-v2-0-e58325950f07@bootlin.com>
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


