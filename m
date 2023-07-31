Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FB3769996
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbjGaOex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjGaOev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:34:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7360610D;
        Mon, 31 Jul 2023 07:34:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 025336117E;
        Mon, 31 Jul 2023 14:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21C3C433C7;
        Mon, 31 Jul 2023 14:34:47 +0000 (UTC)
Date:   Mon, 31 Jul 2023 10:34:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2] tracing: Add a debug_trace_printk() function
Message-ID: <20230731103445.497e48d8@gandalf.local.home>
In-Reply-To: <20230730104321.f30784d6397b65636ac5f2cd@kernel.org>
References: <20230613095537.0ecf2459@gandalf.local.home>
        <20230730104321.f30784d6397b65636ac5f2cd@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jul 2023 10:43:21 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Sorry, I missed this patch.
> As far as it depends CONFIG_FTRACE_DEBUG_PRINT, this looks good to me.
> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks, note I've been holding off on applying it to make sure I really do
need it. I have used it twice since posting. It's great to debug something
in the tracing infrastructure ;-)

> 
> BTW, what about adding generic trace_loglvl_printk(loglvl, fmt, ...)?
> 
> This is a macro that will be expanded to 'trace_loglvl_<N>_printk(fmt, ...)'
> where N is 0-9. Then we can filter the trace_loglvl_N_printk event to a
> specific instance.

Hmm, interesting idea. I'll have to think about it.

-- Steve

