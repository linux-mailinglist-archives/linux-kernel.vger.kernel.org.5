Return-Path: <linux-kernel+bounces-149795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B48E8A95F2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77D071C21387
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A95015CD77;
	Thu, 18 Apr 2024 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="cIQuXqn5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gvqfvSpP"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3799215B571
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432199; cv=none; b=fkNLFOkW5fH7Seu/HWWbFs+kGcuvkSuwyfI2hJA1Wasa/ie1jp5KMo5kgKfQ35S9vcHEAAl+OYLYbB0JDQ2FPbsIrVMA9MmJXFaakSiCE9gtkXtToAwNM2dMPLll/1SVxRVBszecYYjF6ABFVhdwEKKXa7KfPvFCfeuc4bR5sPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432199; c=relaxed/simple;
	bh=3LZ2rckMN5vRD3KByODttuDnXLjALQHZtYdntvxbJI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjaWlMvI5sB6vMuQaMC9sSqNU58rig3CpJioNrq69JMQWy/k04NzIZ2NkFxBBWSA+3EtIXUe5e4ZbIg9w13SgkjIYihPMmHZ1a0LYxZPx7tzQArlL0TKII3zkXBRRBDcdH7sIsMl1k/hwT70JYK+X/HtY6+L4DjIfRNatbzcUKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=cIQuXqn5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gvqfvSpP; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 55FBA13800CB;
	Thu, 18 Apr 2024 05:23:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 18 Apr 2024 05:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1713432197; x=
	1713518597; bh=/e7fuxX/vtKPR4pmRS6j0FIOy9tSq6SszBVnEsJ8ruY=; b=c
	IQuXqn5RTTU50peMfUul5nyiZEtfKOYIiEPCRpKHFIRdW3kYl0rQUEqz/6dNoQ9D
	zuph4b23SO/zal1EIbUDrYfIJgBcWO1KZLnpo+NB34lVnPh4x01tdAgeqPllj8x5
	OPD6XcWuyH0rZIb7isCdFaXY5puzNv500Gq3w18D+JtiAfADV/n+3R9E0uwuNN/y
	MN8g95z/9TsILosGkLqiHhpuB04DGlYehqwHvb1eM0BTfB6OgwLV1I664H5jdKXv
	q77cF8lTRpt6CB7mdaESM/x857NQII5wOr4fXmscE/CCWknGjnbOsncoEA1xIOTR
	5/AEyqeIYZ/jllg93W9UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713432197; x=
	1713518597; bh=/e7fuxX/vtKPR4pmRS6j0FIOy9tSq6SszBVnEsJ8ruY=; b=g
	vqfvSpPRQVUjS6jsarxmFp/6Sn5uxv6PzN/+k0gIZ9NHfkoUS6IjZfIXl1/mq24o
	gqhnuqwGJgIlBDrWmE3RGmvbdz10uUA+H6+C7jCe5288TMcpGoMrGfHRrfxhBDZD
	Yftcb1r/f155RbO4jdgj5NeIDmLy8ZuHEvP0OlZg4davw5VDlQp6PMIx20da4QmO
	02vN+DrAAgdD7BbDE0U+mSfSKHtSqb/yGxwsrEzngCRYsy1ozILxqBkwAyA+y/SX
	HuW6fv290TW5dBBI2ltwKIN5RqHpjcCJ/3rx+nVI/NwZntxnldxt4bNffu5DWGxM
	1fwYGbvBeI3rKH30Tdrdw==
X-ME-Sender: <xms:heYgZqQkB-p_wPAqU4UE_kQNa2A5WiaClp-2oFD2V0GlKm6E4ewEJA>
    <xme:heYgZvwNHFcUE_Ct6SuLlgUQHI4IrJUu8dFn3TYiIHPGDO9MCWnpzw1fBLCdNpwot
    nHXuWW284Z_T8oKxhA>
X-ME-Received: <xmr:heYgZn20Mq8E3IrqNnfL27JCmYDDzb7GEQjHTAlHSn0IXNvvW1vLudrBjTQ6cCoeSWi2j9L8jaXxtEjFlpeZ1icA7SCFw7MkTirwJs03vP93aw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudektddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:heYgZmCT3jR36QjS1PCvyFfi5bV3B6h4NpHrUl3e7-cRyI80HJeb-w>
    <xmx:heYgZjjE8NM5NoEuL6Tn39kucOKCYO829JjOH1JMrqi1ndG6gT2YzA>
    <xmx:heYgZip4VIJpz6DRo6izCis3h43JpF7pPljd8f_rnxerMef6anA2Mg>
    <xmx:heYgZmh3QgcLIXvE5Cz33g6X2QZPMQJHyAa-AJepLvKhe0xWjTtckw>
    <xmx:heYgZmsgy7y-npDn7NHb6E4y6m-1FxyxYzSFumFuH4Dns6se6XRDJxEq>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Apr 2024 05:23:16 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 07/13] firewire: core: add common macro to serialize/deserialize isochronous packet header
Date: Thu, 18 Apr 2024 18:22:57 +0900
Message-ID: <20240418092303.19725-8-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418092303.19725-7-o-takashi@sakamocchi.jp>
References: <20240418092303.19725-1-o-takashi@sakamocchi.jp>
 <20240418092303.19725-2-o-takashi@sakamocchi.jp>
 <20240418092303.19725-3-o-takashi@sakamocchi.jp>
 <20240418092303.19725-4-o-takashi@sakamocchi.jp>
 <20240418092303.19725-5-o-takashi@sakamocchi.jp>
 <20240418092303.19725-6-o-takashi@sakamocchi.jp>
 <20240418092303.19725-7-o-takashi@sakamocchi.jp>
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


