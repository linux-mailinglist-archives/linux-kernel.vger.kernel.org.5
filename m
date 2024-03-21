Return-Path: <linux-kernel+bounces-109814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6451D885607
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948FA1C20D06
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B43226AFC;
	Thu, 21 Mar 2024 08:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gmijaw2Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB56C2E6;
	Thu, 21 Mar 2024 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711010911; cv=none; b=POkeegujKDJefQwtBXXOKE92IFqx8jXe3BcdF1rksGqYf/BrZ2LA00T4v61GETlSo9/7DhDn3C9xnUTuX4u+lYBdXxEI41Artw8siklMNr3RBxCtTPersmXEeEXSdqVJ/bOtKwfMzib29hcuNtj3ZrIK1Wffk6NnrYjyvILvjhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711010911; c=relaxed/simple;
	bh=15ZtzjY1fNYkJ0k0FnRr+bctv3Yg6O2wYPUdrRw1jU4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M2vQxA5NaM9Nx2pQQmOpN9211CHDnpr2XPDzo8FBU19OLBLSj7bfRbAH5HmEzi2w4eG+rrafw7KVVyCMGQdj5d2UaARLdGMDhRV6SsDfMegTCPbySHnRrLdMl0TlY71j7xmlW0glVNhB3XxAOS4dkROYizMpldLc/cxQggdoipE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gmijaw2Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DD6C433C7;
	Thu, 21 Mar 2024 08:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711010911;
	bh=15ZtzjY1fNYkJ0k0FnRr+bctv3Yg6O2wYPUdrRw1jU4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Gmijaw2QPhHATpi68Owc0NGfwiqqzkpz2elHJSZbXKXUtlFJaiMVN25OSGx/pyYsx
	 CZ3kVp43itxG2hgscjbik/tkL8uZt3tSxsi+IPsN7Ba2XGwFTfC5uohzxBijORayQ9
	 n7Pgt7AeV1UUBPYTjeKHvYoOxeaTy6llr4/LY+l1nrprWsOPmriJOk+3172fXQ/Ju6
	 7OPpeamnaOUlwa8S0taZC5fBwzPqk9tv/NEb+TNeCZUUsms2jmV871Vo1WF4ExCJbK
	 H7RV8eaovOIrHEuRjj9rLqqA3jpYLvK3ND9HQwNKifeA7kF+8TmQmFrTtg1E/urVUR
	 obBYTsqsWcF7g==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Andy Chiu <andy.chiu@sifive.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>, Mark Rutland
 <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Guo Ren <guoren@kernel.org>, Ley
 Foon Tan <leyfoon.tan@starfivetech.com>, Deepak Gupta
 <debug@rivosinc.com>, Sia Jee Heng <jeeheng.sia@starfivetech.com>, Bjorn
 Topel <bjorn@rivosinc.com>, Song Shuai <suagrfillet@gmail.com>, Cl'ement
 L'eger <cleger@rivosinc.com>, Al Viro <viro@zeniv.linux.org.uk>, Jisheng
 Zhang <jszhang@kernel.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Robbin
 Ehn <rehn@rivosinc.com>, Brendan Sweeney <brs@rivosinc.com>
Subject: Re: [RFC PATCH] riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
In-Reply-To: <CABgGipWPuvwi43v1+60-=0_MN_q_CD0ZGasxHHVWJ37cig5MmA@mail.gmail.com>
References: <20240306165904.108141-1-puranjay12@gmail.com>
 <87ttlhdeqb.fsf@all.your.base.are.belong.to.us>
 <ZfBbxPDd0rz6FN2T@FVFF77S0Q05N>
 <8734suqsth.fsf@all.your.base.are.belong.to.us>
 <mb61pplvw6grf.fsf@gmail.com>
 <87zfv0onre.fsf@all.your.base.are.belong.to.us>
 <87il1oedx8.fsf@all.your.base.are.belong.to.us>
 <CABgGipWPuvwi43v1+60-=0_MN_q_CD0ZGasxHHVWJ37cig5MmA@mail.gmail.com>
Date: Thu, 21 Mar 2024 09:48:27 +0100
Message-ID: <87msqsotr8.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andy,

Pulling out the A option:

>> > A) Use auipc/jalr, only patch jalr to take us to a common
>> >    dispatcher/trampoline
>> >
>> >  | <func_trace_target_data_8B> # probably on a data cache-line !=3D fu=
nc .text to avoid ping-pong
>> >  | ...
>> >  | func:
>> >  |   ...make sure ra isn't messed up...
>> >  |   aupic
>> >  |   nop <=3D> jalr # Text patch point -> common_dispatch
>> >  |   ACTUAL_FUNC
>> >  |
>> >  | common_dispatch:
>> >  |   load <func_trace_target_data_8B> based on ra
>> >  |   jalr
>> >  |   ...
>> >
>> > The auipc is never touched, and will be overhead. Also, we need a mv to
>> > store ra in a scratch register as well -- like Arm. We'll have two insn
>> > per-caller overhead for a disabled caller.
>
> My patch series takes a similar "in-function dispatch" approach. A
> difference is that the <func_trace_target_data_8B_per_function> is
> embedded within each function entry. I'd like to have it moved to a
> run-time allocated array to reduce total text size.

This is what arm64 has as well. It's a 8B + 1-2 dirt cheap movish like
instructions (save ra, prepare jump with auipc). I think that's a
reasonable overhead.

> Another difference is that my series changes the first instruction to
> "j ACTUAL_FUNC" for the "ftrace disable" case. As long as the
> architecture guarantees the atomicity of the first instruction, then
> we are safe. For example, we are safe if the first instruction could
> only be "mv tmp, ra" or "j ACTUAL_FUNC". And since the loaded address is
> always valid, we can fix "mv + jalr" down so we don't have to
> play with the exception handler trick. The guarantee from arch would
> require ziccif (in RVA22) though, but I think it is the same for us
> (unless with stop_machine). For ziccif, I would rather call that out
> during boot than blindly assume.

I'm maybe biased, but I'd prefer the A) over your version with the
unconditional jump. A) has the overhead of two, I'd say, free
instructions (again "Meten is Weten!" ;-)).

> However, one thing I am not very sure is: do we need a destination
> address in a "per-function" manner? It seems like most of the time the
> destination address can only be ftrace_call, or ftrace_regs_call. If
> the number of destination addresses is very few, then we could
> potentially reduce the size of
> <func_trace_target_data_8B_per_function>.

Yes, we do need a per-function manner. BPF, e.g., uses
dynamically/JIT:ed trampolines/targets.



Bj=C3=B6rn

