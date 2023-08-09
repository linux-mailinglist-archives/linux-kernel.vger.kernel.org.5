Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B92776C21
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjHIWZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjHIWZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:25:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DC2B2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3GN7LGqdTr6CnPW49m5sqS19cT6QuH9Su23vIXkae5w=; b=5Fk7ox2QmkiMrKU0ZB8zJUPTYo
        3WYsHKPT/uZuXI8/Y+uOeJxlN3kWfZLRXEI/kzk0VXO7aqmoGqjokWX2sTffmaKJ4gHYTWaBxoRr9
        cyTz27W1C1FGj44jDUKLVBp2C4PiCry3ZlzmBOa4r4XIDl/Xahr/96c60GoNlYaXkrLr7byGjt0FO
        /HZwh2zEirA+Olxz+Vl1bjIqZmYjUl22a/ILFZrNOZWAeEkZ5EvecldCNhv4YhZH6EBOlgmOviQnq
        SQ85bIR5WlOpUlv4Jce0PLiDUgvPrslN2dMSdSLcJzq6odEXxDD8RnSUHX2TtcR82G4GhAmRodwXx
        JDX8Xa8g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qTrcF-005zKr-2x;
        Wed, 09 Aug 2023 22:25:19 +0000
Date:   Wed, 9 Aug 2023 15:25:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Dylan Jhong <dylan@andestech.com>
Subject: Re: [PATCH -fixes] mm: Add a call to flush_cache_vmap() in vmap_pfn()
Message-ID: <ZNQSTw4uoksSMYB5@infradead.org>
References: <20230809164633.1556126-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809164633.1556126-1-alexghiti@rivosinc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 06:46:33PM +0200, Alexandre Ghiti wrote:
> flush_cache_vmap() must be called after new vmalloc mappings are
> installed in the page table in order to allow architectures to make sure
> the new mapping is visible.

Looks good.  I somehow vaguely remember seing a patch like this floating
around before as part of a series, but if that didn't make it it
certainly should now.

Reviewed-by: Christoph Hellwig <hch@lst.de>
