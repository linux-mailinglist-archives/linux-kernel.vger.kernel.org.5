Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221647C77C7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 22:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442748AbjJLUSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 16:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347396AbjJLUSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 16:18:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1768106
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 13:18:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BE7C433C7;
        Thu, 12 Oct 2023 20:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697141899;
        bh=qBg3AzCpocS368uNrU/3ECKHPKqpKyGfsEnXrND/19I=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HwFbLsOo6GvDC2lZoii3xGwirR6wySTZ9Hl7fAX3a9DFj3QE6vg22YiSHkH2h2MUn
         Insg+kHpu3X8CgWKE5Er5oOH/DTi/dpnY8LTIH+NuLBCBC946s7WBvQCCtH+h63rO1
         jFMnPzXA76G+bxC5CbKlLrzH3KG0AYSrQraJUfOZQNPImwnBFJn1coa0T+kdNx1uYK
         PMa/79oMgE9op95x8757I4+tMMgDhNY6/XOv6DQJtRp+n0Df4Nl2j4b+IFXKstXoVB
         LLgbWMwKzToqYM5+UYSuoGJ41ANt04+gSTLKKgErbzZB5bNAwYbLAqxzfIJscCoTn7
         bn0n9zpflnbYQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D78A8CE096F; Thu, 12 Oct 2023 13:18:18 -0700 (PDT)
Date:   Thu, 12 Oct 2023 13:18:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Willy Tarreau <w@1wt.eu>, Zhangjin Wu <falcon@tinylab.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: add tests for multi-object linkage
Message-ID: <0c8446a7-473d-49bc-9413-d1b9176f13b1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231012-nolibc-linkage-test-v1-1-315e682768b4@weissschuh.net>
 <ZSea+etQwlxbi+Ok@1wt.eu>
 <bfc17e76-fcbc-4ce6-97a8-c1ed72ed2a67@t-8ch.de>
 <33e9afcd-a1cd-4f67-829b-85c86500a93e@paulmck-laptop>
 <b278a643-3761-4699-bafc-df1b7245b8c2@t-8ch.de>
 <ca67eb2c-3918-4a1f-b3e6-2023fda5d6a3@paulmck-laptop>
 <6b66305f-8172-463e-a50d-324c0c33a6ea@t-8ch.de>
 <a5f1a910-dbac-44d8-b9f6-5725bea948b2@paulmck-laptop>
 <aa77a065-fcc9-4d3a-8531-fd994587c48f@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa77a065-fcc9-4d3a-8531-fd994587c48f@t-8ch.de>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 09:34:53PM +0200, Thomas Weißschuh wrote:
> On 2023-10-12 12:06:33-0700, Paul E. McKenney wrote:
> > On Thu, Oct 12, 2023 at 08:39:14PM +0200, Thomas Weißschuh wrote:
> > > On 2023-10-12 11:25:02-0700, Paul E. McKenney wrote:
> > > > [..]
> 
> > > > I have a signed tag urgent/nolibc.2023.10.12a in the -rcu tree, so
> > > > please check the lead-in text for sanity.  (Everything after the digital
> > > > signature is automatically generated.)
> > > 
> > > Looks good. But it's only a listing of the commit subjects, correct?
> > 
> > Pretty close, just a few added words on the last one.
> > 
> > So the question is whether there is some larger issue that Linus should
> > be made aware of.  If these are just simple fixes for simple bugs,
> > we should be good, but yes, I do need to ask.  ;-)
> 
> These are simple fixes for simple bugs.
> 
> Do you always have to ask specifically or can I just mention it in the
> pull request in the future?

I would be extremely happy to simply copy text from the pull request
into the signed tags.  ;-)

We would just need to agree on the format.  For example, in this case,
there will eventually be two signed tags, one for the urgent pull
request early next week and another for the pull request for the upcoming
merge window.

Proposals for the format?

> > [..]
> 
> > > > Ah, and have these been posted to a public mailing list?  If not, then I
> > > > need to send them out.
> > > 
> > > All patches went through the lists as part of the normal developent
> > > flow. They were not posted after rebasing.
> > 
> > I have been sending the group, so I might as well continue the tradition.
> 
> Sounds good. If you want me to do something different, please let me
> know.
> 
> > There are a couple of substantive checkpatch complaints:
> > 
> > 4b4a30ea14d1 ("tools/nolibc: i386: Fix a stack misalign bug on _start")
> > 	The Fixes SHA-1 should be limited to 12 hex digits.
> > 	(I am ignoring this, but be prepared for Linus to gripe.
> > 	If you decide to fix it, I would be happy to repull.)
> 
> Done.

Very good, thank you!

> > f2c7923763da ("selftests/nolibc: add tests for multi-object linkage")
> > 	nolibc-test-linkage.c and nolibc-test-linkage.h need
> > 	"//" comment for the SPDX comment header.  This one needs
> > 	to be fixed, but this is not in the urgent stack, so there
> > 	is some time.
> 
> nolibc limits itself intentionally to C89 language level which disallows
> C++ style headers.
> 
> This should be covered by Documentation/process/license-rules.rst:
> 
>   If a specific tool cannot handle the standard comment style, then the
>   appropriate comment mechanism which the tool accepts shall be used.

I stand corrected, and thank you!

> With that said:
> 
> Please pull the changes since the v6.6-rc1 tag from
> https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git/
> 
> The branch 'fixes' up to and including
> 921992229b1f06df6b649860e4a5f3def1489866 for the v6.6 cycle.
> 
> The branch 'next' up to and including
> b8c60e8fc6f755c2cdf7164931afdbfa670c6646 for linux-next.
> 
> No full test has been performed as only a commit message was changed.
> 
> Testing for full nolibc stack:
> make run:             162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> make run-nolibc-test: 162 test(s): 160 passed,   2 skipped,   0 failed => status: warning

I will pull this in, thank you!

							Thanx, Paul
