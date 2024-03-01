Return-Path: <linux-kernel+bounces-88264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A82286DF60
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F4153285B1B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC666CDB3;
	Fri,  1 Mar 2024 10:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="baMdmU7p"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3E16BFB5;
	Fri,  1 Mar 2024 10:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709289562; cv=none; b=D2pkQxDxFUpW5Un7sxgD/W4OIogD2LKo9RRu3Q3Vz4SCzazxnuyeGHypahBagymqF8nRLNj0O1U7zjoFEJ9fITRjxoMTJT8RznN5AeWxHVsbhXtot6uQmb/mQSssd7vMA5Dr/OfUpLZM1ebLiPX2TTZ67zxaFgYEweRN3uz5TLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709289562; c=relaxed/simple;
	bh=XJlaEvpRz0/GsusTqoSGEBO6ELpXHI3ywLHM6TDhnuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCXIaMM3L6KBXkwB+DkhDKwSJrfhZwT4W/lLRHToCBDaEKj4wd3CkB6VaB3wXSpoiK2fMaINium+yZoFAhZ6I8cEeOw6NSR0epfJ2QerzWIrPRKyCe1edaNPocxjqmJKJv+rtpQgO87tF6VgNLssDfMRjhjize5dvJBiBlzMWUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=baMdmU7p; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5D35CFF808;
	Fri,  1 Mar 2024 10:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709289553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nHQnvcxka58vLFRQuoR+CefX5o1t0IMycj8fHga9rPc=;
	b=baMdmU7pAGkF88fzkFUVBHru4My8O6ObkDvQLMAyaaQHE9z4/Jh4jX3PvTCZYw/Cz/GwhF
	2Uwhy32JjXsyuRxYQF9ojxE4BORKNF25O/1HicYLvIfdnT526UssUAS5aflMUggvhjdEDK
	gppUQqUUdU7zkFBCAV84W0IXDW+odr9cYA0bWuxTOqePXYkXFB2vom/Da9eP4vn0URG09y
	X2S06fwnlZI+oo3rYUONKDPULlJ8fPpi+w6Sfjpr9BzU3azKnG5GxlT5jPzR0KrE1M8Oo8
	ui6kRVYi7bYHgQ4i6d3dnU160UVMqgA5Kie45zQTH6FsVqR4KEoXBOgJFR+QjA==
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
Subject: [PATCH v9 1/3] dt-bindings: vendor-prefixes: Add TouchNetix AS
Date: Fri,  1 Mar 2024 11:39:06 +0100
Message-ID: <20240301103909.167923-2-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240301103909.167923-1-kamel.bouhara@bootlin.com>
References: <20240301103909.167923-1-kamel.bouhara@bootlin.com>
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


