Return-Path: <linux-kernel+bounces-50120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CFC84747E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE7F296F0D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC6F148305;
	Fri,  2 Feb 2024 16:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="Q6BNiPci";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w3EzSPMY"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A9F1474B2
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890581; cv=none; b=ADFiwMIzklFKesO8G1WdnIGqcYK0fC3BCcguf9R56l7yo3AOegsUNfkDPp50gyiSHa3h6U6/b8yuuyOAHhTFNmUiDjz31BN9LBdhjELEHfUPRckkKM+0rYWph+WRk1AWqXNbL18mM5fv2DYS/y/yM0YfShFMNmQ16mrkHVnBCLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890581; c=relaxed/simple;
	bh=JQ3XAd6+1pk8HTCEGu8mix5SOQ7LMO81KCcmw2HK8Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rDfCbmNNWS0hrEybw09hTXwexXHsQtg13kA8cvJ933cG/LvYZQBu5vTUUG0ZKf6K0/U8WNwXvQxD2E3B7KUA9V+jIYSTLZen9Um3qwPs1KKLwQQ06aDXdZCsEiyxnPWXfwkyX4AAH5pxmh8JGLUTCXBgS8npWdUcDLkIJjRAYvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=Q6BNiPci; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w3EzSPMY; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 450FD5C0108;
	Fri,  2 Feb 2024 11:16:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 02 Feb 2024 11:16:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1706890579; x=1706976979; bh=Srz2TBF5bSmmDzT+fRItHrkdBt/FNKVEiEo
	yh1M6V+0=; b=Q6BNiPcizadAd+EZgLpzobSWkpvEDzg+ntUAZW2HFba3/Lbpme2
	O8sD/KsTLcClEooEDS+rgni1VKTOJVvjKG2BECTjNiNda9PMom5VpxTwxk+kmX9g
	5SJAxrVHTNtZxoS5jAUi56r/D8XWcS0OJh2+HEwhuwHmt1t9F6ixsOpYuh0Z62lf
	jsolvlGzfHgQFVTRoeCZd2VaMnTaM1ocYqJaIOR1z9/NUXsfDnUeuUp37YoN3RGo
	h9R7gudHRW7KTw4tSyeCZ1fkU5pRSQ2k5vAl5Zfe3Gl+tFLgCwcmgP1//oQ2W0+0
	ZAsBefLjP95IPfEJx9zsNtGrcaHxRnXII7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1706890579; x=1706976979; bh=Srz2TBF5bSmmDzT+fRItHrkdBt/FNKVEiEo
	yh1M6V+0=; b=w3EzSPMYiSxw7VrU6CcZVS7tnyWg0o5f4EO+FRuCOUgJup6WH3A
	gUN6QtlNYcx+Xn13uj0UTgRkf7/WGHrUMYbh0SZWawyQ1VsQMjqfWMGZIYZFIdqB
	TgfodME8fk/7pVIskKCsZPmLBTaZTRcAhff4gV09XWLcq2pcbc6xc//W7iVxO8y1
	k6Mv24maaJmmjZhsBbAUxbjFqyQp+8mkxO3FQkx6tvJUlZgqg+MLuMvmItlouDmy
	QqdBcxCFwfun+0ZBRcIHVEJ2iA/lBy8U/xlgdDOcFYEGbzGP8Vtg7NECbWUCEn7U
	NABFdFaLw/It9y8LVlvkv8GiKqoNy+b8vYQ==
X-ME-Sender: <xms:UhW9ZZtMEoFFrUqJio5dr-jDfIUZpnAl7M-C-2bLiBHEmjkLVMqVEA>
    <xme:UhW9ZSf8d7Zm2f2BHV86_7z0ho--mcrLI1Oc3M4afN7SDR_zC40MsZ1cDxHneGDjp
    yL1WYmxz6i4YHq9Sw>
X-ME-Received: <xmr:UhW9Zcy-9boW7Mu7KAD2ZZsOE_-FanBYR7ZPyhvUm_QNk6Xy3yWOkBA2SEIf3kfYYt635Y_qUwECrsOY0bX_Qj0_mzReOXcN73q1lXFFnaMJRpHXAAKAbz_W>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedugedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrgggtgfesthekredtredtjeenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepje
    ekteekffelleekudfftdefvddtjeejuedtuedtteegjefgvedtfedujeekieevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:UhW9ZQPxAHXjjMatZ7DnFtCDv1wbQ9s8PLr3a1MiooN7dsn_8Qh10A>
    <xmx:UhW9ZZ8U966yhoaFToiswjuvfZC4rtZ_QHbJOAYkGFGwwMWXk-Yf1g>
    <xmx:UhW9ZQU-NeFnmgM3u0P3SUqKRJ8Cwq1_fa_rkKsTiLBi2n-kHGy1rw>
    <xmx:UxW9Zc0G_6ZQZGBhP71rnnf_MYBlAqUPoMY1tJ5VhiyskbPnKV1kMw>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 11:16:17 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Zi Yan <ziy@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	"Yin, Fengwei" <fengwei.yin@intel.com>,
	Yu Zhao <yuzhao@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Rohan Puri <rohan.puri15@gmail.com>,
	Mcgrof Chamberlain <mcgrof@kernel.org>,
	Adam Manzanares <a.manzanares@samsung.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 3/3] mm/compaction: optimize >0 order folio compaction with free page split.
Date: Fri,  2 Feb 2024 11:15:54 -0500
Message-ID: <20240202161554.565023-4-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202161554.565023-1-zi.yan@sent.com>
References: <20240202161554.565023-1-zi.yan@sent.com>
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

During migration in a memory compaction, free pages are placed in an array
of page lists based on their order. But the desired free page order (i.e.,
the order of a source page) might not be always present, thus leading to
migration failures and premature compaction termination. Split a high
order free pages when source migration page has a lower order to increase
migration successful rate.

Note: merging free pages when a migration fails and a lower order free
page is returned via compaction_free() is possible, but there is too much
work. Since the free pages are not buddy pages, it is hard to identify
these free pages using existing PFN-based page merging algorithm.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/compaction.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 58a4e3fb72ec..fa9993c8a389 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1832,9 +1832,43 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
 	struct compact_control *cc = (struct compact_control *)data;
 	struct folio *dst;
 	int order = folio_order(src);
+	bool has_isolated_pages = false;
 
+again:
 	if (!cc->freepages[order].nr_pages) {
-		isolate_freepages(cc);
+		int i;
+
+		for (i = order + 1; i < NR_PAGE_ORDERS; i++) {
+			if (cc->freepages[i].nr_pages) {
+				struct page *freepage =
+					list_first_entry(&cc->freepages[i].pages,
+							 struct page, lru);
+
+				int start_order = i;
+				unsigned long size = 1 << start_order;
+
+				list_del(&freepage->lru);
+				cc->freepages[i].nr_pages--;
+
+				while (start_order > order) {
+					start_order--;
+					size >>= 1;
+
+					list_add(&freepage[size].lru,
+						&cc->freepages[start_order].pages);
+					cc->freepages[start_order].nr_pages++;
+					set_page_private(&freepage[size], start_order);
+				}
+				dst = (struct folio *)freepage;
+				goto done;
+			}
+		}
+		if (!has_isolated_pages) {
+			isolate_freepages(cc);
+			has_isolated_pages = true;
+			goto again;
+		}
+
 		if (!cc->freepages[order].nr_pages)
 			return NULL;
 	}
@@ -1842,6 +1876,7 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
 	dst = list_first_entry(&cc->freepages[order].pages, struct folio, lru);
 	cc->freepages[order].nr_pages--;
 	list_del(&dst->lru);
+done:
 	post_alloc_hook(&dst->page, order, __GFP_MOVABLE);
 	if (order)
 		prep_compound_page(&dst->page, order);
-- 
2.43.0


