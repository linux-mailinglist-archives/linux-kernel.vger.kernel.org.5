Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BF97682B3
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 01:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjG2XTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 19:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjG2XTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 19:19:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBE030D4;
        Sat, 29 Jul 2023 16:19:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B716560B7C;
        Sat, 29 Jul 2023 23:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26592C433BB;
        Sat, 29 Jul 2023 23:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690672766;
        bh=hkedZRP0pmJPvtoATmQv5DhWWG14hr7Dzkcd8VtvSdY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VTVaq1MS3kAgtvomLvRNgm9yl1ruw3l2kbXIsMdISRaLMJ2XhwlcSfzCTTkLcLnef
         9vMBC9mh54LmVVCHNycZDH5q5XKvA6VTlg1SSgga7BhaPNYoWtpE8o6l5pi3+lLHAe
         i4BD7qK4VXgdJEZtdh8EmuI96xwq6tNL/el7RIGLv2B4nc3lrmBRslTQsOkBhXbmgw
         T/7/MuDF2Ys3mLBm/Vnd7e4aGURbwKEWUl65ZilZkvQOx8FwXjKRzkY7IwYSfoJ3qN
         oDqCNAn5LXPwvBrfA/Kq8KKBP6nVEo/CKNJpzuvFKB4oG/rNGOahoPtAPJ6OrqxIpG
         Ru2pVWUIunvYQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5227e5d9d96so4285024a12.2;
        Sat, 29 Jul 2023 16:19:26 -0700 (PDT)
X-Gm-Message-State: ABy/qLYTKVeYua9vfCv0nzDDvWP4HD/ch69ZTuxGY4Dv8nWV8csxOIE6
        nJZ0jw7U4w8zXpvIapXXXTfSl/TNyF+16TEBchw=
X-Google-Smtp-Source: APBJJlEDXcWd/g3fqIl5w0SvDZiLHM9JOWKvqOsdKPwj6gGSH+Rhs68Y932KO/wlq+iOvGuSNMsrzS7GTmUO5H4w6zk=
X-Received: by 2002:a17:907:2ccf:b0:993:e9b8:90f5 with SMTP id
 hg15-20020a1709072ccf00b00993e9b890f5mr2784182ejc.8.1690672764357; Sat, 29
 Jul 2023 16:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230726145740.1765323-1-arnd@kernel.org> <CAJF2gTTC0BTOyWH4Zod1oRQaUpS9dE-6=otfpGOPcCcffrHohQ@mail.gmail.com>
 <ef413a40-ddc4-4d23-bc56-23b7095ffc83@app.fastmail.com> <fc2b139b-909b-46d7-abbc-7ab287c9d06d@app.fastmail.com>
In-Reply-To: <fc2b139b-909b-46d7-abbc-7ab287c9d06d@app.fastmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 29 Jul 2023 19:19:12 -0400
X-Gmail-Original-Message-ID: <CAJF2gTRMZkT=CE0=g25Hfe7v9_GE8UmqhKBP1vsXd06w+9NBiQ@mail.gmail.com>
Message-ID: <CAJF2gTRMZkT=CE0=g25Hfe7v9_GE8UmqhKBP1vsXd06w+9NBiQ@mail.gmail.com>
Subject: Re: [PATCH] csky: fix old style declaration in module.c
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 4:05=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> On Sat, Jul 29, 2023, at 09:06, Arnd Bergmann wrote:
> > On Sat, Jul 29, 2023, at 06:59, Guo Ren wrote:
>
> > I'd like to enable a few warning options (-Wextra, -Wrestrict,
> > -Wmissing-prototypes, ...) in the Kbuild for 6.6, but the Makefile
> > changes will probably go through the Kbuild tree or linux-mm,
> > and the fixes for existing warnings can just take their normal way.
>
> I just checked my log files again and I now see that there
> are actually a number of -Wcc warnings as well:
>
> csky/kernel/signal.c:255:17: error: no previous prototype for 'do_notify_=
resume' [-Werror=3Dmissing-prototypes]
> csky/mm/fault.c:187:17: error: no previous prototype for 'do_page_fault' =
[-Werror=3Dmissing-prototypes]
> csky/kernel/traps.c:57:13: error: no previous prototype for 'trap_init' [=
-Werror=3Dmissing-prototypes]
> csky/kernel/traps.c:150:15: error: no previous prototype for 'do_trap_unk=
nown' [-Werror=3Dmissing-prototypes]
> csky/kernel/traps.c:152:15: error: no previous prototype for 'do_trap_zdi=
v' [-Werror=3Dmissing-prototypes]
> csky/kernel/traps.c:154:15: error: no previous prototype for 'do_trap_bus=
err' [-Werror=3Dmissing-prototypes]
> csky/kernel/traps.c:157:17: error: no previous prototype for 'do_trap_mis=
aligned' [-Werror=3Dmissing-prototypes]
> csky/kernel/traps.c:168:17: error: no previous prototype for 'do_trap_bkp=
t' [-Werror=3Dmissing-prototypes]
> csky/kernel/traps.c:187:17: error: no previous prototype for 'do_trap_ill=
insn' [-Werror=3Dmissing-prototypes]
> csky/kernel/traps.c:210:17: error: no previous prototype for 'do_trap_fpe=
' [-Werror=3Dmissing-prototypes]
> csky/kernel/traps.c:220:17: error: no previous prototype for 'do_trap_pri=
v' [-Werror=3Dmissing-prototypes]
> csky/kernel/traps.c:230:17: error: no previous prototype for 'trap_c' [-W=
error=3Dmissing-prototypes]
> csky/kernel/vdso/vgettimeofday.c:6:5: error: no previous prototype for '_=
_vdso_clock_gettime' [-Werror=3Dmissing-prototypes]
> csky/kernel/vdso/vgettimeofday.c:12:5: error: no previous prototype for '=
__vdso_clock_gettime64' [-Werror=3Dmissing-prototypes]
> csky/kernel/vdso/vgettimeofday.c:18:5: error: no previous prototype for '=
__vdso_gettimeofday' [-Werror=3Dmissing-prototypes]
> csky/kernel/vdso/vgettimeofday.c:24:5: error: no previous prototype for '=
__vdso_clock_getres' [-Werror=3Dmissing-prototypes]
> csky/kernel/setup.c:104:34: error: no previous prototype for 'csky_start'=
 [-Werror=3Dmissing-prototypes]
> csky/kernel/ptrace.c:320:16: error: no previous prototype for 'syscall_tr=
ace_enter' [-Werror=3Dmissing-prototypes]
> csky/kernel/ptrace.c:336:17: error: no previous prototype for 'syscall_tr=
ace_exit' [-Werror=3Dmissing-prototypes]
>
> I missed these as I was first looking at everything except
> -Wmissing-prototypes that I want to enable. Can you perhaps
> help out and create a fix for these yourself?
Okay, I'll check


>
>        Arnd



--=20
Best Regards
 Guo Ren
