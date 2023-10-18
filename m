Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7257D7CD90A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjJRKUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjJRKU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:20:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF6FB0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:20:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00117C433C9;
        Wed, 18 Oct 2023 10:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697624424;
        bh=sOgqO5PGqwB3C8z51ihJDgYx6Qkli8L//Uj/en/125s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=eriMRYuKPHmk/+70yqXpGXDVRlULhZ2BTh7nYpTXTMMim+Qmd/If/FjPVM1MCyxZ4
         zLvKOFF68y1neFdxiklaOmrrsFZZ8rhawXXS7rcfn7OBi9rN+SWI0U8NP58dZVQFL9
         jVThbWyCSL8HSnu2OsvVxN1MaRCGX2lYkg8GfLm/8pqAzRaJplBdhd/7X5PRdu6FM1
         1yAgQOpuwRiMU0aobMOglS3I+NvE/X879Zci9zIFvuh0N78XTzXj5TVKLnBIh4yil1
         eCKjJIjinBIgbbOUESBuTbqCc6/gmGCs+tjsqvCUQdF8zbJcsj6Txz7d3GQK3E4MGR
         c/fOHOnN+7SWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC5A4C04E27;
        Wed, 18 Oct 2023 10:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] neighbor: tracing: Move pin6 inside CONFIG_IPV6=y section
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169762442389.8273.11100691121228999250.git-patchwork-notify@kernel.org>
Date:   Wed, 18 Oct 2023 10:20:23 +0000
References: <60cb0b0c6266881e225160f80a83884607617921.1697460418.git.geert+renesas@glider.be>
In-Reply-To: <60cb0b0c6266881e225160f80a83884607617921.1697460418.git.geert+renesas@glider.be>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, davem@davemloft.net,
        dsahern@gmail.com, linux-trace-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 16 Oct 2023 14:49:04 +0200 you wrote:
> When CONFIG_IPV6=n, and building with W=1:
> 
>     In file included from include/trace/define_trace.h:102,
> 		     from include/trace/events/neigh.h:255,
> 		     from net/core/net-traces.c:51:
>     include/trace/events/neigh.h: In function ‘trace_event_raw_event_neigh_create’:
>     include/trace/events/neigh.h:42:34: error: variable ‘pin6’ set but not used [-Werror=unused-but-set-variable]
>        42 |                 struct in6_addr *pin6;
> 	  |                                  ^~~~
>     include/trace/trace_events.h:402:11: note: in definition of macro ‘DECLARE_EVENT_CLASS’
>       402 |         { assign; }                                                     \
> 	  |           ^~~~~~
>     include/trace/trace_events.h:44:30: note: in expansion of macro ‘PARAMS’
>        44 |                              PARAMS(assign),                   \
> 	  |                              ^~~~~~
>     include/trace/events/neigh.h:23:1: note: in expansion of macro ‘TRACE_EVENT’
>        23 | TRACE_EVENT(neigh_create,
> 	  | ^~~~~~~~~~~
>     include/trace/events/neigh.h:41:9: note: in expansion of macro ‘TP_fast_assign’
>        41 |         TP_fast_assign(
> 	  |         ^~~~~~~~~~~~~~
>     In file included from include/trace/define_trace.h:103,
> 		     from include/trace/events/neigh.h:255,
> 		     from net/core/net-traces.c:51:
>     include/trace/events/neigh.h: In function ‘perf_trace_neigh_create’:
>     include/trace/events/neigh.h:42:34: error: variable ‘pin6’ set but not used [-Werror=unused-but-set-variable]
>        42 |                 struct in6_addr *pin6;
> 	  |                                  ^~~~
>     include/trace/perf.h:51:11: note: in definition of macro ‘DECLARE_EVENT_CLASS’
>        51 |         { assign; }                                                     \
> 	  |           ^~~~~~
>     include/trace/trace_events.h:44:30: note: in expansion of macro ‘PARAMS’
>        44 |                              PARAMS(assign),                   \
> 	  |                              ^~~~~~
>     include/trace/events/neigh.h:23:1: note: in expansion of macro ‘TRACE_EVENT’
>        23 | TRACE_EVENT(neigh_create,
> 	  | ^~~~~~~~~~~
>     include/trace/events/neigh.h:41:9: note: in expansion of macro ‘TP_fast_assign’
>        41 |         TP_fast_assign(
> 	  |         ^~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - neighbor: tracing: Move pin6 inside CONFIG_IPV6=y section
    https://git.kernel.org/netdev/net/c/2915240eddba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


