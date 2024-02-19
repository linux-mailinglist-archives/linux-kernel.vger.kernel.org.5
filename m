Return-Path: <linux-kernel+bounces-71103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB9D85A0A1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24771C2116B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E525925628;
	Mon, 19 Feb 2024 10:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ifcdmTIU"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675452869B;
	Mon, 19 Feb 2024 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708337555; cv=none; b=VjqzW/nSrDPF1LRM7vLnPBQp+s2eNcTPXxAAQfxpjWCAIrlJzb4Z7IoiNo9ejbmB5RuNeBI+joLgHQLJaDnORFKCpyFH4DlgiqhX2KQiyC8htoIdvLF1b9USABQ1T8dba83ChWx5PV292UkckgA06YL4T70z/stwh42q0qkMLUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708337555; c=relaxed/simple;
	bh=XJlaEvpRz0/GsusTqoSGEBO6ELpXHI3ywLHM6TDhnuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWK+no+B+Hjz3AA6m+I5cy3RSY8v/2kDtYNDivgF1Hi9E+1pJmEnvMo8I2yglNZLoBTPv2fb4kU2AWgVS0EFXKaIeO6e2jPLvSjcKXKrLZT7fKjPqSWbJ7aV+iaGYjp13nJ1z0hNhg9rL4yHEUgfGiFmoA68RopvleTcqPwheQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ifcdmTIU; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 568F61BF210;
	Mon, 19 Feb 2024 10:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708337545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nHQnvcxka58vLFRQuoR+CefX5o1t0IMycj8fHga9rPc=;
	b=ifcdmTIU0g5zi4T9VG65NAAMgDOBHcniLGxQVH5pkcBsLOiHuoMAzo0DA3hDI719azVFv5
	NBksuEVqEkqy5vkzaWlsK5hL2Ziha070I2nr5th1TLsxbPB402jEs5++vHiXqIACBs22v/
	z6qB6LbLCUSeRKXF+Tnetyrh51tES0IaMng6XZLGdJWrCkXW9ey47rXRkgIp3FVR7NXC5K
	oQkM4zm7ULe3wnz8xzGIUbNuE2qsjsU9kCnqi6/Zg/SGRNztWh9DtO9RGNkCq0n9ZMKl51
	78wnQXRTb7Fwl9jI6FUvstriScdqnc1/DW32UwYD5bWPEj+5cjdPD/AuPXks4w==
From: Kamel Bouhara <kamel.bouhara@bootlin.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Marco Felsch <m.felsch@pengutronix.de>,
	Jeff LaBundy <jeff@labundy.com>
Cc: catalin.popescu@leica-geosystems.com,
	mark.satterthwaite@touchnetix.com,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	bsp-development.geo@leica-geosystems.com,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 1/3] dt-bindings: vendor-prefixes: Add TouchNetix AS
Date: Mon, 19 Feb 2024 11:12:18 +0100
Message-ID: <20240219101221.129750-2-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240219101221.129750-1-kamel.bouhara@bootlin.com>
References: <20240219101221.129750-1-kamel.bouhara@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kamel.bouhara@bootlin.com

Add vendor prefix for TouchNetix AS (https://www.touchnetix.com/products/).

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 1a0dc04f1db4..88954a286107 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1444,6 +1444,8 @@ patternProperties:
     description: Toradex AG
   "^toshiba,.*":
     description: Toshiba Corporation
+  "^touchnetix,.*":
+    description: TouchNetix AS
   "^toumaz,.*":
     description: Toumaz
   "^tpk,.*":
-- 
2.25.1


