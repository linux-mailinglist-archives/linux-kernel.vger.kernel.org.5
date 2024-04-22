Return-Path: <linux-kernel+bounces-154106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EC98AD76F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47D26B21346
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28A23BBC3;
	Mon, 22 Apr 2024 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2+bDKMsD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7hxhXPfW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE662576B;
	Mon, 22 Apr 2024 22:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713825912; cv=none; b=lwm/q9UPgUnQ/uovpgx+BOzP2H0PsdJCORXVgWHIX9+8oLfijTfblXg1dQNt1SKD8SQGMQuVn/i5krsuJgvcBpJoA0PF5MQf6cMoWqzK0fVfM3xWr45xl/xV6/RqadClORojlZWpHrUXhjnKgrqHPNOOD+PascTTVqMUWsq9xtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713825912; c=relaxed/simple;
	bh=14HWNJwyYwK1osHOwFe+HNo605T7Kw4QyVEPq+En4xk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=E7yk49+rtSELfGYYVa2o8+Dhhkjjfl73abfHDxV3CETdmTZzBmp69QkJV89zTSBKK6+0uuwbmlcB7fLjoSR9BDjvtB1xCb770de4AMKYcgXE2INYDohGBEIkBAHgm8qxyz4LtM2WI9MHnyjikoyYi+x+fIxf3u2onNQID62KKDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2+bDKMsD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7hxhXPfW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Apr 2024 22:45:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713825909;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nJCmBp2erb2wlwXzCGewgQJza/6RNU7Gu8tcS3tYaIo=;
	b=2+bDKMsD8KfPxswiknrtkZKr4knIPhTkS5pBPo1lMoseWIW0PHDLIq+7wdtVm5OUcSL1JL
	0F2vKAfh7QfmOpfY6B6HOn+gmIXLjODG2+j4jR4/6+4Y5ZZJBZ0q5BE5yBvC/oWKlco+x7
	oKPrBXduG2lOdp0ViJ9GxU7yInAyCsrI+VqaPYOov49azcWVZDtPMwV8hQxULBNCUMXiqF
	nLbRaSf7CQKVpz0iyKh/aUItWGsVijU/z3kn1v7TjGwQcP//TFJ1Ms0iHTzjZgePmQL12H
	hvPALJDBwICW54kyWkAA+pBNFI5bC6yzZc5xdOY7sDEMAUT/tAL665tb2lCq2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713825909;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nJCmBp2erb2wlwXzCGewgQJza/6RNU7Gu8tcS3tYaIo=;
	b=7hxhXPfWwzpnkqWKVLFQzCCkfFRsQ1SaPJc0JHLakOGZpCJR96PpeVQjcdHdP5OQpQcvNP
	5nTLESuUwaGO6ZDw==
From: "tip-bot2 for Antonio Borneo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] ARM: dts: stm32: List exti parent interrupts on stm32mp151
Cc: Antonio Borneo <antonio.borneo@foss.st.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240415134926.1254428-9-antonio.borneo@foss.st.com>
References: <20240415134926.1254428-9-antonio.borneo@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171382590856.10875.13715387865248476658.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     3fca3830b657045dee3a8c702b1c4f9c5d5f62cf
Gitweb:        https://git.kernel.org/tip/3fca3830b657045dee3a8c702b1c4f9c5d5f62cf
Author:        Antonio Borneo <antonio.borneo@foss.st.com>
AuthorDate:    Mon, 15 Apr 2024 15:49:23 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 23 Apr 2024 00:28:15 +02:00

ARM: dts: stm32: List exti parent interrupts on stm32mp151

Stop using the table inside the EXTI driver and list in DT the mapping
between EXTI events and its parent interrupts.

Convert the driver's table for stm32mp151 to the DT property
interrupts-extended.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240415134926.1254428-9-antonio.borneo@foss.st.com

---
 arch/arm/boot/dts/st/stm32mp151.dtsi | 75 +++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp151.dtsi b/arch/arm/boot/dts/st/stm32mp151.dtsi
index fa4cbd3..bcb3ed9 100644
--- a/arch/arm/boot/dts/st/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp151.dtsi
@@ -1224,6 +1224,81 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			reg = <0x5000d000 0x400>;
+			interrupts-extended =
+				<&intc GIC_SPI 6   IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_0 */
+				<&intc GIC_SPI 7   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 8   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 9   IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 10  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 23  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 64  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 65  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 66  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 67  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 40  IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_10 */
+				<&intc GIC_SPI 42  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 76  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 77  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 1   IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 3   IRQ_TYPE_LEVEL_HIGH>,
+				<0>,						/* EXTI_20 */
+				<&intc GIC_SPI 31  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 33  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 72  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 95  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 37  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 38  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 39  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 71  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 52  IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_30 */
+				<&intc GIC_SPI 53  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 82  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 83  IRQ_TYPE_LEVEL_HIGH>,
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
+				<0>,
+				<0>,
+				<&intc GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 93  IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<&intc GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_50 */
+				<0>,
+				<&intc GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+				<&intc GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,						/* EXTI_60 */
+				<&intc GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<0>,
+				<&intc GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+				<0>,
+				<&intc GIC_SPI 62  IRQ_TYPE_LEVEL_HIGH>,	/* EXTI_70 */
+				<0>,
+				<0>,
+				<&intc GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		syscfg: syscon@50020000 {

