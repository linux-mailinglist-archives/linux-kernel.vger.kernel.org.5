Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F62D7B44D4
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 02:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbjJAAiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 20:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjJAAiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 20:38:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34760D3;
        Sat, 30 Sep 2023 17:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=MgPUZu5lJ2mnvysZdGu2Kc1b7RZofo72Va4okUfyrCQ=; b=Ob5YNP+BeMVGp1+WORUo6wyT3r
        nXWuhetfvuluA+OOZ6++X9e1KBQVYrek64A1gAO8ppWpcGI7dDukk2oA59ATyRxvtlpkq76QdMpT6
        y6CxcSGnp0duFCVe+k8aHrF5Hz4lV1YV1ECG0IS4w6sR0V1p4sL1x0ka98W2Qy4r2O4zAxg+rN7ix
        G6xTRXVnOgwu06JxyMQBbzPce0kWEei6MdcS7zTjmUOPNDcpLAG+TFPsRoO/7p5nLtsdt0Ufwc/Iv
        /uOqu5Ea0FfKG8iQv6mfFXf0rGLVYp0+IOWrsff7SAKDITOZpAJrEAHbx4SSD004YzR5GegLwvTcB
        0jYTmRFg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qmkTv-00AI3H-0l;
        Sun, 01 Oct 2023 00:38:47 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] page_pool: fix documentation typos
Date:   Sat, 30 Sep 2023 17:38:45 -0700
Message-ID: <20231001003846.29541-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct grammar for better readability.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 include/net/page_pool/helpers.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -- a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -16,13 +16,13 @@
  * page_pool_alloc_pages() call.  Drivers should use
  * page_pool_dev_alloc_pages() replacing dev_alloc_pages().
  *
- * API keeps track of in-flight pages, in order to let API user know
+ * The API keeps track of in-flight pages, in order to let API users know
  * when it is safe to free a page_pool object.  Thus, API users
  * must call page_pool_put_page() to free the page, or attach
- * the page to a page_pool-aware objects like skbs marked with
+ * the page to a page_pool-aware object like skbs marked with
  * skb_mark_for_recycle().
  *
- * API user must call page_pool_put_page() once on a page, as it
+ * API users must call page_pool_put_page() once on a page, as it
  * will either recycle the page, or in case of refcnt > 1, it will
  * release the DMA mapping and in-flight state accounting.
  */
