Return-Path: <linux-kernel+bounces-3587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CAC816E18
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0584284789
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90DE7D618;
	Mon, 18 Dec 2023 12:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIcKzmBZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171D37EFC6;
	Mon, 18 Dec 2023 12:41:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29569C433C7;
	Mon, 18 Dec 2023 12:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702903284;
	bh=Kwwmc0NfccqeFWq0XGz9CH7vdLIXsemodRHwpiAo6RA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CIcKzmBZ9WPjT25rBRiSmVK9W2ePrImJqe9NHntudL5hh4wRbd9WPmZV4gzQR0Mo5
	 A5OzT7Dcgfy8UnozSKQFv8kVA0E4TUF9KXhOn+CmHipn6BB19EYXmo8dbIjjCIa2rL
	 xT/f8J6xgo/7OH+1Zqgszy+MliolGG/UDsPycRsa0Zavtidk8p32HVQ09NcdIfAYqc
	 bWpfJxgqDWB+KaEnrK84T02Wwr7GYrI0vWlCr/Jzy6GErhcS1TnzsLE4Cb12V6Pv1M
	 eWOzj3z6f9DkQuXM2Kw5ztZPZsoFCmKg+lhDU/vYXQL+J/izAPBCTRpnqUzr/nTLhf
	 6eqGZ4uCJ++fQ==
Date: Mon, 18 Dec 2023 21:41:20 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, "Steven Rostedt (Google)"
 <rostedt@goodmis.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: kernel/trace/ftrace.c:1256: warning: Function parameter or
 struct member 'ops' not described in 'ftrace_free_filter'
Message-Id: <20231218214120.43a0a2b5f8370ca576f59667@kernel.org>
In-Reply-To: <202312180518.X6fRyDSN-lkp@intel.com>
References: <202312180518.X6fRyDSN-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Dec 2023 05:53:57 +0800
kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   0e389834672c723435a44818ed2cabc4dad24429
> commit: 8be9fbd5345da52f4a74f7f81d55ff9fa0a2958e ftrace: Export ftrace_free_filter() to modules
> date:   11 months ago
> config: i386-randconfig-054-20231216 (https://download.01.org/0day-ci/archive/20231218/202312180518.X6fRyDSN-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231218/202312180518.X6fRyDSN-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312180518.X6fRyDSN-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> kernel/trace/ftrace.c:1256: warning: Function parameter or struct member 'ops' not described in 'ftrace_free_filter'
>    kernel/trace/ftrace.c:5709: warning: Function parameter or struct member 'addr' not described in 'unregister_ftrace_direct_multi'
>    kernel/trace/ftrace.c:5854: warning: Function parameter or struct member 'ops' not described in 'ftrace_set_filter_ip'
>    kernel/trace/ftrace.c:5854: warning: Function parameter or struct member 'ip' not described in 'ftrace_set_filter_ip'
>    kernel/trace/ftrace.c:5854: warning: Function parameter or struct member 'remove' not described in 'ftrace_set_filter_ip'
>    kernel/trace/ftrace.c:5854: warning: Function parameter or struct member 'reset' not described in 'ftrace_set_filter_ip'
>    kernel/trace/ftrace.c:5877: warning: Function parameter or struct member 'ops' not described in 'ftrace_set_filter_ips'
>    kernel/trace/ftrace.c:5877: warning: Function parameter or struct member 'ips' not described in 'ftrace_set_filter_ips'
>    kernel/trace/ftrace.c:5877: warning: Function parameter or struct member 'cnt' not described in 'ftrace_set_filter_ips'
>    kernel/trace/ftrace.c:5877: warning: Function parameter or struct member 'remove' not described in 'ftrace_set_filter_ips'
>    kernel/trace/ftrace.c:5877: warning: Function parameter or struct member 'reset' not described in 'ftrace_set_filter_ips'
>    kernel/trace/ftrace.c:5891: warning: Function parameter or struct member 'ops' not described in 'ftrace_ops_set_global_filter'
>    kernel/trace/ftrace.c:5923: warning: Function parameter or struct member 'ops' not described in 'ftrace_set_filter'
>    kernel/trace/ftrace.c:5923: warning: Function parameter or struct member 'buf' not described in 'ftrace_set_filter'
>    kernel/trace/ftrace.c:5923: warning: Function parameter or struct member 'len' not described in 'ftrace_set_filter'
>    kernel/trace/ftrace.c:5923: warning: Function parameter or struct member 'reset' not described in 'ftrace_set_filter'
>    kernel/trace/ftrace.c:5946: warning: Function parameter or struct member 'ops' not described in 'ftrace_set_notrace'
>    kernel/trace/ftrace.c:5946: warning: Function parameter or struct member 'buf' not described in 'ftrace_set_notrace'
>    kernel/trace/ftrace.c:5946: warning: Function parameter or struct member 'len' not described in 'ftrace_set_notrace'
>    kernel/trace/ftrace.c:5946: warning: Function parameter or struct member 'reset' not described in 'ftrace_set_notrace'
>    kernel/trace/ftrace.c:5961: warning: Function parameter or struct member 'buf' not described in 'ftrace_set_global_filter'
>    kernel/trace/ftrace.c:5961: warning: Function parameter or struct member 'len' not described in 'ftrace_set_global_filter'
>    kernel/trace/ftrace.c:5961: warning: Function parameter or struct member 'reset' not described in 'ftrace_set_global_filter'
>    kernel/trace/ftrace.c:5977: warning: Function parameter or struct member 'buf' not described in 'ftrace_set_global_notrace'
>    kernel/trace/ftrace.c:5977: warning: Function parameter or struct member 'len' not described in 'ftrace_set_global_notrace'
>    kernel/trace/ftrace.c:5977: warning: Function parameter or struct member 'reset' not described in 'ftrace_set_global_notrace'
> 
> 
> vim +1256 kernel/trace/ftrace.c
> 
> 07fd5515f3b5c2 Steven Rostedt           2011-05-05  1250  
> 8be9fbd5345da5 Mark Rutland             2023-01-03  1251  /**
> 8be9fbd5345da5 Mark Rutland             2023-01-03  1252   * ftrace_free_filter - remove all filters for an ftrace_ops
> 8be9fbd5345da5 Mark Rutland             2023-01-03  1253   * @ops - the ops to remove the filters from

Ah, this line should be `@ops: the ops to remove the filters from` ('-' -> ':')
And there seems so many similar errors.

Thanks, 

> 8be9fbd5345da5 Mark Rutland             2023-01-03  1254   */
> 5500fa51199aee Jiri Olsa                2012-02-15  1255  void ftrace_free_filter(struct ftrace_ops *ops)
> 5500fa51199aee Jiri Olsa                2012-02-15 @1256  {
> f04f24fb7e48d4 Masami Hiramatsu         2013-05-09  1257  	ftrace_ops_init(ops);
> 33b7f99cf003ca Steven Rostedt (Red Hat  2014-08-15  1258) 	free_ftrace_hash(ops->func_hash->filter_hash);
> 33b7f99cf003ca Steven Rostedt (Red Hat  2014-08-15  1259) 	free_ftrace_hash(ops->func_hash->notrace_hash);
> 5500fa51199aee Jiri Olsa                2012-02-15  1260  }
> 8be9fbd5345da5 Mark Rutland             2023-01-03  1261  EXPORT_SYMBOL_GPL(ftrace_free_filter);
> 5500fa51199aee Jiri Olsa                2012-02-15  1262  
> 
> :::::: The code at line 1256 was first introduced by commit
> :::::: 5500fa51199aee770ce53718853732600543619e ftrace, perf: Add filter support for function trace event
> 
> :::::: TO: Jiri Olsa <jolsa@redhat.com>
> :::::: CC: Steven Rostedt <rostedt@goodmis.org>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

