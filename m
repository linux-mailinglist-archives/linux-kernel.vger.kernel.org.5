Return-Path: <linux-kernel+bounces-161303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 425448B4A6C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 09:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 659991C20D64
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 07:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFAC548F6;
	Sun, 28 Apr 2024 07:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="LFCkfgP8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PeLsxGaG"
Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0756054737
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 07:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714288450; cv=none; b=rvTzDjGS2bMIoYUNI/R/otvX78lmcY617DJH7hrF0uo1S4IVd1QLWTqvDSC7ILENe4D3YwzSZCuosmJwooGg9Xz5N0cTcWKd2qOaSYM5Yj5Pg45I8T4H5JvRzQa8aJKPL71QTnsTs/R43s6nncSIQzs7GA88cA9fqEaq+WldhO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714288450; c=relaxed/simple;
	bh=3LZ2rckMN5vRD3KByODttuDnXLjALQHZtYdntvxbJI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZ33uCzQtO6dwDso9eUJ0uK53ketgFN6NzSJ4VYZpcp0qymr/JrxvcrmtPAXzAK9tEUKCjyaeahxiIZg1l7qIWIc30KAdyWGCpflQjadCvyghNbcSGwC2nooAOvglfVlphKg/VKdWBeY7JverEoELRC7ieoxsn+u8K8NrmSc964=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=LFCkfgP8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PeLsxGaG; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id 199241800142;
	Sun, 28 Apr 2024 03:14:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 28 Apr 2024 03:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714288447; x=
	1714374847; bh=/e7fuxX/vtKPR4pmRS6j0FIOy9tSq6SszBVnEsJ8ruY=; b=L
	FCkfgP8D61oyhA0PBUXCsopLXsuc8ITMR6DoIgWBnbKu4Mc3UZUfWSnFtZNWKae4
	rEsch/OPbVuGAxEO4izym4o+ys0WZ9Pnfce5Usmw+DfUi5KzsYIq2VxZIh0yfnLq
	4eKlxGIaAuzTtHuK3tCFR8/y+7KquhEEOcm7FiJYroPan4nZwC4LcicMtlesJMqz
	o8cS9C4I2Uon32wLQgQZVCMirB5MARrkRZ00/wDyeg2LAP0VU9pQmorxeN01IaEP
	lmJtW+RhTa+XMRh4Uz1cLaOQt0OSNeJ4sPp8LQgOrS4XDYK2JBVBe3p7fh28HzAl
	Azk09VNz5uqTPsmp/+M1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714288447; x=
	1714374847; bh=/e7fuxX/vtKPR4pmRS6j0FIOy9tSq6SszBVnEsJ8ruY=; b=P
	eLsxGaG0mmymGdV29C1kWA9FzNuEnA25tB4hLV3Wfbo1osVnjXgGP2v04cQ5A8jE
	XbhyWOSa+UNcxXKTqAqWnCNDrJjYan/QUOfvRUJrQly7S4rs95MWKobyBsIU7fEV
	pVbLiSt8JBfB1a30a7JhGsRL+s2fcgghevSJ+ORu+phx+D79MvbH/D7Bw5NbCVsa
	CPJl9WleK47ZrPhyX9jD4v6Vz3/0Fy5a+I5uC42Ni3JZf0cfobdA+/vbY7TbCwv4
	ABdhcxiZM3ycA3lNKKfP25wDeeW4OFO2F37dYWxIUYhfLiCEk8C+BldIkGdjxBbc
	S9Q6jv86vJYR0i7dZ15Cg==
X-ME-Sender: <xms:P_ctZkv9fFGQbLU0_p8WuPX-6mWfpVS9Qyf2ta5aD45DUvkSneqsgg>
    <xme:P_ctZhdX49A3yi_JLkicnm4B1XFGPpYrhMnAk_4FKs4HsnLlqYJ9h0M8_FOis7s28
    jTooG-wwroqsmX50So>
X-ME-Received: <xmr:P_ctZvwWn2NH0NPOqrwVwvc5UKHSJ5Oatmp2kq-2qTfHjUXwmBtOSwipZA2-ltQlJkJpSzF-5fiwU11N5EQo13X5Dn9_--mcDp4568awVcta6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:P_ctZnOdllbsXhd3XNpQrtNmjB7-gPZiGWd5OtZUN3MW58SV3JEPhw>
    <xmx:P_ctZk8g3ksQQ43WmYnyW1PJ897agT946rbWKLNvNcNPqd-7mi1C0A>
    <xmx:P_ctZvVXVaoHmBstu3xmG9VHDavSWzyaq11rnbLaTATXnTlJIaeEqQ>
    <xmx:P_ctZtci1jHRlM8c4VEl29ML8ab_qfj1yfEuKj2vwyH8Z6Kny-3I2Q>
    <xmx:P_ctZmJI6Tah-bFeVmMHA7QlOXNpXJDUeKvgnl4gdocgvYnDVF17aFVb>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Apr 2024 03:14:06 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] firewire: core: add common macro to serialize/deserialize isochronous packet header
Date: Sun, 28 Apr 2024 16:13:45 +0900
Message-ID: <20240428071347.409202-8-o-takashi@sakamocchi.jp>
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

The packet for Asynchronous Streaming Packet includes the same header
fields as the isochronous packet has. It is helpful to have some helper
functions to serialize/deserialize them.

This commit adds such helper functions with their test.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/packet-header-definitions.h | 66 ++++++++++++++++++++
 drivers/firewire/packet-serdes-test.c        | 44 +++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/drivers/firewire/packet-header-definitions.h b/drivers/firewire/packet-header-definitions.h
index 83e550427706..ab9d0fa790d4 100644
--- a/drivers/firewire/packet-header-definitions.h
+++ b/drivers/firewire/packet-header-definitions.h
@@ -165,4 +165,70 @@ static inline void async_header_set_extended_tcode(u32 header[ASYNC_HEADER_QUADL
 	header[3] |= (((u32)extended_tcode) << ASYNC_HEADER_Q3_EXTENDED_TCODE_SHIFT) & ASYNC_HEADER_Q3_EXTENDED_TCODE_MASK;
 }
 
+#define ISOC_HEADER_DATA_LENGTH_SHIFT		16
+#define ISOC_HEADER_DATA_LENGTH_MASK		0xffff0000
+#define ISOC_HEADER_TAG_SHIFT			14
+#define ISOC_HEADER_TAG_MASK			0x0000c000
+#define ISOC_HEADER_CHANNEL_SHIFT		8
+#define ISOC_HEADER_CHANNEL_MASK		0x00003f00
+#define ISOC_HEADER_TCODE_SHIFT			4
+#define ISOC_HEADER_TCODE_MASK			0x000000f0
+#define ISOC_HEADER_SY_SHIFT			0
+#define ISOC_HEADER_SY_MASK			0x0000000f
+
+static inline unsigned int isoc_header_get_data_length(u32 header)
+{
+	return (header & ISOC_HEADER_DATA_LENGTH_MASK) >> ISOC_HEADER_DATA_LENGTH_SHIFT;
+}
+
+static inline unsigned int isoc_header_get_tag(u32 header)
+{
+	return (header & ISOC_HEADER_TAG_MASK) >> ISOC_HEADER_TAG_SHIFT;
+}
+
+static inline unsigned int isoc_header_get_channel(u32 header)
+{
+	return (header & ISOC_HEADER_CHANNEL_MASK) >> ISOC_HEADER_CHANNEL_SHIFT;
+}
+
+static inline unsigned int isoc_header_get_tcode(u32 header)
+{
+	return (header & ISOC_HEADER_TCODE_MASK) >> ISOC_HEADER_TCODE_SHIFT;
+}
+
+static inline unsigned int isoc_header_get_sy(u32 header)
+{
+	return (header & ISOC_HEADER_SY_MASK) >> ISOC_HEADER_SY_SHIFT;
+}
+
+static inline void isoc_header_set_data_length(u32 *header, unsigned int data_length)
+{
+	*header &= ~ISOC_HEADER_DATA_LENGTH_MASK;
+	*header |= (((u32)data_length) << ISOC_HEADER_DATA_LENGTH_SHIFT) & ISOC_HEADER_DATA_LENGTH_MASK;
+}
+
+static inline void isoc_header_set_tag(u32 *header, unsigned int tag)
+{
+	*header &= ~ISOC_HEADER_TAG_MASK;
+	*header |= (((u32)tag) << ISOC_HEADER_TAG_SHIFT) & ISOC_HEADER_TAG_MASK;
+}
+
+static inline void isoc_header_set_channel(u32 *header, unsigned int channel)
+{
+	*header &= ~ISOC_HEADER_CHANNEL_MASK;
+	*header |= (((u32)channel) << ISOC_HEADER_CHANNEL_SHIFT) & ISOC_HEADER_CHANNEL_MASK;
+}
+
+static inline void isoc_header_set_tcode(u32 *header, unsigned int tcode)
+{
+	*header &= ~ISOC_HEADER_TCODE_MASK;
+	*header |= (((u32)tcode) << ISOC_HEADER_TCODE_SHIFT) & ISOC_HEADER_TCODE_MASK;
+}
+
+static inline void isoc_header_set_sy(u32 *header, unsigned int sy)
+{
+	*header &= ~ISOC_HEADER_SY_MASK;
+	*header |= (((u32)sy) << ISOC_HEADER_SY_SHIFT) & ISOC_HEADER_SY_MASK;
+}
+
 #endif // _FIREWIRE_PACKET_HEADER_DEFINITIONS_H
diff --git a/drivers/firewire/packet-serdes-test.c b/drivers/firewire/packet-serdes-test.c
index 299e9f908463..f93c966e794d 100644
--- a/drivers/firewire/packet-serdes-test.c
+++ b/drivers/firewire/packet-serdes-test.c
@@ -167,6 +167,26 @@ static void deserialize_async_header_block_response(const u32 header[ASYNC_HEADE
 	*extended_tcode = async_header_get_extended_tcode(header);
 }
 
+static void serialize_isoc_header(u32 *header, unsigned int data_length, unsigned int tag,
+				  unsigned int channel, unsigned int tcode, unsigned int sy)
+{
+	isoc_header_set_data_length(header, data_length);
+	isoc_header_set_tag(header, tag);
+	isoc_header_set_channel(header, channel);
+	isoc_header_set_tcode(header, tcode);
+	isoc_header_set_sy(header, sy);
+}
+
+static void deserialize_isoc_header(u32 header, unsigned int *data_length, unsigned int *tag,
+				    unsigned int *channel, unsigned int *tcode, unsigned int *sy)
+{
+	*data_length = isoc_header_get_data_length(header);
+	*tag = isoc_header_get_tag(header);
+	*channel = isoc_header_get_channel(header);
+	*tcode = isoc_header_get_tcode(header);
+	*sy = isoc_header_get_sy(header);
+}
+
 static void test_async_header_write_quadlet_request(struct kunit *test)
 {
 	static const u32 expected[ASYNC_HEADER_QUADLET_COUNT] = {
@@ -515,6 +535,29 @@ static void test_async_header_lock_response(struct kunit *test)
 	KUNIT_EXPECT_MEMEQ(test, header, expected, sizeof(expected));
 }
 
+static void test_isoc_header(struct kunit *test)
+{
+	const u32 expected = 0x00d08dec;
+	u32 header = 0;
+
+	unsigned int data_length;
+	unsigned int tag;
+	unsigned int channel;
+	unsigned int tcode;
+	unsigned int sy;
+
+	deserialize_isoc_header(expected, &data_length, &tag, &channel, &tcode, &sy);
+
+	KUNIT_EXPECT_EQ(test, 0xd0, data_length);
+	KUNIT_EXPECT_EQ(test, 0x02, tag);
+	KUNIT_EXPECT_EQ(test, 0x0d, channel);
+	KUNIT_EXPECT_EQ(test, 0x0e, tcode);
+	KUNIT_EXPECT_EQ(test, 0x0c, sy);
+
+	serialize_isoc_header(&header, data_length, tag, channel, tcode, sy);
+
+	KUNIT_EXPECT_EQ(test, header, expected);
+}
 
 static struct kunit_case packet_serdes_test_cases[] = {
 	KUNIT_CASE(test_async_header_write_quadlet_request),
@@ -526,6 +569,7 @@ static struct kunit_case packet_serdes_test_cases[] = {
 	KUNIT_CASE(test_async_header_read_block_response),
 	KUNIT_CASE(test_async_header_lock_request),
 	KUNIT_CASE(test_async_header_lock_response),
+	KUNIT_CASE(test_isoc_header),
 	{}
 };
 
-- 
2.43.0


