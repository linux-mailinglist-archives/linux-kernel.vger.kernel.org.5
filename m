Return-Path: <linux-kernel+bounces-126079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28EF8931C7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 15:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 661762818CF
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 13:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAD314533C;
	Sun, 31 Mar 2024 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="BGN/rskT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rTTDVKf6"
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36029144D28
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711893049; cv=none; b=IcJ5XA4QBC7Vpzdl+V+WUESxr6yB3VNZwIupCay+myletf+CCaNBBjYK6rOb8CV8whs9tllBGcooXd6vtqac+xhW0ot+0KzXiKV/2FCEyGjF2N6Eu8ekBvrgsuLkCltsmd10wCXL4JpQZqQ4AtzjbciHX9F6iDbNOWDAt9QdyGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711893049; c=relaxed/simple;
	bh=qd6Hc1CnvuAkfK3DNjZ6oePksqpx6ygYsp1KXjodoYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUCWN7Fhg5kndlMIzObdCcDkCF7BtSi5ad8hspm3tO55MdRFVXQJYy/JzH77kMCvL/Vc0SFq0ZZ4flQujp2It3EYPjJsL3fn4Mru1dHceWtfjQdauHFVz9H03QgDmqDxme0z3xiI3YMhUrJ1l4tnjfLBfYZxPqAHuyw/j7c/Qd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=BGN/rskT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rTTDVKf6; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 2E4E618000BC;
	Sun, 31 Mar 2024 09:50:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 31 Mar 2024 09:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1711893046; x=
	1711979446; bh=c5UyzxdIo0EMw604i5z0Ke4dcgihgur2UN/owwURGQg=; b=B
	GN/rskTywntgx1+9BZn/VL+LKurmtOAdYtOJEuwkVWWBQ2KiSkupdcF0Thmpmolu
	udzqOHUQa5TM8/16lkcQyEhvvF9DpEDfKh4hGC7FoBMYl87Qu7lZPyaKF1DQO+zn
	a4BZmRicfpBHDOVN8VpPtFmXzmV0awhLIgfF+2XvVJB7Em68+aZQEv5DVJu4PDuY
	RxXakRsRB5pHLbjDDh4kf7dYPxzPnquq9RQp8RmzkjtQYkVqnJ5xhK56SYUvGlRX
	bEMordKvFZPPXll13dYR2YL9sbCmKOb1As88jnBjaj/WLmxf0QWkfLkk47Hfk2PV
	M0/1TIAQzw/rZ/tCGsn8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711893046; x=
	1711979446; bh=c5UyzxdIo0EMw604i5z0Ke4dcgihgur2UN/owwURGQg=; b=r
	TTDVKf6yrcUCxLSzcD1IwM4I9Q9mqBvRDggEp9aHBUjuLN2tUklCUhbtRcTeHz0c
	C9iHqxo/CajCh0rBgfnOyO3fNXjLqy5AFLKU9ppo73kjU9iIIU5RLQsnNWEzyYL3
	RkUsHE4lDd0qEcEOlWrAk9K922KqoZVBMXQBK/8DwVag1FG6RYKVW/U+avlw02FK
	LqJACUXiG1vFyl9UODO4JLRGg9Bhan+/66jFNu0T0unbdot8JB4uTxJlA2tghxCF
	tIMfgBHe/RAzxPGSC4gUMw09UzwMTJEQ/PbfeKV7xSzwekXGILwWP+SQFSgCq5i/
	sUo2RwERy/rEsITCed7cQ==
X-ME-Sender: <xms:NmoJZixI_AU9pUEJnWe5Yg6Q2xxJ0oPpK3CvTlsodbFiEewm5af08A>
    <xme:NmoJZuReyC3YWfH2LNjyUgX-I7YfLxMjeSQ9DPjIvdS-2zHnpg_UyryoqSg7riOGt
    NG2L2ctxjivVUE0pUc>
X-ME-Received: <xmr:NmoJZkWXIa25ZVWJflZ2fl_4OFvSUrQGlbxw7kg5vR00gglh8d9Nkl-Mn88pf9ox_o8ALxwoJz0gTw8hKX_S0bfoPfeUdemLxJoqnqFd4xnT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvkedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:NmoJZojStHMnBXWPoCiqt5vH5jTxDltDyhbW3ry7aD8tgYBHB221XQ>
    <xmx:NmoJZkCYx_pV2Pk4_hLoEX7OaPJuNNOpLKWK0z4JVE5zIRKaN8043Q>
    <xmx:NmoJZpLvq3XtvmvUI-zMOI9ck3glJrvy2wFc5Wrp9tJk1cqomtHJYQ>
    <xmx:NmoJZrC-p3xwLzZQIaRHlQaN6XNvr8sWdAOOBVSuQ3lsHGUN5E60LQ>
    <xmx:NmoJZnP1tyh5tHFdILkDV3NQwkgp7UuXNrVqMLa_1keJbvGHQ3jqjTsYwj0>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 Mar 2024 09:50:45 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] firewire: ohci: replace request_irq() with request_threaded_irq()
Date: Sun, 31 Mar 2024 22:50:35 +0900
Message-ID: <20240331135037.191479-3-o-takashi@sakamocchi.jp>
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

Nowadays request_irq() is a wrapper of request_threaded_irq(). The IRQ
handler of 1394 ohci driver has never been optimized yet, while it is
a good preparation for the future work to replace the latter.

This commit replaces the former.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index f18019c5d220..ec02708c5f05 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -3750,11 +3750,11 @@ static int pci_probe(struct pci_dev *dev,
 
 	if (!(ohci->quirks & QUIRK_NO_MSI))
 		pci_enable_msi(dev);
-	if (request_irq(dev->irq, irq_handler,
-			pci_dev_msi_enabled(dev) ? 0 : IRQF_SHARED,
-			ohci_driver_name, ohci)) {
+	err = request_threaded_irq(dev->irq, irq_handler, NULL,
+				   pci_dev_msi_enabled(dev) ? 0 : IRQF_SHARED, ohci_driver_name,
+				   ohci);
+	if (err < 0) {
 		ohci_err(ohci, "failed to allocate interrupt %d\n", dev->irq);
-		err = -EIO;
 		goto fail_msi;
 	}
 
-- 
2.43.0


