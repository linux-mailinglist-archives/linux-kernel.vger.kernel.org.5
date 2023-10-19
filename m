Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8418C7CFF01
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346384AbjJSQFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235445AbjJSQE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:04:59 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C44114
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:04:58 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a7af45084eso104461497b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697731497; x=1698336297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJCfgpMRGm8SsO7MCIzXVFxgcyw3Voi3ZeI75VxR5RI=;
        b=VIwrVYtlnOSHTbVDklPkd70WvNR2cEVQ828duGNQKvlKmhjbdlRYJjkckdjyCmmz03
         /6NcnrSwCY57uggjhyuMD+Rn2ucZJ1v6IZuOuyyDvS6EgTzC9SL0ZwFks09JcxjX8Az8
         6Empif8/A1jmKg+glbHm3IioIkq2mKwHF/e20G96DPVpY1lg7WQ3QsibuCKIDThUJHNB
         xX7d+nAgvd+3zsoxSnS2Welq/Y8oItZiw8YD3tJPwEzcBIyscjZ3rJIle873a+9Pe0TY
         Vo5JV6Uv0m9k49vWETiD/roNrpIFEcXioul+jVilsAeLUNoho/SHOPptVy2uERqy8Hga
         N2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697731497; x=1698336297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJCfgpMRGm8SsO7MCIzXVFxgcyw3Voi3ZeI75VxR5RI=;
        b=WzqoyIDCQaciwQJkXwqUIJWKmbwCpAgvEtJ3GVCeAlZGPNiW3GB3ZaKz16o7b033Xx
         RnFovSzTFc/26ptURDXEaa56JdjY3sTh09dLLSmWN2+UpdRvMPrUexuh4tQccO3FYehQ
         RbytaGf/HMitiuWDJyD1ATymzAKJt5PJh0MA+YIqybQIkxqsxiWMdIfCbBZmqiyanzsi
         UnaDPMRfAthk8uugPDlGb1EYawWVq6RxmpaxoUF93Gc9n2mwaiBIVedhhCnh7tjHMU50
         yqU5g4HawDJCL/hEOjBVtytAhGo0yHmNHtjwGdmCvXRiLn0EbQ1egeaDGZitxU05ci2A
         jL0Q==
X-Gm-Message-State: AOJu0Yza72kwBb8YYbsXWWc7RrcUiBDDoFG5gYoA2VbfYfrDmhtg1bf2
        126bJSe3l1x7NjlUmHxwqwDvwq1uQ7BSkXg6FrJPIQ==
X-Google-Smtp-Source: AGHT+IH1D29/O0i8UviSHMrOwOrO8R9BtMQS0JHXYMFTn+oVrBtqRHHkWddl7TTkxHuw7IQcBZ9cvkq+gOGTUsgWMF0=
X-Received: by 2002:a81:498b:0:b0:5a8:2d2b:ca9c with SMTP id
 w133-20020a81498b000000b005a82d2bca9cmr2962189ywa.32.1697731496606; Thu, 19
 Oct 2023 09:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <ZST/WggW4hSVs9d4@gmail.com> <202310101641075436843@zte.com.cn> <ZScQZLTssSfq19Jm@gmail.com>
In-Reply-To: <ZScQZLTssSfq19Jm@gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 19 Oct 2023 09:04:45 -0700
Message-ID: <CAJuCfpH8mBCx-YvL0bLzUSHf_N+k4ii9uWpRX5JxOHxvD=Rdbw@mail.gmail.com>
Subject: Re: [PATCH linux-next v3 2/4] sched/psi: Avoid update triggers and
 rtpoll_total when it is unnecessary
To:     Ingo Molnar <mingo@kernel.org>
Cc:     yang.yang29@zte.com.cn, peterz@infradead.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        mingo@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 2:15=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * yang.yang29@zte.com.cn <yang.yang29@zte.com.cn> wrote:
>
> > From: Yang Yang <yang.yang29@zte.com.cn>
> >
> > When psimon wakes up and there are no state changes for rtpoll_states,
> > it's unnecessary to update triggers and rtpoll_total because the pressu=
res
> > being monitored by user had not changed.
> > This will help to slightly reduce unnecessary computations of psi.
> >
> > Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> > Cc: Zhang Yunkai <zhang.yunkai@zte.com.cn>
> > Cc: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > ---
> >  kernel/sched/psi.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > index be853f227e40..143f8eb34f9d 100644
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -704,11 +704,12 @@ static void psi_rtpoll_work(struct psi_group *gro=
up)
> >       }
> >
> >       if (now >=3D group->rtpoll_next_update) {
> > -             update_triggers(group, now, &update_total, PSI_POLL);
> >               group->rtpoll_next_update =3D now + group->rtpoll_min_per=
iod;
> > -             if (update_total)
> > +             if (changed_states & group->rtpoll_states) {
> > +                     update_triggers(group, now, &update_total, PSI_PO=
LL);
> >                       memcpy(group->rtpoll_total, group->total[PSI_POLL=
],
> >                                  sizeof(group->rtpoll_total));
> > +             }
>
> Yeah, so I believe we may have been talking past each other for past
> versions of this patch: why is this patch modifying the order of the
> modification to group->rtpoll_next_update?
>
> It should do the below sequence, nothing more - see the patch attached
> below. This is basically a combination of patches #2 and #3.
>
> And then the final patch removes the now superfluous 'update_total'
> parameter, which is always true.
>
> Here are the commits I applied to tip:sched/core:
>
>   e03dc9fa0663 sched/psi: Change update_triggers() to a 'void' function
>   ...
>   80cc1d1d5ee3 sched/psi: Avoid updating PSI triggers and ->rtpoll_total =
when there are no state changes
>   3657680f38cd sched/psi: Delete the 'update_total' function parameter fr=
om update_triggers()
>
> I rewrote the changelogs for readability.
>
> Thanks,
>
>         Ingo
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>
> From: Yang Yang <yang.yang29@zte.com.cn>
> Date: Tue, 10 Oct 2023 16:41:07 +0800
> Subject: [PATCH] sched/psi: Avoid updating PSI triggers and ->rtpoll_tota=
l when there are no state changes
>
> When psimon wakes up and there are no state changes for ->rtpoll_states,
> it's unnecessary to update triggers and ->rtpoll_total because the pressu=
res
> being monitored by the user have not changed.
>
> This will help to slightly reduce unnecessary computations of PSI.
>
> [ mingo: Changelog updates ]
>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Peter Ziljstra <peterz@infradead.org>
> Link: https://lore.kernel.org/r/202310101641075436843@zte.com.cn

This version looks correct to me.

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  kernel/sched/psi.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index be853f227e40..79f8db0c6150 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -704,11 +704,12 @@ static void psi_rtpoll_work(struct psi_group *group=
)
>         }
>
>         if (now >=3D group->rtpoll_next_update) {
> -               update_triggers(group, now, &update_total, PSI_POLL);
> -               group->rtpoll_next_update =3D now + group->rtpoll_min_per=
iod;
> -               if (update_total)
> +               if (changed_states & group->rtpoll_states) {
> +                       update_triggers(group, now, &update_total, PSI_PO=
LL);
>                         memcpy(group->rtpoll_total, group->total[PSI_POLL=
],
>                                    sizeof(group->rtpoll_total));
> +               }
> +               group->rtpoll_next_update =3D now + group->rtpoll_min_per=
iod;
>         }
>
>         psi_schedule_rtpoll_work(group,
