Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4910377025E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbjHDN5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjHDN5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:57:30 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F98FB1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 06:57:28 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bf9252eddso305759966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 06:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691157444; x=1691762244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQEI9Tt3LPX/UCb4Pxuia74BKZS5am/oZbLnhTBeH5c=;
        b=Otu/1GYg84nX3mTs9KrnY7Fb1wsM87ctGmjkaZJjc6ioUNjhdntrjdeF0yrrTxpLri
         IWraiJYMXDRpLdrR/FbVX8Xg9wlIkk+gTVNJ+QXz0mwD9kt6bV32AAKslqoHYtudLmNC
         4B2RnnnEOSrbl9r5Wmf/OZvjEQHwixyCM7FAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691157444; x=1691762244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQEI9Tt3LPX/UCb4Pxuia74BKZS5am/oZbLnhTBeH5c=;
        b=Va957Cu3kPg/+CZMhMjzw802WUoNDoCPNpx1LK/DhT+dcSMCewp6dNtO1FnWUNraNo
         gBJM5YG7QiPvNgF/M4ts02MWDh0FJGB+K0agDKsIUpJH9OzuMMxSU2mFnPEdqeWCQnf1
         ZuudO9Z0ZDw1ywh9XD9veR5up1MztKu0Pqsg/oaNBS9/Zz0dOYiNyGoWPksh7joy7VBh
         +RG5yc8HlC8AweaycjHcdbGjvVu8VWtfgC2e6EU2u/UPiZY8KEZ7D/woopbAXVRVlYMZ
         MsUJSYQ38Yqz3/49cUqfYm6UMc+/Ji6+rPKj74MNi7p0jVpjj+cRy4H2CHb3ssb2Vign
         ah7w==
X-Gm-Message-State: AOJu0Yx2gh0KTemBPZYH0wN5wuCx291d1TVX8N6q2YheFwQnK9tdi14O
        u7Zco84osLrGpnmI2imMgxmjZ5RsmjlmIA36KBZQmRfi
X-Google-Smtp-Source: AGHT+IG+ADm3SjHV9UyEqRjLy2ApKU30mCDFua4pCJEIrluBI79tlPyyIjx5hHwmaFC/lpLjwZ4Tsw==
X-Received: by 2002:a17:906:53cc:b0:993:d7cf:f58 with SMTP id p12-20020a17090653cc00b00993d7cf0f58mr1675169ejo.2.1691157444325;
        Fri, 04 Aug 2023 06:57:24 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id b3-20020a170906038300b0098e42bef732sm1330862eja.183.2023.08.04.06.57.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 06:57:24 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-3fe32ec7201so72265e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 06:57:24 -0700 (PDT)
X-Received: by 2002:a05:600c:1f90:b0:3f1:9a3d:4f7f with SMTP id
 je16-20020a05600c1f9000b003f19a3d4f7fmr49358wmb.1.1691157423841; Fri, 04 Aug
 2023 06:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230803160649.v3.1.Ia35521b91fc781368945161d7b28538f9996c182@changeid>
 <ZMytyEoCARgP9VR8@dhcp22.suse.cz>
In-Reply-To: <ZMytyEoCARgP9VR8@dhcp22.suse.cz>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 4 Aug 2023 06:56:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UQ18JG-sMBJHrhXByCWYSgOpCq8tL=3R8pT8CnFEa=pA@mail.gmail.com>
Message-ID: <CAD=FV=UQ18JG-sMBJHrhXByCWYSgOpCq8tL=3R8pT8CnFEa=pA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] nmi_backtrace: Allow excluding an arbitrary CPU
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Qing Zhang <zhangqing@loongson.cn>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Rix <trix@redhat.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Valentin Schneider <vschneid@redhat.com>,
        WANG Xuerui <kernel@xen0n.name>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 4, 2023 at 12:50=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Thu 03-08-23 16:07:57, Douglas Anderson wrote:
> > The APIs that allow backtracing across CPUs have always had a way to
> > exclude the current CPU. This convenience means callers didn't need to
> > find a place to allocate a CPU mask just to handle the common case.
> >
> > Let's extend the API to take a CPU ID to exclude instead of just a
> > boolean. This isn't any more complex for the API to handle and allows
> > the hardlockup detector to exclude a different CPU (the one it already
> > did a trace for) without needing to find space for a CPU mask.
> >
> > Arguably, this new API also encourages safer behavior. Specifically if
> > the caller wants to avoid tracing the current CPU (maybe because they
> > already traced the current CPU) this makes it more obvious to the
> > caller that they need to make sure that the current CPU ID can't
> > change.
>
> Yes, this looks like the best way forward.
>
> It would have been slightly safer to modify arch_trigger_cpumask_backtrac=
e
> by switching arguments so that some leftovers are captured easier.

I'm not sure I understand. Oh, you're saying make the prototype of
arch_trigger_cpumask_backtrace() incompatible so that if someone is
directly calling it then it'll be a compile-time error? I guess the
hope is that nobody is calling that directly and they're calling
through the trigger_...() functions.

For now I'm going to leave this alone.


> You also have this leftover
> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> index 00982b133dc1..9f1743ee2b28 100644
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -190,10 +190,6 @@ static inline bool trigger_all_cpu_backtrace(void)
>  {
>         return false;
>  }
> -static inline bool trigger_allbutself_cpu_backtrace(void)
> -{
> -       return false;
> -}

Ah yes. I missed that case. Let me send a quick v4.


>  static inline bool trigger_cpumask_backtrace(struct cpumask *mask)
>  {
>         return false;
>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Anyway
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
