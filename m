Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44A7807F3B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 04:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjLGDpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 22:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjLGDpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 22:45:10 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1297DD6D;
        Wed,  6 Dec 2023 19:45:16 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so44102966b.1;
        Wed, 06 Dec 2023 19:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701920714; x=1702525514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmBbfDzaRahd6mhGvah9E1NQ3UgY0cxQBeaQo6+Ndck=;
        b=cCpJbw4IgO4SUkczktyf+s/a8efRIaQ+c1v72/peD5kTckip0mDuscmsyuHh40TCoi
         r8m0TqI+frFRmPo7yYf2MwMvKRCWa90EQ6H4DLDhNdXJp6XQ6lJGTwPofG2WQwVMVZfN
         mkDvuhi8TtUIO0TwaYLez3AwyLyQLK7nSiwa3jH7J9Ib9x5Swd1M7XTS1fYT8RBbBbNF
         6KUEdfdeHC0wRtrqdf0Rwx6re5fFwsJ4cdUkatTWkOzGKqqqXra6NKT73LD90ktvi0W8
         Yt0DOLuNCWiel4QgosmvhNw9qQChYXNDiqIW1RgC6kMQsrTWEvnXPfiuRGxOvhgksyvL
         L4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701920714; x=1702525514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmBbfDzaRahd6mhGvah9E1NQ3UgY0cxQBeaQo6+Ndck=;
        b=TuWMWYXg0WS66Z2wTcvCWuTSCGbRuVXL3wKP5TwWr58n74yTYBKCiBeiYic5DzsxYS
         DacWHkH/MbOX4quWgY2PjRvQTvS9dc7TjyQeytiygHZi9CMruk3mIhb5b0X5iwVkzTAv
         4OU5KYu/4QxaMJ+0KYFxiGSQdH63/UTJkHSaJGXE/s0rISvDdXW1rk3z6TIsZmY6A61M
         +ApknCEWN1BHBblzGI6ZS3NXbGh0sy+ZgBcjCrphWkIKHjhukRTMOfMdSrKnSLDoKKW7
         aw3tQ1W4oRCM/roTovXrsIw7uQ+GoxQTgXZSMj0Ipwj5+MS3SgX2rr5RAuEWdCgxS9XT
         v4jw==
X-Gm-Message-State: AOJu0YyrzPzWc3DpU68Yc5o8wHJq8vNr2j3Ye4Y6QWDkYwEQeFOCNu8k
        pe+6YrE/VzQxR3/E2gcZe5qEYle9IUa79fryGXc=
X-Google-Smtp-Source: AGHT+IGcQlWjHoRDKyoQuuU+XnIyRAneXAWLO6n2Xq/0U/+V9Ee1dbxGqTLKlPIbLLj8ZP1TY7eWEvTjB9UTPSklibU=
X-Received: by 2002:a17:906:b393:b0:a01:e916:3590 with SMTP id
 uh19-20020a170906b39300b00a01e9163590mr1094120ejc.75.1701920714188; Wed, 06
 Dec 2023 19:45:14 -0800 (PST)
MIME-Version: 1.0
References: <20231201161652.1241695-1-vincent.guittot@linaro.org> <20231201161652.1241695-2-vincent.guittot@linaro.org>
In-Reply-To: <20231201161652.1241695-2-vincent.guittot@linaro.org>
From:   Alex Shi <seakeel@gmail.com>
Date:   Thu, 7 Dec 2023 11:44:37 +0800
Message-ID: <CAJy-Amm76rwZ+tFMH-4esEQhrKsAooc0kWEJCVQa9zYAGNZ=Uw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sched/fair: Remove SCHED_FEAT(UTIL_EST_FASTUP, true)
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        corbet@lwn.net, alexs@kernel.org, siyanteng@loongson.cn,
        qyousef@layalina.io, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, lukasz.luba@arm.com,
        hongyan.xia2@arm.com, yizhou.tang@shopee.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nice cleanup.

Reviewed-by: Alex Shi <alexs@kernel.org>

On Sat, Dec 2, 2023 at 12:17=E2=80=AFAM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> sched_feat(UTIL_EST_FASTUP) has been added to easily disable the feature
> in order to check for possibly related regressions. After 3 years, it has
> never been used and no regression has been reported. Let remove it
> and make fast increase a permanent behavior.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-and-tested-by: Lukasz Luba <lukasz.luba@arm.com>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Reviewed-by: Hongyan Xia <hongyan.xia2@arm.com>
> Reviewed-by: Tang Yizhou <yizhou.tang@shopee.com>
> ---
>  Documentation/scheduler/schedutil.rst                    | 7 +++----
>  Documentation/translations/zh_CN/scheduler/schedutil.rst | 7 +++----
>  kernel/sched/fair.c                                      | 8 +++-----
>  kernel/sched/features.h                                  | 1 -
>  4 files changed, 9 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/scheduler/schedutil.rst b/Documentation/schedu=
ler/schedutil.rst
> index 32c7d69fc86c..803fba8fc714 100644
> --- a/Documentation/scheduler/schedutil.rst
> +++ b/Documentation/scheduler/schedutil.rst
> @@ -90,8 +90,8 @@ For more detail see:
>   - Documentation/scheduler/sched-capacity.rst:"1. CPU Capacity + 2. Task=
 utilization"
>
>
> -UTIL_EST / UTIL_EST_FASTUP
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +UTIL_EST
> +=3D=3D=3D=3D=3D=3D=3D=3D
>
>  Because periodic tasks have their averages decayed while they sleep, eve=
n
>  though when running their expected utilization will be the same, they su=
ffer a
> @@ -99,8 +99,7 @@ though when running their expected utilization will be =
the same, they suffer a
>
>  To alleviate this (a default enabled option) UTIL_EST drives an Infinite
>  Impulse Response (IIR) EWMA with the 'running' value on dequeue -- when =
it is
> -highest. A further default enabled option UTIL_EST_FASTUP modifies the I=
IR
> -filter to instantly increase and only decay on decrease.
> +highest. UTIL_EST filters to instantly increase and only decay on decrea=
se.
>
>  A further runqueue wide sum (of runnable tasks) is maintained of:
>
> diff --git a/Documentation/translations/zh_CN/scheduler/schedutil.rst b/D=
ocumentation/translations/zh_CN/scheduler/schedutil.rst
> index d1ea68007520..7c8d87f21c42 100644
> --- a/Documentation/translations/zh_CN/scheduler/schedutil.rst
> +++ b/Documentation/translations/zh_CN/scheduler/schedutil.rst
> @@ -89,16 +89,15 @@ r_cpu=E8=A2=AB=E5=AE=9A=E4=B9=89=E4=B8=BA=E5=BD=93=E5=
=89=8DCPU=E7=9A=84=E6=9C=80=E9=AB=98=E6=80=A7=E8=83=BD=E6=B0=B4=E5=B9=B3=E4=
=B8=8E=E7=B3=BB=E7=BB=9F=E4=B8=AD=E4=BB=BB=E4=BD=95=E5=85=B6=E5=AE=83CPU=E7=
=9A=84=E6=9C=80
>   - Documentation/translations/zh_CN/scheduler/sched-capacity.rst:"1. CPU=
 Capacity + 2. Task utilization"
>
>
> -UTIL_EST / UTIL_EST_FASTUP
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +UTIL_EST
> +=3D=3D=3D=3D=3D=3D=3D=3D
>
>  =E7=94=B1=E4=BA=8E=E5=91=A8=E6=9C=9F=E6=80=A7=E4=BB=BB=E5=8A=A1=E7=9A=84=
=E5=B9=B3=E5=9D=87=E6=95=B0=E5=9C=A8=E7=9D=A1=E7=9C=A0=E6=97=B6=E4=BC=9A=E8=
=A1=B0=E5=87=8F=EF=BC=8C=E8=80=8C=E5=9C=A8=E8=BF=90=E8=A1=8C=E6=97=B6=E5=85=
=B6=E9=A2=84=E6=9C=9F=E5=88=A9=E7=94=A8=E7=8E=87=E4=BC=9A=E5=92=8C=E7=9D=A1=
=E7=9C=A0=E5=89=8D=E7=9B=B8=E5=90=8C=EF=BC=8C
>  =E5=9B=A0=E6=AD=A4=E5=AE=83=E4=BB=AC=E5=9C=A8=E5=86=8D=E6=AC=A1=E8=BF=90=
=E8=A1=8C=E5=90=8E=E4=BC=9A=E9=9D=A2=E4=B8=B4=EF=BC=88DVFS=EF=BC=89=E7=9A=
=84=E4=B8=8A=E6=B6=A8=E3=80=82
>
>  =E4=B8=BA=E4=BA=86=E7=BC=93=E8=A7=A3=E8=BF=99=E4=B8=AA=E9=97=AE=E9=A2=98=
=EF=BC=8C=EF=BC=88=E4=B8=80=E4=B8=AA=E9=BB=98=E8=AE=A4=E4=BD=BF=E8=83=BD=E7=
=9A=84=E7=BC=96=E8=AF=91=E9=80=89=E9=A1=B9=EF=BC=89UTIL_EST=E9=A9=B1=E5=8A=
=A8=E4=B8=80=E4=B8=AA=E6=97=A0=E9=99=90=E8=84=89=E5=86=B2=E5=93=8D=E5=BA=94
>  =EF=BC=88Infinite Impulse Response=EF=BC=8CIIR=EF=BC=89=E7=9A=84EWMA=EF=
=BC=8C=E2=80=9C=E8=BF=90=E8=A1=8C=E2=80=9D=E5=80=BC=E5=9C=A8=E5=87=BA=E9=98=
=9F=E6=97=B6=E6=98=AF=E6=9C=80=E9=AB=98=E7=9A=84=E3=80=82
> -=E5=8F=A6=E4=B8=80=E4=B8=AA=E9=BB=98=E8=AE=A4=E4=BD=BF=E8=83=BD=E7=9A=84=
=E7=BC=96=E8=AF=91=E9=80=89=E9=A1=B9UTIL_EST_FASTUP=E4=BF=AE=E6=94=B9=E4=BA=
=86IIR=E6=BB=A4=E6=B3=A2=E5=99=A8=EF=BC=8C=E4=BD=BF=E5=85=B6=E5=85=81=E8=AE=
=B8=E7=AB=8B=E5=8D=B3=E5=A2=9E=E5=8A=A0=EF=BC=8C
> -=E4=BB=85=E5=9C=A8=E5=88=A9=E7=94=A8=E7=8E=87=E4=B8=8B=E9=99=8D=E6=97=B6=
=E8=A1=B0=E5=87=8F=E3=80=82
> +UTIL_EST=E6=BB=A4=E6=B3=A2=E4=BD=BF=E5=85=B6=E5=9C=A8=E9=81=87=E5=88=B0=
=E6=9B=B4=E9=AB=98=E5=80=BC=E6=97=B6=E7=AB=8B=E5=88=BB=E5=A2=9E=E5=8A=A0=EF=
=BC=8C=E8=80=8C=E9=81=87=E5=88=B0=E4=BD=8E=E5=80=BC=E6=97=B6=E4=BC=9A=E7=BC=
=93=E6=85=A2=E8=A1=B0=E5=87=8F=E3=80=82
>
>  =E8=BF=9B=E4=B8=80=E6=AD=A5=EF=BC=8C=E8=BF=90=E8=A1=8C=E9=98=9F=E5=88=97=
=E7=9A=84=EF=BC=88=E5=8F=AF=E8=BF=90=E8=A1=8C=E4=BB=BB=E5=8A=A1=E7=9A=84=EF=
=BC=89=E5=88=A9=E7=94=A8=E7=8E=87=E4=B9=8B=E5=92=8C=E7=94=B1=E4=B8=8B=E5=BC=
=8F=E8=AE=A1=E7=AE=97=EF=BC=9A
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index bcea3d55d95d..e94d65da8d66 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4870,11 +4870,9 @@ static inline void util_est_update(struct cfs_rq *=
cfs_rq,
>          * to smooth utilization decreases.
>          */
>         ue.enqueued =3D task_util(p);
> -       if (sched_feat(UTIL_EST_FASTUP)) {
> -               if (ue.ewma < ue.enqueued) {
> -                       ue.ewma =3D ue.enqueued;
> -                       goto done;
> -               }
> +       if (ue.ewma < ue.enqueued) {
> +               ue.ewma =3D ue.enqueued;
> +               goto done;
>         }
>
>         /*
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index a3ddf84de430..143f55df890b 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -83,7 +83,6 @@ SCHED_FEAT(WA_BIAS, true)
>   * UtilEstimation. Use estimated CPU utilization.
>   */
>  SCHED_FEAT(UTIL_EST, true)
> -SCHED_FEAT(UTIL_EST_FASTUP, true)
>
>  SCHED_FEAT(LATENCY_WARN, false)
>
> --
> 2.34.1
>
