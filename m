Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECA079D646
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236762AbjILQ2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236772AbjILQ2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:28:37 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670C4115
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:28:33 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8F5BD5C020E;
        Tue, 12 Sep 2023 12:28:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 12 Sep 2023 12:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1694536112; x=1694622512; bh=5t
        1ioQ/11KphbqzXH7SCYin9Bo5ArvfTJo+4zOQ+tUo=; b=yPxIE70aHJyQBG+Cz7
        r1pUm8bA7QZYChGe1yn5GyPCFUsWuCw8vTMgKJmPWCfBljM6LYkcMmbYqPU3v8W1
        McvyoyJHw0npjr6fTKnw0sr9TRsbFbyXlgtwcNGKqStMbESs4XwQQ3D38KA/YrbS
        KgFz6ASTZTmJ2PXCS9mzxogr12O+bxO3FvfD89UhJc33NzdB6GfVoNxgLx0OMEIF
        69l0gbGaX8ewEojdkEH+NzlFLMBXBGOZWc5wFtP3yZ0i7P9AgnvXf9zqCsLe03PD
        JLnF3CucRaTXVr0Otp/U/SQ0xXWS/FxTmkwt6s/fXU9X18/LyA1VsRX/BMDCe1oU
        PYvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1694536112; x=1694622512; bh=5
        t1ioQ/11KphbqzXH7SCYin9Bo5ArvfTJo+4zOQ+tUo=; b=M3g/WjBOWlHh3VsRR
        8pDFfruMUOVnACEwfCjQWnnoCfpyyBSB4X5h+mfZkTim3kdPSAQySOdddZl8FbLN
        QQI+5pCliiBxHNtQFzOJvD1abGwpoVL7Q5LwiM8lByN4baeMu8Znx+Z616roydOz
        TG6AW7aQ3ZmDGMhu80YKMaSdz9wjkzd6Sni1cbTmQXqB6OzL8YEVG9KNPyxFPjBK
        crlzO7e5y5aLclGd/KAstXTbSsN+rkdJXFEJze9ClEiTpRx4VoHxOmJMczbncWj7
        6czUo77It5UygNrbHbwUf3QkLnQePOc/mK/rS9TCCPdF2ps+xfUy0ju0mwyZanQ+
        mf9gw==
X-ME-Sender: <xms:rpEAZe16fOH6ukzZ0EUSzqWXwFRNy0aTcPgDA_IUYMmTu-MapdXIAw>
    <xme:rpEAZRFh4_ghaV3kqh4hkAE7DrEqRP2tJvXZanBHditj1Sow74bMSw6bggVSMIDY6
    GMEnSLkKNE8Onrweg>
X-ME-Received: <xmr:rpEAZW7yEXNNdbl32CBKxNAxJWZ8p-E0I3GeySJyeBpYVpJs8bEt4TYoTDMHXf7SGr9KZHCqL-mR47ndWbDUEtzYM1br6pyiF3EMWE6Wg-vQRI0tgxCqaB0h>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeiiedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkfforhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepudevud
    egfeffgffhteehjeeuheejueelvdehhfekhfduieeggfduvdevkeevieevnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghdptghomhhprggtthhiohhnrdhmmhdpshhplhhithdrmh
    hmpdhprghgvghsrdhmmhdpfhholhhiohhsrdhmmhenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:rpEAZf14vkTTcxWwQYBnspTrA142lsPC2MvCjPEVwaV_plH1kUDhlw>
    <xmx:rpEAZRGWTJEPGBPBn__UWgoukCWdblV2_pb3TmTKc7vMnNVjAgfVaw>
    <xmx:rpEAZY_HAUPqf4uIJ3zUDezQp3KLOJ_1wdYHKsOYN_3tDAnab_3MjA>
    <xmx:sJEAZXVVMFyWbiI7ZhiO1odNJPpS1PnPGVICCMy7ts55iSQZpEfh9Q>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 12:28:29 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Zi Yan <ziy@nvidia.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rohan Puri <rohan.puri15@gmail.com>,
        Mcgrof Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [RFC PATCH 0/4] Enable >0 order folio memory compaction
Date:   Tue, 12 Sep 2023 12:28:11 -0400
Message-Id: <20230912162815.440749-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.40.1
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Hi all,

This patchset enables >0 order folio memory compaction, which is one of
the prerequisitions for large folio support[1]. It is on top of
mm-everything-2023-09-11-22-56.

Overview
=3D=3D=3D

To support >0 order folio compaction, the patchset changes how free pages u=
sed
for migration are kept during compaction. Free pages used to be split into
order-0 pages that are post allocation processed (i.e., PageBuddy flag clea=
red,
page order stored in page->private is zeroed, and page reference is set to =
1).
Now all free pages are kept in a MAX_ORDER+1 array of page lists based
on their order without post allocation process. When migrate_pages() asks f=
or
a new page, one of the free pages, based on the requested page order, is
then processed and given out.


Optimizations
=3D=3D=3D

1. Free page split is added to increase migration success rate in case
a source page does not have a matched free page in the free page lists.
Free page merge is possible but not implemented, since existing
PFN-based buddy page merge algorithm requires the identification of
buddy pages, but free pages kept for memory compaction cannot have
PageBuddy set to avoid confusing other PFN scanners.

2. Sort source pages in ascending order before migration is added to
reduce free page split. Otherwise, high order free pages might be
prematurely split, causing undesired high order folio migration failures.


TODOs
=3D=3D=3D

1. Refactor free page post allocation and free page preparation code so
that compaction_alloc() and compaction_free() can call functions instead
of hard coding.

2. One possible optimization is to allow migrate_pages() to continue
even if get_new_folio() returns a NULL. In general, that means there is
not enough memory. But in >0 order folio compaction case, that means
there is no suitable free page at source page order. It might be better
to skip that page and finish the rest of migration to achieve a better
compaction result.

3. Another possible optimization is to enable free page merge. It is
possible that a to-be-migrated page causes free page split then fails to
migrate eventually. We would lose a high order free page without free
page merge function. But a way of identifying free pages for memory
compaction is needed to reuse existing PFN-based buddy page merge.

4. The implemented >0 order folio compaction algorithm is quite naive
and does not consider all possible situations. A better algorithm can
improve compaction success rate.


Feel free to give comments and ask questions.

Thanks.


[1] https://lore.kernel.org/linux-mm/f8d47176-03a8-99bf-a813-b5942830fd73@a=
rm.com/

Zi Yan (4):
  mm/compaction: add support for >0 order folio memory compaction.
  mm/compaction: optimize >0 order folio compaction with free page
    split.
  mm/compaction: optimize >0 order folio compaction by sorting source
    pages.
  mm/compaction: enable compacting >0 order folios.

 mm/compaction.c | 205 +++++++++++++++++++++++++++++++++++++++---------
 mm/internal.h   |   7 +-
 2 files changed, 176 insertions(+), 36 deletions(-)

--=20
2.40.1

