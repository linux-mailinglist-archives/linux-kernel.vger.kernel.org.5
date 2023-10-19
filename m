Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183887CFEF4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346451AbjJSQBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345951AbjJSQBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:01:31 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92222134
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:01:29 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a7dd65052aso109321957b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697731289; x=1698336089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhoqGC0O2nUa49PSPct+cIziavR2/+EWqOhTzQeZ5jE=;
        b=4ZMrtivlUzdwm2WxA0uzIRiUAv8wB2vJM5TtuYk1yxgrFI1wTtkbMvdhTUHeNU8Oy5
         0FX7A6yh1xA5K/7n0cS9M+87n1pgZphzWiRd2oa3h3SkHl8p+mny+nufUqj6qCdZI+f/
         ay+L7f728y2uogATt51dmMBdcQtua/0nS6wrYGWD/9weLPCkCFrFAog2PToMgbPh+OYZ
         n7y2J9PgVRrKAMjEn7yMBv0qL/1Nnp0jKKvsz0Z/keEwZdHbT+ya8gnFkbb/F8mi5xa2
         kdqHMvTn8Q4a7POsbVStFdq3qhq1M7DIkZTNVreJSrxe2tbtqeE8FbgzPC7BLWIHGPR3
         /c1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697731289; x=1698336089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YhoqGC0O2nUa49PSPct+cIziavR2/+EWqOhTzQeZ5jE=;
        b=of9Cth4AvyHGs92HrX0hFBhBGlshcqMY0D8CjFDEs89Id2SxhCHcROhUjsRiOKIceI
         Z6Acv4EXOJShhk70zQDuYmTxlAMej/lYSZttVDangmFeGKrNs1IaUnJk5+kgoFM4tapy
         YDOoYL/aze24qsUAxaIT/gM5TcaIrhwWvj6FMqk1jm+z+qo7FR7ZsHwTgl/EC8YNRI8z
         FhohXnxa9qmVHClITln9m/C0VwwtAr3wWmrK/oKHL2oEQDd+fC6sgO0e5mAVXP8yQtK5
         LTrti0IOb51BOcelEtzzu/OHmC4UvLE98O3YBLVRUO1IwdMAAQlUAJpUMK6jJfPWraPH
         R8qw==
X-Gm-Message-State: AOJu0YxK9faKQD+yaiPlTiCBmFZjd4acPE34u5gZhP49nImV4dw38ENr
        A/3B6Vv6xqDJ2Qz2NTGGiKB/163bVY466rwQi1vdPA==
X-Google-Smtp-Source: AGHT+IHRAFEPYPqeDd4o96z3g8/Ma8Eet0yV5wVg1cQRffat/a5tI2/jCqrnudQryNY+qxMHwmLNseOR8Z2aEu0iLzQ=
X-Received: by 2002:a81:8407:0:b0:5a7:d73d:42cd with SMTP id
 u7-20020a818407000000b005a7d73d42cdmr2715911ywf.20.1697731288360; Thu, 19 Oct
 2023 09:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <ZST/WggW4hSVs9d4@gmail.com> <202310101636345668937@zte.com.cn>
In-Reply-To: <202310101636345668937@zte.com.cn>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 19 Oct 2023 09:01:17 -0700
Message-ID: <CAJuCfpFwAexdhHubUjrDxs9er7npX6JtX6B78Vkj_pZ+B-1uAw@mail.gmail.com>
Subject: Re: [PATCH linux-next v3 1/4] sched/psi: Change update_triggers() to
 a 'void' function
To:     yang.yang29@zte.com.cn
Cc:     mingo@kernel.org, peterz@infradead.org, hannes@cmpxchg.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com
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

On Tue, Oct 10, 2023 at 1:36=E2=80=AFAM <yang.yang29@zte.com.cn> wrote:
>
> From: Yang Yang <yang.yang29@zte.com.cn>
>
> Update_triggers() always returns now + group->rtpoll_min_period, and the
> return value is only used by psi_rtpoll_work(), so change update_triggers=
()
> to a void function, let group->rtpoll_next_update =3D now +
> group->rtpoll_min_period directly.
>
> This will avoid unnecessary function return value passing & simplifies
> the function.
>
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>

Sorry for the delay, I was traveling and just got back. I think Ingo
already applied this patch but FWIW

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  kernel/sched/psi.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 1d0f634725a6..be853f227e40 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -434,7 +434,7 @@ static u64 window_update(struct psi_window *win, u64 =
now, u64 value)
>         return growth;
>  }
>
> -static u64 update_triggers(struct psi_group *group, u64 now, bool *updat=
e_total,
> +static void update_triggers(struct psi_group *group, u64 now, bool *upda=
te_total,
>                                                    enum psi_aggregators a=
ggregator)
>  {
>         struct psi_trigger *t;
> @@ -503,8 +503,6 @@ static u64 update_triggers(struct psi_group *group, u=
64 now, bool *update_total,
>                 /* Reset threshold breach flag once event got generated *=
/
>                 t->pending_event =3D false;
>         }
> -
> -       return now + group->rtpoll_min_period;
>  }
>
>  static u64 update_averages(struct psi_group *group, u64 now)
> @@ -706,7 +704,8 @@ static void psi_rtpoll_work(struct psi_group *group)
>         }
>
>         if (now >=3D group->rtpoll_next_update) {
> -               group->rtpoll_next_update =3D update_triggers(group, now,=
 &update_total, PSI_POLL);
> +               update_triggers(group, now, &update_total, PSI_POLL);
> +               group->rtpoll_next_update =3D now + group->rtpoll_min_per=
iod;
>                 if (update_total)
>                         memcpy(group->rtpoll_total, group->total[PSI_POLL=
],
>                                    sizeof(group->rtpoll_total));
> --
> 2.25.1
