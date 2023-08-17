Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5673C77F556
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350217AbjHQLdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349221AbjHQLdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:33:22 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F25730C2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 04:32:55 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe4cdb72b9so69351235e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 04:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692271974; x=1692876774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYLXpwq257lrYbI91toUQ4vtNgExpmLr9ktHCtyK+GU=;
        b=jI7P6md7O7FML3MGqt6QFi4l0uTXqWZBIKY+7AMxNOptubpL3F/YB2vS+/4lvmDGOC
         OIHXW/y6ESveVa3WiatlEs5ZqkLUflezKILPf+Dn219ZGX8oX2QNXKWwYisQSaqOPqtm
         L6UYU5fgRd1tLNxNFHKTqd9hohaNyddxjdAqabxeHTbKpzWl0OpVTRiCx5DBRi9dFcu3
         rWrxsgX/fSFoQ9eWsI8XQ4YhSlVR/qsF1K+czzVUX5yZ6d74gnOIEX8yuqLZ4PsxwdLA
         lyHtFZ/2lWnqo/Yy4qU5jANACFViwPPcw7zEuDYtd9+flVi/AWg2Wu+InolzQ84bOobD
         lrzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692271974; x=1692876774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYLXpwq257lrYbI91toUQ4vtNgExpmLr9ktHCtyK+GU=;
        b=TyTWwf/FthgqbxVKz8xO+bRilPmut7pUQ/hH0Ci9mBLhUiG32doszG9nyOv0EyP0dd
         56LlSnCaEgP0lPge4OnqNFWK+Nq7z9eW84sz5Ge2C8JA/Do8zBKzUx8czTlou6VFxa81
         R55CSbMGVbFrpeMd5pYmsC1BgFPLUWj5o3ViUNfrC+WtrVTceSvobGf/vlVYhB/zTg/V
         6wdwZdSjuxuaWH5xh75p27mjQp/ondO4e4Y6B2R3ufxz5mPWyl4hRKGn0J3zooIz2iCo
         +nPTqVkleLxYYy8xwJcsCGg26tAVzvTNFlV5YDU1pP5GdUm3mKYo6cXzEnWR6sS1IviY
         jgag==
X-Gm-Message-State: AOJu0YyDlvpz+0YzK5tUIogi069iLlDaylYY7eeaMEvhPnT0IQ0rIMu6
        jWxsG1gC3dygNpYCrR7zaRdQ8FblhJbreLiVaRueRw==
X-Google-Smtp-Source: AGHT+IEOWnr9SA+8/lkq2R7JqjbgRQH4UYzwLe/l5hsMEDbp+WMIeOFonJ8veCcUqpKl9ZnjadsSGhE63MnHB5/S6EY=
X-Received: by 2002:a05:600c:2308:b0:3fb:e356:b60d with SMTP id
 8-20020a05600c230800b003fbe356b60dmr3394929wmo.38.1692271974048; Thu, 17 Aug
 2023 04:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230329082950.726-1-cuiyunhui@bytedance.com> <87v8dfqays.fsf@all.your.base.are.belong.to.us>
 <CAEEQ3w=MgH82+BMpwmUHnUevMJsJUqgeBRWSZnU_iizMLK37UQ@mail.gmail.com> <871qg29eb7.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <871qg29eb7.fsf@all.your.base.are.belong.to.us>
From:   yunhui cui <cuiyunhui@bytedance.com>
Date:   Thu, 17 Aug 2023 19:32:43 +0800
Message-ID: <CAEEQ3wme6nXoyK+_kFjrM6hV7EDfiPXM83dibfTS_XxPdbfpLQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] riscv: Dump user opcode bytes on fatal faults
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     conor.dooley@microchip.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, peterz@infradead.org,
        mpe@ellerman.id.au, jpoimboe@kernel.org, mark.rutland@arm.com,
        svens@linux.ibm.com, guoren@kernel.org, jszhang@kernel.org,
        ebiederm@xmission.com, bjorn@rivosinc.com, heiko@sntech.de,
        xianting.tian@linux.alibaba.com, mnissler@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi  Bj=C3=B6rn,

On Thu, Aug 17, 2023 at 6:03=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> yunhui cui <cuiyunhui@bytedance.com> writes:
>
> > Hi Bj=C3=B6rn,
> >
> > On Wed, Aug 16, 2023 at 11:11=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@k=
ernel.org> wrote:
> >>
> >> Hi Yunhui,
> >>
> >> Waking up the dead! ;-)
> >>
> >
> >>
> >> X86's show_opcodes() is used both for kernel oops:es, and userland
> >> unhandled signals. On RISC-V there's dump_kernel_instr() added in comm=
it
> >> eb165bfa8eaf ("riscv: Add instruction dump to RISC-V splats").
> >>
> >> Wdyt about reworking that function, so that it works for userland epc =
as
> >> well? I think it's useful to have the surrounding instruction context,
> >> and not just on instruction.
> >
> > Okay,  Based on your suggestion, I'm going to rename dump_kernel_instr
> > to dump_instr. Like:
> > static void dump_instr(const char *loglvl, struct pt_regs *regs)
> > {
> > ...
> >                 if (user_mode(regs))
> >                         bad =3D get_user_nofault(val, &insns[i]);
> >                 else
> >                         bad =3D get_kernel_nofault(val, &insns[i]);
> > ...
> > }
> >
> > What do you think?
>
> Yeah, looks good! Does that work for you?
Yeah, It works for me, I'll update the patch to v3 and send it.

Thanks,
Yunhui
