Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA827DACA7
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 14:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjJ2NqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 09:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjJ2NqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 09:46:01 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4201EC0;
        Sun, 29 Oct 2023 06:45:59 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 6CC00320070D;
        Sun, 29 Oct 2023 09:45:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 29 Oct 2023 09:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1698587157; x=1698673557; bh=nwDi7G8YoCLKQtKQNySfnFuMFDqBzeBBPzR
        HijBNdnI=; b=yvHc5lKkndBP6FqeOcISAQQZkOSLPiPQQnNJoKoHhU0v8kC74at
        PmAmRybiLi+hSSIWDpn6ODsCpr26PQQHgoMbjPy4dQthL1u1cruvxboGKV9QKzVv
        /UyOe4B95ebsQsGVQViqzhbBziVBJBRo4rTcJh9AeNvQ0O5h+3zBVosxbb3Ww2WW
        G+dDyjvGJzD2ZmcUO2uQiHsGSLii4SHE9N4hRndbMHlOt9nfqrGk6cDIOKQYDbTj
        Z/ZdoHwvldCtAEK5kcl5CxZ3aIR4ncjmzL+KVnMYufDUAElLKEQSf2rNRGPQXUXv
        5e9Kvm8j3byvI5koynWePcR61CtIue9WHJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1698587157; x=1698673557; bh=nwDi7G8YoCLKQtKQNySfnFuMFDqBzeBBPzR
        HijBNdnI=; b=tGuQM+Skxm7klrHzJ47I8+qRlLt6ZLMMYv/DzH5VPSD8y8pUlwS
        cXIJ1ItFNqq3dImL3SnZZ1RAOREjYptNba6YNJJpa/7Shj9c1NhTg1OsYTMZDzjr
        T8Wt9KdMpnpkVTpfzVMnTZeUfKsqRl+sDOEu+Wv7MTpkhu/JJmg4hotjOLYRkCV3
        8i+iI9atzw5B7k0oLnDPE+TuQm1KWzti3FzGwL5MI5Tzxq3apw1lQq76u5t4o/Pc
        afKBWJJZF4nZ2/1tuEDMnnBpwUmyPrZn2aP/AwMHeY+BIV0KUQ+rJIFh3AGnm9YX
        z47JAp87fSlaIOzrylwlR+HaP+6K7Vtw+kw==
X-ME-Sender: <xms:FWI-ZRph0QQaINMTWc6qLbJksg7-vxHycyDalemyex00KbXf898pFQ>
    <xme:FWI-ZTrQUYJYX15DuJsG1BGl5YZzdzamwEAC8pcajp6YgA1KT1oOZeaLoKLrAcOWi
    vzKh1otrNa_Q7dQhCk>
X-ME-Received: <xmr:FWI-ZeMcwjb-TqC2tcgnAGElgzrY04mgvt4msjKdWZru3midP_U6m_E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleekgdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefhueev
    geffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:FWI-Zc6qwXYoliuXWBR42uoN3BUv03EjUJvH4WxZRZsv-J7zIENFQw>
    <xmx:FWI-ZQ6SFubZyYAkuJfNCycQJzA-7sfdJ_29K310VwsDpXapvWvBhA>
    <xmx:FWI-ZUhgo4g7L2SqykVoVnCXpXcAB2-zfTSt232K8plpk5zv0JDReg>
    <xmx:FWI-ZQGTcDgDHTyr5doJ5pAM7Ca3eY4tT-9ALcufZ_2aFGLsI4Swfw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Oct 2023 09:45:57 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Date:   Sun, 29 Oct 2023 02:53:06 +0000
Subject: [PATCH 5/8] MIPS: debug_ll: Add Kconfig symbols for some 8250
 uarts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231029-mips_debug_ll-v1-5-d7a491e8c278@flygoat.com>
References: <20231029-mips_debug_ll-v1-0-d7a491e8c278@flygoat.com>
In-Reply-To: <20231029-mips_debug_ll-v1-0-d7a491e8c278@flygoat.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

