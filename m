Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CB879D091
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbjILMBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbjILMAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:00:49 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B7D1721;
        Tue, 12 Sep 2023 05:00:24 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3aa1c046659so4019254b6e.0;
        Tue, 12 Sep 2023 05:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694520024; x=1695124824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bfx8qyKxeQqpt+NjmLCChFJkKXstxcEm0yVFNB6xs3M=;
        b=avlBQkyEf08TjKYKIX0fCBFXXTM0CDhQgHJz4JYUseFE06UX4tJKx0SpAbkf9r0/rH
         bi6gyBInkEFhYzglHYGMnJZ73vMWEpcnc8EV5v7tvXKg50V4CG7yPyZIdWGtrcjcTCOM
         DfM5eD0I/xFbKijk1ktSUBzjexlTFohuKodYBoLzpc2uoxCZUvipcG4k9u/8AGSDFUf3
         WRhJlElNX00O5hYndAbfEKxk+7zqgx4qL3qTVojQFht13KiatSQAQlluURNtuz+IP1E0
         uD7zCruVtVenzba4wIYFRMUzKW8KHPFsqELVE5NRzmkT8/YLvroDXTg2BvF6YTTh+KZe
         KniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694520024; x=1695124824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bfx8qyKxeQqpt+NjmLCChFJkKXstxcEm0yVFNB6xs3M=;
        b=Xu3JQdmKUSPYIM3dqHOCiBuVdwYB+kxUqcRJ9eVde9jrQCpfH/iz3ONVMMM0Zj/eL1
         5s4+RuKqKRpSol/ZLwXmrncncCbjllhz00YiY6PHL/rk7t9tsT0j6ZhHesIsRmVY9Xuu
         lSkuTyVMVl0QEpCcyg2unuUuYbDOo4B134TXS/cCFDMv/OiDGfTPblamxdXJn7r68PtM
         GEm7xwtQO8oM7LId3RerVnF+7+W8ZtrLwBnTA53Nqr74Yb7w/DWiuahv/jWX6WdVyN8W
         rfm3rZ9nuMcU09PQNPaOi6QzrVLJ25Dum5za7vP1lP/GUgjW60XjA/aeRL7wiYQqFvjn
         tiaw==
X-Gm-Message-State: AOJu0YwSQrBlqrUNujo6r56ZEi5I9cIV4/NFLGL6s5+LLgJLo9wKOYVd
        SF3QuafifAl7/tG+mRRn/gY97ODu8kNluDkeuZI=
X-Google-Smtp-Source: AGHT+IFu915Ongf7qGoEx5uG6du+SHYbHAjqGAg+yP49LNsWS4aGUG+9ov+iK1LrZOQ+/4kcWO7JdRp0uCHJtdCPT8Q=
X-Received: by 2002:a05:6808:14d5:b0:3a4:ccf:6a63 with SMTP id
 f21-20020a05680814d500b003a40ccf6a63mr15980885oiw.55.1694520024037; Tue, 12
 Sep 2023 05:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230906115928.3749928-1-alpic@google.com> <202309090600.NSyo7d2q-lkp@intel.com>
 <CAEjxPJ4GOq3E4zqXbEMKUxqewopyeU5nmUg89rL+P5YsuEBi7A@mail.gmail.com>
 <CAEjxPJ4uoqkwmbeOOmUHJwoKiK3cnfJP5P2w+hOXr4BZNtQ+JQ@mail.gmail.com> <CALcwBGBPaYh98d+3_3k8o+8WCbYU8cNPoOHaqhUduKZYz7Ntow@mail.gmail.com>
In-Reply-To: <CALcwBGBPaYh98d+3_3k8o+8WCbYU8cNPoOHaqhUduKZYz7Ntow@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 12 Sep 2023 08:00:12 -0400
Message-ID: <CAEjxPJ6gFh7h5MnEEqTL34_dVEoAmoGfqa01eeYHnOECjkYxBg@mail.gmail.com>
Subject: Re: [PATCH V2] SELinux: Check correct permissions for FS_IOC32_*
To:     Alfred Piccioni <alpic@google.com>
Cc:     kernel test robot <lkp@intel.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        oe-kbuild-all@lists.linux.dev, stable@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 5:00=E2=80=AFAM Alfred Piccioni <alpic@google.com> =
wrote:
>
> On Mon, Sep 11, 2023 at 3:49=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Mon, Sep 11, 2023 at 9:19=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Fri, Sep 8, 2023 at 6:54=E2=80=AFPM kernel test robot <lkp@intel.c=
om> wrote:
> > > >
> > > > Hi Alfred,
> > > >
> > > > kernel test robot noticed the following build errors:
> > > >
> > > > [auto build test ERROR on 50a510a78287c15cee644f345ef8bac8977986a7]
> > > >
> > > > url:    https://github.com/intel-lab-lkp/linux/commits/Alfred-Picci=
oni/SELinux-Check-correct-permissions-for-FS_IOC32_/20230906-200131
> > > > base:   50a510a78287c15cee644f345ef8bac8977986a7
> > > > patch link:    https://lore.kernel.org/r/20230906115928.3749928-1-a=
lpic%40google.com
> > > > patch subject: [PATCH V2] SELinux: Check correct permissions for FS=
_IOC32_*
> > > > config: i386-debian-10.3 (https://download.01.org/0day-ci/archive/2=
0230909/202309090600.NSyo7d2q-lkp@intel.com/config)
> > > > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > > > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci=
/archive/20230909/202309090600.NSyo7d2q-lkp@intel.com/reproduce)
> > > >
> > > > If you fix the issue in a separate patch/commit (i.e. not just a ne=
w version of
> > > > the same patch/commit), kindly add following tags
> > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > | Closes: https://lore.kernel.org/oe-kbuild-all/202309090600.NSyo7d=
2q-lkp@intel.com/
> > > >
> > > > All errors (new ones prefixed by >>):
> > > >
> > > >    security/selinux/hooks.c: In function 'selinux_file_ioctl':
> > > > >> security/selinux/hooks.c:3647:9: error: duplicate case value
> > > >     3647 |         case FS_IOC32_GETFLAGS:
> > > >          |         ^~~~
> > > >    security/selinux/hooks.c:3645:9: note: previously used here
> > > >     3645 |         case FS_IOC_GETFLAGS:
> > > >          |         ^~~~
> > > >    security/selinux/hooks.c:3648:9: error: duplicate case value
> > > >     3648 |         case FS_IOC32_GETVERSION:
> > > >          |         ^~~~
> > > >    security/selinux/hooks.c:3646:9: note: previously used here
> > > >     3646 |         case FS_IOC_GETVERSION:
> > > >          |         ^~~~
> > > >    security/selinux/hooks.c:3654:9: error: duplicate case value
> > > >     3654 |         case FS_IOC32_SETFLAGS:
> > > >          |         ^~~~
> > > >    security/selinux/hooks.c:3652:9: note: previously used here
> > > >     3652 |         case FS_IOC_SETFLAGS:
> > > >          |         ^~~~
> > > >    security/selinux/hooks.c:3655:9: error: duplicate case value
> > > >     3655 |         case FS_IOC32_SETVERSION:
> > > >          |         ^~~~
> > > >    security/selinux/hooks.c:3653:9: note: previously used here
> > > >     3653 |         case FS_IOC_SETVERSION:
> > > >          |         ^~~~
> > >
> > > Not sure of the right way to fix this while addressing the original
> > > issue that this patch was intended to fix. Looking in fs/ioctl.c, I
> > > see that the some FS_IOC32 values are remapped to the corresponding
> > > FS_IOC values by the compat ioctl syscall entrypoint. Also notice thi=
s
> > > comment there:
> > >
> > >         /* RED-PEN how should LSM module know it's handling 32bit? */
> > >         error =3D security_file_ioctl(f.file, cmd, arg);
> > >         if (error)
> > >                 goto out;
> > >
> > > So perhaps this is a defect in LSM that needs to be addressed?
> >
> > Note btw that some of the 32-bit ioctl commands are only handled in
> > the fs-specific compat_ioctl routines, e.g. ext4_compat_ioctl()
> > handles EXT4_IOC32_GETVERSION =3D=3D FS_IOC32_GETVERSION and ditto for
> > _SETVERSION.
> >
> > >
> > >
> > > >
> > > >
> > > > vim +3647 security/selinux/hooks.c
> > > >
> > > >   3634
> > > >   3635  static int selinux_file_ioctl(struct file *file, unsigned i=
nt cmd,
> > > >   3636                                unsigned long arg)
> > > >   3637  {
> > > >   3638          const struct cred *cred =3D current_cred();
> > > >   3639          int error =3D 0;
> > > >   3640
> > > >   3641          switch (cmd) {
> > > >   3642          case FIONREAD:
> > > >   3643          case FIBMAP:
> > > >   3644          case FIGETBSZ:
> > > >   3645          case FS_IOC_GETFLAGS:
> > > >   3646          case FS_IOC_GETVERSION:
> > > > > 3647          case FS_IOC32_GETFLAGS:
> > > >   3648          case FS_IOC32_GETVERSION:
> > > >   3649                  error =3D file_has_perm(cred, file, FILE__G=
ETATTR);
> > > >   3650                  break;
> > > >   3651
> > > >   3652          case FS_IOC_SETFLAGS:
> > > >   3653          case FS_IOC_SETVERSION:
> > > >   3654          case FS_IOC32_SETFLAGS:
> > > >   3655          case FS_IOC32_SETVERSION:
> > > >   3656                  error =3D file_has_perm(cred, file, FILE__S=
ETATTR);
> > > >   3657                  break;
> > > >   3658
> > > >   3659          /* sys_ioctl() checks */
> > > >   3660          case FIONBIO:
> > > >   3661          case FIOASYNC:
> > > >   3662                  error =3D file_has_perm(cred, file, 0);
> > > >   3663                  break;
> > > >   3664
> > > >   3665          case KDSKBENT:
> > > >   3666          case KDSKBSENT:
> > > >   3667                  error =3D cred_has_capability(cred, CAP_SYS=
_TTY_CONFIG,
> > > >   3668                                              CAP_OPT_NONE, t=
rue);
> > > >   3669                  break;
> > > >   3670
> > > >   3671          case FIOCLEX:
> > > >   3672          case FIONCLEX:
> > > >   3673                  if (!selinux_policycap_ioctl_skip_cloexec()=
)
> > > >   3674                          error =3D ioctl_has_perm(cred, file=
, FILE__IOCTL, (u16) cmd);
> > > >   3675                  break;
> > > >   3676
> > > >   3677          /* default case assumes that the command will go
> > > >   3678           * to the file's ioctl() function.
> > > >   3679           */
> > > >   3680          default:
> > > >   3681                  error =3D ioctl_has_perm(cred, file, FILE__=
IOCTL, (u16) cmd);
> > > >   3682          }
> > > >   3683          return error;
> > > >   3684  }
> > > >   3685
>
> Hey Stephen,
>
> Thanks for looking into it a bit deeper! This seems a bit of a pickle.
> I can think of a few somewhat hacky ways to fix this.
>
> I can just set the flags to check `if FS_IOC32_*; set FS_IOC_*;`,
> which is the quickest but kinda hacky.
>
> I can go with the other plan of dropping the irrelevant bytes from the
> cmd code, so all codes will be read as u16. This effectively does the
> same thing, but may be unclear.
>
> I can also look into whether this can be solved at the LSM or a higher
> level. Perhaps the filesystems setting `if FS_IOC32_*; set FS_IOC_*;`
> is a hint that something else interesting is going wrong.
>
> I'll spend a little time thinking and investigating and get back with
> a more concrete solution. I'll also need to do a bit more robust
> testing; it built on my machine!

Likewise for me; I don't generally try building for 32-bit systems.
Remapping FS_IOC32_* to FS_IOC_* in selinux_file_ioctl() seems
reasonable to me although optimally that would be conditional on
whether selinux_file_ioctl() is being called from the compat ioctl
syscall (e.g. adding a flag to the LSM hook to indicate this or using
a separate hook for it). Otherwise we might misinterpret some other
ioctl on 64-bit.

If we didn't have compatibility requirements, it would be tempting to
just get rid of all the special case ioctl command handling in
selinux_file_ioctl() and let ioctl_has_perm() handle them all with the
extended ioctl permissions support. But that would require a SELinux
policy cap to switch it on conditionally for compatibility at least
and not sure anyone is willing to refactor their policies accordingly.

>
> Thanks!
