Return-Path: <linux-kernel+bounces-121735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 092B688ED1E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1C41F31ED7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485E8153579;
	Wed, 27 Mar 2024 17:46:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22C9153561;
	Wed, 27 Mar 2024 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561576; cv=none; b=IUiIGna+zHw7LUC7ob+/N3cTMOFG+4JHU2m5l8zCz2b1NL9Z31R/bGUg2dKAoiT2SIresIj1m8eDjOQyiuJ9f1eoFsAD5vkV8y7pn3eqsFptEH1EjwglB5ruHHIWcgxJv5WcpHJ7lBt0JAvilHeaaxemgD4p6lC8S9+RBk1XQfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561576; c=relaxed/simple;
	bh=yAreWuZEIL/zNEHUrOiCbHPbgbxn2PKGNY7bWws5WmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PY+ZwoPLlcGz/fibnnox6Z+hkM0vWK42icD7pR47AINGnOEQ55z5M5yAQhty1VOOB+1gN9nrqOq/p5HQe4fElLxfrcw25k/DdhDfLaJI9jVJ+KY7lPhuP3Tvwl48Xou1BLpgexya/QmLwDzd2N9TBC+/0GCCNJdLaZ9ivM0dbHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E231C433F1;
	Wed, 27 Mar 2024 17:46:13 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Ran Wang <ran.wang_1@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] usb: phy: fsl-usb: drop driver owner assignment
Date: Wed, 27 Mar 2024 18:46:08 +0100
Message-Id: <20240327174609.519252-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in platform_driver_register() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/phy/phy-fsl-usb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/phy/phy-fsl-usb.c b/drivers/usb/phy/phy-fsl-usb.c
index 79617bb0a70e..1ebbf189a535 100644
--- a/drivers/usb/phy/phy-fsl-usb.c
+++ b/drivers/usb/phy/phy-fsl-usb.c
@@ -1005,7 +1005,6 @@ struct platform_driver fsl_otg_driver = {
 	.remove_new = fsl_otg_remove,
 	.driver = {
 		.name = driver_name,
-		.owner = THIS_MODULE,
 	},
 };
 
-- 
2.34.1


