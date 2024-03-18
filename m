Return-Path: <linux-kernel+bounces-105949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D7787E6C6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3931F22805
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA790376E7;
	Mon, 18 Mar 2024 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d0w8Mu4d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q27b6vrt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43B932C6C;
	Mon, 18 Mar 2024 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756462; cv=none; b=SZuYonj3KfjY7tRuc2HpNT4Ue+zN9eaX6yCN5CB9ANi/oOYP2UbANdywD/FJ4ub9QhzbuVjAPQkeG02qaMQqSkLkbIaI1MuRJPssV0Zc0R0D4cRYXGpz/lVoSF8tIt9CghKTkduXNJ5Mh74HNBroPnMVYnCBtvOhnVnLwoh6/IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756462; c=relaxed/simple;
	bh=wx8xZxU0kWpc8fw4qis3fIsPW1M9LAS6yFujUl6dI1w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XXgZ6J+xWkyOJGxa+xf6ANKQ54IF42QA9LTdeBsZChoHJZXKgn1YbZhboavViKNttvR/R0sn/wnFtzzzV1wPFA6d/OMOU0K8GBpv+yTwo4crttAwdjmTyhgSkpLIewkmz+h8gWvLIG7Oysmv71y3GcxE6la/mqKgkpDd1wut5sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d0w8Mu4d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q27b6vrt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Mar 2024 10:07:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710756457;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R//jkAFKs8MQbcTsyjSpu9eyc9W7qHRFw4F0o5eDsDE=;
	b=d0w8Mu4dZ16uxMvJZoLzVAegAAYvnH/4+Le+5wabKDM2NqFjbTwoIMUq2EFtsASHSqZtJ1
	e7ArUBnK53UZYTayKFDgPSiwzDSy1sycpjf6P/zJmQW3PNddxaKWSgo5GraaT0ToF/I8Wd
	E5fEq0quuUB1BwUqMjPBfgCSve+XSDmC8B8LPqV3gdfs0sgWYvdFh3Z7pLK1SRqisawwRK
	+FoMCn/ZDdJXfpEvrjtkJghJ8tTiGp3vtDqbl+/iGU+AZQfkUSZl4tvyRJKdg93SRa4Dzf
	/3ZVnMlLt7fesx7AazdFVepeJXYp1+7ixXuYDk9pYkZtLdkWm03DyiFjTyng1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710756457;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R//jkAFKs8MQbcTsyjSpu9eyc9W7qHRFw4F0o5eDsDE=;
	b=Q27b6vrtkXbpiq3D+s+aocU/aA4+L1KgIO8DLxyegvzAd9wkKaZT4N2wnvACUm6F9cczjJ
	PKe1QvhU02YRm4Dw==
From: "tip-bot2 for Sergio Paracuellos" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] dt-bindings: timer: add Ralink SoCs system tick counter
Cc: Rob Herring <robh@kernel.org>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231212093443.1898591-1-sergio.paracuellos@gmail.com>
References: <20231212093443.1898591-1-sergio.paracuellos@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171075645656.12214.16614619543155441564.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ec64db6955c5ad7e8fd03f7a52f8df84f943a9b8
Gitweb:        https://git.kernel.org/tip/ec64db6955c5ad7e8fd03f7a52f8df84f943a9b8
Author:        Sergio Paracuellos <sergio.paracuellos@gmail.com>
AuthorDate:    Tue, 12 Dec 2023 10:34:43 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 23 Feb 2024 13:22:45 +01:00

dt-bindings: timer: add Ralink SoCs system tick counter

Add YAML doc for the system tick counter which is present on Ralink SoCs.

cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20231212093443.1898591-1-sergio.paracuellos@gmail.com
---
 Documentation/devicetree/bindings/timer/ralink,cevt-systick.yaml | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/ralink,cevt-systick.yaml

diff --git a/Documentation/devicetree/bindings/timer/ralink,cevt-systick.yaml b/Documentation/devicetree/bindings/timer/ralink,cevt-systick.yaml
new file mode 100644
index 0000000..59d97fe
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/ralink,cevt-systick.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/ralink,cevt-systick.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: System tick counter present in Ralink family SoCs
+
+maintainers:
+  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
+
+properties:
+  compatible:
+    const: ralink,cevt-systick
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    systick@d00 {
+        compatible = "ralink,cevt-systick";
+        reg = <0xd00 0x10>;
+
+        interrupt-parent = <&cpuintc>;
+        interrupts = <7>;
+    };
+...

