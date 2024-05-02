Return-Path: <linux-kernel+bounces-166269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D59258B9850
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01F451C21B84
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080F15FB95;
	Thu,  2 May 2024 09:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="G83L8kMo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cwTKPMKo"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1E358AA1;
	Thu,  2 May 2024 09:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714643984; cv=none; b=MjTvX0rSOp3WG/Iv4X4SbQtaHxin0FJeMlrjZofWAjzNn0prWC2fG4O3MTSnLcDDh4t/+J9I+pReG7mEZ0wN0h9hDnRHExDTBR7C/wJqH44qva6IcFDsfzLqnKhtQ5Kk7RPheI1Y9fJuJe/S76Q+/qNz6tdRblywU32tFmL59Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714643984; c=relaxed/simple;
	bh=FOfpkZ1jw8FR3LMyDtmcF92PGea133W6fq2rKRby+wo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eyb7ac9ROkUw7I7e61wL1liW2GSXbFHcBjHJAmNDionp8IjiusSP8q7Po2jfzn29KIc23jQdZSAHORFoo5jBfnW+zvVV+fGHjDen6nYhhc+nHBKmueSFcb9ly3APF9xtwDeVcgvQLZXYWMZlK6q03DZpGsozdp2JpDc5g4QReuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=G83L8kMo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cwTKPMKo; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 279FB114014E;
	Thu,  2 May 2024 05:59:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 02 May 2024 05:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1714643982;
	 x=1714730382; bh=Wl9g44xy9WnUazfe5zftCh7sZzwGSfuHNWg8YozgAjM=; b=
	G83L8kMorREd4pfcD5auqzqFfKX0inrNYLqq4s/T2jiWBlxo9DbgQdqv3PaotnL+
	0/4qXMp7wNA16lhPB7/KjMhvG4Hqusl2OTH4WMTlBmpUiJSoVFLIN3xJx0kVB//U
	g/tenperUdv7Kpo3SrROPj5WeP9P06XcmX+F0One11YOV93NSbsj5RLQF5Eo9rwY
	6Sx2inGE38Q11UPHSDtnhRSbyv+7Ttnldc6VI6YKCnYUdsxDpSva/oV0RxLXrIlB
	9O76IKEO99NTjO9uV7Shu/Dw06LM33ZCOWGCD8sFiZ7tTKgNHU1OInowxJI3ALEq
	MjxWD2s8RPAfnEXxmQ60Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714643982; x=
	1714730382; bh=Wl9g44xy9WnUazfe5zftCh7sZzwGSfuHNWg8YozgAjM=; b=c
	wTKPMKoBzfEPY9/kmdjlX7sCJbI6iPrVs0B5sKMgTEtYygcxNENnNb+scDAtVceQ
	EAHo1Osv9uH1v+M0WmRtrGWVxSXiB3fLXQvWKONcyEkMAptsoETFUKJy4KoNRnxk
	3BqF2FmInDOWaBBxb5aFXW6AUdgiyY4fkLyQvbwwO1SUERKG2G7wnImTByjOGTSQ
	ZOZoB8VrM1cFtVT2tGHCD1M/jAuZgomFsg4ndzD2gP+c9JRejB/27d2H84xTvteA
	PYeNHkqkDZWZEF51kxo8ZvaemGaX1WDQOF4G5D+kfJsMQbnHMcuYmFFKWpIvLR5E
	MhBIhs/BXA7NAg7GJYlIw==
X-ME-Sender: <xms:DWQzZm2Ux2CQAWKNohrIVNXgo8oVT-gougAUzCI9MBtHygiScar6IQ>
    <xme:DWQzZpE8xiaNtHGofNVwDmabIjVwKCq1FjsME1Kjx5uCygp13Zts_YEjRtflCk4zU
    7_DMabqGxQHwZ2syF0>
X-ME-Received: <xmr:DWQzZu5n3ic0BE1vEEN10H7LoswtVIyjmmjNdRuUFk8EYe0KeIDPHXI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddukedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepveevteehgefggeejkeejtddtteeuleduheevjefgjeetvdfh
    udegtefglefhveeknecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:DWQzZn2AXUM88uVyju5T_nGoio3wiMNiwYYNHgrnzpd2TDfOpNycFg>
    <xmx:DmQzZpHHv8UaZTPToZ_PW7qwQWHQtlDYl6IL-biW7yqBTUIwOzozSg>
    <xmx:DmQzZg_bhrhfyUocgYAd1Ec0pZefpSOAu8RyoSA_RoATgO-n0mVUUw>
    <xmx:DmQzZulQrCA-otAqnLBNTHuuYocPoz5a5vrC_XnEQqz0KGhD4-D56Q>
    <xmx:DmQzZiOZOkpq2yd0ntWGgM2FUGDxNvTXEn6066dr-UShBoX3Wf5cAvTc>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 05:59:41 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 02 May 2024 10:59:32 +0100
Subject: [PATCH v3 5/9] MIPS: debug_ll: Add Kconfig symbols for some 8250
 uarts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240502-mips_debug_ll-v3-5-3b61f30e484c@flygoat.com>
References: <20240502-mips_debug_ll-v3-0-3b61f30e484c@flygoat.com>
In-Reply-To: <20240502-mips_debug_ll-v3-0-3b61f30e484c@flygoat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3115;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=FOfpkZ1jw8FR3LMyDtmcF92PGea133W6fq2rKRby+wo=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjTjFHbl4qoZCadWVP6UKgsWY2fJ/X9BMnv76XUX3/Lva
 JWyMznaUcrCIMbBICumyBIioNS3ofHigusPsv7AzGFlAhnCwMUpABO5+J7hr8BXBokrQb/mFb4p
 lLnyPe9S6l7VQ59eLZhpU/aS/3n2ByaGf3oucvuqxUS5LHP+2b1ad0mNV/rU1OCUTKvyZt6z4oe
 WcwMA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Define platform symbols for all 8250 style uart type supported
by zboot, plus Loongson-2K and boston.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


