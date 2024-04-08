Return-Path: <linux-kernel+bounces-135752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 393F689CACB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7181C21C61
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5724A143C65;
	Mon,  8 Apr 2024 17:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="sA/UQbNT"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A587A143880;
	Mon,  8 Apr 2024 17:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712597288; cv=none; b=ehDdiLMCi70DE5t+2usR4ofPBEn9nA13bgE/EC0EK4uGdU6XV3bGYBjd5sSOYfOuJ/SnCeWM4abxysbJ8yJ8/6BgIsZeY8ehWHgQUsK/gc+QQ18/bOVWgxrjPiDonlSU9dRkwrH6wOFytrtSxOdciJIhaUh7o2T5t2AXvkpFKO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712597288; c=relaxed/simple;
	bh=plYws3az66yYzUB9kegD6f/52t70PzV1zIDHcCsIMqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T//fpqNGJAQzyxy5Zt+03PCxjDh26M2y0V+fzjCIWt/MtSI27cdjlNNmjWpE0G8HQUwFhP13fLwLPzG6EyocjfBsIpK8fxz2fep9ttQJ6fuWak4s3VUSHg0TuUX8XE4r/Yz8U0E7maNp4b0L9BZYBwXAlaGe7EpPh0wTxc+BD10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=sA/UQbNT; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 0CAB1600A2;
	Mon,  8 Apr 2024 17:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1712597282;
	bh=plYws3az66yYzUB9kegD6f/52t70PzV1zIDHcCsIMqY=;
	h=From:To:Cc:Subject:Date:From;
	b=sA/UQbNT4EI9oEo2CYem4mTORREN/kAXnH2EGdlfwUMc7gox03AYTTpK2O1C6VGYJ
	 t2/AeX2TT1F1AgOxF6reGtZcUDdHmsJlwx1MrEo5cxvUXS2E4eH5jkP0TqccLzFfpg
	 yR8NrKtxYpCnPgn4ctHYWbVqAphTCDGpJrdXagjRWKe+oO2GKBjLj6QpBBXvCZxy95
	 AltTL3NG8MYaHwZmokak1pskwl//ZZckBwJr8wIU5yedHGYZmqN5tG+T7ldOQ/iCYh
	 qIYAuqzdIoBgOVgoLwc35f5LxrCIzj8WuzE05jp7xB4Eqs86ROuk7V5CMOkBeUXcN5
	 q5rIi+vk3teRQ==
Received: by x201s (Postfix, from userid 1000)
	id ED11A201CE7; Mon, 08 Apr 2024 17:27:47 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: Steen Hegelund <Steen.Hegelund@microchip.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: sparx5: flower: fix fragment flags handling
Date: Mon,  8 Apr 2024 17:27:35 +0000
Message-ID: <20240408172738.96447-1-ast@fiberby.net>
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
---
 .../microchip/sparx5/sparx5_tc_flower.c       | 60 ++++++++++++-------
 1 file changed, 39 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
index 523e0c470894f..2f87ccb8cf8c8 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
@@ -135,6 +135,26 @@ sparx5_tc_flower_handler_basic_usage(struct vcap_tc_flower_parse_usage *st)
 	return err;
 }
 
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
+static const u8 sparx5_vcap_frag_map[4][4] = {
+	{ FRAG_INVAL, FRAG_INVAL, FRAG_INVAL, FRAG_FIRST },
+	{ FRAG_NOT,   FRAG_NOT,   FRAG_INVAL, FRAG_INVAL },
+	{ FRAG_INVAL, FRAG_INVAL, FRAG_INVAL, FRAG_INVAL },
+	{ FRAG_SOME,  FRAG_LATER, FRAG_INVAL, FRAG_FIRST }
+};
+
 static int
 sparx5_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
 {
@@ -145,29 +165,27 @@ sparx5_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
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
+		/* lookup verdict based on the 2 + 2 input bits */
+		u8 vdt = sparx5_vcap_frag_map[is_frag_idx][first_frag_idx];
+
+		if (vdt == FRAG_INVAL) {
+			NL_SET_ERR_MSG_MOD(st->fco->common.extack,
+					   "match on invalid fragment flag combination");
+			return -EINVAL;
 		}
 
+		/* extract VCAP fragment key and mask from verdict */
+		value = (vdt >> 4) & 0x3;
+		mask = vdt & 0x3;
+
 		err = vcap_rule_add_key_u32(st->vrule,
 					    VCAP_KF_L3_FRAGMENT_TYPE,
 					    value, mask);
-- 
2.43.0


