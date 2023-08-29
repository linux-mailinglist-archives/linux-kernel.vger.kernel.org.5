Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DE678C87C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237229AbjH2PUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237215AbjH2PUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:20:24 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63AEA1A2;
        Tue, 29 Aug 2023 08:20:21 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qb0V8-0001S3-00; Tue, 29 Aug 2023 17:19:30 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 536B4C01D9; Tue, 29 Aug 2023 17:19:18 +0200 (CEST)
Date:   Tue, 29 Aug 2023 17:19:18 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v4 0/4] Modify die() for MIPS
Message-ID: <ZO4Mdr9/XUkXDK9j@alpha.franken.de>
References: <1692434183-2054-1-git-send-email-yangtiezhu@loongson.cn>
 <ZOxkt/6EkQIy+Jkt@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOxkt/6EkQIy+Jkt@alpha.franken.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 11:11:19AM +0200, Thomas Bogendoerfer wrote:
> On Sat, Aug 19, 2023 at 04:36:19PM +0800, Tiezhu Yang wrote:
> > v4:
> >   -- Add BUG() at the end of nmi_exception_handler()
> >   -- Return earlier in die() if notify_die() returns NOTIFY_STOP
> >   -- Update the patch titles and commit messages
> > 
> > v3:
> >   -- Make each patch can be built without errors and warnings.
> > 
> > v2: 
> >   -- Update the commit message to give more detailed info, split into
> >      three individual patches, suggested by Maciej, thank you.
> > 
> > Tiezhu Yang (4):
> >   MIPS: Add BUG() at the end of nmi_exception_handler()
> >   MIPS: Do not kill the task in die() if notify_die() returns
> >     NOTIFY_STOP
> >   MIPS: Return earlier in die() if notify_die() returns NOTIFY_STOP
> >   MIPS: Add identifier names to arguments of die() declaration
> > 
> >  arch/mips/include/asm/ptrace.h |  2 +-
> >  arch/mips/kernel/traps.c       | 15 +++++++++------
> >  2 files changed, 10 insertions(+), 7 deletions(-)
> 
> series applied to mips-next.

I've dropped the series again after feedback from Maciej, that this
still needs more changes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
