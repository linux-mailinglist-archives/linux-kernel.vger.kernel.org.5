Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AA17B4BAA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 08:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbjJBGuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 02:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbjJBGuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 02:50:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A837AA6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 23:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Mug5aMcfidDYMYnLFBdtc2pTxr
        SJ3IWkYw6/i4oRKENPp+PpptyT9af4UvLX3RSmEhQku3UBxMy29qLAgER6E9aDcRJSHIeSsL1Hh8p
        rwI05f0/qagVM7nzpBO0uqKvFFgUxL04rszks1q161KD3HpUtsTmA146hBEkS4rn/4XFSFMQBGsk6
        Q25LSaOCWTX09mygURWIK2obhE8NgqmHWbgwBsJUJUZASFK9U141uVEhjt7RpYEgr3zOZ9GUi+0dz
        2Rh6SA65+xVmJnev/wRAIgqMR5PwK/h50swckQxDSVYHZucLWzrDY4Z4NFpyae2rcR1+B+0vBlTe9
        TmWPeS4g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qnCki-00C2fO-0f;
        Mon, 02 Oct 2023 06:50:00 +0000
Date:   Sun, 1 Oct 2023 23:50:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] mm/filemap: clarify filemap_fault() comments for not
 uptodate case
Message-ID: <ZRpoGHYwCtW5SWjR@infradead.org>
References: <20230930231029.88196-1-lstoakes@gmail.com>
 <ZRpiiq/pUB6hGTl/@infradead.org>
 <2c7014c0-6343-4e76-8697-3f84f54350bd@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c7014c0-6343-4e76-8697-3f84f54350bd@lucifer.local>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
