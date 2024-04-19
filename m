Return-Path: <linux-kernel+bounces-151173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBA08AAA9F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E051F229E3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC956A357;
	Fri, 19 Apr 2024 08:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KckEIBRA"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C28521A0C;
	Fri, 19 Apr 2024 08:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515713; cv=none; b=szIh+cPi2mb+pOXvTO2VdJF9s85Dk22fMDP9XeyKVtS1sKsNLHt9OAVTGoyz1c7N2qe/Y0VDhVL2vyv1th5V3Qlxll/K1mayB3jNR02mb44vIpEsUySPLS00CI98t2m/+9POaAX8Y95RLC+YnS3yQf+6zjmddIIayploXzyPRjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515713; c=relaxed/simple;
	bh=xvhakI/gJi6QeG2YGEaTZ/99O68GdGOJPHyw5PUhbO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fU6e1T4j7r8tnNvXKMzAMyFbxv29ecw4IbV3WWe2fHpZ7HxyrSFlxessUlkzvN4/D+1AfFmb6xI6sujtFHc9EzUBZEaKZd+QVrQ5H50tWCi97TKC4qM0HMlUg70LfkVONyCXUoATagKEZ8nUQeGZcfjq/LcZmYv043nf0nArIq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KckEIBRA; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1ACEE240007;
	Fri, 19 Apr 2024 08:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713515703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KpuZnh+0Pw/1mj7y4M1pa+0BGDPeeXQB2THZ9rva5uI=;
	b=KckEIBRAGhsHf9SJhu1CxQsmISQV2TXp7+oPJsB+xes/antW2xl0gN50ZZIKTLjivpWgfH
	FDN8P3+ICFsA8W8ExoupikqINaPzBp5uAGHvEhvfhDE15+mO/zLXrwPyMbbe5R1S0LdnjX
	cMx5//IS1TkFtJi81kHf4MlwR5cr4h7jMEDFPvTH/DK1kV+JG6G2aV8L9VHbaaPvxtldp9
	BVLRkd69Lx6vF5TigbrYnZmGLlylRNhbQBxKVfTaXx4ctn1w+esmrHqBc5KEMEsVOVBKkv
	TFP6/8brgCC8mn1kKVVBzj0/rc9CLgANvxOAgCQK77ZRdPng/5TWFgYUb9CfGw==
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
Subject: [PATCH v10 1/3] dt-bindings: vendor-prefixes: Add TouchNetix AS
Date: Fri, 19 Apr 2024 10:33:39 +0200
Message-ID: <20240419083342.61199-2-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240419083342.61199-1-kamel.bouhara@bootlin.com>
References: <20240419083342.61199-1-kamel.bouhara@bootlin.com>
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
index b97d298b3eb6..33205dea558b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1481,6 +1481,8 @@ patternProperties:
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


