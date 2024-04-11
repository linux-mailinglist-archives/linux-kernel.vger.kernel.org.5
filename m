Return-Path: <linux-kernel+bounces-140799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E80A8A1904
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C537D286113
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DDA57311;
	Thu, 11 Apr 2024 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="QHJ0LVRu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rrDlv/VD"
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254074D59E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849559; cv=none; b=lP7gEBCuryBh3PHDTc1Mlda4yW92FP5YgzxeVRL3Ceb7ZYtqYWPyT3cKOmNZu7xmeyZHTFz7ipcNRwMabbZrKV61fWnQEtThnIThOi+qHHHjaLVh3JmFtPvjetnY0SN45ATHtk6x7+2w9m3HdRtUZdDXYHCmch4P2giAjz3StcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849559; c=relaxed/simple;
	bh=rKMR5jyIs+kfYGVqAunwC0t4zLUUl9aMrjq9JmvsMnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TER9xryabW9p2k7RaSXeHbIBtZMbIK2UdynZtHDSCd51UGL12H7gfoPeqxBOiso1ZhzqjAXZ0xkjiv1HyEQEpJMsl66DZmUBwJ3yGFcdgtlfovmV5FPYghNCSHOQaP6BdTW/jdKcmrNK8N60Mtajc8j6D98ah3Jjc2nXx81Jll0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=QHJ0LVRu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rrDlv/VD; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 752081C000CD;
	Thu, 11 Apr 2024 11:32:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 11 Apr 2024 11:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm2; t=1712849554; x=
	1712935954; bh=KdSkiWAB+vDwE4VKWUPrvuNlR/TihrAEV6L79eFI5ZQ=; b=Q
	HJ0LVRusDCl9WofJUn1onmqrSqUqAMyw6HqF03WQEacpYIj67+33AMlN0HrdCkuC
	4i+X20NidtzFpZJQ8xCoKsMxrM/zthuBpjU1EGANz5jqLZCOBLORpeFK0K+N+o+g
	WPAUvMwN+KYFrTuO51rkHQ3ys4OwYFVXBvydgWrgJDJgdOTeDNFXRN3cs/Y8vfMT
	AW9ou+8jGS5jl5uaqGrtNZ04Len01wUtFTaHoKkD0wItPviV92d5hjc3cCbubm0H
	K5I0gD7I2NCH94E5iOLaPCCMR8CT0HD+pmbuoD8S49D794j2JdLW+sH9NZ7sL1GX
	UwmAnnS8ZQowvZM8WsYfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1712849554; x=1712935954; bh=K
	dSkiWAB+vDwE4VKWUPrvuNlR/TihrAEV6L79eFI5ZQ=; b=rrDlv/VDEMK6irLfP
	0s8x+W7HbkF4lRMYw6Ry7bWTRbodWBHDMzfDBjLe9rvJv4KBp8C0Ae5LK3XxNVEy
	TyoPFiJUiRML9vwpT2Bs4bJrCFueytwcEr7wIgFEAQiUJdwzvHGpZUPXQoDhRwSr
	CAtcONha58r3B3chAXA5SZ2pbGYm683KrHZkgxxWjgWi+2Dr6VMA2ZRJ8Z77agnx
	lXuQI2c50PfK5D402SHgKosZEkBoaE4KWP8QKIMtD8gZxyDbjwbdaOKeqYYhe9uD
	TQ0LunFJOXJLcABuWcgZJAzzC6PBp7n5RXSA6h6gHH6t6pPKDazgkNTqOj8F6RKs
	w8HlA==
X-ME-Sender: <xms:kgIYZmUW3fjVepV6hfJ2AOlzDROaTKrBs_eW4_gEDvk7A0GaBHQhOQ>
    <xme:kgIYZiljUxvYm9_uCDH8at7_2UmLPwRUezsB-5ekIZjmoaFDXmuDUPo4DfQKq6IbI
    KC8nshj85Z9j3X__g>
X-ME-Received: <xmr:kgIYZqZmxHz_SDZb50y-P-IcBrTDQT5YsXf8rHnwumfl2D2JbI7xB9ACqTMCKHJi8EI2tXGMwtEjyobJ5OAuoKP_NpyyD5ejCwP1PiFUyCLWoK8rafqMKMlj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehkedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofhrgggtgfesthekredtredtjeenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepueevte
    ehveduudffveetfeehueekheeutdeuheeiheeileevgeevueffieelfffhnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:kgIYZtVExG1CQyEsHeMZCJe4boI4TLoTW2iwpU2XdDgacOWMGDKBSw>
    <xmx:kgIYZglxCHmdmIIV8oiVRfe0nxKDK3rAC5YHi9JJyws6avr1g_Jd9w>
    <xmx:kgIYZifTWKEBsQ2NgasWr9X-VSAE1ebDjhwJTfUWJFFBtlSeyBM-Tg>
    <xmx:kgIYZiGDGG0CcjB7kMrIZc0OG00f8szQKekVDbxXXebTLuqzF65OqQ>
    <xmx:kgIYZthE-JSEMgnFV9pr8cjW9YQ76fmczVnM0NmEqRFWFMdevrHY9Lz_>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Apr 2024 11:32:34 -0400 (EDT)
From: Zi Yan <zi.yan@sent.com>
To: linux-mm@kvack.org
Cc: Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Yang Shi <shy828301@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Barry Song <21cnbao@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/rmap: do not add fully unmapped large folio to deferred split list
Date: Thu, 11 Apr 2024 11:32:32 -0400
Message-ID: <20240411153232.169560-1-zi.yan@sent.com>
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

In __folio_remove_rmap(), a large folio is added to deferred split list
if any page in a folio loses its final mapping. It is possible that
the folio is unmapped fully, but it is unnecessary to add the folio
to deferred split list at all. Fix it by checking folio mapcount before
adding a folio to deferred split list.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/rmap.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 2608c40dffad..d599a772e282 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1494,7 +1494,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		enum rmap_level level)
 {
 	atomic_t *mapped = &folio->_nr_pages_mapped;
-	int last, nr = 0, nr_pmdmapped = 0;
+	int last, nr = 0, nr_pmdmapped = 0, mapcount = 0;
 	enum node_stat_item idx;
 
 	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
@@ -1506,7 +1506,8 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 			break;
 		}
 
-		atomic_sub(nr_pages, &folio->_large_mapcount);
+		mapcount = atomic_sub_return(nr_pages,
+					     &folio->_large_mapcount) + 1;
 		do {
 			last = atomic_add_negative(-1, &page->_mapcount);
 			if (last) {
@@ -1554,7 +1555,9 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		 * is still mapped.
 		 */
 		if (folio_test_large(folio) && folio_test_anon(folio))
-			if (level == RMAP_LEVEL_PTE || nr < nr_pmdmapped)
+			if ((level == RMAP_LEVEL_PTE &&
+			     mapcount != 0) ||
+			    (level == RMAP_LEVEL_PMD && nr < nr_pmdmapped))
 				deferred_split_folio(folio);
 	}
 

base-commit: ed7c95c95397baff9b40ba9b0919933eee2d7960
-- 
2.43.0


