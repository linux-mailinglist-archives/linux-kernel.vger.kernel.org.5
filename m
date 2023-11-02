Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A707DEACF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 03:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbjKBCqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 22:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjKBCqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 22:46:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD82110
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 19:46:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A4BC433C8;
        Thu,  2 Nov 2023 02:46:48 +0000 (UTC)
Date:   Wed, 1 Nov 2023 22:46:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: Re: [PATCH] tracing: Have trace_event_file have ref counters
Message-ID: <20231101224646.5d9c21fb@gandalf.local.home>
In-Reply-To: <20231101223254.7ec2a1e2@gandalf.local.home>
References: <20231031122453.7a48b923@gandalf.local.home>
        <20231102111433.5330cbb98cf204b4063924c0@kernel.org>
        <20231101223254.7ec2a1e2@gandalf.local.home>
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

On Wed, 1 Nov 2023 22:32:54 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Ouch! I thought the file descriptor has been hold by the opened process.  
> 
> Well, the struct *filp is, but not the filp->private that points to the
> struct trace_event_file *file.

That was supposed to be "struct file *filp"

-- Steve
