Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0078A7A2833
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237323AbjIOUgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237405AbjIOUgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:36:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71479F9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:36:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78370C433C8;
        Fri, 15 Sep 2023 20:36:13 +0000 (UTC)
Date:   Fri, 15 Sep 2023 16:36:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ajay Kaher <akaher@vmware.com>
Subject: Re: [GIT PULL] tracing: Add eventfs file to help with debugging any
 more issues
Message-ID: <20230915163637.77c673a6@gandalf.local.home>
In-Reply-To: <CAHk-=whAkgy10YVwjQGn1AO=1ZFc193ujvMXwmDOJAc=Jaeg5A@mail.gmail.com>
References: <20230913192905.0a92bcab@gandalf.local.home>
        <CAHk-=whAkgy10YVwjQGn1AO=1ZFc193ujvMXwmDOJAc=Jaeg5A@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2023 12:28:57 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 13 Sept 2023 at 16:28, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > tracing: Add eventfs file to help with debugging any more issues
> >
> > While debugging the eventfs dynamic file creation issues, creating a file
> > in tracefs that exposed what dentries that were created along with their ref
> > counts proved invaluable.  
> 
> Honestly, this is neither a bug-fix, nor does it seem to make any
> sense at all in the main tree.
> 
> This really feels like a "temporary debug patch for tracing developers".

I wouldn't say its temporary, especially since it can be used to see what's
happening internally.

I'm OK with it not going in now, but instead I'll wrap an ifdef around it
and move it to my queue for the next merge window. I still would like to
keep these "what's going on internally" available, as I'll ask people to
enable them when they report an issue.

There's a few other files that do similar things that have been very useful
for such cases.

-- Steve
