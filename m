Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680497BFCF7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjJJNKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjJJNKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:10:43 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A6BA9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:10:39 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d9a518d66a1so957832276.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1696943438; x=1697548238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsgZvUB2O0zJJrI/iXEY3Re98UsWJ7TyyRlE83OGx1c=;
        b=ClEywZq1fSzze7YXlDGvaegYHxjIuvnYfp1HycbsaSvVYQRV9J6UgWzTuAEik1o0pm
         U7DwJ52X+9yH1f/5wbBZ/gXoLOziGyKx8CGl5UpuxHqCgFHDBkln/fVH3y4LILkHuDVF
         1G4puvi5nBFuXjoUg4CrfmTdIXu0z0KI3HXnxArcHL49meMu6XwfDs8g9VqIZHoEqHC4
         iWt3tHlme+gAwG6G3kMXnHsDjCDzi5w8XRmGT4W3u3tIFtk7fuHCohO4TtD4F1GVKQcF
         ATk2r7257VplRrIdF413nbwI9t3Xa6Xq0NdPLhT+m3EdGw2BWJNhH5luI/Fm3xvrGtb6
         vcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696943438; x=1697548238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CsgZvUB2O0zJJrI/iXEY3Re98UsWJ7TyyRlE83OGx1c=;
        b=k8sW76owWxwRY+y0YbIHk7YhOgwC2TUfkwYxISEKIVqFLm7YReIDPC2nXe77/MWsfw
         Lm7ybuga/Rf+GzDCaSIRseMUsyD5ZHqKGrHuC7Mg+b9V97rU0QEtBbYhzYfkQLS9ENbI
         i/pZngxc+Ac/TybcDZkFsRdzO0YTw+DBUhMRQu2NFKa464Y2Jf4dpgucRw3YLhct3lZG
         Ul8dS/W2ETtqZ1mgx/Ey1FkGP4XsIN4wBb5sInFNyuO3mBSQs5N8m8B3sPyOTrhEMMZ3
         MTaNr3CZ6KhgLmbYuyzNLuIS0f7KKj3yRpf7ZR3uUFeabvnpR2ttcW67AYMP1D/iqYpO
         UGYA==
X-Gm-Message-State: AOJu0Yzyq3wU2tY2z90sZho0GB3LrinCQhOGMGJe1LlhioU/7AhEVGTW
        Gb5j0Hk7yaOSAsKrthT7tYh1GJtPpqdRmxv7wMo3
X-Google-Smtp-Source: AGHT+IExdQYxbTm0mWZmMia9F8dQ3CBKiDVgTxmh3dZcW2qO311/CmuHbWAs1IVtseArGBo+1R/yIG6+Wi0mpWLjU5A=
X-Received: by 2002:a25:16c3:0:b0:d62:b8f5:d745 with SMTP id
 186-20020a2516c3000000b00d62b8f5d745mr16050911ybw.52.1696943438099; Tue, 10
 Oct 2023 06:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230912205658.3432-1-casey@schaufler-ca.com> <20230912205658.3432-5-casey@schaufler-ca.com>
 <20231003.kooghohS2Aiz@digikod.net> <CAHC9VhT_ijmqo9ap-EokWHuALsMAqome2qcWgst3eRP6m+vbRA@mail.gmail.com>
 <20231009.MieQu5ou2loo@digikod.net> <CAHC9VhS_pFy=WUq8F7jXQ3gstdM36FG52NQ+OeESHRSa54h7MQ@mail.gmail.com>
 <20231010.eisha1Fohj8u@digikod.net>
In-Reply-To: <20231010.eisha1Fohj8u@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 10 Oct 2023 09:10:27 -0400
Message-ID: <CAHC9VhReBwy6KMOZ58gNhdffGhob_Z3d6G1Z3VbsP-bA00Z0=w@mail.gmail.com>
Subject: Re: [PATCH v15 04/11] LSM: syscalls for current process attributes
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 5:14=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Mon, Oct 09, 2023 at 12:04:31PM -0400, Paul Moore wrote:
> > On Mon, Oct 9, 2023 at 11:37=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > > On Thu, Oct 05, 2023 at 09:04:34PM -0400, Paul Moore wrote:
> > > > On Tue, Oct 3, 2023 at 10:09=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <m=
ic@digikod.net> wrote:
> > > > > On Tue, Sep 12, 2023 at 01:56:49PM -0700, Casey Schaufler wrote:
> > > > > > Create a system call lsm_get_self_attr() to provide the securit=
y
> > > > > > module maintained attributes of the current process.
> > > > > > Create a system call lsm_set_self_attr() to set a security
> > > > > > module maintained attribute of the current process.
> > > > > > Historically these attributes have been exposed to user space v=
ia
> > > > > > entries in procfs under /proc/self/attr.
> > > > > >
> > > > > > The attribute value is provided in a lsm_ctx structure. The str=
ucture
> > > > > > identifies the size of the attribute, and the attribute value. =
The format
> > > > > > of the attribute value is defined by the security module. A fla=
gs field
> > > > > > is included for LSM specific information. It is currently unuse=
d and must
> > > > > > be 0. The total size of the data, including the lsm_ctx structu=
re and any
> > > > > > padding, is maintained as well.
> > > > > >
> > > > > > struct lsm_ctx {
> > > > > >         __u64 id;
> > > > > >         __u64 flags;
> > > > > >         __u64 len;
> > > > > >         __u64 ctx_len;
> > > > > >         __u8 ctx[];
> > > > > > };
> > > > > >
> > > > > > Two new LSM hooks are used to interface with the LSMs.
> > > > > > security_getselfattr() collects the lsm_ctx values from the
> > > > > > LSMs that support the hook, accounting for space requirements.
> > > > > > security_setselfattr() identifies which LSM the attribute is
> > > > > > intended for and passes it along.
> > > > > >
> > > > > > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > > > > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > > > > > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> > > > > > Reviewed-by: John Johansen <john.johansen@canonical.com>
> > > > > > ---
> > > > > >  Documentation/userspace-api/lsm.rst |  70 +++++++++++++
> > > > > >  include/linux/lsm_hook_defs.h       |   4 +
> > > > > >  include/linux/lsm_hooks.h           |   1 +
> > > > > >  include/linux/security.h            |  19 ++++
> > > > > >  include/linux/syscalls.h            |   5 +
> > > > > >  include/uapi/linux/lsm.h            |  36 +++++++
> > > > > >  kernel/sys_ni.c                     |   2 +
> > > > > >  security/Makefile                   |   1 +
> > > > > >  security/lsm_syscalls.c             |  57 +++++++++++
> > > > > >  security/security.c                 | 152 ++++++++++++++++++++=
++++++++
> > > > > >  10 files changed, 347 insertions(+)
> > > > > >  create mode 100644 Documentation/userspace-api/lsm.rst
> > > > > >  create mode 100644 security/lsm_syscalls.c
> > > >
> > > > ...
> > > >
> > > > > > diff --git a/security/security.c b/security/security.c
> > > > > > index a3489c04b783..0d179750d964 100644
> > > > > > --- a/security/security.c
> > > > > > +++ b/security/security.c
> > > > > > @@ -3837,6 +3837,158 @@ void security_d_instantiate(struct dent=
ry *dentry, struct inode *inode)
> > > > > >  }
> > > > > >  EXPORT_SYMBOL(security_d_instantiate);
> > > > > >
> > > > > > +/*
> > > > > > + * Please keep this in sync with it's counterpart in security/=
lsm_syscalls.c
> > > > > > + */
> > > > > > +
> > > > > > +/**
> > > > > > + * security_getselfattr - Read an LSM attribute of the current=
 process.
> > > > > > + * @attr: which attribute to return
> > > > > > + * @uctx: the user-space destination for the information, or N=
ULL
> > > > > > + * @size: pointer to the size of space available to receive th=
e data
> > > > > > + * @flags: special handling options. LSM_FLAG_SINGLE indicates=
 that only
> > > > > > + * attributes associated with the LSM identified in the passed=
 @ctx be
> > > > > > + * reported.
> > > > > > + *
> > > > > > + * A NULL value for @uctx can be used to get both the number o=
f attributes
> > > > > > + * and the size of the data.
> > > > > > + *
> > > > > > + * Returns the number of attributes found on success, negative=
 value
> > > > > > + * on error. @size is reset to the total size of the data.
> > > > > > + * If @size is insufficient to contain the data -E2BIG is retu=
rned.
> > > > > > + */
> > > > > > +int security_getselfattr(unsigned int attr, struct lsm_ctx __u=
ser *uctx,
> > > > > > +                      size_t __user *size, u32 flags)
> > > > > > +{
> > > > > > +     struct security_hook_list *hp;
> > > > > > +     struct lsm_ctx lctx =3D { .id =3D LSM_ID_UNDEF, };
> > > > > > +     u8 __user *base =3D (u8 __user *)uctx;
> > > > > > +     size_t total =3D 0;
> > > > > > +     size_t entrysize;
> > > > > > +     size_t left;
> > > > > > +     bool toobig =3D false;
> > > > > > +     bool single =3D false;
> > > > > > +     int count =3D 0;
> > > > > > +     int rc;
> > > > > > +
> > > > > > +     if (attr =3D=3D LSM_ATTR_UNDEF)
> > > > > > +             return -EINVAL;
> > > > > > +     if (size =3D=3D NULL)
> > > > > > +             return -EINVAL;
> > > > > > +     if (get_user(left, size))
> > > > > > +             return -EFAULT;
> > > > > > +
> > > > > > +     if (flags) {
> > > > > > +             /*
> > > > > > +              * Only flag supported is LSM_FLAG_SINGLE
> > > > > > +              */
> > > > > > +             if (flags !=3D LSM_FLAG_SINGLE)
> > > > > > +                     return -EINVAL;
> > > > > > +             if (uctx && copy_from_user(&lctx, uctx, sizeof(lc=
tx)))
> > > > >
> > > > > I'm not sure if we should return -EINVAL or -EFAULT when uctx =3D=
=3D NULL.
> > > > > Because uctx is optional (when LSM_FLAG_SINGLE is not set), I gue=
ss
> > > > > -EINVAL is OK.
> > > >
> > > > That's a good point, we should probably the error codes here: if uc=
tx
> > > > is NULL in the LSM_FLAG_SINGLE case we should return -EINVAL, if th=
e
> > > > copy_from_user() fails we should return -EFAULT.
> > > >
> > > > > > +                     return -EFAULT;
> > > > > > +             /*
> > > > > > +              * If the LSM ID isn't specified it is an error.
> > > > > > +              */
> > > > > > +             if (lctx.id =3D=3D LSM_ID_UNDEF)
> > > > > > +                     return -EINVAL;
> > > > > > +             single =3D true;
> > > > > > +     }
> > > > > > +
> > > > > > +     /*
> > > > > > +      * In the usual case gather all the data from the LSMs.
> > > > > > +      * In the single case only get the data from the LSM spec=
ified.
> > > > > > +      */
> > > > > > +     hlist_for_each_entry(hp, &security_hook_heads.getselfattr=
, list) {
> > > > > > +             if (single && lctx.id !=3D hp->lsmid->id)
> > > > > > +                     continue;
> > > > > > +             entrysize =3D left;
> > > > > > +             if (base)
> > > > > > +                     uctx =3D (struct lsm_ctx __user *)(base +=
 total);
> > > > > > +             rc =3D hp->hook.getselfattr(attr, uctx, &entrysiz=
e, flags);
> > > > > > +             if (rc =3D=3D -EOPNOTSUPP) {
> > > > > > +                     rc =3D 0;
> > > > > > +                     continue;
> > > > > > +             }
> > > > > > +             if (rc =3D=3D -E2BIG) {
> > > > > > +                     toobig =3D true;
> > > > > > +                     left =3D 0;
> > > > > > +             } else if (rc < 0)
> > > > > > +                     return rc;
> > > > > > +             else
> > > > > > +                     left -=3D entrysize;
> > > > > > +
> > > > > > +             total +=3D entrysize;
> > > > > > +             count +=3D rc;
> > > > >
> > > > > There is a bug if rc =3D=3D -E2BIG
> > > >
> > > > Can you elaborate a bit more on this? Nothing is jumping out at me =
as
> > > > obviously broken... are you talking about @count becoming garbage d=
ue
> > > > to @rc being equal to -E2BIG?  If that is the case it should be oka=
y
> > > > since we explicitly return -E2BIG, not @count, if @toobig is true.
> > >
> > > Indeed, in this case count will not be returned thanks to toobig. I'd
> > > suggest to "continue" if rc =3D=3D -E2BIG (like for -EOPNOTSUPP) to a=
void an
> > > inconsistent count value, which could bite us one day.
> >
> > Okay, how about we reset @rc to zero in the -E2BIG case?  We don't
> > want to bypass the lower part of the loop in this case as we still
> > need to update @total.
> >
> >   if (rc =3D=3D -E2BIG) {
> >     rc =3D 0;
> >     left =3D 0;
> >     toobig =3D true;
> >   }
>
> Indeed, this is better.
>
> To avoid useless calls to getselfattr hooks, we could also patch the
> last part of the loop:
> -               if (single)
> +               if (single || left <=3D 0)
>                         break;
>

They aren't useless calls, we keep calling into the LSMs so that we
can return a buffer size hint in the @size parameter when the getattr
syscall returns -E2BIG.

--=20
paul-moore.com
