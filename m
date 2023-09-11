Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0998879C39F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241483AbjILDEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241341AbjILDDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:03:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4F1FF803;
        Mon, 11 Sep 2023 18:37:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91FDC116AB;
        Mon, 11 Sep 2023 22:02:43 +0000 (UTC)
Date:   Mon, 11 Sep 2023 18:02:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [RESEND][PATCH] tracing/synthetic: Fix order of struct
 trace_dynamic_info
Message-ID: <20230911180259.599a7909@gandalf.local.home>
In-Reply-To: <20230911092612.775372d425e97da96da6f047@kernel.org>
References: <20230908163929.2c25f3dc@gandalf.local.home>
        <20230911092612.775372d425e97da96da6f047@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2023 09:26:12 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > Fix this and just to be safe also add "__packed".
> > 
> > Link: https://lore.kernel.org/all/20230908154417.5172e343@gandalf.local.home/  
> 
> Good catch! I'm not sure why this worked. Maybe we don't have any testcase
> for this feature?

We have a test case, it was broken by a change in the README :-p

I noticed issues with it, and then looked at the tests, fixed the test and
it failed. Before that, it was just reporting "unsupported", which is why I
included that fix with this queue.

  https://lore.kernel.org/linux-trace-kernel/20230614091046.2178539-1-naveen@kernel.org/

> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

-- Steve
