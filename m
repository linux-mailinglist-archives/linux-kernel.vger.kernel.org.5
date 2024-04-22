Return-Path: <linux-kernel+bounces-154107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BA68AD771
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C251C20FD9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EA53D57A;
	Mon, 22 Apr 2024 22:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nW7Z8mKD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XbG27jcx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978633717B;
	Mon, 22 Apr 2024 22:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713825914; cv=none; b=Av+vunl/YI7/nyTZZx7GR+hrL5QKE9/rtvQhmvdymWBNf09f/mvJU2YyKcmZQCa+1tbf6S3drFXjHmeArKYm99AX8pdp0Ym0sKvGuKYtD+YvszjCGEUnf86rsV27qkJJHPA6u8c28z4eMF25VhWr5+hmye4ne4RCSLrlftNTWhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713825914; c=relaxed/simple;
	bh=AKwAmjjvklvmZVrlv7H3syMNcHbzKSqZBcx5Dnt9uek=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cvD9Rmb2yeCOtEZFnJJvD+KKIJ+JUqr3vT1yfMtEbNtW0NKK21glJvlZz8SZT/dX/bPedOdEzJzDeLF8B609tGfZeXB03SLX91LIca+njXqGfTs/YoEJ+aVppfhdDWiGSGging7sxFqbmI+pzFW5C/uGoRFjE3AVonggBwXPgJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nW7Z8mKD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XbG27jcx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Apr 2024 22:45:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713825910;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=spgt3qTiaYieVwu/2RoFj1QmPn9pWKajiXk4TB16Tuw=;
	b=nW7Z8mKDQ/V05YGJ8g40B4fa7pzh8WMfIczoTJN6e+NCJbWeMjrF0ItEMk5Mzu0DwSbzDi
	KbgCpFdIb5M4q7sFnDbhUMWbXn2PxtfvJ5yHznyAQ1Hc8c5potw9Y8apj/cqV+AwfrgmPi
	E+t8b/dYO6pHG1buVEGrlDZNJaX7UVenV2CT6a7OKwXAraUWGj6cBWuGotIqgyrstLTCqJ
	wjoqxKLlY+qSUW0s88gPL9FU0l6wVwmDLRUjAyCNaYDS3IHIWyKVvhrghxIdzcGK1Is0SC
	Dc+uzJ5OgvzN6ijg+OTgRrtoTbvV3lUCjPqVhSqnNi2W5iqZa//M9avOjss90A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713825910;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=spgt3qTiaYieVwu/2RoFj1QmPn9pWKajiXk4TB16Tuw=;
	b=XbG27jcxJrtuia1U8hjjGu/hqzQ+m6BJcahIVNjOVPBiaUCt7HvSVrmSshDnPqIvBSdWkz
	7weRWvo74ByOB7DQ==
From: "tip-bot2 for Antonio Borneo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] arm64: Kconfig.platforms: Enable STM32_EXTI for ARCH_STM32
Cc: Antonio Borneo <antonio.borneo@foss.st.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240415134926.1254428-8-antonio.borneo@foss.st.com>
References: <20240415134926.1254428-8-antonio.borneo@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171382590967.10875.601685086367642003.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f55e8e32566d9d66978f95152e9c141ffa5024ef
Gitweb:        https://git.kernel.org/tip/f55e8e32566d9d66978f95152e9c141ffa5024ef
Author:        Antonio Borneo <antonio.borneo@foss.st.com>
AuthorDate:    Mon, 15 Apr 2024 15:49:22 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 23 Apr 2024 00:28:15 +02:00

arm64: Kconfig.platforms: Enable STM32_EXTI for ARCH_STM32

ARCH_STM32 needs to use STM32 EXTI interrupt controller for GPIO and wakeup
interrupts.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240415134926.1254428-8-antonio.borneo@foss.st.com

---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 2433556..19bf58a 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -302,6 +302,7 @@ config ARCH_STM32
 	select GPIOLIB
 	select PINCTRL
 	select PINCTRL_STM32MP257
+	select STM32_EXTI
 	select ARM_SMC_MBOX
 	select ARM_SCMI_PROTOCOL
 	select COMMON_CLK_SCMI

