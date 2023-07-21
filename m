Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BA775BD01
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 05:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjGUD4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 23:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGUD4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 23:56:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C401BC1;
        Thu, 20 Jul 2023 20:56:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92FDB60F75;
        Fri, 21 Jul 2023 03:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27ABC433C8;
        Fri, 21 Jul 2023 03:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689911788;
        bh=ptN+xqdqGtJBNVF0prBj0UHOwsUmf9X9j22+xdsbzYQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=K+vv3lg+OI70LpRyVPsQimFB7WygaM6fbPNx7u0ZsLtuh9nycdZq5gMH63sRZGlTl
         hkYulhs5rpMIB0+AYqAJIFtDlUcDicDkc1jTPzQrSqMOh4/r8X2WvWbwQ6dFK/mY7W
         n82T6GI9M9W7SiNTb1TeBzAFgpgX0WzBA92WKxNMcf2gBo/blMBpuNxI9gPYt8N7K4
         LsIzBUBcHCd7TDpq74nsNzYzpqsu91KMG0HxrVVbNrre+pm2Jrx5rw2QjDfDeSryzP
         /aeOjj5edAIFQwID1PNFWwbQDR/9z0SlRi/2HAci4HcbVsyIy6JTyXKOC6lAd46prj
         RzArTxCmtmxrg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7D767CE09F7; Thu, 20 Jul 2023 20:56:27 -0700 (PDT)
Date:   Thu, 20 Jul 2023 20:56:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH rcu 5/5] checkpatch: Complain about unexpected uses of
 RCU Tasks Trace
Message-ID: <c0ca3071-231a-49b1-b153-38ff0328470d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a6fff63c-5930-4918-82a3-a9301309d88d@paulmck-laptop>
 <20230717180454.1097714-5-paulmck@kernel.org>
 <04e74fd214a01bee0fb5ac690730cb386536cced.camel@perches.com>
 <8477fd32-38a5-4d66-8deb-a61b0e290df5@paulmck-laptop>
 <589412dd594b7efc618728fe68ad6c86f3c60878.camel@perches.com>
 <798959b0-b107-44c4-8262-075930ebfeaa@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <798959b0-b107-44c4-8262-075930ebfeaa@paulmck-laptop>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 12:43:55PM -0700, Paul E. McKenney wrote:
> On Thu, Jul 20, 2023 at 12:29:42AM -0700, Joe Perches wrote:
> > On Mon, 2023-07-17 at 16:34 -0700, Paul E. McKenney wrote:
> > > On Mon, Jul 17, 2023 at 03:34:14PM -0700, Joe Perches wrote:
> > > > On Mon, 2023-07-17 at 11:04 -0700, Paul E. McKenney wrote:
> > > > > RCU Tasks Trace is quite specialized, having been created specifically
> > > > > for sleepable BPF programs.  Because it allows general blocking within
> > > > > readers, any new use of RCU Tasks Trace must take current use cases into
> > > > > account.  Therefore, update checkpatch.pl to complain about use of any of
> > > > > the RCU Tasks Trace API members outside of BPF and outside of RCU itself.
> > > > > 
> > > > > Cc: Andy Whitcroft <apw@canonical.com> (maintainer:CHECKPATCH)
> > > > > Cc: Joe Perches <joe@perches.com> (maintainer:CHECKPATCH)
> > > > > Cc: Dwaipayan Ray <dwaipayanray1@gmail.com> (reviewer:CHECKPATCH)
> > > > > Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > > > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > > > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > > > > Cc: John Fastabend <john.fastabend@gmail.com>
> > > > > Cc: <bpf@vger.kernel.org>
> > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > ---
> > > > >  scripts/checkpatch.pl | 18 ++++++++++++++++++
> > > > >  1 file changed, 18 insertions(+)
> > > > > 
> > > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > > []
> > > > > @@ -7457,6 +7457,24 @@ sub process {
> > > > >  			}
> > > > >  		}
> > > > >  
> > > > > +# Complain about RCU Tasks Trace used outside of BPF (and of course, RCU).
> > > > > +		if ($line =~ /\brcu_read_lock_trace\s*\(/ ||
> > > > > +		    $line =~ /\brcu_read_lock_trace_held\s*\(/ ||
> > > > > +		    $line =~ /\brcu_read_unlock_trace\s*\(/ ||
> > > > > +		    $line =~ /\bcall_rcu_tasks_trace\s*\(/ ||
> > > > > +		    $line =~ /\bsynchronize_rcu_tasks_trace\s*\(/ ||
> > > > > +		    $line =~ /\brcu_barrier_tasks_trace\s*\(/ ||
> > > > > +		    $line =~ /\brcu_request_urgent_qs_task\s*\(/) {
> > > > > +			if ($realfile !~ m@^kernel/bpf@ &&
> > > > > +			    $realfile !~ m@^include/linux/bpf@ &&
> > > > > +			    $realfile !~ m@^net/bpf@ &&
> > > > > +			    $realfile !~ m@^kernel/rcu@ &&
> > > > > +			    $realfile !~ m@^include/linux/rcu@) {
> > > > 
> > > > Functions and paths like these tend to be accreted.
> > > > 
> > > > Please use a variable or 2 like:
> > > > 
> > > > our $rcu_trace_funcs = qr{(?x:
> > > > 	rcu_read_lock_trace |
> > > > 	rcu_read_lock_trace_held |
> > > > 	rcu_read_unlock_trace |
> > > > 	call_rcu_tasks_trace |
> > > > 	synchronize_rcu_tasks_trace |
> > > > 	rcu_barrier_tasks_trace |
> > > > 	rcu_request_urgent_qs_task
> > > > )};
> > > > our $rcu_trace_paths = qr{(?x:
> > > > 	kernel/bfp/ |
> > 		^^
> > 	kernel/bfp/ |
> > 
> > (umm, oops...)
> > I think my original suggestion works better when I don't typo the path.
> 
> Color me blind!  ;-)
> 
> That works much better, thank you!  I will update the patch on my
> next rebase.

As shown below.  Is this what you had in mind?

							Thanx, Paul

------------------------------------------------------------------------

commit 496aa3821b40459b107f4bbc14ca867daad21fb6
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Jul 6 11:48:07 2023 -0700

    checkpatch: Complain about unexpected uses of RCU Tasks Trace
    
    RCU Tasks Trace is quite specialized, having been created specifically
    for sleepable BPF programs.  Because it allows general blocking within
    readers, any new use of RCU Tasks Trace must take current use cases into
    account.  Therefore, update checkpatch.pl to complain about use of any of
    the RCU Tasks Trace API members outside of BPF and outside of RCU itself.
    
    [ paulmck: Apply Joe Perches feedback. ]
    
    Cc: Andy Whitcroft <apw@canonical.com> (maintainer:CHECKPATCH)
    Cc: Joe Perches <joe@perches.com> (maintainer:CHECKPATCH)
    Cc: Dwaipayan Ray <dwaipayanray1@gmail.com> (reviewer:CHECKPATCH)
    Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
    Cc: Alexei Starovoitov <ast@kernel.org>
    Cc: Daniel Borkmann <daniel@iogearbox.net>
    Cc: John Fastabend <john.fastabend@gmail.com>
    Cc: <bpf@vger.kernel.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 880fde13d9b8..a67e682e896c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7457,6 +7457,30 @@ sub process {
 			}
 		}
 
+# Complain about RCU Tasks Trace used outside of BPF (and of course, RCU).
+		our $rcu_trace_funcs = qr{(?x:
+			rcu_read_lock_trace |
+			rcu_read_lock_trace_held |
+			rcu_read_unlock_trace |
+			call_rcu_tasks_trace |
+			synchronize_rcu_tasks_trace |
+			rcu_barrier_tasks_trace |
+			rcu_request_urgent_qs_task
+		)};
+		our $rcu_trace_paths = qr{(?x:
+			kernel/bpf/ |
+			include/linux/bpf |
+			net/bpf/ |
+			kernel/rcu/ |
+			include/linux/rcu
+		)};
+		if ($line =~ /\b$rcu_trace_funcs\s*\(/) {
+			if ($realfile !~ m@^$rcu_trace_paths@) {
+				WARN("RCU_TASKS_TRACE",
+				     "use of RCU tasks trace is incorrect outside BPF or core RCU code\n" . $herecurr);
+			}
+		}
+
 # check for lockdep_set_novalidate_class
 		if ($line =~ /^.\s*lockdep_set_novalidate_class\s*\(/ ||
 		    $line =~ /__lockdep_no_validate__\s*\)/ ) {
