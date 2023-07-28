Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277B4766C1E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbjG1Lwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236330AbjG1Lwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:52:36 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B8735B5;
        Fri, 28 Jul 2023 04:52:35 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-26813cd7a8aso1477209a91.2;
        Fri, 28 Jul 2023 04:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690545154; x=1691149954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uH9ascag3hCYRu/BXQyOaYFN0XTaBKhDKrOIAGkCAeg=;
        b=Zk1YwlUBckWCahbtf+rodHjh6i5AfLASREmfXGKVNbGp5RnDGYpDb1ekLtVIiCByt/
         /2qKsdFXs6m8jsVB2Bj7FgS48MXAnrDJUGbPIg+CNSBARDm6XhXPzGlesLxcgiiyu91h
         LRmSLf9z2j63TMKyjZMEORJS+aoirlqQ5GJ4gVQ3xEuNGTX1e+36P1EXGPOT8nEpozPe
         Chs/WVgo6F6NUlkcTji4OFJCHtcPWe7Oh7/kK8P7do38ITCc1pBf9xlX4H0nEgtojJlY
         BZBNGCQyuzi+SMlFt1VhgHMIbexpc6ACDJHmX1LjCXnxABXbDbwII1ws2ioq33NK1Uiy
         gl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690545154; x=1691149954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uH9ascag3hCYRu/BXQyOaYFN0XTaBKhDKrOIAGkCAeg=;
        b=SHqIxRcWNQ91Z0CKqoAdbfOrKmFjNQH9YSu23PGnYp/LMVuuR/BFh8n76iGJvZF13F
         aL3F7LBQ3K+2Fakr3LctS3Y28nV/JNxtNuqXM29X9OOqRO50Ua8l3i8yXBezUlCJBXi4
         gVGxgrEupXsp4eEuztpZjr6QeXSEqOJ6X9DeRoyQRtizAzsHNdfnKNGVBYx94jOi+d4k
         y7V/79VNuwiLJT17RPQPnh3DUR6noUFflZIxVAazJjALbJdipTCgYAYNt3YPW/XPxVVr
         UWIUTk59AIe0VfGySKO0gWKGSdg+gic/R6F3dWTdNT61CKkEiQkBbFKBNOItyY9KzlFI
         hS+w==
X-Gm-Message-State: ABy/qLZCglkzaln98yJSX2QLAVLhALOsdUUsRROgYXXFo2l8EwvSBe3O
        vDnurk5W1BgbBbtmhXXmxYEJepBMAbw4uc5qQo4=
X-Google-Smtp-Source: APBJJlEKIPLfaERcHOpXWVP4t3Ap2T9bttAzGZNmTiMoti48b/zUIeUDKCZ4gg86RmsEoY5Y4h9ilPFxn6zr1XNT90Q=
X-Received: by 2002:a17:90b:46d5:b0:262:ebb9:dd59 with SMTP id
 jx21-20020a17090b46d500b00262ebb9dd59mr1418281pjb.20.1690545154528; Fri, 28
 Jul 2023 04:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230620131223.431281-1-omosnace@redhat.com> <87edkseqf8.fsf@mail.lhotse>
 <CAFqZXNtsCKsr0YHPCSJJQ5An=RoMhf0dufgr7P_SnAAv7CrLjw@mail.gmail.com>
In-Reply-To: <CAFqZXNtsCKsr0YHPCSJJQ5An=RoMhf0dufgr7P_SnAAv7CrLjw@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 28 Jul 2023 07:52:23 -0400
Message-ID: <CAEjxPJ643nmW6HZOmQGNFDj-cQGf-x3jzZcrO8BHVN9thM23Dw@mail.gmail.com>
Subject: Re: Login broken with old userspace (was Re: [PATCH v2] selinux:
 introduce an initial SID for early boot processes)
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-next@vger.kernel.org
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

On Fri, Jul 28, 2023 at 7:36=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> On Fri, Jul 28, 2023 at 4:12=E2=80=AFAM Michael Ellerman <mpe@ellerman.id=
.au> wrote:
> >
> > Ondrej Mosnacek <omosnace@redhat.com> writes:
> > > Currently, SELinux doesn't allow distinguishing between kernel thread=
s
> > > and userspace processes that are started before the policy is first
> > > loaded - both get the label corresponding to the kernel SID. The only
> > > way a process that persists from early boot can get a meaningful labe=
l
> > > is by doing a voluntary dyntransition or re-executing itself.
> >
> > Hi,
> >
> > This commit breaks login for me when booting linux-next kernels with ol=
d
> > userspace, specifically Ubuntu 16.04 on ppc64le. 18.04 is OK.
> >
> > The symptom is that login never accepts the root password, it just
> > always says "Login incorrect".
> >
> > Bisect points to this commit.
> >
> > Reverting this commit on top of next-20230726, fixes the problem
> > (ie. login works again).
> >
> > Booting with selinux=3D0 also fixes the problem.
> >
> > Is this expected? The change log below suggests backward compatibility
> > was considered, is 16.04 just too old?
>
> Hi Michael,
>
> I can reproduce it on Fedora 38 when I boot with SELINUX=3Ddisabled in
> /etc/selinux/config (+ a kernel including that commit), so it likely
> isn't caused by the userspace being old. Can you check what you have
> in /etc/selinux/config (or if it exists at all)?
>
> We have deprecated and removed the "runtime disable" functionality in
> SELinux recently [1], which was used to implement "disabling" SELinux
> via the /etc/selinux/config file, so now the situation (selinux=3D0 +
> SELINUX=3Ddisabled in /etc/selinux/config) leads to a state where
> SELinux is enabled, but no policy is loaded (and no enforcement is
> done). Such a state mostly behaves as if SElinux was truly disabled
> (via kernel command line), but there are some subtle differences and I
> believe we don't officially support it (Paul might clarify). With
> latest kernels it is recommended to either disable SELinux via the
> kernel command line (or Kconfig[2]) or to boot it in Enforcing or
> Permissive mode with a valid/usable policy installed.
>
> So I wonder if Ubuntu ships by default with the bad configuration or
> if it's just a result of using the custom-built linux-next kernel (or
> some changes on your part). If Ubuntu's stock kernel is configured to
> boot with SELinux enabled by default, they should also by default ship
> a usable policy and SELINUX=3Dpermissive/enforcing in
> /etc/selinux/config (or configure the kernel[2] or bootloader to boot
> with SELinux disabled by default). (Although if they ship a pre-[1]
> kernel, they may continue to rely on the runtime disable
> functionality, but it means people will have to be careful when
> booting newer or custom kernels.)
>
> That said, I'd like to get to the bottom of why the commit causes the
> login to fail and fix it somehow. I presume something in PAM chokes on
> the fact that userspace tasks now have "init" instead of "kernel" as
> the pre-policy-load security context, but so far I haven't been able
> to pinpoint the problem. I'll keep digging...
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Df22f9aaf6c3d92ebd5ad9e67acc03afebaaeb289
> [2] via CONFIG_LSM (or CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE on older k=
ernels)

Prior to selinux userspace commit
685f4aeeadc0b60f3770404d4f149610d656e3c8 ("libselinux:
is_selinux_enabled(): drop no-policy-loaded test.") libselinux was
checking the result of reading /proc/self/attr/current to see if it
returned the "kernel" string as a means of detecting a system with
SELinux enabled but no policy loaded, and treated that as if SELinux
were disabled. Hence, this does break old userspace. Not sure though
why you'd see the same behavior with modern libselinux.
