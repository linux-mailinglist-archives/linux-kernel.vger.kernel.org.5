Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BF579F2A6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 22:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjIMUNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 16:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjIMUNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 16:13:16 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F331BC3;
        Wed, 13 Sep 2023 13:13:12 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 3AD4C3200931;
        Wed, 13 Sep 2023 16:13:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 13 Sep 2023 16:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1694635990; x=1694722390; bh=nW
        Gq1gLR7F41muaJaoLOMct76xa7LgE2SjtA7mYmrLE=; b=xvbgZdE3/nGTuYUUvH
        u5cCgINz/3pwJhWTguTgefNOzbUhpNqf3mZHxc4jf8Gi1EVIya1H3GR2ZBgF/dXp
        7hNXBAXnSlbfx4HBobFsvvCCxiPdcnXymIZOsu41aom5nBhu4l7FXoH8I5VF0SnJ
        U68NDJ6hCCK5D67ktwRZBjTvJTpdc2KhnOPUvPQyG8kZIysketKrIAR6AZfd5HmF
        85F0KpKO2XbB71FviIWMfeskmsu7YynqqsOHNaBB/JJbZYM38i6zff7PpOD4Kscf
        TWLBWUYJik0rQBafXPQJ/RTOd+g2sPesJscNbLDHt04KAWgTzv0XMC8C83F7Sret
        mJ1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1694635990; x=1694722390; bh=n
        WGq1gLR7F41muaJaoLOMct76xa7LgE2SjtA7mYmrLE=; b=q9t1HOCltCbs9NGp2
        35SQHUh7Yz5SCWu97v/ldfktBV9gKyWzHfSBHsZcxXGXkk/Dbz3Yr/6sPJY+YWj+
        Bc5gJ/GC57NUV4TOAR9Y+nqkp0XcRZK5QSyxjGVmPWLNldWyLWOd/DnqdtqTxxmt
        gMtqtLzXzKIOGCOWdTIg/epr7yg8lYox9+bsRr2ibP+Q2wFCLzUOe2NTW9x3fVgc
        TzqjN5HUq7VwAeGfjUdXL1EI4tVzsEDBgSAQBz4HZtMb7l7+gOHHugHK+fG9rneN
        XIcAVxVDCw3nkHNGILSx5VEblUtX8o/6wecDsvsW794pGIMpChkMXrjpIsKjRohQ
        MECQA==
X-ME-Sender: <xms:1hcCZbqe39lCulOHh3IBffCDvRGYLCQJF9hA_Zm_2kqyBN2NzpIBkQ>
    <xme:1hcCZVrNP5SdHm0SPhC76xognGMq0Tht527_8g_Lg4Uugkowh99n3f3C4Z3KlqtWb
    DYDR46M5BK7CSuY4A>
X-ME-Received: <xmr:1hcCZYOjAcSEEaG7ayzMToZDZEa2gXQAx0WVYo3qQvhZKW5-OH-l2pOofHnBp3iDKXEUXRbqhEzuJv8Ua4mcSgUHORk5DhQ_a7cI_BI81Oem5CNL-gcKYVNt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeikedgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogfuohhrthgvugftvggtihhpvdculdegtddmnecujfgurhephffvvefufffkofhrggfg
    sedtqhertdertddtnecuhfhrohhmpegkihcujggrnhcuoeiiihdrhigrnhesshgvnhhtrd
    gtohhmqeenucggtffrrghtthgvrhhnpeduffekueejvdetgeelgfdvudfggfejtedvheev
    hedvhedvjedvgeejvdffleeuveenucffohhmrghinhepmhgrnhhiphhulhgrthhiohhnrd
    hmmhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeii
    ihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:1hcCZe68QYm3FAjawT_66yjMVD4OS9u9E__zja0uY2QivxybFwA6OQ>
    <xmx:1hcCZa4JZ0zbNUisDdqGqZaNIOCI5pzNfL93_a1nyF0YGA8qn-d-cw>
    <xmx:1hcCZWgP4Gtm0GcL_GPOQodU5dHOykmfYJHSYKrtAazw4vwxkKysRQ>
    <xmx:1hcCZTH1F1Y_tMd92CraEJmPu-2WlQK0NVxKntLqRomFhhXhpdsOHg>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Sep 2023 16:13:09 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Cc:     Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>
Subject: [PATCH v3 0/5] Use nth_page() in place of direct struct page manipulation
Date:   Wed, 13 Sep 2023 16:12:43 -0400
Message-Id: <20230913201248.452081-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.40.1
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

On SPARSEMEM without VMEMMAP, struct page is not guaranteed to be
contiguous, since each memory section's memmap might be allocated
independently. hugetlb pages can go beyond a memory section size, thus
direct struct page manipulation on hugetlb pages/subpages might give
wrong struct page. Kernel provides nth_page() to do the manipulation
properly. Use that whenever code can see hugetlb pages.

The patches are on top of next-20230913

Changes:

From v2:
1. Fixed the subject and the commit log of Patch 3 (David Hildenbrand)

From v1:
1. Separated first patch into three and add Fixes for better backport.

Zi Yan (5):
  mm/cma: use nth_page() in place of direct struct page manipulation.
  mm/hugetlb: use nth_page() in place of direct struct page
    manipulation.
  mm/memory_hotplug: use pfn math in place of direct struct page
    manipulation.
  fs: use nth_page() in place of direct struct page manipulation.
  mips: use nth_page() in place of direct struct page manipulation.

 arch/mips/mm/cache.c | 2 +-
 fs/hugetlbfs/inode.c | 4 ++--
 mm/cma.c             | 2 +-
 mm/hugetlb.c         | 2 +-
 mm/memory_hotplug.c  | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

--=20
2.40.1

