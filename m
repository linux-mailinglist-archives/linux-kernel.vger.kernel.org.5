Return-Path: <linux-kernel+bounces-69092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E8B858460
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D424284807
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49FA135400;
	Fri, 16 Feb 2024 17:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y/u5j1P2"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AE11350E0;
	Fri, 16 Feb 2024 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708105364; cv=none; b=YMdabmMXlPoA7aRwMEOMZlZiuMCxlFLFJyd0J+9Sa6T1rY/kN8D348sZICBTCfwK0iXrD8Wqp+TuOff7zz/jhlg8VbKm4UjeMhj3FGSIp/5xs4eFR8OhgfhTbstzkVEkVfc0Q+wJ1daa0vk0PnVuEfMA2+W6YlpY79Z9KOSwPEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708105364; c=relaxed/simple;
	bh=10ZEAJurS12z5xoBCG/ln6uoclFy6kBUieMg+mevi/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhUVd3DFSV22n2bRYi/JASG+AWzubpzkO5EiwR4XF8Hl/y7o+Opl6rihf9A5KAlnNFnN5EHxl42XhzurTOzFZxsgWnrd2eGEmtDwWzyw1Xqe6Us69a/kZ3RXRKkMSsWE8MEh6MA8/fWH+0etgGJIDJjYznGMocR9d7GDj2MLRX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y/u5j1P2; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C8287C0008;
	Fri, 16 Feb 2024 17:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708105359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KtLJx1LoT2GXTWyVjN+1FeAU3avbgKgLJY8tRT/zqqY=;
	b=Y/u5j1P2Yb2SgI7rdyAOzzZj7lPio26I+guYLc8DwujXJ9oWrJPwKLW3kj+/LHsV2qjcZB
	xLNaCUH1tgWQuagKagNHkMBKdwPeLSl0Fjiw8lMwey1KDho0GkV6cOJJHcHTSlCGr5IiTV
	ZWt6H9rOH2T+bG1Lq4sLlqai2ZqxbDqiWepI1LvhVTq0AQUTX0RAb2no4YOjPXkTpYgJEU
	NSvzBRHTOo6n8yP1/yXm0Xv43jfpH0f6CwXDVrCZM7ebOT5AHD5NrjLoGIjPndqafgDxs7
	5WZrAJIgAo7YqyNC0DVpvnR35THSGxRhKQSPPghZRH9C7zJcw/NmxUkQf5JBvQ==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Paul Burton <paulburton@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir  Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v8 09/14] dt-bindings: mips: Add bindings for Mobileye SoCs
Date: Fri, 16 Feb 2024 18:42:18 +0100
Message-ID: <20240216174227.409400-10-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216174227.409400-1-gregory.clement@bootlin.com>
References: <20240216174227.409400-1-gregory.clement@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com

Add the yaml bindings for Mobileye SoCs. Currently only EyeQ5 is
supported

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 .../devicetree/bindings/mips/mobileye.yaml    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/mobileye.yaml

diff --git a/Documentation/devicetree/bindings/mips/mobileye.yaml b/Documentation/devicetree/bindings/mips/mobileye.yaml
new file mode 100644
index 0000000000000..831975f6b479f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/mobileye.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+# Copyright 2023 Mobileye Vision Technologies Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mips/mobileye.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mobileye SoC series
+
+maintainers:
+  - Vladimir Kondratiev <vladimir.kondratiev@intel.com>
+  - Gregory CLEMENT <gregory.clement@bootlin.com>
+  - Théo Lebrun <theo.lebrun@bootlin.com>
+
+description:
+  Boards with a Mobileye SoC shall have the following properties.
+
+properties:
+  $nodename:
+    const: '/'
+
+  compatible:
+    oneOf:
+      - description: Boards with Mobileye EyeQ5 SoC
+        items:
+          - enum:
+              - mobileye,eyeq5-epm5
+          - const: mobileye,eyeq5
+
+additionalProperties: true
+
+...
-- 
2.43.0


