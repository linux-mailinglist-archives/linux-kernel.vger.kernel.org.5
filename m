Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B3279C32E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239519AbjILCmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237847AbjILCmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:42:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC92107C52
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 19:07:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD24C433B6;
        Mon, 11 Sep 2023 21:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1694466575;
        bh=y2UYJ9xO0/iU8CVs2qutTCIZNaR/yPIdNWIpjtYqvS0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fHVl2kE0nI05eFV42Myffm5EGR1WdFEyEv0Zy7Hw+qCXrVE6NOwd5MDtDlFL+cvK+
         EjiDK8VqsxcMhxo84Kzour//v7cOwVUl+6cTZJGEs/NmrvQmdfc1f5CNibK8/FCxyL
         PQkObg5WLmMgXYUaFy/HIHaL1mN+foNviQCXg8zI=
Date:   Mon, 11 Sep 2023 14:09:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] mm: page_alloc: remove pcppage migratetype caching
Message-Id: <20230911140934.4fb3cb429fd1b4623c68e3c8@linux-foundation.org>
In-Reply-To: <931839F8-3D9B-4203-9FD1-BDAF998B3C97@nvidia.com>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
        <20230911195023.247694-2-hannes@cmpxchg.org>
        <931839F8-3D9B-4203-9FD1-BDAF998B3C97@nvidia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2023 15:59:43 -0400 Zi Yan <ziy@nvidia.com> wrote:

> > A side effect is that this also ensures that pages whose pageblock
> > gets stolen while on the pcplist end up on the right freelist and we
> > don't perform potentially type-incompatible buddy merges (or skip
> > merges when we shouldn't), whis is likely beneficial to long-term
> 
> s/whis/this

Thanks, I did s/whis/which/
