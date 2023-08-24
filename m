Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938B07867C4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 08:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240220AbjHXGta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 02:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240216AbjHXGtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 02:49:10 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76ABC10FE;
        Wed, 23 Aug 2023 23:48:51 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 37O6mQ1d017444;
        Thu, 24 Aug 2023 08:48:26 +0200
Date:   Thu, 24 Aug 2023 08:48:26 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: linux-next: manual merge of the nolibc tree with the mm-stable
 tree
Message-ID: <ZOb9OuFh/2pmkRv+@1wt.eu>
References: <20230817133053.76d9f850@canb.auug.org.au>
 <28aeee7b-2de5-4f39-8eb5-3e3486eeed1b@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28aeee7b-2de5-4f39-8eb5-3e3486eeed1b@t-8ch.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Thu, Aug 24, 2023 at 08:41:18AM +0200, Thomas Weißschuh wrote:
> Hi everybody,
> 
> On 2023-08-17 13:30:53+1000, Stephen Rothwell wrote:
> > Today's linux-next merge of the nolibc tree got a conflict in:
> > 
> >   tools/include/nolibc/stdio.h
> > 
> > between commit:
> > 
> >   08d959738a95 ("selftests: line buffer test program's stdout")
> > 
> > from the mm-stable tree and commits:
> > 
> >   65ff4d19f792 ("tools/nolibc/stdio: add setvbuf() to set buffering mode")
> >   2e00a8fc4f47 ("tools/nolibc: setvbuf: avoid unused parameter warnings")
> > 
> > from the nolibc tree.
> >
> > I fixed it up (I just used the latter version of this file) and can
> > carry the fix as necessary. This is now fixed as far as linux-next is
> > concerned, but any non trivial conflicts should be mentioned to your
> > upstream maintainer when your tree is submitted for merging.  You may
> > also want to consider cooperating with the maintainer of the conflicting
> > tree to minimise any particularly complex conflicts.
> 
> how do we want to handle this one?
> 
> A small note to Linus in the PRs to him on how to resolve it seem
> reasonable to me.
> But I'm fairly new to the process.

My understanding is that Stephen's fix is still in his tree. We may indeed
need to add a note to Linus in the PR about this one and the other one.

Cheers,
Willy
