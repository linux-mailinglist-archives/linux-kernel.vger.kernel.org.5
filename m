Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E847A3267
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 22:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbjIPUNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 16:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjIPUNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 16:13:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FB21B5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 13:13:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1561FC433C7;
        Sat, 16 Sep 2023 20:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1694895183;
        bh=UAYiYwiz1QUuo/1OrgH7awbGSA0xwqGi6uf3RFIGe9U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VcGbmb5axXWDHl0ZARVRMyPPmtgkTL8CGsyCs9ko9BceDWU6tqMaktI/GOoQMtHpr
         GJ7zLy/RfTR6csb9NdNfnEVu26JmgPaFJsOMG2dIAn+9STfuYZzNx3aPL2BOBXZt+D
         uMUYRgU69K8sbaWKW/OpXVv8WJc+ivHZmlwF52VU=
Date:   Sat, 16 Sep 2023 13:13:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/6] mm: page_alloc: freelist migratetype hygiene
Message-Id: <20230916131302.252399080ac5b4d983668f7e@linux-foundation.org>
In-Reply-To: <20230916195739.GB618858@monkey>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
        <20230914235238.GB129171@monkey>
        <20230915141610.GA104956@cmpxchg.org>
        <20230916195739.GB618858@monkey>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Sep 2023 12:57:39 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> > So this was purely a sanity check against the pcpmigratetype cache
> > operations. With that gone, we can remove it.
> 
> With the patch below applied, a slightly different workload triggers the
> following warnings.  It seems related, and appears to go away when
> reverting the series.

Thanks, I've dropped this v2 series from mm.git.
