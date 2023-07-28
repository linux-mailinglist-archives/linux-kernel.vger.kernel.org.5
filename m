Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7C6766E10
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbjG1NYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjG1NYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:24:10 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEE73AA8;
        Fri, 28 Jul 2023 06:24:08 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-447576e24e1so563303137.1;
        Fri, 28 Jul 2023 06:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690550647; x=1691155447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kcj3VWwZAJ2nXS/MjDJ5t2M3CtqdxPFftJUiEtnT0s=;
        b=DNbuPt/1Vpm37NLg+nmMEoQyilVWEIBDoKX5uLqc+2gWqmJldV5uVhOiluB8QrhUjK
         cAcE50nKty1ltbwwsURGorw7XQ6FS6oIf+rhx9WOk8aMFyyPidvJyHNTTaFkOee7JiTR
         iNdvFmg3uPAdkWhtCGSrVVDwg/WcNZmdCCnfz5dAN4Lk3nzfamxmziV4OKvhi5xu+eW2
         +mM3D7V9elPTd/cY4mvjjWa1Ztl904f+s7uslYEHVYR9ml/Q/d3TEwL/h+zakMnx4+zS
         oAf3ICtIuZMXqq8DuNAHAHABI/+CRAZ1FjvrWsPA9ICTMKAzHaDz5XXhmQa8aAnEi4Km
         9aZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690550647; x=1691155447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kcj3VWwZAJ2nXS/MjDJ5t2M3CtqdxPFftJUiEtnT0s=;
        b=imAzbpiAPMUTZD45VfaH5GHW9r4PGzZbM3RM32zpIcjk0EycGvt4qrIqyLxbFiWSqv
         p3Zala7EdeCn7nZjs5MudcK3VEoRcVSazxujj3VJHbV8ffXEkcsF5FZEbi7ONrFuMiv9
         RgFmGqF7DsWLTls8Za/R0cPq6kM96wIfGu7vHrXO0tQPr2tomETA8pmio9cPcY912QnQ
         ivacB/+YsXLHPbeIEGVM80FZODGbzPea+6TZLglLbcrJj0shHglfufu6s2wnKJHCgsOh
         3tBVDIxBxZnR71LWL7sUKq3eXDqwutntq/3cQOql41YA7d7qQNT0ZHL7rW7ULzjU1BmF
         unHg==
X-Gm-Message-State: ABy/qLaZpq9mAeNKqFULAoJUgk9b/zjTg8ohkg6It3DaRuNSItOC/fT4
        NQfxDxWelyX0/iyLjGaxs8sG6DDPHV1CaMKC3Tg=
X-Google-Smtp-Source: APBJJlEdFSq/qkSG4x58s4Td5/s8KFZeqscpYKJANVhmEctzf+sC16le2cznwm3fviN6ULiTqJNGrZsVsH5/9MspG20=
X-Received: by 2002:a05:6102:3569:b0:445:208:3516 with SMTP id
 bh9-20020a056102356900b0044502083516mr1320238vsb.0.1690550647036; Fri, 28 Jul
 2023 06:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230620131223.431281-1-omosnace@redhat.com> <87edkseqf8.fsf@mail.lhotse>
 <CAFqZXNtsCKsr0YHPCSJJQ5An=RoMhf0dufgr7P_SnAAv7CrLjw@mail.gmail.com>
 <CAEjxPJ643nmW6HZOmQGNFDj-cQGf-x3jzZcrO8BHVN9thM23Dw@mail.gmail.com> <CAFqZXNuM-807tmT84rZ25xwh078BxvSfav88AozH=tt=J+dCrA@mail.gmail.com>
In-Reply-To: <CAFqZXNuM-807tmT84rZ25xwh078BxvSfav88AozH=tt=J+dCrA@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Fri, 28 Jul 2023 15:23:56 +0200
Message-ID: <CAJ2a_DdZHFTHiRu5+ZENAwUq1Cor-jVoE9qdhb2x5uSej-MaRA@mail.gmail.com>
Subject: Re: Login broken with old userspace (was Re: [PATCH v2] selinux:
 introduce an initial SID for early boot processes)
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-next@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023 at 15:14, Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Fri, Jul 28, 2023 at 1:52=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, Jul 28, 2023 at 7:36=E2=80=AFAM Ondrej Mosnacek <omosnace@redha=
t.com> wrote:
> > >
> > > On Fri, Jul 28, 2023 at 4:12=E2=80=AFAM Michael Ellerman <mpe@ellerma=
n.id.au> wrote:
> > > >
> > > > Ondrej Mosnacek <omosnace@redhat.com> writes:
> > > > > Currently, SELinux doesn't allow distinguishing between kernel th=
reads
> > > > > and userspace processes that are started before the policy is fir=
st
> > > > > loaded - both get the label corresponding to the kernel SID. The =
only
> > > > > way a process that persists from early boot can get a meaningful =
label
> > > > > is by doing a voluntary dyntransition or re-executing itself.
> > > >
> > > > Hi,
> > > >
> > > > This commit breaks login for me when booting linux-next kernels wit=
h old
> > > > userspace, specifically Ubuntu 16.04 on ppc64le. 18.04 is OK.
> > > >
> > > > The symptom is that login never accepts the root password, it just
> > > > always says "Login incorrect".
> > > >
> > > > Bisect points to this commit.
> > > >
> > > > Reverting this commit on top of next-20230726, fixes the problem
> > > > (ie. login works again).
> > > >
> > > > Booting with selinux=3D0 also fixes the problem.
> > > >
> > > > Is this expected? The change log below suggests backward compatibil=
ity
> > > > was considered, is 16.04 just too old?
> > >
> > > Hi Michael,
> > >
> > > I can reproduce it on Fedora 38 when I boot with SELINUX=3Ddisabled i=
n
> > > /etc/selinux/config (+ a kernel including that commit), so it likely
> > > isn't caused by the userspace being old. Can you check what you have
> > > in /etc/selinux/config (or if it exists at all)?
> > >
> > > We have deprecated and removed the "runtime disable" functionality in
> > > SELinux recently [1], which was used to implement "disabling" SELinux
> > > via the /etc/selinux/config file, so now the situation (selinux=3D0 +
> > > SELINUX=3Ddisabled in /etc/selinux/config) leads to a state where
> > > SELinux is enabled, but no policy is loaded (and no enforcement is
> > > done). Such a state mostly behaves as if SElinux was truly disabled
> > > (via kernel command line), but there are some subtle differences and =
I
> > > believe we don't officially support it (Paul might clarify). With
> > > latest kernels it is recommended to either disable SELinux via the
> > > kernel command line (or Kconfig[2]) or to boot it in Enforcing or
> > > Permissive mode with a valid/usable policy installed.
> > >
> > > So I wonder if Ubuntu ships by default with the bad configuration or
> > > if it's just a result of using the custom-built linux-next kernel (or
> > > some changes on your part). If Ubuntu's stock kernel is configured to
> > > boot with SELinux enabled by default, they should also by default shi=
p
> > > a usable policy and SELINUX=3Dpermissive/enforcing in
> > > /etc/selinux/config (or configure the kernel[2] or bootloader to boot
> > > with SELinux disabled by default). (Although if they ship a pre-[1]
> > > kernel, they may continue to rely on the runtime disable
> > > functionality, but it means people will have to be careful when
> > > booting newer or custom kernels.)
> > >
> > > That said, I'd like to get to the bottom of why the commit causes the
> > > login to fail and fix it somehow. I presume something in PAM chokes o=
n
> > > the fact that userspace tasks now have "init" instead of "kernel" as
> > > the pre-policy-load security context, but so far I haven't been able
> > > to pinpoint the problem. I'll keep digging...
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3Df22f9aaf6c3d92ebd5ad9e67acc03afebaaeb289
> > > [2] via CONFIG_LSM (or CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE on old=
er kernels)
> >
> > Prior to selinux userspace commit
> > 685f4aeeadc0b60f3770404d4f149610d656e3c8 ("libselinux:
> > is_selinux_enabled(): drop no-policy-loaded test.") libselinux was
> > checking the result of reading /proc/self/attr/current to see if it
> > returned the "kernel" string as a means of detecting a system with
> > SELinux enabled but no policy loaded, and treated that as if SELinux
> > were disabled. Hence, this does break old userspace. Not sure though
> > why you'd see the same behavior with modern libselinux.
>
> Hm... now I tried booting the stock Fedora kernel (without the early
> boot initial SID commit) and I got the same failure to login as with
> the new kernel. So if Ubuntu 16.04 ships with pre-685f4aeeadc0
> libselinux (quite possible), then it seems that the scenario with
> terminal login + SELinux enabled + policy not loaded only works with
> pre-685f4aeeadc0 libselinux and pre-5b0eea835d4e kernel, the other
> combinations are broken. With pre-685f4aeeadc0 libselinux +
> post-5b0eea835d4e kernel it is expected as you say (and probably
> inevitable barring some hack on the kernel side), but it's not clear
> why also only updating libselinux seems to break it... /sys/fs/selinux
> is not mounted in my scenario, so there must be something else coming
> into play.
>
>
> --
> Ondrej Mosnacek
> Senior Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.
>

Completely untested:

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.=
c
index 2c5be06fbada..1ed275bd4551 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1322,8 +1322,19 @@ static int security_sid_to_context_core(u32
sid, char **scontext,
        if (!selinux_initialized()) {
                if (sid <=3D SECINITSID_NUM) {
                        char *scontextp;
-                       const char *s =3D initial_sid_to_string[sid];
+                       const char *s;

+                       /*
+                        * Hide the context split of kernel threads and
+                        * userspace threads from userspace before the firs=
t
+                        * policy is loaded.  Userspace, e.g. libselinux pr=
ior
+                        * to v2.6 or systemd, depends on the context being
+                        * "kernel".
+                        */
+                       if (sid =3D=3D SECINITSID_INIT)
+                               sid =3D SECINITSID_KERNEL;
+
+                       s =3D initial_sid_to_string[sid];
                        if (!s)
                                return -EINVAL;
                        *scontext_len =3D strlen(s) + 1;
