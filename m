Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C2976B5C3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbjHANZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbjHANZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:25:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985C2198B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 06:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690896278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=du9AAG/dP7EybnXiTIbMPQ2DqZuLKJ1D8f7iRAwNssA=;
        b=Nx7HD14vi4zxz/iNiM1G5X6oWGbOBzk2isKAYjjwoU07j8IWWJNrcl2/p9dOx7buw8bJmw
        U4wcdfR1dTdr30O6moLyDOMHSpnGFLj3UHIVyhYOmk/0SzUWzgdeZ7O7G9exrWX9VwOGrX
        MpuSLlq3L5b9nYDdSG8J7i8ImVk2O8U=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-hH9pMqPIPu6Mtoo3JgGh_Q-1; Tue, 01 Aug 2023 09:24:36 -0400
X-MC-Unique: hH9pMqPIPu6Mtoo3JgGh_Q-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5646868b9e7so638707a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 06:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690896275; x=1691501075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=du9AAG/dP7EybnXiTIbMPQ2DqZuLKJ1D8f7iRAwNssA=;
        b=N/Bf7tNU8ihfwqupo1uPzkLqfTrUTJ1qdGWoDcPVHFFETY6xe6bi0BvqxblXRgPV8n
         x8MzQ5bbvHqturtAi8/qkGGOf40S5JAnj74oFgha4GZ+sl+jAXwsSGf5tQCgz0A7ThOl
         QaMEbsVd/xXtJibj5K46+Ik8xapcT19a1LdVc+j0zesobwgAaIpBRRq81aqs/avmnpZF
         INLad1IaQzyoEaCPWUGZxDjuhKuOr4iv94+p/UhtPRL3TshU5X5fvO7g9I0hqKeiY370
         QpFMTWaRlupl5qNIp8lrTB1KbTa4JLyTeeSfRMS3CA0l0nvz+oFmlJdjDfcDH4g8/6Zh
         +h7g==
X-Gm-Message-State: ABy/qLZYKAT9lP/29LKaI9BPOFcCSddON/tNJWa9/Tn8PYqWauE+Vm4/
        YMlk6ozHHQ8FQTfW8xcFVz9Z7sKHXojLTEmt2LHRABovi7AP7Q/0nJem8+VyL+JvwfXp0x202SJ
        Pkuavi/XweYrgmZstxoV7OF500oIa2q58VgUdtjuB
X-Received: by 2002:a17:902:8301:b0:1b0:3a74:7fc4 with SMTP id bd1-20020a170902830100b001b03a747fc4mr9249083plb.24.1690896275003;
        Tue, 01 Aug 2023 06:24:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEdL4Qc45HE412hd5YyrtzfiXVBDGQUYaed1NNu54V07lQbE55W9fai0JxCrCvPbOe8HjogCi1SMpvR70AlGak=
X-Received: by 2002:a17:902:8301:b0:1b0:3a74:7fc4 with SMTP id
 bd1-20020a170902830100b001b03a747fc4mr9249064plb.24.1690896274612; Tue, 01
 Aug 2023 06:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230620131223.431281-1-omosnace@redhat.com> <87edkseqf8.fsf@mail.lhotse>
 <CAFqZXNtsCKsr0YHPCSJJQ5An=RoMhf0dufgr7P_SnAAv7CrLjw@mail.gmail.com>
 <CAEjxPJ643nmW6HZOmQGNFDj-cQGf-x3jzZcrO8BHVN9thM23Dw@mail.gmail.com>
 <CAFqZXNuM-807tmT84rZ25xwh078BxvSfav88AozH=tt=J+dCrA@mail.gmail.com>
 <CAJ2a_DdZHFTHiRu5+ZENAwUq1Cor-jVoE9qdhb2x5uSej-MaRA@mail.gmail.com> <CAHC9VhQVQv78Xr1bDoJcuT5s441Lvc8AanMvMh8KXG-PuPTVAQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQVQv78Xr1bDoJcuT5s441Lvc8AanMvMh8KXG-PuPTVAQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 1 Aug 2023 15:24:23 +0200
Message-ID: <CAFqZXNvt1Hz7yZoY47sYQdjUPTTPxa=VmR0=z7or9XjVMwkU=A@mail.gmail.com>
Subject: Re: Login broken with old userspace (was Re: [PATCH v2] selinux:
 introduce an initial SID for early boot processes)
To:     Paul Moore <paul@paul-moore.com>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>, selinux@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-next@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 5:12=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Fri, Jul 28, 2023 at 9:24=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > On Fri, 28 Jul 2023 at 15:14, Ondrej Mosnacek <omosnace@redhat.com> wro=
te:
> > >
> > > On Fri, Jul 28, 2023 at 1:52=E2=80=AFPM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > On Fri, Jul 28, 2023 at 7:36=E2=80=AFAM Ondrej Mosnacek <omosnace@r=
edhat.com> wrote:
> > > > >
> > > > > On Fri, Jul 28, 2023 at 4:12=E2=80=AFAM Michael Ellerman <mpe@ell=
erman.id.au> wrote:
> > > > > >
> > > > > > Ondrej Mosnacek <omosnace@redhat.com> writes:
> > > > > > > Currently, SELinux doesn't allow distinguishing between kerne=
l threads
> > > > > > > and userspace processes that are started before the policy is=
 first
> > > > > > > loaded - both get the label corresponding to the kernel SID. =
The only
> > > > > > > way a process that persists from early boot can get a meaning=
ful label
> > > > > > > is by doing a voluntary dyntransition or re-executing itself.
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > This commit breaks login for me when booting linux-next kernels=
 with old
> > > > > > userspace, specifically Ubuntu 16.04 on ppc64le. 18.04 is OK.
> > > > > >
> > > > > > The symptom is that login never accepts the root password, it j=
ust
> > > > > > always says "Login incorrect".
> > > > > >
> > > > > > Bisect points to this commit.
> > > > > >
> > > > > > Reverting this commit on top of next-20230726, fixes the proble=
m
> > > > > > (ie. login works again).
> > > > > >
> > > > > > Booting with selinux=3D0 also fixes the problem.
> > > > > >
> > > > > > Is this expected? The change log below suggests backward compat=
ibility
> > > > > > was considered, is 16.04 just too old?
> > > > >
> > > > > Hi Michael,
> > > > >
> > > > > I can reproduce it on Fedora 38 when I boot with SELINUX=3Ddisabl=
ed in
> > > > > /etc/selinux/config (+ a kernel including that commit), so it lik=
ely
> > > > > isn't caused by the userspace being old. Can you check what you h=
ave
> > > > > in /etc/selinux/config (or if it exists at all)?
> > > > >
> > > > > We have deprecated and removed the "runtime disable" functionalit=
y in
> > > > > SELinux recently [1], which was used to implement "disabling" SEL=
inux
> > > > > via the /etc/selinux/config file, so now the situation (selinux=
=3D0 +
> > > > > SELINUX=3Ddisabled in /etc/selinux/config) leads to a state where
> > > > > SELinux is enabled, but no policy is loaded (and no enforcement i=
s
> > > > > done). Such a state mostly behaves as if SElinux was truly disabl=
ed
> > > > > (via kernel command line), but there are some subtle differences =
and I
> > > > > believe we don't officially support it (Paul might clarify). With
> > > > > latest kernels it is recommended to either disable SELinux via th=
e
> > > > > kernel command line (or Kconfig[2]) or to boot it in Enforcing or
> > > > > Permissive mode with a valid/usable policy installed.
> > > > >
> > > > > So I wonder if Ubuntu ships by default with the bad configuration=
 or
> > > > > if it's just a result of using the custom-built linux-next kernel=
 (or
> > > > > some changes on your part). If Ubuntu's stock kernel is configure=
d to
> > > > > boot with SELinux enabled by default, they should also by default=
 ship
> > > > > a usable policy and SELINUX=3Dpermissive/enforcing in
> > > > > /etc/selinux/config (or configure the kernel[2] or bootloader to =
boot
> > > > > with SELinux disabled by default). (Although if they ship a pre-[=
1]
> > > > > kernel, they may continue to rely on the runtime disable
> > > > > functionality, but it means people will have to be careful when
> > > > > booting newer or custom kernels.)
> > > > >
> > > > > That said, I'd like to get to the bottom of why the commit causes=
 the
> > > > > login to fail and fix it somehow. I presume something in PAM chok=
es on
> > > > > the fact that userspace tasks now have "init" instead of "kernel"=
 as
> > > > > the pre-policy-load security context, but so far I haven't been a=
ble
> > > > > to pinpoint the problem. I'll keep digging...
> > > > >
> > > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/commit/?id=3Df22f9aaf6c3d92ebd5ad9e67acc03afebaaeb289
> > > > > [2] via CONFIG_LSM (or CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE on=
 older kernels)
> > > >
> > > > Prior to selinux userspace commit
> > > > 685f4aeeadc0b60f3770404d4f149610d656e3c8 ("libselinux:
> > > > is_selinux_enabled(): drop no-policy-loaded test.") libselinux was
> > > > checking the result of reading /proc/self/attr/current to see if it
> > > > returned the "kernel" string as a means of detecting a system with
> > > > SELinux enabled but no policy loaded, and treated that as if SELinu=
x
> > > > were disabled. Hence, this does break old userspace. Not sure thoug=
h
> > > > why you'd see the same behavior with modern libselinux.
> > >
> > > Hm... now I tried booting the stock Fedora kernel (without the early
> > > boot initial SID commit) and I got the same failure to login as with
> > > the new kernel. So if Ubuntu 16.04 ships with pre-685f4aeeadc0
> > > libselinux (quite possible), then it seems that the scenario with
> > > terminal login + SELinux enabled + policy not loaded only works with
> > > pre-685f4aeeadc0 libselinux and pre-5b0eea835d4e kernel, the other
> > > combinations are broken. With pre-685f4aeeadc0 libselinux +
> > > post-5b0eea835d4e kernel it is expected as you say (and probably
> > > inevitable barring some hack on the kernel side), but it's not clear
> > > why also only updating libselinux seems to break it... /sys/fs/selinu=
x
> > > is not mounted in my scenario, so there must be something else coming
> > > into play.
> > >
> > >
> > > --
> > > Ondrej Mosnacek
> > > Senior Software Engineer, Linux Security - SELinux kernel
> > > Red Hat, Inc.
> > >
> >
> > Completely untested:
> >
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/servi=
ces.c
> > index 2c5be06fbada..1ed275bd4551 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -1322,8 +1322,19 @@ static int security_sid_to_context_core(u32
> > sid, char **scontext,
> >         if (!selinux_initialized()) {
> >                 if (sid <=3D SECINITSID_NUM) {
> >                         char *scontextp;
> > -                       const char *s =3D initial_sid_to_string[sid];
> > +                       const char *s;
> >
> > +                       /*
> > +                        * Hide the context split of kernel threads and
> > +                        * userspace threads from userspace before the =
first
> > +                        * policy is loaded.  Userspace, e.g. libselinu=
x prior
> > +                        * to v2.6 or systemd, depends on the context b=
eing
> > +                        * "kernel".
> > +                        */
> > +                       if (sid =3D=3D SECINITSID_INIT)
> > +                               sid =3D SECINITSID_KERNEL;
> > +
> > +                       s =3D initial_sid_to_string[sid];
> >                         if (!s)
> >                                 return -EINVAL;
> >                         *scontext_len =3D strlen(s) + 1;
>
> I think I'd rather see something that does the following:
>
> 1. Convert all direct access of @initial_sid_to_string to calls to
> security_get_initial_sid_context().  I think we can leave all the
> stuff under scripts/ as-is, but I didn't think about it that hard, so
> some additional thought would be required here.

What should we then do with the reverse translation in
security_context_to_sid_core()? It seems it is currently possible for
a process to e.g. change its SID to another initial SID before the
policy is loaded - would we let it to set itself to INIT and yet still
return back KERNEL afterwards?

> 2. Modify security_get_initial_sid_context() to so something similar
> to what Christian proposed, e.g. translate INIT to KERNEL, but do so
> only when POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT is not enabled.  I
> believe this should cover both the uninitialized and old policy case.

You don't know whether the policycap is enabled or not until the
policy is loaded and at that point it doesn't matter because then you
already have a full context assigned to the SID. So we could only
translate INIT to KERNEL unconditionally, but it feels wrong to lie to
userspace like that (plus there is the reverse translation issue
above)... OTOH, I don't know if we have another choice given the "no
regressions" rule...

> It might be easier if both were done as a single patch, as those that
> want the userspace isid patch will likely want this as a fix, but if
> it becomes to ugly I have no problem splitting #1 and #2 into
> different patches.
>
> What do folks think?  Am I missing something?
>
> --
> paul-moore.com
>

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

