Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5951C77E4C0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239116AbjHPPL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344048AbjHPPLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:11:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC90110EC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:11:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A0B262332
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 15:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693D4C433C8;
        Wed, 16 Aug 2023 15:11:40 +0000 (UTC)
Date:   Wed, 16 Aug 2023 11:11:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] few fixes for synthetic trace events
Message-ID: <20230816111142.1b774383@gandalf.local.home>
In-Reply-To: <yt9dcyzn9wwr.fsf@linux.ibm.com>
References: <20230810060538.1350348-1-svens@linux.ibm.com>
        <yt9dcyzn9wwr.fsf@linux.ibm.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2023 11:08:52 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> Sven Schnelle <svens@linux.ibm.com> writes:
> 
> > Hi Steven,
> >
> > I'm now sending these patches in one patchset, because the second patch
> > has a dependeny on the union vs. cast fix.
> >
> > Changes in v3:
> > - remove superfluous struct around union trace_synth_field
> >
> > Changes in v2:
> > - cosmetic changes
> > - add struct trace_dynamic_info to include/linux/trace_events.h
> >
> > Sven Schnelle (3):
> >   tracing/synthetic: use union instead of casts
> >   tracing/synthetic: skip first entry for stack traces
> >   tracing/synthetic: allocate one additional element for size
> >
> >  include/linux/trace_events.h      |  11 ++++
> >  kernel/trace/trace.h              |   8 +++
> >  kernel/trace/trace_events_synth.c | 103 ++++++++++++------------------
> >  3 files changed, 60 insertions(+), 62 deletions(-)  
> 
> Gentle ping? We're still seeing a lot of KASAN warnings.

Can you resend and include a Cc to linux-trace-kernel@vger.kernel.org. That
will put it into patchwork:

  https://patchwork.kernel.org/project/linux-trace-kernel/list/

Also, include everyone in the MAINTAINERS file too please.

That's what I use to know what to pull in for tracing. I have a personal
patchwork on my INBOX that this did go into, but that's always considered
lower priority.

-- Steve
