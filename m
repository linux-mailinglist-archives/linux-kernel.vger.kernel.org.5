Return-Path: <linux-kernel+bounces-12251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA41481F1F7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 21:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C4D283D8F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 20:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CB6481D0;
	Wed, 27 Dec 2023 20:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZHB3UMik"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E826481A8;
	Wed, 27 Dec 2023 20:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703710003; x=1735246003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E9NNujhNzXB2J6RFiytU9tsINKsj3T6egLLXp+6j1eE=;
  b=ZHB3UMikDNyP3/oPr5sEy7KPKsJeGIwEVLawjWX70JX1AJNZ5yfBR8Sb
   n/Vx8iFYfx7WymTVi86adW7XuKoujsS2U+sTRk9MCFS/Peqs9KX8fgHh5
   RDii7rIU1UOfuQEfJpHvd80QoN3F4xkAhQXLqSvAsPOkD9Nu8nnC29QW9
   HruCAmKBdZ8tKR0paXxSciFM5VWoE7p/4BBjPXwky3u+XP2VJx+0ibzDL
   mXj9q6pBHT8OFKM5SgFlBSWbl5uuMLYCIaw9XfiJhKZRYFSAnegPFtVk5
   dqwCjbvMGskEfzAjS7x+cXUWQirczZbFsuAcCwEn/NqJUoLhCN8V+jnns
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="427654809"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="427654809"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 12:46:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="754551656"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="754551656"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 27 Dec 2023 12:46:39 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rIanV-000FkV-17;
	Wed, 27 Dec 2023 20:46:37 +0000
Date: Thu, 28 Dec 2023 04:46:05 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring-buffer/Documentation: Add documentation on
 buffer_percent file
Message-ID: <202312280409.XbgJXp8K-lkp@intel.com>
References: <20231226123525.71a6d0fb@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226123525.71a6d0fb@gandalf.local.home>

Hi Steven,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lwn/docs-next]
[also build test WARNING on linus/master v6.7-rc7 next-20231221]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/ring-buffer-Documentation-Add-documentation-on-buffer_percent-file/20231227-013710
base:   git://git.lwn.net/linux.git docs-next
patch link:    https://lore.kernel.org/r/20231226123525.71a6d0fb%40gandalf.local.home
patch subject: [PATCH] ring-buffer/Documentation: Add documentation on buffer_percent file
reproduce: (https://download.01.org/0day-ci/archive/20231228/202312280409.XbgJXp8K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312280409.XbgJXp8K-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/trace/ftrace.rst:194: WARNING: Unexpected indentation.
>> Documentation/trace/ftrace.rst:195: WARNING: Block quote ends without a blank line; unexpected unindent.

vim +194 Documentation/trace/ftrace.rst

    91	
    92	
    93	 Note: all time values are in microseconds.
    94	
    95	  current_tracer:
    96	
    97		This is used to set or display the current tracer
    98		that is configured. Changing the current tracer clears
    99		the ring buffer content as well as the "snapshot" buffer.
   100	
   101	  available_tracers:
   102	
   103		This holds the different types of tracers that
   104		have been compiled into the kernel. The
   105		tracers listed here can be configured by
   106		echoing their name into current_tracer.
   107	
   108	  tracing_on:
   109	
   110		This sets or displays whether writing to the trace
   111		ring buffer is enabled. Echo 0 into this file to disable
   112		the tracer or 1 to enable it. Note, this only disables
   113		writing to the ring buffer, the tracing overhead may
   114		still be occurring.
   115	
   116		The kernel function tracing_off() can be used within the
   117		kernel to disable writing to the ring buffer, which will
   118		set this file to "0". User space can re-enable tracing by
   119		echoing "1" into the file.
   120	
   121		Note, the function and event trigger "traceoff" will also
   122		set this file to zero and stop tracing. Which can also
   123		be re-enabled by user space using this file.
   124	
   125	  trace:
   126	
   127		This file holds the output of the trace in a human
   128		readable format (described below). Opening this file for
   129		writing with the O_TRUNC flag clears the ring buffer content.
   130	        Note, this file is not a consumer. If tracing is off
   131	        (no tracer running, or tracing_on is zero), it will produce
   132	        the same output each time it is read. When tracing is on,
   133	        it may produce inconsistent results as it tries to read
   134	        the entire buffer without consuming it.
   135	
   136	  trace_pipe:
   137	
   138		The output is the same as the "trace" file but this
   139		file is meant to be streamed with live tracing.
   140		Reads from this file will block until new data is
   141		retrieved.  Unlike the "trace" file, this file is a
   142		consumer. This means reading from this file causes
   143		sequential reads to display more current data. Once
   144		data is read from this file, it is consumed, and
   145		will not be read again with a sequential read. The
   146		"trace" file is static, and if the tracer is not
   147		adding more data, it will display the same
   148		information every time it is read.
   149	
   150	  trace_options:
   151	
   152		This file lets the user control the amount of data
   153		that is displayed in one of the above output
   154		files. Options also exist to modify how a tracer
   155		or events work (stack traces, timestamps, etc).
   156	
   157	  options:
   158	
   159		This is a directory that has a file for every available
   160		trace option (also in trace_options). Options may also be set
   161		or cleared by writing a "1" or "0" respectively into the
   162		corresponding file with the option name.
   163	
   164	  tracing_max_latency:
   165	
   166		Some of the tracers record the max latency.
   167		For example, the maximum time that interrupts are disabled.
   168		The maximum time is saved in this file. The max trace will also be
   169		stored,	and displayed by "trace". A new max trace will only be
   170		recorded if the latency is greater than the value in this file
   171		(in microseconds).
   172	
   173		By echoing in a time into this file, no latency will be recorded
   174		unless it is greater than the time in this file.
   175	
   176	  tracing_thresh:
   177	
   178		Some latency tracers will record a trace whenever the
   179		latency is greater than the number in this file.
   180		Only active when the file contains a number greater than 0.
   181		(in microseconds)
   182	
   183	  buffer_percent:
   184	
   185		This is the water-mark for how much the ring buffer needs to be filled
   186		before a waiter is woken up. That is, if an application call a
   187		blocking read syscall on one of the per_cpu trace_pipe_raw files, it
   188		will block until the given amount of data specified by buffer_percent
   189		is in the ring buffer before it wakes the reader up. This also
   190		controls how splice system calls are blocked on this file.
   191	
   192		0   - means to wake up as soon as there is any data in the ring buffer.
   193		50  - means to wake up when roughly half of the ring buffer sub-buffers
 > 194		      are full.
 > 195		100 - means to block until the ring buffer is totally full and is
   196		      about to start overwriting the older data.
   197	
   198	  buffer_size_kb:
   199	
   200		This sets or displays the number of kilobytes each CPU
   201		buffer holds. By default, the trace buffers are the same size
   202		for each CPU. The displayed number is the size of the
   203		CPU buffer and not total size of all buffers. The
   204		trace buffers are allocated in pages (blocks of memory
   205		that the kernel uses for allocation, usually 4 KB in size).
   206		A few extra pages may be allocated to accommodate buffer management
   207		meta-data. If the last page allocated has room for more bytes
   208		than requested, the rest of the page will be used,
   209		making the actual allocation bigger than requested or shown.
   210		( Note, the size may not be a multiple of the page size
   211		due to buffer management meta-data. )
   212	
   213		Buffer sizes for individual CPUs may vary
   214		(see "per_cpu/cpu0/buffer_size_kb" below), and if they do
   215		this file will show "X".
   216	
   217	  buffer_total_size_kb:
   218	
   219		This displays the total combined size of all the trace buffers.
   220	
   221	  free_buffer:
   222	
   223		If a process is performing tracing, and the ring buffer	should be
   224		shrunk "freed" when the process is finished, even if it were to be
   225		killed by a signal, this file can be used for that purpose. On close
   226		of this file, the ring buffer will be resized to its minimum size.
   227		Having a process that is tracing also open this file, when the process
   228		exits its file descriptor for this file will be closed, and in doing so,
   229		the ring buffer will be "freed".
   230	
   231		It may also stop tracing if disable_on_free option is set.
   232	
   233	  tracing_cpumask:
   234	
   235		This is a mask that lets the user only trace on specified CPUs.
   236		The format is a hex string representing the CPUs.
   237	
   238	  set_ftrace_filter:
   239	
   240		When dynamic ftrace is configured in (see the
   241		section below "dynamic ftrace"), the code is dynamically
   242		modified (code text rewrite) to disable calling of the
   243		function profiler (mcount). This lets tracing be configured
   244		in with practically no overhead in performance.  This also
   245		has a side effect of enabling or disabling specific functions
   246		to be traced. Echoing names of functions into this file
   247		will limit the trace to only those functions.
   248		This influences the tracers "function" and "function_graph"
   249		and thus also function profiling (see "function_profile_enabled").
   250	
   251		The functions listed in "available_filter_functions" are what
   252		can be written into this file.
   253	
   254		This interface also allows for commands to be used. See the
   255		"Filter commands" section for more details.
   256	
   257		As a speed up, since processing strings can be quite expensive
   258		and requires a check of all functions registered to tracing, instead
   259		an index can be written into this file. A number (starting with "1")
   260		written will instead select the same corresponding at the line position
   261		of the "available_filter_functions" file.
   262	
   263	  set_ftrace_notrace:
   264	
   265		This has an effect opposite to that of
   266		set_ftrace_filter. Any function that is added here will not
   267		be traced. If a function exists in both set_ftrace_filter
   268		and set_ftrace_notrace,	the function will _not_ be traced.
   269	
   270	  set_ftrace_pid:
   271	
   272		Have the function tracer only trace the threads whose PID are
   273		listed in this file.
   274	
   275		If the "function-fork" option is set, then when a task whose
   276		PID is listed in this file forks, the child's PID will
   277		automatically be added to this file, and the child will be
   278		traced by the function tracer as well. This option will also
   279		cause PIDs of tasks that exit to be removed from the file.
   280	
   281	  set_ftrace_notrace_pid:
   282	
   283	        Have the function tracer ignore threads whose PID are listed in
   284	        this file.
   285	
   286	        If the "function-fork" option is set, then when a task whose
   287		PID is listed in this file forks, the child's PID will
   288		automatically be added to this file, and the child will not be
   289		traced by the function tracer as well. This option will also
   290		cause PIDs of tasks that exit to be removed from the file.
   291	
   292	        If a PID is in both this file and "set_ftrace_pid", then this
   293	        file takes precedence, and the thread will not be traced.
   294	
   295	  set_event_pid:
   296	
   297		Have the events only trace a task with a PID listed in this file.
   298		Note, sched_switch and sched_wake_up will also trace events
   299		listed in this file.
   300	
   301		To have the PIDs of children of tasks with their PID in this file
   302		added on fork, enable the "event-fork" option. That option will also
   303		cause the PIDs of tasks to be removed from this file when the task
   304		exits.
   305	
   306	  set_event_notrace_pid:
   307	
   308		Have the events not trace a task with a PID listed in this file.
   309		Note, sched_switch and sched_wakeup will trace threads not listed
   310		in this file, even if a thread's PID is in the file if the
   311	        sched_switch or sched_wakeup events also trace a thread that should
   312	        be traced.
   313	
   314		To have the PIDs of children of tasks with their PID in this file
   315		added on fork, enable the "event-fork" option. That option will also
   316		cause the PIDs of tasks to be removed from this file when the task
   317		exits.
   318	
   319	  set_graph_function:
   320	
   321		Functions listed in this file will cause the function graph
   322		tracer to only trace these functions and the functions that
   323		they call. (See the section "dynamic ftrace" for more details).
   324		Note, set_ftrace_filter and set_ftrace_notrace still affects
   325		what functions are being traced.
   326	
   327	  set_graph_notrace:
   328	
   329		Similar to set_graph_function, but will disable function graph
   330		tracing when the function is hit until it exits the function.
   331		This makes it possible to ignore tracing functions that are called
   332		by a specific function.
   333	
   334	  available_filter_functions:
   335	
   336		This lists the functions that ftrace has processed and can trace.
   337		These are the function names that you can pass to
   338		"set_ftrace_filter", "set_ftrace_notrace",
   339		"set_graph_function", or "set_graph_notrace".
   340		(See the section "dynamic ftrace" below for more details.)
   341	
   342	  available_filter_functions_addrs:
   343	
   344		Similar to available_filter_functions, but with address displayed
   345		for each function. The displayed address is the patch-site address
   346		and can differ from /proc/kallsyms address.
   347	
   348	  dyn_ftrace_total_info:
   349	
   350		This file is for debugging purposes. The number of functions that
   351		have been converted to nops and are available to be traced.
   352	
   353	  enabled_functions:
   354	
   355		This file is more for debugging ftrace, but can also be useful
   356		in seeing if any function has a callback attached to it.
   357		Not only does the trace infrastructure use ftrace function
   358		trace utility, but other subsystems might too. This file
   359		displays all functions that have a callback attached to them
   360		as well as the number of callbacks that have been attached.
   361		Note, a callback may also call multiple functions which will
   362		not be listed in this count.
   363	
   364		If the callback registered to be traced by a function with
   365		the "save regs" attribute (thus even more overhead), a 'R'
   366		will be displayed on the same line as the function that
   367		is returning registers.
   368	
   369		If the callback registered to be traced by a function with
   370		the "ip modify" attribute (thus the regs->ip can be changed),
   371		an 'I' will be displayed on the same line as the function that
   372		can be overridden.
   373	
   374		If a non ftrace trampoline is attached (BPF) a 'D' will be displayed.
   375		Note, normal ftrace trampolines can also be attached, but only one
   376		"direct" trampoline can be attached to a given function at a time.
   377	
   378		Some architectures can not call direct trampolines, but instead have
   379		the ftrace ops function located above the function entry point. In
   380		such cases an 'O' will be displayed.
   381	
   382		If a function had either the "ip modify" or a "direct" call attached to
   383		it in the past, a 'M' will be shown. This flag is never cleared. It is
   384		used to know if a function was every modified by the ftrace infrastructure,
   385		and can be used for debugging.
   386	
   387		If the architecture supports it, it will also show what callback
   388		is being directly called by the function. If the count is greater
   389		than 1 it most likely will be ftrace_ops_list_func().
   390	
   391		If the callback of a function jumps to a trampoline that is
   392		specific to the callback and which is not the standard trampoline,
   393		its address will be printed as well as the function that the
   394		trampoline calls.
   395	
   396	  touched_functions:
   397	
   398		This file contains all the functions that ever had a function callback
   399		to it via the ftrace infrastructure. It has the same format as
   400		enabled_functions but shows all functions that have every been
   401		traced.
   402	
   403		To see any function that has every been modified by "ip modify" or a
   404		direct trampoline, one can perform the following command:
   405	
   406		grep ' M ' /sys/kernel/tracing/touched_functions
   407	
   408	  function_profile_enabled:
   409	
   410		When set it will enable all functions with either the function
   411		tracer, or if configured, the function graph tracer. It will
   412		keep a histogram of the number of functions that were called
   413		and if the function graph tracer was configured, it will also keep
   414		track of the time spent in those functions. The histogram
   415		content can be displayed in the files:
   416	
   417		trace_stat/function<cpu> ( function0, function1, etc).
   418	
   419	  trace_stat:
   420	
   421		A directory that holds different tracing stats.
   422	
   423	  kprobe_events:
   424	
   425		Enable dynamic trace points. See kprobetrace.rst.
   426	
   427	  kprobe_profile:
   428	
   429		Dynamic trace points stats. See kprobetrace.rst.
   430	
   431	  max_graph_depth:
   432	
   433		Used with the function graph tracer. This is the max depth
   434		it will trace into a function. Setting this to a value of
   435		one will show only the first kernel function that is called
   436		from user space.
   437	
   438	  printk_formats:
   439	
   440		This is for tools that read the raw format files. If an event in
   441		the ring buffer references a string, only a pointer to the string
   442		is recorded into the buffer and not the string itself. This prevents
   443		tools from knowing what that string was. This file displays the string
   444		and address for	the string allowing tools to map the pointers to what
   445		the strings were.
   446	
   447	  saved_cmdlines:
   448	
   449		Only the pid of the task is recorded in a trace event unless
   450		the event specifically saves the task comm as well. Ftrace
   451		makes a cache of pid mappings to comms to try to display
   452		comms for events. If a pid for a comm is not listed, then
   453		"<...>" is displayed in the output.
   454	
   455		If the option "record-cmd" is set to "0", then comms of tasks
   456		will not be saved during recording. By default, it is enabled.
   457	
   458	  saved_cmdlines_size:
   459	
   460		By default, 128 comms are saved (see "saved_cmdlines" above). To
   461		increase or decrease the amount of comms that are cached, echo
   462		the number of comms to cache into this file.
   463	
   464	  saved_tgids:
   465	
   466		If the option "record-tgid" is set, on each scheduling context switch
   467		the Task Group ID of a task is saved in a table mapping the PID of
   468		the thread to its TGID. By default, the "record-tgid" option is
   469		disabled.
   470	
   471	  snapshot:
   472	
   473		This displays the "snapshot" buffer and also lets the user
   474		take a snapshot of the current running trace.
   475		See the "Snapshot" section below for more details.
   476	
   477	  stack_max_size:
   478	
   479		When the stack tracer is activated, this will display the
   480		maximum stack size it has encountered.
   481		See the "Stack Trace" section below.
   482	
   483	  stack_trace:
   484	
   485		This displays the stack back trace of the largest stack
   486		that was encountered when the stack tracer is activated.
   487		See the "Stack Trace" section below.
   488	
   489	  stack_trace_filter:
   490	
   491		This is similar to "set_ftrace_filter" but it limits what
   492		functions the stack tracer will check.
   493	
   494	  trace_clock:
   495	
   496		Whenever an event is recorded into the ring buffer, a
   497		"timestamp" is added. This stamp comes from a specified
   498		clock. By default, ftrace uses the "local" clock. This
   499		clock is very fast and strictly per cpu, but on some
   500		systems it may not be monotonic with respect to other
   501		CPUs. In other words, the local clocks may not be in sync
   502		with local clocks on other CPUs.
   503	
   504		Usual clocks for tracing::
   505	
   506		  # cat trace_clock
   507		  [local] global counter x86-tsc
   508	
   509		The clock with the square brackets around it is the one in effect.
   510	
   511		local:
   512			Default clock, but may not be in sync across CPUs
   513	
   514		global:
   515			This clock is in sync with all CPUs but may
   516			be a bit slower than the local clock.
   517	
   518		counter:
   519			This is not a clock at all, but literally an atomic
   520			counter. It counts up one by one, but is in sync
   521			with all CPUs. This is useful when you need to
   522			know exactly the order events occurred with respect to
   523			each other on different CPUs.
   524	
   525		uptime:
   526			This uses the jiffies counter and the time stamp
   527			is relative to the time since boot up.
   528	
   529		perf:
   530			This makes ftrace use the same clock that perf uses.
   531			Eventually perf will be able to read ftrace buffers
   532			and this will help out in interleaving the data.
   533	
   534		x86-tsc:
   535			Architectures may define their own clocks. For
   536			example, x86 uses its own TSC cycle clock here.
   537	
   538		ppc-tb:
   539			This uses the powerpc timebase register value.
   540			This is in sync across CPUs and can also be used
   541			to correlate events across hypervisor/guest if
   542			tb_offset is known.
   543	
   544		mono:
   545			This uses the fast monotonic clock (CLOCK_MONOTONIC)
   546			which is monotonic and is subject to NTP rate adjustments.
   547	
   548		mono_raw:
   549			This is the raw monotonic clock (CLOCK_MONOTONIC_RAW)
   550			which is monotonic but is not subject to any rate adjustments
   551			and ticks at the same rate as the hardware clocksource.
   552	
   553		boot:
   554			This is the boot clock (CLOCK_BOOTTIME) and is based on the
   555			fast monotonic clock, but also accounts for time spent in
   556			suspend. Since the clock access is designed for use in
   557			tracing in the suspend path, some side effects are possible
   558			if clock is accessed after the suspend time is accounted before
   559			the fast mono clock is updated. In this case, the clock update
   560			appears to happen slightly sooner than it normally would have.
   561			Also on 32-bit systems, it's possible that the 64-bit boot offset
   562			sees a partial update. These effects are rare and post
   563			processing should be able to handle them. See comments in the
   564			ktime_get_boot_fast_ns() function for more information.
   565	
   566		tai:
   567			This is the tai clock (CLOCK_TAI) and is derived from the wall-
   568			clock time. However, this clock does not experience
   569			discontinuities and backwards jumps caused by NTP inserting leap
   570			seconds. Since the clock access is designed for use in tracing,
   571			side effects are possible. The clock access may yield wrong
   572			readouts in case the internal TAI offset is updated e.g., caused
   573			by setting the system time or using adjtimex() with an offset.
   574			These effects are rare and post processing should be able to
   575			handle them. See comments in the ktime_get_tai_fast_ns()
   576			function for more information.
   577	
   578		To set a clock, simply echo the clock name into this file::
   579	
   580		  # echo global > trace_clock
   581	
   582		Setting a clock clears the ring buffer content as well as the
   583		"snapshot" buffer.
   584	
   585	  trace_marker:
   586	
   587		This is a very useful file for synchronizing user space
   588		with events happening in the kernel. Writing strings into
   589		this file will be written into the ftrace buffer.
   590	
   591		It is useful in applications to open this file at the start
   592		of the application and just reference the file descriptor
   593		for the file::
   594	
   595			void trace_write(const char *fmt, ...)
   596			{
   597				va_list ap;
   598				char buf[256];
   599				int n;
   600	
   601				if (trace_fd < 0)
   602					return;
   603	
   604				va_start(ap, fmt);
   605				n = vsnprintf(buf, 256, fmt, ap);
   606				va_end(ap);
   607	
   608				write(trace_fd, buf, n);
   609			}
   610	
   611		start::
   612	
   613			trace_fd = open("trace_marker", O_WRONLY);
   614	
   615		Note: Writing into the trace_marker file can also initiate triggers
   616		      that are written into /sys/kernel/tracing/events/ftrace/print/trigger
   617		      See "Event triggers" in Documentation/trace/events.rst and an
   618	              example in Documentation/trace/histogram.rst (Section 3.)
   619	
   620	  trace_marker_raw:
   621	
   622		This is similar to trace_marker above, but is meant for binary data
   623		to be written to it, where a tool can be used to parse the data
   624		from trace_pipe_raw.
   625	
   626	  uprobe_events:
   627	
   628		Add dynamic tracepoints in programs.
   629		See uprobetracer.rst
   630	
   631	  uprobe_profile:
   632	
   633		Uprobe statistics. See uprobetrace.txt
   634	
   635	  instances:
   636	
   637		This is a way to make multiple trace buffers where different
   638		events can be recorded in different buffers.
   639		See "Instances" section below.
   640	
   641	  events:
   642	
   643		This is the trace event directory. It holds event tracepoints
   644		(also known as static tracepoints) that have been compiled
   645		into the kernel. It shows what event tracepoints exist
   646		and how they are grouped by system. There are "enable"
   647		files at various levels that can enable the tracepoints
   648		when a "1" is written to them.
   649	
   650		See events.rst for more information.
   651	
   652	  set_event:
   653	
   654		By echoing in the event into this file, will enable that event.
   655	
   656		See events.rst for more information.
   657	
   658	  available_events:
   659	
   660		A list of events that can be enabled in tracing.
   661	
   662		See events.rst for more information.
   663	
   664	  timestamp_mode:
   665	
   666		Certain tracers may change the timestamp mode used when
   667		logging trace events into the event buffer.  Events with
   668		different modes can coexist within a buffer but the mode in
   669		effect when an event is logged determines which timestamp mode
   670		is used for that event.  The default timestamp mode is
   671		'delta'.
   672	
   673		Usual timestamp modes for tracing:
   674	
   675		  # cat timestamp_mode
   676		  [delta] absolute
   677	
   678		  The timestamp mode with the square brackets around it is the
   679		  one in effect.
   680	
   681		  delta: Default timestamp mode - timestamp is a delta against
   682		         a per-buffer timestamp.
   683	
   684		  absolute: The timestamp is a full timestamp, not a delta
   685	                 against some other value.  As such it takes up more
   686	                 space and is less efficient.
   687	
   688	  hwlat_detector:
   689	
   690		Directory for the Hardware Latency Detector.
   691		See "Hardware Latency Detector" section below.
   692	
   693	  per_cpu:
   694	
   695		This is a directory that contains the trace per_cpu information.
   696	
   697	  per_cpu/cpu0/buffer_size_kb:
   698	
   699		The ftrace buffer is defined per_cpu. That is, there's a separate
   700		buffer for each CPU to allow writes to be done atomically,
   701		and free from cache bouncing. These buffers may have different
   702		size buffers. This file is similar to the buffer_size_kb
   703		file, but it only displays or sets the buffer size for the
   704		specific CPU. (here cpu0).
   705	
   706	  per_cpu/cpu0/trace:
   707	
   708		This is similar to the "trace" file, but it will only display
   709		the data specific for the CPU. If written to, it only clears
   710		the specific CPU buffer.
   711	
   712	  per_cpu/cpu0/trace_pipe
   713	
   714		This is similar to the "trace_pipe" file, and is a consuming
   715		read, but it will only display (and consume) the data specific
   716		for the CPU.
   717	
   718	  per_cpu/cpu0/trace_pipe_raw
   719	
   720		For tools that can parse the ftrace ring buffer binary format,
   721		the trace_pipe_raw file can be used to extract the data
   722		from the ring buffer directly. With the use of the splice()
   723		system call, the buffer data can be quickly transferred to
   724		a file or to the network where a server is collecting the
   725		data.
   726	
   727		Like trace_pipe, this is a consuming reader, where multiple
   728		reads will always produce different data.
   729	
   730	  per_cpu/cpu0/snapshot:
   731	
   732		This is similar to the main "snapshot" file, but will only
   733		snapshot the current CPU (if supported). It only displays
   734		the content of the snapshot for a given CPU, and if
   735		written to, only clears this CPU buffer.
   736	
   737	  per_cpu/cpu0/snapshot_raw:
   738	
   739		Similar to the trace_pipe_raw, but will read the binary format
   740		from the snapshot buffer for the given CPU.
   741	
   742	  per_cpu/cpu0/stats:
   743	
   744		This displays certain stats about the ring buffer:
   745	
   746		entries:
   747			The number of events that are still in the buffer.
   748	
   749		overrun:
   750			The number of lost events due to overwriting when
   751			the buffer was full.
   752	
   753		commit overrun:
   754			Should always be zero.
   755			This gets set if so many events happened within a nested
   756			event (ring buffer is re-entrant), that it fills the
   757			buffer and starts dropping events.
   758	
   759		bytes:
   760			Bytes actually read (not overwritten).
   761	
   762		oldest event ts:
   763			The oldest timestamp in the buffer
   764	
   765		now ts:
   766			The current timestamp
   767	
   768		dropped events:
   769			Events lost due to overwrite option being off.
   770	
   771		read events:
   772			The number of events read.
   773	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

