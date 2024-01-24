Return-Path: <linux-kernel+bounces-37367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF82283AEE0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77F1DB23DE8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51207E770;
	Wed, 24 Jan 2024 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="H3pt824g"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ACE7E580;
	Wed, 24 Jan 2024 16:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115398; cv=none; b=Cz6jKstJXz0gl1g11igFJPa2hhyFdIrmcJoWTtdCFI+konBpSHJaLl/g1s9spT14JN13k8SVOCvKK7PNAr8o/2KXTnScp41X15GPK8lnK/gwgjhSnlt11zI1EVqgcYyDS9XITDkRfN/gPNoNbwscVKDpB/t3DsVxJV44/Lffr9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115398; c=relaxed/simple;
	bh=lZA+e0dIxK877058SzFliRvNwUJWUN4OduorJ7kVHKQ=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=q3TDGgITda7QZsH7rOP3VZwEc4eA/Tb423y7zT2w2SaUWDhneQsmAiw6Swxbz5Rc3A4euAIvA4UgM3RIiyQnohU6P8XPNKoTms7YFiJUgXmyNEtufEWl47g+3I8FE10AB4HMaGAHqxsBE/2y/HiKXVzSf3BBb7BNJW2LEeUOGY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=H3pt824g; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=xu8UU0gvqutfoz2yq3VWsMN1puk4qThtJk09yfvGUzo=; b=H3pt824gUrgjhMuO3BLSyqHjB1
	8uiwA9LBj8SRKv3YsNKevfGtLaHeEgZJUI8+WITUTMaG7HUfLxWqImeInN6aNF1NzZaC8xhRWyNKE
	Ydfd/ktcbPFU5KjuaqAlTQxMhAD1jcVa92MHsn9rKYsbh6JLGEtjqPoG4RNOO0YrSJvs=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:45420 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rSgY8-0007ym-0A; Wed, 24 Jan 2024 11:56:28 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	leoyang.li@nxp.com,
	hvilleneuve@dimonoff.com
Cc: krzysztof.kozlowski@linaro.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	hugo@hugovil.com,
	andy.shevchenko@gmail.com
Date: Wed, 24 Jan 2024 11:46:45 -0500
Message-Id: <20240124164646.1506814-2-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124164646.1506814-1-hugo@hugovil.com>
References: <20240124164646.1506814-1-hugo@hugovil.com>
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
Subject: [PATCH v2 1/2] dt-bindings: arm: fsl: remove redundant company name
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Company name in compatible description appears twice, which is not really
helpful, so remove it from product name.

Fixes: bb405e8b5336 ("dt-bindings: arm: fsl: add RVE gateway board")
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


