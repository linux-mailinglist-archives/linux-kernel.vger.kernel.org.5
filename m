Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FA1756FD9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 00:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjGQWe0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jul 2023 18:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjGQWeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 18:34:25 -0400
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B23FB5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:34:23 -0700 (PDT)
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay04.hostedemail.com (Postfix) with ESMTP id D40B71A05CE;
        Mon, 17 Jul 2023 22:34:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 68AEC2002D;
        Mon, 17 Jul 2023 22:34:15 +0000 (UTC)
Message-ID: <04e74fd214a01bee0fb5ac690730cb386536cced.camel@perches.com>
Subject: Re: [PATCH rcu 5/5] checkpatch: Complain about unexpected uses of
 RCU Tasks Trace
From:   Joe Perches <joe@perches.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Date:   Mon, 17 Jul 2023 15:34:14 -0700
In-Reply-To: <20230717180454.1097714-5-paulmck@kernel.org>
References: <a6fff63c-5930-4918-82a3-a9301309d88d@paulmck-laptop>
         <20230717180454.1097714-5-paulmck@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 68AEC2002D
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout02
X-Stat-Signature: ydqcdtaadgq3km87eotg8j8pd3mh6b44
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX199v8b1YJAszH97EHPUzWOIn/skmRIxrWs=
X-HE-Tag: 1689633255-124912
X-HE-Meta: U2FsdGVkX18q26xURpW9+7yIL42BuR4Zkw3canI6Q+OaBoEjxOlN4sWO2r2VSPNWSpmqVT2U5xjk7hqFilI04qYOR0SfI2y77lfk9KiC3ksoCTNcalQJLUoOAbm22blsjRiMqKOOFrUtlbPz6p8+1d3RDEZbL/cNxlrRGIfcABTMjv3YW1yQx0HxurQICyXOXY9236m5b8jXkMAeP0DYKYxDMi65GeHRr0wfvh9DCQC0GClucM3KkPEVsRmbrk7JhWDR+6wyGr+fOq244GpBh558PLQ5RW7Lww8erKmNSkQT7MZpMM4KYity//XXO3qESACljOpJ+E3tdzooYjEbv8kH5JOZyxBEuVOEoeG832GISOUxT7dNW0VHoYb0GJ3O0Dfry58QH0V6GhebW2QhLmXhRMKWe3CIv9dyqT1ngG8zSlaC0dQSWlqxxIoWa3U7y2SNQ0Y7BcNEzDK9dcTvxzLAnjtAsIMeLRs+sbYfkB4NOOwrQ9nSYcmJO+ZB5L1M6UpJzh3c0UzxOi/2KW/ZI41TxOlm/8dRVG1Z+KpHLl8U10glR/PgjHnG7cFTil2GKT2UWE5WrRo=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-07-17 at 11:04 -0700, Paul E. McKenney wrote:
> RCU Tasks Trace is quite specialized, having been created specifically
> for sleepable BPF programs.  Because it allows general blocking within
> readers, any new use of RCU Tasks Trace must take current use cases into
> account.  Therefore, update checkpatch.pl to complain about use of any of
> the RCU Tasks Trace API members outside of BPF and outside of RCU itself.
> 
> Cc: Andy Whitcroft <apw@canonical.com> (maintainer:CHECKPATCH)
> Cc: Joe Perches <joe@perches.com> (maintainer:CHECKPATCH)
> Cc: Dwaipayan Ray <dwaipayanray1@gmail.com> (reviewer:CHECKPATCH)
> Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: <bpf@vger.kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  scripts/checkpatch.pl | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -7457,6 +7457,24 @@ sub process {
>  			}
>  		}
>  
> +# Complain about RCU Tasks Trace used outside of BPF (and of course, RCU).
> +		if ($line =~ /\brcu_read_lock_trace\s*\(/ ||
> +		    $line =~ /\brcu_read_lock_trace_held\s*\(/ ||
> +		    $line =~ /\brcu_read_unlock_trace\s*\(/ ||
> +		    $line =~ /\bcall_rcu_tasks_trace\s*\(/ ||
> +		    $line =~ /\bsynchronize_rcu_tasks_trace\s*\(/ ||
> +		    $line =~ /\brcu_barrier_tasks_trace\s*\(/ ||
> +		    $line =~ /\brcu_request_urgent_qs_task\s*\(/) {
> +			if ($realfile !~ m@^kernel/bpf@ &&
> +			    $realfile !~ m@^include/linux/bpf@ &&
> +			    $realfile !~ m@^net/bpf@ &&
> +			    $realfile !~ m@^kernel/rcu@ &&
> +			    $realfile !~ m@^include/linux/rcu@) {

Functions and paths like these tend to be accreted.

Please use a variable or 2 like:

our $rcu_trace_funcs = qr{(?x:
	rcu_read_lock_trace |
	rcu_read_lock_trace_held |
	rcu_read_unlock_trace |
	call_rcu_tasks_trace |
	synchronize_rcu_tasks_trace |
	rcu_barrier_tasks_trace |
	rcu_request_urgent_qs_task
)};
our $rcu_trace_paths = qr{(?x:
	kernel/bfp/ |
	include/linux/bpf |
	net/bpf/ |
	kernel/rcu/ |
	include/linux/rcu
)};

...
	
		if ($line =~ /\b($rcu_trace_funcs)\s*\(/ &&
		    $realfile !~ m{^$rcu_trace_paths}) {
			WARN("RCU_TASKS_TRACE",
			     "use of RCU tasks trace '$1' is incorrect outside BPF or core RCU code\n" . $herecurr);			}
		}


