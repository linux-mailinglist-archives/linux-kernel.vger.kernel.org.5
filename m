Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D665F81257D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442979AbjLNCtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbjLNCtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:49:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1DB10E7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:48:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5218AC433C8;
        Thu, 14 Dec 2023 02:48:45 +0000 (UTC)
Date:   Wed, 13 Dec 2023 21:49:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring-buffer: Remove 32bit timestamp logic
Message-ID: <20231213214930.5a501584@gandalf.local.home>
In-Reply-To: <20231213211126.24f8c1dd@gandalf.local.home>
References: <20231213211126.24f8c1dd@gandalf.local.home>
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

On Wed, 13 Dec 2023 21:11:26 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> @@ -3720,6 +3517,7 @@ rb_reserve_next_event(struct trace_buffer *buffer,
>  	struct rb_event_info info;
>  	int nr_loops = 0;
>  	int add_ts_default;
> +	static int once;
>  
>  	/* ring buffer does cmpxchg, make sure it is safe in NMI context */
>  	if (!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) &&

Oops, some debug code got committed!

-- Steve
