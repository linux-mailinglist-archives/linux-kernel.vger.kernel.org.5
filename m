Return-Path: <linux-kernel+bounces-121739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDE988ED25
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0243E29F61A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FCD12E1D0;
	Wed, 27 Mar 2024 17:46:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF05130A7A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 17:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561613; cv=none; b=DvlWAMoBfryQf+icpTfthWeEqtiSDg4Vzwie2fbG050TWiEvyC948SzpDXwfA5nlCSRbz/8KI6fXFmX9ajgk/xfsGP0Nzvw4Zri2HZKKj8MJgWzOwiYfsUIYb/K0ADTnKRj8LcHvxROVZOYf2LVPKuGHHamilSgkIMmoRWjrphw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561613; c=relaxed/simple;
	bh=RdBpp99teN4Qb039qk3aCjzPPmNbdqhCa01fhlNy6bk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rF/mjy0Fh/UnkdIpGMCuRGdQdANWFFkMfgkaOlC16yhvURQ3s1XMUQ1LaWiPUZLeEwaN3M7BgfJCAbGCHzm/KuZ0mmQJU4bb8ZJdhdNazNR6EGMjz2dShDTGz5yH7cwYBxWqSqqgIcDKOz3jQfosdcSP3sQ3IX1hMbLEMk116VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEED7C43390;
	Wed, 27 Mar 2024 17:46:51 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] pcmcia: bcm63xx: drop driver owner assignment
Date: Wed, 27 Mar 2024 18:46:47 +0100
Message-Id: <20240327174647.519475-1-krzysztof.kozlowski@linaro.org>
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
 drivers/pcmcia/bcm63xx_pcmcia.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pcmcia/bcm63xx_pcmcia.c b/drivers/pcmcia/bcm63xx_pcmcia.c
index a5414441834a..5bda3e6d43d8 100644
--- a/drivers/pcmcia/bcm63xx_pcmcia.c
+++ b/drivers/pcmcia/bcm63xx_pcmcia.c
@@ -456,7 +456,6 @@ struct platform_driver bcm63xx_pcmcia_driver = {
 	.remove_new = bcm63xx_drv_pcmcia_remove,
 	.driver	= {
 		.name	= "bcm63xx_pcmcia",
-		.owner  = THIS_MODULE,
 	},
 };
 
-- 
2.34.1


