Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1897DA7E2
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 17:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjJ1P44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 11:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJ1P4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 11:56:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C296CE1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 08:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=fXN5QmDxRcC9PlWGir13GkiD3PUEUiOPSu3HdRVFd6c=; b=cLOfh4GW1bLPZcygMnf+MkOebK
        NJ54b86vclK2VBNyqW9MzYvrgxrZ8q6v6lghitLHvpYBF0Qo7EnZ8XWH6sxh3xaF4BGNP1yzDW4/4
        ns1MHGSjJ8xvSP9+rYWEEA17io5vOVw7i1reA4ft7bNkDQI0EZ9/Ya5lVtmz8CCC/glvUseqRlTN6
        Qv7t6LVKY34eO3qku476a2UKDOUHo9LR/ZNclFISKFeKUq97cwpahZPsKz9lMYHgqxGGg2PfYDn3H
        3AvQ7iF46UDKLUlprYRiMhwiPO1F2zKrjXQs1vbP0tVuzOxskqcv0rdeSRHOnZbFXk/4N7v908ZUY
        qfqpW/5A==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qwlg8-000cnM-20;
        Sat, 28 Oct 2023 15:56:50 +0000
Date:   Sat, 28 Oct 2023 17:56:41 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping fix for Linux 6.6
Message-ID: <ZT0vORvO7dAaHPvj@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 4f82870119a46b0d04d91ef4697ac4977a255a9d:

  Merge tag 'mm-hotfixes-stable-2023-10-24-09-40' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm (2023-10-24 09:52:16 -1000)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.6-2023-10-28

for you to fetch changes up to d5090484b021794271280ab64d20253883b7f6fd:

  swiotlb: do not try to allocate a TLB bigger than MAX_ORDER pages (2023-10-25 16:26:20 +0200)

----------------------------------------------------------------
dma-mapping fix for Linux 6.6

 - reduce the initialy dynamic swiotlb size to remove an annoying but
   harmless warning from the page allocator (Petr Tesarik)

----------------------------------------------------------------
Petr Tesarik (1):
      swiotlb: do not try to allocate a TLB bigger than MAX_ORDER pages

 kernel/dma/swiotlb.c | 5 +++++
 1 file changed, 5 insertions(+)
