Return-Path: <linux-kernel+bounces-115259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF0F88900E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5184B35B5E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F1D316EB8;
	Mon, 25 Mar 2024 01:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRahk9yG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9089822F510;
	Sun, 24 Mar 2024 23:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324376; cv=none; b=Bvd7tWXlFcAm7fkOD0RBNj4j7/Ddgr74fhpbTtg5HjRrLSuzLMqyieOJQlEZQ7jY0cGs9WZ5tKOgG8mEwizaCGkBYXhNkTWzf9+TzyzfuHJcIkB+YHEtbVRAWyqnLxmF2OOEcNaP+riEy3PfUEhTQtoJl3nVRsyP1x0skjh5FDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324376; c=relaxed/simple;
	bh=tCYwIpLCrAOSE6XXUPJqeVGUo8QLA62vXiD5B6NkFHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7jKxCb5UFjnk/b8e4EHnEn7Ml0CyBsP8+pyHM+0FeIyXTWMhLOrnTlLWY87xDlD+hjncPXjqQIQOs3wD4ZynY2Or0MNS34WAIv0Cemi7jgxjTJew8xmsI4ncY9LNqBvY4vl7P9U3/TWD7Cx5ZD4U5qQXH1A3jLh95/ZdOT6HQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRahk9yG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEAB8C433C7;
	Sun, 24 Mar 2024 23:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324376;
	bh=tCYwIpLCrAOSE6XXUPJqeVGUo8QLA62vXiD5B6NkFHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BRahk9yG5soAKJUdIV8iKjBMgnNJz02zUHfjob7dnqTgAKIEwBM5qQ5r3ssUUm2wp
	 2dWJa5IZrl69YQwEyCNJK2XhId+i8odp7rre9uT7OR03FRpbbXlMxFZuW+SsCeu9rj
	 ijWhX0n3ayGn4APAU/WF4JlPc6lI3P0Ffn49/2RPAfE0/meCl1sh0a0TpGbtF7V6FP
	 e/hoFvqO8W+eXJzfNBxzv6ORv0kKHVQGRdyxqfqzYq2kjytaWsR7ABm/WjFRzSZWwa
	 6C0qMyTWGEtb+BBKab2OdllyvP4kGqRyWQjmAhOi/SfqNNsByUaquStyn8X2cFS0i4
	 OH+esdxTOYpZg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Murali Karicheri <m-karicheri2@ti.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 142/148] net: hsr: fix placement of logical operator in a multi-line statement
Date: Sun, 24 Mar 2024 19:50:06 -0400
Message-ID: <20240324235012.1356413-143-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Murali Karicheri <m-karicheri2@ti.com>

[ Upstream commit 059477830022e1886f55a9641702461c249fa864 ]

In a multi-line statement exceeding 80 characters, logical operator
should be at the end of a line instead of being at the start. This
is seen when ran checkpatch.pl -f on files under net/hsr. The change
is per suggestion from checkpatch.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: ddbec99f5857 ("hsr: Fix uninit-value access in hsr_get_node()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/hsr/hsr_forward.c  | 8 ++++----
 net/hsr/hsr_framereg.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index adfb497606785..886fad5922b3c 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -63,8 +63,8 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
 		return false;
 
 	/* Correct ether type?. */
-	if (!(ethHdr->h_proto == htons(ETH_P_PRP)
-			|| ethHdr->h_proto == htons(ETH_P_HSR)))
+	if (!(ethHdr->h_proto == htons(ETH_P_PRP) ||
+	      ethHdr->h_proto == htons(ETH_P_HSR)))
 		return false;
 
 	/* Get the supervision header from correct location. */
@@ -336,8 +336,8 @@ static int hsr_fill_frame_info(struct hsr_frame_info *frame,
 		/* FIXME: */
 		WARN_ONCE(1, "HSR: VLAN not yet supported");
 	}
-	if (ethhdr->h_proto == htons(ETH_P_PRP)
-			|| ethhdr->h_proto == htons(ETH_P_HSR)) {
+	if (ethhdr->h_proto == htons(ETH_P_PRP) ||
+	    ethhdr->h_proto == htons(ETH_P_HSR)) {
 		frame->skb_std = NULL;
 		frame->skb_hsr = skb;
 		frame->sequence_nr = hsr_get_skb_sequence_nr(skb);
diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 37795502bb511..9c5a423f0f7a3 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -192,8 +192,8 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct sk_buff *skb,
 
 	/* Everyone may create a node entry, connected node to a HSR device. */
 
-	if (ethhdr->h_proto == htons(ETH_P_PRP)
-			|| ethhdr->h_proto == htons(ETH_P_HSR)) {
+	if (ethhdr->h_proto == htons(ETH_P_PRP) ||
+	    ethhdr->h_proto == htons(ETH_P_HSR)) {
 		/* Use the existing sequence_nr from the tag as starting point
 		 * for filtering duplicate frames.
 		 */
-- 
2.43.0


