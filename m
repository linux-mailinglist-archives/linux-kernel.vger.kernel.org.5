Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6952777FA3A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352732AbjHQPGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352743AbjHQPF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:05:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFEA30E9;
        Thu, 17 Aug 2023 08:05:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4239B6157E;
        Thu, 17 Aug 2023 15:05:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10394C433C8;
        Thu, 17 Aug 2023 15:05:47 +0000 (UTC)
Date:   Thu, 17 Aug 2023 11:05:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH RESEND v3 0/3] few fixes for synthetic trace events
Message-ID: <20230817110553.08dbd536@gandalf.local.home>
In-Reply-To: <20230816154928.4171614-1-svens@linux.ibm.com>
References: <20230816154928.4171614-1-svens@linux.ibm.com>
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

On Wed, 16 Aug 2023 17:49:25 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> Hi Steven,
> 
> I'm now sending these patches in one patchset, because the second patch
> has a dependeny on the union vs. cast fix.

Thanks. I'm currently waiting on some other fixes before running them all
through my tests before sending them off to Linus. If they are not ready by
tomorrow, I'll just kick off my tests without them.

-- Steve


> 
> Changes in v3:
> - remove superfluous struct around union trace_synth_field
> 
> Changes in v2:
> - cosmetic changes
> - add struct trace_dynamic_info to include/linux/trace_events.h
> 
> Sven Schnelle (3):
>   tracing/synthetic: use union instead of casts
>   tracing/synthetic: skip first entry for stack traces
>   tracing/synthetic: allocate one additional element for size
> 
>  include/linux/trace_events.h      |  11 ++++
>  kernel/trace/trace.h              |   8 +++
>  kernel/trace/trace_events_synth.c | 103 ++++++++++++------------------
>  3 files changed, 60 insertions(+), 62 deletions(-)
> 

