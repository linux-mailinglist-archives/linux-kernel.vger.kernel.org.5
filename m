Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D311C805DCC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345963AbjLES2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjLES2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:28:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96501A3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:28:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7601AC433C7;
        Tue,  5 Dec 2023 18:28:21 +0000 (UTC)
Date:   Tue, 5 Dec 2023 13:28:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dmytro Maluka <dmaluka@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Sean Paul <seanpaul@chromium.org>,
        Arun Easi <aeasi@marvell.com>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] tracing: Allow creating instances with specified system
 events
Message-ID: <20231205132847.74d31532@gandalf.local.home>
In-Reply-To: <ZW9oNUanjo2qn7r_@google.com>
References: <20231128122117.2276f4a7@gandalf.local.home>
        <ZW9oNUanjo2qn7r_@google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2023 19:13:09 +0100
Dmytro Maluka <dmaluka@chromium.org> wrote:

> On Tue, Nov 28, 2023 at 12:21:17PM -0500, Steven Rostedt wrote:
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > A trace instance may only need to enable specific events. As the eventfs
> > directory of an instance currently creates all events which adds overhead,
> > allow internal instances to be created with just the events in systems
> > that they care about. This currently only deals with systems and not
> > individual events, but this should bring down the overhead of creating
> > instances for specific use cases quite bit.
> > 
> > The trace_array_get_by_name() now has another parameter "systems". This
> > parameter is a const string pointer of a comma/space separated list of
> > event systems that should be created by the trace_array. (Note if the
> > trace_array already exists, this parameter is ignored).
> > 
> > The list of systems is saved and if a module is loaded, its events will
> > not be added unless the system for those events also match the systems
> > string.
> > 
> > Note that all dynamic events are still added as they are created by the
> > user.
> > 
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---  
> 
> Tested-by: Dmytro Maluka <dmaluka@chromium.org>

Thanks, but I have a v2 of this patch on my local repository, as after
discussing with Masami, I decided not to allow dynamic events unless they
are specified.

I'll send the v2 out later today.

-- Steve
