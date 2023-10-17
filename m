Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C56D7CC5A8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343996AbjJQONg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbjJQONf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:13:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14D4EA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qv/q2jRKci67EaYvl/g4SHwh75inWamJyzD52C/KScw=; b=WPjVQWPS1dqhKQcMI092Amozl0
        FxIDiWFEaM4K6LIk3eNIrWJ5ifOT0DCEh54B2/LU96oJgXTq0GrIx1GT8i2ObY1uAjCS0Olrx2I7l
        8yNF0RotJAsKSqQiGz2CqMLa2gwHhgG4pSldGjmboxM3FIhHFh20CoLkqzpu3ahhkUnNAhooXI83N
        ao98iKQsdnpCZ+F9n1cuW0GCRw1ooud6oldRdZmzWP0w/+gRN/Gut+ggGzfAx/Tj1ykCEXqDON/0Z
        0Ig7Amn/dzjOzesO5mP0SnZkomrdznP3y6SGlYkiQ8O4P1S4PuWCtcpG4P/xHp6RKBAx1kkLObVbJ
        5wKLSfzQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qskp4-00CmCC-Uh; Tue, 17 Oct 2023 14:13:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6277230047C; Tue, 17 Oct 2023 16:13:26 +0200 (CEST)
Date:   Tue, 17 Oct 2023 16:13:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     syzbot <syzbot+f78380e4eae53c64125c@syzkaller.appspotmail.com>,
        Benjamin Segall <bsegall@google.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [syzbot] [kernel?] possible deadlock in console_flush_all (2)
Message-ID: <20231017141326.GB1599@noisy.programming.kicks-ass.net>
References: <000000000000e40a2906072e9567@google.com>
 <CANp29Y61NUOC1CDOzNs_euoFCG-tX1TGFEfro2PuvBEhGqEC3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANp29Y61NUOC1CDOzNs_euoFCG-tX1TGFEfro2PuvBEhGqEC3Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 12:06:12PM +0200, Aleksandr Nogikh wrote:
> This is currently causing more than 50% daily crashes on syzbot:
> 
> https://syzkaller.appspot.com/upstream/graph/crashes
> 
> It began to appear after next-20231004. Judging by the diff between
> next-20231003 and next-20231004, it looks like quite a few changes to
> kernel/sched were merged in between. Could it be caused by any of
> those?

> > EEVDF scheduling fail, picking leftmost

That was in next for a little bit, can you still reproduce with current
next?
