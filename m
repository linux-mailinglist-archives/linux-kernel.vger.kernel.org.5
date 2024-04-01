Return-Path: <linux-kernel+bounces-126641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C49893ACD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56A9E1C20D68
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE433717B;
	Mon,  1 Apr 2024 12:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="lafkyf0j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bm5NjL1e"
Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793A9219E2
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711973529; cv=none; b=DZp/LcO5DhzPeYkJgkvegQEMz9exVaVmq/+uNt9k0mJ/xoYnsyYji76QPT0qGHbAitmZJ0iLJ4UlaEisJaylBRD3nae98JRFXNGuhYLGfTDtJzgiHljVYfvEBMXSHYN5fclQ1Qn3B91dB3qw9QXdnhpIq95aZimf78i3sdI3eKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711973529; c=relaxed/simple;
	bh=pXfRUsFt3Rus79YAuj06EctgrL+T3J750KmiRrYlJkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q2bloEQPahFiauUnAJzn3XIuPACzuMd6LaXntDPkKzTfgs0Qfy2ACcDB2EYreHgpNCJS8FCMzSUaLHxeEfQDe36j2Vvz46NDjnz4nYIhVtBNufZBwEiwNKKD16p+P45qa9rFtRXiGY0r/FBSqNViuTnMRASDiE2DD0p0Kg8hOmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=lafkyf0j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bm5NjL1e; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 496E31800100;
	Mon,  1 Apr 2024 08:12:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 01 Apr 2024 08:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1711973524; x=1712059924; bh=3tseEkYxfs
	WFCYTT9gGvEvDc3BMkqs5rodTIypP9LjI=; b=lafkyf0jIT9O8ms5H0O8IY+JYF
	Hc87jDnB4UuuPy/g3uEJlcyEShPl0RZHvrk0tzMi6jUs9sfNT2bs3CUklf46pG/V
	HR3ElwJK1MDHCcmr4oZ+whp1CsUh3rDk3gf6HWivF5dbHDktXdUL3VonkKPLshRT
	grugrPXyR15nV4UXymEOPHsN+roK+fvHa2WMtMSdkDafhGAxwH0vQg47ZsRpYUj9
	hFU0071+77kR48jk8o1QAOCO6tN4fY/jqxXkB7sFnBm2VZldxSUMJRaU14mc4Z65
	Bunu2q3rzaE5pFgH1uLBZuLStv0a729hOshNsHMKMvmbPlaq2jkhpuTW/qrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711973524; x=1712059924; bh=3tseEkYxfsWFCYTT9gGvEvDc3BMk
	qs5rodTIypP9LjI=; b=bm5NjL1eq1+aDlNI3foz8RqPIRfnx5MOHYFtxhzJ27xf
	UAXyBH5P3+9gppWf9AerxyyrGxZXPhqICTyZQL/ZV3C3x8WLHpNYSd6jo5zWaRa6
	gIeOTw8CjlpucEUEJAkn7+mgKyviZSl5+l2r7f88uJPIcrfgrgMxIre9BW4/TR1m
	kiMyHpHQdAQtxyqG+Gl8inoXVLzk91ICT7iuGM+p4Vhvhb3W1pkkR6x24Bk4XnF2
	GA866IYM6Ai/HD8Z33pw62j9HlD6mDiJ3cbPn6xzj0TZaRGP3T+xW+7mDU9sfK3e
	s8ZciTSl+wckAXqkyDDz9szGcGXfQXecdmVNpdLQbQ==
X-ME-Sender: <xms:lKQKZj00QKqC0aX9KP1QAdVp0kwXLOhysiokr3mI9lOAy0S4mcVE6A>
    <xme:lKQKZiEod4IddlVsCFz1S6jVjUPKJyRz2B4Iy-wpPUnYH46mMgnjxzXaDMi-RJU15
    yQZL8J7Q4nV2gGsay4>
X-ME-Received: <xmr:lKQKZj4Uli4Vvbupa_eswaM3-rVyFvAmE6R6OrTyTycHfmfTwVnUHP-0MAtE_8BKmATUchlxa0dw6IRcVhA0wUlYrABepVtrIgQ9dQWkf_XA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeftddggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeffvdeuleffve
    ekudfhteejudffgefhtedtgfeutdfgvdfgueefudehveehveekkeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:lKQKZo2-IV5t4j5QpU-TrrOLIkCP0H2Qmng5pHkSBYpuFmBbDSb6Xw>
    <xmx:lKQKZmGU0JH3Aoh9tcm3Qayy85olT0hmXCYNyujvuh26FKTzk8xscA>
    <xmx:lKQKZp_vcOPUirOg2O3oQ-HMWikwK8eZDFDSc7xGRDCi5KV5lOkDCQ>
    <xmx:lKQKZjlykInfpL2ihrn4OrGtLkXwoMVoYvt9g7S4maBLh8G4sVqPtw>
    <xmx:lKQKZiivvrALG5CtgtlXlmSzLBfJCwiIfBD83EjMPxTsH__LWN6gEl4EOY4>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Apr 2024 08:12:03 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	adamg@pobox.com
Subject: [PATCH] firewire: ohci: always handle IRQ event for bus reset
Date: Mon,  1 Apr 2024 21:11:59 +0900
Message-ID: <20240401121200.220013-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the former commit, the spurious interrupt events are suppressed as
possible, when masking the expected interrupts events for bus reset. The
change was written to be less intrusive, thus it does not work at the
first event of bus reset. However, it has few trouble to make it work at
the first event.

This commit is to mask the interrupt events as a default for the purpose.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 38d19410a2be..4e86205f81bf 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -2060,8 +2060,7 @@ static void bus_reset_work(struct work_struct *work)
 
 	ohci->generation = generation;
 	reg_write(ohci, OHCI1394_IntEventClear, OHCI1394_busReset);
-	if (param_debug & OHCI_PARAM_DEBUG_BUSRESETS)
-		reg_write(ohci, OHCI1394_IntMaskSet, OHCI1394_busReset);
+	reg_write(ohci, OHCI1394_IntMaskSet, OHCI1394_busReset);
 
 	if (ohci->quirks & QUIRK_RESET_PACKET)
 		ohci->request_generation = generation;
@@ -2133,6 +2132,7 @@ static irqreturn_t irq_handler(int irq, void *data)
 	reg_write(ohci, OHCI1394_IntEventClear,
 		  event & ~(OHCI1394_busReset | OHCI1394_postedWriteErr));
 	log_irqs(ohci, event);
+	// The flag is masked again at bus_reset_work() scheduled by selfID event.
 	if (event & OHCI1394_busReset)
 		reg_write(ohci, OHCI1394_IntMaskClear, OHCI1394_busReset);
 
@@ -2472,9 +2472,8 @@ static int ohci_enable(struct fw_card *card,
 		OHCI1394_cycleInconsistent |
 		OHCI1394_unrecoverableError |
 		OHCI1394_cycleTooLong |
-		OHCI1394_masterIntEnable;
-	if (param_debug & OHCI_PARAM_DEBUG_BUSRESETS)
-		irqs |= OHCI1394_busReset;
+		OHCI1394_masterIntEnable |
+		OHCI1394_busReset;
 	reg_write(ohci, OHCI1394_IntMaskSet, irqs);
 
 	reg_write(ohci, OHCI1394_HCControlSet,
-- 
2.43.0


