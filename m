Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04847867A2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 08:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240185AbjHXGmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 02:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240155AbjHXGlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 02:41:24 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A40F610FD;
        Wed, 23 Aug 2023 23:41:21 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 37O6eYn8017295;
        Thu, 24 Aug 2023 08:40:34 +0200
Date:   Thu, 24 Aug 2023 08:40:34 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Christian Brauner <brauner@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Zhangjin Wu <falcon@tinylab.org>
Subject: Re: linux-next: manual merge of the nolibc tree with the vfs-brauner
 tree
Message-ID: <ZOb7Ynd8vjC/kygl@1wt.eu>
References: <20230824141008.27f7270b@canb.auug.org.au>
 <3028a552-bd75-4ded-9211-62d10768d9ea@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3028a552-bd75-4ded-9211-62d10768d9ea@t-8ch.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 08:27:21AM +0200, Thomas Weißschuh wrote:
> Hi everybody,
> 
> On 2023-08-24 14:10:08+1000, Stephen Rothwell wrote:
> > Today's linux-next merge of the nolibc tree got a conflict in:
> > 
> >   tools/testing/selftests/nolibc/nolibc-test.c
> > 
> > between commit:
> > 
> >   49319832de90 ("selftests/nolibc: drop test chmod_net")
> > 
> > from the vfs-brauner tree and commit:
> > 
> >   148e9718e2a2 ("selftests/nolibc: add chmod_argv0 test")
> > 
> > from the nolibc tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> 
> This is fallout from the recent removal of
> "selftests/nolibc: drop test chmod_net" from the nolibc tree.
> 
> Christian:
> 
> You mentioned before that you plan to have this series in
> -next for some time. If you only submit it to Linux for 6.7 or later
> then you have to, if I understand the process correctly, rebase your
> -next branch on Linus' master after 6.6-rc1.
> 6.6-rc1 should contain the conflicting nolibc changes, so you would need
> to resolve the conflict during rebasing.
> The patch is intentionally made to be easy to resolve conflicts for,
> just delete the line containing "CASE_TEST(chmod_net)".
> 
> Everyone:
> 
> What is your opinion on that?

I think that if Stephen is okay with temporarily carrying the small fix
he has (which is correct), it could be the simplest way to resolve it
until the branches are merged. Otherwise we can try to adjust again.

Cheers,
Willy
