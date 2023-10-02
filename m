Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181247B4B6D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 08:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbjJBG0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 02:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbjJBG0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 02:26:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB36AB
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 23:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=g+PPt0PZHmo02mh9GogQC8Pu3uCPDQcILPNZPjjYZfY=; b=QZLNWR45DDwYvykpS/pQrIHlYn
        mj7UEVifF3CRoZh+GTU2halUtIsz0RFEYT8v08k3nXOiAEWb6eosJrR1EIt5esZpyfH03W+aD7sHu
        WeS0dyqm4vNW9nsi2spY+r5jRN5dQHM5iuiR2vEBTmJMFJYaFeMvoNQmL4kLh/YNkdPuGlWi3S0EB
        DTN+eYNP47lN9MhrB4yfAdYk1lU5gCLLQCmsg4BywY4x7HTAAl4R39FTy26gEJEAABVl/iRaSVRKC
        OeK1gV7NWkwfAA9bwLzfuGLQLAAbvuoOaQHOVIVukzvG/PGFcAi39Szi8XC+ZyFz/dyraN94lxKqU
        9NTJEROw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qnCNm-00C1a2-3B;
        Mon, 02 Oct 2023 06:26:18 +0000
Date:   Sun, 1 Oct 2023 23:26:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] mm/filemap: clarify filemap_fault() comments for not
 uptodate case
Message-ID: <ZRpiiq/pUB6hGTl/@infradead.org>
References: <20230930231029.88196-1-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230930231029.88196-1-lstoakes@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +		 * If the invalidate lock is not held, the folio was in cache and
> +		 * uptodate and now it is not. Strange but possible since we

Please don't spill block comments ôver the 80 charater limit, that makes
them impossible to read nicely.

