Return-Path: <linux-kernel+bounces-96141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BF4875795
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C6A1F245A8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671321EB56;
	Thu,  7 Mar 2024 19:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kays2Dit"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93F41386A2;
	Thu,  7 Mar 2024 19:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841119; cv=none; b=JvQaqkU+U6fFEJbDdmifnpT4S7UPTtVX/32Dhz6Fdu9NiE0aGXFbXuDzKiO6Hj7k/hmR3ksGGDnSqdeMJ8yZy/wlMVnUhm8/1AYB4Y/kAKbguXUOQRf8Q7NjhkEY1vyFEHT3hdemagHDoa7XygB8BCR6V18/EhZM3YczM7/jfEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841119; c=relaxed/simple;
	bh=TdtykXB7n8fNd9dJcXpahhooUT09J4+JKDYWfeZjLlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VTIciQbr6MIdfmeEEmkCgaBwdNAR68Ffj1E8cngFNkC/ueHiKD86Xu+ivdF0fjOp14wEjDJXt/D+1p+3PbIbr6tmt6JzSw//QfOmrHsYhTv3Vv9rO6eUD2nJ5p5Lty78UC7F6+3IPYY7I2+nNA98Cf40XHm/ImDQmPbdlGkAizk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kays2Dit; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5133d26632fso163072e87.2;
        Thu, 07 Mar 2024 11:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709841116; x=1710445916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4I1lXn3FBBpmnufblffhcte7kEWdSkpeXIrFdn90Cs=;
        b=kays2DitVDgF4FgstaCnHBHFrzGg1UAHnCJgtZMhnqM6UQOL5QFhmxrocNrT5sonZr
         jiCl0MJ+YYAHr6CDbLUNVey/uZQpqFL3KyLDBwaakvJlrm4aSiS3q2wga81UtGnKsO7G
         cfoU0ViP9fuXh2Cpief/A32A5JqRTVeZLmbyCMwY3QHvbuAud/ENJqY/5Mz1hVjwnIod
         zvYBdyPydop32lhxqz/KJrcSo62O1XqdSNts27HjqPbTPCBY908efpo5j6NrKbBpaTrZ
         6UiUFH1mzxu24a/bLm+NmOWqpcL7L99XeqdE147mO+sjlhHQgNYYPglXveD560rzn3IH
         pgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709841116; x=1710445916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4I1lXn3FBBpmnufblffhcte7kEWdSkpeXIrFdn90Cs=;
        b=CtgGQDZcwOAHqWwRBFzavJ6daQ0ldvRgUKstU29j8ImgTNjLEwE5V6kA86dbF/8f5R
         1BrLcWB6fmkuVi0RPbTq9Xl1KWB++5nc29nexCaWTsUjROZ5F2ighIbS9xtjFzlRGyRt
         /Pgmsw/HpL3PO/l17GBNeJB+e3Tu42QIcj2YvSvNeUFlorSKy+i8AkE8aKakcS7BZcx0
         FS64cPc7mVVxCOykzGQg96mZz+m9oAa9msndKEE9DGLJpJdC8Mr0KBWFKAvxEdd7LDgk
         XjHCKCaFclKp+FAg0YNUmxfp4RziTHIMjatS2mepnYUJ9XnWfFaPjug0m+2sFZp9Eyr3
         3wNA==
X-Forwarded-Encrypted: i=1; AJvYcCWLMDtOdkGhceUGbOV3uMQKMz4edxUmoO+BwswzuWHh61WuRaZ/xK2bBWZCB/ascnc3uAlYSSeEKhp+Ox1gWgX2lOZ/YwNKyhT5Mqok4qj5in/5Tosrmiai+dxToLl8w0NRE0kWECetGa9mi93BHNc3
X-Gm-Message-State: AOJu0YxRSZr3KkRaMRfryUvztgKD1Qqcg0U9BrqhIM4AOrx5INHBtkN+
	W56XQ4KdNcQ/zrCMSYhRjd9IIDRlamIDLgT4tmnBgt4RsgxjbkGF65kUFiSYTtqE4no2vXmzrqK
	ta2upQm9FB4yMIbqK1uZBnt7hzVo=
X-Google-Smtp-Source: AGHT+IFTDb9kSXJSV9aEH7Cc4i8JuuCykEZTMKhx5/zbStDpJtxFBfLhgQMojeCXfJ0KbIatFZO3IZs9FgExJRCFUoo=
X-Received: by 2002:a05:6512:3d1f:b0:513:2f96:72b5 with SMTP id
 d31-20020a0565123d1f00b005132f9672b5mr2958723lfv.33.1709841115402; Thu, 07
 Mar 2024 11:51:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306165904.108141-1-puranjay12@gmail.com> <87ttlhdeqb.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87ttlhdeqb.fsf@all.your.base.are.belong.to.us>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 7 Mar 2024 20:51:44 +0100
Message-ID: <CANk7y0gbQdYw0V+CEv-z8wFGXnki8KSn4c8+i0iZ1UFNCg7wJQ@mail.gmail.com>
Subject: Re: [RFC PATCH] riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Guo Ren <guoren@kernel.org>, 
	Ley Foon Tan <leyfoon.tan@starfivetech.com>, Deepak Gupta <debug@rivosinc.com>, 
	Sia Jee Heng <jeeheng.sia@starfivetech.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Song Shuai <suagrfillet@gmail.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jisheng Zhang <jszhang@kernel.org>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bj=C3=B6rn,

On Thu, Mar 7, 2024 at 8:27=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.=
org> wrote:
>
> Puranjay!
>
> Puranjay Mohan <puranjay12@gmail.com> writes:
>
> > This patch enables support for DYNAMIC_FTRACE_WITH_CALL_OPS on RISC-V.
> > This allows each ftrace callsite to provide an ftrace_ops to the common
> > ftrace trampoline, allowing each callsite to invoke distinct tracer
> > functions without the need to fall back to list processing or to
> > allocate custom trampolines for each callsite. This significantly speed=
s
> > up cases where multiple distinct trace functions are used and callsites
> > are mostly traced by a single tracer.
> >
> > The idea and most of the implementation is taken from the ARM64's
> > implementation of the same feature. The idea is to place a pointer to
> > the ftrace_ops as a literal at a fixed offset from the function entry
> > point, which can be recovered by the common ftrace trampoline.
>
> Not really a review, but some more background; Another rationale (on-top
> of the improved per-call performance!) for CALL_OPS was to use it to
> build ftrace direct call support (which BPF uses a lot!). Mark, please
> correct me if I'm lying here!
>
> On Arm64, CALL_OPS makes it possible to implement direct calls, while
> only patching one BL instruction -- nice!
>
> On RISC-V we cannot use use the same ideas as Arm64 straight off,
> because the range of jal (compare to BL) is simply too short (+/-1M).
> So, on RISC-V we need to use a full auipc/jal pair (the text patching
> story is another chapter, but let's leave that aside for now). Since we
> have to patch multiple instructions, the cmodx situation doesn't really
> improve with CALL_OPS.
>
> Let's say that we continue building on your patch and implement direct
> calls on CALL_OPS for RISC-V as well.
>
> From Florent's commit message for direct calls:
>
>   |    There are a few cases to distinguish:
>   |    - If a direct call ops is the only one tracing a function:
>   |      - If the direct called trampoline is within the reach of a BL
>   |        instruction
>   |         -> the ftrace patchsite jumps to the trampoline
>   |      - Else
>   |         -> the ftrace patchsite jumps to the ftrace_caller trampoline=
 which
>   |            reads the ops pointer in the patchsite and jumps to the di=
rect
>   |            call address stored in the ops
>   |    - Else
>   |      -> the ftrace patchsite jumps to the ftrace_caller trampoline an=
d its
>   |         ops literal points to ftrace_list_ops so it iterates over all
>   |         registered ftrace ops, including the direct call ops and call=
s its
>   |         call_direct_funcs handler which stores the direct called
>   |         trampoline's address in the ftrace_regs and the ftrace_caller
>   |         trampoline will return to that address instead of returning t=
o the
>   |         traced function
>
> On RISC-V, where auipc/jalr is used, the direct called trampoline would
> always be reachable, and then first Else-clause would never be entered.
> This means the the performance for direct calls would be the same as the
> one we have today (i.e. no regression!).
>
> RISC-V does like x86 does (-ish) -- patch multiple instructions, long
> reach.
>
> Arm64 uses CALL_OPS and patch one instruction BL.
>
> Now, with this background in mind, compared to what we have today,
> CALL_OPS would give us (again assuming we're using it for direct calls):
>
> * Better performance for tracer per-call (faster ops lookup) GOOD

^ this was the only motivation for me to implement this patch.

I don't think implementing direct calls over call ops is fruitful for
RISC-V because once
the auipc/jalr can be patched atomically, the direct call trampoline
is always reachable.
Solving the atomic text patching problem would be fun!! I am eager to
see how it will be
solved.

> * Larger text size (function alignment + extra nops) BAD
> * Same direct call performance NEUTRAL
> * Same complicated text patching required NEUTRAL
>
> It would be interesting to see how the per-call performance would
> improve on x86 with CALL_OPS! ;-)

If I remember from Steven's talk, x86 uses dynamically allocated trampoline=
s
for per callsite tracers, would CALL_OPS provide better performance than th=
at?

>
> I'm trying to wrap my head if it makes sense to have it on RISC-V, given
> that we're a bit different from Arm64. Does the scale tip to the GOOD
> side?
>
> Oh, and we really need to see performance numbers on real HW! I have a
> VF2 that I could try this series on.

It would be great if you can do it :D.

Thanks,
Puranjay

