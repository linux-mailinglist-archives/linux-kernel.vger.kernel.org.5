Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8D17BFE79
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjJJNw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjJJNwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:52:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E789325F
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:42:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAB5C433C9;
        Tue, 10 Oct 2023 13:42:02 +0000 (UTC)
Date:   Tue, 10 Oct 2023 09:43:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Subject: Re: kernel/trace/ftrace.c:5675: warning: Function parameter or
 member 'ops' not described in 'ftrace_set_filter_ips'
Message-ID: <20231010094323.52f8ed88@gandalf.local.home>
In-Reply-To: <202310100857.YpF7BNZH-lkp@intel.com>
References: <202310100857.YpF7BNZH-lkp@intel.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023 08:41:44 +0800
kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   94f6f0550c625fab1f373bb86a6669b45e9748b3
> commit: 4f554e955614f19425cee86de4669351741a6280 ftrace: Add ftrace_set_filter_ips function
> date:   1 year, 7 months ago
> config: i386-debian-10.3 (https://download.01.org/0day-ci/archive/20231010/202310100857.YpF7BNZH-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231010/202310100857.YpF7BNZH-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310100857.YpF7BNZH-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    kernel/trace/ftrace.c:5553: warning: Function parameter or member 'addr' not described in 'unregister_ftrace_direct_multi'
>    kernel/trace/ftrace.c:5656: warning: Function parameter or member 'ops' not described in 'ftrace_set_filter_ip'
>    kernel/trace/ftrace.c:5656: warning: Function parameter or member 'ip' not described in 'ftrace_set_filter_ip'
>    kernel/trace/ftrace.c:5656: warning: Function parameter or member 'remove' not described in 'ftrace_set_filter_ip'
>    kernel/trace/ftrace.c:5656: warning: Function parameter or member 'reset' not described in 'ftrace_set_filter_ip'
> >> kernel/trace/ftrace.c:5675: warning: Function parameter or member 'ops' not described in 'ftrace_set_filter_ips'
> >> kernel/trace/ftrace.c:5675: warning: Function parameter or member 'ips' not described in 'ftrace_set_filter_ips'
> >> kernel/trace/ftrace.c:5675: warning: Function parameter or member 'cnt' not described in 'ftrace_set_filter_ips'
> >> kernel/trace/ftrace.c:5675: warning: Function parameter or member 'remove' not described in 'ftrace_set_filter_ips'
> >> kernel/trace/ftrace.c:5675: warning: Function parameter or member 'reset' not described in 'ftrace_set_filter_ips'  
>    kernel/trace/ftrace.c:5689: warning: Function parameter or member 'ops' not described in 'ftrace_ops_set_global_filter'
>    kernel/trace/ftrace.c:5717: warning: Function parameter or member 'ops' not described in 'ftrace_set_filter'
>    kernel/trace/ftrace.c:5717: warning: Function parameter or member 'buf' not described in 'ftrace_set_filter'
>    kernel/trace/ftrace.c:5717: warning: Function parameter or member 'len' not described in 'ftrace_set_filter'
>    kernel/trace/ftrace.c:5717: warning: Function parameter or member 'reset' not described in 'ftrace_set_filter'
>    kernel/trace/ftrace.c:5736: warning: Function parameter or member 'ops' not described in 'ftrace_set_notrace'
>    kernel/trace/ftrace.c:5736: warning: Function parameter or member 'buf' not described in 'ftrace_set_notrace'
>    kernel/trace/ftrace.c:5736: warning: Function parameter or member 'len' not described in 'ftrace_set_notrace'
>    kernel/trace/ftrace.c:5736: warning: Function parameter or member 'reset' not described in 'ftrace_set_notrace'
>    kernel/trace/ftrace.c:5751: warning: Function parameter or member 'buf' not described in 'ftrace_set_global_filter'
>    kernel/trace/ftrace.c:5751: warning: Function parameter or member 'len' not described in 'ftrace_set_global_filter'
>    kernel/trace/ftrace.c:5751: warning: Function parameter or member 'reset' not described in 'ftrace_set_global_filter'
>    kernel/trace/ftrace.c:5767: warning: Function parameter or member 'buf' not described in 'ftrace_set_global_notrace'
>    kernel/trace/ftrace.c:5767: warning: Function parameter or member 'len' not described in 'ftrace_set_global_notrace'
>    kernel/trace/ftrace.c:5767: warning: Function parameter or member 'reset' not described in 'ftrace_set_global_notrace'
>    kernel/trace/ftrace.c:7843: warning: Function parameter or member 'ops' not described in 'register_ftrace_function'
>    kernel/trace/ftrace.c:7865: warning: Function parameter or member 'ops' not described in 'unregister_ftrace_function'
> 
> 
> vim +5675 kernel/trace/ftrace.c
> 
>   5661	
>   5662	/**
>   5663	 * ftrace_set_filter_ips - set functions to filter on in ftrace by addresses
>   5664	 * @ops - the ops to set the filter with
>   5665	 * @ips - the array of addresses to add to or remove from the filter.
>   5666	 * @cnt - the number of addresses in @ips
>   5667	 * @remove - non zero to remove ips from the filter
>   5668	 * @reset - non zero to reset all filters before applying this filter.

I was confused by this warning, but it's because the above should be:

 * @param: description

and not

 * @param - description.


-- Steve

>   5669	 *
>   5670	 * Filters denote which functions should be enabled when tracing is enabled
>   5671	 * If @ips array or any ip specified within is NULL , it fails to update filter.
>   5672	 */
>   5673	int ftrace_set_filter_ips(struct ftrace_ops *ops, unsigned long *ips,
>   5674				  unsigned int cnt, int remove, int reset)
> > 5675	{  
>   5676		ftrace_ops_init(ops);
>   5677		return ftrace_set_addr(ops, ips, cnt, remove, reset, 1);
>   5678	}
>   5679	EXPORT_SYMBOL_GPL(ftrace_set_filter_ips);
>   5680	
> 

