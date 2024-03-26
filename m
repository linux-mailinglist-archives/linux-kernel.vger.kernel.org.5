Return-Path: <linux-kernel+bounces-119936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B51A88CF1C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A913B2641B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0990613E024;
	Tue, 26 Mar 2024 20:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="jUNmDgaw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uRG2P3Vr"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A17013DDD9;
	Tue, 26 Mar 2024 20:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485343; cv=none; b=J89+Ihmfwaz+s9d/OqCL70GqRmEVoZdQzwza2zQaPB2diFTfDSb2P16SF4OAjRt/8OKpJ3uSqPEjfi4lsipaBGBHARDarYvpboQHJL0K4YAWjgWayfKNB1kDFojLz1p64lKSEwyJCRLw6uutAub46CEF9wMseE7f6274br6heIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485343; c=relaxed/simple;
	bh=BBomUg78OZxYpqgzbaZi9r0/KZEWgWAOBqW6Gaf5Kjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mx7/HRm3Yw20l2MZxyTw1iooRX4dGloJtod8YZVP18NvAZdPx1Y1BkNolRUGTR/vHJyR41JX2HtvcQKqznBxY5oCnyaEN5BxRA4w5ye2sU/y+HwLte4pzvatpAhLNIo4I5dM2IbuPjOeifflo7l+awZjJ4F6HrYsUG7LJtRqzXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=jUNmDgaw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uRG2P3Vr; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 08B3A5C007E;
	Tue, 26 Mar 2024 16:35:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 26 Mar 2024 16:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1711485341;
	 x=1711571741; bh=nwDi7G8YoCLKQtKQNySfnFuMFDqBzeBBPzRHijBNdnI=; b=
	jUNmDgawkc3Qg8SwoQcCm/h7MgPSZhbKisR5m2wyteS0kv74Nv37j+OWJ8boLZ3p
	3NSpP22YWzdGh7iwEv63iR7uPdCQF4+Mrj4xYiG4UvJy4aYJLhx4OVU9mQQL0xFz
	ATg3FNgUNakby80awVIq2ugRO13FPG1oJ6c3G3P8CBwv/peEe+F3GWvV/Sb6KCiM
	IedKFeE7/rvmUX7Lekav8BA6XdTwxkyNPpmliOsWRFT9aK9is/xwGZ/yzycoFZ88
	4wn9FC0And2KNAw8+KE7cwLPIRKr7ChWBLrvbVJjpGplJKM49L2459wzBmW1flIS
	nvQvJDU29ClA3uFGOHDz3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711485341; x=
	1711571741; bh=nwDi7G8YoCLKQtKQNySfnFuMFDqBzeBBPzRHijBNdnI=; b=u
	RG2P3VrG/zmh9HKJo39NPm6veIgIYv005lFPyXrfySs7aJFeR+dLUuvM0iKOah6P
	yZiC4xYKGtZ3wguIIZSIUS81ot5E4+qTvq88JyLlC5OcbSQuU+rT+keLwncuWHzO
	ku3IXEnunOL8DigsLNlSescvskgqcHAxR7JmmFc22QsiO17JqEZU7xnL6Kh9DZP9
	+XJeJuE1UdCejGOI9d7sZb09zaQfj3yeD13f+fTVho8jqMUtPw5ynkHjWFYxoXJ+
	HxiZmpmhX2NgctI1PAIoVVGAo1qXVszXwnHn/D0M/f9CJfYysRtMDE24c5NGYMsi
	ZktVV7w1V/bql+turhNtg==
X-ME-Sender: <xms:nDEDZjb5Jx45N2MUv4yy7h_rflMr3rBW8uadtjpl7OQ4Z9-_2qytLQ>
    <xme:nDEDZia8qZoKSZ_eSCfA8hmUaOBVU_SleHOpFrNL-0pkGelg06CT5vCGkjD0PQfp9
    CLRsc_BrV4p5g6Wp-k>
X-ME-Received: <xmr:nDEDZl-Yt7cVNfgxNOom6JM35eK7YXLAHdp4qYxhLYCj2WpFlTOCezU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
    ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:nDEDZpqmiEqGJmF8_9NBYF7XXJYslBcNoXai_0mx1Mdf3Hg0Keg2ZA>
    <xmx:nDEDZuoPGeD-LEgI70Nz0FC7iMlUvNSBBeGvFTow7qIoJZGWVGDKBQ>
    <xmx:nDEDZvSelgc-va_4AUHdj4jNaUwp9myTYtx-cxKlo71cERUG12Yd7Q>
    <xmx:nDEDZmp3fiGY0TBy5Ah-Y1jIaBAsD6L01aKa65CIaCjLqH7pq_PW8w>
    <xmx:nTEDZnnJu0pswGXP5B-NZHPQInSA5p702h3JUo_bhR9Fzq-C70j2GQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 16:35:40 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 26 Mar 2024 20:35:37 +0000
Subject: [PATCH v2 5/9] MIPS: debug_ll: Add Kconfig symbols for some 8250
 uarts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-mips_debug_ll-v2-5-b64abc76f2a1@flygoat.com>
References: <20240326-mips_debug_ll-v2-0-b64abc76f2a1@flygoat.com>
In-Reply-To: <20240326-mips_debug_ll-v2-0-b64abc76f2a1@flygoat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3057;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=BBomUg78OZxYpqgzbaZi9r0/KZEWgWAOBqW6Gaf5Kjo=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjRmw5mRSsXB/92+vVK6Mj1mzubWs757ev7PrZxVH/REj
 fvMv6iTHaUsDGIcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjAR2ROMDDcm6069nNO+KdfA
 9NJ+n+d/w3UYgu8n5WaJHZnwPbw74A0jw/RJJy7Pky4y/S3hk8dXuSFlctXUg3Hccs9m3LRmFGv
 exQIA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Define platform symbols for all 8250 style uart type supported
by zboot, plus Loongson-2K and boston.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig.debug | 56 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index 323ad3ec643b..3609d298a9eb 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -209,6 +209,54 @@ choice
 		  selecting one of the platform specific options below if
 		  you know the parameters for the port.
 
+	config DEBUG_BOSTON_UART
+		bool "Kernel low-level debugging messages via Boston UART"
+		depends on MIPS_GENERIC_KERNEL
+		select DEBUG_UART_8250
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on IMG Boston board.
+
+	config DEBUG_MALTA_UART
+		bool "Kernel low-level debugging messages via malta UART"
+		depends on MIPS_MALTA
+		select DEBUG_UART_8250
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on MTI malta board.
+
+	config DEBUG_AR71XX_UART
+		bool "Kernel low-level debugging messages via AR71XX UART"
+		depends on ATH79
+		select DEBUG_UART_8250
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on AR71xx based platforms.
+
+	config DEBUG_LOONGSON3_UART
+		bool "Kernel low-level debugging messages via Loongson-3 UART"
+		depends on MACH_LOONGSON64
+		select DEBUG_UART_8250
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Loongson-3 systems.
+
+	config DEBUG_LOONGSON2K_UART
+		bool "Kernel low-level debugging messages via Loongson 2K UART"
+		depends on MACH_LOONGSON64
+		select DEBUG_UART_8250
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Loongson-2K SoCs.
+
+	config DEBUG_INGENIC_UART
+		bool "Kernel low-level debugging messages via Ingenic UART"
+		depends on MACH_INGENIC_SOC
+		select DEBUG_UART_8250
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on uart0 of Ingenic SoCs.
+
 endchoice
 
 config DEBUG_LL_INCLUDE
@@ -239,6 +287,12 @@ config DEBUG_UART_FLOW_CONTROL
 config DEBUG_UART_PHYS
 	hex "Physical base address of debug UART"
 	depends on DEBUG_LL_UART
+	default 0x17ffe000 if DEBUG_BOSTON_UART
+	default 0x1fd003f8 if DEBUG_MALTA_UART
+	default 0x18020000 if DEBUG_AR71XX_UART
+	default 0x1fd003f8 if DEBUG_LOONGSON3_UART
+	default 0x1fe00000 if DEBUG_LOONGSON2K_UART
+	default 0x10030000 if DEBUG_INGENIC_UART
 	help
 	  This is the physical base address of the debug UART. It must be
 	  accessible from unmapped kernel space (i.e. KSEG1 for 32bit kernels
@@ -247,6 +301,8 @@ config DEBUG_UART_PHYS
 config DEBUG_UART_8250_SHIFT
 	int "Register offset shift for the 8250 debug UART"
 	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
+	default 1 if DEBUG_MALTA_UART || DEBUG_LOONGSON3_UART || \
+		DEBUG_LOONGSON2K_UART
 	default 2
 
 config DEBUG_UART_8250_WIDTH

-- 
2.34.1


