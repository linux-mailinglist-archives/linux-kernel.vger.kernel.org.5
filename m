Return-Path: <linux-kernel+bounces-119248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD1888C61E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16868306634
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794B113C83E;
	Tue, 26 Mar 2024 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="hlzN8L8M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N3dxK1hb"
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5696913C68E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465239; cv=none; b=FLOlDMlc1esEzOW8OpD6yhFya8h0SogW1+WNisHjqUOWXS71JV+j2HWkoPVQfl8DYgNU4x7KFE1R59I7pTzhvB2bTuNtoBkwxGxrbZBNS7N1tQIPwF7fnB8Sd8a+q3vXWdPlfjO1X5nfutgWk88VojMKKZ5GWDEglaNGspZRqPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465239; c=relaxed/simple;
	bh=+mF00Y1pbQkzbmCwx0NJZ/IOVF1mX9Z85FpFY/ryW3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WTp6mRWWMusnsxiv+6+haSikIdRcCSKtI12sNWGp7cukyRf5YijzfnSpp6algegIKkf2KDREILS1rsSf7N3+M30ar/MxqbNGYu+Kk/07EjPnFEQTkwhDL81DONF3F7Pn5p/L1udM0OxRewih88iSHGlpk6J+IUA/02Ip0ITwBpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=hlzN8L8M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N3dxK1hb; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 552081C0008E;
	Tue, 26 Mar 2024 11:00:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 26 Mar 2024 11:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm2; t=1711465234; x=
	1711551634; bh=K/wy8Tr0L+Nsny9bf7oP+FXiEoeQqvQFzQlzCUqbxGA=; b=h
	lzN8L8MgVeC1huObqTMQm4/JkVu+6/ioqXutkfnME+OCbS8EhTU3hhGAW0AHAD7o
	gEqTUhe68Vfn2iSv+T3/xMxWPMighv7viBL4jKnwD/vAL2n0egzt2s0RscmeuFAR
	UaNprhjpQP96boS6nxC2YaMdizwJ23xBttznLb6QJW2CFTFhWcAUSVwFd36k6xP5
	Sj17Fm2rQO2eGNYhpKThf0dGP1zvR6Oo3e+YbdUCNG62bB9unvJt1nrwcpt3pSVG
	32RtdPHsrmszt31LfTXFv5k0Fog2l3mmkbwcLs8O7D/PsMwJhy0/fpEJz0LsIn+u
	7aR+84OEZ9CP3HJh6Sd7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1711465234; x=1711551634; bh=K
	/wy8Tr0L+Nsny9bf7oP+FXiEoeQqvQFzQlzCUqbxGA=; b=N3dxK1hbhVHxdQTM1
	b80EL1pK16h2vM7WZTFAYX/XNGqHNLxyb0ydQPoZytSRV31Hp8b4Ci7YiuwdShUM
	Pp80f93T+j3TVSviYsV6qWU8PrNGfyU2wLxh4E8Co2gKdOu8o2LbR5blmfHuF4qS
	RCZR0LZ8UfVJ5rOIQ8I/UA+/G7L4a3J6HxAMYipZY+bOtFTW1wvV0xlNoDQK7cUE
	tdrqA0KzdnMhz0VtJXMhFfQN9A2LKrRdia4uTtB+yV7IwhAc3yl84eC4en//+oyQ
	dHpiA83OejYUQ1mnjGMSfqTlWgTef+UDrRxG5pPGlvZnqGpoUP9bz9hcBzYRAPQG
	WbShQ==
X-ME-Sender: <xms:EeMCZupOGR8CI300n5cD8CbPLUhqpqC5MmvWivRdMZQByyof-n321Q>
    <xme:EeMCZsrxWu6cfHpkC1wjAOYEFATMi3gq1o4t3PYE52PSKWGPLdftSSGd5S2DxUBjk
    gorNGYbU8ICemcb_g>
X-ME-Received: <xmr:EeMCZjPHjDsPjrduCUB0-lLqdMIMPjog0bmnVvSGlKLQkziw6ceh1d5xb9gNqiglPL7QZPddzEwr-GtPAuuLCawcR1O5znFFZeCQNnAgD6maIbTWlbTFvMa7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofhrgggtgfesthekredtredtjeenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepteduve
    ehteehheeiteeihfejveejledtgfdvieeuiedutefftdevtdfhteevtdffnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:EeMCZt4O0PfvAlKstskzLBiF8mj9adTWrnFC8SdatzKhYebLhcgSSw>
    <xmx:EeMCZt6M3eXtq0IBleDuFczUitkeV1mw1Ig6a7gyX02T0PU7WTiLWA>
    <xmx:EeMCZtgKc80zjbzVcADgv7Z-iqoJVxGGkzVI-vA8m0QHTSKsqF1qKg>
    <xmx:EeMCZn4_d5chVdJrac4AhCrnu3AGAykf-T-GRh3xNYy_mBXDrJoi6g>
    <xmx:EuMCZsLJkx2joy1z2EAOgrB0kAcv5tO-y_oSHksmkdtWWdVYxrSMHMFOTWY>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 11:00:33 -0400 (EDT)
From: Zi Yan <zi.yan@sent.com>
To: linux-mm@kvack.org
Cc: Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Yang Shi <shy828301@gmail.com>,
	Huang Ying <ying.huang@intel.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Yin, Fengwei" <fengwei.yin@intel.com>,
	SeongJae Park <sj@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6] mm/migrate: split source folio if it is on deferred split list
Date: Tue, 26 Mar 2024 11:00:31 -0400
Message-ID: <20240326150031.569387-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
Reply-To: Zi Yan <ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Zi Yan <ziy@nvidia.com>

If the source folio is on deferred split list, it is likely some subpages
are not used. Split it before migration to avoid migrating unused subpages.

Commit 616b8371539a6 ("mm: thp: enable thp migration in generic path")
did not check if a THP is on deferred split list before migration, thus,
the destination THP is never put on deferred split list even if the source
THP might be. The opportunity of reclaiming free pages in a partially
mapped THP during deferred list scanning is lost, but no other harmful
consequence is present[1].

From v5:
1. Fixed an error in migrate_misplaced_folio() reported by Baolin Wang[3].

From v4:
1. Simplify _deferred_list check without locking and do not count as
   migration failures. (per Matthew Wilcox)

From v3:
1. Guarded deferred list code behind CONFIG_TRANSPARENT_HUGEPAGE to avoid
   compilation error (per SeongJae Park).

From v2:
1. Split the source folio instead of migrating it (per Matthew Wilcox)[2].

From v1:
1. Used dst to get correct deferred split list after migration
   (per Ryan Roberts).

[1]: https://lore.kernel.org/linux-mm/03CE3A00-917C-48CC-8E1C-6A98713C817C@nvidia.com/
[2]: https://lore.kernel.org/linux-mm/Ze_P6xagdTbcu1Kz@casper.infradead.org/
[3]: https://lore.kernel.org/linux-mm/df9a644c-a007-46ac-98e3-61d4014fcfff@linux.alibaba.com/

Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/migrate.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index 1dbe5bd927de..a31aa75d223d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1652,6 +1652,29 @@ static int migrate_pages_batch(struct list_head *from,
 
 			cond_resched();
 
+			/*
+			 * The rare folio on the deferred split list should
+			 * be split now. It should not count as a failure.
+			 * Only check it without removing it from the list.
+			 * Since the folio can be on deferred_split_scan()
+			 * local list and removing it can cause the local list
+			 * corruption. Folio split process below can handle it
+			 * with the help of folio_ref_freeze().
+			 *
+			 * nr_pages > 2 is needed to avoid checking order-1
+			 * page cache folios. They exist, in contrast to
+			 * non-existent order-1 anonymous folios, and do not
+			 * use _deferred_list.
+			 */
+			if (nr_pages > 2 &&
+			   !list_empty(&folio->_deferred_list)) {
+				if (try_split_folio(folio, split_folios) == 0) {
+					stats->nr_thp_split += is_thp;
+					stats->nr_split++;
+					continue;
+				}
+			}
+
 			/*
 			 * Large folio migration might be unsupported or
 			 * the allocation might be failed so we should retry
-- 
2.43.0


