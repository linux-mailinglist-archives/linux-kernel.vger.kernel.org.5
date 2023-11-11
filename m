Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844017E8AB7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 12:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjKKLcB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 11 Nov 2023 06:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjKKLcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 06:32:00 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB023A9C;
        Sat, 11 Nov 2023 03:31:56 -0800 (PST)
Received: from mail-ed1-f51.google.com ([209.85.208.51]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MGknn-1rEgVm229B-00DW3X;
 Sat, 11 Nov 2023 12:31:55 +0100
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-53dd3f169d8so4448733a12.3;
        Sat, 11 Nov 2023 03:31:55 -0800 (PST)
X-Gm-Message-State: AOJu0Yw6m8oYrMpNWBeKzYJ8cS6oXN7VBSHd19EyujYSzCDACxPS78Ni
        EEr8QHGNLfuWKjATOSAAIV4ixH7od8xpOnlbRKY=
X-Google-Smtp-Source: AGHT+IHcrSnLpeBT4VrVFBQaA8HRCxTfFPpj0DrNVV9+ctHoWJvKZ3yjXWg/W/mKZvIwszW9ejL5FFLOWeVP3vHFo9k=
X-Received: by 2002:a50:ef01:0:b0:543:5293:9a81 with SMTP id
 m1-20020a50ef01000000b0054352939a81mr1430331eds.8.1699702314065; Sat, 11 Nov
 2023 03:31:54 -0800 (PST)
MIME-Version: 1.0
References: <20231110235021.192796-1-linux@jordanrome.com> <CAEf4BzaWtOeTBb_+b7Td3NHaKjZU+OohuBJje_nvw9kd6xPA3g@mail.gmail.com>
 <CA+QiOd4X_=rZ5s=XgxBrmSkoepJLFmN4p+3q-0ST9j1sj_BhPw@mail.gmail.com> <CAEf4BzZT_H1rac3DsSeOdUe2oLEzXkY0EMEnyo-KXXhT=z2djQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZT_H1rac3DsSeOdUe2oLEzXkY0EMEnyo-KXXhT=z2djQ@mail.gmail.com>
From:   Jordan Rome <linux@jordanrome.com>
Date:   Sat, 11 Nov 2023 06:31:42 -0500
X-Gmail-Original-Message-ID: <CA+QiOd5FJOYK8i1JC9q9HY14XAm27pK5ZMw7jQnbkbGDag1QpQ@mail.gmail.com>
Message-ID: <CA+QiOd5FJOYK8i1JC9q9HY14XAm27pK5ZMw7jQnbkbGDag1QpQ@mail.gmail.com>
Subject: Re: [PATCH perf] perf: get_perf_callchain return NULL for crosstask
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:2OkTcxgfTR8jL1fk/DXfM/jiY8S1x/OYIZvuzGRJFtS7L7CdDAq
 Wizwkgdm8NsyrIU7u5m92f2EeeUcC1WP0gCMmWLnpQnNEtCKFQyM8IEgLtMWQYJ/jYs/v0C
 i/s1ahWuXz1UThgS7oPRlsa5f6H65YxzkcvHfKB2HBcKZivtULWNU2AdLsMqXmibiedOFyR
 +dXau4jC4ixzc4nI66icw==
UI-OutboundReport: notjunk:1;M01:P0:J8hFUjGBwX0=;Hnqu8ypxqmmNhjXUfL74GT6cWlY
 ufEnvQhqkZ9eTrzZF3iWSnAb2ki+0NX3X4yc1h7GmhF4/fRBxt/hgJvNMPBPQopXQ2/Hv93jO
 0rBXn84tUuIMjfOp8gQttvIUCO36BUyH4SziZpYC6FFLjZw/SBBPw2QRTdxkE6nc+SNVM9sz2
 kJYiUsIj4jFyZbPeFovfFjgI/s8QlP3Gs1eEjVT2WcQtyFGOKFnODYlH70u9Xw/Vzy4dXYGAp
 QLF/KAzkCzF+CweTeAwo0qynnieLXDdZPvILUM6PBin6YCvY8UgoLvu25ckCNASjHiZXn2wXA
 IvbEEpJNZJNVcwRvqRplsWOtToFAIrjHde14AcPWDZeBm0+EZ69U5dv+Wt7NdjA9uqFlpeqdz
 DBbhKWg23tr4WwU1f0QhbuwjzpN2rk7QreHzz0jdzmY6cF1Dm1Mkt0haxe1C31JYa6ne7CS8u
 hbyFNsFMIHA6nl8yTuZlbLTwDfkgYH8/gBom0lzZACFB+eyo2C57QFFnL0iOBQ6Vk9U4fjuyM
 L2r7a+FCeMPh/QSVQ9CiKc9mNhe6HGGyk4cIKZpA0VLyeu8Egm+ev0FrdTKZuGFZBUnABJqrc
 S48dufhxkfC5OJgamLH1NI7qo/q/uQBpFRzpGu4z2H7vCcBHUd8WV5fCP7ZDHgsSdXHmOsx9g
 1dclgcIwSgd/raqRbOOyKZyf8wYAWDaYCBmdRxt6zMdKzNszFHTzqfSWgBB8JpQu3x9SOguP5
 POd/kOD8nzVDv7FsLBxt0Tr2ccaNedCfxymfaRVpdJRzwqJWlOkJ8Qmfzp+BBuWwG4ZrP8gzN
 Qei3SrN4n2vfZ++BzwLfj14lEMRV/RIGD6EVS2sR9hgvt9wGdDircTT1KcS6UqoSp1djlVOAM
 tq+5QdhnLs0Gq7Q==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 11:32 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Nov 10, 2023 at 4:43 PM Jordan Rome <linux@jordanrome.com> wrote:
> >
> > On Fri, Nov 10, 2023 at 7:10 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Fri, Nov 10, 2023 at 3:51 PM Jordan Rome <linux@jordanrome.com> wrote:
> > > >
> > > > Return NULL instead of returning 1 incorrect frame, which
> > > > currently happens when trying to walk the user stack for
> > > > any task that isn't current. Returning NULL is a better
> > > > indicator that this behavior is not supported.
> > > >
> > > > This issue was found using bpf_get_task_stack inside a BPF
> > > > iterator ("iter/task"), which iterates over all tasks. The
> > > > single address/frame in the buffer when getting user stacks
> > > > for tasks that aren't current could not be symbolized (testing
> > > > multiple symbolizers).
> > > >
> > > > Signed-off-by: Jordan Rome <linux@jordanrome.com>
> > > > ---
> > > >  kernel/events/callchain.c | 7 +++----
> > > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> > > > index 1273be84392c..430fa544fa80 100644
> > > > --- a/kernel/events/callchain.c
> > > > +++ b/kernel/events/callchain.c
> > > > @@ -201,6 +201,9 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
> > > >         }
> > > >
> > > >         if (user) {
> > > > +               if (crosstask)
> > > > +                       return NULL;
> > >
> > > I think you need that goto exit_put here.
> > >
> >
> > Why is that? Wouldn't that be the same behavior that already exists?
> > That being said we can probably move this check above get_callchain_entry
> > and exit earlier.
>
> If I read the code right, get_callchain_entry() does expect
> put_callchain_entry(), which you are breaking with this return NULL.
>
> But indeed, checking it early and bailing out might be the best solution here.
>

Sounds good. I'll move this check before `get_callchain_entry`.

> >
> > > > +
> > > >                 if (!user_mode(regs)) {
> > > >                         if  (current->mm)
> > > >                                 regs = task_pt_regs(current);
> > > > @@ -209,9 +212,6 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
> > > >                 }
> > > >
> > > >                 if (regs) {
> > > > -                       if (crosstask)
> > > > -                               goto exit_put;
> > > > -
> > > >                         if (add_mark)
> > > >                                 perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
> > > >
> > > > @@ -219,7 +219,6 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
> > > >                 }
> > > >         }
> > > >
> > > > -exit_put:
> > > >         put_callchain_entry(rctx);
> > > >
> > > >         return entry;
> > > > --
> > > > 2.39.3
> > > >
