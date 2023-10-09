Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AC07BE5D5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376862AbjJIQEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbjJIQEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:04:45 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07477A6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:04:44 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7af52ee31so4113257b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 09:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1696867483; x=1697472283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9fDlNvOmnLtg5Op0t4a2gYADf6L/TQ4pS3//DFpv4Y=;
        b=Zd5STm59FoJsi3k5D876d90iOOjfR6B38r+qNuFlVmk0Hk0HAlgbTQ2Y3CqGbpvg7/
         h20rrLzzMYnsQ+PO8Tl+EXUPsue4zIPa5LNqCY4VNET7wlRqXgSGzhTtySc3DgDHQfEh
         jdWlUps295VLoKZYWcvHCNpsnNKZLIIuAehcnOMFAeom/FsfrorGX5puUNbQahHy3lu/
         XWw/mQ523ZhC7Tl6qManggDvuMmYRce01m9dfP49bTuVNQEIQUhj5GotkXlMnPf8Rv/g
         hyVCd0b48jn9DyBGeW1dcFgN4hGyuiTHbwP364KgfCGAfH92UGXv3FqKTai/A/ochCEX
         wGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696867483; x=1697472283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9fDlNvOmnLtg5Op0t4a2gYADf6L/TQ4pS3//DFpv4Y=;
        b=xB/dT4mtIDsGGNloVRIEvfYjAs8aH7lRojkZw1Nc4PcYQLZftEq6AOYtO9BlfadZY4
         +1yA081NKHksxBANleQFmSpdnjIM046qAzJuJdyI5wAo2JmQOtaisWwmUGtCQ9XbOma7
         PaVhvbDeENUj34AMgetViB6BOoYyDj2e0nqrd5CZX2wdJ4cFtpZjEy5WhkSrZRR4fKFg
         132l0hEFAd6T7wyIXD5RjmL+7rOKKTYfSXODFoVnaMuSl0323RFLiWphLHWBqzn1zwPX
         C4WDy25HhYYPhhQjVc8hpbOS7O+YQpZQ1IuCOsauf3rgjdZu8CB/iTvdtlAD0/w0lkFR
         jvWQ==
X-Gm-Message-State: AOJu0YwIsrTa7T25VD+KHRW1sK3nT9A+agbzLCf3tN2iqF3iuHWmFNAj
        yMKGudruXiv6qjzjkQH0YMEBb2jCqaYvb2HhqJxO
X-Google-Smtp-Source: AGHT+IG289Jk17vEztzyThvi6KHoyIoAnumxy2kyOt6T/0bQ9I8E6+Ff1KHXg3mIX4GLMEPGX9TcMjbz2O+cpsfjwe0=
X-Received: by 2002:a25:db08:0:b0:d9a:3adf:95a0 with SMTP id
 g8-20020a25db08000000b00d9a3adf95a0mr1147643ybf.27.1696867482619; Mon, 09 Oct
 2023 09:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230912205658.3432-1-casey@schaufler-ca.com> <20230912205658.3432-5-casey@schaufler-ca.com>
 <20231003.kooghohS2Aiz@digikod.net> <CAHC9VhT_ijmqo9ap-EokWHuALsMAqome2qcWgst3eRP6m+vbRA@mail.gmail.com>
 <20231009.MieQu5ou2loo@digikod.net>
In-Reply-To: <20231009.MieQu5ou2loo@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 9 Oct 2023 12:04:31 -0400
Message-ID: <CAHC9VhS_pFy=WUq8F7jXQ3gstdM36FG52NQ+OeESHRSa54h7MQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 11:37=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Thu, Oct 05, 2023 at 09:04:34PM -0400, Paul Moore wrote:
> > On Tue, Oct 3, 2023 at 10:09=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > > On Tue, Sep 12, 2023 at 01:56:49PM -0700, Casey Schaufler wrote:
> > > > Create a system call lsm_get_self_attr() to provide the security
> > > > module maintained attributes of the current process.
> > > > Create a system call lsm_set_self_attr() to set a security
> > > > module maintained attribute of the current process.
> > > > Historically these attributes have been exposed to user space via
> > > > entries in procfs under /proc/self/attr.
> > > >
> > > > The attribute value is provided in a lsm_ctx structure. The structu=
re
> > > > identifies the size of the attribute, and the attribute value. The =
format
> > > > of the attribute value is defined by the security module. A flags f=
ield
> > > > is included for LSM specific information. It is currently unused an=
d must
> > > > be 0. The total size of the data, including the lsm_ctx structure a=
nd any
> > > > padding, is maintained as well.
> > > >
> > > > struct lsm_ctx {
> > > >         __u64 id;
> > > >         __u64 flags;
> > > >         __u64 len;
> > > >         __u64 ctx_len;
> > > >         __u8 ctx[];
> > > > };
> > > >
> > > > Two new LSM hooks are used to interface with the LSMs.
> > > > security_getselfattr() collects the lsm_ctx values from the
> > > > LSMs that support the hook, accounting for space requirements.
> > > > security_setselfattr() identifies which LSM the attribute is
> > > > intended for and passes it along.
> > > >
> > > > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > > > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> > > > Reviewed-by: John Johansen <john.johansen@canonical.com>
> > > > ---
> > > >  Documentation/userspace-api/lsm.rst |  70 +++++++++++++
> > > >  include/linux/lsm_hook_defs.h       |   4 +
> > > >  include/linux/lsm_hooks.h           |   1 +
> > > >  include/linux/security.h            |  19 ++++
> > > >  include/linux/syscalls.h            |   5 +
> > > >  include/uapi/linux/lsm.h            |  36 +++++++
> > > >  kernel/sys_ni.c                     |   2 +
> > > >  security/Makefile                   |   1 +
> > > >  security/lsm_syscalls.c             |  57 +++++++++++
> > > >  security/security.c                 | 152 ++++++++++++++++++++++++=
++++
> > > >  10 files changed, 347 insertions(+)
> > > >  create mode 100644 Documentation/userspace-api/lsm.rst
> > > >  create mode 100644 security/lsm_syscalls.c
> >
> > ...
> >
> > > > diff --git a/security/security.c b/security/security.c
> > > > index a3489c04b783..0d179750d964 100644
> > > > --- a/security/security.c
> > > > +++ b/security/security.c
> > > > @@ -3837,6 +3837,158 @@ void security_d_instantiate(struct dentry *=
dentry, struct inode *inode)
> > > >  }
> > > >  EXPORT_SYMBOL(security_d_instantiate);
> > > >
> > > > +/*
> > > > + * Please keep this in sync with it's counterpart in security/lsm_=
syscalls.c
> > > > + */
> > > > +
> > > > +/**
> > > > + * security_getselfattr - Read an LSM attribute of the current pro=
cess.
> > > > + * @attr: which attribute to return
> > > > + * @uctx: the user-space destination for the information, or NULL
> > > > + * @size: pointer to the size of space available to receive the da=
ta
> > > > + * @flags: special handling options. LSM_FLAG_SINGLE indicates tha=
t only
> > > > + * attributes associated with the LSM identified in the passed @ct=
x be
> > > > + * reported.
> > > > + *
> > > > + * A NULL value for @uctx can be used to get both the number of at=
tributes
> > > > + * and the size of the data.
> > > > + *
> > > > + * Returns the number of attributes found on success, negative val=
ue
> > > > + * on error. @size is reset to the total size of the data.
> > > > + * If @size is insufficient to contain the data -E2BIG is returned=
.
> > > > + */
> > > > +int security_getselfattr(unsigned int attr, struct lsm_ctx __user =
*uctx,
> > > > +                      size_t __user *size, u32 flags)
> > > > +{
> > > > +     struct security_hook_list *hp;
> > > > +     struct lsm_ctx lctx =3D { .id =3D LSM_ID_UNDEF, };
> > > > +     u8 __user *base =3D (u8 __user *)uctx;
> > > > +     size_t total =3D 0;
> > > > +     size_t entrysize;
> > > > +     size_t left;
> > > > +     bool toobig =3D false;
> > > > +     bool single =3D false;
> > > > +     int count =3D 0;
> > > > +     int rc;
> > > > +
> > > > +     if (attr =3D=3D LSM_ATTR_UNDEF)
> > > > +             return -EINVAL;
> > > > +     if (size =3D=3D NULL)
> > > > +             return -EINVAL;
> > > > +     if (get_user(left, size))
> > > > +             return -EFAULT;
> > > > +
> > > > +     if (flags) {
> > > > +             /*
> > > > +              * Only flag supported is LSM_FLAG_SINGLE
> > > > +              */
> > > > +             if (flags !=3D LSM_FLAG_SINGLE)
> > > > +                     return -EINVAL;
> > > > +             if (uctx && copy_from_user(&lctx, uctx, sizeof(lctx))=
)
> > >
> > > I'm not sure if we should return -EINVAL or -EFAULT when uctx =3D=3D =
NULL.
> > > Because uctx is optional (when LSM_FLAG_SINGLE is not set), I guess
> > > -EINVAL is OK.
> >
> > That's a good point, we should probably the error codes here: if uctx
> > is NULL in the LSM_FLAG_SINGLE case we should return -EINVAL, if the
> > copy_from_user() fails we should return -EFAULT.
> >
> > > > +                     return -EFAULT;
> > > > +             /*
> > > > +              * If the LSM ID isn't specified it is an error.
> > > > +              */
> > > > +             if (lctx.id =3D=3D LSM_ID_UNDEF)
> > > > +                     return -EINVAL;
> > > > +             single =3D true;
> > > > +     }
> > > > +
> > > > +     /*
> > > > +      * In the usual case gather all the data from the LSMs.
> > > > +      * In the single case only get the data from the LSM specifie=
d.
> > > > +      */
> > > > +     hlist_for_each_entry(hp, &security_hook_heads.getselfattr, li=
st) {
> > > > +             if (single && lctx.id !=3D hp->lsmid->id)
> > > > +                     continue;
> > > > +             entrysize =3D left;
> > > > +             if (base)
> > > > +                     uctx =3D (struct lsm_ctx __user *)(base + tot=
al);
> > > > +             rc =3D hp->hook.getselfattr(attr, uctx, &entrysize, f=
lags);
> > > > +             if (rc =3D=3D -EOPNOTSUPP) {
> > > > +                     rc =3D 0;
> > > > +                     continue;
> > > > +             }
> > > > +             if (rc =3D=3D -E2BIG) {
> > > > +                     toobig =3D true;
> > > > +                     left =3D 0;
> > > > +             } else if (rc < 0)
> > > > +                     return rc;
> > > > +             else
> > > > +                     left -=3D entrysize;
> > > > +
> > > > +             total +=3D entrysize;
> > > > +             count +=3D rc;
> > >
> > > There is a bug if rc =3D=3D -E2BIG
> >
> > Can you elaborate a bit more on this? Nothing is jumping out at me as
> > obviously broken... are you talking about @count becoming garbage due
> > to @rc being equal to -E2BIG?  If that is the case it should be okay
> > since we explicitly return -E2BIG, not @count, if @toobig is true.
>
> Indeed, in this case count will not be returned thanks to toobig. I'd
> suggest to "continue" if rc =3D=3D -E2BIG (like for -EOPNOTSUPP) to avoid=
 an
> inconsistent count value, which could bite us one day.

Okay, how about we reset @rc to zero in the -E2BIG case?  We don't
want to bypass the lower part of the loop in this case as we still
need to update @total.

  if (rc =3D=3D -E2BIG) {
    rc =3D 0;
    left =3D 0;
    toobig =3D true;
  }

--=20
paul-moore.com
