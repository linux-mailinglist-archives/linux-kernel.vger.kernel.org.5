Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5265175A7C7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjGTH3z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Jul 2023 03:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjGTH3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:29:52 -0400
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4E02118;
        Thu, 20 Jul 2023 00:29:50 -0700 (PDT)
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay05.hostedemail.com (Postfix) with ESMTP id 5A86E401AC;
        Thu, 20 Jul 2023 07:29:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id E4DEC20028;
        Thu, 20 Jul 2023 07:29:43 +0000 (UTC)
Message-ID: <589412dd594b7efc618728fe68ad6c86f3c60878.camel@perches.com>
Subject: Re: [PATCH rcu 5/5] checkpatch: Complain about unexpected uses of
 RCU Tasks Trace
From:   Joe Perches <joe@perches.com>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Date:   Thu, 20 Jul 2023 00:29:42 -0700
In-Reply-To: <8477fd32-38a5-4d66-8deb-a61b0e290df5@paulmck-laptop>
References: <a6fff63c-5930-4918-82a3-a9301309d88d@paulmck-laptop>
         <20230717180454.1097714-5-paulmck@kernel.org>
         <04e74fd214a01bee0fb5ac690730cb386536cced.camel@perches.com>
         <8477fd32-38a5-4d66-8deb-a61b0e290df5@paulmck-laptop>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Stat-Signature: cijt47qa3gutgm4mse8f61ihc156sytj
X-Rspamd-Server: rspamout07
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: E4DEC20028
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19bWiq7WZ/5O5QREbocb7bKaf2iJ1IJsm8=
X-HE-Tag: 1689838183-320032
X-HE-Meta: U2FsdGVkX1/WarbZk931biGimJZzUmR0O/BUkC16MDMYi+FZCE9vkChV5+1oQv6fW7ys3SKQXW6ny8ivNo+4hr59Zu0HwPgQVExCwjMOWdBjkXj1wru2zKknxwNVBrYhpYn3niGT0jMfQaKKf5f2K+lZNMiT/Tuu0zydTf+uBcVFdyzJpgNCqTHtB/RwZNqaaJH3+WWoKuBdrBdTfOyTyol2UlAOv9t7t6x1uwPo33MeFYV3deDRqHFbev2Xfx3cBsG+gkVwiwRtStG89YFKfgTozhO0ixB3fYkRsV8GMqTEQcmqZgsAxa6w76geQUWVpfdy6KJHLa/FHKsZ+1wKwkhWHVT9ncBcctS0nvMkNa9f8w75v8m2Iwpm3CW7x51aSRX2TcwtlxR5eKcfSI9NMEFRuusF334j39b6nkzTbutvUyxguv6WODZhCYB35codJJ0JdujRE//8K4pa6ZyjVJevUpcc5HdLH3YoN5mccX05SDuyrKmHmx93iyb6J6K98o592DeGGMU1+AQYQZNLni5OtqEPJxqhM90T6jyrh+HXqY829BrUsXQFRu6vlMqmmQpeC1NKC3I=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-07-17 at 16:34 -0700, Paul E. McKenney wrote:
> On Mon, Jul 17, 2023 at 03:34:14PM -0700, Joe Perches wrote:
> > On Mon, 2023-07-17 at 11:04 -0700, Paul E. McKenney wrote:
> > > RCU Tasks Trace is quite specialized, having been created specifically
> > > for sleepable BPF programs.  Because it allows general blocking within
> > > readers, any new use of RCU Tasks Trace must take current use cases into
> > > account.  Therefore, update checkpatch.pl to complain about use of any of
> > > the RCU Tasks Trace API members outside of BPF and outside of RCU itself.
> > > 
> > > Cc: Andy Whitcroft <apw@canonical.com> (maintainer:CHECKPATCH)
> > > Cc: Joe Perches <joe@perches.com> (maintainer:CHECKPATCH)
> > > Cc: Dwaipayan Ray <dwaipayanray1@gmail.com> (reviewer:CHECKPATCH)
> > > Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > > Cc: John Fastabend <john.fastabend@gmail.com>
> > > Cc: <bpf@vger.kernel.org>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > ---
> > >  scripts/checkpatch.pl | 18 ++++++++++++++++++
> > >  1 file changed, 18 insertions(+)
> > > 
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > []
> > > @@ -7457,6 +7457,24 @@ sub process {
> > >  			}
> > >  		}
> > >  
> > > +# Complain about RCU Tasks Trace used outside of BPF (and of course, RCU).
> > > +		if ($line =~ /\brcu_read_lock_trace\s*\(/ ||
> > > +		    $line =~ /\brcu_read_lock_trace_held\s*\(/ ||
> > > +		    $line =~ /\brcu_read_unlock_trace\s*\(/ ||
> > > +		    $line =~ /\bcall_rcu_tasks_trace\s*\(/ ||
> > > +		    $line =~ /\bsynchronize_rcu_tasks_trace\s*\(/ ||
> > > +		    $line =~ /\brcu_barrier_tasks_trace\s*\(/ ||
> > > +		    $line =~ /\brcu_request_urgent_qs_task\s*\(/) {
> > > +			if ($realfile !~ m@^kernel/bpf@ &&
> > > +			    $realfile !~ m@^include/linux/bpf@ &&
> > > +			    $realfile !~ m@^net/bpf@ &&
> > > +			    $realfile !~ m@^kernel/rcu@ &&
> > > +			    $realfile !~ m@^include/linux/rcu@) {
> > 
> > Functions and paths like these tend to be accreted.
> > 
> > Please use a variable or 2 like:
> > 
> > our $rcu_trace_funcs = qr{(?x:
> > 	rcu_read_lock_trace |
> > 	rcu_read_lock_trace_held |
> > 	rcu_read_unlock_trace |
> > 	call_rcu_tasks_trace |
> > 	synchronize_rcu_tasks_trace |
> > 	rcu_barrier_tasks_trace |
> > 	rcu_request_urgent_qs_task
> > )};
> > our $rcu_trace_paths = qr{(?x:
> > 	kernel/bfp/ |
		^^
	kernel/bfp/ |

(umm, oops...)
I think my original suggestion works better when I don't typo the path.

> > 	include/linux/bpf |
> > 	net/bpf/ |
> > 	kernel/rcu/ |
> > 	include/linux/rcu
> > )};
> 
> Like this?
> 
> # Complain about RCU Tasks Trace used outside of BPF (and of course, RCU).
> 		our $rcu_trace_funcs = qr{(?x:
> 			rcu_read_lock_trace |
> 			rcu_read_lock_trace_held |
> 			rcu_read_unlock_trace |
> 			call_rcu_tasks_trace |
> 			synchronize_rcu_tasks_trace |
> 			rcu_barrier_tasks_trace |
> 			rcu_request_urgent_qs_task
> 		)};
> 		our $rcu_trace_paths = qr{(?x:
> 			kernel/bfp/ |
> 			include/linux/bpf |
> 			net/bpf/ |
> 			kernel/rcu/ |
> 			include/linux/rcu
> 		)};
> 		if ($line =~ /$rcu_trace_funcs/) {
> 			if ($realfile !~ m@^$rcu_trace_paths@) {
> 				WARN("RCU_TASKS_TRACE",
> 				     "use of RCU tasks trace is incorrect outside BPF or core RCU code\n" . $herecurr);
> 			}
> 		}
> 
> No, that is definitely wrong.  It has lost track of the list of pathnames,
> thus complaining about uses of those functions in files where their use
> is permitted.
> 
> But this seems to work:
> 
> # Complain about RCU Tasks Trace used outside of BPF (and of course, RCU).
> 		our $rcu_trace_funcs = qr{(?x:
> 			rcu_read_lock_trace |
> 			rcu_read_lock_trace_held |
> 			rcu_read_unlock_trace |
> 			call_rcu_tasks_trace |
> 			synchronize_rcu_tasks_trace |
> 			rcu_barrier_tasks_trace |
> 			rcu_request_urgent_qs_task
> 		)};
> 		if ($line =~ /\b$rcu_trace_funcs\s*\(/) {
> 			if ($realfile !~ m@^kernel/bpf@ &&
> 			    $realfile !~ m@^include/linux/bpf@ &&
> 			    $realfile !~ m@^net/bpf@ &&
> 			    $realfile !~ m@^kernel/rcu@ &&
> 			    $realfile !~ m@^include/linux/rcu@) {
> 				WARN("RCU_TASKS_TRACE",
> 				     "use of RCU tasks trace is incorrect outside BPF or core RCU code\n" . $herecurr);
> 			}
> 		}
> 
> Maybe the "^" needs to be distributed into $rcu_trace_paths?
> 
> # Complain about RCU Tasks Trace used outside of BPF (and of course, RCU).
> 		our $rcu_trace_funcs = qr{(?x:
> 			rcu_read_lock_trace |
> 			rcu_read_lock_trace_held |
> 			rcu_read_unlock_trace |
> 			call_rcu_tasks_trace |
> 			synchronize_rcu_tasks_trace |
> 			rcu_barrier_tasks_trace |
> 			rcu_request_urgent_qs_task
> 		)};
> 		our $rcu_trace_paths = qr{(?x:
> 			^kernel/bfp/ |
> 			^include/linux/bpf |
> 			^net/bpf/ |
> 			^kernel/rcu/ |
> 			^include/linux/rcu
> 		)};
> 		if ($line =~ /\b$rcu_trace_funcs\s*\(/) {
> 			if ($realfile !~ m@$rcu_trace_paths@) {
> 				WARN("RCU_TASKS_TRACE",
> 				     "use of RCU tasks trace is incorrect outside BPF or core RCU code\n" . $herecurr);
> 			}
> 		}
> 
> But no joy here, either.  Which is no surprise, given that perl is
> happy to distribute the "\b" and the "\s*\(" across the elements of
> $rcu_trace_funcs.  I tried a number of other variations, including
> inverting the "if" condition "(!(... =~ ...))", inverting the "if"
> condition via an empty "then" clause, replacing the "m@" with "/",
> replacing the "|" in the "qr{}" with "&", and a few others.
> 
> Again, listing the pathnames explicitly in the second "if" condition
> works just fine.
> 
> Help?
> 
> 							Thanx, Paul

