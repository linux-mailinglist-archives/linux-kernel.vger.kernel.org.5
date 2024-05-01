Return-Path: <linux-kernel+bounces-164992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 157D58B8623
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C03C92832D5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB5550246;
	Wed,  1 May 2024 07:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="jJjUpBCv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cPo1tp9u"
Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8DD4F201
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 07:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714548801; cv=none; b=FBG06B8DJPus9E4sJ6e0yI328UEItUSyihGJXaPdN0AD7urLCouq29jxkhUoMHNli4vbCZNzt6kmhvRygBX4YisfL/bNBOIwaZhrINor3/VkUBvEA6bKoUQV3mpNCHOsUsGIsPkaH3HYADmvG9PH91p22vK6qEwDAE29qoGg58g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714548801; c=relaxed/simple;
	bh=bipW+sFTPR0KNhCgWOsfzV4atAEryOnMGBM6QNDGdgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3g8wlnzCuOk9HS68yAnL8lUb6RD/VO+DT0tT9qKV36KTS6AVIOouENIBR7h95Gd7e1wYDDjwOYcQVdYyAZfdwpa6lWjKqzeOoRqOCQQFcbHzOPvo8bJCD7z6LXd4jCvxlpafmFX1W33spqG0k8BQDS8KPLX/I+iMyOG4KUKp5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=jJjUpBCv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cPo1tp9u; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 84FB31C0010F;
	Wed,  1 May 2024 03:33:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 01 May 2024 03:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714548798; x=
	1714635198; bh=HgUZJoRk+wcwO/h9C2rYbGduJQggRI/00GIyShHGGpA=; b=j
	JjUpBCvGeTlsxIUw5HQKZbOWIrlFM2iP6G2ZepoUYd5Gt29KSM4/CJZFSYmIRzRz
	+u6eVG0dXM67eyp3BnKoGX+f8w1oo9JFjWqZS1QkawrgiHDCDouq68o2bEOfv2t9
	mo+3HWO20Hasist7d1c4w8K1S3Q8ZgHIKTJRO/+XBx3NlKPVh0Ay0YKb4TAJhl28
	3lkzeottPpmEJJpJiJwclzAzdIMGRdZ4Lu3epiMetomIY1fUlziieHHah1D+PVUS
	Psdn/UpY5/xLlUQWILauoEVLBHSXTokPw4h41rXVf8//XR3nxMXXHJRDjqQCVxdQ
	jIiyczxX/kBM/2TYKYpww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714548798; x=
	1714635198; bh=HgUZJoRk+wcwO/h9C2rYbGduJQggRI/00GIyShHGGpA=; b=c
	Po1tp9u76EPuscnqfGXwz5UmsjcEwPZhrpc67yjjicwV7mlTve3sYmyksanIdwn+
	oeaKJGjEuYpWT020fQ14IBoIoy++syarHuuCU1XqemzTSWnvimgVIozZSkvPpdJw
	AP+B0V80+g74fWqraAPL5J7nfzwJHJEgpyLYiMBQtghPf3CcbFI3zPt6ScONqaxx
	+T5xjWKvDUiJ9prJX5EFKuv6PDUQqcVXIh9fUTMFHUHDC4lgOSPokiWjNp98u0b2
	Afw7JfXF1R7gEjmNZtEr+RX0uOh8yNFKBsXpMAvqLl+jNuQt7JRtIaesC3OqwIlJ
	m5liOmWq8A7RIvnmWGI8A==
X-ME-Sender: <xms:PfAxZtj_wJZtGrIWvLh16q9xi-fYiw3QVNPXDJ-P9MGg_p8Lr2JExg>
    <xme:PfAxZiAbHwlnhik3biIruyc1gdn-3pSpLWcfLrUwpfHrwpIBMX895C4t4wJlCoRtG
    GfbYUJZN8c9Lj44ooE>
X-ME-Received: <xmr:PfAxZtGkfY3ClifFosRA0UkZQHWfKh5-ANYsDhOvbbb8QNCszi5BdPia9EyJStUtknFfHeJ30htF4Eigco778I3SVSNtGPnuyZOs_tUSLBZeZ-8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduhedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:PvAxZiRfIpQ8Btp6Uec83rtfI7or_rN1S3YI6SCSTaGDqjDDIrRFyg>
    <xmx:PvAxZqyekB2rsp3hcUHAt2T_xYtfo8Hgsd__vbjY47zVoS3DV_u_KQ>
    <xmx:PvAxZo6zmHThkI3jNoG3PFIkW90jcoMC11GD1ZNTEOSg1b-EOW9OMA>
    <xmx:PvAxZvyY2_P7EdLpL3zWblaemB2Q0Xm0_W6MC2JJj1icHV3-JmkrpA>
    <xmx:PvAxZu-8YurkUelixSzAtrrK6Wk29Kj4QowyeA6T5fMPyfskETgH_926>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 May 2024 03:33:16 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	adamg@pobox.com
Subject: [PATCH 4/5] Revert "firewire: core: option to log bus reset initiation"
Date: Wed,  1 May 2024 16:32:37 +0900
Message-ID: <20240501073238.72769-5-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240501073238.72769-1-o-takashi@sakamocchi.jp>
References: <20240501073238.72769-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 6732491243045f5a7e1995b4be5f3c964b579ebd.

The former commit adds some alternative tracepoints events to replace the
reverted kernel log messages.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-card.c        | 10 ----------
 drivers/firewire/core-transaction.c |  7 -------
 drivers/firewire/core.h             |  4 ----
 3 files changed, 21 deletions(-)

diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index 5d43acf45a7d..127d87e3a153 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -224,10 +224,6 @@ static int reset_bus(struct fw_card *card, bool short_reset)
 
 	trace_bus_reset_initiate(card->generation, short_reset);
 
-	if (unlikely(fw_core_param_debug & FW_CORE_PARAM_DEBUG_BUSRESETS))
-		fw_notice(card, "initiating %s bus reset\n",
-		          short_reset ? "short" : "long");
-
 	return card->driver->update_phy_reg(card, reg, 0, bit);
 }
 
@@ -235,10 +231,6 @@ void fw_schedule_bus_reset(struct fw_card *card, bool delayed, bool short_reset)
 {
 	trace_bus_reset_schedule(card->generation, short_reset);
 
-	if (unlikely(fw_core_param_debug & FW_CORE_PARAM_DEBUG_BUSRESETS))
-		fw_notice(card, "scheduling %s bus reset\n",
-		          short_reset ? "short" : "long");
-
 	/* We don't try hard to sort out requests of long vs. short resets. */
 	card->br_short = short_reset;
 
@@ -259,8 +251,6 @@ static void br_work(struct work_struct *work)
 	    time_before64(get_jiffies_64(), card->reset_jiffies + 2 * HZ)) {
 		trace_bus_reset_postpone(card->generation, card->br_short);
 
-		if (unlikely(fw_core_param_debug & FW_CORE_PARAM_DEBUG_BUSRESETS))
-			fw_notice(card, "delaying bus reset\n");
 		if (!queue_delayed_work(fw_workqueue, &card->br_work, 2 * HZ))
 			fw_card_put(card);
 		return;
diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index d3eefbf23663..571fdff65c2b 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -1390,12 +1390,5 @@ static void __exit fw_core_cleanup(void)
 	idr_destroy(&fw_device_idr);
 }
 
-int fw_core_param_debug;
-module_param_named(debug, fw_core_param_debug, int, 0644);
-MODULE_PARM_DESC(debug, "Verbose logging (default = 0"
-	", bus resets = "	__stringify(FW_CORE_PARAM_DEBUG_BUSRESETS)
-	")");
-
-
 module_init(fw_core_init);
 module_exit(fw_core_cleanup);
diff --git a/drivers/firewire/core.h b/drivers/firewire/core.h
index 5097c7a270b4..7c36d2628e37 100644
--- a/drivers/firewire/core.h
+++ b/drivers/firewire/core.h
@@ -245,10 +245,6 @@ static inline bool tcode_is_link_internal(unsigned int tcode)
 /* OHCI-1394's default upper bound for physical DMA: 4 GB */
 #define FW_MAX_PHYSICAL_RANGE		(1ULL << 32)
 
-#define FW_CORE_PARAM_DEBUG_BUSRESETS	1
-
-extern int fw_core_param_debug;
-
 void fw_core_handle_request(struct fw_card *card, struct fw_packet *request);
 void fw_core_handle_response(struct fw_card *card, struct fw_packet *packet);
 int fw_get_response_length(struct fw_request *request);
-- 
2.43.0


