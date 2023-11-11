Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641D37E8982
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 07:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjKKGZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 01:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjKKGZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 01:25:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC011BD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 22:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EBZKrJAdeTHdt+fXmPtrVcfH5epTVqfv+vgHAQN0udk=; b=I3f8kNkpX208PMuq0FCBAZZdrB
        Chyn3Q0cPxHanUM/v6cHMmBqBrKuWzuQtps8SQcSe5eK+ZgJwZX7nD1ECilSkkW1GIQg4bPgstWqj
        55N9u6n2NB+4jB8hvwu++rnToycTHLCXEj1qX1/6wKJm7LsN1F7vR8jd/87qzd6HfS0avj7o1n3zA
        dr07QpktvS228chaHGx92w4I4QsvVvc7NjMzieSWFL0sBR2lncROC+WEaRKDBF0UILFemM2m5JHRb
        Dp6SYJZxGwLI4zIRMVeIrhrLKGg9WMxd+v/ZhSRQaO6K/O00RqPsKMno5tGMzjYYkVchXzXh1O3Sc
        cfDbCG1A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r1hQb-000NKL-9A; Sat, 11 Nov 2023 06:25:09 +0000
Date:   Sat, 11 Nov 2023 06:25:09 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Zhiguo Jiang <justinjiang@vivo.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v2 1/1] mm: ALLOC_HIGHATOMIC flag allocation issue
Message-ID: <ZU8eRWQvk/Mm4VHO@casper.infradead.org>
References: <20231109073133.792-1-justinjiang@vivo.com>
 <20231109073133.792-2-justinjiang@vivo.com>
 <20231109094954.dd4b2a5b1f5dfcc9a721edba@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109094954.dd4b2a5b1f5dfcc9a721edba@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 09:49:54AM -0800, Andrew Morton wrote:
> On Thu,  9 Nov 2023 15:31:33 +0800 Zhiguo Jiang <justinjiang@vivo.com> wrote:
> 
> > Add a new bool* argument to pass return flag instead of *alloc_flags
> > and add the related comments.
> 
> Please retain (and update) the changelog with each version of a patch.
> 
> For reviewers (please), here's the v1 changelog:

This patch isn't diffed against the current tree.  It can't be reviewed.

