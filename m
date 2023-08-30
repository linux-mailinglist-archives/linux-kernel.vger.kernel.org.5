Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0121E78DE30
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbjH3S7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344205AbjH3S2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 14:28:20 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FE8A3;
        Wed, 30 Aug 2023 11:28:16 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id C602B3200900;
        Wed, 30 Aug 2023 14:28:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 30 Aug 2023 14:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1693420092; x=1693506492; bh=fo
        Dp5yxOH6GyIQ67vpSZpUgHB1689dLzaIy9GEckfQ4=; b=VzSy6vz/3jEqLcnt9d
        v70cTqblMSUtCONPDq2FYgH9KbZ6oGQe1ANLeFnEgDOr5gWNNxTw5feWIR4SBX7h
        +4hFw0pFT8WwNFeFfwmaNrk3PiwuQsrEpmwSlhMR8J48ZSSGJg/XDBrMC5aAADJw
        3UcCiWZspWV2Gw7spuWTq1xsaDTlP45JEeacMLmsXm675V2wjdMddi0WEiedGjbD
        rRizhHE3iwQAUHwImy4bMqWy09AtAfwywDjeXcQgWCkuL1wRGaH42LyhokgusYcn
        GX2UJ7b4PAjUjtiTTSRhwhNONqdOnww+tHfZkNMiHFpIkuQQWf/OZEtvLKcbDhRj
        wNGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1693420092; x=1693506492; bh=f
        oDp5yxOH6GyIQ67vpSZpUgHB1689dLzaIy9GEckfQ4=; b=K0njS7rklou26kRAO
        Ptbz0hqL7fAXkVMBKaRcwtNpFezNy8PJ+nXQZNAYMMePSYqhe3wUB4DAdktZx0np
        Q+op8kthM/R+Z40rFmhR1wWiNtDfBJSE6Kd03BmyPjUGZEHtLgZr3mym6CyyUvHK
        ooGu45R4oxwURaZm632kYTlAejmvAC1A/WVDahOgCKxjFh6jEcS55rEIiU6JeO9n
        0nHi7Vp3VYKq3JaVU+YPuU6ewr3rKUuQtEORW9JjBjcuf64KwGzIcVkBpQz/YG6e
        hJmCewlZS79KxxllqpZAs4ChV+VvXmtDg7FPwb7wb/xIyb30SJ8D8BvHnmSj+p7y
        85kqw==
X-ME-Sender: <xms:O4rvZMhFDP2YYXFFPRvINnUUYDSy1Zmb41wRFOR-1kCidF4xJV7Lig>
    <xme:O4rvZFCCQdGeKe-bgaEHuCC8X0oOZ4UXVbc9LYt6iIj4RFlGe4kQVIUwl4pxYENWW
    OMT3qdd8--DLJ2iMQ>
X-ME-Received: <xmr:O4rvZEG0GG22F2Iaa-N4zkU93AduAl9MFqzBmWZTied7sYxifrlTjvzwe3XtHlMlW4ZhCCZDpnK9CDzGTcvXVHIOGEp8j3rPJBJMktgEDhx1OrUCvWlup92M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefkedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogfuohhrthgvugftvggtihhpvdculdegtddmnecujfgurhephffvvefufffkofhrggfg
    sedtqhertdertddtnecuhfhrohhmpegkihcujggrnhcuoeiiihdrhigrnhesshgvnhhtrd
    gtohhmqeenucggtffrrghtthgvrhhnpedtgffhtdetledtkeeihfefueeuhedvudfhvdei
    feevtdektdetgfeiieejuefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:O4rvZNSRRnR9bqnIJ-r1O0Zr-3HOYIh35Ze72Zua9KcbhCpQmlxpUA>
    <xmx:O4rvZJxTxGwzSP9QwnCwYv_ruTb_8htUXHXrlhUcaC4mdRxON_hA4A>
    <xmx:O4rvZL5dbI-XW8W1PaOYhbJUBWH6WF3mEh8mDpbcSXhQnmosD-4gMg>
    <xmx:PIrvZJfPM8RWAIKhfZY8iPKfIqaFFYLwbAZuN0TPSNbOlxEmSdDIkg>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Aug 2023 14:28:11 -0400 (EDT)
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
Subject: [PATCH 0/3] Use nth_page() in place of direct struct page manipulation
Date:   Wed, 30 Aug 2023 14:27:50 -0400
Message-Id: <20230830182753.55367-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.40.1
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

The patches are on top of next-20230830.

Zi Yan (3):
  mm: use nth_page() in place of direct struct page manipulation.
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

