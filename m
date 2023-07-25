Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1116B7605DA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 04:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjGYCmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 22:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjGYCl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 22:41:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B7B1BE9;
        Mon, 24 Jul 2023 19:41:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20D3261468;
        Tue, 25 Jul 2023 02:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1CBC433C7;
        Tue, 25 Jul 2023 02:40:19 +0000 (UTC)
Date:   Mon, 24 Jul 2023 22:40:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] tracing/probes: Fixes for v6.5-rc2
Message-ID: <20230724224017.76d5b0e9@rorschach.local.home>
In-Reply-To: <169024903018.395371.1006584451160707296.stgit@devnote2>
References: <169024903018.395371.1006584451160707296.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Tue, 25 Jul 2023 10:37:10 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> These two patches are probe-events fixes for v6.5-rc2.
> One is to fix btf_type_by_id() return value check and the other is fixing
> selftest.
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (Google) (2):
>       tracing/probes: Fix to add NULL check for BTF APIs
>       selftests/ftrace: Fix to check fprobe event eneblement

For both patches:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> 
> 
>  kernel/trace/trace_probe.c                         |    8 ++++----
>  .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |    2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

