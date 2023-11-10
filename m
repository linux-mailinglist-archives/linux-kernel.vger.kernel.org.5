Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3567E8635
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 00:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjKJXCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 18:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjKJXCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 18:02:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9F2B0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 15:02:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7E6C433C8;
        Fri, 10 Nov 2023 23:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699657322;
        bh=ZD6WGhp750eeH5fxFK6q1CEI5R4qA//eR5EUKPVqZH0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fBhQZ3buXMXEyLHfwgRrYA37QhPhtBMstCKg71zfCj/kk0BiPnCjtxeDQy/8NSf1p
         IM4d/TubU8tlQeOSn7xLgMjQqa66eF8BYhmiqpzCKjb8wQaIdfEE8PydHq1OCYnkY0
         hQAPZ4Lo2JIS3hi8hbmM5LnOILQEf/O+4Z7R18ycs2abE0dJow7eOgVvKiuURr2Ake
         t/hRV7rR/VT883GIYtZlp5FsU29xyKS5DZ4S/a38Zkq+3T3qytqF6o7qWZrioyrkpT
         l9v0+rs4JjekgrXNbTENQBhvCZMfxvTTVFsdvnPd8mtazKgsqeNm69zyjhKN4MLFU/
         7FHnFeubxS1Fw==
Date:   Sat, 11 Nov 2023 08:01:57 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     Yujie Liu <yujie.liu@intel.com>,
        <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tom Zanussi <zanussi@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing/kprobes: Fix the order of argument descriptions
Message-Id: <20231111080157.1ad21fc9a236d69137d3a8c9@kernel.org>
In-Reply-To: <98413d47-986f-bf94-0793-865a5a4dc80d@quicinc.com>
References: <20231031041305.3363712-1-yujie.liu@intel.com>
        <98413d47-986f-bf94-0793-865a5a4dc80d@quicinc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2023 15:18:14 +0530
Mukesh Ojha <quic_mojha@quicinc.com> wrote:

> 
> 
> On 10/31/2023 9:43 AM, Yujie Liu wrote:
> > The order of descriptions should be consistent with the argument list of
> > the function, so "kretprobe" should be the second one.
> > 
> > int __kprobe_event_gen_cmd_start(struct dynevent_cmd *cmd, bool kretprobe,
> >                                   const char *name, const char *loc, ...)
> > 
> > Fixes: 2a588dd1d5d6 ("tracing: Add kprobe event command generation functions")
> > Suggested-by: Mukesh Ojha <quic_mojha@quicinc.com>
> > Signed-off-by: Yujie Liu <yujie.liu@intel.com>
> 
> Thanks.
> 
> Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

OK, let me pick this to probes/fixes.

Thanks!

> 
> -Mukesh
> 
> > ---
> >   kernel/trace/trace_kprobe.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index e834f149695b..47812aa16bb5 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -1020,9 +1020,9 @@ EXPORT_SYMBOL_GPL(kprobe_event_cmd_init);
> >   /**
> >    * __kprobe_event_gen_cmd_start - Generate a kprobe event command from arg list
> >    * @cmd: A pointer to the dynevent_cmd struct representing the new event
> > + * @kretprobe: Is this a return probe?
> >    * @name: The name of the kprobe event
> >    * @loc: The location of the kprobe event
> > - * @kretprobe: Is this a return probe?
> >    * @...: Variable number of arg (pairs), one pair for each field
> >    *
> >    * NOTE: Users normally won't want to call this function directly, but


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
