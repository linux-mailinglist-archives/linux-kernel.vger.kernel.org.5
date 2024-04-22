Return-Path: <linux-kernel+bounces-154105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9348AD76D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79A0F1C20E3E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BD5374F7;
	Mon, 22 Apr 2024 22:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gTHixTav";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OU4b50UA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7001F94D;
	Mon, 22 Apr 2024 22:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713825912; cv=none; b=E2FeQgdAKZ64exzq1rWtLwb2uDo7ZC06i13p97hI/T2cIKux9TDrMHH5bXCJJYcMkVcw3HqNJtiNad45b02Ufrt2wy/ZR18f7ioX4Os9cixzS9bs0NwxzviMevL3Pxjsd8scmKRLv7A8YKlZIhMlzPBD7HTKQNxq8hJbK8i1EjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713825912; c=relaxed/simple;
	bh=AKVmnA3nU7E2udoGSs+iwhvY3DADmq/+jp9AdJow9hU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hQe95DKO6ZA4c0H7t32lfFuf9OKDm/ujISURPgXann8GBCt1zxlLchFykZ8vbM+PPbt7nyja97nYplldkeK+0zDEEupx5SGaRVTYDXGWBq0EkoREYtj3/8EA3UQldbiqND/Nj1M0KDv8h1k/iij6R24Hf44yBHCVXNYsfLBCOs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gTHixTav; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OU4b50UA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Apr 2024 22:45:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713825908;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1eBPDeJPst0YCwhIioubgVKl6zQZ23B8p+6/wiQ9f4=;
	b=gTHixTavDkoAWRuG/8Dl8MIjZZGwhtnw+m9fyXYyqwGcIfQgAJF+bI7LgMUc2FIHcb9Cb6
	8Mhq4S+kDBPOFzGO7DBojFoc/cFewU25woT7dnoE5G+8aSTubn7qb6eiz6I2vPizaCg/UW
	55b69Mq61hlOnTPeYUmbe8xka866B+DqSQg9wuQ99FHU278o2AVjfYpY8n1anP4merCE+d
	+j09yJouQH7u5XwtjYK+yhz3ClKkKrSaRJQdfUTjU6UKRGXOsuD4XdQR63TC7GVKiKAu3Z
	YPcJyG4gbff56rZJFQXdmTA7mHPB+aY1GRKlu0ZNeHbUC2t9VmIeMXI3jt8MZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713825908;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1eBPDeJPst0YCwhIioubgVKl6zQZ23B8p+6/wiQ9f4=;
	b=OU4b50UAI2CDi8Hwd6whE34CBH2Qwqb2BiLBXD38SM0KwS2+Nqs9yfAIFqjG9zT6OE3TYP
	yl2JKkDxlGVYdACw==
From: "tip-bot2 for Antonio Borneo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] ARM: dts: stm32: List exti parent interrupts on stm32mp131
Cc: Antonio Borneo <antonio.borneo@foss.st.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240415134926.1254428-10-antonio.borneo@foss.st.com>
References: <20240415134926.1254428-10-antonio.borneo@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171382590753.10875.2152269232797137612.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     283f86483f45724aaf80ea84712f02e2402b2b90
Gitweb:        https://git.kernel.org/tip/283f86483f45724aaf80ea84712f02e2402b2b90
Author:        Antonio Borneo <antonio.borneo@foss.st.com>
AuthorDate:    Mon, 15 Apr 2024 15:49:24 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 23 Apr 2024 00:28:15 +02:00

ARM: dts: stm32: List exti parent interrupts on stm32mp131

Stop using the table inside the EXTI driver and list in DT the mapping
between EXTI events and its parent interrupts.

By switching away from using the internal table, there is no need anymore
to use the specific compatible "st,stm32mp13-exti", which was introduced to
select the proper internal table.

Convert the driver's table for stm32mp131 to the DT property
interrupts-extended.

Switch the compatible string to the generic "st,stm32mp1-exti", in place of
the specific "st,stm32mp13-exti".

Older DT using compatible "st,stm32mp13-exti" will still work as the driver
remains backward compatible.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240415134926.1254428-10-antonio.borneo@foss.st.com

---
 arch/arm/boot/dts/st/stm32mp131.dtsi | 74 ++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stm32mp131.dtsi b/arch/arm/boot/dts/st/stm32mp131.dtsi
index 3900f32..c432fe1 100644
--- a/arch/arm/boot/dts/st/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp131.dtsi
@@ -1093,10 +1093,82 @@
 		};
 
 		exti: interrupt-controller@5000d000 {
-			compatible = "st,stm32mp13-exti", "syscon";
+			compatible = "st,stm32mp1-exti", "syscon";
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			reg = <0x5000d000 0x400>;
+			interrupts-extended =
+				<&intc GIC_SPI 6   IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_0 */
+				<&intc GIC_SPI 7   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 8   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 9   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 10  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 24  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 65  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 66  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 67  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 68  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 41  IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_10 */
+				<&intc GIC_SPI 43  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 77  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 78  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 1   IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 3   IRQ_TYPE_LEVEL_HIGH>,
+				<0>,						/* EXTI_20 */
+				<&intc GIC_SPI 32  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 34  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 73  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 93  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 38  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 39  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 40  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 72  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 53  IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_30 */
+				<&intc GIC_SPI 54  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 83  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 84  IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,						/* EXTI_40 */
+				<0>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 96  IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 92  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<&intc GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_50 */
+				<0>,
+				<&intc GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,						/* EXTI_60 */
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 63  IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<&intc GIC_SPI 98  IRQ_TYPE_LEVEL_HIGH>;	/* EXTI_70 */
 		};
 
 		syscfg: syscon@50020000 {

