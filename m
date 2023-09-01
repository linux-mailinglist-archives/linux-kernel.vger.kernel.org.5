Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4903F78F8FE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 09:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348474AbjIAHRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 03:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjIAHRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 03:17:06 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5D6E7F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 00:17:03 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31dca134c83so1383946f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 00:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693552622; x=1694157422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwsUiHSBSvIQRknRmzUEvnXIncuNFizpbiIrIMgBrD4=;
        b=EYODEFrEOIdUWOC7vix8OzyeOkPynFbuo1uNvVbhpYVV5cF8Gad3HcE2kCeP1ibLIV
         Epx6+C/s6+ekDFKPJUazLsPzhTTSccBSY6ljHLcdQo3ZhfSBA4xHEYrrWqLfNcnRbvY7
         ScqtftIXuaLr6B7m+VTmrBaEWwEo3N+2fb8QodC76y5DL8TJOMtYxlRn4DaG/AVB51VV
         k9zT2vOcviT4S6o5lIDdRZRHNmjtSG1Q1XvR68soL2Mc55cxS7WVAuEIj2Uo4+xXDq+G
         Q8VivMtWjlSbeZqH0drwy+fFSRA/x9AhjznGYGgCBq80b/5BjmIFX5CpwWOK6mx4tTLp
         XIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693552622; x=1694157422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwsUiHSBSvIQRknRmzUEvnXIncuNFizpbiIrIMgBrD4=;
        b=Y6qrldlT8Q5rylZP7yr5vJ34cUOMW5396pkVDkSLa2IQpWSPTwsST1ZC4qMAY/JhZn
         XBdsTRwCMLLt2N67CSwzVh42coAEl8aA2sdVE/ohmeksAfH1irbQ0O9X/JrYrO78ejn3
         RCCS3Zhue6WZr0E5cvmNzhx3nL2X+XtRg4NNrCGDyDKWUTCmbHUwSNZK7PK7bTrPaqp3
         Y6N1fLo2TToaMu+nShWMKoYikeWn5+EI+hIu2J9kEpaesLU1skpqufOgR4XFjwh9XEJO
         oxy2N4NFmasr1MtXYEELCixqX8wRuEoUKH1U4/2COSUbPC/2PMNWaUT99aedSOMWSwVT
         Micw==
X-Gm-Message-State: AOJu0YwqfS2fYmkBxKjFeDsJkmeAd7/OT91XUIjhCrjQBSPp2PMt0syd
        7PcHCie3pQO/DFitzRWKfIUMRLoDni2xvDvpZtjTVA==
X-Google-Smtp-Source: AGHT+IGsHp15JavXEMV06Q0MxKz6Y7Z/ayog654/+XZZ2uCOs9hkOmfmxXwHyeBsCkrvABzY1qEDtAKPsVIHYQLZFZs=
X-Received: by 2002:a5d:4089:0:b0:314:3bd7:6a0c with SMTP id
 o9-20020a5d4089000000b003143bd76a0cmr1263055wrp.33.1693552621943; Fri, 01 Sep
 2023 00:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230818121504.60492-1-cuiyunhui@bytedance.com> <878ra8o4qa.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <878ra8o4qa.fsf@all.your.base.are.belong.to.us>
From:   yunhui cui <cuiyunhui@bytedance.com>
Date:   Fri, 1 Sep 2023 15:16:50 +0800
Message-ID: <CAEEQ3wmL90oOZcmpv8G34u7kg44zGscpHJiiRHLi=_LAm=C1jg@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bj=C3=B6rn=EF=BC=8C

On Fri, Aug 18, 2023 at 9:33=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> Yunhui Cui <cuiyunhui@bytedance.com> writes:
>
> > Add userland instruction dump and rename dump_kernel_instr()
> > to dump_instr().
> >
> > An example:
> > [    0.822439] Freeing unused kernel image (initmem) memory: 6916K
> > [    0.823817] Run /init as init process
> > [    0.839411] init[1]: unhandled signal 4 code 0x1 at 0x000000000005be=
18 in bb[10000+5fb000]
> > [    0.840751] CPU: 0 PID: 1 Comm: init Not tainted 5.14.0-rc4-00049-gb=
d644290aa72-dirty #187
> > [    0.841373] Hardware name:  , BIOS
> > [    0.841743] epc : 000000000005be18 ra : 0000000000079e74 sp : 000000=
3fffcafda0
> > [    0.842271]  gp : ffffffff816e9dc8 tp : 0000000000000000 t0 : 000000=
0000000000
> > [    0.842947]  t1 : 0000003fffc9fdf0 t2 : 0000000000000000 s0 : 000000=
0000000000
> > [    0.843434]  s1 : 0000000000000000 a0 : 0000003fffca0190 a1 : 000000=
3fffcafe18
> > [    0.843891]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 000000=
0000000000
> > [    0.844357]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 000000=
0000000000
> > [    0.844803]  s2 : 0000000000000000 s3 : 0000000000000000 s4 : 000000=
0000000000
> > [    0.845253]  s5 : 0000000000000000 s6 : 0000000000000000 s7 : 000000=
0000000000
> > [    0.845722]  s8 : 0000000000000000 s9 : 0000000000000000 s10: 000000=
0000000000
> > [    0.846180]  s11: 0000000000d144e0 t3 : 0000000000000000 t4 : 000000=
0000000000
> > [    0.846616]  t5 : 0000000000000000 t6 : 0000000000000000
> > [    0.847204] status: 0000000200000020 badaddr: 00000000f0028053 cause=
: 0000000000000002
> > [    0.848219] Code: f06f ff5f 3823 fa11 0113 fb01 2e23 0201 0293 0000 =
(8053) f002
> > [    0.851016] Kernel panic - not syncing: Attempted to kill init! exit=
code=3D0x00000004
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>
> Nice!
>
> Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

When can this patch be applied to the linux-next branch?

Thanks,
Yunhui
