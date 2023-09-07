Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20380797665
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbjIGQIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238578AbjIGQH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:07:56 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A1BD17D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:00:48 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-501bd6f7d11so1853910e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694102370; x=1694707170; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90u68D9H+JLsBVvyuV4vyLydDhUwYz9a13aqB1Txjj4=;
        b=JX5nz1rpJjh8vi504edwZrEfUcv2KpbcpyII0qTJM3QhPPsdLToq1juM1FA8dSrsdF
         d5yF5qWoYZ6Sr754pnrpU7fCzjY0uSr/BA52hQ3CyC/1n5OOL30iN6Y6RewliQ+sMWlz
         MvjT/3p3boSj8xV/gDkJvjdwNkd40+inkoCxMaXrRH7innvSl3mQOenrBWN+QLqRiZLm
         YeJABsg31a75Sa9oCFa6O8wnSSrRXcGJUcNpu2g3T/IqY+E0qibN1DS8ovKI+b6ZiJwt
         /LEsjVV2uKhk7gYgvrxNajdQJJtJFWfB5PuimU5uyVIjIn/Ns50X5TZkz+hIA4oaJa+O
         2gMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694102370; x=1694707170;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90u68D9H+JLsBVvyuV4vyLydDhUwYz9a13aqB1Txjj4=;
        b=lYw+nnyMLbke6FRiLOEf9HAhKU5e50YTVU4jSqxz1PBI6hriwyy+c7MoR9jjWfNS+6
         GaiivspC6Zu4Ls4BulAPo9BK26LfigAzMU0k1fZohMd6cqXBoaNhtg8ghbwwKRBBILZx
         kpkO+D7mNkUwGQEKYR4WKTYVxNtZfi1ZNrYr3QpF9pP5uIvNxQNtD4uQxZj8DLRuf/O9
         fk3YJJaXcNYOUAGl/Gf1k/X2/3DMjUigYMo8infd4cxlbTOJZ9568ULdVs0UUOpOlkZw
         nGD2B7NZHy9P+P9i9AZ6FYvwIHCvDUNaC1CaMDXWgfF+gxgi3lZyHS5zTl0nA5yhjgX6
         dpLg==
X-Gm-Message-State: AOJu0Yw66hozy15WhaHZPmx4+vfBFOewhFbrb8FWnQxcLWPsf+avGn1Z
        kro2N6jZwyCBlNIZ4MUlz3TiopLV2w1gVmrVJ5ppb93jVFjAqErpOMg=
X-Google-Smtp-Source: AGHT+IFhYlmhCf4jB46umRXIi/Py9M4QQfQzziUEI4I0Mn9rPBWre08kyQfiO58iQvTBTthkqsMkE0/cCHt2BZ4oIXs=
X-Received: by 2002:a05:6000:4ec:b0:314:3c84:4da2 with SMTP id
 cr12-20020a05600004ec00b003143c844da2mr4681376wrb.13.1694087006274; Thu, 07
 Sep 2023 04:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230901123043.73700-1-cuiyunhui@bytedance.com>
In-Reply-To: <20230901123043.73700-1-cuiyunhui@bytedance.com>
From:   yunhui cui <cuiyunhui@bytedance.com>
Date:   Thu, 7 Sep 2023 19:43:15 +0800
Message-ID: <CAEEQ3wm6BOMFXr78kb6J5tGXgfNu1fJcvTg=sw4QT2ZeWYQTVQ@mail.gmail.com>
Subject: Re: [PATCH v5] riscv: add userland instruction dump to RISC-V splats
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, guoren@kernel.org, bjorn@rivosinc.com,
        conor.dooley@microchip.com, jszhang@kernel.org,
        andy.chiu@sifive.com, cuiyunhui@bytedance.com,
        dave.hansen@linux.intel.com, elver@google.com, glider@google.com,
        cyphar@cyphar.com, kirill.shutemov@linux.intel.com,
        keescook@chromium.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bj=C3=B6rn,


On Fri, Sep 1, 2023 at 8:30=E2=80=AFPM Yunhui Cui <cuiyunhui@bytedance.com>=
 wrote:
>
> Add userland instruction dump and rename dump_kernel_instr()
> to dump_instr().
>
> An example:
> [    0.822439] Freeing unused kernel image (initmem) memory: 6916K
> [    0.823817] Run /init as init process
> [    0.839411] init[1]: unhandled signal 4 code 0x1 at 0x000000000005be18=
 in bb[10000+5fb000]
> [    0.840751] CPU: 0 PID: 1 Comm: init Not tainted 5.14.0-rc4-00049-gbd6=
44290aa72-dirty #187
> [    0.841373] Hardware name:  , BIOS
> [    0.841743] epc : 000000000005be18 ra : 0000000000079e74 sp : 0000003f=
ffcafda0
> [    0.842271]  gp : ffffffff816e9dc8 tp : 0000000000000000 t0 : 00000000=
00000000
> [    0.842947]  t1 : 0000003fffc9fdf0 t2 : 0000000000000000 s0 : 00000000=
00000000
> [    0.843434]  s1 : 0000000000000000 a0 : 0000003fffca0190 a1 : 0000003f=
ffcafe18
> [    0.843891]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 00000000=
00000000
> [    0.844357]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 00000000=
00000000
> [    0.844803]  s2 : 0000000000000000 s3 : 0000000000000000 s4 : 00000000=
00000000
> [    0.845253]  s5 : 0000000000000000 s6 : 0000000000000000 s7 : 00000000=
00000000
> [    0.845722]  s8 : 0000000000000000 s9 : 0000000000000000 s10: 00000000=
00000000
> [    0.846180]  s11: 0000000000d144e0 t3 : 0000000000000000 t4 : 00000000=
00000000
> [    0.846616]  t5 : 0000000000000000 t6 : 0000000000000000
> [    0.847204] status: 0000000200000020 badaddr: 00000000f0028053 cause: =
0000000000000002
> [    0.848219] Code: f06f ff5f 3823 fa11 0113 fb01 2e23 0201 0293 0000 (8=
053) f002
> [    0.851016] Kernel panic - not syncing: Attempted to kill init! exitco=
de=3D0x00000004
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/riscv/kernel/traps.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index f798c853bede..923b49c38985 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -33,7 +33,19 @@ int show_unhandled_signals =3D 1;
>
>  static DEFINE_SPINLOCK(die_lock);
>
> -static void dump_kernel_instr(const char *loglvl, struct pt_regs *regs)
> +static int copy_code(struct pt_regs *regs, u16 *val, const u16 *insns)
> +{
> +       if (!user_mode(regs))
> +               return get_kernel_nofault(*val, insns);
> +
> +       /* The user space code from other tasks cannot be accessed. */
> +       if (regs !=3D task_pt_regs(current))
> +               return -EPERM;
> +
> +       return copy_from_user_nofault(val, insns, sizeof(*val));
> +}
> +
> +static void dump_instr(const char *loglvl, struct pt_regs *regs)
>  {
>         char str[sizeof("0000 ") * 12 + 2 + 1], *p =3D str;
>         const u16 *insns =3D (u16 *)instruction_pointer(regs);
> @@ -42,7 +54,7 @@ static void dump_kernel_instr(const char *loglvl, struc=
t pt_regs *regs)
>         int i;
>
>         for (i =3D -10; i < 2; i++) {
> -               bad =3D get_kernel_nofault(val, &insns[i]);
> +               bad =3D copy_code(regs, &val, &insns[i]);
>                 if (!bad) {
>                         p +=3D sprintf(p, i =3D=3D 0 ? "(%04hx) " : "%04h=
x ", val);
>                 } else {
> @@ -71,7 +83,7 @@ void die(struct pt_regs *regs, const char *str)
>         print_modules();
>         if (regs) {
>                 show_regs(regs);
> -               dump_kernel_instr(KERN_EMERG, regs);
> +               dump_instr(KERN_EMERG, regs);
>         }
>
>         cause =3D regs ? regs->cause : -1;
> @@ -104,6 +116,7 @@ void do_trap(struct pt_regs *regs, int signo, int cod=
e, unsigned long addr)
>                 print_vma_addr(KERN_CONT " in ", instruction_pointer(regs=
));
>                 pr_cont("\n");
>                 __show_regs(regs);
> +               dump_instr(KERN_EMERG, regs);
>         }
>
>         force_sig_fault(signo, code, (void __user *)addr);
> --
> 2.20.1
>

This patch has been passed:
https://patchwork.kernel.org/project/linux-riscv/patch/20230901123043.73700=
-1-cuiyunhui@bytedance.com/

Could you help merge it to linux-next?

Thanks=EF=BC=8C
Yunhui
