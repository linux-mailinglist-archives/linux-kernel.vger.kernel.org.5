Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3572F7C7609
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441919AbjJLSjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379612AbjJLSjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:39:18 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4DBB7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 11:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1697135955;
        bh=a3nvpY6mqBaBUqBy6qoFGqPWfRmz0UC+DXMizhLUBRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R9BLNfxYR1wohwcx/rNhxbyjh/vdwqbTO57kMyT9ZwXlMNmdtShUUU9ARj/qkR+DU
         gsfK0d/v5788TkdRcUnQ3poO4OckihQnDwrJbMGwge9ct8ShOb9wMRltVZkefw3pgy
         rLp/ZwBtrbyn688um6PzXAuclNp1oWC7Qro81OmQ=
Date:   Thu, 12 Oct 2023 20:39:14 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Willy Tarreau <w@1wt.eu>, Zhangjin Wu <falcon@tinylab.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: add tests for multi-object linkage
Message-ID: <6b66305f-8172-463e-a50d-324c0c33a6ea@t-8ch.de>
References: <20231012-nolibc-linkage-test-v1-1-315e682768b4@weissschuh.net>
 <ZSea+etQwlxbi+Ok@1wt.eu>
 <bfc17e76-fcbc-4ce6-97a8-c1ed72ed2a67@t-8ch.de>
 <33e9afcd-a1cd-4f67-829b-85c86500a93e@paulmck-laptop>
 <b278a643-3761-4699-bafc-df1b7245b8c2@t-8ch.de>
 <ca67eb2c-3918-4a1f-b3e6-2023fda5d6a3@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca67eb2c-3918-4a1f-b3e6-2023fda5d6a3@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-12 11:25:02-0700, Paul E. McKenney wrote:
> [..]

> > Please pull the changes since the v6.6-rc1 tag from
> > https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git/
> > 
> > The branch 'fixes' up to and including
> > 90864f0679fdbb3b2e1c3bdbe4b0a34df785cb0a for the v6.6 cycle.
> > 
> > The branch 'next' up to and including
> > f2c7923763dae51226584494722349fef4df3748 for linux-next.
> > 
> > The branch 'next', based upon 'fixes', was tested as follows:
> > 
> > i386:          162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> > x86_64:        162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> > arm64:         162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> > arm:           162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> > mips:          162 test(s): 161 passed,   1 skipped,   0 failed => status: warning
> > ppc:           162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> > ppc64:         162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> > ppc64le:       162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> > riscv:         162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> > s390:          162 test(s): 161 passed,   1 skipped,   0 failed => status: warning
> > loongarch:     162 test(s): 161 passed,   1 skipped,   0 failed => status: warning
> 
> I have a signed tag urgent/nolibc.2023.10.12a in the -rcu tree, so
> please check the lead-in text for sanity.  (Everything after the digital
> signature is automatically generated.)

Looks good. But it's only a listing of the commit subjects, correct?

> Testing for urgent/nolibc.2023.10.12a:
> make run: 160 test(s): 160 passed,   0 skipped,   0 failed => status: success
> make run-user: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning
> 
> Testing for full nolibc stack:
> make run: 162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> make run-user: 162 test(s): 160 passed,   2 skipped,   0 failed => status: warning
> 
> > > But after about Wednesday of next week, getting things into the upcoming
> > > merge window is pretty much as fast as sending them quickly to Linus,
> > > if that makes sense.  Unless there is to be a -rc8 this time, but I
> > > have heard no sign of that.
> > > 
> > > Make sense?
> > 
> > Sure, hopefully no more fixes are needed!
> 
> Ah, and have these been posted to a public mailing list?  If not, then I
> need to send them out.

All patches went through the lists as part of the normal developent
flow. They were not posted after rebasing.

For transparency I did the following follow-up changes:

* The rebase of "tools/nolibc: mark start_c as weak" required some
  minor changes to resolve conflicts.
* reword the message of
  "tools/nolibc: drop test for getauxval(AT_PAGESZ)" slightly.
* simplify the includes intruduced by
  "selftests/nolibc: add tests for multi-object linkage".

> We reset the -next testing clock, so if all goes well, then I send the
> three urgent commits to Linus on Monday.

Sounds good, thanks!

Thomas
