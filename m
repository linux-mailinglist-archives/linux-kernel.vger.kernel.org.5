Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB8F7B6B0F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238430AbjJCOH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjJCOHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:07:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FCBA3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:07:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F8DC433C7;
        Tue,  3 Oct 2023 14:07:49 +0000 (UTC)
Date:   Tue, 3 Oct 2023 10:08:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org,
        Michael Jeanson <mjeanson@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [RFC PATCH v3 1/5] tracing: Introduce faultable tracepoints
 (v3)
Message-ID: <20231003100854.7285d2a9@gandalf.local.home>
In-Reply-To: <5d0771e9-332c-42cd-acf3-53d46bb691f3@paulmck-laptop>
References: <20231002202531.3160-1-mathieu.desnoyers@efficios.com>
        <20231002202531.3160-2-mathieu.desnoyers@efficios.com>
        <20231002191023.6175294d@gandalf.local.home>
        <97c559c9-51cf-415c-8b0b-39eba47b8898@paulmck-laptop>
        <20231002211936.5948253e@gandalf.local.home>
        <5d0771e9-332c-42cd-acf3-53d46bb691f3@paulmck-laptop>
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

On Tue, 3 Oct 2023 06:44:50 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > That way it is clear what uses what, as I read the original paragraph a
> > couple of times and could have sworn that rcu_read_lock_trace() required
> > tasks to not block.  
> 
> That would work for me.  Would you like to send a patch, or would you
> rather we made the adjustments?

Which ever.

-- Steve
