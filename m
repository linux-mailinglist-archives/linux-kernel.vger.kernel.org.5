Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7117CB6BB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 00:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbjJPWzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 18:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjJPWzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 18:55:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4090A83
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:55:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362D9C433C7;
        Mon, 16 Oct 2023 22:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1697496913;
        bh=OHmhqUAqN5yMBaohB5QfpbPKKU2turB5eDOqm+ZWhYI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fikwoOubEAZOwd/HG1+U1G6gObQtm8ydsyAeiTqryWbkbBOiFLecs8XBnSL9dIJ51
         4m5onV5ImF9Ljrzc7OgwQxynvH8PwUhvKTZb9ycCZtfcj62HHkY1U7YWYMz3tXkpKj
         JTzCjylz2G+2ajsIY9nPrytP7G3+ekxGegFbFKq0=
Date:   Mon, 16 Oct 2023 15:55:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>
Subject: Re: [PATCH v2 01/11] hugetlb: set hugetlb page flag before
 optimizing vmemmap
Message-Id: <20231016155512.6e48836f3baef1c899bcae91@linux-foundation.org>
In-Reply-To: <20231013214356.GA245341@monkey>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
        <20230905214412.89152-2-mike.kravetz@oracle.com>
        <20231013125856.GA636971@u2004>
        <20231013214356.GA245341@monkey>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 14:43:56 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> > Could you consider adding some diff like below?
> 
> Thanks!  That case was indeed overlooked.
> 
> Andrew, this patch is currently in mm-stable.  How would you like to update?
> - A new version of the patch
> - An patch to the original patch
> - Something else

I guess just a fixup against what's currently in mm-stable, please.  It
happens sometimes.

Please let's get the Fixes: accurate.  I just had to rebase mm-stable
to drop Huang Ying's pcp auto-tuning series.  I'm now seeing

d8f5f7e445f0 hugetlb: set hugetlb page flag before optimizing vmemmap

which I think is what it used to be, so the rebasing shouldn't affect
this patch's hash.



