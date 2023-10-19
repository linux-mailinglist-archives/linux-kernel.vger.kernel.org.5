Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC057CFF17
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344662AbjJSQJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345675AbjJSQJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:09:15 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F6F112
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:09:13 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a7dafb659cso100098547b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697731753; x=1698336553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJKwIUYCCHU3sixg0SqHq3rSibq/LjHnIiSA4lvj0XI=;
        b=zeQOAqe9luxaIOV54WF9aF5B4qCGAaRh0BCOWY5MONXsTPyDeSDKH7Yj/1MxryTTbE
         ZUK3G0I8Em8YrWCQ6eqd4HM4N0RPnPGvfrwEyIo4PezbYIZdS0UFDCw/X26icQ+1Zqaz
         70XCpj/3OLT2D4jlqA4P6qGVkzF7XJCZuEC7JBPSsbXV4I8wzTiQ5YXNYao88qjcjkBK
         sViVRrd5oeJhQIQxpTIfD4jUgQ3FJ6jsuB6jr2QZa2IRe1NegIAK+ZdM9tJsdohlKxrl
         8DLCoqOMkYts7keqcQot0qXhuz/C+YcGM6hWkP0pEPsiSg2ypgxETKJZ1LTZxyrzf0E3
         aXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697731753; x=1698336553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJKwIUYCCHU3sixg0SqHq3rSibq/LjHnIiSA4lvj0XI=;
        b=qZhywZAv8zLisVxEjCnhgIyH8X0STCmbmLrwrwQvLunBIjFcpg9i55F8mOXPY/styT
         tA+ZpskL6eZxjy0gGhBchxvy8K+SN9SFAXRKOM9Gg0lvKNAiES/fK7HMgrM8/MZ40sqb
         Xy6/cltm4PyGN75fqLRsxU6MdLu6oPWFjGFveHNzOrvs4Y3opMNpsWPKYLEHxtmLFF+P
         yJBMphf3Ai51Ji+QkmInIOY810ZZ5Z/WswCJm2kQOaE0YML1+4b355RqDnWzA/4xK5s3
         vIDmdYfBCwjih+SmgqfMPFkN82iJVNdqRM5ramQjaYcPQgLZDBpKPNtsnoPx+h5/XMJL
         OblA==
X-Gm-Message-State: AOJu0YyzXDHxrXOGryOh3MMgV5MBZcn3y1NpYbIUmtGBv0jf6l23uxjW
        L0qQf4WoMbXJYP8JtsVBDJcUYGMJ4qGRDLLcC99BZQ==
X-Google-Smtp-Source: AGHT+IGJSgIGQxGQDrLWfqPLLdNZNiOU6oxsfpAmDnSOjYZkUliklf4zRbOhpDyEUlGHFhTYUBnJG0W3Idra0wRNHhc=
X-Received: by 2002:a81:8441:0:b0:5a7:baae:329f with SMTP id
 u62-20020a818441000000b005a7baae329fmr2806003ywf.15.1697731752467; Thu, 19
 Oct 2023 09:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <ZST/WggW4hSVs9d4@gmail.com> <202310101645437859599@zte.com.cn>
In-Reply-To: <202310101645437859599@zte.com.cn>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 19 Oct 2023 09:09:01 -0700
Message-ID: <CAJuCfpGbUvqUz1spJP_WgSGyGe_Kb1L500q44hzvobZwhaH3Cg@mail.gmail.com>
Subject: Re: [PATCH linux-next v3 4/4] sched/psi: Delete the function
 parameter update_total of update_triggers()
To:     yang.yang29@zte.com.cn
Cc:     mingo@kernel.org, peterz@infradead.org, hannes@cmpxchg.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com
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

On Tue, Oct 10, 2023 at 1:45=E2=80=AFAM <yang.yang29@zte.com.cn> wrote:
>
> From: Yang Yang <yang.yang29@zte.com.cn>
>
> The parameter update_total in update_triggers() is useless after patch
> "sched/psi: Avoid update triggers and rtpoll_total when it is unnecessary=
".
> If changed_states & group->rtpoll_states is true, new_stall in
> update_triggers() will be true, then update_total should also
> be true. We have no need for update_total to help judgment
> whether to update rtpoll_total, so delete it.
> This makes the code cleaner & simpler.
>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  kernel/sched/psi.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 79f8db0c6150..44a78774ae87 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -434,14 +434,13 @@ static u64 window_update(struct psi_window *win, u6=
4 now, u64 value)
>         return growth;
>  }
>
> -static void update_triggers(struct psi_group *group, u64 now, bool *upda=
te_total,
> +static void update_triggers(struct psi_group *group, u64 now,
>                                                    enum psi_aggregators a=
ggregator)
>  {
>         struct psi_trigger *t;
>         u64 *total =3D group->total[aggregator];
>         struct list_head *triggers;
>         u64 *aggregator_total;
> -       *update_total =3D false;
>
>         if (aggregator =3D=3D PSI_AVGS) {
>                 triggers =3D &group->avg_triggers;
> @@ -471,14 +470,6 @@ static void update_triggers(struct psi_group *group,=
 u64 now, bool *update_total
>                  * events without dropping any).
>                  */
>                 if (new_stall) {
> -                       /*
> -                        * Multiple triggers might be looking at the same=
 state,
> -                        * remember to update group->polling_total[] once=
 we've
> -                        * been through all of them. Also remember to ext=
end the
> -                        * polling time if we see new stall activity.
> -                        */
> -                       *update_total =3D true;
> -
>                         /* Calculate growth since last update */
>                         growth =3D window_update(&t->win, now, total[t->s=
tate]);
>                         if (!t->pending_event) {
> @@ -563,7 +554,6 @@ static void psi_avgs_work(struct work_struct *work)
>         struct delayed_work *dwork;
>         struct psi_group *group;
>         u32 changed_states;
> -       bool update_total;
>         u64 now;
>
>         dwork =3D to_delayed_work(work);
> @@ -582,7 +572,7 @@ static void psi_avgs_work(struct work_struct *work)
>          * go - see calc_avgs() and missed_periods.
>          */
>         if (now >=3D group->avg_next_update) {
> -               update_triggers(group, now, &update_total, PSI_AVGS);
> +               update_triggers(group, now, PSI_AVGS);
>                 group->avg_next_update =3D update_averages(group, now);
>         }
>
> @@ -638,7 +628,6 @@ static void psi_rtpoll_work(struct psi_group *group)
>  {
>         bool force_reschedule =3D false;
>         u32 changed_states;
> -       bool update_total;
>         u64 now;
>
>         mutex_lock(&group->rtpoll_trigger_lock);
> @@ -705,7 +694,7 @@ static void psi_rtpoll_work(struct psi_group *group)
>
>         if (now >=3D group->rtpoll_next_update) {
>                 if (changed_states & group->rtpoll_states) {
> -                       update_triggers(group, now, &update_total, PSI_PO=
LL);
> +                       update_triggers(group, now, PSI_POLL);
>                         memcpy(group->rtpoll_total, group->total[PSI_POLL=
],
>                                    sizeof(group->rtpoll_total));
>                 }
> --
> 2.25.1
