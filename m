Return-Path: <linux-kernel+bounces-156612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F61B8B05A1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B444CB25565
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CDD158867;
	Wed, 24 Apr 2024 09:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CV2h6DL9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7434D158D75;
	Wed, 24 Apr 2024 09:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713950030; cv=none; b=k72GK44RH/g9tWMsTcwyu0ANC9fIZZyexChz8N31CMwj1Po+peXX0TH+tDC7lnxFcgyexhvzBfJgEN/mDRPY47rAW/+qQ9d1dJTpT6U7NoGMF+kVqsloU4HumBQ50irFwcrDhnts9UnbdscPCS9m3bs9wNl3ZYQy4E9vhDMwwvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713950030; c=relaxed/simple;
	bh=wWp0kC0f24K1UMqnicLBYBOSUnN/lBPXIwSVeU+KJ5g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pgqo9yIMUCdaEoa40auuzu9ve7Lr7cFaKlc1PUY0B6yvjICsz+cfrnxGmoVINRzfCv6ZomYvcXN7oKsweeq2OYO/TwbEHen4/gkyxr4pm+660mMG2sdXiA7704BQFJg0aeVV+gKIxprJ+4a0s9VuvnkZqbz9g2MrzciS42vDEc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CV2h6DL9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA785C2BD11;
	Wed, 24 Apr 2024 09:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713950030;
	bh=wWp0kC0f24K1UMqnicLBYBOSUnN/lBPXIwSVeU+KJ5g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CV2h6DL9iv2ythhvD/13ptoyATcTW+G96JRcj/SvrgZCkvJxD92Lw3pcFLpOzbxCe
	 BnM4SO92UtECCHk1IyaDMIMOwVl3ofArv6esZBXJXNwjMHuGpM1gFP0ncMhfieTHVE
	 gA+qn9ShcJiVn+DuC67KdIW6OpUxb/+ybBaJYmrfELRvDwhN4SXFUN6y/CjuB4ABR7
	 BKEhfpZtbpF7/OQF+vahNOmAaLojngSGFHyPIsG7w94aalXnInh/92tcusj/b9QL6p
	 kDUs1gwBmpbxM8aBZQ3Jp1OxAEeXqnkqf8ikvL/+it2oDGMQN73fGKUebdBdp8K/J6
	 BQth9A7Y/X8Yg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>, Alexandre Ghiti
 <alexghiti@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sami
 Tolvanen <samitolvanen@google.com>, Guo Ren <guoren@kernel.org>, Ley Foon
 Tan <leyfoon.tan@starfivetech.com>, Deepak Gupta <debug@rivosinc.com>, Sia
 Jee Heng <jeeheng.sia@starfivetech.com>, Song Shuai
 <suagrfillet@gmail.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, =?utf-8?Q?Cl=C3=A9ment_L=C3=A9ger?=
 <cleger@rivosinc.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: Re: [PATCH] ftrace: riscv: move from REGS to ARGS
In-Reply-To: <20240405142453.4187-1-puranjay@kernel.org>
References: <20240405142453.4187-1-puranjay@kernel.org>
Date: Wed, 24 Apr 2024 11:13:46 +0200
Message-ID: <87il0786np.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Puranjay Mohan <puranjay@kernel.org> writes:

> This commit replaces riscv's support for FTRACE_WITH_REGS with support
> for FTRACE_WITH_ARGS. This is required for the ongoing effort to stop
> relying on stop_machine() for RISCV's implementation of ftrace.
>
> The main relevant benefit that this change will bring for the above
> use-case is that now we don't have separate ftrace_caller and
> ftrace_regs_caller trampolines. This will allow the callsite to call
> ftrace_caller by modifying a single instruction. Now the callsite can
> do something similar to:
>
> When not tracing:            |             When tracing:
>
> func:                                      func:
>   auipc t0, ftrace_caller_top                auipc t0, ftrace_caller_top
>   nop  <=3D=3D=3D=3D=3D=3D=3D=3D=3D<Enable/Disable>=3D=3D=3D=3D=3D=3D=3D=
=3D=3D>  jalr  t0, ftrace_caller_bottom
>   [...]                                      [...]
>
> The above assumes that we are dropping the support of calling a direct
> trampoline from the callsite. We need to drop this as the callsite can't
> change the target address to call, it can only enable/disable a call to
> a preset target (ftrace_caller in the above diagram). We can later optimi=
ze
> this by calling an intermediate dispatcher trampoline before ftrace_calle=
r.
>
> Currently, ftrace_regs_caller saves all CPU registers in the format of
> struct pt_regs and allows the tracer to modify them. We don't need to
> save all of the CPU registers because at function entry only a subset of
> pt_regs is live:
>
> |----------+----------+---------------------------------------------|
> | Register | ABI Name | Description                                 |
> |----------+----------+---------------------------------------------|
> | x1       | ra       | Return address for traced function          |
> | x2       | sp       | Stack pointer                               |
> | x5       | t0       | Return address for ftrace_caller trampoline |
> | x8       | s0/fp    | Frame pointer                               |
> | x10-11   | a0-1     | Function arguments/return values            |
> | x12-17   | a2-7     | Function arguments                          |
> |----------+----------+---------------------------------------------|
>
> See RISCV calling convention[1] for the above table.
>
> Saving just the live registers decreases the amount of stack space
> required from 288 Bytes to 112 Bytes.
>
> Basic testing was done with this on the VisionFive 2 development board.
>
> Note:
>   - Moving from REGS to ARGS will mean that RISCV will stop supporting
>     KPROBES_ON_FTRACE as it requires full pt_regs to be saved.
>   - KPROBES_ON_FTRACE will be supplanted by FPROBES see [2].

Puranjay,

Apologies for the slow response.

Restating from the RFC; This change is a prerequisite for moving towards
a "FTRACE_WITH_CALL_OPS" model on riscv, and finally getting rid of the
stop_machine() text patching.

I've tested this on QEMU, and on the VisionFive2. No regressions
(FTRACE_STARTUP_*, and kselftest), other than that KPROBES_ON_FTRACE no
longer works. (Which will be addressed by [2]).

Palmer, my preference is that this should go on for-next, rather than
being part of the upcoming text patching support (worked on by Andy),
but really up to you.

Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

