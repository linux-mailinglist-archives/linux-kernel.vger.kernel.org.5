Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205B377867F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 06:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjHKE2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 00:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjHKE2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 00:28:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B696B2696
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 21:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dgkXBhhGOK+N9g5kHizVj2PkllTyXLaTugwbboJFVoA=; b=MbI9sXS/mzMQEALl8vBmWra+io
        MmiHXgUQBJ21mfNebzgn9BpdN6QUqmZt5nuwcZsfijD7nWK38gUwZ6G+din5P84q8wxCOwOyXFeLn
        j7wVQ5DBC9tAMQpwzObMzv/7z1XwfIO418Ob+AT9Sdm8mgzszsh1j/6ApVKYA8cu0rYY8hKJWUZ+t
        YdbCxk5b0HyYvDr1RajyHzbXHTDa2bky5d1KsP0wERoo8wedIquFNJcylcJdW3410szCV5ORPQHyh
        dQaNXFwHrwIXk9/ronjbkOCjb+HHawNGyjDr3Oq3ylhRyX83oGyKzdLgGGdWHBFOYXvn9JztbBDkj
        XRUrFt9w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qUJlT-00Gdqa-BP; Fri, 11 Aug 2023 04:28:43 +0000
Date:   Fri, 11 Aug 2023 05:28:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com
Subject: Re: [PATCH 1/2] mm/page_alloc: remove unnecessary inner
 __get_pfnblock_flags_mask
Message-ID: <ZNW4++rQC5V9qKi6@casper.infradead.org>
References: <20230811115945.3423894-1-shikemeng@huaweicloud.com>
 <20230811115945.3423894-2-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811115945.3423894-2-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 07:59:44PM +0800, Kemeng Shi wrote:
> Function get_pfnblock_flags_mask just calls inline inner
> __get_pfnblock_flags_mask without any extra work. Just opencode
> __get_pfnblock_flags_mask in get_pfnblock_flags_mask and replace call
> to __get_pfnblock_flags_mask with call to get_pfnblock_flags_mask to
> remove unnecessary __get_pfnblock_flags_mask.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

This could have happened at any time after 535b81e20921 (and arguably
should have happened as part of it)
