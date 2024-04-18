Return-Path: <linux-kernel+bounces-149796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 373E48A95F4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6877B1C208EA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AEB15D5CC;
	Thu, 18 Apr 2024 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="jgCeem/i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cvKw6z75"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7438F15B98B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432200; cv=none; b=qbReITEpWhyJciIDHb4sLsoutQJ5evPCoWPMUTGpcA5q3adDWXpyA2F9a4hpN8CegxwDCdK2ca/XQ32k7PZjYIreU7ZHbj0wVF3sUKB88epWBlaPanEFPO1movhP2bLhIujTJddgWdCYnXg5lkCwDj4m99wcGGHAFsffZVpifgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432200; c=relaxed/simple;
	bh=pLO3FhGZaNArOcfH1KMiwUqgnwV+BSPoHLgSZPIR818=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baqrkqgxfdFI/ICfYBX55WoomTaxeIyQBebKkPSx/hjVLEZs5yTSqaRRsKt2I0ZKClHWYog1jj5orwM3MqHV/nAW5mB4gc+SnI8PQg99vvb7Owv92DeRuktu9tGkbk3kzfaW2GjoWI6WyEzbSUTn6gLCrq+q0xdKtYRZOWCQjeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=jgCeem/i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cvKw6z75; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B32541140121;
	Thu, 18 Apr 2024 05:23:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 18 Apr 2024 05:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1713432198; x=
	1713518598; bh=e+bYK+97MmRa/Ky4nfoRqpy88xXQ8TuiU/pcMg4OPnk=; b=j
	gCeem/i7hOGoJRPWD74Y3vg3gZGNQI/Qhd9qZcr/JywlZHsDHxXzKWnijdRHicqu
	SnwI9xah4cAhL45tSb415zZvwiRJx+SaAWdQ+OOLU2UIdZI1ADN1gbI98gbS2tTc
	9TX43SK4iZ50dTtXt/h4WEa2nMn7OjFNRib1maEyhxnl/SmUsaXq0jenZZom1Q2G
	wnG/Z/RtyvJC6a+TkQs9P2OrbUrRuoLUWcg/K3PpA4XvMfAot632tcqgCHhX5d/E
	JJrcOMKoaKi4W9u3kNq9a97GtQjSNQafrm5qQoaYRQJUaopKKywulVsvfdgvBnTW
	HzPzvQ1vQQqBFBYUt1yxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713432198; x=
	1713518598; bh=e+bYK+97MmRa/Ky4nfoRqpy88xXQ8TuiU/pcMg4OPnk=; b=c
	vKw6z75l+Ubezx6INQOX/CDgZ6CpU1UJwgSUlnOkAuu0qlcqGkS3Di5c6jeWZX/G
	jmuWvwkc/rrN0g6EvtvmUvL23IatpwBs4C313qWCKxCIpyEnUOXIB3bhpuUMQLW3
	XDqlW8zJaZCnHoVP8hczWbfjwA8xOV4wZhvOt8ulOLlTIdY69UV08aGQryqIZQ8i
	QoyhI6v+/Sk0Pqmx/e2gYP9gz2gq/htvHpF8zhlHUDOxd496FNefLxWnMxt9lsfW
	cQzCIGeBRJAaOgMxDjfw2uzI8uhIR5ui/7OvIwM0sn5nnk6lqTJjaz1GnfVIz1Mk
	0zaU05xjQ24s9SVKEb55w==
X-ME-Sender: <xms:huYgZmwLgy3NO8qaJEkVUpJrPiYUr9RFPseP9-EpohXLcEMLzFwkDw>
    <xme:huYgZiQBlZQYITtsyF9yspdGnYflitzuNLetqwW239Of2FmhPmK--om5TT8DesxVu
    RASmA0VbZVj5jfMxAA>
X-ME-Received: <xmr:huYgZoUsCF89GXlOiNEKvWDpyGpmVRYNrsOTAZPvzxYIyPxNQMgPDiP437_-yyfnQaYk0JkfE7a3V49p_SLc-vpSKf_04hZoQ7AGrbcOtbTPFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudektddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:huYgZsje-XM1e9AGKlSk86ZrL49tu8ufh8pz8o6R1Ll6K40OqKaNcg>
    <xmx:huYgZoBPL-wv-DcKqE7Bckh9EAQjacsexCicaquExstdnX1Xa-GDEg>
    <xmx:huYgZtJ1eNz8hiIyXaulbDqdaequYFB1Usgta1Q6WpUN9XaxRwY49w>
    <xmx:huYgZvBnWkV-TuoCrBZDjCQZATTvn46f5vAwJt6Uvq5mjRuAPmJuIw>
    <xmx:huYgZrPMxI5T_LhETwyNG18yytHw_zfrnYHcPGNjCyhUbL5XhzlILA4J>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Apr 2024 05:23:17 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 08/13] firewire: core: replace local macros with common inline functions for isochronous packet header
Date: Thu, 18 Apr 2024 18:22:58 +0900
Message-ID: <20240418092303.19725-9-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418092303.19725-8-o-takashi@sakamocchi.jp>
References: <20240418092303.19725-1-o-takashi@sakamocchi.jp>
 <20240418092303.19725-2-o-takashi@sakamocchi.jp>
 <20240418092303.19725-3-o-takashi@sakamocchi.jp>
 <20240418092303.19725-4-o-takashi@sakamocchi.jp>
 <20240418092303.19725-5-o-takashi@sakamocchi.jp>
 <20240418092303.19725-6-o-takashi@sakamocchi.jp>
 <20240418092303.19725-7-o-takashi@sakamocchi.jp>
 <20240418092303.19725-8-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit replaces the local macros with the common inline functions
to serialize the packer header for Asynchronous Streaming Packet.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index 24febc23c0c4..52d8d483c178 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -31,9 +31,6 @@
 #include "core.h"
 #include "packet-header-definitions.h"
 
-#define HEADER_TCODE(tcode)		((tcode) << 4)
-#define HEADER_DATA_LENGTH(length)	((length) << 16)
-
 #define HEADER_DESTINATION_IS_BROADCAST(header) \
 	((async_header_get_destination(header) & 0x3f) == 0x3f)
 
@@ -215,10 +212,11 @@ static void fw_fill_request(struct fw_packet *packet, int tcode, int tlabel,
 	int ext_tcode;
 
 	if (tcode == TCODE_STREAM_DATA) {
-		packet->header[0] =
-			HEADER_DATA_LENGTH(length) |
-			destination_id |
-			HEADER_TCODE(TCODE_STREAM_DATA);
+		// The value of destination_id argument should include tag, channel, and sy fields
+		// as isochronous packet header has.
+		packet->header[0] = destination_id;
+		isoc_header_set_data_length(packet->header, length);
+		isoc_header_set_tcode(packet->header, TCODE_STREAM_DATA);
 		packet->header_length = 4;
 		packet->payload = payload;
 		packet->payload_length = length;
-- 
2.43.0


