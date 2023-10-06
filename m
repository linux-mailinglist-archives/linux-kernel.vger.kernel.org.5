Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFD27BAFE2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 03:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjJFBEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 21:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjJFBEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 21:04:47 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F9FE8
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 18:04:45 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d8181087dc9so1800366276.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 18:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1696554285; x=1697159085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gL74AVv/kADxmrat7aE6h2s1GttYw5i8Oajx36h7rE=;
        b=V3o+t/na+IFVLoo5v84Iz4jG8x49Mr0lKmSlaVgb5LdfKLOWFr/d1ssmVrLozY0Apl
         AzQhfKA5NA7ezx19Zthz7DtYEcNPUdQWb5ghclRp+QH3YXSHIS2+CxnIDURJS9xi4fXt
         gkZ3fyW62F2HQ+h1J4Pqxv17Jq0xw+v2IZlRPTEV3K6xQ5ZxNcGLjjZ5occzy/bdqj/Q
         eE12QdrBY0jHkVvOHA1LK29X1S2JZBXK/anzu283ZTuEvB4reIQ6gpqaeM3ZglhzuAS4
         oy8EJby6qQFjh82lDtviSb0R6I0H//vTxRUAdXns79hW9rK1zwan5ijjalNRVDg+44g4
         aTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696554285; x=1697159085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6gL74AVv/kADxmrat7aE6h2s1GttYw5i8Oajx36h7rE=;
        b=P0O59ZaQh1Wm1sdbque+pXWI2DprVhs2I9GLnRD6QUo7oY7DfdQdeXySugBxUOSqtt
         tMnurMSQC4e66HAbjKMepapB6sKunmRui7PL3iIS11Pd+WqOr4b8m2ERILWuMsE6ov7U
         VddNpNiEoXHYdZlFLfKn5QE8j4w21CC8tSgvohTOqpE9TUXxTnTI5hFCF+ul9sbzGZAL
         OWFRG5+ydnN2HLN0br4UuOayJ5G3A3wbU0X6zXHYC/qN0ahzFAWRLidmzTDfOABTLUtY
         OnBtXxXYwmOXjdedMO3ywRvu5m2gFZMpVsyswoiwHk1LHQEEZgEUPLz0p3q7z35zAxj+
         kzbw==
X-Gm-Message-State: AOJu0YwX2DXCFPSkymfW7r1ClhDZI8yE05/8EcmNCynyZPgMUTllkKjQ
        PgUpTcieOQ4OniKmwOac6+PY20zdLdMTVikvSQFq
X-Google-Smtp-Source: AGHT+IFjA2MaGiVDVxZNi9Kil7q848FSc5god1/jayS8nH5Zot/WRoFgFQBx1DUh0fv4zhps9wL+Oj28UeN5TTuHiKU=
X-Received: by 2002:a25:cb05:0:b0:d78:18c3:23dd with SMTP id
 b5-20020a25cb05000000b00d7818c323ddmr6954997ybg.62.1696554284853; Thu, 05 Oct
 2023 18:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230912205658.3432-1-casey@schaufler-ca.com> <20230912205658.3432-5-casey@schaufler-ca.com>
 <20231003.kooghohS2Aiz@digikod.net>
In-Reply-To: <20231003.kooghohS2Aiz@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 5 Oct 2023 21:04:34 -0400
Message-ID: <CAHC9VhT_ijmqo9ap-EokWHuALsMAqome2qcWgst3eRP6m+vbRA@mail.gmail.com>
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

On Tue, Oct 3, 2023 at 10:09=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Tue, Sep 12, 2023 at 01:56:49PM -0700, Casey Schaufler wrote:
> > Create a system call lsm_get_self_attr() to provide the security
> > module maintained attributes of the current process.
> > Create a system call lsm_set_self_attr() to set a security
> > module maintained attribute of the current process.
> > Historically these attributes have been exposed to user space via
> > entries in procfs under /proc/self/attr.
> >
> > The attribute value is provided in a lsm_ctx structure. The structure
> > identifies the size of the attribute, and the attribute value. The form=
at
> > of the attribute value is defined by the security module. A flags field
> > is included for LSM specific information. It is currently unused and mu=
st
> > be 0. The total size of the data, including the lsm_ctx structure and a=
ny
> > padding, is maintained as well.
> >
> > struct lsm_ctx {
> >         __u64 id;
> >         __u64 flags;
> >         __u64 len;
> >         __u64 ctx_len;
> >         __u8 ctx[];
> > };
> >
> > Two new LSM hooks are used to interface with the LSMs.
> > security_getselfattr() collects the lsm_ctx values from the
> > LSMs that support the hook, accounting for space requirements.
> > security_setselfattr() identifies which LSM the attribute is
> > intended for and passes it along.
> >
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> > Reviewed-by: John Johansen <john.johansen@canonical.com>
> > ---
> >  Documentation/userspace-api/lsm.rst |  70 +++++++++++++
> >  include/linux/lsm_hook_defs.h       |   4 +
> >  include/linux/lsm_hooks.h           |   1 +
> >  include/linux/security.h            |  19 ++++
> >  include/linux/syscalls.h            |   5 +
> >  include/uapi/linux/lsm.h            |  36 +++++++
> >  kernel/sys_ni.c                     |   2 +
> >  security/Makefile                   |   1 +
> >  security/lsm_syscalls.c             |  57 +++++++++++
> >  security/security.c                 | 152 ++++++++++++++++++++++++++++
> >  10 files changed, 347 insertions(+)
> >  create mode 100644 Documentation/userspace-api/lsm.rst
> >  create mode 100644 security/lsm_syscalls.c

...

> > diff --git a/security/security.c b/security/security.c
> > index a3489c04b783..0d179750d964 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -3837,6 +3837,158 @@ void security_d_instantiate(struct dentry *dent=
ry, struct inode *inode)
> >  }
> >  EXPORT_SYMBOL(security_d_instantiate);
> >
> > +/*
> > + * Please keep this in sync with it's counterpart in security/lsm_sysc=
alls.c
> > + */
> > +
> > +/**
> > + * security_getselfattr - Read an LSM attribute of the current process=
.
> > + * @attr: which attribute to return
> > + * @uctx: the user-space destination for the information, or NULL
> > + * @size: pointer to the size of space available to receive the data
> > + * @flags: special handling options. LSM_FLAG_SINGLE indicates that on=
ly
> > + * attributes associated with the LSM identified in the passed @ctx be
> > + * reported.
> > + *
> > + * A NULL value for @uctx can be used to get both the number of attrib=
utes
> > + * and the size of the data.
> > + *
> > + * Returns the number of attributes found on success, negative value
> > + * on error. @size is reset to the total size of the data.
> > + * If @size is insufficient to contain the data -E2BIG is returned.
> > + */
> > +int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uct=
x,
> > +                      size_t __user *size, u32 flags)
> > +{
> > +     struct security_hook_list *hp;
> > +     struct lsm_ctx lctx =3D { .id =3D LSM_ID_UNDEF, };
> > +     u8 __user *base =3D (u8 __user *)uctx;
> > +     size_t total =3D 0;
> > +     size_t entrysize;
> > +     size_t left;
> > +     bool toobig =3D false;
> > +     bool single =3D false;
> > +     int count =3D 0;
> > +     int rc;
> > +
> > +     if (attr =3D=3D LSM_ATTR_UNDEF)
> > +             return -EINVAL;
> > +     if (size =3D=3D NULL)
> > +             return -EINVAL;
> > +     if (get_user(left, size))
> > +             return -EFAULT;
> > +
> > +     if (flags) {
> > +             /*
> > +              * Only flag supported is LSM_FLAG_SINGLE
> > +              */
> > +             if (flags !=3D LSM_FLAG_SINGLE)
> > +                     return -EINVAL;
> > +             if (uctx && copy_from_user(&lctx, uctx, sizeof(lctx)))
>
> I'm not sure if we should return -EINVAL or -EFAULT when uctx =3D=3D NULL=
.
> Because uctx is optional (when LSM_FLAG_SINGLE is not set), I guess
> -EINVAL is OK.

That's a good point, we should probably the error codes here: if uctx
is NULL in the LSM_FLAG_SINGLE case we should return -EINVAL, if the
copy_from_user() fails we should return -EFAULT.

> > +                     return -EFAULT;
> > +             /*
> > +              * If the LSM ID isn't specified it is an error.
> > +              */
> > +             if (lctx.id =3D=3D LSM_ID_UNDEF)
> > +                     return -EINVAL;
> > +             single =3D true;
> > +     }
> > +
> > +     /*
> > +      * In the usual case gather all the data from the LSMs.
> > +      * In the single case only get the data from the LSM specified.
> > +      */
> > +     hlist_for_each_entry(hp, &security_hook_heads.getselfattr, list) =
{
> > +             if (single && lctx.id !=3D hp->lsmid->id)
> > +                     continue;
> > +             entrysize =3D left;
> > +             if (base)
> > +                     uctx =3D (struct lsm_ctx __user *)(base + total);
> > +             rc =3D hp->hook.getselfattr(attr, uctx, &entrysize, flags=
);
> > +             if (rc =3D=3D -EOPNOTSUPP) {
> > +                     rc =3D 0;
> > +                     continue;
> > +             }
> > +             if (rc =3D=3D -E2BIG) {
> > +                     toobig =3D true;
> > +                     left =3D 0;
> > +             } else if (rc < 0)
> > +                     return rc;
> > +             else
> > +                     left -=3D entrysize;
> > +
> > +             total +=3D entrysize;
> > +             count +=3D rc;
>
> There is a bug if rc =3D=3D -E2BIG

Can you elaborate a bit more on this? Nothing is jumping out at me as
obviously broken... are you talking about @count becoming garbage due
to @rc being equal to -E2BIG?  If that is the case it should be okay
since we explicitly return -E2BIG, not @count, if @toobig is true.

> > +             if (single)
> > +                     break;
> > +     }
> > +     if (put_user(total, size))
> > +             return -EFAULT;
> > +     if (toobig)
> > +             return -E2BIG;
> > +     if (count =3D=3D 0)
> > +             return LSM_RET_DEFAULT(getselfattr);
> > +     return count;
> > +}

--=20
paul-moore.com
