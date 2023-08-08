Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361F9774BC6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbjHHUy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjHHUyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:54:38 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B64814B93E;
        Tue,  8 Aug 2023 10:03:33 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99c10ba30afso9192966b.1;
        Tue, 08 Aug 2023 10:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691514211; x=1692119011;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0MpGXuBiuN9koLckS5szeKEmUEXvO5QPu+ncywhWoiA=;
        b=MbZg1LIzREBaDWbU1mkzHxft9FqCY1XRSJBdpu66MvBlTlLLz14ZYoVB76Vrwoq0Dj
         b1u8+EbYRY/cxI/ywahbYJ74OuipJg+lWku4hFJ10YFkgxgagbUTvLQSG2j6AF+MZ5un
         boRBiJ0zu89/Ws3n1IhFQMrP1WpaCbL0aRGWipkRZw7CXzOTtLdwZQf50APWtdcyTD23
         o8aIDj8VlOjNVAqa39EHzYIvkjBpa5UPauIbAPpklyGc1ZPyE6P/OohhKUKOhKZjnwqC
         lQkL336MXHsh8aQ+EIhtOlJHqE9qyOU/NK/8+j5wJ1rAy2sh/R/j2FqIpGM/Qjt4NnZi
         jsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514211; x=1692119011;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0MpGXuBiuN9koLckS5szeKEmUEXvO5QPu+ncywhWoiA=;
        b=FM7TLgCxRQsIKGv4jRf0bR26gZ41VvlJAGQmxIUtoMTE/WR+F5JV2kk/UjvbqpLZK0
         pZJeqQ2nVeQ6VBFhnYkWGNzTgdLFvweOiiVjIEB1K2vgQbwAoGDv2u6LZ8YjqdaliOt1
         bkcWKUbdZbrjZTVxTrrCh4VMCedoqHIizGS/8c63lDALvEb0ES7Q+uwy1LQOlLq9jpNG
         jBJziDWRcOtU26IWwYqjjLh8unT0IgUKoIWRU/C13ps1yboSwQH6TcbYqG881hfmOiiT
         M+WGxytJvsTo3QI3Z0qWbHB5Hvc6TI4GxBMC3Rjxxi7Kk2Fm7zsQ8PtvSMPklVSv2efc
         +eoQ==
X-Gm-Message-State: AOJu0YxxGtNqHZM9yh3DiillvWZ/QLSJnZgbtCKxPCVYayXP8P5CNdOs
        A3jubCqmrp+oaptFF85ibeo3DrXjvZIPl40Z
X-Google-Smtp-Source: AGHT+IH3o9fSz3J+trqyHYXdiDpwfrwl61+YP2/JN6E3g3m41PBKKYJRMnJQG8WwN5bwpD/yKjjAfg==
X-Received: by 2002:a5d:5083:0:b0:317:dcdd:3fa1 with SMTP id a3-20020a5d5083000000b00317dcdd3fa1mr5827685wrt.34.1691472828609;
        Mon, 07 Aug 2023 22:33:48 -0700 (PDT)
Received: from khadija-virtual-machine ([124.29.208.67])
        by smtp.gmail.com with ESMTPSA id 23-20020a05600c229700b003fbdd5d0758sm12633902wmf.22.2023.08.07.22.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 22:33:47 -0700 (PDT)
Date:   Tue, 8 Aug 2023 10:33:44 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com,
        john.johansen@canonical.com, ztarkhani@microsoft.com
Subject: Re: [PATCH v2] lsm: constify the 'target' parameter in
 security_capget()
Message-ID: <ZNHTuHFDVdCNPXj+@gmail.com>
References: <ZNCWUQXKrZnCeB/5@gmail.com>
 <CAHC9VhT+DPRrSnmh_2PCAf05jPCE-EPaMU_TLB=jJ+mJ+NALsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhT+DPRrSnmh_2PCAf05jPCE-EPaMU_TLB=jJ+mJ+NALsw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 07:09:33PM -0400, Paul Moore wrote:
> On Mon, Aug 7, 2023 at 2:59 AM Khadija Kamran <kamrankhadijadj@gmail.com> wrote:
> >
> >
> >
> > cap_capget() LSM hook declaration exceeds the 80 characters per line
> > limit. Split the function declaration to multple lines to decrease the
> 
> "multiple" :)
> 
> Don't worry, I'll fix that in the merge.
>

Hey Paul,
Thank you. :)

> There is one more nitpick below, but I think this looks good.  I'll
> give this a few days to see if John can ACK the AppArmor bits, but if
> we don't hear from him by mid-week I'll plan to merge this.
> 
> Thanks!
> 
> > line length.
> >
> > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > ---
> > Changes in v2:
> >  - Squash the patches 1/2 and 2/2 into a single patch
> >  - Simplify the commit message
> >
> >  include/linux/lsm_hook_defs.h | 2 +-
> >  include/linux/security.h      | 7 ++++---
> >  kernel/capability.c           | 2 +-
> >  security/apparmor/lsm.c       | 2 +-
> >  security/commoncap.c          | 2 +-
> >  security/security.c           | 2 +-
> >  security/selinux/hooks.c      | 2 +-
> >  7 files changed, 10 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> > index 6bb55e61e8e8..fd3844e11077 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -36,7 +36,7 @@ LSM_HOOK(int, 0, binder_transfer_file, const struct cred *from,
> >  LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
> >          unsigned int mode)
> >  LSM_HOOK(int, 0, ptrace_traceme, struct task_struct *parent)
> > -LSM_HOOK(int, 0, capget, struct task_struct *target, kernel_cap_t *effective,
> > +LSM_HOOK(int, 0, capget, const struct task_struct *target, kernel_cap_t *effective,
> >          kernel_cap_t *inheritable, kernel_cap_t *permitted)
> >  LSM_HOOK(int, 0, capset, struct cred *new, const struct cred *old,
> >          const kernel_cap_t *effective, const kernel_cap_t *inheritable,
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index e2734e9e44d5..fef65d0e522d 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -145,7 +145,8 @@ extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
> >  extern int cap_settime(const struct timespec64 *ts, const struct timezone *tz);
> >  extern int cap_ptrace_access_check(struct task_struct *child, unsigned int mode);
> >  extern int cap_ptrace_traceme(struct task_struct *parent);
> > -extern int cap_capget(struct task_struct *target, kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted);
> > +extern int cap_capget(const struct task_struct *target, kernel_cap_t *effective,
> > +                                         kernel_cap_t *inheritable, kernel_cap_t *permitted);
> 
> Don't resubmit the patch just for this, I'll fix it during the merge,
> but generally nice to make sure the wrapped lines are aligned with the
> previous line; look at the security_cap_get() declaration (below) in
> this patch to see an example.

Okay noted. 

Regards,
Khadija

> 
> >  extern int cap_capset(struct cred *new, const struct cred *old,
> >                       const kernel_cap_t *effective,
> >                       const kernel_cap_t *inheritable,
> > @@ -271,7 +272,7 @@ int security_binder_transfer_file(const struct cred *from,
> >                                   const struct cred *to, struct file *file);
> >  int security_ptrace_access_check(struct task_struct *child, unsigned int mode);
> >  int security_ptrace_traceme(struct task_struct *parent);
> > -int security_capget(struct task_struct *target,
> > +int security_capget(const struct task_struct *target,
> >                     kernel_cap_t *effective,
> >                     kernel_cap_t *inheritable,
> >                     kernel_cap_t *permitted);
> > @@ -553,7 +554,7 @@ static inline int security_ptrace_traceme(struct task_struct *parent)
> >         return cap_ptrace_traceme(parent);
> >  }
> >
> > -static inline int security_capget(struct task_struct *target,
> > +static inline int security_capget(const struct task_struct *target,
> >                                    kernel_cap_t *effective,
> >                                    kernel_cap_t *inheritable,
> >                                    kernel_cap_t *permitted)
> > diff --git a/kernel/capability.c b/kernel/capability.c
> > index 3e058f41df32..67bdee3414dd 100644
> > --- a/kernel/capability.c
> > +++ b/kernel/capability.c
> > @@ -112,7 +112,7 @@ static inline int cap_get_target_pid(pid_t pid, kernel_cap_t *pEp,
> >         int ret;
> >
> >         if (pid && (pid != task_pid_vnr(current))) {
> > -               struct task_struct *target;
> > +               const struct task_struct *target;
> >
> >                 rcu_read_lock();
> >
> > diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> > index f431251ffb91..12dd96c3b2f0 100644
> > --- a/security/apparmor/lsm.c
> > +++ b/security/apparmor/lsm.c
> > @@ -144,7 +144,7 @@ static int apparmor_ptrace_traceme(struct task_struct *parent)
> >  }
> >
> >  /* Derived from security/commoncap.c:cap_capget */
> > -static int apparmor_capget(struct task_struct *target, kernel_cap_t *effective,
> > +static int apparmor_capget(const struct task_struct *target, kernel_cap_t *effective,
> >                            kernel_cap_t *inheritable, kernel_cap_t *permitted)
> >  {
> >         struct aa_label *label;
> > diff --git a/security/commoncap.c b/security/commoncap.c
> > index 0b3fc2f3afe7..5fd64d3e5bfd 100644
> > --- a/security/commoncap.c
> > +++ b/security/commoncap.c
> > @@ -197,7 +197,7 @@ int cap_ptrace_traceme(struct task_struct *parent)
> >   * This function retrieves the capabilities of the nominated task and returns
> >   * them to the caller.
> >   */
> > -int cap_capget(struct task_struct *target, kernel_cap_t *effective,
> > +int cap_capget(const struct task_struct *target, kernel_cap_t *effective,
> >                kernel_cap_t *inheritable, kernel_cap_t *permitted)
> >  {
> >         const struct cred *cred;
> > diff --git a/security/security.c b/security/security.c
> > index d5ff7ff45b77..fb2d93b481f1 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -893,7 +893,7 @@ int security_ptrace_traceme(struct task_struct *parent)
> >   *
> >   * Return: Returns 0 if the capability sets were successfully obtained.
> >   */
> > -int security_capget(struct task_struct *target,
> > +int security_capget(const struct task_struct *target,
> >                     kernel_cap_t *effective,
> >                     kernel_cap_t *inheritable,
> >                     kernel_cap_t *permitted)
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 79b4890e9936..ff42d49f1b41 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2056,7 +2056,7 @@ static int selinux_ptrace_traceme(struct task_struct *parent)
> >                             SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
> >  }
> >
> > -static int selinux_capget(struct task_struct *target, kernel_cap_t *effective,
> > +static int selinux_capget(const struct task_struct *target, kernel_cap_t *effective,
> >                           kernel_cap_t *inheritable, kernel_cap_t *permitted)
> >  {
> >         return avc_has_perm(current_sid(), task_sid_obj(target),
> > --
> > 2.34.1
> 
> -- 
> paul-moore.com
