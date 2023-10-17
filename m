Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D83B7CC6D8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344242AbjJQOxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344401AbjJQOxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:53:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EF36F8D
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:51:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4841C433C9;
        Tue, 17 Oct 2023 14:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1697554279;
        bh=8QST9rScEh763jZNRI95ZyKqEX0qwnM3d8lkq1pcw6I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H4iWL+pptGDQhWA85o5KX5RrPFhjScdrk3yvR2NjLi2uRCSyeTR2ERxD7lIxUkZoB
         YwlSpNUcRvS9s/siEAJNrtQqttodD+6K+VQ1A15Th5iKEPsOtxiB173S8wld0PSjf3
         7xWSEHEkAmXyDxF4wZfV/1ah5TdxzH3RvLkF1LP8=
Date:   Tue, 17 Oct 2023 07:51:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
        Linux Memory Management List <linux-mm@kvack.org>,
        <willy@infradead.org>, <linux-kernel@vger.kernel.org>,
        <ying.huang@intel.com>, <david@redhat.com>,
        Zi Yan <ziy@nvidia.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH -next v2 17/19] mm: convert wp_page_reuse() and
 finish_mkwrite_fault() to take a folio
Message-Id: <20231017075118.724458634e508729bd1d2683@linux-foundation.org>
In-Reply-To: <b52105b5-3910-46b8-a869-4a82c8a2b845@huawei.com>
References: <20231013085603.1227349-18-wangkefeng.wang@huawei.com>
        <202310171537.XhmrkImn-lkp@intel.com>
        <b52105b5-3910-46b8-a869-4a82c8a2b845@huawei.com>
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

On Tue, 17 Oct 2023 17:04:41 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> >>> mm/memory.c:3276: warning: Function parameter or member 'folio' not described in 'finish_mkwrite_fault'
> > 
> 
> Hi Andrew, should I resend this patch? or could you help me to update
> it, also a comment(page -> folio's) on patch18, thanks.

I'd assumed a new series would be sent, addressing Matthew's comments.
