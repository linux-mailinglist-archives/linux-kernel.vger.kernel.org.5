Return-Path: <linux-kernel+bounces-154112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2718AD77C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4231F2278C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E684644C;
	Mon, 22 Apr 2024 22:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kk9oT1fc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wOpgT/ya"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E125144C64;
	Mon, 22 Apr 2024 22:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713825919; cv=none; b=bzacCxITp2F/AOQHncGEeFZ4LPlOUHfo0fhUwv/H8azVdEXQxPSYfc7myg/A+iGvJW19hsqTML4Z7pyytKAgK7CeBIXlGz1+GxtDD5SLQNHAPAWyQD33BPDOI+UF/bcWxWqI8C2Lst0KU1V9aMGjOgTPkP+2psL9mAbHhTMy1IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713825919; c=relaxed/simple;
	bh=j4rD7blzhMJPc0OZ/TP57rhGazTshBpp6zmBhbU1sbw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AUL5ju+3mIQ0em0fMA3I58Z9JL1euq2rrN3qPjk1TxVgQA0A3aaZAJCul1XKUskA2X+M89hFHUCtCTBorMUQm0cQDPiZf88ITpfZU7Pj2lzo6/zgUSjLFfV+MzE/5Aox2lF5V9wEcjWUb7gYf/FqxSZEdGaaYR3DTcCFMnPIcbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kk9oT1fc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wOpgT/ya; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Apr 2024 22:45:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713825915;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uM12Oq7Ipw/Ycd8ENw3FXESI0OoJb7FfZRiRt4t6W04=;
	b=Kk9oT1fc4AzFO6js4J7ofFi2bslWgHJilIbcr/4MQmFA8VIAS4i31I7iWHR7SWLtlqQi/9
	CxLc7mEYltj9VjeG+RXLAtH1WYfAiBgzWUg0air/Q6jQEICLf7ERIYQu5R8aSP/SSxBjgv
	pF5wb511vKDF9QLy09RoQqp26KMqtarnFxxHNDDcwhx7ft0l5vqfHv3tnK1irXQV2KyDf5
	qYTQfNGz+JqE6TCfsXRy0N0V+uB1YTEjq1E6AlhfFyj3/ljgpf7tYLD/XeHYs6nSuN5Xa1
	Cx0Ym3+kKP+/ifiEw+n/hjAKc7bWKMMOYsz6aw4yy8QTYtZbhJeCFYN8WDzUYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713825915;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uM12Oq7Ipw/Ycd8ENw3FXESI0OoJb7FfZRiRt4t6W04=;
	b=wOpgT/yalzEXskBrjb037eSvi5HuiS5uUz+p/zTtGBfYuDnvfF/ATvVei4Dn3X/N56V62c
	hsmzNjLuoeJ899AQ==
From: "tip-bot2 for Antonio Borneo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] dt-bindings: interrupt-controller: stm32-exti: Add
 irq mapping to parent
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Antonio Borneo <antonio.borneo@foss.st.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Rob Herring (Arm)" <robh@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240415134926.1254428-3-antonio.borneo@foss.st.com>
References: <20240415134926.1254428-3-antonio.borneo@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171382591472.10875.17922057700794997100.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e9c17d91e6980993711eebe0c914fbd31298b94e
Gitweb:        https://git.kernel.org/tip/e9c17d91e6980993711eebe0c914fbd31298b94e
Author:        Antonio Borneo <antonio.borneo@foss.st.com>
AuthorDate:    Mon, 15 Apr 2024 15:49:17 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 23 Apr 2024 00:28:14 +02:00

dt-bindings: interrupt-controller: stm32-exti: Add irq mapping to parent

The mapping of EXTI events to its parent interrupt controller is both SoC
and instance dependent.

The current implementation requires adding a new mapping table to the
driver's code and a new compatible for each new EXTI instance.

To avoid that use the interrupts-extended property to list, for each EXTI
event, the associated parent interrupt.

Co-developed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/r/20240415134926.1254428-3-antonio.borneo@foss.st.com

---
 Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
index 00c10a8..9967e57 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
@@ -89,8 +89,23 @@ examples:
         reg = <0x5000d000 0x400>;
     };
 
+  - |
     //Example 2
-    exti2: interrupt-controller@40013c00 {
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    exti2: interrupt-controller@5000d000 {
+        compatible = "st,stm32mp1-exti", "syscon";
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        reg = <0x5000d000 0x400>;
+        interrupts-extended =
+            <&intc GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+            <0>,
+            <&intc GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+    };
+
+  - |
+    //Example 3
+    exti3: interrupt-controller@40013c00 {
         compatible = "st,stm32-exti";
         interrupt-controller;
         #interrupt-cells = <2>;

