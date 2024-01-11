Return-Path: <linux-kernel+bounces-23619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A771782AF33
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6E3CB20A1C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750A315EA1;
	Thu, 11 Jan 2024 13:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tc29WRwQ"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DC715AFF;
	Thu, 11 Jan 2024 13:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704978554; x=1736514554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qOuB30Dc16U0vCarITox+yCHGsdehgXMs3mhCYq968c=;
  b=Tc29WRwQQxo1a9NsxNhKsuVT5hhIOq1Kl73FnJ85gaxCTtBtZ06l3E7V
   Hp+kFihwaXb8eUdRhXpGDiKx7DozpZUk2KDbaW6AQZDNDZgHBWoqpFVXK
   3nxxVk/naADbaJKa8p3TBieg8SF6K9jkxqbENuLZu6ZEIWJd8B7z/KLNt
   BHcIBFCJsOaDoiCwyt1916en3UJQYXfVsuhyGTndBdPfDSPc6iO4lk1mk
   kTs3Z+rNGqKnWp0GkXGZfekoFPM7rlyWCTN4/pbTeQCnxGwEE8WKoEkUn
   77n1sJyEefz73bUFRIfMEEDt1yN+/+4bUFfeL5iBQMOOkGV0cmFi+ZWuO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="463125645"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="463125645"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 05:09:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="17039461"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 11 Jan 2024 05:09:10 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNuo0-0008HM-1i;
	Thu, 11 Jan 2024 13:09:08 +0000
Date: Thu, 11 Jan 2024 21:08:13 +0800
From: kernel test robot <lkp@intel.com>
To: Carlos Galo <carlosgalo@google.com>, rostedt@goodmis.org,
	akpm@linux-foundation.org, surenb@google.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	android-mm@google.com, kernel-team@android.com,
	Carlos Galo <carlosgalo@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm: Update mark_victim tracepoints fields
Message-ID: <202401112057.lJYUSJJe-lkp@intel.com>
References: <20240111001155.746-1-carlosgalo@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111001155.746-1-carlosgalo@google.com>

Hi Carlos,

kernel test robot noticed the following build errors:

[auto build test ERROR on 0dd3ee31125508cd67f7e7172247f05b7fd1753a]

url:    https://github.com/intel-lab-lkp/linux/commits/Carlos-Galo/mm-Update-mark_victim-tracepoints-fields/20240111-081635
base:   0dd3ee31125508cd67f7e7172247f05b7fd1753a
patch link:    https://lore.kernel.org/r/20240111001155.746-1-carlosgalo%40google.com
patch subject: [PATCH] mm: Update mark_victim tracepoints fields
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240111/202401112057.lJYUSJJe-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240111/202401112057.lJYUSJJe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401112057.lJYUSJJe-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/oom_kill.c:54:
   In file included from include/trace/events/oom.h:206:
   In file included from include/trace/define_trace.h:102:
   In file included from include/trace/trace_events.h:237:
>> include/trace/events/oom.h:96:3: error: called object type 'uid_t' (aka 'unsigned int') is not a function or function pointer
      74 |         ),
         |         ~~
      75 | 
      76 |         TP_fast_assign(
         |         ~~~~~~~~~~~~~~~
      77 |                 __entry->pid = task->pid;
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~
      78 |                 __entry->uid = uid;
         |                 ~~~~~~~~~~~~~~~~~~~
      79 |                 __assign_str(comm, task->comm);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      80 |                 __entry->oom_score_adj = task->signal->oom_score_adj;
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      81 |         ),
         |         ~~
      82 | 
      83 |         TP_printk("pid=%d uid=%u comm=%s oom_score_adj=%hd",
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      84 |                 __entry->pid,
         |                 ~~~~~~~~~~~~~
      85 |                 __entry->uid
         |                 ~~~~~~~~~~~~
      86 |                 __get_str(comm),
         |                 ^~~~~~~~~~~~~~~~
      87 |                 __entry->oom_score_adj,
         |                 ~~~~~~~~~~~~~~~~~~~~~~~
      88 |         )
         |         ~
      89 | );
         | ~
   include/trace/stages/stage3_trace_output.h:20:26: note: expanded from macro '__get_str'
      20 | #define __get_str(field) ((char *)__get_dynamic_array(field))
         |                          ^
   include/trace/stages/stage3_trace_output.h:9:43: note: expanded from macro 'TP_printk'
       9 | #define TP_printk(fmt, args...) fmt "\n", args
         |                                           ^
   include/trace/trace_events.h:45:16: note: expanded from macro 'TRACE_EVENT'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      41 |                              PARAMS(proto),                    \
         |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      42 |                              PARAMS(args),                     \
         |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      43 |                              PARAMS(tstruct),                  \
         |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      44 |                              PARAMS(assign),                   \
         |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      45 |                              PARAMS(print));                   \
         |                              ~~~~~~~^~~~~~~
   include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
     107 | #define PARAMS(args...) args
         |                         ^
   include/trace/trace_events.h:203:27: note: expanded from macro 'DECLARE_EVENT_CLASS'
     203 |         trace_event_printf(iter, print);                                \
         |                                  ^~~~~
   In file included from mm/oom_kill.c:54:
   In file included from include/trace/events/oom.h:206:
   In file included from include/trace/define_trace.h:102:
   In file included from include/trace/trace_events.h:237:
>> include/trace/events/oom.h:74:1: error: expected expression
      74 | TRACE_EVENT(mark_victim,
         | ^
   include/trace/trace_events.h:40:2: note: expanded from macro 'TRACE_EVENT'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ^
   include/trace/trace_events.h:203:32: note: expanded from macro 'DECLARE_EVENT_CLASS'
     203 |         trace_event_printf(iter, print);                                \
         |                                       ^
   2 errors generated.


vim +96 include/trace/events/oom.h

    73	
  > 74	TRACE_EVENT(mark_victim,
    75		TP_PROTO(struct task_struct *task, uid_t uid),
    76	
    77		TP_ARGS(task, uid),
    78	
    79		TP_STRUCT__entry(
    80			__field(int, pid)
    81			__field(uid_t, uid)
    82			__string(comm, task->comm)
    83			__field(short, oom_score_adj)
    84		),
    85	
    86		TP_fast_assign(
    87			__entry->pid = task->pid;
    88			__entry->uid = uid;
    89			__assign_str(comm, task->comm);
    90			__entry->oom_score_adj = task->signal->oom_score_adj;
    91		),
    92	
    93		TP_printk("pid=%d uid=%u comm=%s oom_score_adj=%hd",
    94			__entry->pid,
    95			__entry->uid
  > 96			__get_str(comm),
    97			__entry->oom_score_adj,
    98		)
    99	);
   100	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

