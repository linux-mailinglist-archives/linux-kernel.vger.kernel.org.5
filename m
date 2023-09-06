Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A89793FD3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241736AbjIFPDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbjIFPDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:03:23 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281FEE49;
        Wed,  6 Sep 2023 08:03:19 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 6D2FB320092A;
        Wed,  6 Sep 2023 11:03:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 06 Sep 2023 11:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1694012597; x=1694098997; bh=nT
        uP10zriYyST8Q/kBCNG/qEQgmqc70KHU1yjiMDwLg=; b=Sn70enwh1eH007UJNc
        cyTt2nHpLZx1vQXdrhk438xafdqp5ZuDSJAtPeceUmtBeGUE7LmH3LLhREeuxFXi
        o1j/JRtZIwdGsclczjEvFQF0Fs43c1qm69kCLNXwsb98wLaVRmlHQ5j0kRgA6R0x
        aAgssCKGyGj0/rReVQey4zOuwRpbTR9eJBKA2fzDbi81QYocnTwZbPod+pOroKHf
        MLTDIpatpHi+ffs8FXqViLfGWAkcMvekidGMx64rzVB7FU4strT98RIlnFPCrV0Z
        fKHza8ElRmeH2gUD4+25WTGLjFZa5uvZd/NkMXJvV9aBVmMU5LsJF6Ow+Rc0P83g
        5RMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1694012597; x=1694098997; bh=n
        TuP10zriYyST8Q/kBCNG/qEQgmqc70KHU1yjiMDwLg=; b=abyRc8o8LiDpvKbHi
        raN8Yulebq767LF3nLwmzWfDM1dVKzNk/M9refFnLGQv7/VmvjGIuSlVUPL/t89r
        HRoS7P15C73rFKnKSIgAVXMLGes+9tyefoMU5jE0VbhVwCNizYbHi4AnHfgdnzUC
        V5fsIjlbOheo8HlHsLc742H6jQUJo5AXlPMERpd1hBFq/aI8QjfZdkxLZSttq5t0
        L0Zr/P46BbTsevdvf9OUt0vE6ZY64xgCfwXK9/u+WOt8uccU9iJkdKrUYx9hcEID
        qkw7p2PMqjRtx5raaPi75LnvpCkcItR6g8QMxssAQVzlmV7AhptttM1ypJczPYdf
        HlpiA==
X-ME-Sender: <xms:s5T4ZJwVjvizExJgeDCfV9hvstJwM9xlZMOLSgUoTWyKiAENiLG72Q>
    <xme:s5T4ZJR3r_cjPFWx-qbxWHa1-DSG0g0lZ6WJamoxPaNOSNy7xEBNnLnSuBpNWxR1F
    6zdW2hJLhF12JU-3g>
X-ME-Received: <xmr:s5T4ZDU69abxYUefTaLGn48O_aS6HzCMczQoXOxaQUM9eTj-BpH3WwHT8tWbzNAvZ2D82GZMzudd21Za_18cA6vXbMdiKj7WG_UcOxTrKZECbofpkyTy_KWr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehfedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhorhhtvggutfgvtghiphdvucdlgedtmdenucfjughrpefhvfevufffkfforhgggfes
    tdhqredtredttdenucfhrhhomhepkghiucgjrghnuceoiihirdihrghnsehsvghnthdrtg
    homheqnecuggftrfgrthhtvghrnhepudffkeeujedvteeglefgvddugffgjeetvdehveeh
    vdehvdejvdegjedvffelueevnecuffhomhgrihhnpehmrghnihhpuhhlrghtihhonhdrmh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihi
    rdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:tJT4ZLjSdEwyzC4tYTNrcNV6e3bBjx0t0fwzuiDrL56DCbRz8saKxw>
    <xmx:tJT4ZLDM8pCTwZImO9eG0ftEhwvqXN_YR4jGlg_DJS5hJ954jJ6hcA>
    <xmx:tJT4ZELjba6lr-ACO2rmMUxMsqKl8dU83DVgaXgTJh8iMCenZdTytw>
    <xmx:tZT4ZHsRxOv17cIkiIbuF1Tbwqym3PxwksssxPG-BUQn6TLY1fWT5A>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Sep 2023 11:03:15 -0400 (EDT)
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
Subject: [PATCH v2 0/5] Use nth_page() in place of direct struct page manipulation
Date:   Wed,  6 Sep 2023 11:03:04 -0400
Message-Id: <20230906150309.114360-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.40.1
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

The patches are on top of next-20230906

Changes from v1:
1. Separated first patch into three and add Fixes for better backport.
2. Collected Reviewed-by.

Zi Yan (5):
  mm/cma: use nth_page() in place of direct struct page manipulation.
  mm/hugetlb: use nth_page() in place of direct struct page
    manipulation.
  mm/memory_hotplug: use nth_page() in place of direct struct page
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

