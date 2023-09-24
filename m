Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8317ACB41
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 20:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjIXSLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 14:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjIXSLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 14:11:12 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC784FF
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 11:11:05 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-418157e979eso56761cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 11:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695579065; x=1696183865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cG//7W4GvFKB3RUZel/s/r0KoIAXjuYDKz7+aYl6dbw=;
        b=gxizrCvWUbszQ73Mnb2OBfYODjAjIsfgzglB6kYN3qD2u5Ps92tS5uuIqxAHdZEFLa
         mtbQBle3HrWd8uPDwTmhxIa1eb0VXPgPFJXVyHUb70rTJlzF6C49TS7bPGRYFrb3oSMy
         MuU9AgUz0jbIqt1yVKP06FrRUkeQbQ/sHFeIi857hF2unztlSunREfM8u4yMM3uzN8Nd
         SdFY4d7iiaItdpXkcj6Ki4P4jLHt4YMc2wSwmDGd2SYUn0VHGSG58oVddxOoD9XSEtm0
         xBZSa4yTHkRSv2hpYWzvmoNek8QCuNoxeue0zK3cmb0EPqLJ6m/Nz/B+siPKHHlOokw/
         45mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695579065; x=1696183865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cG//7W4GvFKB3RUZel/s/r0KoIAXjuYDKz7+aYl6dbw=;
        b=onFr7XJ7cPI04IuIlalJ6AVqZHq5zTFFiqKqnGFwfD6gohnrh8ol33SHCzp0PN4gI1
         Zxu7kwz1cisacWK00hiVckmxl8HYyMU+mPTYwYnYhOcriSraLtLnx/z0s66AxerV75zZ
         KB2h3eKX37uHWQ6+lkim3EJSp7l/TDirBTMMG51mwxsmW2ZtRKUibjgIMdrmdLy1/VNN
         OI8fbuml9iV9NvbvNUjPnMghvEq2X5++sXW+CJiorL04ejJ0YjE7v7YSiJ6TNDyzpRzu
         E96ULAcPLDVicfX3SHmJUSQ53Y9Eg/kjoKYOUPIKyK5qWvYFH+XkTUpPjo4JrYJgcA6a
         LgOQ==
X-Gm-Message-State: AOJu0YxImvh+pFFwZFDHlE/5VdBST61+cK/hIXxfrx908BdbDtqFFq11
        KiDLDnMXFPjoyI17UKRToWvTmNxOdSYcpzyNkdj+fw==
X-Google-Smtp-Source: AGHT+IE2x2zMKhx6VgB5uMiZT3B7zLGQ2fylz9BV1K3bxporY8GHHsHjBCelDLvCj8RqqMtNubif3frEMB55fZcySMs=
X-Received: by 2002:a05:622a:1050:b0:40d:eb06:d3cc with SMTP id
 f16-20020a05622a105000b0040deb06d3ccmr300808qte.7.1695579064870; Sun, 24 Sep
 2023 11:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230923093037.961232-1-yangjihong1@huawei.com> <20230923093037.961232-2-yangjihong1@huawei.com>
In-Reply-To: <20230923093037.961232-2-yangjihong1@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 24 Sep 2023 11:10:52 -0700
Message-ID: <CAP-5=fWpZk-sXjy5D28Os6YgDeMiu9UiVRzqZM9RHMs8YFj-3Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] perf bench messaging: Fix coding style issues for sched-messaging
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 2:32=E2=80=AFAM Yang Jihong <yangjihong1@huawei.com=
> wrote:
>
> Fixed several code style issues in sched-messaging:
> 1. Use one space around "-" and "+" operators.
> 2. When a long line is broken, the operator is at the end of the line.
>
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>

Series:
Reviewed-by: Ian Rogers <irogers@google.com>
I wonder with the SIGTERM improvements whether there should be
improvements to tools/lib/subcmd and then we use that.

Thanks,
Ian

> ---
>  tools/perf/bench/sched-messaging.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-=
messaging.c
> index fa1f8f998814..6a33118c8f9b 100644
> --- a/tools/perf/bench/sched-messaging.c
> +++ b/tools/perf/bench/sched-messaging.c
> @@ -98,7 +98,7 @@ static void *sender(struct sender_context *ctx)
>
>  again:
>                         ret =3D write(ctx->out_fds[j], data + done,
> -                                   sizeof(data)-done);
> +                                   sizeof(data) - done);
>                         if (ret < 0)
>                                 err(EXIT_FAILURE, "SENDER: write");
>                         done +=3D ret;
> @@ -201,8 +201,8 @@ static unsigned int group(pthread_t *pth,
>                 int wakefd)
>  {
>         unsigned int i;
> -       struct sender_context *snd_ctx =3D malloc(sizeof(struct sender_co=
ntext)
> -                       + num_fds * sizeof(int));
> +       struct sender_context *snd_ctx =3D malloc(sizeof(struct sender_co=
ntext) +
> +                                               num_fds * sizeof(int));
>
>         if (!snd_ctx)
>                 err(EXIT_FAILURE, "malloc()");
> @@ -239,7 +239,7 @@ static unsigned int group(pthread_t *pth,
>                 snd_ctx->wakefd =3D wakefd;
>                 snd_ctx->num_fds =3D num_fds;
>
> -               pth[num_fds+i] =3D create_worker(snd_ctx, (void *)sender)=
;
> +               pth[num_fds + i] =3D create_worker(snd_ctx, (void *)sende=
r);
>         }
>
>         /* Close the fds we have left */
> @@ -288,7 +288,7 @@ int bench_sched_messaging(int argc, const char **argv=
)
>
>         total_children =3D 0;
>         for (i =3D 0; i < num_groups; i++)
> -               total_children +=3D group(pth_tab+total_children, num_fds=
,
> +               total_children +=3D group(pth_tab + total_children, num_f=
ds,
>                                         readyfds[1], wakefds[0]);
>
>         /* Wait for everyone to be ready */
> --
> 2.34.1
>
