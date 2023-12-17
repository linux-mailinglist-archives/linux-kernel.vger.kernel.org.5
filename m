Return-Path: <linux-kernel+bounces-2605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D74815F52
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326E11F21038
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014C44594E;
	Sun, 17 Dec 2023 13:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="qA0PjjFm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA4644361;
	Sun, 17 Dec 2023 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id E674728C344;
	Sun, 17 Dec 2023 14:20:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1702819247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2SD3taSO+f1UM86Cr/JcCY5HUjl3SAc3qWRqT3ByZoE=;
	b=qA0PjjFm1+I4j5Z919u1bq1xSAoukywGOAIiT9do2HZ/NAxyetmEZzTcKiYk5lWLu/97lM
	TAOX6Zr22H+Uh5EmDipRGGqJtVhujiuXyRhNbUz1vQIn9rQlCUkFTzQP0rqgUDhx8bTF2j
	IUFYES9HVURnzJt46w2vlllL+ATH8OE=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id C5A7B44AF99;
	Sun, 17 Dec 2023 14:20:47 +0100 (CET)
From: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
To: Karel Balej <balejk@matfyz.cz>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org
Subject: [RFC PATCH 5/5] MAINTAINERS: add myself for Marvell 88PM88X PMICs
Date: Sun, 17 Dec 2023 14:17:03 +0100
Message-ID: <20231217131838.7569-6-karelb@gimli.ms.mff.cuni.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217131838.7569-1-karelb@gimli.ms.mff.cuni.cz>
References: <20231217131838.7569-1-karelb@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karel Balej <balejk@matfyz.cz>

Add an entry to MAINTAINERS for the Marvell 88PM88X PMICs MFD and onkey
drivers.

Signed-off-by: Karel Balej <balejk@matfyz.cz>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e2c6187a3ac8..eb0171cd2323 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12737,6 +12737,15 @@ F:	drivers/net/dsa/mv88e6xxx/
 F:	include/linux/dsa/mv88e6xxx.h
 F:	include/linux/platform_data/mv88e6xxx.h
 
+MARVELL 88PM88X PMIC MFD DRIVER
+M:	Karel Balej <balejk@matfyz.cz>
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/marvell,88pm88x-onkey.yaml
+F:	Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml
+F:	drivers/input/misc/88pm88x-onkey.c
+F:	drivers/mfd/88pm88x.c
+F:	include/linux/mfd/88pm88x.h
+
 MARVELL ARMADA 3700 PHY DRIVERS
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
 S:	Maintained
-- 
2.43.0


