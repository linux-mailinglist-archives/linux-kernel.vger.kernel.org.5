Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B9B7D3A27
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjJWO6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbjJWOo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:44:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EB51704
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:43:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAAF9C433C8;
        Mon, 23 Oct 2023 14:43:43 +0000 (UTC)
Date:   Mon, 23 Oct 2023 10:43:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [for-next][PATCH 5/6] tracing: Move readpos from seq_buf to
 trace_seq
Message-ID: <20231023104341.34c188a5@gandalf.local.home>
In-Reply-To: <ZTZDocwUP9PU39Mg@smile.fi.intel.com>
References: <20231020222713.074741220@goodmis.org>
        <20231020222740.632819967@goodmis.org>
        <ZTZDocwUP9PU39Mg@smile.fi.intel.com>
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

On Mon, 23 Oct 2023 12:57:53 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Oct 20, 2023 at 06:27:18PM -0400, Steven Rostedt wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > To make seq_buf more lightweight as a string buf, move the readpos member
> > from seq_buf to its container, trace_seq.  That puts the responsibility
> > of maintaining the readpos entirely in the tracing code.  If some future
> > users want to package up the readpos with a seq_buf, we can define a
> > new struct then.  
> 
> > Link: https://lore.kernel.org/linux-trace-kernel/20231020033545.2587554-2-willy@infradead.org
> >   
> 
> If we want Link: to be recognized as a tag, we probably should remove the blank
> line. Maybe new versions of b4 support that, but not all maintainers use it and
> AFAIK the convention was to have no blank lines in the tag block.
> 

So I've been using Link tags for over a decade. I originally had it as
part of the tag block, but realized that it's more for humans than bots,
and purposely separated it out. What Link tags are good for IMO is for
humans that are looking at git blame and want to know more content. I
prefer the Link tag to stand out so that it's easier for humans to go back
to the archive and see if there was more discussions about why the change
was made.

Hence, I don't really care if Link tags are "recognized" by anything but
humans. It's actually one of the first tags to show up after Signed-off-by:
Cc: and Acked-by:. I believe it even predates "Fixes". At least the new
format for the Fixes tag.

-- Steve
