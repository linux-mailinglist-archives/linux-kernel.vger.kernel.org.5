Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2597AE189
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjIYWJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjIYWJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:09:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D42107
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 15:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eMEfoEC1Ghs4PzxRCt6ZFREgLJm195iq7qGjwxOBxfc=; b=oYMps9DxFuuynyPP5AP0CTgT5C
        yBAxSiS7LtMzwyx0jq3ICE6DH9nOIcIIbFAJMgMxU87E8MR0ZPhrYjSZpavQBSlKSq5IdD1Fe6B5S
        6m1gvYFcTlTWEdGkT+9cDWddHvfuKVTbwssttuVEpmPx9lt9XdTFu+g3VdY32Yp/97CUGYqxeSvG+
        hPTZO4kydKKyD77gt5cLSBIGfoo+LB5rZ6JYUE/tZzjRhNKDB1KjBqQshe3M0lXsIg6s8dmgDV9Mv
        YiwoZNGDYgmE7yZahp5C9QzFi2XHSh5ORPtPgKQ1+nMvG9FZCscH3pphdNNpmw1SA/IKMqX1t+ems
        a3/+WGLA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qktlV-003vbs-VK; Mon, 25 Sep 2023 22:09:18 +0000
Date:   Mon, 25 Sep 2023 23:09:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Christoph Lameter <cl@linux.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 01/12] hugetlbfs: drop shared NUMA mempolicy pretence
Message-ID: <ZRIFDYUokzCtK0oQ@casper.infradead.org>
References: <2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com>
 <47a562a-6998-4dc6-5df-3834d2f2f411@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47a562a-6998-4dc6-5df-3834d2f2f411@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 01:21:10AM -0700, Hugh Dickins wrote:
> hugetlbfs_fallocate() goes through the motions of pasting a shared NUMA
> mempolicy onto its pseudo-vma, but how could there ever be a shared NUMA
> mempolicy for this file?  hugetlb_vm_ops has never offered a set_policy
> method, and hugetlbfs_parse_param() has never supported any mpol options
> for a mount-wide default policy.

Hah.  I was wondering, but never cared enough to investigate.  Thanks
for doing this.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
