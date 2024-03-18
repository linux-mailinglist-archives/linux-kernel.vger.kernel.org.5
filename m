Return-Path: <linux-kernel+bounces-106322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 979CE87EC5F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383B61F235BE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B65752F6E;
	Mon, 18 Mar 2024 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4vsvdxA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4FC524BD;
	Mon, 18 Mar 2024 15:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710776584; cv=none; b=uegpGwZG+iwiA5YO1Zc0D0FZwjneWlUnjXFw0GzCTEanQQDnzGDYZTkp6KnIwgz8qyPV7CxOLHRZ8WAbpRyEjPuteobM7zuwtL+KTbb2075bY2H504/G2Wv3/JY9OPFeSDFD85sG5i26k5uHIJ6VcQ3sWPJObgK09diAaXsMWtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710776584; c=relaxed/simple;
	bh=qhMgOtaICUkeTtfPcfP/CSjZBvXls4O81TYsjiRoEvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKVIf6fXhcqmosQBu4qN5b47art7EimJQ3a3CTZOS2LW2tMsCL2vYSMdmnmXmOeBD2lB6tXj0KFepau5CTv9pa+Xfy7lYveFRE9ki0HwFoblmYkk+hklHgFKM/A+mXzCwUP1FQS7XBI9/1mFAgrckK9gs2OwLMAgBNAQU8rHFn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4vsvdxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80050C433F1;
	Mon, 18 Mar 2024 15:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710776584;
	bh=qhMgOtaICUkeTtfPcfP/CSjZBvXls4O81TYsjiRoEvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q4vsvdxAU2l9z+ABU4RNeEHXMVDq+x6oeTzCY4PBlnTBwWbudF9cqa3JqwhJrZjiq
	 cqasOHoiPvZRptYizIAOrw7xVPey3bDT7Tyjy5Ykrz9fRs5sgAoZMVCNcovf0uDzjk
	 kp+PK/zTi4ecEIlvmiopxrMmztkLm/kriYVibp8QpGpN9ElLgrfgs7fOjH84T4MUH7
	 L0ZgdVRhj4ay96G30DD5vPXI2AX36Y7E4HU/K8f656bzaZ4qQwmjksSBEvpbUazver
	 GJcoyshDydV88jViUQBbX9r2PJZ+Jk80X5qdyUhKv21BctkaLQv3rDdgnfrem301EG
	 Gk1NfGnFxDM8Q==
Date: Mon, 18 Mar 2024 08:43:00 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Netdev <netdev@vger.kernel.org>,
	clang-built-linux <llvm@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	"David S. Miller" <davem@davemloft.net>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Eric Dumazet <edumazet@google.com>, rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: net/sunrpc/sched.c: error: result of comparison against a string
 literal is unspecified (use an explicit string comparison function instead)
Message-ID: <20240318154300.GA816320@dev-arch.thelio-3990X>
References: <CA+G9fYs=OTKAZS6g1P1Ewadfr0qoe6LgOVSohqkXmFXotEODdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYs=OTKAZS6g1P1Ewadfr0qoe6LgOVSohqkXmFXotEODdg@mail.gmail.com>

Hi Naresh,

On Mon, Mar 18, 2024 at 02:55:54PM +0530, Naresh Kamboju wrote:
> The following build warnings / errors noticed on x86 kselftests build with
> clang nightly  / clang-17 on Linux  next tag next-20240318.
> 
> This build config is generated from kselftest merge configs [1].
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Build log:
> -----------
> In file included from net/sunrpc/sched.c:31:
> In file included from include/trace/events/sunrpc.h:2524:
> In file included from include/trace/define_trace.h:102:
> In file included from include/trace/trace_events.h:419:
> include/trace/events/sunrpc.h:707:4: error: result of comparison
> against a string literal is unspecified (use an explicit string
> comparison function instead) [-Werror,-Wstring-compare]
>   667 |                         __assign_str(progname,
>       |                         ~~~~~~~~~~~~~~~~~~~~~~
>   668 |                                      task->tk_client->cl_program->name);
>       |                                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   669 |                         __entry->version = task->tk_client->cl_vers;
>       |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   670 |                         __assign_str(procedure,
> task->tk_msg.rpc_proc->p_name);
>       |

Thanks for the report. This is caused by commit 433e1d88a3be ("tracing:
Add warning if string in __assign_str() does not match __string()") from
the tracing tree, not a change on the netdev side (although I have left
them on CC for this reply so they are aware of that).

To resolve it, [1] needs to be applied then the following diff can be
applied on top of that to fully clear it up (as __builtin_constant_p()
does not influence diagnostics in the front end, so the warning still
triggers on the else branch when it will really use strcmp(), as Steve
tested at [2]).

[1]: https://lore.kernel.org/20240312113002.00031668@gandalf.local.home/
[2]: https://lore.kernel.org/20240313161420.3b668558@gandalf.local.home/

diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/stages/stage6_event_callback.h
index 83da83a0c14f..dbd27adb1b83 100644
--- a/include/trace/stages/stage6_event_callback.h
+++ b/include/trace/stages/stage6_event_callback.h
@@ -35,9 +35,14 @@
 	do {								\
 		char *__str__ = __get_str(dst);				\
 		int __len__ = __get_dynamic_array_len(dst) - 1;		\
+		__diag_push();						\
+		__diag_ignore(clang, 13, "-Wstring-compare",		\
+			      "__builtin_constant_p() ensures strcmp()"	\
+			      "will be used for string literals");	\
 		WARN_ON_ONCE(__builtin_constant_p(src) ?		\
 			     strcmp((src), __data_offsets.dst##_ptr_) :	\
 			     (src) != __data_offsets.dst##_ptr_);	\
+		__diag_pop();						\
 		memcpy(__str__, __data_offsets.dst##_ptr_ ? :		\
 		       EVENT_NULL_STR, __len__);			\
 		__str__[__len__] = '\0';				\

