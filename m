Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1147A98C6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjIURxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjIURwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:52:42 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CBB301E7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:25:24 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c4084803f1so10545ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695317123; x=1695921923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEO84+iq6kC3VEaU1+DAhOho9ryfXauqS0h4qPx+tVo=;
        b=UmgM4a5eO87NvvqT4VbsUD0cVBF7B5KILCjrBj+T+pVfrTpG9Rg47p6TdtG/FmvTtP
         lmh/zpJ54NrDpw09b64iEmxoDm5ZwAkgb3eI4yKkHGbKZIA50+BUoksudnqUWQkrgEfy
         Enw2O0EfHEppZeg/y78ZI2SnIBpAJJAxpobZ2XdhAa75qu2F7mqU/JbOYsMz7YM0I14I
         cUQx+o+5dj7442hvkHKh39JqnGtvxt8sKLbAuoWMVJESGOhBxN1X436pK8LhOLPa68qR
         +V2f82kuKT/dDxgtQhKmdkFE356gUZkRv+ndek7XB2NvLPlzuW1NlVcTpSAf1Nryj9BC
         31DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317123; x=1695921923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nEO84+iq6kC3VEaU1+DAhOho9ryfXauqS0h4qPx+tVo=;
        b=ZizGc0xS3YaHzNrmWr5ApUnUCPMLQm2fxMoSl4igJzPyJ0Ptc+jjcbppG/ZZmHRq2v
         kWsW0hrybAu1QWS6hpJcEI9rBADMl7p2/3KZKgVDjNJvGx21zTm2fhYD1j1hX1ECm0gh
         TQXu22dqpcnWZZe8TcJlBGnflTrOu+nbh64ENoEi06WPNjp+RrbBOEPZDNKH/XNN+8yU
         e0sTTnrS1TzBrAQjOGBUvbtqdH/aUECSl1blumElxq/dUMfD+h+v3Cy6rpP+8wSSK/I4
         xnzzRwJaPEvKEOIXWq5T6MDSspioKKpdsH8fwusEFO9UDLRjcpil4i2SU8Es6JyAfuGb
         /Bcw==
X-Gm-Message-State: AOJu0Yyl8mkQVaVibVydQaisHO7mpibGeQvJQuebkw57fGdyLqiVWyVg
        8Z9MHqiersS4iiwoTPqWXDOWdu7QltSNBbItDpR3SyZtfEPfwkm5FwA=
X-Google-Smtp-Source: AGHT+IH34jeCfkePOj7hpV+ODrentVe9NkKGE3tVIgDkrp39gCm/9T4EqQqhcSsElnfpQxsWsPmXdWmVy7RyHw94dUk=
X-Received: by 2002:a17:902:e744:b0:1b8:89fd:61ea with SMTP id
 p4-20020a170902e74400b001b889fd61eamr201854plf.1.1695317123272; Thu, 21 Sep
 2023 10:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <ZQrSXh+riB7NnZuE@dhcp22.suse.cz> <4eb47d6a-b127-4aad-af30-896c3b9505b4@linux.microsoft.com>
 <ZQr3+YfcBM2Er6F7@dhcp22.suse.cz> <CALvZod7E_Jm9y+40OKtLs5EFA0ptKGjoe2BU58SY29pUiPc93g@mail.gmail.com>
 <ZQskGGAwlsr1YxAp@dhcp22.suse.cz> <CALvZod6b3=+=xXEUeWOQW3t_URJpeeVX46WjBHv5BS+436KoFA@mail.gmail.com>
 <ZQtRKzUOfdaVKRCF@dhcp22.suse.cz> <CALvZod5DSMoEGY0CwGz=P-2=Opbr4SmMfwHhZRROBx7yCaBdDA@mail.gmail.com>
 <ZQv2MXOynlEPW/bX@dhcp22.suse.cz> <f01b5d93-0f43-41c8-b3d8-40ef9696dcf8@linux.microsoft.com>
 <ZQwnUpX7FlzIOWXP@dhcp22.suse.cz>
In-Reply-To: <ZQwnUpX7FlzIOWXP@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 21 Sep 2023 10:25:11 -0700
Message-ID: <CALvZod7fs_K3807N1=-5bmXbA=vhAk+zcF+VHS=T5ycK1eeMfg@mail.gmail.com>
Subject: Re: [REGRESSION] Re: [PATCH 6.1 033/219] memcg: drop kmem.limit_in_bytes
To:     Michal Hocko <mhocko@suse.com>
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        mathieu.tortuyaux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 4:21=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Thu 21-09-23 12:43:05, Jeremi Piotrowski wrote:
> > On 9/21/2023 9:52 AM, Michal Hocko wrote:
> > > On Wed 20-09-23 14:46:52, Shakeel Butt wrote:
> > >> On Wed, Sep 20, 2023 at 1:08=E2=80=AFPM Michal Hocko <mhocko@suse.co=
m> wrote:
> > >>>
> > >> [...]
> > >>>> have a strong opinion against it. Also just to be clear we are not
> > >>>> talking about full revert of 58056f77502f but just the returning o=
f
> > >>>> EOPNOTSUPP, right?
> > >>>
> > >>> If we allow the limit to be set without returning a failure then we
> > >>> still have options 2 and 3 on how to deal with that. One of them is=
 to
> > >>> enforce the limit.
> > >>>
> > >>
> > >> Option 3 is a partial revert of 58056f77502f where we keep the no
> > >> limit enforcement and remove the EOPNOTSUPP return on write. Let's g=
o
> > >> with option 3. In addition, let's add pr_warn_once on the read of
> > >> kmem.limit_in_bytes as well.
> > >
> > > How about this?
> > > ---
> >
> > I'm OK with this approach. You're missing this in the patch below:
> >
> > // static struct cftype mem_cgroup_legacy_files[] =3D {
> >
> > +       {
> > +               .name =3D "kmem.limit_in_bytes",
> > +               .private =3D MEMFILE_PRIVATE(_KMEM, RES_LIMIT),
> > +               .write =3D mem_cgroup_write,
> > +               .read_u64 =3D mem_cgroup_read_u64,
> > +       },
>
> Of course. I've lost the hunk while massaging the revert. Thanks for
> spotting. Updated version below. Btw. I've decided to not pr_{warn,info}
> on the read side because realistically I do not think this will help all
> that much. I am worried we will get stuck with this for ever because
> there always be somebody stuck on unpatched userspace.
> ---
> From bb6702b698efd31f3f90f4f1dd36ffe223397bec Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Thu, 21 Sep 2023 09:38:29 +0200
> Subject: [PATCH] mm, memcg: reconsider kmem.limit_in_bytes deprecation
>
> This reverts commits 86327e8eb94c ("memcg: drop kmem.limit_in_bytes")
> and partially reverts 58056f77502f ("memcg, kmem: further deprecate
> kmem.limit_in_bytes") which have incrementally removed support for the
> kernel memory accounting hard limit. Unfortunately it has turned out
> that there is still userspace depending on the existence of
> memory.kmem.limit_in_bytes [1]. The underlying functionality is not
> really required but the non-existent file just confuses the userspace
> which fails in the result. The patch to fix this on the userspace side
> has been submitted but it is hard to predict how it will propagate
> through the maze of 3rd party consumers of the software.
>
> Now, reverting alone 86327e8eb94c is not an option because there is
> another set of userspace which cannot cope with ENOTSUPP returned when
> writing to the file. Therefore we have to go and revisit 58056f77502f
> as well. There are two ways to go ahead. Either we give up on the
> deprecation and fully revert 58056f77502f as well or we can keep
> kmem.limit_in_bytes but make the write a noop and warn about the fact.
> This should work for both known breaking workloads which depend on the
> existence but do not depend on the hard limit enforcement.
>
> [1] http://lkml.kernel.org/r/20230920081101.GA12096@linuxonhyperv3.guj3yc=
tzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net
> Fixes: 86327e8eb94c ("memcg: drop kmem.limit_in_bytes")
> Fixes: 58056f77502f ("memcg, kmem: further deprecate kmem.limit_in_bytes"=
)
> Signed-off-by: Michal Hocko <mhocko@suse.com>

With one request below:

Acked-by: Shakeel Butt <shakeelb@google.com>

> ---
>  Documentation/admin-guide/cgroup-v1/memory.rst |  7 +++++++
>  mm/memcontrol.c                                | 18 ++++++++++++++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentati=
on/admin-guide/cgroup-v1/memory.rst
> index 5f502bf68fbc..ff456871bf4b 100644
> --- a/Documentation/admin-guide/cgroup-v1/memory.rst
> +++ b/Documentation/admin-guide/cgroup-v1/memory.rst
> @@ -92,6 +92,13 @@ Brief summary of control files.
>   memory.oom_control                 set/show oom controls.
>   memory.numa_stat                   show the number of memory usage per =
numa
>                                      node
> + memory.kmem.limit_in_bytes          Deprecated knob to set and read the=
 kernel
> +                                     memory hard limit. Kernel hard limi=
t is not
> +                                     supported since 5.16. Writing any v=
alue to
> +                                     do file will not have any effect sa=
me as if
> +                                     nokmem kernel parameter was specifi=
ed.
> +                                     Kernel memory is still charged and =
reported
> +                                     by memory.kmem.usage_in_bytes.
>   memory.kmem.usage_in_bytes          show current kernel memory allocati=
on
>   memory.kmem.failcnt                 show the number of kernel memory us=
age
>                                      hits limits
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index a4d3282493b6..0b161705ef36 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3097,6 +3097,7 @@ static void obj_cgroup_uncharge_pages(struct obj_cg=
roup *objcg,
>  static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
>                                    unsigned int nr_pages)
>  {
> +       struct page_counter *counter;
>         struct mem_cgroup *memcg;
>         int ret;
>
> @@ -3107,6 +3108,10 @@ static int obj_cgroup_charge_pages(struct obj_cgro=
up *objcg, gfp_t gfp,
>                 goto out;
>
>         memcg_account_kmem(memcg, nr_pages);
> +
> +       /* There is no way to set up kmem hard limit so this operation ca=
nnot fail */
> +       if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> +               WARN_ON(!page_counter_try_charge(&memcg->kmem, nr_pages, =
&counter));

WARN_ON_ONCE() please.
