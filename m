Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C02F7F315C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbjKUOoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbjKUOof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:44:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40559E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:44:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5174C433C8;
        Tue, 21 Nov 2023 14:44:29 +0000 (UTC)
Date:   Tue, 21 Nov 2023 09:44:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org,
        Michael Jeanson <mjeanson@efficios.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v4 1/5] tracing: Introduce faultable tracepoints
Message-ID: <20231121094444.04701bdc@gandalf.local.home>
In-Reply-To: <20231121143647.GI8262@noisy.programming.kicks-ass.net>
References: <20231120205418.334172-1-mathieu.desnoyers@efficios.com>
        <20231120205418.334172-2-mathieu.desnoyers@efficios.com>
        <20231120214742.GC8262@noisy.programming.kicks-ass.net>
        <62c6e37c-88cc-43f7-ac3f-1c14059277cc@paulmck-laptop>
        <20231120222311.GE8262@noisy.programming.kicks-ass.net>
        <cfc4b94e-8076-4e44-a8a7-2fd42dd9f2f2@paulmck-laptop>
        <20231121084706.GF8262@noisy.programming.kicks-ass.net>
        <a0ac5f77-411e-4562-9863-81196238f3f5@efficios.com>
        <20231121143647.GI8262@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023 15:36:47 +0100
Peter Zijlstra <peterz@infradead.org> wrote:
> 
> Still utterly confused about what task-tracing rcu is and how it is
> different from preemptible rcu.

Is this similar to synchronize_rcu_tasks()? As I understand that one (grace
period continues until all tasks have voluntarily scheduled or gone into
user space). But I'm a bit confused by synchronize_rcu_tasks_trace()?

Note, that for syncronize_rcu_tasks() the critical sections must not call
schedule (although it is OK to be preempted).

-- Steve
