Return-Path: <linux-kernel+bounces-119934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8CC88CF16
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5E3C30580D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A1A13E029;
	Tue, 26 Mar 2024 20:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="udukm/h1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jH5GW2jg"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D069213DDB3;
	Tue, 26 Mar 2024 20:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485341; cv=none; b=ZfYGI6f5uGY03/qmKYs5a7qvA7QnYW7p5KRUsrW/1rAy4abl84n3oQsWXs9dkZujAjTREK5Rx+OeH1Rc3gLbSwTJjWGXmsWImqEbbqjl8E/pSDWI3Xmim5AvqLmZDpS31QWGGMrV9ypOsQguX2djtb5PHajUMbfzZuB1sQPw8XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485341; c=relaxed/simple;
	bh=hz1+11ATs0FhDts7x1BiLRiY/yQQgRHlTVt2M8apkkE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jq2lUbB9otEQBMN/L2690u4G2OL54pl2cQHnQTp05JCk+U6pobCV515mthzdlGOKe+MP6UrHDXTJc0cuHXOg1KuWfSqk9f7BYp5h9qIgD6hoQHaACZmoQCMoWb5TdELYvQ5JvExbj1gtC2g7tgWBM5stS4mzetCFl4J3BCTxQHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=udukm/h1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jH5GW2jg; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id D5A485C004D;
	Tue, 26 Mar 2024 16:35:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 26 Mar 2024 16:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1711485338;
	 x=1711571738; bh=nkW4taJQaUsRU866lha58WkbM4sO1ApMx1WOQCLwoj4=; b=
	udukm/h1EBa78dAF1N0IXIcqtlkH/Tg/MPM0MY2FM2KZ38uhRebtHiaNYVdQqcAn
	DBy61vJL9xkAz00vHu57SdweSZuCWff4Fy4pvX988jUftdaKDQyRjesF+yXqmpdc
	2DEZQ2s4erohuYtVhX5mrljspyVPCCC5S3JRy4fVpovRnqeSLRibf6rIE1Bi2x8o
	zeyE//wd12JKZGakRmaHbeyuf9I9HyldoWU7712e/1fWmyoIgvcev2a0aFn92QCL
	TuVP5v3N97lGwHut4ooUMmRbyCM0C9vzNqaAjHZwb6rrob3NkwRiIC5eE8BxBq+d
	KFyRLY0eAwY6Ck9XTiJljA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711485338; x=
	1711571738; bh=nkW4taJQaUsRU866lha58WkbM4sO1ApMx1WOQCLwoj4=; b=j
	H5GW2jgzWBdjERxk+ziHwGTmzaovggqeiLBFKSpBi/trvWRu1/xqsIrPSmpEmd1B
	N/d0CRcNgvib/1771W6AQFkoPj3f6uRGa5/4Y34sKNMuqEmezwePNrfFchoImOzx
	RSTApQ5kFSXGOa6IUFsDNO/dOc5fazdstfLkHWo4DZgiWPSFEGNEI3AiL7nb8uHM
	4fRQt8+eMBI/q7BM12j1dwCn+NFuwc+fbTCBDgMbWPi0JjKVCRqqzCWYbIZq+6Gv
	GJkAClF0VXHjcGlXK/0vybeHcTXzvBhb+2ZfHCinhFj+If0fq+0dX1oLYuysgRI/
	vIFrQIi1LEN1h2nOxBioA==
X-ME-Sender: <xms:mjEDZgtCPJNwnunibMcfjHAF43Itym4g6PlBPP867dtrPLzCwjylhg>
    <xme:mjEDZtccGIhc9WApKMgS_oJTo5ea7Im5XIRUmM80RBVjanEpWxvPm7IgbmXniSw8_
    o-ebJT5HkYohAA0QOQ>
X-ME-Received: <xmr:mjEDZrzJwZscaDdHQWa2WqbT2h0IOfMbdQICxj5Hq4zQ58eDRd0qL_E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
    ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:mjEDZjM59bJX5m45-QyT73xI-1NIPC8WNleP1Amnp_zPVzU5kytXKQ>
    <xmx:mjEDZg_xFLVGVmuU6DWEF3XLQeurJeLp8BGMBkKNGWrAyToEcMjbow>
    <xmx:mjEDZrW5OKdJWZ1O4iH7N6pGC15kDA_Ek6K4XSm1QbKcTt5ZrKKaOQ>
    <xmx:mjEDZpdBecWjai7HTUs7PI7TqOMUhnNTZ0DGNAY6sM4t-_teO-ogug>
    <xmx:mjEDZkbMIl0tANQ9lyK_A-F2vXYhgsZv8Yal8n90AEjiE-e1wDBpxw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 16:35:37 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 26 Mar 2024 20:35:35 +0000
Subject: [PATCH v2 3/9] MIPS: debug: Hook up DEBUG_LL with early printk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-mips_debug_ll-v2-3-b64abc76f2a1@flygoat.com>
References: <20240326-mips_debug_ll-v2-0-b64abc76f2a1@flygoat.com>
In-Reply-To: <20240326-mips_debug_ll-v2-0-b64abc76f2a1@flygoat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1752;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=hz1+11ATs0FhDts7x1BiLRiY/yQQgRHlTVt2M8apkkE=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjRmw5linGyP51fNOPRFaN161WtVbrbfT55f5appEp8Rs
 9rsaH5vRykLgxgHg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAExEXZmRYZuuhK/zser6+Tc+
 35oeJdqn+UV1pc/8oo2/5S4fb8j8wMHIsCtoWbi4wpf6hndMkSEm/xiVZi3YbPPJrlEpfGLp11f
 xbAA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

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


