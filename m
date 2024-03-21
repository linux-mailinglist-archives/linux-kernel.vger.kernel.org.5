Return-Path: <linux-kernel+bounces-109820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B104885617
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEAAA2823B0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9352A1C6;
	Thu, 21 Mar 2024 08:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvP43udc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFFCBE6E;
	Thu, 21 Mar 2024 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711011513; cv=none; b=AKuCgz6BJSzzK+9HL1cSrOEPBaS8T8xGAXkhzloZlRywB1IU923UBmGFXVNAeew61aEADCEY95pwPpNKjMUlIDzm6JTeckaTezuW2/VVNpF9Nc24gVLFyvGjBtkjBqSUb2kuZ2Q612H8pU5kwQs4f4btJ+/WChyxGp7qEFLvZKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711011513; c=relaxed/simple;
	bh=uGpBd9QI+Atx1GoKgTQyA4nlsR96BwgZ79GAu7yGD1g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sRMHD3gZTnBLWfoIvRWMuKILvIi8CzfXRz1AtUE7ZqvcHRyzPNOvNkiTG5JcpRjAGSO0dzRjMZKEseSRP3SdJb95L9HbzCcZh8b8HJS4r3LZBk33cGPqN5hNnH2pt9+9sjkhxHI20gVdsWP3gLfW9Xy3donpfz3JCcRtE2vTLv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvP43udc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D37C433F1;
	Thu, 21 Mar 2024 08:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711011512;
	bh=uGpBd9QI+Atx1GoKgTQyA4nlsR96BwgZ79GAu7yGD1g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qvP43udcWQrSBEPeuwihpyfg0fFvip845SrGXz7bPiJjHieri42mcfdZqQDG0kc6+
	 OH13aUlpu3Q4xJGkyE5mQ8T6efE522w++4IKlroUpju0JeINkt9GlEC1N83+uXyi7F
	 MjWsXYk7eQKzrLijzdZdzSzMHK5L8Gr9qWKLjjV7hCGVSRSo9V5h04V5nBDNG2M3xh
	 ZpCC5a0xqmaaguE1omKiNqgV/r3BztmHo5kwuSNw8Nqfo7AajuHr0qhEIS5APplFIZ
	 ieJmyvkcZaMGR1TpRYbNkZ3mjrtsosTVruW/SOf/7dEs4M9cn0jwf4SNaozH2UWJUR
	 hMCzRnWoXxyeA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>, Andy Chiu <andy.chiu@sifive.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Sami
 Tolvanen <samitolvanen@google.com>, Guo Ren <guoren@kernel.org>, Ley Foon
 Tan <leyfoon.tan@starfivetech.com>, Deepak Gupta <debug@rivosinc.com>, Sia
 Jee Heng <jeeheng.sia@starfivetech.com>, Bjorn Topel <bjorn@rivosinc.com>,
 Song Shuai <suagrfillet@gmail.com>, Cl'ement L'eger <cleger@rivosinc.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Jisheng Zhang <jszhang@kernel.org>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Robbin Ehn <rehn@rivosinc.com>
Subject: Re: [RFC PATCH] riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
In-Reply-To: <ZfslAb_W0Gk-0pmR@FVFF77S0Q05N.cambridge.arm.com>
References: <20240306165904.108141-1-puranjay12@gmail.com>
 <87ttlhdeqb.fsf@all.your.base.are.belong.to.us>
 <ZfBbxPDd0rz6FN2T@FVFF77S0Q05N>
 <8734suqsth.fsf@all.your.base.are.belong.to.us>
 <mb61pplvw6grf.fsf@gmail.com>
 <87zfv0onre.fsf@all.your.base.are.belong.to.us>
 <ZfslAb_W0Gk-0pmR@FVFF77S0Q05N.cambridge.arm.com>
Date: Thu, 21 Mar 2024 09:58:28 +0100
Message-ID: <87frwkotaj.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mark,

Mark Rutland <mark.rutland@arm.com> writes:

>> A) Use auipc/jalr, only patch jalr to take us to a common
>>    dispatcher/trampoline
>>=20=20=20
>>  | <func_trace_target_data_8B> # probably on a data cache-line !=3D func=
 .text to avoid ping-pong
>>  | ...
>>  | func:
>>  |   ...make sure ra isn't messed up...
>>  |   aupic
>>  |   nop <=3D> jalr # Text patch point -> common_dispatch
>>  |   ACTUAL_FUNC
>>  |=20
>>  | common_dispatch:
>>  |   load <func_trace_target_data_8B> based on ra
>>  |   jalr
>>  |   ...
>>=20
>> The auipc is never touched, and will be overhead. Also, we need a mv to
>> store ra in a scratch register as well -- like Arm. We'll have two insn
>> per-caller overhead for a disabled caller.
>
> Is the AUIPC a significant overhead? IIUC that's similar to Arm's ADRP, a=
nd I'd
> have expected that to be pretty cheap.

No, reg-to-reg moves are dirt cheap in my book.

> IIUC your JALR can choose which destination register to store the return
> address in, and if so, you could leave the original ra untouched (and rec=
over
> that in the common trampoline). Have I misunderstood that?
>
> Maybe that doesn't play nicely with something else?

No, you're right, we can link to another register, and shave off an
instruction. I can imagine that some implementation prefer x1/x5 for
branch prediction reasons, but that's something that we can measure on.=20

So, 1-2 movs + nop are unconditionally executed on the disabled case.
(1-2 depending on the ra save/jalr reg strategy).

>> B) Use jal, which can only take us +/-1M, and requires multiple
>>    dispatchers (and tracking which one to use, and properly distribute
>>    them. Ick.)
>>=20
>>  | <func_trace_target_data_8B> # probably on a data cache-line !=3D func=
 .text to avoid ping-pong
>>  | ...
>>  | func:
>>  |   ...make sure ra isn't messed up...
>>  |   nop <=3D> jal # Text patch point -> within_1M_to_func_dispatch
>>  |   ACTUAL_FUNC
>>  |=20
>>  | within_1M_to_func_dispatch:
>>  |   load <func_trace_target_data_8B> based on ra
>>  |   jalr
>>=20
>> C) Use jal, which can only take us +/-1M, and use a per-function
>>    trampoline requires multiple dispatchers (and tracking which one to
>>    use). Blows up text size A LOT.
>>=20
>>  | <func_trace_target_data_8B> # somewhere, but probably on a different =
cacheline than the .text to avoid ping-ongs
>>  | ...
>>  | per_func_dispatch
>>  |   load <func_trace_target_data_8B> based on ra
>>  |   jalr
>>  | func:
>>  |   ...make sure ra isn't messed up...
>>  |   nop <=3D> jal # Text patch point -> per_func_dispatch
>>  |   ACTUAL_FUNC
>
> Beware that with option (C) you'll need to handle that in your unwinder f=
or
> RELIABLE_STACKTRACE. If you don't have a symbol for per_func_dispatch (or
> func_trace_target_data_8B), PC values within per_func_dispatch would be
> symbolized as the prior function/data.

Good point (but I don't like C much...)!

>> It's a bit sad that we'll always have to have a dispatcher/trampoline,
>> but it's still better than stop_machine(). (And we'll need a fencei IPI
>> as well, but only one. ;-))
>>=20
>> Today, I'm leaning towards A (which is what Mark suggested, and also
>> Robbin).. Any other options?
>
> Assuming my understanding of JALR above is correct, I reckon A is the nic=
est
> option out of A/B/C.

Yes! +1!


Bj=C3=B6rn

