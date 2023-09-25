Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778F57AE1AE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjIYW3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjIYW3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:29:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60319C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 15:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vThqe82wFHQYIn4iDqh4uJHLDDFlNPpTiNpJ978Vj4w=; b=Yxyn0YvHU4ijOJFKxi40NVpG6M
        10klXG5q6CbXoKlZpEsiC4AWoeYkjSu132p0eMfW+ZAxsOmDmeYwKI6dNPA3d2tfgkNfSDAKnB2wR
        DjQesKO6BHO4cB0jcWm+aeDhgN67vj8/Rp03RudAOWasWtUB/QGq1Oq1j1mUUkzrMLXS6/HO/ZddY
        +bCIB7v1bXRyyI4Kdpt1rgIGsItdmHsTLkW697DshfEMLKUzq4BbXOZ/yUxTipdnAz7cVv0EIkmm2
        b/gO6ecZMT0m3fmjJUWoS5Yk++88IhoKeBLFGo1JEaO2OjpFFOZi/XG/PXaMjR9tWmiSCjx6HCbKK
        BNMPCCqA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qku4G-0040tr-Jy; Mon, 25 Sep 2023 22:28:40 +0000
Date:   Mon, 25 Sep 2023 23:28:40 +0100
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
Subject: Re: [PATCH 05/12] mempolicy trivia: slightly more consistent naming
Message-ID: <ZRIJmIWQ4WRLkZZ7@casper.infradead.org>
References: <2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com>
 <1a75d3dd-7fa-7a41-c76b-1232198a9a4a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a75d3dd-7fa-7a41-c76b-1232198a9a4a@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 01:26:55AM -0700, Hugh Dickins wrote:
> Before getting down to work, do a little cleanup, mainly of inconsistent
> variable naming.  I gave up trying to rationalize mpol versus pol versus
> policy, and node versus nid, but let's avoid p and nd.  Remove a few
> superfluous blank lines, but add one; and here prefer vma->vm_policy to
> vma_policy(vma) - the latter being appropriate in other sources, which
> have to allow for !CONFIG_NUMA.  That intriguing line about KERNEL_DS?
> should have gone in v2.6.15, when numa_policy_init() stopped using
> set_mempolicy(2)'s system call handler.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

