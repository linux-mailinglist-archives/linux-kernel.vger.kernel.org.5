Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27FC78FB94
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 12:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343597AbjIAKCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 06:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjIAKCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 06:02:33 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0A910E0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 03:02:06 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31c5a2e8501so1468300f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 03:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693562525; x=1694167325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/HkOQzxeW8BnxrMWfNqofeHJy0DGs2aFW803SrTcs8=;
        b=aSRtX4vksvxqWHWDFk6okK8+UnFkl44xUIOhXFbAOaBLohQCXIrdi+NDkbSEIiExzw
         HYSE5k7JCP/P0B5+GIlviRYAFUroAR+hUe3yf/9fB3N7igG/o9IFiYltPp1XVs/B4/34
         Qm5UWx+nOogeLzdaEE9CLshSbKJydmml9OMwhkpd2dRegv+CMkOZTTJ/AMBj5I+g5Vsi
         NI4JXoRQEisB5Ute1N3ICiMMOp79dVyZf6DieLcoP3WyfgxyeM36jYw742SSEDPAaPEF
         qgtcHw9bOuwe4sW8JfymJtqPxesIg/ZIeUSpOHCQaRf29csTn704payltiyzormb9D7F
         Kwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693562525; x=1694167325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/HkOQzxeW8BnxrMWfNqofeHJy0DGs2aFW803SrTcs8=;
        b=iw++xSBKa8KXtKDhCHFObo6pnAnacau0gMgZml3oxUnvRZVFecvsL2Q/EhxQaetqjX
         1Y4KKr5ewSDzydU0kbKZiSDTkh6TaA4B6oZaLAbzb72zLII5UZJm3/O7vHeqaAd17s3A
         3DUrNAQX1sgC5y6ym5SdSLz/FB1yeahUjnTnc+FxYkex43ZTUVgSUmavaP39pTwIeU1L
         T7E/K7qtXiZh8T1sI7n6eGudkfP5FDk6TjtFgqBzNEJ55ivJyKlKA9z+c5KOqHbQ1jBw
         3Jde2JkZLJmCdVm7tCiB3dlf9sfnn782woimL6oRu4qgrpIxKiu5Vd7cR4y3x2QrfRia
         A9hg==
X-Gm-Message-State: AOJu0YwCE7rmF/5uN1mTX1+pVSobROvpgZt8qSDbndmT6D2NzUqWf/wm
        2IAjMS8wDSfAP8ybAV0XIoOrqaL+T6v7VCpkms6GVw==
X-Google-Smtp-Source: AGHT+IGsAzrvsl7U2rv8ejAeCZUTjaHvPimEYWXEpjBR6u8BUJ+R0dDTG7MmG5JN/zBo7osd6rWEMUjBElWIKFhRlJU=
X-Received: by 2002:adf:e7cc:0:b0:31a:dc2e:2db2 with SMTP id
 e12-20020adfe7cc000000b0031adc2e2db2mr1566044wrn.49.1693562524822; Fri, 01
 Sep 2023 03:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230818121504.60492-1-cuiyunhui@bytedance.com>
 <878ra8o4qa.fsf@all.your.base.are.belong.to.us> <CAEEQ3wmL90oOZcmpv8G34u7kg44zGscpHJiiRHLi=_LAm=C1jg@mail.gmail.com>
 <87msy6p8k3.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87msy6p8k3.fsf@all.your.base.are.belong.to.us>
From:   yunhui cui <cuiyunhui@bytedance.com>
Date:   Fri, 1 Sep 2023 18:01:53 +0800
Message-ID: <CAEEQ3wk-n0B0UmJ_fpw1kKn5TT+Nohxarv3QbmCbAUUrK8K8Gw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4] riscv: add userland instruction dump to
 RISC-V splats
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, guoren@kernel.org, bjorn@rivosinc.com,
        conor.dooley@microchip.com, jszhang@kernel.org,
        andy.chiu@sifive.com, dave.hansen@linux.intel.com,
        elver@google.com, glider@google.com, cyphar@cyphar.com,
        kirill.shutemov@linux.intel.com, keescook@chromium.org,
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

Hi Bj=C3=B6rn,

On Fri, Sep 1, 2023 at 5:06=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.=
org> wrote:
>
> yunhui cui <cuiyunhui@bytedance.com> writes:
>
> > Hi Bj=C3=B6rn=EF=BC=8C
> >
> > On Fri, Aug 18, 2023 at 9:33=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@ke=
rnel.org> wrote:
> >>
> >> Yunhui Cui <cuiyunhui@bytedance.com> writes:
> >>
> >> > Add userland instruction dump and rename dump_kernel_instr()
> >> > to dump_instr().
> >> >
> >> > An example:
> >> > [    0.822439] Freeing unused kernel image (initmem) memory: 6916K
> >> > [    0.823817] Run /init as init process
> >> > [    0.839411] init[1]: unhandled signal 4 code 0x1 at 0x00000000000=
5be18 in bb[10000+5fb000]
> >> > [    0.840751] CPU: 0 PID: 1 Comm: init Not tainted 5.14.0-rc4-00049=
-gbd644290aa72-dirty #187
> >> > [    0.841373] Hardware name:  , BIOS
> >> > [    0.841743] epc : 000000000005be18 ra : 0000000000079e74 sp : 000=
0003fffcafda0
> >> > [    0.842271]  gp : ffffffff816e9dc8 tp : 0000000000000000 t0 : 000=
0000000000000
> >> > [    0.842947]  t1 : 0000003fffc9fdf0 t2 : 0000000000000000 s0 : 000=
0000000000000
> >> > [    0.843434]  s1 : 0000000000000000 a0 : 0000003fffca0190 a1 : 000=
0003fffcafe18
> >> > [    0.843891]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 000=
0000000000000
> >> > [    0.844357]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 000=
0000000000000
> >> > [    0.844803]  s2 : 0000000000000000 s3 : 0000000000000000 s4 : 000=
0000000000000
> >> > [    0.845253]  s5 : 0000000000000000 s6 : 0000000000000000 s7 : 000=
0000000000000
> >> > [    0.845722]  s8 : 0000000000000000 s9 : 0000000000000000 s10: 000=
0000000000000
> >> > [    0.846180]  s11: 0000000000d144e0 t3 : 0000000000000000 t4 : 000=
0000000000000
> >> > [    0.846616]  t5 : 0000000000000000 t6 : 0000000000000000
> >> > [    0.847204] status: 0000000200000020 badaddr: 00000000f0028053 ca=
use: 0000000000000002
> >> > [    0.848219] Code: f06f ff5f 3823 fa11 0113 fb01 2e23 0201 0293 00=
00 (8053) f002
> >> > [    0.851016] Kernel panic - not syncing: Attempted to kill init! e=
xitcode=3D0x00000004
> >> >
> >> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> >>
> >> Nice!
> >>
> >> Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> >
> > When can this patch be applied to the linux-next branch?
>
> It looks like you're getting a sparse warning on the patch [1], and
> that's probably why it hasn't been considered. You need something like:
>
> --
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 69b5d18b5ae9..c5364131b8bd 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -34,7 +34,7 @@ int show_unhandled_signals =3D 1;
>  static DEFINE_SPINLOCK(die_lock);
>
>  #define get_user_nofault(val, ptr) ({                          \
> -       const typeof(val) *__gk_ptr =3D (ptr);                    \
> +       const typeof(val) __user *__gk_ptr =3D (__force const typeof(val)=
 __user *)(ptr); \
>         copy_from_user_nofault(&(val), __gk_ptr, sizeof(val));\
>  })
> --
>
> IDK, maybe it worth removing the define all together, and just open code
> it.
>
> When you're submitting patches, it's a good thing to track patchwork for
> warnings/errors.
>
>
> Bj=C3=B6rn
>
> [1] https://patchwork.kernel.org/project/linux-riscv/patch/20230818121504=
.60492-1-cuiyunhui@bytedance.com/

Okay, I might as well remove the macro, after all, the definition is only h=
ere.
I'll update it v5 like:
+static int copy_code(struct pt_regs *regs, u16 *val, const u16 *insns)
+{
+       if (!user_mode(regs))
+               return get_kernel_nofault(*val, insns);
+
+       /* The user space code from other tasks cannot be accessed. */
+       if (regs !=3D task_pt_regs(current))
+               return -EPERM;
+
+       return copy_from_user_nofault(val, insns, sizeof(*val));
+}

Thanks,
Yunhui
