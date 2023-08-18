Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD8F780AB1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359839AbjHRLDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243727AbjHRLDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:03:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073DF2722;
        Fri, 18 Aug 2023 04:03:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9770C65ECE;
        Fri, 18 Aug 2023 11:03:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96FAEC433C7;
        Fri, 18 Aug 2023 11:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692356583;
        bh=klz9FaS+VfT+r6P08TExqYfZdZ0wrHKtfW1SQSee8Zg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X8yohGEj0M58n8ht4tan10WU/GZKIcNyFWXtdyb66JsN/mPzKP22TIbOGB9qC/IKi
         +hWcR4OQ6HMIAmPOVFiFtx09LjX9gA114p406POq2Oy06WUNi4VbgqnIcqkj596U+p
         6hvy2WSHIvO2HnejFk6P55JI4ir6tUwHwk/5OjxBD0bAQ+ov0wtKl92cTXfk0VR0oq
         oGPJYGdYOYz15E0tUr88L5hWMeE/ooMXjeCb5sYrmwkK51EuM7h5KQCHqOf51FUyqY
         sZFMWk2c/SCkl8BKWwctwZmMb5heabLkbAPAByPAlkk6SqennR/enQ8Aj1VNUuYhed
         1oxfUgPch9RZA==
Date:   Fri, 18 Aug 2023 20:02:58 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Chuang Wang <nashuiliang@gmail.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/eprobe: Iterate trace_eprobe directly
Message-Id: <20230818200258.7f318bab352508c54ed53e83@kernel.org>
In-Reply-To: <20230816160850.48fa95b6@gandalf.local.home>
References: <20230811081239.246365-1-nashuiliang@gmail.com>
        <20230811154523.61e67cc3@gandalf.local.home>
        <20230812142019.06cb38b56287b0f068e8164f@kernel.org>
        <20230816160850.48fa95b6@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2023 16:08:50 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 12 Aug 2023 14:20:19 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > At a minimum, let's call it:
> > > 
> > >   for_each_trace_point_eprobe()  
> > 
> > OK, what about "for_each_trace_eprobe_on()"? I would like to clarify
> > 
> > - what type is returned
> > - not all trace_eprobes, but only on the trace_probe.
> > 
> > Thank you,
> 
>  for_each_trace_eprobe_tp() or for_each_trace_tp_eprobe() ?

for_each_trace_eprobe_tp() is OK for me.

Thanks!

> 
> As it only works for a trace_probe.
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
