Return-Path: <linux-kernel+bounces-96009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3868875603
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABFAD283DCE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9E01332A6;
	Thu,  7 Mar 2024 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="DvgTWnpE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HhyYVyOK"
Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9D284FBA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 18:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709835630; cv=none; b=XiIUaOWnxJ7iXMQDtd8QwqJShgU3RNnqmzsmXEAWkFWevNsUZkTzZSg9MEqwFmrGnjO+yyFqMNwU8h4KVEHatGIa2N7TXiIQD3QdyJQceXj/oL+vXv2W59X9tHavrEv7RvyWPr6h2oYivZ2hm4Jq9S9SV0x/8KjYARORqQxL5DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709835630; c=relaxed/simple;
	bh=vx9f52epNWEzONOHjyN4alR7l5mAAB50BSvc+yNmx9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P3JNeg+dm0ObNsOnD7M2Id22O75POY6kafySPYjrl4RTcROGNrOPpL3vTJGhUKeUoU1HwCw+Adpc3yAAbjH+eePFBrGSOE8AgH2WqD5uqYkr2qETSx7Q7ZA6R2yB1/iRq60JemaLsWD4+76NZFkumOi+6Fk1tTYcgZnbiVTJh1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=DvgTWnpE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HhyYVyOK; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id A0CBA18000CA;
	Thu,  7 Mar 2024 13:20:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 07 Mar 2024 13:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm1; t=1709835626; x=
	1709922026; bh=arK+NBGKdHWZ6efyHQWXlXfgQ1L/CzF1zSO+BWgFZXQ=; b=D
	vgTWnpExQF81NowzJzUTgnd9lYg2Yxvqc1NFwSGjL4AdA/ycBpKzffa/5eluXgj7
	eGl2AI8DFJLCb9n+kKOPGQs6CmonlhWsXWHJG82SQSoCtPIz5oWbhopO04OPw2La
	AEq39UGxN4q/bkS6UPbKCu3C/EPrGyiBC9rlJ6iT3JL+7K63cyKYElGPm61RNxRy
	RqBkKANLzyKDZU+OsOC64aYA4tmbSo9UaNa8uqpA0mLHaFATy9e/OgdAhHtRvXJ2
	k7AJ5Bn8uVgKQmdr2tFqIIfnDEW0eIK2XN/SGjnlVoJVDf/My0t6V8FEYV1yDaZf
	3UDt9B5WFLG1KcxFYSV9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1709835626; x=1709922026; bh=a
	rK+NBGKdHWZ6efyHQWXlXfgQ1L/CzF1zSO+BWgFZXQ=; b=HhyYVyOKsumEySrPt
	Hqr9GLVr2KX7esjQZZTMMsuPDt9AmLAKtHvXNIhBjS9nMlkq/kyRKIlRGAJUnhnE
	vQ54uiRxjCnMD4jfYENEPLSYRJvNB0R1OWDkG3Sjzz71vEXDIFCcifM6v1v2ETBI
	6fYgQ1AriMBHhHAnL4Z/VgPKf0AVTKtp/3XBjdM5ZP7FC8ODc8QDXnhQ42qF/xx/
	1DbTftHtGOiZzALLeRcWP9TbKN4/to4sJdG0QK38MCxUTZJa/ypoG+D8qGKGFRow
	Wp0K01SALTlNQ8fZixzm/s12GIzH6MkpKfGgn0OqHh/n19WkwnWWFk7huL4ZogEB
	yFQgg==
X-ME-Sender: <xms:aQXqZXGuExPNCniHl5kfn_KjXtGLHugyvcPy00GfzBFPOe_WmiNOzg>
    <xme:aQXqZUXoPOQCf7CnInCBXKm-r7_wNUkJKPeipZL1jpP3_DrMGph_F0SqbJZn7izZu
    k-ciznnAjLbvFzQpg>
X-ME-Received: <xmr:aQXqZZI7mdP5O25FdpKhrC8I4DJFaf6-cBYTgZUvKw8pmQ4MGLvLGqSYtgSWILvdEUVpyTghfpGU7-s2hV0x9duKGZdX2VQce0aksRrnZxVYSU5bENDE2FEV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofhrgggtgfesthekredtredtjeenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepteduve
    ehteehheeiteeihfejveejledtgfdvieeuiedutefftdevtdfhteevtdffnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:aQXqZVH1Po-ZVPjmXUyaAltBne1JUQ37u76ixDMo241RW53yUtr0Tw>
    <xmx:aQXqZdX9JC9mN4KycfynT1lxjCI0wi8Tc7oFbh8B5BeSGWhaFtNOuQ>
    <xmx:aQXqZQMOEIY8ZgFVD384TcfJE1QupNax4AvM4htM8RTyyxGwqQq51Q>
    <xmx:agXqZWuIYnQSQqCArdU3C9LzoaNwbUzAWxtBkcXzUTH1AktLz0s02OaaKZs>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Mar 2024 13:20:25 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: Zi Yan <ziy@nvidia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <shy828301@gmail.com>,
	Yu Zhao <yuzhao@google.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm/huge_memory: check new folio order when split a folio
Date: Thu,  7 Mar 2024 13:18:53 -0500
Message-ID: <20240307181854.138928-1-zi.yan@sent.com>
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

A folio can only be split into lower orders. Check new_order to make sure
it is smaller than input folio order.

Link: https://lore.kernel.org/linux-mm/7dda9283-b437-4cf8-ab0d-83c330deb9c0@moroto.mountain/
Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pages")
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a81a09236c16..57fca7bffd20 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3052,6 +3052,9 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
 
+	if (new_order >= folio_order(folio))
+		return -EINVAL;
+
 	/* Cannot split anonymous THP to order-1 */
 	if (new_order == 1 && folio_test_anon(folio)) {
 		VM_WARN_ONCE(1, "Cannot split to order-1 folio");
-- 
2.43.0


