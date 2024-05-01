Return-Path: <linux-kernel+bounces-164989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B1D8B8619
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1CF28381B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8F94D135;
	Wed,  1 May 2024 07:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="fRZn50ID";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ehlXrLD9"
Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA464CE0F
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 07:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714548794; cv=none; b=iJYOnJjyRLzrYJQQz/7oDXQwtN7VPPrpDdJMgeaEK56W2aJESVG8WNpLv/XCYgbBbJmTlI1ZwB7i/0JsGiuPZDfvU0TXDEBsqApTyM7K54/23aSdqc7Jb31PgpS1Gf7ZI1QuqvzwS7wBXtahiRUP46/1p98v5KntsSteERU7wow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714548794; c=relaxed/simple;
	bh=rU0h/tMyHHX9I3PZoivJSoAE32ghOrIOuF+fTIqbsm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsYbfpcoXXpWbQLkSlm+j3YdIH7D+dAc/KceaEpKcO0d2lZeCJG74O8FgPj/rXSMFv/qAMzlkB5RWYiPMcYByopSFcYDLJ/IoufHQZHeSKk7fEX0gnUn+ciChPHeoV2LmWHO4G5RPhAFnniaYDX+IJO0PXSEJskV+D4EuYozA+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=fRZn50ID; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ehlXrLD9; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id BE04C1C00102;
	Wed,  1 May 2024 03:33:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 01 May 2024 03:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714548791; x=
	1714635191; bh=vji99/5fwHT52mv+ugt6zqpbbOZSoA4Zeq3Z+QiUnIM=; b=f
	RZn50IDPzKCnT10evJnhaZ1XMSky9rBphcABk5RsYgpQlo9j9JOX7W2I2gCASzb6
	6VGRCC52xAG8rlYVFZZeVD5Yj9PGPlfk4AsWGZPJgVFJ/MEsWM92tQQZJIPE+FD9
	pCGZYJFfPtuHRjwXGuXYkEtoaJm9Zk46Ul6QDVS/zlLlZZT1ajepl/7pzFlaeIbM
	MYQ3Pf43Oz3DDwUBRNmVDBgcjSM+aaac53wtQAsS6gSl+aVf18e+y4Gq6fv2eVix
	ZTY+riFpGs1ged0o9qW6/aplaDb+lLwFin1JSpfWIyErYoGdciafFd1VwH3xdhhF
	x8R0lzq8YrwOR3eilHAkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714548791; x=
	1714635191; bh=vji99/5fwHT52mv+ugt6zqpbbOZSoA4Zeq3Z+QiUnIM=; b=e
	hlXrLD9wSymNy2xdSFHwg+G/RbCberV/M4dA7UbcgUbloinuoN8CI6puTJ1DjESk
	tzEaC0CX1MPdDxbF/a+wfnMRPs9DhZR7cFulIzFgTwnK1SAZIKPAIJXOy8DlH/Da
	KMCwuvv5/AwiaWgdGHC7Z/zuyBhYEBcgXUOzwXSOww+Vyw/TkGwMf4cxesDI8r5W
	6wB5e95ox/a+YkEmGKui6gCE+GIDpV6B5kIqFAkGLYQaBmEM6afMxBaZ0pAa5+kg
	Fu8pWUzIEoqAltr7NE2vZYZ1wUsityrcOa2DUCE7yGyqW0J1g+zYfXjeGvUnMf9Y
	RpNm1QAH2Xc+Y8U6n6oZQ==
X-ME-Sender: <xms:N_AxZpnZ3CDr0OEnDRH1e7UdXicJmEEN3idNf_zoi_xw0hEfR26JRA>
    <xme:N_AxZk04iviv-3QIndbUrnm4XvO6gVKv_V7sesE8nHqfNR_ElzD-Lq_ZZlDZ3Nc-p
    zouWQaVke36caugZIc>
X-ME-Received: <xmr:N_AxZvp-y6Xle8fFzfJoFE-bGeOFc2sdbRNLHhT_aZbDB0JIMZSwfD2mKBMLxmRDhA4iQgvziQpWqbIExQBKI2Q_IfNeai8-2HxyvcMZQq2helM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduhedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:N_AxZpkYFYvvOwQciROhgrJgwzv-x_LOtpxqxbtrYNs-J5_Zo5hcZA>
    <xmx:N_AxZn2zZMPE9KrXu25W5Q44p22l5OrpMui0EF8JtPF3ODXwvNyRmw>
    <xmx:N_AxZotWRQnMgVjlih3OaxvmPOAnhdAmP9SPLAPEiRxSBVprvFSn1w>
    <xmx:N_AxZrVMCAOzudnyuWyRZNcKnnwxhFs2noHChU0N_WcrdaAW69JYxg>
    <xmx:N_AxZozib_-jI4XIJFnHT7TB_JcyHaxAW55SEFLnmLVXM6WSnaKA3P2X>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 May 2024 03:33:10 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	adamg@pobox.com
Subject: [PATCH 1/5] firewire: ohci: add bus-reset event for initial set of handled irq
Date: Wed,  1 May 2024 16:32:34 +0900
Message-ID: <20240501073238.72769-2-o-takashi@sakamocchi.jp>
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

In the former commits, the spurious interrupt events are suppressed as
possible, by unset bus-reset event from the set of handled irq. The change
was written with the less-intrusive style, thus it firstly works at the
second time to handle the event. But it is slightly inconvenient.

This commit adds the event for the initial set of irq to handle. As a
result, the event can be handled even if it is the first time. The change
has a benefit that the OHCI_PARAM_DEBUG_BUSRESETS bit in debug module
parameter is always effective.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 6116153f0ce6..d69629d8ba71 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -394,7 +394,7 @@ MODULE_PARM_DESC(quirks, "Chip quirks (default = 0"
 #define OHCI_PARAM_DEBUG_AT_AR		1
 #define OHCI_PARAM_DEBUG_SELFIDS	2
 #define OHCI_PARAM_DEBUG_IRQS		4
-#define OHCI_PARAM_DEBUG_BUSRESETS	8 /* only effective before chip init */
+#define OHCI_PARAM_DEBUG_BUSRESETS	8
 
 static int param_debug;
 module_param_named(debug, param_debug, int, 0644);
@@ -2062,8 +2062,7 @@ static void bus_reset_work(struct work_struct *work)
 
 	ohci->generation = generation;
 	reg_write(ohci, OHCI1394_IntEventClear, OHCI1394_busReset);
-	if (param_debug & OHCI_PARAM_DEBUG_BUSRESETS)
-		reg_write(ohci, OHCI1394_IntMaskSet, OHCI1394_busReset);
+	reg_write(ohci, OHCI1394_IntMaskSet, OHCI1394_busReset);
 
 	if (ohci->quirks & QUIRK_RESET_PACKET)
 		ohci->request_generation = generation;
@@ -2135,6 +2134,7 @@ static irqreturn_t irq_handler(int irq, void *data)
 	reg_write(ohci, OHCI1394_IntEventClear,
 		  event & ~(OHCI1394_busReset | OHCI1394_postedWriteErr));
 	log_irqs(ohci, event);
+	// The flag is masked again at bus_reset_work() scheduled by selfID event.
 	if (event & OHCI1394_busReset)
 		reg_write(ohci, OHCI1394_IntMaskClear, OHCI1394_busReset);
 
@@ -2474,9 +2474,8 @@ static int ohci_enable(struct fw_card *card,
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


