Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223527B732E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241182AbjJCVRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241162AbjJCVRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:17:13 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F94AF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:17:10 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso254344966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 14:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696367829; x=1696972629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Br3Tu4ye6QhbdVWpW+TWoiV1JRezZ/yxalXAAhE32SU=;
        b=gX7VvnnmY1++/s3aBpi+JPyEO83TPBFe9VtpFGpCy+fIPagTjJ2izWjZuQtougmiOF
         sy2Hp76zuw/PIsXBAf5MDLV13xqRmbJsx+2fqYhzlmiYziH7bPBQ0OvCjNONFKqi3dEx
         93gAj4MTow0pecoRjs+iXYq5Lxx7+McEfsRcYaKFTLvamgSETyXgt8UNW7bgvjzeEcnD
         Vw8l7b6QdM1rg2gAmXci6b1DJSWAZMrM7OP6mskCPOCAklWPONXpn5Vans4aAosE0mGY
         sxh52DAc3wdo5K1CRzt7OD0eqzf/N6+6iwsV89e4r6+zEbjpD85fguzTGIpUtPmVnAEA
         lCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696367829; x=1696972629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Br3Tu4ye6QhbdVWpW+TWoiV1JRezZ/yxalXAAhE32SU=;
        b=CUPg3/QIlJdE85o6cb0L0s8TcKg+WuX77xEGiLARPfThCB2U75K5Ru54qpiyU0ICc/
         OUD+mFwLrfYhOPllXct3z4R5mpJoD174ELMn0Sc4SsHIJ6pG7laLyOYioiCVeT3aEqTo
         OhEN0ooVUs4ZkIMwQI5ustOpUL9veyYZSyBn/+A8m1FppNiE/CURDFreI/TaYX+ZNazy
         nKl5zSm6adOcIckWqy6o8H6dCRwh6ayjO1wG64oi1rJ3GOcn3EpqiGNN9Mb+IaQ8m06Q
         cNn66cKf70dZUcL38cQti/14ut52dee84tmWhWFSDxLWbx+ew3jHqguDu1qZVboOAWpN
         gUpA==
X-Gm-Message-State: AOJu0Yzqcy6TPYtDzxYQa+cm59o88UaWeCdL6wXJ5FKxgcvD4fF41oQi
        mMgK6JuRumtlIuAiDLyOxh4=
X-Google-Smtp-Source: AGHT+IG9Q3xayqtxGLlGUspRr9k+tWNbr2WagJQuOYWopa1UahAN6CvKd0+xwOOrmHXCbygfKU2eFA==
X-Received: by 2002:a17:907:78c4:b0:9a5:d16b:6631 with SMTP id kv4-20020a17090778c400b009a5d16b6631mr383058ejc.70.1696367828629;
        Tue, 03 Oct 2023 14:17:08 -0700 (PDT)
Received: from datamate.fritz.box (dynamic-077-190-158-124.77.190.pool.telefonica.de. [77.190.158.124])
        by smtp.gmail.com with ESMTPSA id jx14-20020a170906ca4e00b0098951bb4dc3sm1614108ejb.184.2023.10.03.14.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 14:17:08 -0700 (PDT)
From:   Kai Bosch <kellerassel@gmail.com>
X-Google-Original-From: Kai Bosch <kbosch@protonmail.com>
To:     o-takashi@sakamocchi.jp
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kai Bosch <kbosch@protonmail.com>
Subject: [PATCH] Firewire: IP over IEEE 1394: replaced implicit mentions of unsigned int
Date:   Tue,  3 Oct 2023 21:16:50 +0000
Message-Id: <20231003211650.349521-1-kbosch@protonmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/firewire/net.c | 48 +++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/firewire/net.c b/drivers/firewire/net.c
index 7a4d1a478e33..1fbf62ef793c 100644
--- a/drivers/firewire/net.c
+++ b/drivers/firewire/net.c
@@ -86,14 +86,14 @@ struct rfc2734_header {
 #define fwnet_set_hdr_dgl(dgl)		((dgl) << 16)
 
 static inline void fwnet_make_uf_hdr(struct rfc2734_header *hdr,
-		unsigned ether_type)
+		unsigned int ether_type)
 {
 	hdr->w0 = fwnet_set_hdr_lf(RFC2374_HDR_UNFRAG)
 		  | fwnet_set_hdr_ether_type(ether_type);
 }
 
 static inline void fwnet_make_ff_hdr(struct rfc2734_header *hdr,
-		unsigned ether_type, unsigned dg_size, unsigned dgl)
+		unsigned int ether_type, unsigned int dg_size, unsigned int dgl)
 {
 	hdr->w0 = fwnet_set_hdr_lf(RFC2374_HDR_FIRSTFRAG)
 		  | fwnet_set_hdr_dg_size(dg_size)
@@ -102,7 +102,7 @@ static inline void fwnet_make_ff_hdr(struct rfc2734_header *hdr,
 }
 
 static inline void fwnet_make_sf_hdr(struct rfc2734_header *hdr,
-		unsigned lf, unsigned dg_size, unsigned fg_off, unsigned dgl)
+		unsigned int lf, unsigned int dg_size, unsigned int fg_off, unsigned int dgl)
 {
 	hdr->w0 = fwnet_set_hdr_lf(lf)
 		  | fwnet_set_hdr_dg_size(dg_size)
@@ -142,15 +142,15 @@ struct fwnet_device {
 	struct fw_iso_context *broadcast_rcv_context;
 	struct fw_iso_buffer broadcast_rcv_buffer;
 	void **broadcast_rcv_buffer_ptrs;
-	unsigned broadcast_rcv_next_ptr;
-	unsigned num_broadcast_rcv_ptrs;
-	unsigned rcv_buffer_size;
+	unsigned int broadcast_rcv_next_ptr;
+	unsigned int num_broadcast_rcv_ptrs;
+	unsigned int rcv_buffer_size;
 	/*
 	 * This value is the maximum unfragmented datagram size that can be
 	 * sent by the hardware.  It already has the GASP overhead and the
 	 * unfragmented datagram header overhead calculated into it.
 	 */
-	unsigned broadcast_xmt_max_payload;
+	unsigned int broadcast_xmt_max_payload;
 	u16 broadcast_xmt_datagramlabel;
 
 	/*
@@ -176,13 +176,13 @@ struct fwnet_peer {
 
 	/* guarded by dev->lock */
 	struct list_head pd_list; /* received partial datagrams */
-	unsigned pdg_size;        /* pd_list size */
+	unsigned int pdg_size;        /* pd_list size */
 
 	u16 datagram_label;       /* outgoing datagram label */
 	u16 max_payload;          /* includes RFC2374_FRAG_HDR_SIZE overhead */
 	int node_id;
 	int generation;
-	unsigned speed;
+	unsigned int speed;
 };
 
 /* This is our task struct. It's used for the packet complete callback.  */
@@ -207,7 +207,7 @@ struct fwnet_packet_task {
  */
 static int fwnet_header_create(struct sk_buff *skb, struct net_device *net,
 			unsigned short type, const void *daddr,
-			const void *saddr, unsigned len)
+			const void *saddr, unsigned int len)
 {
 	struct fwnet_header *h;
 
@@ -273,10 +273,10 @@ static const struct header_ops fwnet_header_ops = {
 
 /* FIXME: is this correct for all cases? */
 static bool fwnet_frag_overlap(struct fwnet_partial_datagram *pd,
-			       unsigned offset, unsigned len)
+			       unsigned int offset, unsigned int len)
 {
 	struct fwnet_fragment_info *fi;
-	unsigned end = offset + len;
+	unsigned int end = offset + len;
 
 	list_for_each_entry(fi, &pd->fi_list, fi_link)
 		if (offset < fi->offset + fi->len && end > fi->offset)
@@ -287,7 +287,7 @@ static bool fwnet_frag_overlap(struct fwnet_partial_datagram *pd,
 
 /* Assumes that new fragment does not overlap any existing fragments */
 static struct fwnet_fragment_info *fwnet_frag_new(
-	struct fwnet_partial_datagram *pd, unsigned offset, unsigned len)
+	struct fwnet_partial_datagram *pd, unsigned int offset, unsigned int len)
 {
 	struct fwnet_fragment_info *fi, *fi2, *new;
 	struct list_head *list;
@@ -350,8 +350,8 @@ static struct fwnet_fragment_info *fwnet_frag_new(
 }
 
 static struct fwnet_partial_datagram *fwnet_pd_new(struct net_device *net,
-		struct fwnet_peer *peer, u16 datagram_label, unsigned dg_size,
-		void *frag_buf, unsigned frag_off, unsigned frag_len)
+		struct fwnet_peer *peer, u16 datagram_label, unsigned int dg_size,
+		void *frag_buf, unsigned int frag_off, unsigned int frag_len)
 {
 	struct fwnet_partial_datagram *new;
 	struct fwnet_fragment_info *fi;
@@ -413,7 +413,7 @@ static void fwnet_pd_delete(struct fwnet_partial_datagram *old)
 
 static bool fwnet_pd_update(struct fwnet_peer *peer,
 		struct fwnet_partial_datagram *pd, void *frag_buf,
-		unsigned frag_off, unsigned frag_len)
+		unsigned int frag_off, unsigned int frag_len)
 {
 	if (fwnet_frag_new(pd, frag_off, frag_len) == NULL)
 		return false;
@@ -466,7 +466,7 @@ static struct fwnet_peer *fwnet_peer_find_by_node_id(struct fwnet_device *dev,
 }
 
 /* See IEEE 1394-2008 table 6-4, table 8-8, table 16-18. */
-static unsigned fwnet_max_payload(unsigned max_rec, unsigned speed)
+static unsigned int fwnet_max_payload(unsigned int max_rec, unsigned int speed)
 {
 	max_rec = min(max_rec, speed + 8);
 	max_rec = clamp(max_rec, 8U, 11U); /* 512...4096 */
@@ -562,7 +562,7 @@ static int fwnet_incoming_packet(struct fwnet_device *dev, __be32 *buf, int len,
 	struct sk_buff *skb;
 	struct net_device *net = dev->netdev;
 	struct rfc2734_header hdr;
-	unsigned lf;
+	unsigned int lf;
 	unsigned long flags;
 	struct fwnet_peer *peer;
 	struct fwnet_partial_datagram *pd;
@@ -1075,7 +1075,7 @@ static int fwnet_fifo_start(struct fwnet_device *dev)
 
 static void __fwnet_broadcast_stop(struct fwnet_device *dev)
 {
-	unsigned u;
+	unsigned int u;
 
 	if (dev->broadcast_state != FWNET_BROADCAST_ERROR) {
 		for (u = 0; u < FWNET_ISO_PAGE_COUNT; u++)
@@ -1103,12 +1103,12 @@ static int fwnet_broadcast_start(struct fwnet_device *dev)
 {
 	struct fw_iso_context *context;
 	int retval;
-	unsigned num_packets;
-	unsigned max_receive;
+	unsigned int num_packets;
+	unsigned int max_receive;
 	struct fw_iso_packet packet;
 	unsigned long offset;
 	void **ptrptr;
-	unsigned u;
+	unsigned int u;
 
 	if (dev->broadcast_state != FWNET_BROADCAST_ERROR)
 		return 0;
@@ -1141,7 +1141,7 @@ static int fwnet_broadcast_start(struct fwnet_device *dev)
 
 	for (u = 0; u < FWNET_ISO_PAGE_COUNT; u++) {
 		void *ptr;
-		unsigned v;
+		unsigned int v;
 
 		ptr = kmap(dev->broadcast_rcv_buffer.pages[u]);
 		for (v = 0; v < num_packets / FWNET_ISO_PAGE_COUNT; v++)
@@ -1229,7 +1229,7 @@ static netdev_tx_t fwnet_tx(struct sk_buff *skb, struct net_device *net)
 	struct fwnet_device *dev = netdev_priv(net);
 	__be16 proto;
 	u16 dest_node;
-	unsigned max_payload;
+	unsigned int max_payload;
 	u16 dg_size;
 	u16 *datagram_label_ptr;
 	struct fwnet_packet_task *ptask;
-- 
2.34.1

