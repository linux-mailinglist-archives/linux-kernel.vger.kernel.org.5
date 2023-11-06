Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F207E1CE8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 10:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjKFJE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 04:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjKFJEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 04:04:25 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF4583;
        Mon,  6 Nov 2023 01:04:22 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-5079f9675c6so5559545e87.2;
        Mon, 06 Nov 2023 01:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699261461; x=1699866261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/8Dv00RFeRNB2AjmLS+laUWw316tnEfZnwqT3z8dIA=;
        b=NXzg5zQms1jQzPvUf6x+JBwhYRznCCL42gLi2a9ryWtgCZiyZH/cgyHyVcG+TLsR0h
         cykJ0y27680DJLbYfaqLCFFs8LdrGug4+FuWGgzaJ2zP1OyvrDYgMZ7gepJZi5golY0K
         OIKIf3hpB3eGxwvqtPdOjwbZr5N7R9HoI2cFJklznuNe9sUk0JRarv4TVgmgLSwK2gZK
         oxCcGofOhoanoZeeNDwkUCc59eoUafGfzCmera7LAqBJuFV8T/Zxrlo8VffjN9aeQfe3
         6BF8eMWtDBlcZs6GchTy/mqerXxJRruCVQdruPtx1HpVYT5L4Md7wRK1+wKysJHO98zC
         4Pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699261461; x=1699866261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/8Dv00RFeRNB2AjmLS+laUWw316tnEfZnwqT3z8dIA=;
        b=S1OlEWJKjmUrJhVGxjTsOAhwFMk+mAEubUnwpZi+cFk5qVJakeiSZzPMUPjWQXHN51
         Pajft3dAbm6rkCPcVwvGfY8q6Ju2mt714jzf5lR7vQTp4rylIpiq3agtcB4VdMnnpkw6
         OhBkBgUUXsyKuZPulCu5rDhrwlk/+tidVeWtmWq8n8b4cRESR1fW97bmWlPrDAQ8MWrn
         R3OKIZUWLkIOLThnpi1Dp0ET4JtaHU4yCCspren9ixqI05yGxBKxtQR2SRZc9u6U6alA
         xTfUWJZCPt2OmHRpEXPElKppDgfwJle903sVV+uw06z5pKwR9J+DD0n6LsMoQJI3IbVR
         l7jA==
X-Gm-Message-State: AOJu0Yw9FOeIb4EFl6yOQ4FHotK9xDOET40Vh84NLnKl5DCx6U1O4xPW
        RdjRoWZhu2LXp2H/yrq3c+DRK/M9dz2VCFDqkeA=
X-Google-Smtp-Source: AGHT+IGgDtb18fYcuHQYhC4Ckh0nS1k/o6q9qqCFCeIlQ5R5DEXHatT4VSPsFyL1WiKAFODa/Cl12JRIFFbbt9cvzSs=
X-Received: by 2002:ac2:54b7:0:b0:508:1aa7:dffa with SMTP id
 w23-20020ac254b7000000b005081aa7dffamr21919345lfk.18.1699261460489; Mon, 06
 Nov 2023 01:04:20 -0800 (PST)
MIME-Version: 1.0
References: <20230917000045.56377-1-puranjay12@gmail.com> <20230917000045.56377-2-puranjay12@gmail.com>
 <ZUPVbrMSNNwPw_B-@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZUPVbrMSNNwPw_B-@FVFF77S0Q05N.cambridge.arm.com>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Mon, 6 Nov 2023 10:04:09 +0100
Message-ID: <CANk7y0g8SOrSAY2jqZ22v6Duu9yhHY-d39g5gJ2vA2j2Y-v53Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/1] bpf, arm64: support exceptions
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Thu, Nov 2, 2023 at 5:59=E2=80=AFPM Mark Rutland <mark.rutland@arm.com> =
wrote:
>
> On Sun, Sep 17, 2023 at 12:00:45AM +0000, Puranjay Mohan wrote:
> > Implement arch_bpf_stack_walk() for the ARM64 JIT. This will be used
> > by bpf_throw() to unwind till the program marked as exception boundary =
and
> > run the callback with the stack of the main program.
> >
> > The prologue generation code has been modified to make the callback
> > program use the stack of the program marked as exception boundary where
> > callee-saved registers are already pushed.
> >
> > As the bpf_throw function never returns, if it clobbers any callee-save=
d
> > registers, they would remain clobbered. So, the prologue of the
> > exception-boundary program is modified to push R23 and R24 as well,
> > which the callback will then recover in its epilogue.
> >
> > The Procedure Call Standard for the Arm 64-bit Architecture[1] states
> > that registers r19 to r28 should be saved by the callee. BPF programs o=
n
> > ARM64 already save all callee-saved registers except r23 and r24. This
> > patch adds an instruction in prologue of the  program to save these
> > two registers and another instruction in the epilogue to recover them.
> >
> > These extra instructions are only added if bpf_throw() used. Otherwise
> > the emitted prologue/epilogue remains unchanged.
> >
> > [1] https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rs=
t
> >
> > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > ---
>
> [...]
>
> > +void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 =
sp, u64 bp), void *cookie)
> > +{
> > +     struct stack_info stacks[] =3D {
> > +             stackinfo_get_task(current),
> > +     };
>
> Can bpf_throw() only be used by BPF programs that run in task context, or=
 is it
> possible e.g. for those to run within an IRQ handler (or otherwise on the=
 IRQ
> stack)?

I will get back on this with more information.

>
> > +
> > +     struct unwind_state state =3D {
> > +             .stacks =3D stacks,
> > +             .nr_stacks =3D ARRAY_SIZE(stacks),
> > +     };
> > +     unwind_init_common(&state, current);
> > +     state.fp =3D (unsigned long)__builtin_frame_address(1);
> > +     state.pc =3D (unsigned long)__builtin_return_address(0);
> > +
> > +     if (unwind_next_frame_record(&state))
> > +             return;
> > +     while (1) {
> > +             /* We only use the fp in the exception callback. Pass 0 f=
or sp as it's unavailable*/
> > +             if (!consume_fn(cookie, (u64)state.pc, 0, (u64)state.fp))
> > +                     break;
> > +             if (unwind_next_frame_record(&state))
> > +                     break;
> > +     }
> > +}
>
> IIUC you're not using arch_stack_walk() because you need the FP in additi=
on to
> the PC.

Yes,

>
> Is there any other reason you need to open-code this?

No,

>
> If not, I'd rather rework the common unwinder so that it's possible to ge=
t at
> the FP. I had patches for that a while back:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=
=3Darm64/stacktrace/metadata
>
> ... and I'm happy to rebase that and pull out the minimum necessary to ma=
ke
> that possible.

It would be great if you can rebase and push the code, I can rebase
this on your work and
not open code this implementation.

>
> Mark.
>

Thanks,
Puranjay
