Return-Path: <linux-kernel+bounces-149793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBFD8A95E8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B64C1F223CB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB2815B56B;
	Thu, 18 Apr 2024 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="ctH0zVQ4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q4mf2IQx"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B66115B121
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432197; cv=none; b=IcQQS05w7Vh9bJI392uZzOytn/r6rn0xRXAbLM18zidsVhdaDGDR1TObEDBDIZl9xMf7oT0xpB1E1IkVCfZIML/auRhY2eRJxcrMjTakYCBewkUenJqR83e0qePolllSTRHtHnhibGPrcyG36ebkIcRfl9I5sASAMIIuiQzwJ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432197; c=relaxed/simple;
	bh=MJHBKudG/kZgwlUBFzIAt9k68zjMK0BJO59W1qx1VPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsrIiZDTeA3vnhmIFY/v750lgQC1yA+euQH9XiJBRuF1qoKNVvbyZ2ttnZCtr3aE3z9vwa6rWm8f9oUEipPX9LXnc32C5p/jilSPYHioZsl5oXWk3hp0FWxQWf6KaAQCGahg8GM7lAgQZ20AE9QhgPkqhQJYv/nTyrjnJ71wrIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=ctH0zVQ4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q4mf2IQx; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 85F1F114011D;
	Thu, 18 Apr 2024 05:23:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 18 Apr 2024 05:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1713432194; x=
	1713518594; bh=OvkJ3JJBdTmm0oyGBN0bERJHPObwKkGyJk/XH2hv2+w=; b=c
	tH0zVQ4ZTitLpU+ke2/lTpiDHDXdmoAMYVNGNzTlyRkSyyva+hgHao1T9pwfGvfy
	gSyMwMKFaD8OpoIQvE9tvVfOBshtUtYVyTywiNNlSfe68/xzXqWsT3DL7G4xdWtC
	YTuqEB+EFruLYcASXjA+4hYNmrGhVb8CdE4LS9lLfo2PCG5ryL7OIuVm9Y5FUS1h
	qT8x++ijTEIUwJHtJ2f5u3KWuKS8n9PSrzwi+Ggi0JdXq5ZKJcz+fiLrzfAc41qL
	5/hwiYE1YN5NtWY7COADmHDaXHE9RisfE7YY6uwXLYbhC7lBlbFsPDvfAcOUg/tj
	ZhAx55r4l8IKbysZVeR3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713432194; x=
	1713518594; bh=OvkJ3JJBdTmm0oyGBN0bERJHPObwKkGyJk/XH2hv2+w=; b=Q
	4mf2IQxAxI0eHnPnmAjs0ZebbcUqkdSCcXx9iHUuENbbX4onrSyFuQ5vBWEDOH49
	rjN+xAIoBPjOH41ROBW6toI+kCXTfa4tDOZhgYNxxYuFC0sFTSrBX6budKb1L539
	IGn6ZbDiZN+cbqcaNXr/2enPwlPQz+8TllTMjKDL5xJ2lJj4IBqyasLtyW7xpOVr
	ci4ourhEJfb8/YFx79kEIsAYH+dkq2VzQb05n/obEviDwD5VSOUHY+5dcApRDzS4
	/8IB1ksTeXZTXRTCSYrGNAfEe+EJeQnDHbEmPBic7SnS1yQtFC58T0QwyLenKEvV
	QxVanQr8ZdbOzfAVW2S1w==
X-ME-Sender: <xms:guYgZlT4O1YxXa6pix8PNxVntC6TEu5ezrLQNFlN750He5UL1Xos_w>
    <xme:guYgZuxPCqZrZWXwhtHyE7nfXkhEBzl9Qzd-cacXGKJZdv9jClIK5IFclkmjc4R1Q
    qhKxhetr9pxDMDaFBY>
X-ME-Received: <xmr:guYgZq1nIkO8RIbX-vKyP8WmymTMQ_2P6u-nrK6qyEiwHTXTf6pRkQQ72Ls83W-n5NyAJ-7oG9N9-_bJFIJ5vRXfcUnfsrIuUlJ69_z-X_veIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudektddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:guYgZtD-Kl3_4_9P4s_l1bNtUW2RNe9htlY8lLNPaJw1taecqtCZDA>
    <xmx:guYgZugiQdD4XPkdzLt5zYCniIqPgGBotv8CMHcUVHKg8c7JnnqjIg>
    <xmx:guYgZhrp3g9xMzbkjlqV1VXAL-BYcxTCc_LxfUs2dlDzgumaoxA3wA>
    <xmx:guYgZpgt7OlA5jhNEGYwySEqRw42A-dQHZuTnJLtM5zzlE5e_0qo2w>
    <xmx:guYgZhulZi3O3rh0IHF5a7I1CRB4tz7XAE4cngsOHo8a0ImHUaKnCnTh>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Apr 2024 05:23:13 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 05/13] firewire: ohci: replace hard-coded values with common macros
Date: Thu, 18 Apr 2024 18:22:55 +0900
Message-ID: <20240418092303.19725-6-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418092303.19725-5-o-takashi@sakamocchi.jp>
References: <20240418092303.19725-1-o-takashi@sakamocchi.jp>
 <20240418092303.19725-2-o-takashi@sakamocchi.jp>
 <20240418092303.19725-3-o-takashi@sakamocchi.jp>
 <20240418092303.19725-4-o-takashi@sakamocchi.jp>
 <20240418092303.19725-5-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the helper function for logging in 1394 ohci driver includes the
hard-coded variables for transaction code. They can be replaced with
the enumerations in UAPI header.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 4666d941a2ae..85223a1c90a1 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -533,11 +533,17 @@ static void log_ar_at_event(struct fw_ohci *ohci,
 	}
 
 	switch (tcode) {
-	case 0x0: case 0x6: case 0x8:
+	case TCODE_WRITE_QUADLET_REQUEST:
+	case TCODE_READ_QUADLET_RESPONSE:
+	case TCODE_CYCLE_START:
 		snprintf(specific, sizeof(specific), " = %08x",
 			 be32_to_cpu((__force __be32)header[3]));
 		break;
-	case 0x1: case 0x5: case 0x7: case 0x9: case 0xb:
+	case TCODE_WRITE_BLOCK_REQUEST:
+	case TCODE_READ_BLOCK_REQUEST:
+	case TCODE_READ_BLOCK_RESPONSE:
+	case TCODE_LOCK_REQUEST:
+	case TCODE_LOCK_RESPONSE:
 		snprintf(specific, sizeof(specific), " %x,%x",
 			 async_header_get_data_length(header),
 			 async_header_get_extended_tcode(header));
@@ -547,7 +553,7 @@ static void log_ar_at_event(struct fw_ohci *ohci,
 	}
 
 	switch (tcode) {
-	case 0xa:
+	case TCODE_STREAM_DATA:
 		ohci_notice(ohci, "A%c %s, %s\n",
 			    dir, evts[evt], tcodes[tcode]);
 		break;
@@ -555,7 +561,11 @@ static void log_ar_at_event(struct fw_ohci *ohci,
 		ohci_notice(ohci, "A%c %s, PHY %08x %08x\n",
 			    dir, evts[evt], header[1], header[2]);
 		break;
-	case 0x0: case 0x1: case 0x4: case 0x5: case 0x9:
+	case TCODE_WRITE_QUADLET_REQUEST:
+	case TCODE_WRITE_BLOCK_REQUEST:
+	case TCODE_READ_QUADLET_REQUEST:
+	case TCODE_READ_BLOCK_REQUEST:
+	case TCODE_LOCK_REQUEST:
 		ohci_notice(ohci,
 			    "A%c spd %x tl %02x, %04x -> %04x, %s, %s, %012llx%s\n",
 			    dir, speed, async_header_get_tlabel(header),
-- 
2.43.0


