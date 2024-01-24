Return-Path: <linux-kernel+bounces-37279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53E183ADAB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64CF0289C00
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E445A7CF13;
	Wed, 24 Jan 2024 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="p/v/SQC+"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1927C099;
	Wed, 24 Jan 2024 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706111151; cv=none; b=m/yJwwF7yFf4fLMOSJ+h/V+vjfMlTCCWoWEavCjA5s8N6jAW4IWyKRvvGmC5N+ESZZe2habMga70nqoV6hLsF0gg2D1Gb05GIvIuXqRrlqbvB2yCSGJrEsQZwR6nTcV/FOB4slmA6bqoTArxW+dvT9cAz8GJOBdhqVgMBiL1FHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706111151; c=relaxed/simple;
	bh=5VEK0y8xwK2Yu2cCt2iPYNRvJOFHGsyOOqYVXqeV9rg=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=kW4KPS2VkKNWUTe41GOAFj+nK4aZ/LsTBBilePv92w5tGm5PaDhHIvQqgbVcJ7DtAzE6QQg9KwCwE6SOQNt7zYDng7KyOPSy5UyFKZMuwdrp6r8X7spgOi6eMyyKdwbkd1yG2gTNdxbeSzlU23jUfms5e1BlDbHnAkFQvqrbLoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=p/v/SQC+; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=yNbAXH5FKiT/iwyT3JP2PKUh3C/2nRMwck7EtGJ1LgU=; b=p/v/SQC+vaZ7cl5BpbqaeL9Q6Q
	wni32tbqSMeT1o4l71c590tMpImeG11kn8WC/Epsg7vd1XHZh/Gdcd9LDnr+jCJRtk7lyuTwV3H7/
	Gihp7/F8Bj6vqTmiye4QplKSc4vtmNnUiBJVL7e8fKWKsI8rOcttetT40PAm7Y9r4laE=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:46384 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rSfRb-0007N8-DC; Wed, 24 Jan 2024 10:45:39 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	leoyang.li@nxp.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	hugo@hugovil.com,
	andy.shevchenko@gmail.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Wed, 24 Jan 2024 10:44:20 -0500
Message-Id: <20240124154422.3600920-2-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124154422.3600920-1-hugo@hugovil.com>
References: <20240124154422.3600920-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
Subject: [PATCH 1/2] dt-bindings: arm: fsl: remove redundant company name
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Company name in compatible description appears twice, which is not really
helpful, so remove it from product name.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 228dcc5c7d6f..f455c0172c84 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1026,7 +1026,7 @@ properties:
         items:
           - enum:
               - dimonoff,gateway-evk # i.MX8MN Dimonoff Gateway EVK Board
-              - rve,rve-gateway # i.MX8MN RVE Gateway Board
+              - rve,gateway # i.MX8MN RVE Gateway Board
               - variscite,var-som-mx8mn-symphony
           - const: variscite,var-som-mx8mn
           - const: fsl,imx8mn
-- 
2.39.2


