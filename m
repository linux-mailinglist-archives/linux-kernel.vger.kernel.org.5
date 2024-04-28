Return-Path: <linux-kernel+bounces-161302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319FC8B4A6B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 09:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1D4281D8E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 07:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4E85474B;
	Sun, 28 Apr 2024 07:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="D8Nn7C3L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NF90Df3V"
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76A053E14
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 07:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714288448; cv=none; b=rMx6He2jFcPg6irhyYj5aw/Mw2Bbg6d3ZnqSnX8ZFpQ5jmwjEA+kmntSrxsnnqqEhwBj+6fEiEep/Ab0a2Gr7lZUMNegxf0Y9Ph3ABQ49XsVrAudCNotR4uKPH64bkKZId/3YVtT1bD4HuXz281i9s4OfXlvlUQ/Kf2TzZRjGoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714288448; c=relaxed/simple;
	bh=2Vaq9fd/yjcb9d0npa84rg+qoGmsdZijjdGRvqKP0ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O8NeYjXTSTXzGg105Ggx/bHBhOYbGNPOE0ueU5kAN+8T826CMaIQVIfiG6kMyK6RS3o/42H1LDfKRqyHH8OFLWHBukjQkzXdY5IepELc6DJ7+txBsBkQhzG8zbXTwgnY4UlQrd5Aq2Kx+2jVGujm7CvatnrTE7LmytRnjePHxYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=D8Nn7C3L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NF90Df3V; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id C336D1C0010E;
	Sun, 28 Apr 2024 03:14:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Sun, 28 Apr 2024 03:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714288445; x=
	1714374845; bh=29saDBiucRwDFm2Dxf2GJ51sLzVdC8ydOKBz+0kYKWI=; b=D
	8Nn7C3LYgunlA2nvLOeV4pixwLbMAnsueIACChcxEn24JVQlgteE/8twmdO31K5s
	D8IEgdQi2KT0Kq6HzWfEAwGNdulFBe+0Xa7jVB1/Bfrf8lRqYRBRu1bkBWf408nq
	j8h+4sg6WevcRiLkyGBTR8QtriEyHi06fK2H/GdXP8bi64OWRaCt81jCKMebAVGE
	1u/B7oq2DANF+F551MUnOaNHfAOSqDlvJQnaNp2ZnS2AIYCcfUiC9mY/KQU+fBGd
	+J9ntILYMNNQAEiKzwAoTW5mPHkJifeKon569dHvnyZeNaTAPnirZ4Et3Mgj/S3H
	DbIsyhq27tFpYJJH/+yZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714288445; x=
	1714374845; bh=29saDBiucRwDFm2Dxf2GJ51sLzVdC8ydOKBz+0kYKWI=; b=N
	F90Df3Vb5Tz84EVApIVzt2YxT8p3xgVDtCTxfCTxpg0B1A9TewWhXPKDvmFN9Kk/
	rFiZZkr4nDJPdaCC5A04fR+SQAHp/6ZqMCIWeixGXD2HWxxv6HO2nEjctee75Pjz
	uHVJCZrPZry8demuk3o2SxndasM4H9nkAd6U9UWaJaIkSKTvj07CaE3Stvoq6uN6
	yvW4mvLP1Ujsvy989PiLKOCcK19You9GlQhT6Rppa3IKz6OxEialqd9vHNI012pa
	nXwViTiSzihjpFkrebzwo1qxAKQmDOUuRmTYmcNroGAwddoowhcfaY+4NYXe00PT
	F4o39IxnidTmNE9wVw9/A==
X-ME-Sender: <xms:PfctZgV37ZvTIZKZYqWVV0ZPMHpuILJyz2F3OxtoUmhC2OGPKEVDIA>
    <xme:PfctZklHnBOGM2cyvXu8MbxHe00q1U_5KF-W6vsBKsYA5TS7y90mJqls5aLJ94Xch
    Gh8l8hPp9jEhkkDMGg>
X-ME-Received: <xmr:PfctZkZIQr4tB92zQujP2g1kzPklb9RWUa03Rvb1xxwRRsKY51pqk4sQv7_SPEtW62KQEXDaeypXY0On_xBx56ENARPV6xX6Cu79ORT-gy-5Tw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:PfctZvUVkyjeGoZ5rYlixXydMvONPw6h08rfQQ9ZNw_snEwJIYDdxA>
    <xmx:PfctZqk7elx4pxaeSwxbpHDjT_3OyGf8eatXvAvfJFslURyaw1umYw>
    <xmx:PfctZkfZV0ABpAn_ymli62MiJOH5grMR-F8hHM0QTez0bW4paCU0BQ>
    <xmx:PfctZsHerqSHDMQy5EuC8-aYCBpjYd13fx1VjN7rQVncjm7S6AlygA>
    <xmx:PfctZvy0Byp59UWpFosU6QXr6dp893x2PA9MH3A2hAfDdrljFScHpJJT>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Apr 2024 03:14:04 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] firewire: core: obsolete tcode check macros with inline functions
Date: Sun, 28 Apr 2024 16:13:44 +0900
Message-ID: <20240428071347.409202-7-o-takashi@sakamocchi.jp>
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

This commit declares the helper functions to check tcode to obsolete
the functional macros.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c |  4 ++--
 drivers/firewire/core.h             | 21 ++++++++++++++-------
 drivers/firewire/ohci.c             |  6 +++---
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index a113f801cf33..45ea15342ab8 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -972,7 +972,7 @@ void fw_core_handle_request(struct fw_card *card, struct fw_packet *p)
 	if (p->ack != ACK_PENDING && p->ack != ACK_COMPLETE)
 		return;
 
-	if (TCODE_IS_LINK_INTERNAL(async_header_get_tcode(p->header))) {
+	if (tcode_is_link_internal(async_header_get_tcode(p->header))) {
 		fw_cdev_handle_phy_packet(card, p);
 		return;
 	}
@@ -1109,7 +1109,7 @@ static void handle_topology_map(struct fw_card *card, struct fw_request *request
 {
 	int start;
 
-	if (!TCODE_IS_READ_REQUEST(tcode)) {
+	if (!tcode_is_read_request(tcode)) {
 		fw_send_response(card, request, RCODE_TYPE_ERROR);
 		return;
 	}
diff --git a/drivers/firewire/core.h b/drivers/firewire/core.h
index ff96e5456b5d..5097c7a270b4 100644
--- a/drivers/firewire/core.h
+++ b/drivers/firewire/core.h
@@ -225,13 +225,20 @@ static inline bool is_next_generation(int new_generation, int old_generation)
 
 #define TCODE_LINK_INTERNAL		0xe
 
-#define TCODE_IS_READ_REQUEST(tcode)	(((tcode) & ~1) == 4)
-#define TCODE_IS_BLOCK_PACKET(tcode)	(((tcode) &  1) != 0)
-#define TCODE_IS_LINK_INTERNAL(tcode)	((tcode) == TCODE_LINK_INTERNAL)
-#define TCODE_IS_REQUEST(tcode)		(((tcode) &  2) == 0)
-#define TCODE_IS_RESPONSE(tcode)	(((tcode) &  2) != 0)
-#define TCODE_HAS_REQUEST_DATA(tcode)	(((tcode) & 12) != 4)
-#define TCODE_HAS_RESPONSE_DATA(tcode)	(((tcode) & 12) != 0)
+static inline bool tcode_is_read_request(unsigned int tcode)
+{
+	return (tcode & ~1u) == 4u;
+}
+
+static inline bool tcode_is_block_packet(unsigned int tcode)
+{
+	return (tcode & 1u) != 0u;
+}
+
+static inline bool tcode_is_link_internal(unsigned int tcode)
+{
+	return (tcode == TCODE_LINK_INTERNAL);
+}
 
 #define LOCAL_BUS 0xffc0
 
diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 4811e3255ca8..6116153f0ce6 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -1382,7 +1382,7 @@ static int at_context_queue_packet(struct context *ctx,
 					(packet->header[0] & 0xffff0000));
 		header[2] = cpu_to_le32(packet->header[2]);
 
-		if (TCODE_IS_BLOCK_PACKET(tcode))
+		if (tcode_is_block_packet(tcode))
 			header[3] = cpu_to_le32(packet->header[3]);
 		else
 			header[3] = (__force __le32) packet->header[3];
@@ -1568,7 +1568,7 @@ static void handle_local_rom(struct fw_ohci *ohci,
 	int tcode, length, i;
 
 	tcode = async_header_get_tcode(packet->header);
-	if (TCODE_IS_BLOCK_PACKET(tcode))
+	if (tcode_is_block_packet(tcode))
 		length = async_header_get_data_length(packet->header);
 	else
 		length = 4;
@@ -1577,7 +1577,7 @@ static void handle_local_rom(struct fw_ohci *ohci,
 	if (i + length > CONFIG_ROM_SIZE) {
 		fw_fill_response(&response, packet->header,
 				 RCODE_ADDRESS_ERROR, NULL, 0);
-	} else if (!TCODE_IS_READ_REQUEST(tcode)) {
+	} else if (!tcode_is_read_request(tcode)) {
 		fw_fill_response(&response, packet->header,
 				 RCODE_TYPE_ERROR, NULL, 0);
 	} else {
-- 
2.43.0


