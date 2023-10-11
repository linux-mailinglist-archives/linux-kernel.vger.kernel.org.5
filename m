Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537527C4C3A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345588AbjJKHqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345427AbjJKHpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:45:51 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186299B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:45:49 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-538575a38ffso10628426a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697010347; x=1697615147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNhFI0v6UKt7VgTziyBvjQKuILoZxlQQlESpPcR93wY=;
        b=GHLOxhv3KUk1L4RHPSrouX+cFSkl2Xi+92kgzHnEviATBkpnxybA+sfuaLM6meH/ob
         fCWrPGJpR8LpHugAiwXO3ofI7oim2Jm2QTPVrNvIrP2swMrkPDj6262SufI79I9pm3Uw
         KL/xvCnU9z16OtRRDoOo/cWth3oJtmrgAO246dhuSmh+HeHvUzRKvEe50cQo/oXS2Wpm
         8BHJd1+UIaP5Bobjb+5a91niLxTzUtyknUPXaaa5GKtqEDGMentOlU32wFeF5UI9KFn/
         ZEZezHWDyD15mL8ZiBcG2cOyp/G2ssieGoS13mbfLwjiKmA8SeACeoSy34P0SHVsmpI7
         DZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697010347; x=1697615147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNhFI0v6UKt7VgTziyBvjQKuILoZxlQQlESpPcR93wY=;
        b=dMguxZyd4onuoOBmDBkmY+uDTDqXYQ929/mSVunssFMghMSMZTWTXXlnqnc//Iiuyv
         LecqzO7qr6qvsaoYMGri/vjWQEX0pDx95GzRd32uLFZa+YvAk1QLxKj0z5jq60i8S/f1
         32+3O1Pn0n8I3ZBgQ9OzvfCXdK67PcwHW1s1/w2yfDK8hyfIRevgYJNIcUWf1LmF3AOO
         6pF1N/HI3YlOwTmh0vz3fau7wwq87/7+TmDr5/rJ6WLJab2ARsVzxYfSXKncde7+cce4
         K5FdWiWTgmX2fHK829/MTYIQa7NdDMVDl8/WeJ6/yN8dFK5DH13jY3q3U3ObZ0+4Zqpl
         a/ww==
X-Gm-Message-State: AOJu0YxwpKIhjogKigSBXNDNgEtXoSYXkLdSZci2eu1LVKKz79aPyRB4
        VbkkbZqvzCSvLwPNZ5cEeADDAxwjhB1kqhucL+w=
X-Google-Smtp-Source: AGHT+IHwGKH/zQTAT/Tqq3t8U2wzLX+orADo8tbm7ECgowENe4futBgruOphOh1VL32xSLDR2GgFa81ShuY0G2tWA2o=
X-Received: by 2002:aa7:cd74:0:b0:52a:6497:d02b with SMTP id
 ca20-20020aa7cd74000000b0052a6497d02bmr18961168edb.16.1697010347429; Wed, 11
 Oct 2023 00:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <CAFULd4Y8NSArDqH=VMy8F97eNosUUGxrBMEyHH=MytjUBSCmjg@mail.gmail.com>
 <CAHk-=whMr8V_q3dq4iS0dpx4Nssu+aYWz+mA36p2ykA+OXTjXA@mail.gmail.com> <CAFULd4Z-F0mFov5zhLya=OfPnQx=oOHkyLqs_UVTbQaWjk7AMA@mail.gmail.com>
In-Reply-To: <CAFULd4Z-F0mFov5zhLya=OfPnQx=oOHkyLqs_UVTbQaWjk7AMA@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 11 Oct 2023 09:45:36 +0200
Message-ID: <CAFULd4bPPRmdwUCehKhx=cSVAK8r+6+7cEL24WdUNCPO3Y5Rbw@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 9:27=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wro=
te:

> > IOW, something like
> >
> >     static __always_inline unsigned long new_cpu_offset(void)
> >     {
> >         unsigned long res;
> >         asm(ALTERNATIVE(
> >                         "movq " __percpu_arg(1) ",%0",
> >                         "rdgsbase %0",
> >                         X86_FEATURE_FSGSBASE)
> >                 : "=3Dr" (res)
> >                 : "m" (this_cpu_off));
> >         return res;
> >     }
> >
> > would presumably work together with your __seg_gs stuff.
>
> I have zero experience with rdgsbase insn, but the above is not
> dependent on __seg_gs, so (the movq part at least) would also work in
> the current mainline. To work together with __seg_gs stuff,
> this_cpu_offset should be enclosed in __my_cpu_var. Also, if rdgsbase
> is substituted with rdfsbase, it will also work for 32-bit targets.

In fact, rdgsbase is available only for 64-bit targets.

Uros.
