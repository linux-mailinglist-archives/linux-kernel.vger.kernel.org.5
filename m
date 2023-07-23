Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBF075E197
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 13:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjGWLSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 07:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGWLSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 07:18:10 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B93AA8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 04:18:08 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b974031aeaso28305391fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 04:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690111086; x=1690715886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BO40iUCR34boKqtV0a+boSEm0WAYtmQoWtGDnOfzR2Q=;
        b=VK/biSlS5pE4EID7AILxs3ipynaIyBiv+BcJ2fOqK/u014CGOEgOE7VIfG+Tpriu/1
         +4rQr3Zms/Dp9JJ5YRsKUpC5jT0yVHsZ4Pzu8o1X2mjv8kEAazpiKBJLnboWe021XfJa
         CrZNivugVUT8VNgs6tysfek4Eor/qsem/uD/oO7C7FTMr3tKxdTsVGKiiR6wwT+ZJPx8
         km5/AhBk3tgViaUgI1NJVYDdVt0z91//5hgBKmWc/nlI7zniYP75WEQWOTvGkkZSyJij
         lCW+GeETpY9Z6sPG5Y09PsHcFf1q7ObW11YLshhGGx8VkeuNR+rL4dFtEPXcOCwFsCqd
         KXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690111086; x=1690715886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BO40iUCR34boKqtV0a+boSEm0WAYtmQoWtGDnOfzR2Q=;
        b=NFLAF37WVQ8xkbEZVtq2zzxq+X/EYtc4JXXCSNtiwA4P9J/EGiA/1Cw7g9ml/DFTHT
         Z093VllLkI6oSbDyfLq95GF4I5I1FR6lqSYkrayrqD3O9kAC/ZnGurKgCNtBJPqfc5GR
         NyDf6SFyTYHhrhkXhUZ7DpuvTYraSYlMgNj3br0T4Ippq7GTVI90znLhaEdJh7UlNf5r
         cIrseD66lyWYSpqhfgqcoWJAyaHFIcfZ+CGHGJ3kPbajFZJsTAQjDYlEx3k/gefDQTXw
         1ZFWMSD33ugNZCqcKeCkQRZlOAxAQWOFeYoQp4Z4KqfJw6mz3/3BxSBTYWEip0kRaQ64
         YbQw==
X-Gm-Message-State: ABy/qLbx+TLPBHA+aRvR2dVzkBlcK2PfRG5T66nEPkfGFwkBrbMZQdnj
        443JRIFZG/7A7X/Pjxqo7rqdlh4EzoKzSwOCVQ==
X-Google-Smtp-Source: APBJJlFksztVU4koECHGPBtdcbxQd70XoxBZxc56IK4tGMeB0BKRCik2RAdhy8+1dy95dPRg/nzDL0Ld1m9udXYrcOw=
X-Received: by 2002:a05:651c:20b:b0:2b6:efc7:2aee with SMTP id
 y11-20020a05651c020b00b002b6efc72aeemr4267883ljn.51.1690111086216; Sun, 23
 Jul 2023 04:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230721161018.50214-1-brgerst@gmail.com> <20230721161018.50214-3-brgerst@gmail.com>
 <SA1PR11MB6734D85E6D1DB2BBFBBDF069A83DA@SA1PR11MB6734.namprd11.prod.outlook.com>
In-Reply-To: <SA1PR11MB6734D85E6D1DB2BBFBBDF069A83DA@SA1PR11MB6734.namprd11.prod.outlook.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Sun, 23 Jul 2023 07:17:53 -0400
Message-ID: <CAMzpN2i0NjQ4A3wk_FMhEibr00Zwyk+1SndY3aZSa-paNGS-gg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] x86/entry/64: Convert SYSRET validation tests to C
To:     "Li, Xin3" <xin3.li@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 5:53=E2=80=AFAM Li, Xin3 <xin3.li@intel.com> wrote:
>
>
> > @@ -84,6 +85,43 @@ __visible noinstr void do_syscall_64(struct pt_regs =
*regs, int
> > nr)
> >
> >       instrumentation_end();
> >       syscall_exit_to_user_mode(regs);
>
> Would it be better to make the following code a new function?
>
> And then the similar changes in patch 6 could be merged into the new
> function with #ifdef CONFIG_X86_64.
>
> > +
> > +     /*
> > +      * Check that the register state is valid for using SYSRET to exi=
t
> > +      * to userspace.  Otherwise use the slower but fully capable IRET
> > +      * exit path.
> > +      */
> > +
> > +     /* XEN PV guests always use IRET path */
> > +     if (cpu_feature_enabled(X86_FEATURE_XENPV))
> > +             return false;
> > +
> > +     /* SYSRET requires RCX =3D=3D RIP and R11 =3D=3D EFLAGS */
> > +     if (unlikely(regs->cx !=3D regs->ip || regs->r11 !=3D regs->flags=
))
> > +             return false;
> > +
> > +     /* CS and SS must match the values set in MSR_STAR */
> > +     if (unlikely(regs->cs !=3D __USER_CS || regs->ss !=3D __USER_DS))
> > +             return false;
> > +
> > +     /*
> > +      * On Intel CPUs, SYSRET with non-canonical RCX/RIP will #GP
> > +      * in kernel space.  This essentially lets the user take over
> > +      * the kernel, since userspace controls RSP.
> > +      */
> > +     if (unlikely(!__is_canonical_address(regs->ip, __VIRTUAL_MASK_SHI=
FT +
> > 1)))
> > +             return false;
> > +
> > +     /*
> > +      * SYSRET cannot restore RF.  It can restore TF, but unlike IRET,
> > +      * restoring TF results in a trap from userspace immediately afte=
r
> > +      * SYSRET.
> > +      */
> > +     if (unlikely(regs->flags & (X86_EFLAGS_RF | X86_EFLAGS_TF)))
> > +             return false;
> > +
> > +     /* Use SYSRET to exit to userspace */
> > +     return true;
> >  }
> >  #endif
> >

The tests are similar but not enough to combine them.  If
IA32_EMULATION is enabled, both versions are needed so one copy of the
function with #ifdefs won't work..

Brian Gerst
