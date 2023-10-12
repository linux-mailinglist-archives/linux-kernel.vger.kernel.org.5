Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E8E7C6B83
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347142AbjJLKvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347149AbjJLKvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:51:33 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C83DE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1697107889;
        bh=aj3wyUO+5x3bQ3Eq7y/F6nchqfp9lYII43M6cBU4Khc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XIGLyxO5FglrZGkWnifpvtoU5YYBiVBzGsxxRI+OBIEfA9bJiiVnc1WC/WA8RHXOI
         8Pcb4N4SKf9lHCO6o1xJJVLVE6oWGNAn32AlMQUak2M9Y1+Y7q8Ygzx4+2tHrpZJWB
         gFWynlAYEoRJz2l1tPFI5KWexm6egwU9wYyAR0LM=
Date:   Thu, 12 Oct 2023 12:51:28 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Willy Tarreau <w@1wt.eu>, Zhangjin Wu <falcon@tinylab.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: add tests for multi-object linkage
Message-ID: <b278a643-3761-4699-bafc-df1b7245b8c2@t-8ch.de>
References: <20231012-nolibc-linkage-test-v1-1-315e682768b4@weissschuh.net>
 <ZSea+etQwlxbi+Ok@1wt.eu>
 <bfc17e76-fcbc-4ce6-97a8-c1ed72ed2a67@t-8ch.de>
 <33e9afcd-a1cd-4f67-829b-85c86500a93e@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33e9afcd-a1cd-4f67-829b-85c86500a93e@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-12 03:41:50-0700, Paul E. McKenney wrote:
> On Thu, Oct 12, 2023 at 09:23:29AM +0200, Thomas Weißschuh wrote:
> > Hi Willy, Paul,
> > 
> > On 2023-10-12 09:06:33+0200, Willy Tarreau wrote:
> > > On Thu, Oct 12, 2023 at 01:13:37AM +0200, Thomas Weißschuh wrote:
> > > > While uncommon, nolibc executables can be linked together from multiple
> > > > compilation units.
> > > > Add some tests to make sure everything works in that case.
> > > (...)
> > 
> > [..]
> > 
> > > > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > > > ---
> > > > Note:
> > > > 
> > > > This depends on path "tools/nolibc: mark start_c as weak".
> > > > https://lore.kernel.org/lkml/20231012-nolibc-start_c-multiple-v1-1-fbfc73e0283f@weissschuh.net/
> > > 
> > > For these two patches: Acked-by: Willy Tarreau <w@1wt.eu>
> > 
> > Thanks, applied locally.
> > 
> > I guess the linked patch "tools/nolibc: mark start_c as weak" should
> > also go into nolibc/fixes.
> > 
> > @Paul, would it introduce too much churn for you if I submit another
> > nolibc pull with an updated nolibc/fixes?
> > (And the rebased nolibc/next with this commit while we are at it)
> 
> Not a problem this week!

Great, then:

Please pull the changes since the v6.6-rc1 tag from
https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git/

The branch 'fixes' up to and including
90864f0679fdbb3b2e1c3bdbe4b0a34df785cb0a for the v6.6 cycle.

The branch 'next' up to and including
f2c7923763dae51226584494722349fef4df3748 for linux-next.

The branch 'next', based upon 'fixes', was tested as follows:

i386:          162 test(s): 162 passed,   0 skipped,   0 failed => status: success
x86_64:        162 test(s): 162 passed,   0 skipped,   0 failed => status: success
arm64:         162 test(s): 162 passed,   0 skipped,   0 failed => status: success
arm:           162 test(s): 162 passed,   0 skipped,   0 failed => status: success
mips:          162 test(s): 161 passed,   1 skipped,   0 failed => status: warning
ppc:           162 test(s): 162 passed,   0 skipped,   0 failed => status: success
ppc64:         162 test(s): 162 passed,   0 skipped,   0 failed => status: success
ppc64le:       162 test(s): 162 passed,   0 skipped,   0 failed => status: success
riscv:         162 test(s): 162 passed,   0 skipped,   0 failed => status: success
s390:          162 test(s): 161 passed,   1 skipped,   0 failed => status: warning
loongarch:     162 test(s): 161 passed,   1 skipped,   0 failed => status: warning

> But after about Wednesday of next week, getting things into the upcoming
> merge window is pretty much as fast as sending them quickly to Linus,
> if that makes sense.  Unless there is to be a -rc8 this time, but I
> have heard no sign of that.
> 
> Make sense?

Sure, hopefully no more fixes are needed!

Thanks,
Thomas
