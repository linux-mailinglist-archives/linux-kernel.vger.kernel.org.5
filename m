Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E557D3FFB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbjJWTO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjJWTOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:14:18 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E31510C;
        Mon, 23 Oct 2023 12:14:13 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.nyi.internal (Postfix) with ESMTP id 05D615C0399;
        Mon, 23 Oct 2023 15:14:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 23 Oct 2023 15:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1698088453; x=
        1698174853; bh=U85JK5asZNHXyazqwXB2WH7hdrGFnY8ew4l7GY3z8ws=; b=J
        HGnVzxbsQN1dNFQ/3+udQO0s2OJOp/w6OjzjV6V3zHQcTwXS/WW4qPAku1MQRznF
        gKAeX2mUqez6v7r24PEg58TFbZc3z79MD3tfgywgjgY0EsJk3w6j27myWvD6VCUj
        7hiVFjarxqiPDMgQaDVpkENTjjZqQcY/zGJqltibOUXpRWTKIdttsYiGuGI/EG2u
        CLWbZ5LdsVCCn35YtZZjH6cHyOILg1D+lATI4lFjmOHrO1M5oLKPmq0oiGgKNSgC
        YWkxz0eXy07OlvsdbzaDPyQNlARZNo95N99tjTzgGtpEwZN8F55TPPzHfC/G1+Xx
        pWk44/apOPZnlz5FcyMcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698088453; x=
        1698174853; bh=U85JK5asZNHXyazqwXB2WH7hdrGFnY8ew4l7GY3z8ws=; b=j
        PQDcZFCJqJfqjhXf16QctX5HJVp4BAkG//lGz9g8oI4rfl3X0G0ChlJF0V3XVtiD
        nevi5ZEaxxQ52tm0wFMWzxoQpbRGe4A7fuRPTsuFudRkGfmAVClW8izrJZwYIT3S
        HaiK2HqdPnPrNvaMEDjt8Ttvqf3WIgocM74K70SpbsK0IS+H4UQggZJfh6x/RAIU
        Xcjodsl4vt8Jruztlcf9vqvOHH7V567YfY7M8eWPe4MNs5jT1+7+qYysusWOi0Rd
        8Om1bcTKHRoRlkSf7UmrZDBucN3qwGjQEhpXCoRa8fnpmMyZRR71X3wAnHC99FgW
        RLvCwYyVbqzjJlXdE6agA==
X-ME-Sender: <xms:BMY2ZcEyhurCuOxPQWaVeOGQKNhXHb8MeIGiKoxWBFwqJD5hIJ2a8g>
    <xme:BMY2ZVUen9zGYaaOU0K-J2finLDoclVHI6wj7xDJKwTYqRa3W5AsZgUvihqYwoiCm
    pEFX7wnZGAtnr6oNck>
X-ME-Received: <xmr:BMY2ZWKgvIi13i7XSQwnjDgHEzv9iHb2JVUks2gg0czTOd0hgd905hls6ZbiMrCaQwhu3prpoKo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeeigddufeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:BMY2ZeHBo8vg3qmK204uvJ-K3tpZemIrY4dzeTGGTSSocer1j32JGg>
    <xmx:BMY2ZSV3meq5IkGf0VDtDatHvxwR8i8x9SASZcmuD4-MwFsx5TzPrQ>
    <xmx:BMY2ZROVZTEkitxvoUXAqKNI-VtJf-hASiWIshku-Bn2lbkc4Wi2Og>
    <xmx:BcY2ZQzC3MtasRKCQcDb2gdeYgHiMksmCp5JdP4ztfkU96m2EkbbZw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Oct 2023 15:14:11 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        gregory.clement@bootlin.com, vladimir.kondratiev@intel.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 5/5] MIPS: Allow kernel base to be set from Kconfig for all platforms
Date:   Mon, 23 Oct 2023 20:14:00 +0100
Message-Id: <20231023191400.170052-6-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023191400.170052-1-jiaxun.yang@flygoat.com>
References: <20231023191400.170052-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some platforms in wild that generic loading address won't
work with them due to memory layout.

Allow PHYSICAL_START to be override from Kconfig, introduce
PHYSICAL_START_BOOL symbol as powerpc did.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index bc8421859006..bfedc8b48a81 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2884,12 +2884,22 @@ config ARCH_SUPPORTS_KEXEC
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool y
 
+config PHYSICAL_START_BOOL
+	bool "Set physical address where the kernel is loaded"
+	default y if CRASH_DUMP
+	help
+	  This gives the CKSEG0, KSEG0 or XKPHYS address where the kernel
+	  is loaded.
+
+	  Say N here unless you know what you are doing.
+
 config PHYSICAL_START
-	hex "Physical address where the kernel is loaded"
-	default "0xffffffff84000000"
-	depends on CRASH_DUMP
+	hex "Physical address where the kernel is loaded" if PHYSICAL_START_BOOL
+	default "0xffffffff84000000" if CRASH_DUMP
+	default "0xffffffff80100000"
 	help
-	  This gives the CKSEG0 or KSEG0 address where the kernel is loaded.
+	  This gives the CKSEG0, KSEG0 or XKPHYS address where the kernel
+	  is loaded.
 	  If you plan to use kernel for capturing the crash dump change
 	  this value to start of the reserved region (the "X" value as
 	  specified in the "crashkernel=YM@XM" command line boot parameter
-- 
2.34.1

