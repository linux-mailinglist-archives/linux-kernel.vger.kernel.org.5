Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9617BEBA0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377816AbjJIUcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346654AbjJIUcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:32:45 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350859E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 13:32:44 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A12B15C02B9;
        Mon,  9 Oct 2023 16:32:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 09 Oct 2023 16:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696883563; x=1696969963; bh=JP
        vpBZP1SSiqvBRF9ydN+g0ZFANiZsdjFQ7+amB/n1s=; b=eXdStKJ2pUQ8PIxQKv
        v4+49A47wjAImQwoLH2c9IWNdyCam1VBVuLz+McMZoPKxDRdxoOYIRCBRQducQR2
        WfM2TuASvkyffQNdk9oFuFANUnk+4AQ/Fue6JYRdYw7XM9EfN/kpfFudR2Z9KM0a
        FMIeJFp751MvE2jeSz2I5wTB6ZO2UyjsLwlS9dWVyNX2316+O0oAD1Ou2xnKiKJT
        oQH5iSKi7F3lPORxiGkWp+ZieyeHw3BZepFlgetSkTDJxdmeF1Go4XiO20X09hpL
        kxK899lKSbaI31hk+OiY6anY+25Wn7VB3cFdYE1OGFxb+7CEO/FeaorveYoarwFT
        SY8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1696883563; x=1696969963; bh=J
        PvpBZP1SSiqvBRF9ydN+g0ZFANiZsdjFQ7+amB/n1s=; b=Ha1tRQ+kVnqQxBJUW
        8EXwUIBNS5fH98GQgY8Lpb+aSAXu9/UPJZq5f0z12lKqQ1XPql/iPGB8K+PS8XzG
        lbPEvqRmWfVWNSWh5wJeuthxxqrcQjN5Jl7/djL/PjOqwLdE86pF+5Eeu4hrJkqI
        mw5fV36KFlmVg+NnzMxLLNVWOrBUSaBYoGPKngcUiQiEveiBpu9fKBYeMRC0r8L1
        G5oCI82lUGZrN2KTGhtS/cbGyqxOGACP5ZdiDKEHscmyiK5+aJMPHSeJiWOaAbMT
        Ekj++sOuSOf6ZRtL40TRcr68ZqRctc/1Cthp4yR7BZJQhHFyq+ZgFkPinrH59E+X
        I77OQ==
X-ME-Sender: <xms:a2MkZbYN0m_GE-7ZPHL_6gSeMUQ0dTB0gojE2bxWhJ9PervBdcnP_g>
    <xme:a2MkZaZ2fxQ91dfQ68wuQtf9z-4SZojUBPrI-_DY1neqnBI6vtwZlxtlcSK8uaBxx
    FClTnxx6SHQUaJXew>
X-ME-Received: <xmr:a2MkZd8AR4tShPz3vpDAzLQxgo_zKTVVuXvthKZAwByt2tRLp0u-uv0PaAgdZiwoVfXagmLn2wjmGdpsraeLmZr_QUCJXVvZbPRvzR4C5sUeIu8_VEIuTeDO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheefgdduhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpedtgffhtd
    etledtkeeihfefueeuhedvudfhvdeifeevtdektdetgfeiieejuefhtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
    htrdgtohhm
X-ME-Proxy: <xmx:a2MkZRole4xCL4y7dbo4nCkPKaTJ5Biin5xKqlZLvwWRwrrdnro5Qw>
    <xmx:a2MkZWrs_2-5SGgXAb4NThbbCa9K4QiD8LtWeE211BsXQvfxfBMNMA>
    <xmx:a2MkZXSB_fyD-ml_c4raEJFn9Se0QGwerLpsZu96LpeGExVkFnYSJw>
    <xmx:a2MkZXdMVirKhVCTbzS6phbxkP0-BITuzcHOvIPMAVZfRFufF5KJMQ>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Oct 2023 16:32:42 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: [PATCH 0/1] Large folio migration fix and questions on migration stats
Date:   Mon,  9 Oct 2023 16:32:30 -0400
Message-ID: <20231009203231.1715845-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.42.0
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

I am adding support for >0 folio compaction and find the
VM_BUG_ON(!list_empty(&cc->migratepages)) in compact_zone() can be triggered
when a large folio is tried to be migrated, split, and its split base
pages are not migrated. The fix is in patch 1. In the upstream tree,
large folios can be migrated via move_pages() syscall and there is no
VM_BUG_ON in do_move_pages_to_node() but pages left in the source page
list will not be returned to LRU lists. This is from my code inspection
and I have not reproduced it on upstream tree yet.

In addition, I wonder if we need to add any large folio migration stats in
addition to existing THP migration stats, at least for large folio split
stats. Otherwise, large folio migrations seem to happen without any
notice.

Thanks.

Zi Yan (1):
  mm/migrate: correct nr_failed in migrate_pages_sync()

 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--=20
2.42.0

