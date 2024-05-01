Return-Path: <linux-kernel+bounces-164990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E708B861F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FBE91F2287F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC74C4DA1F;
	Wed,  1 May 2024 07:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="USG6fP7D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VMgGHrYb"
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E394D11D
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 07:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714548796; cv=none; b=Q/ugrIJDPvQnYV27ILP9OCkktGO0aS9Tg/vsvT8QnEARL0SaT/ET7LCvfBrhpM6rPW5RSOD/Zy+3BN03mj9CM/2mREZWOIhTWF2w6sT1EZBQB5Ow6z234xAcax3SLyT0vSGZXLt8aySIULeLBFcB4EfQFvPl9kJYZPOs8spXzng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714548796; c=relaxed/simple;
	bh=30aRBMC3W7x8Y6esE4/TZUqzERrGNKxNM9Q2Xe3E4EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQmfIWQJnxwbBc/vYtPY+ov7VOmcgK4BQ3WSEX6qTb//I4gfQZFY/SXAHHCGLOTnEZPz4teVUTA8V61Ik5H8rniTSdgF8DlsaGb5a83QnTEclkgvkzy+4z6WP65gQOsYbCxXxhZ29rIKjIahf7J0v3rRI4zIZzZclieHq3uSb5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=USG6fP7D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VMgGHrYb; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 0E4CA180010C;
	Wed,  1 May 2024 03:33:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 01 May 2024 03:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714548793; x=
	1714635193; bh=HFcRJRe/Y0MyNFmax3pmYevS0hyOD26+e/Eh8+mPM+k=; b=U
	SG6fP7DGEzjg3GM5cQMBmQl7icOaF4Kr8vqAGctrRZ19aYtUbS6FIEdMAEEateyK
	zs4cGfFotsgz2ZTjFJbIPuaxHXZ6exdS2g1bg5DslJ3MwEcNWpYxN4xSKe26G03O
	T6z3Mmx4Qw7B+TXozQBQlfruoEpOPybze1u2wasKJdCAuHUnqQc5YR42KNUZ/gi9
	U62glcatF9xDpwazXZwlN8StXZzVoeIFXGRe/Tk02NKxu43ctRpu1MwCMAhtHst/
	BsY3LeIf5+HlATZdCUN45S3Chl3/5W9acTULfTw4kkgyBDzoy9FNSBGCHMXp9h7E
	/PbWXR0MvJDee1hNJkPEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714548793; x=
	1714635193; bh=HFcRJRe/Y0MyNFmax3pmYevS0hyOD26+e/Eh8+mPM+k=; b=V
	MgGHrYbm3A2wcOjot7M4DWw9ZQjzU0MsgM4ArYUGqUOjEtTmv9QmSheLIZXtOaGi
	HUeQ1qjx+pOLlPHRIKWE90YjdgouviGs+9HkcijwRfCRviydTs5bJ4fV//VuZecb
	xyF4qf+IcaVhfmfZTc35xdIKhqzjI/+ovyV/O5zVuESCedgiXSySxRjDwslwCsuM
	YSGRA3LLpc1uWV1++dIRTE+Ze9ASExYzryprWz1Sn6+PEAWudIkGDc8wiCpIUKjq
	7Ux1VlGTpQL57yB68HBRpfMv8U758O16iucTEmHlBoqPp9RDHk6rpB7eMueRG8ZR
	2w9Ewx5xATyYIGJXnY4aQ==
X-ME-Sender: <xms:OfAxZru7BsIy0wnDXFb22OYOQBD-vu2kDIWMMztZNypg8qr_k4BX9g>
    <xme:OfAxZscM4ivcpmgFuk8eS_sPFGyml5_ir2EHTBqJUheXpxs9rSdJPJcQEgU7i2AQW
    HS318iBnWFS3ihXzp0>
X-ME-Received: <xmr:OfAxZuySjhcrJNL3tRWi-YYJEMPLIhiujKJ4VahVz3iN0qXGzJmbVyXUw_8dq-do27S8YkKDLS1GWgP89WDK7IamjQBpdv7TOrjPa8A2DOm2gl4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduhedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:OfAxZqMCKH5TOkL7ysKUuNPzojusuYrvvevI3JUQoeCYnx7XpOwpNA>
    <xmx:OfAxZr9V760R1gF37J0E-hcOk9qM5c-hUaCbOIBcb6maJWlyIPzEtQ>
    <xmx:OfAxZqW460R5tjvcIqg_n5iGUXqiy2ahA30FqG9d9PpXpFVfESTzIA>
    <xmx:OfAxZsdt--BybWTe9dvW2OGnXOAbg97thmgf0UfJD-bbFwgCUKI4mg>
    <xmx:OfAxZuatklq3QhtqD_P5MwkwV5T4Sgi4SAWZL2lCPz6kdoltT7oTGGmM>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 May 2024 03:33:12 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	adamg@pobox.com
Subject: [PATCH 2/5] firewire: ohci: obsolete OHCI_PARAM_DEBUG_BUSRESETS from debug module parameter
Date: Wed,  1 May 2024 16:32:35 +0900
Message-ID: <20240501073238.72769-3-o-takashi@sakamocchi.jp>
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

The OHCI_PARAM_DEBUG_BUSRESETS bit of debug module parameter was added at
a commit a007bb857e0b ("firewire: fw-ohci: conditionally log busReset
interrupts").

At the former commit, the bit becomes less meaningful, just to skip
logging.

This commit obsoletes it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index d69629d8ba71..93dca3216e45 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -394,7 +394,6 @@ MODULE_PARM_DESC(quirks, "Chip quirks (default = 0"
 #define OHCI_PARAM_DEBUG_AT_AR		1
 #define OHCI_PARAM_DEBUG_SELFIDS	2
 #define OHCI_PARAM_DEBUG_IRQS		4
-#define OHCI_PARAM_DEBUG_BUSRESETS	8
 
 static int param_debug;
 module_param_named(debug, param_debug, int, 0644);
@@ -402,7 +401,6 @@ MODULE_PARM_DESC(debug, "Verbose logging (default = 0"
 	", AT/AR events = "	__stringify(OHCI_PARAM_DEBUG_AT_AR)
 	", self-IDs = "		__stringify(OHCI_PARAM_DEBUG_SELFIDS)
 	", IRQs = "		__stringify(OHCI_PARAM_DEBUG_IRQS)
-	", busReset events = "	__stringify(OHCI_PARAM_DEBUG_BUSRESETS)
 	", or a combination, or all = -1)");
 
 static bool param_remote_dma;
@@ -411,12 +409,7 @@ MODULE_PARM_DESC(remote_dma, "Enable unfiltered remote DMA (default = N)");
 
 static void log_irqs(struct fw_ohci *ohci, u32 evt)
 {
-	if (likely(!(param_debug &
-			(OHCI_PARAM_DEBUG_IRQS | OHCI_PARAM_DEBUG_BUSRESETS))))
-		return;
-
-	if (!(param_debug & OHCI_PARAM_DEBUG_IRQS) &&
-	    !(evt & OHCI1394_busReset))
+	if (likely(!(param_debug & OHCI_PARAM_DEBUG_IRQS)))
 		return;
 
 	ohci_notice(ohci, "IRQ %08x%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s\n", evt,
-- 
2.43.0


