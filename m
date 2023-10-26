Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DBE7D7A12
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 03:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjJZBVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 21:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjJZBVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 21:21:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A88ABD;
        Wed, 25 Oct 2023 18:21:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD97C433C9;
        Thu, 26 Oct 2023 01:21:30 +0000 (UTC)
Date:   Wed, 25 Oct 2023 21:21:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the ftrace tree
Message-ID: <20231025212126.689c6088@gandalf.local.home>
In-Reply-To: <20231026121816.401d2723@canb.auug.org.au>
References: <20231023133033.5d54f393@canb.auug.org.au>
        <20231026121816.401d2723@canb.auug.org.au>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 12:18:16 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> On Mon, 23 Oct 2023 13:30:33 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > 
> > After merging the ftrace tree, today's linux-next build (powerpc
> > ppc64_defconfig) failed like this:
> > 
> > arch/powerpc/kernel/setup-common.c:604:10: error: 'struct seq_buf' has no member named 'readpos'
> >   604 |         .readpos = 0,
> >       |          ^~~~~~~
> > arch/powerpc/kernel/setup-common.c:604:20: error: excess elements in struct initializer [-Werror]
> >   604 |         .readpos = 0,
> >       |                    ^
> > arch/powerpc/kernel/setup-common.c:604:20: note: (near initialization for 'ppc_hw_desc')
> > cc1: all warnings being treated as errors
> > 
> > Caused by commit
> > 
> >   d0ed46b60396 ("tracing: Move readpos from seq_buf to trace_seq")
> > 
> > I have used the ftrace tree from next-20231020 for today.  
> 
> This is still failing ...
> 

Ah, I never pushed it up from trace/for-next to for-next. Thanks for the reminder.

I'll do that now.

-- Steve
