Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BB57D9990
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345875AbjJ0NSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345851AbjJ0NSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:18:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD14518F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:18:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55826C433C8;
        Fri, 27 Oct 2023 13:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698412718;
        bh=Jlk5lCPwKrprPDRM1mo9/OlooWAMGpRQnm89JwUPmj4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bUHAN6s/nVDZV7TB5xCmk6RZtZCQOCfLs9GgBFT9XeTfrQIs3WLyfWCG88Lf4CMKm
         yFxQFtC3oltl3IYGwYf4QqNGDIBOTvZQ9rLa6OdFUBvfmgSNEilcPmuqHEq+Q8J1zb
         TwI68K8/xZxqGKTjnOJv6ms0ZO6alIdFrPMYYqZkeloVwIxmJA4UHbIc5WiD15bt1w
         oohBH/N1sYo0uH9N2fr4LQfooo0g6JM48qG8EyUmC4LaXFpfmwNVkKGcTdMTZKA/uy
         IWcrnpxyk9FRr4kD148rA3WPbopSxaUuFycFtZnopkW++w37Y3ApNytjv7c3lbasR6
         KRsS6yWN9bSXw==
Date:   Fri, 27 Oct 2023 22:18:33 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     Yujie Liu <yujie.liu@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] tracing/kprobes: Fix the description of variable length
 arguments
Message-Id: <20231027221833.5f2c6d46dfd51110aafe6f58@kernel.org>
In-Reply-To: <aa71f7e3-71c5-1d2f-bc73-6db977025b41@quicinc.com>
References: <20231027041315.2613166-1-yujie.liu@intel.com>
        <aa71f7e3-71c5-1d2f-bc73-6db977025b41@quicinc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2023 14:10:44 +0530
Mukesh Ojha <quic_mojha@quicinc.com> wrote:

> 
> 
> On 10/27/2023 9:43 AM, Yujie Liu wrote:
> > Fix the following kernel-doc warnings:
> > 
> > kernel/trace/trace_kprobe.c:1029: warning: Excess function parameter 'args' description in '__kprobe_event_gen_cmd_start'
> > kernel/trace/trace_kprobe.c:1097: warning: Excess function parameter 'args' description in '__kprobe_event_add_fields'
> > 
> > Refer to the usage of variable length arguments elsewhere in the kernel
> > code, "@..." is the proper way to express it in the description.
> > 
> > Fixes: 2a588dd1d5d6 ("tracing: Add kprobe event command generation functions")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202310190437.paI6LYJF-lkp@intel.com/
> > Signed-off-by: Yujie Liu <yujie.liu@intel.com>
> 
> Not related to this patch, but I see order of the argument as well is 
> not proper in the document of the __kprobe_event_gen_cmd_start(),
> if you can fix that too.
> 
> LGTM, Thanks for this.
> Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

Thanks! let me pick this!

> 
> -Mukesh
> 
> > ---
> >   kernel/trace/trace_kprobe.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index a8fef6ab0872..95c5b0668cb7 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -1007,7 +1007,7 @@ EXPORT_SYMBOL_GPL(kprobe_event_cmd_init);
> >    * @name: The name of the kprobe event
> >    * @loc: The location of the kprobe event
> >    * @kretprobe: Is this a return probe?
> > - * @args: Variable number of arg (pairs), one pair for each field
> > + * @...: Variable number of arg (pairs), one pair for each field
> >    *
> >    * NOTE: Users normally won't want to call this function directly, but
> >    * rather use the kprobe_event_gen_cmd_start() wrapper, which automatically
> > @@ -1080,7 +1080,7 @@ EXPORT_SYMBOL_GPL(__kprobe_event_gen_cmd_start);
> >   /**
> >    * __kprobe_event_add_fields - Add probe fields to a kprobe command from arg list
> >    * @cmd: A pointer to the dynevent_cmd struct representing the new event
> > - * @args: Variable number of arg (pairs), one pair for each field
> > + * @...: Variable number of arg (pairs), one pair for each field
> >    *
> >    * NOTE: Users normally won't want to call this function directly, but
> >    * rather use the kprobe_event_add_fields() wrapper, which


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
