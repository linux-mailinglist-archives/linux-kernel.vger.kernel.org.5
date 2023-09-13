Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B3479DECF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 05:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238245AbjIMDxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 23:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjIMDxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 23:53:15 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266F81723
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 20:53:11 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-591ba8bd094so60638907b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 20:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694577190; x=1695181990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYJQAFk4TkvEcbrRQ1V1P9VjmHlaAWhJgURQMMrzUVs=;
        b=TgVdUgXlHE++B7QdiRngObxD4+vgLgdHkfH8kKzmXhJ9ZqMqGZUDG2aJ8F3FEAX16O
         TX6cP4RsTx9nbUSfMXFt5upGFW3OvEQTZdYj1V88Xe++hsLTE8lbh2m+cmkfdVvx/bqn
         aKPgGTHwA5igBOZi1KuoaCvZG4WOnQBoQSqhqtbQLJwYcmv835INoZJ0xt/2+CJrG7gr
         cWI8HWeFLIGK8/0iNBlg8BjTJG8eT2hr9beJIIGHzIhhCBGbqTdcxDpw4LBpbXeTm0V4
         QZBauudmg6ULa91fn0/RytR3d3626yoSTtxUeNpsF44N9l8q0GiUvfgYKH2Qe/i/zX3s
         ZLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694577190; x=1695181990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYJQAFk4TkvEcbrRQ1V1P9VjmHlaAWhJgURQMMrzUVs=;
        b=iKVO+y1qIaygPT1OgAL6WFbh9wxRIm8g97W7E2pjGzMUIM7PHiBPsrh1TpZXDvwCT6
         DddJutli5m2k716oif5DgfJjUP9pRck1nAhQC3yxuYmT7F6gZH/Hc+ffLbPTMOze1Vtq
         Xh7Ve6wDGAbCi07MALsrtvqk6Ourv04gj+uom0l0DU1JKQss1LMtHtpH3QWtFlrqMNKc
         tUJrYkwrT5Oi3I/v5v2y8T4jGLEbTgm2AGZj2jErPdvCHc53+fbeSiJ7S2vmjSI4BTbx
         ymEWMcCxpEZlPFoA0mhVk7/bKcTrv74wqiE4raro6bjNyBuRFAdkb3oaIQVAEA0q/iNA
         xIDw==
X-Gm-Message-State: AOJu0Yx38VdDcxSAfKj3hdOhMmOS80Rqx61UldETYYGgVr12dl9gEh1b
        0XqIxS60lk2mN2rH1lEmeEHvtFEgdV3I3LJCVlJt
X-Google-Smtp-Source: AGHT+IGWFtCPQVNwSqBN05Ij423EEN2/RjQvZH93bfk5icnuXTXVrRWFfuWbtfhha38djcat1yub4i+QKIKm61zQI50=
X-Received: by 2002:a0d:ebc3:0:b0:57a:9b2c:51f1 with SMTP id
 u186-20020a0debc3000000b0057a9b2c51f1mr1446354ywe.1.1694577190229; Tue, 12
 Sep 2023 20:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230906115928.3749928-1-alpic@google.com> <202309090600.NSyo7d2q-lkp@intel.com>
 <CAEjxPJ4GOq3E4zqXbEMKUxqewopyeU5nmUg89rL+P5YsuEBi7A@mail.gmail.com>
In-Reply-To: <CAEjxPJ4GOq3E4zqXbEMKUxqewopyeU5nmUg89rL+P5YsuEBi7A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Sep 2023 23:52:59 -0400
Message-ID: <CAHC9VhRFs0gaMpnnFb2dLy7SWQRbPT_8Wpf3a5WbHiasE8UPiQ@mail.gmail.com>
Subject: Re: [PATCH V2] SELinux: Check correct permissions for FS_IOC32_*
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Alfred Piccioni <alpic@google.com>,
        Eric Paris <eparis@parisplace.org>,
        oe-kbuild-all@lists.linux.dev, stable@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 9:19=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
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

What is both interesting and scary is that the "RED-PEN" comment seems
to go back at least as far as git, which is a lifetime these days.
This has been broken for a while.

> So perhaps this is a defect in LSM that needs to be addressed?

I think so.  I would suggest a new security_file_ioctl_compat() hook
as I often worry that flags are too easy to misuse whereas a separate
hook, especially one with "_compat" at the end, are a bit more clear.
The good news is that of the three LSMs that have file_ioctl hook
implementations it looks like only SELinux will need a dedicated
compat hook implementation (*maybe* TOMOYO, but I think it should be
okay reusing the existing tomoyo_file_ioctl() implementation).

--=20
paul-moore.com
