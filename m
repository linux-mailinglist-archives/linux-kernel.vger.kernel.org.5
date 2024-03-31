Return-Path: <linux-kernel+bounces-126078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6E88931C6
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 15:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B33D1C20B7A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 13:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697F0144D3C;
	Sun, 31 Mar 2024 13:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="kIMa6Wyi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IZHwGU7V"
Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D121144D19
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711893048; cv=none; b=qheyQUtk6DGRBrx2KHheLfZpFQhIk9tjU9NXDnCi+Uq/QSyOyy1p2h0+CYuWtK73/OFKtno3ESINm1+xLaqtcyR0rIMiwuekRrq/7rweKQHq5Ws6HrY0d0IxpMmCsahqH/DVM25Tvy9ptA1U3xz9lO86NDogLOp8eJ11OOt26S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711893048; c=relaxed/simple;
	bh=w65z0QxskN7ZF9tF3NOX4hkXK+fx5BObox8xBpurGQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pck8zbQcowQmv7B+BHr2Hz4UZjDRfUqnYtmRVUdKtrGgqpqTpBhk3DrIQsCD91vRXzO+Bq5XdHCrUjLGj9PjzVN0Wk6nwMi0DBNcZyAvkYBKvQcivny5jJ6xoxuUq1RLoLAfABXOcUZCpEOXvWDVf0Pc0lvovRlrB0j6CO8ANRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=kIMa6Wyi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IZHwGU7V; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id F32B01C000CD;
	Sun, 31 Mar 2024 09:50:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 31 Mar 2024 09:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1711893044; x=
	1711979444; bh=qkJRo23QIS6MlyibldBmAeHzIc3e5Kr0E1mP5LfohmM=; b=k
	IMa6WyiI4RF5Quvp9i5BL+2FjailCwKSJ9QEvcBVUYnaiSX712IrMEnIRLiT7aPQ
	RnDP8iLQahsdD9MYZVvKX9N11oCPLcmxhAaBVYC7a91I2xd8+Cr/PnAhFd6B07cx
	jkMCTpKFe9B45z1N0jsBQG+7k/3RMsX8EA36ZJIHPkKkg76Tp1Vookrkpeorkttj
	Ek/6ACzEoqSzZ6gYm5POUSywcQUT0DOVkSAz2S62HXlqn4j8DPQxgqsrR++XS6lH
	8er0kwneEe4m9YwJkNn7OCJjECOr/UDMO6/zFVvP4hJFStvCMIrgqfoYCZqr44qT
	y/RopHaIuFcYYIZp8EFZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711893044; x=
	1711979444; bh=qkJRo23QIS6MlyibldBmAeHzIc3e5Kr0E1mP5LfohmM=; b=I
	ZHwGU7VF97/j73JOg9bznshb4D3QMcR+0mm6fJ+Ep9gB6cl5MAcI7QFTl1s6IvO5
	2470NTtDmbZD/d1WmdaDZsPYXXoC66+PVdzvYeE+IGSWyOuYKpFIgK8YHHIMG5CW
	pq0cmLUkEVblLkeZBKJzXJftTbBcqjvTddqiPR2iB7L97fvp/S1lN4yZVxzo47Nv
	7bvL1M7QCHBdXfvGddeRoMvln+E4IygNTvlvWo6yJmb/V/HjmS7bUFFu8aL/zcMU
	/0JfSjs/CHKRnBhAKuolrLcnlyj7vq6Gvsem6QVORMBmABqlVDjV8MBFpEpQAGQZ
	2m6JW9j0/zlLpFlFPu2gg==
X-ME-Sender: <xms:NGoJZqEVmpZfxfc6aoN8M0t8XMiqwPbe1Wc9MKIcoU670l-Wgh4J3g>
    <xme:NGoJZrX3a2W1B2pTaNBHyVFhtUDzI1NzY_ljbbhrzw4xLFn6VAfn1cq1wHXS5y8dA
    5jqCGivQ1QqvhROApQ>
X-ME-Received: <xmr:NGoJZkJuwXe60nP77v6e9X0pn_X3p1ZuYskldoInpb53k0EpW9cMAwE6lljw-n1zKO8deFV9K59VAqQs7YD6Hd63m95vIbVrfP3AK2_iBFjv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvkedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:NGoJZkGqJuxTRyUplKSaCLA-6k0QD1M0QfozLWwRf-slozP0Swa_Vw>
    <xmx:NGoJZgWonNcoDCvwtB3BDWyvGmA7wDDpx7r2YnqzedQsroaREL31KA>
    <xmx:NGoJZnOkKkjoNGUJ9jxK75xhOTl9gbb_yNHwVsadHTr9MtVtSZnk0g>
    <xmx:NGoJZn3oiNC0JLuBZBcg-vwPP5WxMmG8b5u5eLB3sEtzjGec9POitQ>
    <xmx:NGoJZnQF6uCQBv1MwjsAfsm64aaLFm3dUD3rJzVvdp3ES4Ajf52PbzC16QM>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 Mar 2024 09:50:43 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] Revert "firewire: ohci: use devres for requested IRQ"
Date: Sun, 31 Mar 2024 22:50:34 +0900
Message-ID: <20240331135037.191479-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240331135037.191479-1-o-takashi@sakamocchi.jp>
References: <20240331135037.191479-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 5a95f1ded28691e69f7d6718c5dcbc149613d431.

As long as allocating any device interrupt vector for MSI, it is
inconvenient to utilize managed device resources for IRQ requesting.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 7bc71f4be64a..f18019c5d220 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -3750,16 +3750,17 @@ static int pci_probe(struct pci_dev *dev,
 
 	if (!(ohci->quirks & QUIRK_NO_MSI))
 		pci_enable_msi(dev);
-	err = devm_request_irq(&dev->dev, dev->irq, irq_handler,
-			       pci_dev_msi_enabled(dev) ? 0 : IRQF_SHARED, ohci_driver_name, ohci);
-	if (err < 0) {
+	if (request_irq(dev->irq, irq_handler,
+			pci_dev_msi_enabled(dev) ? 0 : IRQF_SHARED,
+			ohci_driver_name, ohci)) {
 		ohci_err(ohci, "failed to allocate interrupt %d\n", dev->irq);
+		err = -EIO;
 		goto fail_msi;
 	}
 
 	err = fw_card_add(&ohci->card, max_receive, link_speed, guid);
 	if (err)
-		goto fail_msi;
+		goto fail_irq;
 
 	version = reg_read(ohci, OHCI1394_Version) & 0x00ff00ff;
 	ohci_notice(ohci,
@@ -3772,8 +3773,9 @@ static int pci_probe(struct pci_dev *dev,
 
 	return 0;
 
+ fail_irq:
+	free_irq(dev->irq, ohci);
  fail_msi:
-	devm_free_irq(&dev->dev, dev->irq, ohci);
 	pci_disable_msi(dev);
 
 	return err;
@@ -3801,7 +3803,7 @@ static void pci_remove(struct pci_dev *dev)
 
 	software_reset(ohci);
 
-	devm_free_irq(&dev->dev, dev->irq, ohci);
+	free_irq(dev->irq, ohci);
 	pci_disable_msi(dev);
 
 	dev_notice(&dev->dev, "removing fw-ohci device\n");
-- 
2.43.0


