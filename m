Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAAB754678
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 05:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjGODOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 23:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGODOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 23:14:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BD635BD
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 20:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rzzcvrMOZmLVJ3qqStCtg2gxmWnvYjv7H4zS+C4FIDY=; b=Sb7I+uOzGR99xPAR8LAErP730X
        Z8e1zIay5znOBrHBHXZom0u0uBbafOb9DATBYqK5lzNYQyBI0eeY18elonLDyLCKM+57aiZl71qXN
        i46XEAHq+li/aWDJbuECA8XTMmMC+UeTadV159WB7UpoFW9hOQI9F0bKIOGpdI4IrlxfpE1hkefZZ
        jwVliNT4jvjFTP5sgssUcpIkvhd6EuJU4bit65WevOiHb6VxuhDDuf16pcy7dc19XL2Kim2oeMPNI
        b5Zw6aJFrsOJDM2ahcn5kHp+HvAIWjv8NNapWy9T/KSQ7y6858TqKueNaw5cxbI7ssrMi6F1InTU0
        Z9wF700g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qKVjh-001lqt-23; Sat, 15 Jul 2023 03:14:21 +0000
Date:   Sat, 15 Jul 2023 04:14:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Tom Rix <trix@redhat.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shmem: set variable shmem_mark_dquot_dirty and
 shmem_dquot_write_info storage-class-specifier to static
Message-ID: <ZLIPDVIw/6cZfKrz@casper.infradead.org>
References: <20230714215113.3919026-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714215113.3919026-1-trix@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 05:51:13PM -0400, Tom Rix wrote:
> smatch reports
> mm/shmem_quota.c:318:5: warning: symbol 'shmem_mark_dquot_dirty'
>   was not declared. Should it be static?
> mm/shmem_quota.c:323:5: warning: symbol 'shmem_dquot_write_info'
>   was not declared. Should it be static?
> 
> These variables are only used in their defining file, so it should be static.

These are functions, not variables, and you're the third person to send
this patch today.
