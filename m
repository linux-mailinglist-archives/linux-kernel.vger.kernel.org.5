Return-Path: <linux-kernel+bounces-12555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF44981F6B0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DA98B23DE8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4CC6FA8;
	Thu, 28 Dec 2023 10:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="f8X8Mcbw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF16C881E;
	Thu, 28 Dec 2023 10:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 5103428C556;
	Thu, 28 Dec 2023 11:02:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1703757762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YVSEF+bVjS3Qq3ykpL6+CxTXTvvWWKuDoro8ix+FW6c=;
	b=f8X8McbwyJtNecPhdNm9LZB1pqb0LQLcr2EBJa68rO9Chd0wgZXYopNteKeOQYuIJ7ODx3
	3KfU4eMXG9S/DibeXat59cY9sExUuAO6mhTfvRZQHK1XjtmpFujXcC4FUeKTgtmkzgzwqk
	O7kp1z591a8xmLPOtnqBMMEaFNc8k+M=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 2CFAF4423CE;
	Thu, 28 Dec 2023 11:02:42 +0100 (CET)
From: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
To: Karel Balej <balejk@matfyz.cz>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org
Subject: [RFC PATCH 5/5] MAINTAINERS: add entries for the 88pm88x regulators driver
Date: Thu, 28 Dec 2023 10:39:14 +0100
Message-ID: <20231228100208.2932-6-karelb@gimli.ms.mff.cuni.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231228100208.2932-1-karelb@gimli.ms.mff.cuni.cz>
References: <20231228100208.2932-1-karelb@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karel Balej <balejk@matfyz.cz>

List the related files under the Marvell 88PM88X PMICs entry.

Signed-off-by: Karel Balej <balejk@matfyz.cz>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f35ec0f186a9..f9676aec7397 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12743,8 +12743,10 @@ M:	Karel Balej <balejk@matfyz.cz>
 S:	Maintained
 F:	Documentation/devicetree/bindings/input/marvell,88pm88x-onkey.yaml
 F:	Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml
+F:	Documentation/devicetree/bindings/regulator/marvell,88pm88x-regulator.yaml
 F:	drivers/input/misc/88pm88x-onkey.c
 F:	drivers/mfd/88pm88x.c
+F:	drivers/regulators/88pm88x-regulator.c
 F:	include/linux/mfd/88pm88x.h
 
 MARVELL ARMADA 3700 PHY DRIVERS
-- 
2.43.0


