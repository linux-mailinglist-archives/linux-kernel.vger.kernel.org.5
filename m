Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB997D0399
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 23:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346557AbjJSVSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 17:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjJSVSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 17:18:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5E0113
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 14:18:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7AAC433C7;
        Thu, 19 Oct 2023 21:18:19 +0000 (UTC)
Date:   Thu, 19 Oct 2023 17:18:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, Christoph Hellwig <hch@lst.de>,
        Justin Stitt <justinstitt@google.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 0/1] Put seq_buf on a diet
Message-ID: <20231019171746.3da43332@gandalf.local.home>
In-Reply-To: <20231019171439.1c50a16e@gandalf.local.home>
References: <20231019194514.2115506-1-willy@infradead.org>
        <20231019171439.1c50a16e@gandalf.local.home>
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

On Thu, 19 Oct 2023 17:14:39 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 19 Oct 2023 20:45:13 +0100
> "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> 
> > Prompted by the recent mails on ksummit, let's actually try to make this
> > work this time.  We need a container for manipulating strings easily,
> > and seq_buf is the closest thing we have to it.  The only problem I have
> > with it is the readpos that is only useful for the tracing code today.
> > So move it from the seq_buf to the tracing code.
> > 
> > We should go further with this patch series, including using seq_buf
> > within vsprintf, but if we can't get over this hurdle first, I'm not
> > going to waste my time on this again.
> > 
> > Matthew Wilcox (Oracle) (1):
> >   trace: Move readpos from seq_buf to trace_seq
> > 
> >  include/linux/seq_buf.h   |  5 +----
> >  include/linux/trace_seq.h |  2 ++
> >  kernel/trace/trace.c      | 10 +++++-----
> >  kernel/trace/trace_seq.c  |  6 +++++-
> >  lib/seq_buf.c             | 13 +++++--------
> >  5 files changed, 18 insertions(+), 18 deletions(-)
> >   
> 
> Thanks Matthew, I'll pull this in and add it to my for-next queue (after
> testing)

Actually,

Can you resend it, and Cc: linux-trace-kernel@vger.kernel.org so that it
goes into patchwork.

Thanks!

-- Steve

