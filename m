Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D967DACA4
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 14:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjJ2NqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 09:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjJ2Np5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 09:45:57 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1B4C0;
        Sun, 29 Oct 2023 06:45:55 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 73D683200914;
        Sun, 29 Oct 2023 09:45:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 29 Oct 2023 09:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1698587153; x=1698673553; bh=nkW4taJQaUsRU866lha58WkbM4sO1ApMx1W
        OQCLwoj4=; b=W70be8GJ+XiQ5Rpdfmn+3ZRG050zZEgnxWKfzqBC1btiaMirs9e
        kJW2XMWoBb39R3GrNlSYQ7ISgI3E31TSDxw+iCKyz9xv5k/B/a2BEj2YadjufXkZ
        O7i1PGWJciX3esg16b6/HSlbsKnM33KCQi5pPPehsb9tIJzn04JkT8bRXpoIQd6/
        DsdU8z9ykJGlapb5M/kBfn3a1ldaB/YTqqG6VqeSqEYoasWgTxMDbbniV1qtMsjS
        YJRwr4TBckcxObIjjedu8P/2SuIVYA5Vd2D36PHL8I2sbFp5rwj+G18nQp2s6Z4p
        zy5chTnCbxR95nU/0B9Q6UdQ8eKHdpr+owg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1698587153; x=1698673553; bh=nkW4taJQaUsRU866lha58WkbM4sO1ApMx1W
        OQCLwoj4=; b=P2vGki3XTDzjvSr99YGyGE5GWN30BSSddhl4Yly4fXwnwPT+WD4
        EfNGzkjmFEI4iqQQXSnr03SLLJi31E7HDsi2AYQMh+eZT0g6UXzoFDyDw2dJgSUw
        rBpDaTeIxGNOdJo8uibuO5f8xgpAHpSWcrGZBr/oiBwfcTXpAyfFvfCo6MXHXwZi
        7+egwMrfjmUVbR90//2/nrtN6OVsB8Ayl9kVKcTZUNhBC9p1rI84d29YzJ74DZ36
        vmETjAUlCQhrfUNVohu02hJHEIbLvaOJvTgo737KpVSKbSlQE0o5Sewgyul64Hih
        d/AfHlNJoPfEMYRmLw7HYvtepj1IC0mEpWg==
X-ME-Sender: <xms:EWI-ZRtzAD8gHss7uvEYClEq4ayHkN9eYAK8pXQUGJktYq_BO6UGGA>
    <xme:EWI-ZadgdQmTF-UTPGuAbk61zPd7oiM5KXH3v_g2776eXQmt_TncjcUhV0Q8DxvvL
    avrRja_hUkCZFwKHKA>
X-ME-Received: <xmr:EWI-ZUyJJF_1Y3QqefXf1XbJqt6bdvS9qdYUV8xWK7_kHjuYAUwsI9Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleekgdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefhueev
    geffgedukeejleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:EWI-ZYMp3BTrB83Vn1DfHxFALsQgXzyh9d-Nzc3rsar1P2CulpCrqA>
    <xmx:EWI-ZR8jEcrD8tk8ihhfXqash2vPVBLnYLTHzLpgupbHE7hWKcuvTQ>
    <xmx:EWI-ZYVqVDINwFJUfjcaODBMVPpnjOlSJK1no1AkvdTAYOu0_kfuWA>
    <xmx:EWI-ZTLVS8KaLDizXyjP21vN1eFiLmGoTmIyWFXZSvityQivEXbSRQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Oct 2023 09:45:53 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Date:   Sun, 29 Oct 2023 02:53:04 +0000
Subject: [PATCH 3/8] MIPS: debug: Hook up DEBUG_LL with early printk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231029-mips_debug_ll-v1-3-d7a491e8c278@flygoat.com>
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

Output earlyprintk to low-level debug functions when it's
available.

DEBUG_LL takes priority over platform earlyprintk because
people must know what are they doing when they are trying
to enable DEBUG_LL.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig.debug         |  2 +-
 arch/mips/kernel/early_printk.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index 892e31804982..6ef42edc7d67 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -2,7 +2,7 @@
 
 config EARLY_PRINTK
 	bool "Early printk" if EXPERT
-	depends on SYS_HAS_EARLY_PRINTK
+	depends on SYS_HAS_EARLY_PRINTK || DEBUG_LL
 	default y
 	help
 	  This option enables special console drivers which allow the kernel
diff --git a/arch/mips/kernel/early_printk.c b/arch/mips/kernel/early_printk.c
index 4a1647ddfbd9..c3f3b0a930f0 100644
--- a/arch/mips/kernel/early_printk.c
+++ b/arch/mips/kernel/early_printk.c
@@ -14,6 +14,24 @@
 
 #include <asm/setup.h>
 
+#ifdef CONFIG_DEBUG_LL
+extern void printascii(const char *);
+
+static void early_console_write(struct console *con, const char *s, unsigned n)
+{
+	char buf[128];
+
+	while (n) {
+		unsigned int l = min(n, sizeof(buf)-1);
+
+		memcpy(buf, s, l);
+		buf[l] = 0;
+		s += l;
+		n -= l;
+		printascii(buf);
+	}
+}
+#else
 static void early_console_write(struct console *con, const char *s, unsigned n)
 {
 	while (n-- && *s) {
@@ -23,6 +41,7 @@ static void early_console_write(struct console *con, const char *s, unsigned n)
 		s++;
 	}
 }
+#endif
 
 static struct console early_console_prom = {
 	.name	= "early",

-- 
2.34.1

