Return-Path: <linux-kernel+bounces-96812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CBB8761BE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B541F21387
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB7E5477C;
	Fri,  8 Mar 2024 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJedCYhX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D22C2CCB3;
	Fri,  8 Mar 2024 10:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709892986; cv=none; b=sfh2chPCBINk53gMUgYGFYdg5XPAGowrwycbf/GKKWqr5+DSEWlsii/cVrfy8htv+FYQkiKtytYC6oexoLyGc4zX3A1gISu0oPrOFlptD6i6CZQ+T/6gDoY23ql1VDVaqkyoueh7HF4M44h5yYnyTKBsUf3dkwHNtic+SBjflMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709892986; c=relaxed/simple;
	bh=sr34wHQR+GgEvXvJDRqEnla88k1cwdRe+zsxhA2KPFk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=paQQzy61kzX6PBsuGG7zIHTdh4TeuM6rrlrsDXAPAVRcMJjMLhIrzAqW7GLB6VTVJwLxIiZGRdMC5QExJNfxMrKjjHReYF91sGDeqanRTsGROWpVtP9eCsiwMHpe1OugyQz1kKnKgn72SdS08R+q36fB8f4c6xqLkJKdTsevrVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJedCYhX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0534C43394;
	Fri,  8 Mar 2024 10:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709892986;
	bh=sr34wHQR+GgEvXvJDRqEnla88k1cwdRe+zsxhA2KPFk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EJedCYhXdgxyKjMGasPYqipqYYnAZ65LM3kQ+MHKrTlT9ZQ6rN+iU1TjJzblviJlf
	 Bp0hjP/p0J+cqLJIc+OoPiaXTDVcq3/JNysNf8vghkPPjzzT04VAd13OhUxFgtUkNO
	 UZYcqCM7BCzjgfhi22rKrbkYVKw+9r8SjfIRYuNnE7FVE3I+drOz8NvYcWzQulUUL6
	 VYrhEdiK/NfyqFLsn4IrrH6lKiiJNVx6HDIe6BNPQRVQkAUt+LbYtqAsbaT1uFhkcR
	 Cm5AuETZI2VtDtymRdum/yjwzIB0IFswVkTbhlI18Jyd1jaTdIkL7kpFHYKmFDPpGx
	 HYJ3JRpC1CkMQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Sami Tolvanen <samitolvanen@google.com>,
 Guo Ren <guoren@kernel.org>, Ley Foon Tan <leyfoon.tan@starfivetech.com>,
 Deepak Gupta <debug@rivosinc.com>, Sia Jee Heng
 <jeeheng.sia@starfivetech.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Song
 Shuai <suagrfillet@gmail.com>, =?utf-8?Q?Cl=C3=A9ment_L=C3=A9ger?=
 <cleger@rivosinc.com>, Al
 Viro <viro@zeniv.linux.org.uk>, Jisheng Zhang <jszhang@kernel.org>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
In-Reply-To: <CANk7y0gbQdYw0V+CEv-z8wFGXnki8KSn4c8+i0iZ1UFNCg7wJQ@mail.gmail.com>
References: <20240306165904.108141-1-puranjay12@gmail.com>
 <87ttlhdeqb.fsf@all.your.base.are.belong.to.us>
 <CANk7y0gbQdYw0V+CEv-z8wFGXnki8KSn4c8+i0iZ1UFNCg7wJQ@mail.gmail.com>
Date: Fri, 08 Mar 2024 11:16:23 +0100
Message-ID: <87jzmdowp4.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Puranjay Mohan <puranjay12@gmail.com> writes:

> Hi Bj=C3=B6rn,
>
> On Thu, Mar 7, 2024 at 8:27=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kerne=
l.org> wrote:
>>
>> Puranjay!
>>
>> Puranjay Mohan <puranjay12@gmail.com> writes:
>>
>> > This patch enables support for DYNAMIC_FTRACE_WITH_CALL_OPS on RISC-V.
>> > This allows each ftrace callsite to provide an ftrace_ops to the common
>> > ftrace trampoline, allowing each callsite to invoke distinct tracer
>> > functions without the need to fall back to list processing or to
>> > allocate custom trampolines for each callsite. This significantly spee=
ds
>> > up cases where multiple distinct trace functions are used and callsites
>> > are mostly traced by a single tracer.
>> >
>> > The idea and most of the implementation is taken from the ARM64's
>> > implementation of the same feature. The idea is to place a pointer to
>> > the ftrace_ops as a literal at a fixed offset from the function entry
>> > point, which can be recovered by the common ftrace trampoline.
>>
>> Not really a review, but some more background; Another rationale (on-top
>> of the improved per-call performance!) for CALL_OPS was to use it to
>> build ftrace direct call support (which BPF uses a lot!). Mark, please
>> correct me if I'm lying here!
>>
>> On Arm64, CALL_OPS makes it possible to implement direct calls, while
>> only patching one BL instruction -- nice!
>>
>> On RISC-V we cannot use use the same ideas as Arm64 straight off,
>> because the range of jal (compare to BL) is simply too short (+/-1M).
>> So, on RISC-V we need to use a full auipc/jal pair (the text patching
>> story is another chapter, but let's leave that aside for now). Since we
>> have to patch multiple instructions, the cmodx situation doesn't really
>> improve with CALL_OPS.
>>
>> Let's say that we continue building on your patch and implement direct
>> calls on CALL_OPS for RISC-V as well.
>>
>> From Florent's commit message for direct calls:
>>
>>   |    There are a few cases to distinguish:
>>   |    - If a direct call ops is the only one tracing a function:
>>   |      - If the direct called trampoline is within the reach of a BL
>>   |        instruction
>>   |         -> the ftrace patchsite jumps to the trampoline
>>   |      - Else
>>   |         -> the ftrace patchsite jumps to the ftrace_caller trampolin=
e which
>>   |            reads the ops pointer in the patchsite and jumps to the d=
irect
>>   |            call address stored in the ops
>>   |    - Else
>>   |      -> the ftrace patchsite jumps to the ftrace_caller trampoline a=
nd its
>>   |         ops literal points to ftrace_list_ops so it iterates over all
>>   |         registered ftrace ops, including the direct call ops and cal=
ls its
>>   |         call_direct_funcs handler which stores the direct called
>>   |         trampoline's address in the ftrace_regs and the ftrace_caller
>>   |         trampoline will return to that address instead of returning =
to the
>>   |         traced function
>>
>> On RISC-V, where auipc/jalr is used, the direct called trampoline would
>> always be reachable, and then first Else-clause would never be entered.
>> This means the the performance for direct calls would be the same as the
>> one we have today (i.e. no regression!).
>>
>> RISC-V does like x86 does (-ish) -- patch multiple instructions, long
>> reach.
>>
>> Arm64 uses CALL_OPS and patch one instruction BL.
>>
>> Now, with this background in mind, compared to what we have today,
>> CALL_OPS would give us (again assuming we're using it for direct calls):
>>
>> * Better performance for tracer per-call (faster ops lookup) GOOD
>
> ^ this was the only motivation for me to implement this patch.
>
> I don't think implementing direct calls over call ops is fruitful for
> RISC-V because once
> the auipc/jalr can be patched atomically, the direct call trampoline
> is always reachable.
> Solving the atomic text patching problem would be fun!! I am eager to
> see how it will be
> solved.

Given the upcoming Zjid spec, we'll soon be in a much better place where
we can reason about cmodx.

>> * Larger text size (function alignment + extra nops) BAD
>> * Same direct call performance NEUTRAL
>> * Same complicated text patching required NEUTRAL
>>
>> It would be interesting to see how the per-call performance would
>> improve on x86 with CALL_OPS! ;-)
>
> If I remember from Steven's talk, x86 uses dynamically allocated trampoli=
nes
> for per callsite tracers, would CALL_OPS provide better performance than =
that?

Probably not, and it was really a tongue-in-cheek comment -- nothing I
encourage you to do!

Now, I think a better approach for RISC-V would be implementing what x86
has (arch_ftrace_update_trampoline()), rather than CALL_OPS for RISC-V.

Thoughts?


Bj=C3=B6rn


