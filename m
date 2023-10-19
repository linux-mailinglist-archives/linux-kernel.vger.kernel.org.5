Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4532E7CFADB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345950AbjJSNWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345908AbjJSNWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:22:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C4B106
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:22:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB8CC433CD;
        Thu, 19 Oct 2023 13:22:09 +0000 (UTC)
Date:   Thu, 19 Oct 2023 09:22:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Tom Zanussi <zanussi@kernel.org>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: kernel/trace/trace_kprobe.c:952: warning: Excess function
 parameter 'args' description in '__kprobe_event_gen_cmd_start'
Message-ID: <20231019092207.7d2fa545@gandalf.local.home>
In-Reply-To: <202310190437.paI6LYJF-lkp@intel.com>
References: <202310190437.paI6LYJF-lkp@intel.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 04:33:41 +0800
kernel test robot <lkp@intel.com> wrote:

> All warnings (new ones prefixed by >>):
> 
> >> kernel/trace/trace_kprobe.c:952: warning: Excess function parameter 'args' description in '__kprobe_event_gen_cmd_start'
> >> kernel/trace/trace_kprobe.c:1017: warning: Excess function parameter 'args' description in '__kprobe_event_add_fields'  
> 
> 
> vim +952 kernel/trace/trace_kprobe.c
> 
>    929	
>    930	/**
>    931	 * __kprobe_event_gen_cmd_start - Generate a kprobe event command from arg list
>    932	 * @cmd: A pointer to the dynevent_cmd struct representing the new event
>    933	 * @name: The name of the kprobe event
>    934	 * @loc: The location of the kprobe event
>    935	 * @kretprobe: Is this a return probe?
>    936	 * @args: Variable number of arg (pairs), one pair for each field
>    937	 *
>    938	 * NOTE: Users normally won't want to call this function directly, but
>    939	 * rather use the kprobe_event_gen_cmd_start() wrapper, which automatically
>    940	 * adds a NULL to the end of the arg list.  If this function is used
>    941	 * directly, make sure the last arg in the variable arg list is NULL.
>    942	 *
>    943	 * Generate a kprobe event command to be executed by
>    944	 * kprobe_event_gen_cmd_end().  This function can be used to generate the
>    945	 * complete command or only the first part of it; in the latter case,
>    946	 * kprobe_event_add_fields() can be used to add more fields following this.
>    947	 *
>    948	 * Return: 0 if successful, error otherwise.
>    949	 */
>    950	int __kprobe_event_gen_cmd_start(struct dynevent_cmd *cmd, bool kretprobe,
>    951					 const char *name, const char *loc, ...)
>  > 952	{  

So what is the proper kerneldoc way to express variable length arguments?

-- Steve
