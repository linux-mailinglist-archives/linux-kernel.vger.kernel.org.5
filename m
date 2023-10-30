Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E967DBB37
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 14:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjJ3N7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 09:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjJ3N7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 09:59:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1900EC0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 06:59:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25ACFC433C8;
        Mon, 30 Oct 2023 13:59:20 +0000 (UTC)
Date:   Mon, 30 Oct 2023 09:59:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Francis Laniel <flaniel@linux.microsoft.com>
Subject: Re: [PATCH for-next] tracing/kprobes: Add symbol counting check
 when module loads
Message-ID: <20231030095918.4ec74c88@gandalf.local.home>
In-Reply-To: <169854904604.132316.12500381416261460174.stgit@devnote2>
References: <169854904604.132316.12500381416261460174.stgit@devnote2>
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

On Sun, 29 Oct 2023 12:10:46 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Check the number of probe target symbols in the target module when
> the module is loaded. If the probe is not on the unique name symbols
> in the module, it will be rejected at that point.
> 
> Note that the symbol which has a unique name in the target module,
> it will be accepted even if there are same-name symbols in the
> kernel or other modules,
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_kprobe.c |  112 ++++++++++++++++++++++++++-----------------
>  1 file changed, 68 insertions(+), 44 deletions(-)

Reviewed-by: Steven Rosted (Google) <rostedt@goodmis.org>

-- Steve
