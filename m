Return-Path: <linux-kernel+bounces-161298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B63748B4A61
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 09:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9B571C20D8F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 07:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F38524DE;
	Sun, 28 Apr 2024 07:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="XzbagI2p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e4zDaDUO"
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA52E50A67
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 07:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714288440; cv=none; b=n3V8CJtDO0YkkL1NzuVpXmFpmBQ6aOE492cyK/PGcMHWrLioFu+LSx1o0uPeLKaRE+yeUrZu4+/yCL/BM3uLZEb4U/khfHvmbTK3RU5i2IQ5vxGT+cXfDunSaPM8pckZ1XmtQ0JdtychA1w2zgVdiweuF56AkBS/s+Ql4tXYhZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714288440; c=relaxed/simple;
	bh=jjbi1AEp8NlXwrb4Zc+88MD1lPSM8EZS1QDcg+6nMyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGCxCc+PUtf/uC7jrqH2SOkQbbtjVABfAN4hpPekoZrycccaM4zPj1UYVpQObuCP0HavLvikqMlR+7wPP0yrWQJjoQ+q0hQmEfYntXimC70KzBwcOUJt5k6gnK8cbuO0FPLBDWhR1R19Ids8ASWDrLvHJ9yxdxVSVFt6kefBmdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=XzbagI2p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e4zDaDUO; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id C55EC1C00112;
	Sun, 28 Apr 2024 03:13:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 28 Apr 2024 03:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714288436; x=
	1714374836; bh=bhe/jIX2fIrMMP4LYFpXfC38ZNlP+77hegb1D1tYzu0=; b=X
	zbagI2ps3VaB1k2e3h5ADISbO1wfGxH51gUdiwSe7WX/DEr8RPVLW8VFlRU5yXer
	C40uetr3rF3F5vmQ032JGVEL98rIGkWl7Gs93kO1VIagWooOdkr1LxUvwQC6CGUF
	b/MEmNclq12E2c2/q37ijG4fag2YLZ0SsJ8qa8GRAps70gcDU9Oo4mUGTLlZ9OT7
	5/OH58qGLOFrrwI3PQPdF50yPDylAj6xTjDlmiXlvOUMyWAI28N3GigUXWSBm5GJ
	1n4PTISELkUGQU3U0S+X/xjZYMAh+9vixzj/ka2QBUs3G2e9YPCQySpJFSMjxE0t
	rH6aeNjEBMF0xjD49CtFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714288436; x=
	1714374836; bh=bhe/jIX2fIrMMP4LYFpXfC38ZNlP+77hegb1D1tYzu0=; b=e
	4zDaDUOICGWmEzk2xZymKd8lsXjjnHok3Xo6/mLRQg5K/1OuYVaJmvF6d5uNmgaN
	PovT1zMiA9uuHVooYZGJGPvYZCNl+Tgpyf9agGysSOKVlUnPSHF63eD+3tqOamGO
	tmGicS7b9Ec8h3Ddjs2oXrm+LYsY4azD4uv7z0XHrKCFinvxx4VLXuNGH8yBgOur
	Nl+Pej5uGqlItCHHVWe3jT/C5R/ViHTfUq9T8WIzOhe0DhEyoqQ/TAAezLJWL+rR
	kLKLfZcbQb0CCrhRzxKi8vg4aXK1qstqLLUTgN6/GHxIUM1Va77Cb+jCy69hA5AQ
	Hk6K6POd4LHsjHtL6Ve2w==
X-ME-Sender: <xms:NPctZs8XWQBesvoEwlIhtEY8Bl8FNMYF9TM_d_RKEYrrpqyr-qWRAw>
    <xme:NPctZks5He7G7pgBbZ0f3GZ5xxVJSbI7HDA-rq_Vdo4ztlOXF_9kANkxQ8sGJRwHz
    31AsM8q1yT9fwNVzuo>
X-ME-Received: <xmr:NPctZiAfb3b7wy93PK9L54cRH2jS_RJTAD8-LoGzrpmWyYfl2vESPZnXCRYHD7xACjMB-Dt0MjZtm_s-AZfK1uwW-yaYujJqf1PiIqWHvC9Pww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:NPctZsdsqvnEhPrT2C_YzQ9a3PfknPtWshbJ-z-Ear-oeSFIS7DbfQ>
    <xmx:NPctZhPfAoGATf5nnpda2CgvunTZWnCX-6lZd-mcstIxWBgmwgDMbA>
    <xmx:NPctZmmpDiP0Nyqp1lCIn2extD3skF7hwlK5npx6GG9Hc-fVX97bkw>
    <xmx:NPctZjsJ3MYUzWI3TKFPRqSes-xklMSMyRPLnKljbMyx6vRCADhJfw>
    <xmx:NPctZqabdTGD9RKcJ1tnRX1aVtnUQ3ziXq4QCNsT6lOptR6cbd5C-2Sn>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Apr 2024 03:13:55 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] firewire: core: replace local macros with common inline functions for asynchronous packet header
Date: Sun, 28 Apr 2024 16:13:40 +0900
Message-ID: <20240428071347.409202-3-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240428071347.409202-1-o-takashi@sakamocchi.jp>
References: <20240428071347.409202-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit uses common inline functions to serialize and deserialize
header of asynchronous packet.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c | 138 +++++++++++-----------------
 1 file changed, 56 insertions(+), 82 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index c427b7861eaf..a113f801cf33 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -29,29 +29,13 @@
 #include <asm/byteorder.h>
 
 #include "core.h"
+#include "packet-header-definitions.h"
 
-#define HEADER_PRI(pri)			((pri) << 0)
 #define HEADER_TCODE(tcode)		((tcode) << 4)
-#define HEADER_RETRY(retry)		((retry) << 8)
-#define HEADER_TLABEL(tlabel)		((tlabel) << 10)
-#define HEADER_DESTINATION(destination)	((destination) << 16)
-#define HEADER_SOURCE(source)		((source) << 16)
-#define HEADER_RCODE(rcode)		((rcode) << 12)
-#define HEADER_OFFSET_HIGH(offset_high)	((offset_high) << 0)
 #define HEADER_DATA_LENGTH(length)	((length) << 16)
-#define HEADER_EXTENDED_TCODE(tcode)	((tcode) << 0)
 
-#define HEADER_GET_TCODE(q)		(((q) >> 4) & 0x0f)
-#define HEADER_GET_TLABEL(q)		(((q) >> 10) & 0x3f)
-#define HEADER_GET_RCODE(q)		(((q) >> 12) & 0x0f)
-#define HEADER_GET_DESTINATION(q)	(((q) >> 16) & 0xffff)
-#define HEADER_GET_SOURCE(q)		(((q) >> 16) & 0xffff)
-#define HEADER_GET_OFFSET_HIGH(q)	(((q) >> 0) & 0xffff)
-#define HEADER_GET_DATA_LENGTH(q)	(((q) >> 16) & 0xffff)
-#define HEADER_GET_EXTENDED_TCODE(q)	(((q) >> 0) & 0xffff)
-
-#define HEADER_DESTINATION_IS_BROADCAST(q) \
-	(((q) & HEADER_DESTINATION(0x3f)) == HEADER_DESTINATION(0x3f))
+#define HEADER_DESTINATION_IS_BROADCAST(header) \
+	((async_header_get_destination(header) & 0x3f) == 0x3f)
 
 #define PHY_PACKET_CONFIG	0x0
 #define PHY_PACKET_LINK_ON	0x1
@@ -248,28 +232,24 @@ static void fw_fill_request(struct fw_packet *packet, int tcode, int tlabel,
 	} else
 		ext_tcode = 0;
 
-	packet->header[0] =
-		HEADER_RETRY(RETRY_X) |
-		HEADER_TLABEL(tlabel) |
-		HEADER_TCODE(tcode) |
-		HEADER_DESTINATION(destination_id);
-	packet->header[1] =
-		HEADER_OFFSET_HIGH(offset >> 32) | HEADER_SOURCE(source_id);
-	packet->header[2] =
-		offset;
+	async_header_set_retry(packet->header, RETRY_X);
+	async_header_set_tlabel(packet->header, tlabel);
+	async_header_set_tcode(packet->header, tcode);
+	async_header_set_destination(packet->header, destination_id);
+	async_header_set_source(packet->header, source_id);
+	async_header_set_offset(packet->header, offset);
 
 	switch (tcode) {
 	case TCODE_WRITE_QUADLET_REQUEST:
-		packet->header[3] = *(u32 *)payload;
+		async_header_set_quadlet_data(packet->header, *(u32 *)payload);
 		packet->header_length = 16;
 		packet->payload_length = 0;
 		break;
 
 	case TCODE_LOCK_REQUEST:
 	case TCODE_WRITE_BLOCK_REQUEST:
-		packet->header[3] =
-			HEADER_DATA_LENGTH(length) |
-			HEADER_EXTENDED_TCODE(ext_tcode);
+		async_header_set_data_length(packet->header, length);
+		async_header_set_extended_tcode(packet->header, ext_tcode);
 		packet->header_length = 16;
 		packet->payload = payload;
 		packet->payload_length = length;
@@ -281,9 +261,8 @@ static void fw_fill_request(struct fw_packet *packet, int tcode, int tlabel,
 		break;
 
 	case TCODE_READ_BLOCK_REQUEST:
-		packet->header[3] =
-			HEADER_DATA_LENGTH(length) |
-			HEADER_EXTENDED_TCODE(ext_tcode);
+		async_header_set_data_length(packet->header, length);
+		async_header_set_extended_tcode(packet->header, ext_tcode);
 		packet->header_length = 16;
 		packet->payload_length = 0;
 		break;
@@ -655,7 +634,7 @@ EXPORT_SYMBOL(fw_core_remove_address_handler);
 struct fw_request {
 	struct kref kref;
 	struct fw_packet response;
-	u32 request_header[4];
+	u32 request_header[ASYNC_HEADER_QUADLET_COUNT];
 	int ack;
 	u32 timestamp;
 	u32 length;
@@ -695,7 +674,7 @@ int fw_get_response_length(struct fw_request *r)
 {
 	int tcode, ext_tcode, data_length;
 
-	tcode = HEADER_GET_TCODE(r->request_header[0]);
+	tcode = async_header_get_tcode(r->request_header);
 
 	switch (tcode) {
 	case TCODE_WRITE_QUADLET_REQUEST:
@@ -706,12 +685,12 @@ int fw_get_response_length(struct fw_request *r)
 		return 4;
 
 	case TCODE_READ_BLOCK_REQUEST:
-		data_length = HEADER_GET_DATA_LENGTH(r->request_header[3]);
+		data_length = async_header_get_data_length(r->request_header);
 		return data_length;
 
 	case TCODE_LOCK_REQUEST:
-		ext_tcode = HEADER_GET_EXTENDED_TCODE(r->request_header[3]);
-		data_length = HEADER_GET_DATA_LENGTH(r->request_header[3]);
+		ext_tcode = async_header_get_extended_tcode(r->request_header);
+		data_length = async_header_get_data_length(r->request_header);
 		switch (ext_tcode) {
 		case EXTCODE_FETCH_ADD:
 		case EXTCODE_LITTLE_ADD:
@@ -731,46 +710,42 @@ void fw_fill_response(struct fw_packet *response, u32 *request_header,
 {
 	int tcode, tlabel, extended_tcode, source, destination;
 
-	tcode          = HEADER_GET_TCODE(request_header[0]);
-	tlabel         = HEADER_GET_TLABEL(request_header[0]);
-	source         = HEADER_GET_DESTINATION(request_header[0]);
-	destination    = HEADER_GET_SOURCE(request_header[1]);
-	extended_tcode = HEADER_GET_EXTENDED_TCODE(request_header[3]);
-
-	response->header[0] =
-		HEADER_RETRY(RETRY_1) |
-		HEADER_TLABEL(tlabel) |
-		HEADER_DESTINATION(destination);
-	response->header[1] =
-		HEADER_SOURCE(source) |
-		HEADER_RCODE(rcode);
-	response->header[2] = 0;
+	tcode = async_header_get_tcode(request_header);
+	tlabel = async_header_get_tlabel(request_header);
+	source = async_header_get_destination(request_header); // Exchange.
+	destination = async_header_get_source(request_header); // Exchange.
+	extended_tcode = async_header_get_extended_tcode(request_header);
+
+	async_header_set_retry(response->header, RETRY_1);
+	async_header_set_tlabel(response->header, tlabel);
+	async_header_set_destination(response->header, destination);
+	async_header_set_source(response->header, source);
+	async_header_set_rcode(response->header, rcode);
+	response->header[2] = 0;	// The field is reserved.
 
 	switch (tcode) {
 	case TCODE_WRITE_QUADLET_REQUEST:
 	case TCODE_WRITE_BLOCK_REQUEST:
-		response->header[0] |= HEADER_TCODE(TCODE_WRITE_RESPONSE);
+		async_header_set_tcode(response->header, TCODE_WRITE_RESPONSE);
 		response->header_length = 12;
 		response->payload_length = 0;
 		break;
 
 	case TCODE_READ_QUADLET_REQUEST:
-		response->header[0] |=
-			HEADER_TCODE(TCODE_READ_QUADLET_RESPONSE);
+		async_header_set_tcode(response->header, TCODE_READ_QUADLET_RESPONSE);
 		if (payload != NULL)
-			response->header[3] = *(u32 *)payload;
+			async_header_set_quadlet_data(response->header, *(u32 *)payload);
 		else
-			response->header[3] = 0;
+			async_header_set_quadlet_data(response->header, 0);
 		response->header_length = 16;
 		response->payload_length = 0;
 		break;
 
 	case TCODE_READ_BLOCK_REQUEST:
 	case TCODE_LOCK_REQUEST:
-		response->header[0] |= HEADER_TCODE(tcode + 2);
-		response->header[3] =
-			HEADER_DATA_LENGTH(length) |
-			HEADER_EXTENDED_TCODE(extended_tcode);
+		async_header_set_tcode(response->header, tcode + 2);
+		async_header_set_data_length(response->header, length);
+		async_header_set_extended_tcode(response->header, extended_tcode);
 		response->header_length = 16;
 		response->payload = payload;
 		response->payload_length = length;
@@ -807,7 +782,7 @@ static struct fw_request *allocate_request(struct fw_card *card,
 	u32 *data, length;
 	int request_tcode;
 
-	request_tcode = HEADER_GET_TCODE(p->header[0]);
+	request_tcode = async_header_get_tcode(p->header);
 	switch (request_tcode) {
 	case TCODE_WRITE_QUADLET_REQUEST:
 		data = &p->header[3];
@@ -817,7 +792,7 @@ static struct fw_request *allocate_request(struct fw_card *card,
 	case TCODE_WRITE_BLOCK_REQUEST:
 	case TCODE_LOCK_REQUEST:
 		data = p->payload;
-		length = HEADER_GET_DATA_LENGTH(p->header[3]);
+		length = async_header_get_data_length(p->header);
 		break;
 
 	case TCODE_READ_QUADLET_REQUEST:
@@ -827,7 +802,7 @@ static struct fw_request *allocate_request(struct fw_card *card,
 
 	case TCODE_READ_BLOCK_REQUEST:
 		data = NULL;
-		length = HEADER_GET_DATA_LENGTH(p->header[3]);
+		length = async_header_get_data_length(p->header);
 		break;
 
 	default:
@@ -872,7 +847,7 @@ void fw_send_response(struct fw_card *card,
 {
 	/* unified transaction or broadcast transaction: don't respond */
 	if (request->ack != ACK_PENDING ||
-	    HEADER_DESTINATION_IS_BROADCAST(request->request_header[0])) {
+	    HEADER_DESTINATION_IS_BROADCAST(request->request_header)) {
 		fw_request_put(request);
 		return;
 	}
@@ -926,11 +901,11 @@ static void handle_exclusive_region_request(struct fw_card *card,
 	struct fw_address_handler *handler;
 	int tcode, destination, source;
 
-	destination = HEADER_GET_DESTINATION(p->header[0]);
-	source      = HEADER_GET_SOURCE(p->header[1]);
-	tcode       = HEADER_GET_TCODE(p->header[0]);
+	destination = async_header_get_destination(p->header);
+	source = async_header_get_source(p->header);
+	tcode = async_header_get_tcode(p->header);
 	if (tcode == TCODE_LOCK_REQUEST)
-		tcode = 0x10 + HEADER_GET_EXTENDED_TCODE(p->header[3]);
+		tcode = 0x10 + async_header_get_extended_tcode(p->header);
 
 	rcu_read_lock();
 	handler = lookup_enclosing_address_handler(&address_handler_list,
@@ -963,9 +938,9 @@ static void handle_fcp_region_request(struct fw_card *card,
 		return;
 	}
 
-	tcode       = HEADER_GET_TCODE(p->header[0]);
-	destination = HEADER_GET_DESTINATION(p->header[0]);
-	source      = HEADER_GET_SOURCE(p->header[1]);
+	tcode = async_header_get_tcode(p->header);
+	destination = async_header_get_destination(p->header);
+	source = async_header_get_source(p->header);
 
 	if (tcode != TCODE_WRITE_QUADLET_REQUEST &&
 	    tcode != TCODE_WRITE_BLOCK_REQUEST) {
@@ -997,7 +972,7 @@ void fw_core_handle_request(struct fw_card *card, struct fw_packet *p)
 	if (p->ack != ACK_PENDING && p->ack != ACK_COMPLETE)
 		return;
 
-	if (TCODE_IS_LINK_INTERNAL(HEADER_GET_TCODE(p->header[0]))) {
+	if (TCODE_IS_LINK_INTERNAL(async_header_get_tcode(p->header))) {
 		fw_cdev_handle_phy_packet(card, p);
 		return;
 	}
@@ -1008,8 +983,7 @@ void fw_core_handle_request(struct fw_card *card, struct fw_packet *p)
 		return;
 	}
 
-	offset = ((u64)HEADER_GET_OFFSET_HIGH(p->header[1]) << 32) |
-		p->header[2];
+	offset = async_header_get_offset(p->header);
 
 	if (!is_in_fcp_region(offset, request->length))
 		handle_exclusive_region_request(card, p, request, offset);
@@ -1027,10 +1001,10 @@ void fw_core_handle_response(struct fw_card *card, struct fw_packet *p)
 	size_t data_length;
 	int tcode, tlabel, source, rcode;
 
-	tcode	= HEADER_GET_TCODE(p->header[0]);
-	tlabel	= HEADER_GET_TLABEL(p->header[0]);
-	source	= HEADER_GET_SOURCE(p->header[1]);
-	rcode	= HEADER_GET_RCODE(p->header[1]);
+	tcode = async_header_get_tcode(p->header);
+	tlabel = async_header_get_tlabel(p->header);
+	source = async_header_get_source(p->header);
+	rcode = async_header_get_rcode(p->header);
 
 	spin_lock_irqsave(&card->lock, flags);
 	list_for_each_entry(iter, &card->transaction_list, link) {
@@ -1073,7 +1047,7 @@ void fw_core_handle_response(struct fw_card *card, struct fw_packet *p)
 	case TCODE_READ_BLOCK_RESPONSE:
 	case TCODE_LOCK_RESPONSE:
 		data = p->payload;
-		data_length = HEADER_GET_DATA_LENGTH(p->header[3]);
+		data_length = async_header_get_data_length(p->header);
 		break;
 
 	default:
-- 
2.43.0


