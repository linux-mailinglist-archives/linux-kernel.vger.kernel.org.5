Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48677B6823
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239955AbjJCLkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240621AbjJCLkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:40:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADA2DD
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 04:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0hVrByY9OZMwSDVH4NovQCWUi18feulbnZSSWENahGo=; b=hSVvXxhnluuBkQzvcowECzcZFw
        tYY0dT4IQ7hyJCFF4qhBYq3cYI2yhXvGfhlBkxAdxO6RWGgStz33lCrIT5N/eWO1+gANcwuxROBhs
        OuBiGuhXxWcToFjgeCs/oUNPU/FCAcnQl2I0lIaiD1L10SqCS7ZjwxZkLMM5E36hGOgSwWJmrkKxF
        39IxjbYKBloEF9hcCDCQuCS7ESqNcx453xtfd1mbehjMkLwXeiNSDgUsd6Oogc0Qej6k7Regmjy9d
        YzHs0ftfUxyqY4Axkr94WYVfciIe4QtfZXRDeA4oRGwapuKy2jVBW+wMZeNgJ6KcJsf4D6v83yFBX
        PmNROhpw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qndkv-00EmKj-A6; Tue, 03 Oct 2023 11:40:01 +0000
Date:   Tue, 3 Oct 2023 12:40:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Juntong Deng <juntong.deng@outlook.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, lstoakes@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+e295147e14b474e4ad70@syzkaller.appspotmail.com
Subject: Re: [PATCH] pagevec: Add remaining space check before adding folio
 to batch.
Message-ID: <ZRv9kXspdAZ5OamD@casper.infradead.org>
References: <VI1P193MB0752429AFF2B87041B0D9E2799C4A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1P193MB0752429AFF2B87041B0D9E2799C4A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 05:18:52PM +0800, Juntong Deng wrote:
> Currently there is no check for remaining space before adding folio to
> batch, which means that folios can still be added via folio_batch_add()
> when the batch is full and cause errors.

No.  This is an ntfs3 error.  It corrupted the stack.  You can't fix
this in pagevec.  Ignore all syzbot treports that involve ntfs3.
