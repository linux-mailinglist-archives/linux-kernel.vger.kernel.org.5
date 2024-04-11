Return-Path: <linux-kernel+bounces-140320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6439D8A12C0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877221C21487
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039251482EF;
	Thu, 11 Apr 2024 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Cr0bOjjL"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201EF1474BE;
	Thu, 11 Apr 2024 11:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712834052; cv=none; b=RVgrDce/QKZZPTnr4Igs88hyNYSJYhGpKh0cFBJa2wjum97w2LCDGg/JgJrzokhlQtkr8UJNS0eGO9yz2rKF7TDZ8l0+Ixc24VkAG3AqRN+jhAQhtSrNNNhWqmfFZkkKNzqYf13BU3c/w7ZDsJZLs1mK36WReMy2JUgelWTrSgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712834052; c=relaxed/simple;
	bh=qvx2mawf3ghJ8pkjK1npUg1bbbAJVNMh44XNGAu8YZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rOxWsa70K/LoqNeeM6QXx1BdGyzO8/udTRp5e19vhs3q7Bg8nXFzcXuZRojLHFAaGCmzUj8HrzjQpBugUyxII/cZ5LHCK8PTHbW31JJWxVum9kxPj1RD0WPESLcAftzql9XbMl4sDziJxT2xZbtznN6Ov78H1X7+TDSaVYvfQuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Cr0bOjjL; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id C07B2600A2;
	Thu, 11 Apr 2024 11:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1712834046;
	bh=qvx2mawf3ghJ8pkjK1npUg1bbbAJVNMh44XNGAu8YZI=;
	h=From:To:Cc:Subject:Date:From;
	b=Cr0bOjjLP+KfhIaEIypx14rlYVzFCgJtk9YqryPHuda93iiRSfr3v6AZfeJK3gDR3
	 mBX37xSWAqP/unG7GpPpzRybd2E/TAC/V0pyE+3aHegl1X0qwxWIAoB6pPcBogg7fu
	 q3kCnBlh1q8BlEaSb4NQVHx8Kt2WyUbhkaGOyyn+G8lhy6kPp2+j7it7GAtXa6yKCL
	 xMpK+K2LyAmaqKDM0imMAdtiw+K08B8aJ41e7YIz6fWIFqOhZ3igGFyM5ERi6xCdiC
	 B2r1TvWlxwLojpcJbQIiLVI6ksI3x7N4DcN4J8mMeAdqqbosDvtwrw8TExucpjNMB8
	 +CLpj7aVemw1Q==
Received: by x201s (Postfix, from userid 1000)
	id 447E120106A; Thu, 11 Apr 2024 11:14:02 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net v3] net: sparx5: flower: fix fragment flags handling
Date: Thu, 11 Apr 2024 11:13:18 +0000
Message-ID: <20240411111321.114095-1-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I noticed that only 3 out of the 4 input bits were used,
mt.key->flags & FLOW_DIS_IS_FRAGMENT was never checked.

In order to avoid a complicated maze, I converted it to
use a 16 byte mapping table.

As shown in the table below the old heuristics doesn't
always do the right thing, ie. when FLOW_DIS_IS_FRAGMENT=1/1
then it used to only match follow-up fragment packets.

Here are all the combinations, and their resulting new/old
VCAP key/mask filter:

  /- FLOW_DIS_IS_FRAGMENT (key/mask)
  |    /- FLOW_DIS_FIRST_FRAG (key/mask)
  |    |    /-- new VCAP fragment (key/mask)
  v    v    v    v- old VCAP fragment (key/mask)

 0/0  0/0  -/-  -/-     impossible (due to entry cond. on mask)
 0/0  0/1  -/-  0/3 !!  invalid (can't match non-fragment + follow-up frag)
 0/0  1/0  -/-  -/-     impossible (key > mask)
 0/0  1/1  1/3  1/3     first fragment

 0/1  0/0  0/3  3/3 !!  not fragmented
 0/1  0/1  0/3  3/3 !!  not fragmented (+ not first fragment)
 0/1  1/0  -/-  -/-     impossible (key > mask)
 0/1  1/1  -/-  1/3 !!  invalid (non-fragment and first frag)

 1/0  0/0  -/-  -/-     impossible (key > mask)
 1/0  0/1  -/-  -/-     impossible (key > mask)
 1/0  1/0  -/-  -/-     impossible (key > mask)
 1/0  1/1  -/-  -/-     impossible (key > mask)

 1/1  0/0  1/1  3/3 !!  some fragment
 1/1  0/1  3/3  3/3     follow-up fragment
 1/1  1/0  -/-  -/-     impossible (key > mask)
 1/1  1/1  1/3  1/3     first fragment

In the datasheet the VCAP fragment values are documented as:
 0 = no fragment
 1 = initial fragment
 2 = suspicious fragment
 3 = valid follow-up fragment

Result: 3 combinations match the old behavior,
        3 combinations have been corrected,
        2 combinations are now invalid, and fail,
        8 combinations are impossible.

It should now be aligned with how FLOW_DIS_IS_FRAGMENT
and FLOW_DIS_FIRST_FRAG is set in __skb_flow_dissect() in
net/core/flow_dissector.c

Since the VCAP fragment values are not a bitfield, we have
to ignore the suspicious fragment value, eg. when matching
on any kind of fragment with FLOW_DIS_IS_FRAGMENT=1/1.

Only compile tested, and logic tested in userspace, as I
unfortunately don't have access to this switch chip (yet).

Fixes: d6c2964db3fe ("net: microchip: sparx5: Adding more tc flower keys for the IS2 VCAP")
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Tested-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---

Changelog:

v3:
- Added Reviewed-by from Jacob Keller.
- Start NL msg and comments with uppercase (requested by Daniel)

v2: https://lore.kernel.org/netdev/20240410095224.6372-1-ast@fiberby.net/
- Improved in-line documentation of mapping table (requested by Steen)
- Relocated enum and mapping table (requested by Steen)
- Added Reviewed-by from Steen Hegelund
- Added Tested-by from Daniel Machon

v1: https://lore.kernel.org/netdev/20240408172738.96447-1-ast@fiberby.net/

 .../microchip/sparx5/sparx5_tc_flower.c       | 61 ++++++++++++-------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
index 523e0c470894f..55f255a3c9db6 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
@@ -36,6 +36,27 @@ struct sparx5_tc_flower_template {
 	u16 l3_proto; /* protocol specified in the template */
 };
 
+/* SparX-5 VCAP fragment types:
+ * 0 = no fragment, 1 = initial fragment,
+ * 2 = suspicious fragment, 3 = valid follow-up fragment
+ */
+enum {                   /* key / mask */
+	FRAG_NOT   = 0x03, /* 0 / 3 */
+	FRAG_SOME  = 0x11, /* 1 / 1 */
+	FRAG_FIRST = 0x13, /* 1 / 3 */
+	FRAG_LATER = 0x33, /* 3 / 3 */
+	FRAG_INVAL = 0xff, /* invalid */
+};
+
+/* Flower fragment flag to VCAP fragment type mapping */
+static const u8 sparx5_vcap_frag_map[4][4] = {		  /* is_frag */
+	{ FRAG_INVAL, FRAG_INVAL, FRAG_INVAL, FRAG_FIRST }, /* 0/0 */
+	{ FRAG_NOT,   FRAG_NOT,   FRAG_INVAL, FRAG_INVAL }, /* 0/1 */
+	{ FRAG_INVAL, FRAG_INVAL, FRAG_INVAL, FRAG_INVAL }, /* 1/0 */
+	{ FRAG_SOME,  FRAG_LATER, FRAG_INVAL, FRAG_FIRST }  /* 1/1 */
+	/* 0/0	      0/1	  1/0	      1/1 <-- first_frag */
+};
+
 static int
 sparx5_tc_flower_es0_tpid(struct vcap_tc_flower_parse_usage *st)
 {
@@ -145,29 +166,27 @@ sparx5_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
 	flow_rule_match_control(st->frule, &mt);
 
 	if (mt.mask->flags) {
-		if (mt.mask->flags & FLOW_DIS_FIRST_FRAG) {
-			if (mt.key->flags & FLOW_DIS_FIRST_FRAG) {
-				value = 1; /* initial fragment */
-				mask = 0x3;
-			} else {
-				if (mt.mask->flags & FLOW_DIS_IS_FRAGMENT) {
-					value = 3; /* follow up fragment */
-					mask = 0x3;
-				} else {
-					value = 0; /* no fragment */
-					mask = 0x3;
-				}
-			}
-		} else {
-			if (mt.mask->flags & FLOW_DIS_IS_FRAGMENT) {
-				value = 3; /* follow up fragment */
-				mask = 0x3;
-			} else {
-				value = 0; /* no fragment */
-				mask = 0x3;
-			}
+		u8 is_frag_key = !!(mt.key->flags & FLOW_DIS_IS_FRAGMENT);
+		u8 is_frag_mask = !!(mt.mask->flags & FLOW_DIS_IS_FRAGMENT);
+		u8 is_frag_idx = (is_frag_key << 1) | is_frag_mask;
+
+		u8 first_frag_key = !!(mt.key->flags & FLOW_DIS_FIRST_FRAG);
+		u8 first_frag_mask = !!(mt.mask->flags & FLOW_DIS_FIRST_FRAG);
+		u8 first_frag_idx = (first_frag_key << 1) | first_frag_mask;
+
+		/* Lookup verdict based on the 2 + 2 input bits */
+		u8 vdt = sparx5_vcap_frag_map[is_frag_idx][first_frag_idx];
+
+		if (vdt == FRAG_INVAL) {
+			NL_SET_ERR_MSG_MOD(st->fco->common.extack,
+					   "Match on invalid fragment flag combination");
+			return -EINVAL;
 		}
 
+		/* Extract VCAP fragment key and mask from verdict */
+		value = (vdt >> 4) & 0x3;
+		mask = vdt & 0x3;
+
 		err = vcap_rule_add_key_u32(st->vrule,
 					    VCAP_KF_L3_FRAGMENT_TYPE,
 					    value, mask);
-- 
2.43.0


