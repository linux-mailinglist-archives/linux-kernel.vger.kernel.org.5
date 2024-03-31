Return-Path: <linux-kernel+bounces-126080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A76A8931CD
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 15:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D29312817B8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 13:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6411145B07;
	Sun, 31 Mar 2024 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="HueOHeQq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t+POq55Z"
Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AB2145332
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711893052; cv=none; b=u3TekDyblfW3H2eQn5KH0P1sCsFRh71xGdPysOtSDljUTU6t8izyjPyKMln6Bi1gHfue/jJopsTax6c0YMg7pLQw6h0VTPt0RjchqLAvA4OXFAzAAtt36E8k657o+KdLDMrgjsjn4SSjG3TyA7SsUhFl0QeWx03vFMAO02+Sxzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711893052; c=relaxed/simple;
	bh=1YWQJPgEtzrWLiz5E4pGUghg2+MyIdPK3IgGgUl0n/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cb2uA3baSN/M1vkikoAhy8C9WVR311uuoA5rxHuA3eCO2FVFR9OjRn8Pj4hAZJdE1sTek6FyW/W3VLXshNx5M0KcRSA6wb+TlZsWUWeEdhsme922VDRruCVX6UpDRl4ySiCFrbthDMbwDkvkNEDLyTUHbeDondy8eCzUaSG14Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=HueOHeQq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t+POq55Z; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 5EA0C1C000D0;
	Sun, 31 Mar 2024 09:50:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 31 Mar 2024 09:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1711893048; x=
	1711979448; bh=izQDdQ9YH09NT46uOT7yt+MDXit2Qa5tOUgaoIashhQ=; b=H
	ueOHeQquuMcR9BvenNaCrsxWiewh44J2HCqmTlZ/6wcVmqpOm8R4Q7AVdd8vm/cg
	vsU8a9jkH4JIfJFQfAwrDJ6P210RIU2O7Qcj8Z3hfA4+0490nikJj3HnMTlV6/2K
	Xv1uU+GXRS39CNiQRNaKeCtxKAYJY4Nydn4Pu0QhxBCd9QmBTZRCyXUcOTK+rsqC
	Q3+z86raVGtpKX8AEfuPDGiHoHWUy3Gm2J5/A0FKd0Gu7GjqMXwNmw7VTPxHJnjF
	UptSUMvmpgnWHQULwAQqKd/TpADQHcBfws2FONnqLSCdgMOlgPpvFUtRnghqr8kL
	cHMzpdm8bqtDJluL8XJLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711893048; x=
	1711979448; bh=izQDdQ9YH09NT46uOT7yt+MDXit2Qa5tOUgaoIashhQ=; b=t
	+POq55Ztxx5RIzzNjesxwL0m9yNH70LyT1uUq+ujC2ZNsKa/80XOq0YMB6peIoEN
	yBj2nyBKPfI4xluYOFxqo/+I9xPG6oCAXmOJopbUl+iHCFtS8EH1Ja/KNQcgnTc+
	lLe40HLpfGCorlzzv3pqFJydFlZR3Y9OfoimoPencF7x+vAGkkOOG8qoK/+rVMXV
	bmt309ZBLYOdTEqlINnldQkKzvwk2kN45I4HjbnyiYe8phK0acuw4+TgxNJQd9ZT
	GTLPDx0BBME32KbJeaMZ1PAY+KszV8DrauU6u/DXYssfdrag8iCyWmgxtmOqrnf5
	UpOMhVaBA1TBQQBKaKGSQ==
X-ME-Sender: <xms:OGoJZnB5wkJyRgcHcY_EZpQA80qKXegD47IJpA9qIcRLpc8OoZkSCg>
    <xme:OGoJZthwHoEeq6zn_hLXgH59HjJQUvoK5oIkkg1zlxgOkgW9O_3lrwejvbX3Ayb-G
    cpMqUP38nxfAnTTPi4>
X-ME-Received: <xmr:OGoJZil02KE9RtNYoWNf2saZCM8Q8K6ystO2_2tg8DR4NGj8Reo-SX8RGCrh0kSSNVjfymp4u0wSYPf8i8lpjtGAju2vUd19nKktP7LXNEaU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvkedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:OGoJZpy3NUqgTZpQM-pAXsnHio_HkFm7oi5ui1-4wK74o-qRL4CPGg>
    <xmx:OGoJZsQZ6aP0FrYdcoozmIfl8KAGd9K-EACDU6g_N5UKhYpB1YPWRw>
    <xmx:OGoJZsas_HDRD9ChVxIU1ZJLxAZoXfkNhBHOBbhPoQ1ggzbXHCtd6Q>
    <xmx:OGoJZtQF9Ys_INhU0-ruCJ8cbsP9Wo5J5xEmlONHp4UKAkrWcv2KFA>
    <xmx:OGoJZielJ1hajzOGGwdMBE_eqvPfk6LblvKgit2XVq9WZ9qtR8-oOsGeRQc>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 Mar 2024 09:50:47 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] firewire: ohci: obsolete usage of deprecated API for MSI
Date: Sun, 31 Mar 2024 22:50:36 +0900
Message-ID: <20240331135037.191479-4-o-takashi@sakamocchi.jp>
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

The usage of the pair of pci_enable_msi() and pci_disable_msi() is
deprecated.

This commit uses the preferred pair of API for the purpose. The call of
pci_alloc_irq_vectors() can have a subeffect to change the return value
of pci_dev_msi_enabled().

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index ec02708c5f05..c14e6efaba36 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -3623,7 +3623,7 @@ static int pci_probe(struct pci_dev *dev,
 	struct fw_ohci *ohci;
 	u32 bus_options, max_receive, link_speed, version;
 	u64 guid;
-	int i, err;
+	int i, flags, err;
 	size_t size;
 
 	if (dev->vendor == PCI_VENDOR_ID_PINNACLE_SYSTEMS) {
@@ -3748,8 +3748,13 @@ static int pci_probe(struct pci_dev *dev,
 	guid = ((u64) reg_read(ohci, OHCI1394_GUIDHi) << 32) |
 		reg_read(ohci, OHCI1394_GUIDLo);
 
+	flags = PCI_IRQ_INTX;
 	if (!(ohci->quirks & QUIRK_NO_MSI))
-		pci_enable_msi(dev);
+		flags |= PCI_IRQ_MSI;
+	err = pci_alloc_irq_vectors(dev, 1, 1, flags);
+	if (err < 0)
+		return err;
+
 	err = request_threaded_irq(dev->irq, irq_handler, NULL,
 				   pci_dev_msi_enabled(dev) ? 0 : IRQF_SHARED, ohci_driver_name,
 				   ohci);
@@ -3776,7 +3781,7 @@ static int pci_probe(struct pci_dev *dev,
  fail_irq:
 	free_irq(dev->irq, ohci);
  fail_msi:
-	pci_disable_msi(dev);
+	pci_free_irq_vectors(dev);
 
 	return err;
 }
@@ -3804,7 +3809,7 @@ static void pci_remove(struct pci_dev *dev)
 	software_reset(ohci);
 
 	free_irq(dev->irq, ohci);
-	pci_disable_msi(dev);
+	pci_free_irq_vectors(dev);
 
 	dev_notice(&dev->dev, "removing fw-ohci device\n");
 }
-- 
2.43.0


