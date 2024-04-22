Return-Path: <linux-kernel+bounces-154103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E898B8AD769
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A081C21141
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8947A20DFC;
	Mon, 22 Apr 2024 22:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f+nb5g70";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VhCKKd2A"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8770621105;
	Mon, 22 Apr 2024 22:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713825909; cv=none; b=afzOLGFx97T7q4WNS1ImT0eJ158zU0iZHCK4XgRyKFO5W85MFV7BQjAtL1i2QqC3fhSXn/SSCaPcvNJuC+mN5GBsryW0ydARuYA9qAx2zyfSG+kHcWpYAYpgPXrS9CXwaDNN/f7Gv1OW7p8A/NNgxFbyGQBMWfTFnLJ8EE4TBUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713825909; c=relaxed/simple;
	bh=2e/r5JrZxxFtB8OP+nXi/R2bonpKgDuBDlR3eXlLMcE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EQq4U/5OoidVjdl2wC9y4UcLlVJTSl8p4BoUHM/PVpnbQOnIX5HuDTUeD7gb3llZQpeEa5fadjxOmdc2ydXM+pFi52CIE/7JrL9918cXl0U0yYdVd/B/yzNoluO6dfUWSpRZZLQenLo68Nz7eoxyzFL2rtgkA30Grvv2Ce8EOXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f+nb5g70; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VhCKKd2A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Apr 2024 22:45:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713825906;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ZYJdt5C4o9SaqYmrAWBEmoNHbcJIcsCz59TkN74CEI=;
	b=f+nb5g70fanv91hA+CELCDWjbf+GcpKr94au9sCR1TydcKZd/CjpJvvm3IPD1tzyvwhVWW
	IHjGNmc1vPAzqwb8A+PWI9nTjcbUekcwm+s3GyzjdvGbZlxmxFOPishfSI5Pu5JFLStfqB
	Q59NxR8yxGewweS77hQ8TyeQBbu/U/7Mcy7TVQ2UDdfEawP4jFpewYYyENZC5Rq4vn400T
	2VVBxGzk5mgrz2VoMIrBg9Dfc8058KWgApnno1O+0DuKUn1rMHxbJGTyKP0fs3fY9TMkL2
	tmbPXbd6xmqaZLPM5TLNSAD3T/f6OYCCV8x1KIJDih+AOQEMguuPGgmVjZteqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713825906;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ZYJdt5C4o9SaqYmrAWBEmoNHbcJIcsCz59TkN74CEI=;
	b=VhCKKd2ARKVXexwfYiZcxmshqdl8yRd64VvORGpK5WwmE0g0B7Qqk4CdQRstTK2rK/d4T8
	INGLOqkVhQgNLQBQ==
From: "tip-bot2 for Antonio Borneo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] arm64: dts: st: Add interrupt parent to pinctrl on stm32mp251
Cc: Antonio Borneo <antonio.borneo@foss.st.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240415134926.1254428-12-antonio.borneo@foss.st.com>
References: <20240415134926.1254428-12-antonio.borneo@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171382590543.10875.6779801776975672013.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     7da4ba315e3980ca3e87d40a10908f716f026d2c
Gitweb:        https://git.kernel.org/tip/7da4ba315e3980ca3e87d40a10908f716f026d2c
Author:        Antonio Borneo <antonio.borneo@foss.st.com>
AuthorDate:    Mon, 15 Apr 2024 15:49:26 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 23 Apr 2024 00:28:16 +02:00

arm64: dts: st: Add interrupt parent to pinctrl on stm32mp251

Add exti1 as interrupt parent for the two pin controllers.  Add the
additional required property st,syscfg.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240415134926.1254428-12-antonio.borneo@foss.st.com

---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index 1426446..e7d1614 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -271,6 +271,8 @@
 			#size-cells = <1>;
 			compatible = "st,stm32mp257-pinctrl";
 			ranges = <0 0x44240000 0xa0400>;
+			interrupt-parent = <&exti1>;
+			st,syscfg = <&exti1 0x60 0xff>;
 			pins-are-numbered;
 
 			gpioa: gpio@44240000 {
@@ -400,6 +402,8 @@
 			#size-cells = <1>;
 			compatible = "st,stm32mp257-z-pinctrl";
 			ranges = <0 0x46200000 0x400>;
+			interrupt-parent = <&exti1>;
+			st,syscfg = <&exti1 0x60 0xff>;
 			pins-are-numbered;
 
 			gpioz: gpio@46200000 {

