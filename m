Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8EB75D780
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 00:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjGUW3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 18:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjGUW3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 18:29:01 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD0D3A98
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 15:28:56 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-583b4522927so1106547b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 15:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689978535; x=1690583335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEFdiO+MnTvZjJ7JLWAkLut4guXgVutjrOaonvSxngY=;
        b=X3gRdQyN0mYiZnS9IGUB95IBfvWekZVIKr4UQfoy8yA8lDxuQFkgbK4oaODtTkTp2/
         IbwAz0vBGvkfOYcOjzEiUXF7XeFr/aAVUzoEVHIo44bXtMmoQOdrmJ4E7pqi8ftj4iZw
         pXFz7xslkLkGzZUINE2Rp7MEEolCnlfWlJtZYYyxMcyy3AbqwmcJA+KdqF967wtsIggC
         v9cID6GurhgOAnReyKEX7mzg4m5zFJ7UkGwnLEYZHqigTgFHRACCSNhrPArx7zTRv0xU
         keZoSuxnWfphj7FZw9f5nSE/+xN6ikWYXc8CLSYrWNyhH8pk/a1w2TxAQ9yOgdnmc04c
         WqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689978535; x=1690583335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEFdiO+MnTvZjJ7JLWAkLut4guXgVutjrOaonvSxngY=;
        b=BdtA+TVX5n8g3XSozacJKMTDukV2ztO8fhanOn/wll8lKpFrnSSdsMJJBjlE0ygUdE
         tfMdcBJTkHBudc4bN792DAtJVKiso6gMCy/jQ1AEXTgDs1d5NtQcvBvj/4EZ9Q+3beOH
         FiDk6FC4lbsV9g9tb8BL5hiIeB7KetEMp5BrIHwL/lFzEUZszei7mzPb2ZlbcRyrT77r
         b5LYQ148nkyzoojrUxcSoSnf3dl7MiecmSqT2Zg/5pzqzSvq79znoGUCQcevYG9n0jwX
         Ry69vES89e4pLkWuYguGlv4uTLbbwUTBQdi2pIeoPTtvIvAEUYVhL3rCk6Mg6uAKDdTf
         6ThA==
X-Gm-Message-State: ABy/qLbJgpiADLqvN18WNLWRK0Dzet+TDrngC4jVWG24/mhWl+g5n2e1
        8FMpx3O9cwJZbBqi7d1urrA32NfAM9ENMlHvo6sHl4C819IfmMs=
X-Google-Smtp-Source: APBJJlGiHoUYDH5eVWELb1GonzekdBP81DiZvgmd7Qj0OlMQh5FbEM0tUURDYpL5pojRRJD0sIxSgvlUx9Twez0Q00c=
X-Received: by 2002:a0d:de84:0:b0:576:777f:28bc with SMTP id
 h126-20020a0dde84000000b00576777f28bcmr1430709ywe.21.1689978535358; Fri, 21
 Jul 2023 15:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230629195535.2590-1-casey@schaufler-ca.com> <20230629195535.2590-5-casey@schaufler-ca.com>
 <dde1ce1f-280d-f4b2-4bb0-bc9d8a6894a3@digikod.net>
In-Reply-To: <dde1ce1f-280d-f4b2-4bb0-bc9d8a6894a3@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 Jul 2023 18:28:44 -0400
Message-ID: <CAHC9VhRvNLYE6aQJ9-LReLGQ5304j7wC4MLN1B7X8LV=2zgyXQ@mail.gmail.com>
Subject: Re: [PATCH v12 04/11] LSM: syscalls for current process attributes
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 11:36=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
> On 29/06/2023 21:55, Casey Schaufler wrote:
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
> >          __u64 id;
> >          __u64 flags;
> >          __u64 len;
> >          __u64 ctx_len;
> >          __u8 ctx[];
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
> > ---
> >   Documentation/userspace-api/lsm.rst |  15 ++++
> >   include/linux/lsm_hook_defs.h       |   4 +
> >   include/linux/lsm_hooks.h           |   1 +
> >   include/linux/security.h            |  19 +++++
> >   include/linux/syscalls.h            |   5 ++
> >   include/uapi/linux/lsm.h            |  36 +++++++++
> >   kernel/sys_ni.c                     |   4 +
> >   security/Makefile                   |   1 +
> >   security/lsm_syscalls.c             |  55 ++++++++++++++
> >   security/security.c                 | 112 +++++++++++++++++++++++++++=
+
> >   10 files changed, 252 insertions(+)
> >   create mode 100644 security/lsm_syscalls.c

Just a gentle reminder to everyone that if you are replying to a large
patch and only commenting on a couple of things in the patch, please
trim your reply so it is easier for others to read; we've got good
archives these days, if someone needs the extra context they can look
it up.

Additional comments below ...

> > diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> > new file mode 100644
> > index 000000000000..ee3881159241
> > --- /dev/null
> > +++ b/security/lsm_syscalls.c
> > @@ -0,0 +1,55 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * System calls implementing the Linux Security Module API.
> > + *
> > + *  Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
> > + *  Copyright (C) 2022 Intel Corporation
> > + */
> > +
> > +#include <asm/current.h>
> > +#include <linux/compiler_types.h>
> > +#include <linux/err.h>
> > +#include <linux/errno.h>
> > +#include <linux/security.h>
> > +#include <linux/stddef.h>
> > +#include <linux/syscalls.h>
> > +#include <linux/types.h>
> > +#include <linux/lsm_hooks.h>
> > +#include <uapi/linux/lsm.h>
> > +
> > +/**
> > + * sys_lsm_set_self_attr - Set current task's security module attribut=
e
> > + * @attr: which attribute to set
> > + * @ctx: the LSM contexts
> > + * @size: size of @ctx
>
> I don't understand why we need the lsm_ctx's size in this argument and
> in the lsm_ctx.len field as well. It makes sense to use the syscall's
> argument to set/get the size but I don't the the point of the "len" field=
.
>
> I may have miss some explanation but I also don't see the point of the
> ctx_len field if we can infer this information from the size argument.

I think the origin is probably due to the fact that early drafts
allowed multiple attributes to be set, but as we've discussed that is
not something we want to support in the final version.  It's also
possible it was there to offer some level of symmetry with the
associated getter function, which definitely does need a dedicated
@size parameter.

I agree it isn't probably isn't strictly necessary given the current
implementation, but I somewhat like the symmetry argument and it does
give us one extra "future use" knob to fiddle with if we need it in
the future.  It's also trivial to set for callers so I don't think
having it imposes any type of real penalty on callers.

If anyone is strongly opposed to this, I suppose we can drop it.

> > + * @flags: reserved for future use
> > + *
> > + * Sets the calling task's LSM context. On success this function
> > + * returns 0. If the attribute specified cannot be set a negative
> > + * value indicating the reason for the error is returned.
> > + */
> > +SYSCALL_DEFINE4(lsm_set_self_attr, unsigned int, attr, struct lsm_ctx =
__user *,
> > +             ctx, size_t, size, u32, flags)
> > +{
> > +     return security_setselfattr(attr, ctx, size, flags);
>
> Why not include all this lsm_syscalls.c file into security.c, or
> implement security_setselfattr() here instead? Ditto for other syscalls.
> This would simplify code and avoid duplicating the documentation.

I like having the syscalls in a separate file from the LSM hooks.  Not
only are they conceptually different, but the hooks file is pushing
~5.5k lines and is already a bit unwieldy.

... and yes, the syscalls do end up calling LSM hooks, but syscalls
are an *external* API with respect to the kernel while the hooks are
an *internal* API with respect to the kernel.

> > +/**
> > + * sys_lsm_get_self_attr - Return current task's security module attri=
butes
> > + * @attr: which attribute to set
> > + * @ctx: the LSM contexts
> > + * @size: size of @ctx, updated on return
> > + * @flags: reserved for future use
> > + *
> > + * Returns the calling task's LSM contexts. On success this
> > + * function returns the number of @ctx array elements. This value
> > + * may be zero if there are no LSM contexts assigned. If @size is
> > + * insufficient to contain the return data -E2BIG is returned and
> > + * @size is set to the minimum required size. In all other cases
>
> This is not true with selinux_getselfattr() (and without
> LSM_FLAG_SINGLE) at least.

?

> -E2BIG is returned without updating *size.

I seeing a put_user() call in security_getselfattr() that should
update @size; am I missing something here?

> > + * a negative value indicating the error is returned.
> > + */
> > +SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct lsm_ctx =
__user *,
> > +             ctx, size_t __user *, size, u32, flags)
> > +{
> > +     return security_getselfattr(attr, ctx, size, flags);
> > +}
> > diff --git a/security/security.c b/security/security.c
> > index d942b0c8e32f..199db23581f1 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -3798,6 +3798,118 @@ void security_d_instantiate(struct dentry *dent=
ry, struct inode *inode)
> >   }
> >   EXPORT_SYMBOL(security_d_instantiate);
> >
> > +/**
> > + * security_getselfattr - Read an LSM attribute of the current process=
.
> > + * @attr: which attribute to return
> > + * @ctx: the user-space destination for the information, or NULL
>
> It would be useful to explain the use case for NULL: to only get the
> number of attributes.

Good point.  I believe it also works to set @size.

> Also, LSM_FLAG_SINGLE is incompatible with a NULL
> ctx. It's also a bit weird to still require size to contain a valid
> address. And size is always checked by the hook implementations even if
> ctx is NULL. I suggest to require size to be NULL if ctx is NULL, or
> return -EINVAL otherwise.

I believe this is so that the caller can get a @size value too, to
help guide allocations for a future call.

> I'm not convinced this trick/exception to only get the number of
> attribute is useful though, especially with *size that needs to be large
> enough. Or maybe we should require *size to be zero and return the
> required size to hold all attributes?

Agreed, in fact I have a vague memory that is how this works, but it
has been a few weeks since I seriously looked at this code.

> > + * @size: pointer to the size of space available to receive the data
> > + * @flags: special handling options. LSM_FLAG_SINGLE indicates that on=
ly
> > + * attributes associated with the LSM identified in the passed @ctx be
> > + * reported
> > + *
> > + * Returns the number of attributes found on success, negative value
> > + * on error. @size is reset to the total size of the data.
> > + * If @size is insufficient to contain the data -E2BIG is returned.
> > + */
> > +int security_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx=
,
> > +                      size_t __user *size, u32 flags)
> > +{
> > +     struct security_hook_list *hp;
> > +     struct lsm_ctx lctx =3D { .id =3D LSM_ID_UNDEF, };
> > +     u8 __user *base =3D (u8 __user *)ctx;
> > +     size_t total =3D 0;
> > +     size_t entrysize;
> > +     size_t left;
> > +     bool toobig =3D false;
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
> > +     if ((flags & LSM_FLAG_SINGLE) =3D=3D LSM_FLAG_SINGLE) {
> > +             if (!ctx)
> > +                     return -EINVAL;
> > +             if (copy_struct_from_user(&lctx, sizeof(lctx), ctx, left)=
)
> > +                     return -EFAULT;
> > +             if (lctx.id =3D=3D LSM_ID_UNDEF)
> > +                     return -EINVAL;
> > +     } else if (flags) {
> > +             return -EINVAL;
> > +     }
> > +
> > +     hlist_for_each_entry(hp, &security_hook_heads.getselfattr, list) =
{
> > +             if (lctx.id !=3D LSM_ID_UNDEF && lctx.id !=3D hp->lsmid->=
id)
> > +                     continue;
> > +             entrysize =3D left;
> > +             if (base)
> > +                     ctx =3D (struct lsm_ctx __user *)(base + total);
> > +             rc =3D hp->hook.getselfattr(attr, ctx, &entrysize, flags)=
; > +            if (rc =3D=3D -EOPNOTSUPP) {
> > +                     rc =3D 0;
> > +                     continue;
> > +             }
> > +             if (rc =3D=3D -E2BIG) {
> > +                     toobig =3D true;
> > +                     left =3D 0;
> > +                     continue;
> > +             }
> > +             if (rc < 0)
> > +                     return rc;
> > +
> > +             left -=3D entrysize;
> > +             total +=3D entrysize;
> > +             count +=3D rc;
>
> Would it make sense for an LSM (e.g. eBPF program) to return more than
> one?

Yes, we want to allow for that possibility.

> > +     }
> > +     if (put_user(total, size))
>
> This might be useful to get the required size, but if the original *size
> is not big enough the LSM hook implementations (e.g.
> selinux_getselfattr) currently don't update *size and just return
> -E2BIG, which is then propagated at the end of the syscall, after all
> hook calls.

At the very least I believe that SELinux updates the size value when
returning -E2BIG.

> > +             return -EFAULT;
> > +     if (toobig)
> > +             return -E2BIG;
>
> This doesn't help because we don't know how much space is required for a
> specific list entries/LSMs.
>
> I'm convinced this syscall should only deal with one LSM attribute at a
> time (i.e. only support LSM_FLAG_SINGLE, but then without this flag). I
> think it's not worth it to handle a list of arbitrary-size elements,
> especially when they have a different semantic.

Thank you for the review, I appreciate it and I'm sure Casey does as
well, but I want this syscall to allow for multiple attributes.  I
think you're suggestion of adding support for LSM_FLAG_SINGLE was a
good addition, but I don't want LSM_FLAG_SINGLE to be the only option
here.

> If we really need such list handling, I think it would be easier to have
> a syscall argument pointing to a header part containing an array of LSM
> IDs (and potentially the flags field)), and another syscall argument
> that contains an array of (simplified) lsm_ctx entries (without len).

I really like the idea of a single struct that we can use across the
different LSM syscalls.

> > +/**
> > + * security_setselfattr - Set an LSM attribute on the current process.
> > + * @attr: which attribute to set
> > + * @ctx: the user-space source for the information
> > + * @size: the size of the data
> > + * @flags: reserved for future use, must be 0
> > + *
> > + * Set an LSM attribute for the current process. The LSM, attribute
> > + * and new value are included in @ctx.
> > + *
> > + * Returns 0 on success, -EINVAL if the input is inconsistent, -EFAULT
> > + * if the user buffer is inaccessible or an LSM specific failure.
> > + */
> > +int security_setselfattr(unsigned int attr, struct lsm_ctx __user *ctx=
,
> > +                      size_t size, u32 flags)
> > +{
> > +     struct security_hook_list *hp;
> > +     struct lsm_ctx lctx;
> > +
> > +     if (flags)
> > +             return -EINVAL;
> > +     if (size < sizeof(*ctx))
> > +             return -EINVAL;
> > +     if (copy_from_user(&lctx, ctx, sizeof(*ctx)))
>
> I'd suggest to handle all the user space copy here and pass a kernel
> pointer to each LSM hook calls (and handle kmalloc and kfree here, if
> needed).

Agreed.  I thought I mentioned something like that at one point, maybe
not.  In general we should do whatever user/kernel copying and sanity
checking in the LSM layer that we can; there will be somethings we
can't check, but those that we can, we should.

> This single point of copy would make the LSM implementations
> (setselfattr hooks) easier and less error prone. For instance, we could
> limit data copied from user space to PAGE_SIZE (as done for Landlock
> syscalls). If one day this limit is too short, there is always the
> possibility to add a dedicated flag to the syscall or set exceptions
> according to the target LSM.

Let's not do that right now.

> > +             return -EFAULT;
> > +     if (size < lctx.len || size < lctx.ctx_len + sizeof(ctx) ||
> > +         lctx.len < lctx.ctx_len + sizeof(ctx))
>
> It should not be sizeof(ctx) but sizeof(*ctx) or sizeof(lctx). Positive
> and negative tests for these checks would be useful.
>
> Why not `if (size !=3D lctx.ctx_len + sizeof(lctx))` instead? If this is
> correct, ctx_len and len are redundant. Otherwise, a comment should
> explain what is going on, and what is being checked.
>
>
>
> > +             return -EINVAL;
> > +
> > +     hlist_for_each_entry(hp, &security_hook_heads.setselfattr, list)
> > +             if ((hp->lsmid->id) =3D=3D lctx.id)
> > +                     return hp->hook.setselfattr(attr, ctx, size, flag=
s);
> > +
> > +     return LSM_RET_DEFAULT(setselfattr);
> > +}
> > +
> >   /**
> >    * security_getprocattr() - Read an attribute for a task
> >    * @p: the task

--=20
paul-moore.com
