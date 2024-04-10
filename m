Return-Path: <linux-kernel+bounces-138283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 288CF89EF39
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CD911C20F7F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C017157E98;
	Wed, 10 Apr 2024 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="eI0+fOVg"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9690C125CD;
	Wed, 10 Apr 2024 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712742765; cv=none; b=F41aGtnBoNNs8/MwMw9Jw7nvo25myuy9A9EQ/QK/gFopeQ6HN9Giouuyl8QzpCMCE+gnaieVYfbN3GQ6fcJHCiEZB5/eJYBgCZ59RteoJsNXVuAffrbHJ4ZmLYwU9xJwPQszCQsR07GioXu5vOrSAMJX9/6WeYm6bOpSYT8oG2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712742765; c=relaxed/simple;
	bh=A4SQWAoLTl1trJBjvVe+szcFLe+EAdNIB9cPeBqzuDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N0BpGlzZgOclQ1iwbJxoURzf1mao4x6FLURtENQjiurcza8E6EkzNF5SektU2qFWG5zWrYOpKWq5iCiOfrGbYj+T8plETQM1dxj/6woykSWmZw9U5SG3EU0IbDo0anTdJm1Z3xiJ1o10h3PJFWDGM5B8T2pDEA6/zlJaj1d5ePU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=eI0+fOVg; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 73943600A2;
	Wed, 10 Apr 2024 09:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1712742759;
	bh=A4SQWAoLTl1trJBjvVe+szcFLe+EAdNIB9cPeBqzuDg=;
	h=From:To:Cc:Subject:Date:From;
	b=eI0+fOVggcZc7WNQ/m1KCUdUH7wDPdHE1nD+kVl0KFnmjjE1LqJu62Xs4yCV4pTAf
	 Ktnn5KdaxmdtwIABs0VRdvn3DLMlWRmw2JUvXErX8QRxVw8DFGwpNS3jn9YEHCWYqP
	 XFJDD+ql//6KIeIuLWaeeso92NXpxHebXuEgAz//Q5v9ha/6+beKebk+aFw+RR1Ak+
	 qzJBLrl2jkSt6juOf3cJprOHbtj6zwBmE9Awia+mWN9BcLoFK1YLsyIiPuPqwVAmbE
	 s40KOtKJQrflr+9qyt6nv7+J7kbLmkvwiDW3V8NR7Iwi0cy2UMqMuxx0p//wugJAk9
	 avsXySNcW876A==
Received: by x201s (Postfix, from userid 1000)
	id A78D5200D78; Wed, 10 Apr 2024 09:52:33 +0000 (UTC)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: sparx5: flower: fix fragment flags handling
Date: Wed, 10 Apr 2024 09:52:19 +0000
Message-ID: <20240410095224.6372-1-ast@fiberby.net>
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

v2:
- Improved in-line documentation of mapping table (requested by Steen)
- Relocated enum and mapping table (requested by Steen)
- Added Reviewed-by from Steen Hegelund
- Added Tested-by from Daniel Machon

v1: https://lore.kernel.org/netdev/20240408172738.96447-1-ast@fiberby.net/

Fixes: d6c2964db3fe ("net: microchip: sparx5: Adding more tc flower keys for the IS2 VCAP")
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Tested-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../microchip/sparx5/sparx5_tc_flower.c       | 61 ++++++++++++-------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
index 523e0c470894f..f986850efdcc7 100644
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


