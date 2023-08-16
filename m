Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6941C77EA65
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346023AbjHPUJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbjHPUIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:08:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B25CD;
        Wed, 16 Aug 2023 13:08:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06A6766BD8;
        Wed, 16 Aug 2023 20:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20E0C433C8;
        Wed, 16 Aug 2023 20:08:46 +0000 (UTC)
Date:   Wed, 16 Aug 2023 16:08:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Chuang Wang <nashuiliang@gmail.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/eprobe: Iterate trace_eprobe directly
Message-ID: <20230816160850.48fa95b6@gandalf.local.home>
In-Reply-To: <20230812142019.06cb38b56287b0f068e8164f@kernel.org>
References: <20230811081239.246365-1-nashuiliang@gmail.com>
        <20230811154523.61e67cc3@gandalf.local.home>
        <20230812142019.06cb38b56287b0f068e8164f@kernel.org>
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

On Sat, 12 Aug 2023 14:20:19 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > At a minimum, let's call it:
> > 
> >   for_each_trace_point_eprobe()  
> 
> OK, what about "for_each_trace_eprobe_on()"? I would like to clarify
> 
> - what type is returned
> - not all trace_eprobes, but only on the trace_probe.
> 
> Thank you,

 for_each_trace_eprobe_tp() or for_each_trace_tp_eprobe() ?

As it only works for a trace_probe.

-- Steve
