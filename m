Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5C179B81A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348369AbjIKV0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238206AbjIKNtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:49:43 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DE8F5;
        Mon, 11 Sep 2023 06:49:39 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-573449a364fso2914900eaf.1;
        Mon, 11 Sep 2023 06:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694440179; x=1695044979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXNPbouy3kzuW6cEr2/zAGNQTmDNOg3cj29kcDr8jVg=;
        b=b1jpZvlNtfsi5DB/9yhslbfEuSSKOJz/rQVzCa8FwN0GRfyJwAkcZ1IMFPrzjAMLEg
         5fcROyU8mHE4oHCw8D7Aj8LbjpkVEWxeQAqSSmZPx+rf8Ur2xQpQ9d5OH2vfT8C2usUP
         Z4mNyEnWpRsKhiL1LPCRCtFLg8ZyFZHOraAmdn0ooqkio6HvL8zjKYPrUsMZjh5mi7RN
         8sTKQqtjQkQZjXJ90zMs4iQEz4BlswgZcd9dC8G+xnFMcNP5jhWWOORrmNiQCHq7mq5N
         8ceEaZgGkQt9ICarOVI5E+TocYp4yj3D4mDO/sDcbv8VcsDTHXlFZkde9g4zAooMl52j
         /0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694440179; x=1695044979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXNPbouy3kzuW6cEr2/zAGNQTmDNOg3cj29kcDr8jVg=;
        b=CdQEpKWw76nPpvQIErHxXKJmaxDSmANJ+jPNMtkjE/YwY+AVqXc8h0a41qFT+ZGucd
         zbhpUQWJql+EV0RISgm+JBRE6CfY774wpqaLBZqXkptvLEIPkjoJ9d7cXes4WiUqCxPb
         69a+0nfpL4rKVJC/bxTGasnWbiuFEwPt0DIeKzTCe7qoNODxIST87jHnJqZ1Iju3jlTh
         hnqjF7IeABwYqVgqmvdBG1unP66ajrk9VsfUa2899yFzRSKH1ohtM8OrI1Q12IJ0R2Jf
         1TFxf0iTPLLTnbGPP3P0QnVVZavQ8K5x89pCgN1S8AZYxdQNgdA1eBwECMS0WhnVRlvl
         GnMw==
X-Gm-Message-State: AOJu0YwpGR1kiuvsJBrX5WPQgcOKIkqDaOmUyOYY4Y2sNDOxaWvV3TBc
        ugQiWYpcwEElynJgVNzZ3YMZ93PIukZ5mVsGuFc=
X-Google-Smtp-Source: AGHT+IE4R9jl7ZSD4oR4TffX/ALcpWOZ4zwagoM4Tx84LF1QGH9ViZAd4OeqM7xUiHyfzOu7FdoyK4H2SxtpGRO8HUM=
X-Received: by 2002:a05:6820:170:b0:576:8d6e:9a41 with SMTP id
 k16-20020a056820017000b005768d6e9a41mr6173164ood.1.1694440178811; Mon, 11 Sep
 2023 06:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230906115928.3749928-1-alpic@google.com> <202309090600.NSyo7d2q-lkp@intel.com>
 <CAEjxPJ4GOq3E4zqXbEMKUxqewopyeU5nmUg89rL+P5YsuEBi7A@mail.gmail.com>
In-Reply-To: <CAEjxPJ4GOq3E4zqXbEMKUxqewopyeU5nmUg89rL+P5YsuEBi7A@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 11 Sep 2023 09:49:27 -0400
Message-ID: <CAEjxPJ4uoqkwmbeOOmUHJwoKiK3cnfJP5P2w+hOXr4BZNtQ+JQ@mail.gmail.com>
Subject: Re: [PATCH V2] SELinux: Check correct permissions for FS_IOC32_*
To:     kernel test robot <lkp@intel.com>
Cc:     Alfred Piccioni <alpic@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        oe-kbuild-all@lists.linux.dev, stable@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 9:19=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Sep 8, 2023 at 6:54=E2=80=AFPM kernel test robot <lkp@intel.com> =
wrote:
> >
> > Hi Alfred,
> >
> > kernel test robot noticed the following build errors:
> >
> > [auto build test ERROR on 50a510a78287c15cee644f345ef8bac8977986a7]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Alfred-Piccioni/=
SELinux-Check-correct-permissions-for-FS_IOC32_/20230906-200131
> > base:   50a510a78287c15cee644f345ef8bac8977986a7
> > patch link:    https://lore.kernel.org/r/20230906115928.3749928-1-alpic=
%40google.com
> > patch subject: [PATCH V2] SELinux: Check correct permissions for FS_IOC=
32_*
> > config: i386-debian-10.3 (https://download.01.org/0day-ci/archive/20230=
909/202309090600.NSyo7d2q-lkp@intel.com/config)
> > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20230909/202309090600.NSyo7d2q-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202309090600.NSyo7d2q-l=
kp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> >    security/selinux/hooks.c: In function 'selinux_file_ioctl':
> > >> security/selinux/hooks.c:3647:9: error: duplicate case value
> >     3647 |         case FS_IOC32_GETFLAGS:
> >          |         ^~~~
> >    security/selinux/hooks.c:3645:9: note: previously used here
> >     3645 |         case FS_IOC_GETFLAGS:
> >          |         ^~~~
> >    security/selinux/hooks.c:3648:9: error: duplicate case value
> >     3648 |         case FS_IOC32_GETVERSION:
> >          |         ^~~~
> >    security/selinux/hooks.c:3646:9: note: previously used here
> >     3646 |         case FS_IOC_GETVERSION:
> >          |         ^~~~
> >    security/selinux/hooks.c:3654:9: error: duplicate case value
> >     3654 |         case FS_IOC32_SETFLAGS:
> >          |         ^~~~
> >    security/selinux/hooks.c:3652:9: note: previously used here
> >     3652 |         case FS_IOC_SETFLAGS:
> >          |         ^~~~
> >    security/selinux/hooks.c:3655:9: error: duplicate case value
> >     3655 |         case FS_IOC32_SETVERSION:
> >          |         ^~~~
> >    security/selinux/hooks.c:3653:9: note: previously used here
> >     3653 |         case FS_IOC_SETVERSION:
> >          |         ^~~~
>
> Not sure of the right way to fix this while addressing the original
> issue that this patch was intended to fix. Looking in fs/ioctl.c, I
> see that the some FS_IOC32 values are remapped to the corresponding
> FS_IOC values by the compat ioctl syscall entrypoint. Also notice this
> comment there:
>
>         /* RED-PEN how should LSM module know it's handling 32bit? */
>         error =3D security_file_ioctl(f.file, cmd, arg);
>         if (error)
>                 goto out;
>
> So perhaps this is a defect in LSM that needs to be addressed?

Note btw that some of the 32-bit ioctl commands are only handled in
the fs-specific compat_ioctl routines, e.g. ext4_compat_ioctl()
handles EXT4_IOC32_GETVERSION =3D=3D FS_IOC32_GETVERSION and ditto for
_SETVERSION.

>
>
> >
> >
> > vim +3647 security/selinux/hooks.c
> >
> >   3634
> >   3635  static int selinux_file_ioctl(struct file *file, unsigned int c=
md,
> >   3636                                unsigned long arg)
> >   3637  {
> >   3638          const struct cred *cred =3D current_cred();
> >   3639          int error =3D 0;
> >   3640
> >   3641          switch (cmd) {
> >   3642          case FIONREAD:
> >   3643          case FIBMAP:
> >   3644          case FIGETBSZ:
> >   3645          case FS_IOC_GETFLAGS:
> >   3646          case FS_IOC_GETVERSION:
> > > 3647          case FS_IOC32_GETFLAGS:
> >   3648          case FS_IOC32_GETVERSION:
> >   3649                  error =3D file_has_perm(cred, file, FILE__GETAT=
TR);
> >   3650                  break;
> >   3651
> >   3652          case FS_IOC_SETFLAGS:
> >   3653          case FS_IOC_SETVERSION:
> >   3654          case FS_IOC32_SETFLAGS:
> >   3655          case FS_IOC32_SETVERSION:
> >   3656                  error =3D file_has_perm(cred, file, FILE__SETAT=
TR);
> >   3657                  break;
> >   3658
> >   3659          /* sys_ioctl() checks */
> >   3660          case FIONBIO:
> >   3661          case FIOASYNC:
> >   3662                  error =3D file_has_perm(cred, file, 0);
> >   3663                  break;
> >   3664
> >   3665          case KDSKBENT:
> >   3666          case KDSKBSENT:
> >   3667                  error =3D cred_has_capability(cred, CAP_SYS_TTY=
_CONFIG,
> >   3668                                              CAP_OPT_NONE, true)=
;
> >   3669                  break;
> >   3670
> >   3671          case FIOCLEX:
> >   3672          case FIONCLEX:
> >   3673                  if (!selinux_policycap_ioctl_skip_cloexec())
> >   3674                          error =3D ioctl_has_perm(cred, file, FI=
LE__IOCTL, (u16) cmd);
> >   3675                  break;
> >   3676
> >   3677          /* default case assumes that the command will go
> >   3678           * to the file's ioctl() function.
> >   3679           */
> >   3680          default:
> >   3681                  error =3D ioctl_has_perm(cred, file, FILE__IOCT=
L, (u16) cmd);
> >   3682          }
> >   3683          return error;
> >   3684  }
> >   3685
